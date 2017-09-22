---
layout: post
title: "Why coroutines won’t work on the web"
date: 2011-12-14T10:30:00
categories:
  - JavaScript
  - coroutines
  - continuations
  - generators
---

<img class="right" src="/assets/yunocoros.jpg" style="width: 200px; height: 150px;" /> The topic of coroutines (or
fibers, or continuations) for JavaScript comes up from time to time,
so I figured I'd write down my thoughts on the matter. I admit to
having a soft spot for crazy control-flow features like continuations,
but they're unlikely ever to make it into ECMAScript. With good
reason.

<!--more-->

The big justification for coroutines in JavaScript is non-blocking
I/O. As we all know, asynchronous I/O leads to callback API's, which
lead to nested lambdas, which lead to... the pyramid of doom:

```javascript
range.on("preheat", function() {
    pot.on("boil", function() {
        rice.on("cooked", function() {
            dinner.serve(rice);
        });
    });
});
```

Whereas, if you look at the README for
[node-fibers](https://github.com/laverdet/node-fibers), you'll see
this pleasant-looking example:

```javascript
Fiber.run(function() {
    console.log('wait...' + new Date);
    sleep(1000);
    console.log('ok...' + new Date);
});
```

That looks pretty sweet. It's a synchronous version of `setTimeout`
that doesn't block the main thread. This seems like a nice combination
of the sequential style of synchronous code but with the
responsiveness of non-blocking I/O. Why wouldn't we want something
like this in ECMAScript?

## Coroutines are almost as pre-emptive as threads

Part of the beauty of JavaScript's event loop is that there's a very
clear synchronization point for reaching a stable state in your
programs: the end of the current turn. You can go ahead and leave
things in a funky intermediate state for as long as you like, and as
long as you stitch everything back up in time for the next spin of the
event loop, no other code can run in the meantime. That means you can
be sure that while your object is lying in pieces on the floor, nobody
else can poke at it before you put it back together again.

Once you add coroutines, you never know when someone might call
`yield`.  Any function you call has the right to pause and resume you
whenever they want, _even after any number of spins of the event
loop_. Now any time you find yourself modifying state, you start
worrying that calling a function might interrupt some code you
intended to be transactional. Take something as simple as swapping a
couple fields of an object:

```javascript
var tmp = obj.foo;
obj.foo = obj.bar;
obj.bar = munge(tmp);
```

What happens if `munge` does a `yield` and only resumes your code
after a few other events fire? Those events could interact with `obj`,
and they'd see it in this intermediate state where both `obj.foo` and
`obj.bar` are the same value, because `obj.bar` hasn't yet been
updated.

We've seen this movie before. This is just like Java's threads, where
any time you're working with state, you have to worry about who might
try to touch your data before it reaches a stable point. To be fair,
life is actually far worse in Java, where almost every single basic
operation of the language can be pre-empted. But still, with
coroutines, every function call becomes a potential pre-emption point.

## Host frames make coroutines unportable

And then there's the implementation problem. Unless your JavaScript
engine doesn't use a stack (and they all do), coroutines would have to
be able to save a stack on the heap and restore it back on the stack
later. But what if JavaScript code calls into code implemented in the
host language (usually C++)? Some engines implement functions like
`Array.prototype.forEach` in C++. How would they handle code like
this?

```javascript
Fiber.run(function() {
    array.forEach(function(x) {
        console.log('wait: ' + x);
        sleep(1000);
        console.log('ok: ' + x);
    });
});
```

Other languages with coroutines take different approaches.  Lua allows
implementations to [throw an error](http://www.lua.org/manual/5.1/manual.html#pdf-coroutine.yield)
if user code tries to suspend host activations. This would simply be
unportable, since different engines would implement different standard
libraries in C++.

The Scheme community tends to demand a lot from their continuations,
so they expect functions like `for-each` and `map` to be
suspended. This could mean either forcing all the standard libraries
to be self-hosted, or using more complicated [implementation strategies](http://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.70.9076)
than traditional stacks.

Simply put: browser vendors are not going to do this. Modern JS
engines are extraordinary feats of engineering, and rearchitecting
their entire stack mechanism is just not realistic. Then when you
consider that these changes could hurt performance of ordinary
function calls, well... end of discussion.

## Shallow coroutines to the rescue

OK, back to the pyramid of doom. It really does kind of suck. I mean,
you could name and lift out your functions, but then you break up the
sequential flow even worse, and you get a combinatorial explosion of
function arguments for all those upvars.

This is why I'm excited about
[generators](http://wiki.ecmascript.org/doku.php?id=harmony:generators). Generators
are a lot like coroutines, with one important difference: _they only
suspend their own function activation_. In ES6, `yield` isn't a
function that anyone can use, it's a built-in operator that only a
generator function can use. With generators, calling a JS function is
as benign as it ever was. You never have to worry that a function call
might `yield` and stop you from doing what you were trying to do.

But it's still possible to build an API similar to node-fibers. This
is the idea of [task.js](https://github.com/dherman/taskjs). The
fibers example looks pretty similar in task.js:

```javascript
Task(function() {
    console.log('wait... ' + new Date);
    yield sleep(1000);
    console.log('ok... ' + new Date);
}).run();
```

The big difference is that the `sleep` function doesn't _implicitly_
yield; instead, it returns a
[promise](http://blogs.msdn.com/b/ie/archive/2011/09/11/asynchronous-programming-in-javascript-with-promises.aspx). The
task then _explicitly_ `yield`s the promise back to the task.js
scheduler. When the promise is fulfilled, the scheduler wakes the task
back up to continue. Hardly any wordier than node-fibers, but with the
benefit that you can always tell when and what you're suspending.

## Coroutines no, generators yes

Coroutines are not going to happen in JavaScript. They would break one
of the best features of JavaScript: the simplicity of the event loop
execution model. And the demands they would place on current engines
for portability are simply unrealistic. But generator functions are
easy to add to existing engines, they have none of the portability
issues of coroutines, and they give you just enough power to write
non-blocking I/O in a synchronous style without being "threads lite."

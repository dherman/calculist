---
layout: post
title: "Static module resolution"
date: 2012-06-29T13:41:00
caregories:
  - ES6
  - modules
---

I haven't spoken enough about the rationale for declarative, static module resolution in [ES6 modules](http://wiki.ecmascript.org/doku.php?id=harmony:modules). Since multiple module systems exist in pure JS, the concept of modules that involve new syntax is coming across as foreign to people. I'd like to explain the motivation.

<!--more-->

First, a quick explanation of what this is about. In a pure-JS system like CommonJS, modules are just objects, and whatever definitions they export can be imported by a client with object property lookup:

```javascript
var { stat, exists, readFile } = require('fs');
```

By contrast, in the ES6 module system, modules are not objects, they're declarative collections of code. Importing definitions from a module is also declarative:

```javascript
import { stat, exists, readFile } from 'fs';
```

This import is resolved at compile time — that is, before the script starts executing. All the imports and exports of the declarative module dependency graph are resolved before execution. (There's also an asynchronous dynamic loading API; it's of course important to be able to defer module loading to runtime. But this post is about the resolution of a declarative module dependency graph.)

## On the origin of specs

<img class="right" src="/img/evolution.jpg" /> Node leaders are arguing that we should take more incremental, evolutionary steps, that we should hew more closely to the module systems that exist today. I have a lot of sympathy for the "pave the cowpaths" philosophy, and I often argue for it. But the module systems people have built for JavaScript to date did not have the option of modifying the language. We have an opportunity to move JS in directions where a purely dynamic system could never go.

What are some of those directions?

## Fast lookup

Static imports (whether via `import` or references like `m.foo`) can always be compiled like variable references. In a dynamic module system, an explicit dereference like `m.foo` will be an object reference, which will generally require [PIC guards](http://blog.cdleary.com/2010/09/picing-on-javascript-for-fun-and-profit/). If you copy them into locals, they'll be more optimizable in some cases, but with static modules you always predictably get early binding. Keeping module references as cheap as variable references makes modular programs faster and avoids imposing a tax on modular code.

## Early variable checking

Having variable references, including imports and exports, checked before a script starts running is, in my experience, very useful for making sure the basic top-level structure of a program is sane. JavaScript is almost statically scoped, and this is our one and only chance to get there. James Burke dismisses this as a kind of [shallow type checking](http://tagneto.blogspot.ca/2012/06/es-modules-suggestions-for-improvement.html), which he claims is not enough to be useful. My experience in other languages says otherwise — it is super useful! Variable checking is a nice sweet spot where you can still write expressive dynamic programs, but catch really basic and common errors. As Anton Kovalyov points out, unbound variable reporting is a [popular feature in JSHint](https://mail.mozilla.org/pipermail/es-discuss/2012-June/023777.html), and it's so much nicer not to have to run a separate linter to catch these bugs.

## Cyclic dependencies

Allowing cyclic dependencies between modules is really important. Mutual recursion is a fact of programming. It occurs sometimes without you even noticing it. If you try splitting up your program into modules and the system breaks because it can't handle cycles, the easiest workaround is just to keep everything together in one big module. Module systems should not prevent programmers from splitting up their program however they see fit. They should not provide disincentives from writing modular programs.

This isn't impossible with dynamic systems, but it tends to be something I see treated as an afterthought by alternative proposals. It's something we've thought very carefully about for ES6. Also, declarative modules allow you to pre-initialize more of the module structure before executing any code, so that you can give better errors if someone refers to a not-yet-assigned export. For example, a `let` binding throws if you refer to it before it's been assigned, and you get a clear error message. This is much easier to diagnose than referring to a property of a dynamic module object that just isn't even there yet, getting `undefined`, and having to trace the eventual error back to the source.

## Future-compatibility for macros

One of the things I would love to see in JavaScript's future is the ability for programmers to come up with their own custom syntax extensions without having to wait for TC39 to add it. Today, people invent new syntax by writing their own compilers. But this is extremely hard to do, and you can't use different syntax features from different compilers in a single source file.

With macros, you might implement, say, a new `cond` syntax that makes a nicer alternative to chaining `? :` conditionals, and share that via a library:

```javascript
import cond from 'cond.js';
...
var type = cond {
    case (x === null): "null",
    case Array.isArray(x): "array",
    case (typeof x === "object"): "object",
    default: typeof x
};
```

The `cond` macro would preprocess this into a chain of conditionals before the program runs. Preprocessing doesn't work with purely dynamic modules:

```javascript
var cond = require('cond.js');
...
// impossible to preprocess because we haven't evaluated the require!
var type = cond { /* etc */ };
```

## Future-compatibility for types

I joined TC39 in the ill-fated ES4 days, when the committee was working on an optional type system for JS. It was built on sketchy foundations and ultimately fell apart. One of the things that was really lacking was a module system where you could draw a boundary around a section of code and say "this part needs to be type-checked." Otherwise you never knew if more code was going to be appended later.

Why types? Here's one reason: JS is fast and getting faster, but it only gets [harder to predict performance](http://blog.mrale.ph/post/12396216081/the-trap-of-the-performance-sweet-spot). With experiments like [LLJS](http://lljs.org), my group at Mozilla is playing with dialects of JS that use types to pre-compile offline and generate some pretty funky JS code optimized for current JIT's. But if you could just directly write your high-performance kernels in a typed dialect of JS, modern compilers could go to town with it.

With declarative resolution, you can import and export typed definitions and they can all be checked at compile-time. Dynamic imports can't be statically checked.

## Inter-language modularity

Some people may not care about or want features like macros or types. But JavaScript has to serve many different programmers who come with many different development practices and needs. And one of the ways it can do so is by allowing people to use their own languages that compile to JavaScript. So even if macros or types aren't in the future of the ECMAScript standard, it'd be pretty great if you could use statically typed or macro-enabled dialects of JS offline that compile to browser-compatible JS. People are already doing this kind of thing today with the [Closure compiler](https://developers.google.com/closure/compiler/)'s type checking, or the [Roy](http://roy.brianmckenna.org/) language, or [ClojureScript](https://github.com/clojure/clojurescript). A static module system is more universally and straightforwardly compatible with a wider range of languages.

## Costs and benefits

The above are some of the benefits that I see to declarative module resolution. Isaac Schlueter says the `import` syntax [adds nothing](http://blog.izs.me/post/25906678790/on-es-6-modules). That's unfair and wrong. It's there for a purpose. I don't believe that a declarative import syntax is a high cost for the benefit both to ES6 and to potential future editions.

## PS: What's all this about Python?

One last thing: people keep claiming that the ES6 module system came from Python. I don't even have very much experience with Python. And Python's modules are more mutable and their scope is more dynamic. Personally, I've drawn inspiration from [Racket](http://racket-lang.org), which has gotten lots of mileage out of its [declarative module system](http://docs.racket-lang.org/guide/Module_Syntax.html). They've leveraged static modules to build a macro system, early variable checking, optimized references, dynamic contracts with module-based blame reporting, multi-language interoperability, and a statically typed dialect.

I'm not interested in making JavaScript into some other language. But you can learn a lot from studying precedent in other languages. I've seen firsthand the benefits you can get from a declarative module system in a dynamic language.

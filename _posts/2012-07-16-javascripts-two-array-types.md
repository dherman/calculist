---
layout: post
title: "JavaScript’s two array types"
date: 2012-07-16T15:06:00
categories:
  - JavaScript
  - arrays
  - nominal types
  - structural types
  - duck types
  - duck testing
---

Imagine a `BitSet` constructor with an overloaded API for setting bits:

```javascript
var bits = new BitSet();

bits.set(4);
bits.set([1, 4, 8, 17]);
```

<!--more-->

The interface for `BitSet.prototype.set` is:

```javascript
// set :: (number | [number]) -> undefined
```

Now imagine a `StringSet` constructor with an overloaded API for adding strings:

```javascript
var set = new StringSet();

set.add('foo');
set.add(['foo', 'bar', 'baz']);
set.add({ foo: true, bar: true, baz: true });
```

The interface for `StringSet.prototype.add` is something like:

```javascript
// add :: (string | [string] | object) -> undefined
```

These both look pretty similar, but there's a critical difference. Think about how you might implement `BitSet.prototype.set`:

```javascript
BitSet.prototype.set = function set(x) {
    // number case
    if (typeof x === 'number') {
        this._add1(x);
        return;
    }
    // array case
    for (var i = 0, n = x.length; i < n; i++) {
        this._add1(x[i]);
    }
};
```

Now think about how you might implement `StringSet.prototype.add`:

```javascript
StringSet.prototype.add = function add(x) {
    // string case
    if (typeof x === 'string') {
        this._add1(x);
        return;
    }
    // array case
    if (/* hmmmm... */) {
        for (var i = 0, n = x.length; i < n; i++) {
            this._add1(x[i]);
        }
        return;
    }
    // object case
    for (var key in x) {
        if ({}.hasOwnProperty.call(x, key)) {
            this._add1(key);
        }
    }
};
```

What's the difference? `BitSet.prototype.set` doesn't have to test whether its argument is an array. It'll work for any object that acts like an array (i.e., has indexed properties and a numeric `length` property). It'll even accept values like an `arguments` object, a `NodeList`, some custom object you create that acts like an array, or even a primitive string.

But `StringSet.prototype.add` actually needs a test to see if `x` is an array. How do you distinguish between arrays and objects when JavaScript arrays *are* objects?

One answer you'll sometimes see is what I call "duck testing": use some sort of heuristic that *probably* indicates the client intended the argument to be an array:

```javascript
if (typeof x.length === 'number') {
    // ...
}
```

Beware the word "probably" in programming! Duck testing is a horribly medieval form of computer science:

<iframe class="video" width="640" height="390" src="http://www.youtube.com/embed/zrzMhU_4m-g" frameborder="0" allowfullscreen></iframe>

For example, what happens when a user happens to pass in a dictionary object with the string `'length'`?

```javascript
symbolTable.add({ a: 1, i: 1, length: 1 });
```

The user clearly intended this to be the dictionary case, but the duck test saw a numeric `'length'` property and gleefully proclaimed "it's an array!"

This comes down to the difference between *nominal* and *structural* types.

A **nominal type** is a type that has a unique identity or "brand." It carries a tag with it that can be atomically tested to distinguish it from other types.

A **structural type**, also known as a duck type, is a kind of interface: it's just a contract that mandates certain behaviors, but doesn't say anything about what specific implementation is used to provide that behavior. The reason people have such a hard time figuring out how to test for structural types is that they are designed specifically *not to be testable*!

There are a few common scenarios in dynamically typed languages where you need to do dynamic type testing, such as error checking, debugging, and inrospection. But the most common case is when implementing overloaded API's like the `set` and `add` methods above.

The `BitSet.prototype.set` method treats arrays as a structural type: they can be any kind of value whatsoever as long as they have indexed properties with corresponding `length`. But `StringSet.prototype.add` overloads array and object types, so it has to check for "arrayness." And you can't reliably check for structural types.

It's specifically when you **overload arrays and objects** that you need a predictable nominal type test. One answer would be to punt and change the API so the client has to explicitly tag the variants:

```javascript
set.add({ key: 'foo' });
set.add({ array: ['foo', 'bar', 'baz'] });
set.add({ dict: { foo: true, bar: true, baz: true } });
```

This overloads three different objects types that can be distinguished by their relevant property names. Or you could get rid of overloading altogether:

```javascript
set.add('foo');
set.addArray(['foo', 'bar', 'baz']);
set.addDict({ foo: true, bar: true, baz: true });
```

But these API's are heavier and clunkier. Rather than rigidly avoiding overloading arrays and objects, the lighter-weight approach is to use JavaScript's latent notion of a "true" array: an object whose <a href="http://es5.github.com/#x8.6.2">\[\[Class\]\] internal property</a> is `"Array"`. That internal property serves as the brand for a built-in nominal type of JavaScript. And it's a pretty good candidate for a universally available nominal type: clients get the concise array literal syntax, and the ES5 [Array.isArray](https://developer.mozilla.org/en/JavaScript/Reference/Global_Objects/Array/isArray) function (which can be [shimmed pretty reliably](http://perfectionkills.com/instanceof-considered-harmful-or-how-to-write-a-robust-isarray/) in older JavaScript engines) provides the exact test needed to implement the API.

But this test is very different from the structural type accepted by `BitSet.prototype.set`. For example, you can't pass an `arguments` object to `StringSet.prototype.add`:

```javascript
MyClass.prototype.update = function update() {
    this.wibbles.add(arguments);
};
```

This code clearly means to pass `arguments` as an array, but it'll get interpreted as a dictionary. Similarly, you can't pass a `NodeList`, or a primitive string, or any other JavaScript value that acts array-like.

In other words, <strong>JavaScript has <em>two</em> latent concepts of array types</strong>. Library writers should clearly document when their API's accept any *array-like* value (i.e., the structural type) and when they require a true array (i.e., the nominal type). That way clients know whether they need to convert array-like values to true arrays before passing them in.

As a final note, ES6's [Array.from](http://wiki.ecmascript.org/doku.php?id=strawman:array_extras) API will do that exact conversion. This would make it very convenient, for example, for the `update` method above to be fixed:

```javascript
MyClass.prototype.update = function update() {
    this.wibbles.add(Array.from(arguments));
};
```

*Thanks to Rick Waldron for helping me come to this understanding during an awesome IRC conversation this morning.*

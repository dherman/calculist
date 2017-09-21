---
layout: post
title: "The little-endian web?"
date: 2012-04-24T22:32:00
categories:
  - typed arrays
  - binary data
  - endianness
excerpt_separator: <!--more-->
---

Here's the deal: [typed arrays](http://www.khronos.org/registry/typedarray/specs/latest/) are not fully portable. On most browsers, this code will print 1:

```javascript
var a1 = new Uint32Array([1]);
var a2 = new Uint8Array(a1.buffer);
console.log(a2[0])
```

<!--more-->

But the typed arrays spec doesn't specify a byte order. So a browser on a big-endian system (say, a PowerPC console like Xbox or PS3) is allowed to print 0. In short: <strong>casting an `ArrayBuffer` to different types is unportable by default.</strong> It's up to web developers to canonicalize bytes for different architectures.

<img class="right" src="/assets/nuxi.jpg" /> Now, we could just require typed arrays to be little-endian, once and for all. After all, almost all platforms are little-endian these days. The few big-endian platforms could just automatically reorder bytes for all typed array accesses. But this would have to be made to work with WebGL, which works by sending application-generated buffers to the GPU. In order to make this work on a big-endian architecture, little-endian-encoded `ArrayBuffer` data would need to be translated when sending back and forth to the GPU. Technically, [this might be possible](http://lists.whatwg.org/htdig.cgi/whatwg-whatwg.org/2012-March/035236.html), but there's really no evidence that it would have acceptable performance.

On the other hand, can we really trust that web applications will write portable code? Imagine a [hashing algorithm](http://blog.faultylabs.com/files/md5.js) that builds an internal `ArrayBuffer` and casts it to different types. If the code isn't written portably, it'll break on a browser implementing big-endian typed arrays.

This leaves big-endian browsers with a **nasty decision**: try to emulate little-endian typed arrays to protect against unportable application logic, and suffer the complexity and performance costs of translating data back and forth to the GPU, or just hope that not too many web pages break. Or perhaps surface an annoying decision to users: do you want to run this application in fast mode or correct mode?

For now, we should let browser vendors on big-endian systems make that decision, and not force the decision through the spec. If they end up all choosing to emulate little-endian, I'll be happy to codify that in the standards. As I understand it, [TenFourFox](http://www.floodgap.com/software/tenfourfox/) can't support WebGL, so there the best decision is probably to emulate little-endianness. On an Xbox, I would guess WebGL performance would be a higher priority than web sites using internal `ArrayBuffer`s. But I'm not sure. I'd say this is a decision for big-endian browsers to make, but **I would greatly welcome their input**.

In the meantime, we should do everything we can to make portability more attractive and convenient. For working with I/O, where you need explicit control over endianness, applications can use [DataView](https://developer.mozilla.org/en/JavaScript_typed_arrays/DataView). For heterogeneous data, there'll be ES6 [structs](http://wiki.ecmascript.org/doku.php?id=harmony:binary_data). Finally, I'd like to add an option for `ArrayBuffer`s and typed arrays to be given an optional explicit endianness:

```javascript
var buffer = new ArrayBuffer(1024, "little"); // a little-endian buffer
var a1 = new Uint32Array(buffer);
a1[0] = 1;
var a2 = new Uint8Array(buffer);
a2[0]; // must be 1, regardless of system architecture
```

With the endianness specified explicitly, you can still easily write portable logic even when casting — without having to canonicalize bytes yourself. [Emscripten](https://github.com/kripken/emscripten) and [Mandreel](http://www.mandreel.com/) could benefit from this increased portability, for example, and I think crypto algorithms would as well. I'll propose this extension to Khronos and TC39, and discuss it with JavaScript engine implementors.

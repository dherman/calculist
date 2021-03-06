---
layout: post
title: "On “On Asm.js”"
date: 2013-11-27T15:17:48
categories:
  - asm.js
  - evolution
---

On his [impossibly beautiful blog](http://acko.net/blog) (seriously, it's amazing, take some time to bask in it), Steven Wittens [expressed some sadness](http://acko.net/blog/on-asmjs/) about [asm.js](http://asmjs.org). It's an understandable feeling: he compares asm.js to compatibility hacks like UTF-8 and x86, and longs for the browser vendors to "sit down and define the most basic glue that binds their platforms"---referring to a computational baseline that could form a robust and portable VM for the web.

<!--more-->

I get it: it's surprising to see a makeshift VM find its way into the web via JavaScript, rather than through the perhaps more direct approach of a [new bytecode language](http://mozakai.blogspot.com/2013/05/the-elusive-universal-web-bytecode.html) and standardization effort. What's more, it has become clear to me that emotions always run high when it comes to JavaScript. It's easy for observers to suspect that what we're doing is the result of a blind fealty to JavaScript. But the fact is, our strategy has nothing to do with the success of JavaScript. It's about the success of the *web*. On a shared medium like the web, where content has to run across all OSes, platforms, and browsers, backwards-compatible strategies are far more likely to succeed than discrete jumps. In short, we're betting on evolution because it works: UTF-8 and x86 may be ugly hacks, but the reason we're talking about them at all is that they're success stories.

There's more work to be done, but between [sweet](http://jlongster.com/s/lljs-cloth/) [demos](http://www.flohofwoe.net/demos.html), rapid improvements in [browser performance](https://blog.mozilla.org/futurereleases/2013/11/26/chrome-and-opera-optimize-for-mozilla-pioneered-asm-js/), and the narrowing gap to native via [float32](https://blog.mozilla.org/javascript/2013/11/07/efficient-float32-arithmetic-in-javascript/) and [SIMD](https://github.com/johnmccutchan/ecmascript_simd), I see plenty of reason to keep betting on evolution. The truth is, in my heart I'm an idealist. I love beautiful, clean designs done right from scratch. (I spent my academic years working in Scheme, after all!) But my head tells me that this is the right bet. In fact, I've spent my career at Mozilla betting on evolution: growing JavaScript with [modules](http://wiki.ecmascript.org/doku.php?id=harmony:modules) and [classes](http://wiki.ecmascript.org/doku.php?id=strawman:maximally_minimal_classes), leveling up the internal architecture of browser engines with [Servo](https://github.com/mozilla/servo/), and kicking the web's virtualization powers into high gear with asm.js.

So for developers like Steven who are put off by the web's idiosyncratic twists of fate, let's keep working to build better abstractions to [extend the web forward](http://yehudakatz.com/2013/05/21/extend-the-web-forward/). In particular, in 2014 I want to invest in [LLJS](http://lljs.org), as [James Long](http://jlongster.com/) has been doing in his spare time, to build better developer tools for generating high-performance code---and asm.js can be our stepping stone to get there.

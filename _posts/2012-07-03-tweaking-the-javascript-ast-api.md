---
layout: post
title: "Tweaking the JavaScript AST API"
date: 2012-07-03T11:53:00
categories:
  - JavaScript
  - AST
  - Parser API
  - Esprima
---

A couple years ago I created a [JavaScript parser API](https://developer.mozilla.org/en/SpiderMonkey/Parser_API) and implemented SpiderMonkey's [Reflect.parse](https://developer.mozilla.org/en/SpiderMonkey/Parser_API#Reflect.parse%28src.5B.2C_options.5D%29) library. Since then, there have been a couple of pure JavaScript implementations of the API, including Zach Carter's [reflect.js](https://github.com/zaach/reflect.js) and Ariya Hidayat's [Esprima](http://esprima.org) parser.

<!--more-->

Over time, I've gotten a bunch of good critiques about the API from people. I probably don't want to make any huge changes, but there are a couple of small changes that would be nice:

* [Bug 770567](https://bugzilla.mozilla.org/show_bug.cgi?id=770567) - rename `callee` to `constructor` to match the documentation
* [Bug 742612](https://bugzilla.mozilla.org/show_bug.cgi?id=742612) - separate guarded/unguarded catch clauses
* [Bug 745678](https://bugzilla.mozilla.org/show_bug.cgi?id=745678) - range-based location info

Ariya is graciously willing to change Esprima to keep in sync with SpiderMonkey. But some of these would affect existing clients of either library. I wanted to post this publicly to ask if there's anyone who would be opposed to us making the change. Ariya and I would make sure to be very clear about when we're making the change, and we'd try to batch the changes so that people don't have to keep repeatedly updating their code.

Feel free to leave a comment if you are using Esprima or `Reflect.parse` and have thoughts about this.

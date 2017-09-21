---
layout: post
title: "Synchronous module loading in ES6"
date: 2012-03-29T07:41:00
categories:
  - JavaScript
  - modules
  - async
excerpt_separator: <!--more-->
---

One of the great features of ES6 modules is the direct style module loading syntax:

```javascript
import map from "underscore.js";
... map(a, f) ...
```

This makes it as frictionless as possible to grow or refactor your code into multiple modules, and to pull third-party modules into an existing codebase. It also makes a common module format that can be shared between the browser and JS servers like Node.

<!--more-->

But this direct style requires loading its dependencies before it can execute. That is, it's a synchronous module load. Put in the context of a `script` tag, this would make it all too easy to block page rendering on I/O:

```html
<script>
import $ from "jquery.js";
$('myelement').style({ 'background-color': 'yellow' })
</script>
```

<img class="right" src="/assets/boromir-sync.jpg" /> Throwing this syntax into the browser like this would be an [invitation to jank](https://developer.mozilla.org/En/XMLHttpRequest/Using_XMLHttpRequest#Synchronous_and_asynchronous_requests). Thanks to insight from [Luke Hoban](http://blogs.msdn.com/b/lukeh), I think we have the right approach to this for ES6, which is in fact similar to our approach to avoiding turning `eval` into a synchronous I/O operation.

In previous versions of ECMAScript, there's only one syntactic category of program that you can evaluate, called `Program` in the grammar. In ES6, we'll define a restricted version of the syntax to be used in synchronous settings, which makes it illegal to do synchronous loads. Within a blocking script, the only access to modules is via the dynamic loading API:

```html
<script>
System.load("jquery.js", function($) {
    $('myelement').style({ 'background-color': 'yellow' })
});
</script>
```

This eliminates the footgun, and all of your modules can themselves use the synchronous loading syntax. For example, if `jquery.js` wants to use a module — say, a data structure library — it can go ahead and load it synchronously:

```javascript
// jquery.js
import Stack from "utils.js";
... new Stack() ...
```

But still, this restriction on the top-level loses the convenience of directly importing modules from scripts. Thing is, in an asynchronous context, there's nothing wrong with doing a synchronous load. So just like the asynchronously loaded `jquery.js` can use the synchronous syntax, we can also allow it in a `defer` or `async` script:

```html
<script async>
import $ from "jquery.js";
$('myelement').style({ 'background-color': 'yellow' })
</script>
```

This allows the full flexibility and expressiveness of ES6 embedded in HTML, without any hazard of blocking page rendering for I/O.

The `eval` function for ES6 will work the same way, disallowing synchronous loading syntax in the grammar it recognizes, to prevent turning it into a synchronous API. We'll also add an asynchronous version of `eval` that, like `script async`, recognizes the full grammar.

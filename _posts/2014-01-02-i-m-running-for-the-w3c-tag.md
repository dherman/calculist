---
layout: post
title: "I’m Running for the W3C TAG"
date: 2014-01-02T15:07:25
categories:
  - W3C
  - TAG
excerpt_separator: <!--more-->
---

The W3C's Technical Architecture Group (TAG) has two open seats for 2014, and [I'm running for one of those seats](http://lists.w3.org/Archives/Public/www-tag/2013Dec/0004.html).

In recent years a reform effort has been underway to help the TAG to improve the cohesiveness and transparency of the many moving parts of Web standards. [Domenic Denicola and I would like to help continue that reform process](http://domenic.me/2013/12/02/continual-progress-in-the-w3c-tag/). My particular interests in running focus on several themes:

<!--more-->

## Designing for Extensibility

I'm an original co-signer of the [Extensible Web Manifesto](http://extensiblewebmanifesto.org/), which urges Web standards to focus on powerful, efficient, and composable primitives, in order to allow developers --- who are far more efficient and scalable than standards can ever be --- to innovate building higher layers of the platform. The TAG has recognized the Extensible Web as a core principle. We need to build on this momentum to continue educating people about how the principles play out in practice for designing new APIs and platform capabilities that [empower developers to extend the web forward](https://medium.com/the-future-of-the-web/2fcd1c1bb32).

## Thinking Big and Working Collaboratively

For the Web to compete with native platforms, I believe we have to think big. This means building on our competitive strengths like [URLs](http://www.youtube.com/watch?v=BQ6at0addi4) and dynamic loading, as well as taking a hard look at our platform's weaknesses --- lack of access to modern hardware, failures of the offline experience, or limitations of cross-origin communication, to name a few. My entire job at Mozilla Research is focused on thinking big: from ES6 modules to [asm.js](http://asmjs.org) and [Servo](https://github.com/mozilla/servo/), my goal is to push the Web as far forward as possible. I'm running for TAG because I believe it's an opportunity to set and articulate big goals for the Web.

At the same time, standards only work by getting people working together. My experience with open source software and standards work --- particularly in shepherding the process of getting modules into ES6 --- has taught me that the best way to build community consensus is the [layers of the onion](https://blog.lizardwrangler.com/2006/07/05/layers-of-the-onion/) approach: bring together key stakeholders and subject experts and iteratively widen the conversation. It's critical to identify those stakeholders early, particularly developers. Often we see requests for developer feedback too late in the process, at which point flawed assumptions are too deeply baked into the core structure of a solution. The most successful standards involve close and continuous collaboration with experienced, productive developers. Pioneers like [Yehuda Katz](https://twitter.com/wycats) and [Domenic Denicola](https://twitter.com/domenic) are blazing trails building [better collaboration models](http://www.youtube.com/watch?v=hneN6aW-d9w) between developers and platform vendors. Beyond the bully pulpit, the TAG should actively identify and approach stakeholders to initiate important collaborations.

## Articulating Design Principles

When Alex Russell joined the TAG, he [advocated for setting forth principles for idiomatic Web API design](http://infrequently.org/2012/12/reforming-the-w3c-tag/). We can do this in part by advising standards work in progress, which is the ongoing purview of the TAG. Web API creators are often browser implementors, who are under aggressive schedules to ship functionality, and don't always have the firsthand experience of using the API's they create. Worse yet, they sometimes break key invariants of JavaScript that the creators, who are often primarily C++ programmers, didn't understand. One area of particular concern to me is data races: several API's, including the [File API](http://www.w3.org/TR/file-system-api/) and some [proposed extensions to WebAudio](http://lists.w3.org/Archives/Public/public-audio/2013AprJun/thread.html#msg644) introduce [low-level data races](http://blog.regehr.org/archives/490) into JavaScript, something that has been carefully avoided since the run-to-completion model was introduced on Day 1.

And there's room to lead more proactively still. One area I'd like to help with is in evolving or reforming [WebIDL](http://www.w3.org/TR/WebIDL/), which is used by browser vendors to specify and implement Web API's, but which carries a legacy of more C++- and Java-centric API's. Several current members of TAG have begun investigating [alternatives to WebIDL](https://github.com/w3ctag/jsidl) that can provide the same convenience for creating libraries but that lead to more idiomatic API's.

**If you're a developer who finds my perspective compelling, I'd certainly appreciate your public expression of support. If you belong to a voting member organization, I'd very much appreciate your organization's vote.** I also highly recommend [Domenic Denicola](http://domenic.me/2013/12/02/continual-progress-in-the-w3c-tag/) as the other candidate whose vision and track record are most closely aligned with my own. Thanks!

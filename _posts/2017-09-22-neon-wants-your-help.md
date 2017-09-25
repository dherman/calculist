---
layout: post
title: "Neon Wants Your Help!"
date: 2017-09-22T12:00:00
categories:
  - Rust
  - Node
  - Neon
  - Contributors
published: false
---

[Neon](https://www.neon-bindings.com) is a library for conveniently implementing fast, crash-free native Node.js modules with Rust. We've been making steady progress in recent months, with some cool new features including [Electron support](https://guides.neon-bindings.com/electron-apps/) and a new [Task API](https://api.neon-bindings.com/neon/task/) for asynchronously spawning Rust computations to run in a background thread.

<img class="right" style="width: 200px; height: 150px;" src="/assets/help-wanted.jpg" /> But there's much more to do! **I'm inviting you---yes, you!---to come help take Neon to the next level.** We would benefit enormously from contributors with **a wide range of skills and backgrounds.** 

<!--more-->

## And I Mean _Wide_

My dream is to make Neon:

- **Easy to learn:** The default abstraction layer should be intuitive enough that a newcomer's first experience coming from JavaScript should be approachable, and there should be documentation and learning materials to smoothe the on-boarding experience.
- **Rock-solid:** Users should feel confident that refactoring their code in Rust should be no more likely to crash their Node server than vanilla JavaScript.
- **Fully-featured:** The Neon API should be able to express everything you could do in JavaScript itself.
- **Stable:** Once we start approaching 1.0, Rust should get on a regular release cycle, with strong commitment to semantic versioning and backwards compatibility.

Just to give you a sense of the many varied kinds of contributions we could use, here's a taste:

**Project management.** We should keep on top of issues and PRs. I would love to set up a regular meeting with anyone who's willing to help out with this! I could also use help setting up a simple RFC process similar to [Rust RFCs](https://github.com/rust-lang/rfcs), especially for having community discussions around API and workflow design.

**Technical writing.** The [guides](https://github.com/neon-bindings/guides) are shaping up, but they're incomplete and one of the most important tools for on-boarding new users. The [API docs](https://api.neon-bindings.com) are pretty rudimentary and would benefit from many more examples---we should strive for a high-quality, illustrative example for every single API.

**Testing.** The [test suite](https://github.com/neon-bindings/neon/tree/master/test) has a decent structure but is not at all complete. We should aim for complete test coverage of the API!

**Teaching.** I would love to get some good thinking into how to teach Neon to various audiences, especially people who are new to Rust and systems programming. We could use this to drive the way we structure the guides, tutorial videos, etc.

**Windows development.** My primary development machine is Windows these days, but I'm not an expert. I recently [broke our Appveyor builds](https://github.com/neon-bindings/neon/issues/248) just to prove it! 😝 We've also seen some intermittent hangs in Appveyor builds and I'd love a Windows expert to [do some investigating](https://github.com/neon-bindings/neon/issues/250)!

**Web development.** The Neon web site is currently a static page. It certainly would be fun to set it up as a Node page using Neon itself! One of the nice dynamic things we could do would be to create a roadmap page like [the one Helix has](http://usehelix.com/roadmap), with automatic tracking of milestone progress using GitHub APIs. We should also set up a Neon project blog with Jekyll and style it consistently with the rest of [neon-bindings.com](https://www.neon-bindings.com).

**Ops and automation.** I've started an [automation label](https://github.com/neon-bindings/neon/issues?q=is%3Aissue+is%3Aopen+label%3Aautomation) in the issues. A fantastic contribution would be an automated [publication script](https://github.com/neon-bindings/neon/issues/42) to make releases one-touch. (This is realistically achievable now thanks to some project reorganization.)

**Node plugins.** We should explore the possibility of supporting using the new [N-API](https://nodejs.org/api/n-api.html) as an alternative backend for the implementation. We wouldn't be able to move to this as the default backend right away, but it could pave the way for supporting [Node on ChakraCore](https://github.com/nodejs/node-chakracore), and eventually might replace the current backend entirely.

**API design.** There are lots of things you can do in JavaScript that you still can't do in Neon, so there's plenty of missing APIs to finish. And it's not too late to make incompatible changes to the API that's there currently. For example, I'd be especially interested in ideas about making the [`Scope`](https://api.neon-bindings.com/neon/scope/trait.scope) API less awkward, if possible.

**Cargo extensions.** So far, the [neon-cli](https://www.npmjs.com/package/neon-cli) workflow has been reasonably successful at abstracting away the painful configuration details required to build native Node modules correctly. But the _ideal_ situation would be to allow programmers to just use `cargo build`, `cargo run`, and the like to build their Neon crates like any other Rust project. The recent discussions around [making Cargo extensible](https://github.com/rust-lang/rfcs/pull/2136) open up some exciting possibilities to push in this direction. One of the ways you can indirectly help with Neon is to help that effort.

**Macrology.** One of the big, exciting projects we have left is to flesh out the [high-level macro for defining JavaScript classes]({{ site.baseurl }}{% post_url 2016-04-01-native-js-classes-in-neon %}) (and another for defining standalone functions) so users can use simple type annotations to automate conversions between JavaScript and Rust types. We should take inspiration from the design of our sibling project, [Helix](http://usehelix.com)!

**Systems programming.** One of the biggest challenges we have to tackle is making the process of shipping Neon libraries practical, especially for shipping prebuilt binaries. One technique we can explore is to create an ABI-stable middle layer so that Neon binaries don't need to be rebuilt for different versions of Node.

**Threading architectures.** Currently, Neon supports a couple of forms of threading: pausing the JavaScript VM to synchronously run a parallelized Rust computation (via the [`Lock`](https://api.neon-bindings.com/neon/vm/trait.lock) API), and running a background [`Task`](https://api.neon-bindings.com/neon/task/trait.task) as part of the [libuv thread pool](http://docs.libuv.org/en/v1.x/threadpool.html). There's more we can do both on the computation side (for example, supporting [attaching to different threads than libuv's pool](https://github.com/neon-bindings/neon/issues/228)) and the data side (for example, supporting [`ArrayBuffer` transfer](https://v8docs.nodesource.com/node-8.0/d5/d6e/classv8_1_1_array_buffer.html#a9291f6ac203b9ceae83f7f17d39ecb59)).

## Getting Involved

Does any of these sound like something you'd be interested in? Or maybe you have other ideas! If you want to help, come talk to me (**@dherman**) in the [`#neon` community Slack channel](https://rust-bindings.slack.com/messages/neon) (make sure to get an [automatic invite](https://rust-bindings-slackin.herokuapp.com/) first).

## <img class="right" style="width: 184px; height: 128px;" src="/assets/come-in.png" /> A Note About Community

As the original creator of this project, I'm responsible not only for the software but for the community I foster. I _deeply love_ this part of open source, and I don't take the responsibility lightly.

Neon has a ton of cool tech inside of it, and if that's the only aspect you're interested in, that's totally OK. Not everyone needs to be passionate about community-building. Still, not unlike Rust, this whole project's purpose is to **widen the circle of tech and empower new systems programmers.** So I ask of everyone who participates in the Neon project to strive to act in ways that will encourage and motivate as many people as possible to participate.

Concretely, Neon uses the [Contributor Covenant](https://www.contributor-covenant.org/) to frame the expectations and standards of how we treat people in our community. Behind the policies is a simple goal: to **make our community a place that welcomes, trusts, supports, and empowers one another.**

If that sounds good to you, wanna come join us?

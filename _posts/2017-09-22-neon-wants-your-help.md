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

<img class="right" style="width: 184px; height: 128px;" src="/assets/come-in.png" /> [Neon](https://www.neon-bindings.com) is a library for conveniently implementing fast, crash-free native Node.js modules with Rust. We've been making steady progress in recent months, with some cool new features including [Electron support](https://guides.neon-bindings.com/electron-apps/) and a new [Task API](https://api.neon-bindings.com/neon/task/) for asynchronously spawning Rust computations to run in a background thread.

But there's much more to do! **I'm inviting you---yes, you!---to come help take Neon to the next level.** We would benefit enormously from contributors with **a wide range of skills and backgrounds.** 

<!--more-->

## And I Mean _Wide_

My dream is to make Neon:

- **Easy to learn:** The default abstraction layer should be intuitive enough that a newcomer's first experience coming from JavaScript should be approachable, and there should be documentation and learning materials to smoothe the on-boarding experience.
- **Rock-solid:** Users should feel confident that refactoring their code in Rust should be no more likely to crash down their Node server than vanilla JavaScript.
- **Fully-featured:** The Neon API should be able to express everything you could do in JavaScript itself.
- **Stable:** Once we start approaching 1.0, Rust should get on a regular release cycle, with strong commitment to semantic versioning and backwards compatibility.

Just to give you a sense of the many varied kinds of contributions we could use, here's a taste:

**Project management.** We should keep on top of issues and PRs. I would love to set up a regular meeting with anyone who's willing to help out with this! I could also use help setting up a simple RFC process similar to [Rust RFCs](https://github.com/rust-lang/rfcs), especially for having community discussions around API and workflow design.

**Technical writing.** The [guides](https://github.com/neon-bindings/guides) are shaping up, but they're incomplete and one of the most important tools for on-boarding new users. The [API docs](https://api.neon-bindings.com) are pretty rudimentary and would benefit from many more examples---we should strive for a high-quality, illustrative example for every single API.

**Testing.** The [test suite](https://github.com/neon-bindings/neon/tree/master/test) has a decent structure but is not at all complete. We should aim for complete test coverage of the API!

**Teaching.** I would love to get some good thinking into how to teach Neon to various audiences, especially people who are new to Rust and systems programming. We could use this to drive the way we structure the guides, tutorial videos, etc.

**Windows development.** My primary development machine is Windows these days, but I'm not an expert. I recently [broke our Appveyor builds](https://github.com/neon-bindings/neon/issues/248) just to prove it! 😝 We've also seen some intermittent hangs in Appveyor builds and I'd love a Windows expert to [do some investigating](https://github.com/neon-bindings/neon/issues/250)!

**Cargo extensions.** So far, the [neon-cli](https://www.npmjs.com/package/neon-cli) workflow has been reasonably successful at abstracting away the painful configuration details required to build native Node modules correctly. But the _ideal_ situation would be to allow programmers to just use `cargo build`, `cargo run`, and the like to build their Neon crates like any other Rust project. The recent discussions around [making Cargo extensible](https://github.com/rust-lang/rfcs/pull/2136) open up some exciting possibilities to push in this direction. One of the ways you can indirectly help with Neon is to help that effort.

**Macrology.** One of the big, exciting projects we have left is to flesh out the [high-level macro for defining JavaScript classes]({{ site.baseurl }}{% post_url 2016-04-01-native-js-classes-in-neon %}) (and another for defining standalone functions) so users can use simple type annotations to automate conversions between JavaScript and Rust types. We should take inspiration from the design of our sibling project, [Helix](http://usehelix.com)!

**API design.**

**Systems programming.**

**Ops and automation.**

**Node plugins.**

**Threading architectures.**

**Web development.**

## A Note About Community

As the original creator of this project, I'm responsible not only for the software but for the community I foster. I _deeply love_ this part of open source, and I don't take the responsibility lightly.

Neon has a ton of cool tech inside of it, and if that's the only aspect you're interested in, that's totally OK. Still, it's important to understand that, like Rust itself, this whole project's purpose is to **widen the circle of tech and empower new systems programmers.** So I ask of everyone who participates in the Neon project to strive to act in ways that will encourage and motivate as many people as possible to participate.

In operational terms, Neon uses the [Contributor Covenant](https://www.contributor-covenant.org/) to frame the expectations around what is and isn't welcome behavior. More broadly, it's helpful to [remember the goals](https://twitter.com/sarahmei/status/899880200577499136): to **make our community a place that welcomes, trust, supports, and empowers one another.**

So if that sounds good to you, wanna come join us?

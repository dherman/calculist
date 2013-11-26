    Title: The little-endian web!
    Date: 2012-04-25T12:29:00
    Tags: typed arrays, binary data, endianness

<a href="http://en.wikipedia.org/wiki/The_Gates_of_Hell"><img class="right" src="/img/gates-of-hell.jpg" /></a>

> [This](http://calculist.org/blog/2012/04/24/the-little-endian-web/) feels a little bit like the web platform having opened a door to hell and Zombies running out of it. I wonder if we can ever close it again.
-- [Malte Ubl](https://plus.google.com/u/1/116910304844117268718/posts/9fdegEJkAtt)

Let's see if we can. I've had a bunch of productive conversations since my [post](http://calculist.org/blog/2012/04/24/the-little-endian-web/) the other day.

I talked about how specifying little-endian would force big-endian browser vendors to choose one implementation strategy — emulate little-endian by byte-swapping and try to optimize as best they can — and concluded that it was better to let them decide for themselves and see how the market shakes out before specifying. But that doesn't take into account the cost to web developers, which should always be the first priority (mea culpa).

Leaving it unspecified or forcing developers to opt in to a specified endianness taxes developers: it leaves them open to the possibility of their sites breaking on systems they likely can't even test on, or forces them to make sure they pass the argument (in which case, they'd always be one forgotten argument away from possible bustage on some platform they can't test on).

Imagine that instead of defaulting to unspecified behavior, we defaulted to little-endian — which is the de facto semantics of the web today — but apps could opt in to big-endian with an optional argument. Then a carefully-written app could use this (in combination with, say, a `navigator.endianness` feature test API) to decide which byte order would give them better performance. On little-endian systems, they'd use little-endian, on big-endian systems, they'd use big-endian. Less carefully-written apps that just went with the default might get some performance degradation in big-endian platforms, but we don't actually know how bad it would be. But crucially, **there would be no way to accidentally break your app's behavior**.

But let me take it one step further. I don't even think we know that that additional option will be needed. For now, we don't even know of any big-endian user agents that are implementing WebGL, nor do we know if byte-swapping will be prohibitively expensive. Until then, I say any additional API surface area is premature optimization. [YAGNI](http://en.wikipedia.org/wiki/You_ain%27t_gonna_need_it).

In summary: let's prioritize web developers over hypothetical performance issues on hypothetical browsers. **Typed arrays should be standardized as little-endian** — full stop.

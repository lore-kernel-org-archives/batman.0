Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 7 May 2019 17:34:59 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: Re: [PATCH v2] batman-adv: Introduce no noflood mark
Message-ID: <20190507153459.GC1493@otheros>
References: <20190507072821.8147-1-linus.luessing@c0d3.blue>
 <3693433.LtgH54LjNc@bentobox> <3691280.TvIfeD7Em7@rousseau>
 <1895475.8kFdyZb9vl@bentobox> <20190507151723.GB1493@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190507151723.GB1493@otheros>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Marek Lindner <mareklindner@neomailbox.ch>

On Tue, May 07, 2019 at 05:17:23PM +0200, Linus Lüssing wrote:
> > This would even allow some fancy stuff like rate limiting or per hardif 
> > behavior. With the problem that there is no package yet which does this in 
> > gluon.
> 
> Ah, that's an interesting idea. So basically filtering on the
> hardif instead of in batman-adv via some custom compiled BPF
> filters. So basically similar to writing a small program like the
> gluon-radv-filterd with a BPF_* parser?
> 
> https://github.com/freifunk-gluon/gluon/blob/master/package/gluon-radv-filterd/src/gluon-radv-filterd.c#L223

And usability is of course different. Compared to writing a BPF
program it would just be an extra line in the firewall like here:

https://github.com/freifunk-gluon/gluon/pull/1357/files#diff-adbff50d8f3994ffbbac77f580ace41e

And setting the noflood_mark in batman-adv:

https://github.com/freifunk-gluon/gluon/pull/1357/files#diff-89c09eae71234dcaa46a6137d796048b

Also, we would not only need to package it for Gluon then but also
various Linux distributions used on gateways, I guess. To further
reduce the ARP broadcasts for vanished clients on gateways, for instance
(the second use-case).


Btw., I think rate-limiting would already be possible. We could
set the mark in a rate-limited fashion incoming on bat0 with
ebtables for instance.

Which could be useful to simplify gluon-ebtables-arp-limiter [0] a
bit. Currently there's a loop over the "batctl dat_cache" table
to add an exception to rate-limiting for addresses available in
the cache.

Regards, Linus


[0]: https://github.com/freifunk-gluon/gluon/tree/master/package/gluon-ebtables-limit-arp

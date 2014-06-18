Return-Path: <linus.luessing@web.de>
Date: Wed, 18 Jun 2014 21:56:57 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20140618195657.GM29033@Linus-Debian>
References: <1403000163-8148-1-git-send-email-sw@simonwunderlich.de>
 <20140617224449.GH29033@Linus-Debian>
 <201406181121.14252.simon@open-mesh.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201406181121.14252.simon@open-mesh.com>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: increase default hop penalty
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Simon Wunderlich <simon@open-mesh.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Wed, Jun 18, 2014 at 11:21:14AM +0200, Simon Wunderlich wrote:
> > 
> > Any data for others to check?
> 
> Nope, unfortunately these are customer networks, and I can't reveal data from 
> that in public.

That's very, very unfortunate... and made my hair stand on end. It
clashes/undermines a little with a point I love a lot about free
software... Anyways, maybe that's not something to discuss on a
mailing list.


Damn it, why don't we have the stupid hop count in the
measurements from the last WBM? Would have been very easy to
verify with that.

Maybe we could try using the WBM to transparently find better
default values in the future (again; I remember that you had made
nice graphs for the decision of having interface-alternating or
interface-bonding as the default back then at WBMv3 in Italy -
that was awesome!)?

> But I can certainly explain how I tested: We were running 
> Antonios throughput meter on these devices and saw some unusual slow 
> throughput and too long paths (4 hops were 2 were possible). We then increase 
> the hop penalty to the suggested value, and both the hopcount decreased and 
> the throughput increase. We repeated that with other 6 networks and had either 
> similar improvement or no change at all (since all hopcounts were already 
> one).

What mcast-rate were you using? Will this make things worse for
setups with a different mcast-rate?

> 
> Cheers,
>     Simon

Cheers, Linus

Return-Path: <simon@open-mesh.com>
From: Simon Wunderlich <simon@open-mesh.com>
Date: Wed, 18 Jun 2014 11:21:14 +0200
References: <1403000163-8148-1-git-send-email-sw@simonwunderlich.de>
 <20140617224449.GH29033@Linus-Debian>
In-Reply-To: <20140617224449.GH29033@Linus-Debian>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201406181121.14252.simon@open-mesh.com>
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hi Linus,

> On Tue, Jun 17, 2014 at 12:16:03PM +0200, Simon Wunderlich wrote:
> > This patch changes the hop penalty to 30, which will give an effective
> > penalty of 60 on single band devices (hop penalty + wifi penalty).
> 
> "batman-adv: encourage batman to take shorter routes by changing the
> default hop penalty" (6a12de1939281dd7fa62a6e22dc2d2c38f82734f)
> 
> This patch changed the hop penalty for single (and back then
> also dual) band devices from 10 to 30.

that's right. Actually, at this time I was using 50 for most of my networks, 
so 30 was a compromise.

 
> 
> If 60 were always the correct value, why wasn't it changed from
> 10 to 60 back then?

There is no such thing as a correct value for that. The hop penalty is an 
empirical value  derived from various experiments. The original idea was to 
introduce a artificial decrease of the metric for perfect networks (e.g. 
Ethernet) to avoid loops, but it turned out that it can also be useful to 
avoid route flapping between paths of different lengths, or to compensate 
small changes in the measurement. For example, when we placed 10 routers in 
one place, the routes were flapping from 1 hop (which would to be expected) to 
2 hops - because of small changes in the TQ measurement. We then increased the 
hop penalty from 10 to 30 (or even 50) which solved that problem.

> 
> If the reason was not having it measured thoroughly enough
> back then, why would your latest measurements be? (For instance
> what will prevent the hop penalty being changed again next year?)

What is "thoroughly enough"? I didn't do "scientifical research" or write any 
paper on that, and don't plan to do so. It's a default value, but anyone who 
has a better idea can change that. It's solely based on our personal 
experience. I don't guarantee that we will not change it again next year, but 
last time we kept it for quite some time too ...

I tested it on 7 networks with 10-20 nodes each, and different type of 
devices. That is certainly more than last time. If you have the time/resources 
to do a bigger / more detailed test, feel free to do so and share your 
results. :)


> 
> Any data for others to check?

Nope, unfortunately these are customer networks, and I can't reveal data from 
that in public. But I can certainly explain how I tested: We were running 
Antonios throughput meter on these devices and saw some unusual slow 
throughput and too long paths (4 hops were 2 were possible). We then increase 
the hop penalty to the suggested value, and both the hopcount decreased and 
the throughput increase. We repeated that with other 6 networks and had either 
similar improvement or no change at all (since all hopcounts were already 
one).

Cheers,
    Simon

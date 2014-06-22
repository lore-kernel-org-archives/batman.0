Return-Path: <linus.luessing@web.de>
Date: Sun, 22 Jun 2014 12:29:38 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20140622102938.GY29033@Linus-Debian>
References: <1403000163-8148-1-git-send-email-sw@simonwunderlich.de>
 <201406181121.14252.simon@open-mesh.com>
 <20140618195657.GM29033@Linus-Debian>
 <201406191818.12149.simon@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201406191818.12149.simon@simonwunderlich.de>
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
To: Simon Wunderlich <simon@simonwunderlich.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

Hi Simon,

first of all, sorry for me getting so emotional about it. My bad,
I know, it's usually not very constructive to get emotional on a
mailing list.


On Thu, Jun 19, 2014 at 06:18:11PM +0200, Simon Wunderlich wrote:
> > 
> > Damn it, why don't we have the stupid hop count in the
> > measurements from the last WBM? Would have been very easy to
> > verify with that.
> 
> Very easy ...? Well, if you think so, please propose/perform/evaluate these 
> tests in the next battlemesh. :)

What I ment was, that actually we sort of had these tests/the data
:). If I remember correctly, then there were non-dynamic
environment tests on the slides Axel and others presented. Where
you could see the number of hops each layer 3 routing protocol
took and what throughput they had. If there had been hop-count
information for batman-adv too, we could have compared it to the
other protocols and might have been able to deduce whether more or
less hops would have resulted in higher throughput.

I will see whether I can help setting up logging data from batctl-ping
next year :).

> 
> > 
> > Maybe we could try using the WBM to transparently find better
> > default values in the future (again; I remember that you had made
> > nice graphs for the decision of having interface-alternating or
> > interface-bonding as the default back then at WBMv3 in Italy -
> > that was awesome!)?
> 
> Yeah, that wasn't so bad, but the tests were not very extensive too - 3 
> devices with special hardware and setup. We could show the gains of 
> alternating/bonding after all ... ;)
> 
> In any case, feel free to propose these kind of tests for next WBM.
> 
> > 
> > > But I can certainly explain how I tested: We were running
> > > Antonios throughput meter on these devices and saw some unusual slow
> > > throughput and too long paths (4 hops were 2 were possible). We then
> > > increase the hop penalty to the suggested value, and both the hopcount
> > > decreased and the throughput increase. We repeated that with other 6
> > > networks and had either similar improvement or no change at all (since
> > > all hopcounts were already one).
> > 
> > What mcast-rate were you using? Will this make things worse for
> > setups with a different mcast-rate?
> 
> The mcast rate was 18M. I don't know if it gets "worse" for different MCS 
> rates, and it depends what we think is "worse". In general, I'd expect that 
> the protocol chooses longer links /shorter paths, for all mcast rates.

Thanks, 18MBit/s is a valuable information! Hm, I would kind of
guess then, that everyone using an mcast rate lower or equal to
18MBit/s should be good to go, right? If nodes are using a lower
mcast rate then they mostly have a lower packet loss and would
need a higher hop penalty to select the same "good" path.

On the other hand, people using an mcast rate higher than 18MBit/s
might want to have a hop penalty lower than 60. But right now, I'm
not aware of any such mesh networks, so probably it shouldn't make
things worse for other people if your measurements in your mesh
were correct (which I believe they were - I never wanted to
discredit your capabilities, you, Marek and Antonio are probably
the best people to perform such tests in a reliable way).

> 
> Cheers,
>     Simon

PS: Somebody noted on IRC, that it might seem that I would have a
problem with commercial, non-public mesh networks.
While I would certainly love it if everyone were setting
up their commercial network on top of a free community mesh
network Freifunk, Ninux etc., I don't have an issue if someone
decides to not do that, that's everyone's free choice :). And
people making a living with a commercial mesh network didn't get
me emotional at all, that wasn't it.

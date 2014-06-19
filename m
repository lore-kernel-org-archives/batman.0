Return-Path: <jay@dslx.net>
From: "Jay Brussels" <jay@dslx.net>
References: <1403000163-8148-1-git-send-email-sw@simonwunderlich.de>
 <201406181121.14252.simon@open-mesh.com>
 <20140618195657.GM29033@Linus-Debian>
 <201406191818.12149.simon@simonwunderlich.de>
In-Reply-To: <201406191818.12149.simon@simonwunderlich.de>
Date: Thu, 19 Jun 2014 15:25:57 -0400
Message-ID: <0d4801cf8bf4$4bcc6040$e36520c0$@dslx.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
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
To: 'The list for a Better Approach To Mobile Ad-hoc Networking' <b.a.t.m.a.n@lists.open-mesh.org>

I will be setting up a test network with 20-25 radio's before our big
roll-out.  I can make the network available for testing if that would help
at all.

-----Original Message-----
From: B.A.T.M.A.N [mailto:b.a.t.m.a.n-bounces@lists.open-mesh.org] On Behalf
Of Simon Wunderlich
Sent: Thursday, June 19, 2014 12:18 PM
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: increase default hop penalty


> On Wed, Jun 18, 2014 at 11:21:14AM +0200, Simon Wunderlich wrote:
> > > Any data for others to check?
> > 
> > Nope, unfortunately these are customer networks, and I can't reveal 
> > data from that in public.
> 
> That's very, very unfortunate... and made my hair stand on end. It 
> clashes/undermines a little with a point I love a lot about free 
> software... Anyways, maybe that's not something to discuss on a 
> mailing list.

I don't quite get why you are so emotional about that. There are tons of
other default settings and "heuristic" values which we determined with much
less "scientific" effort - e.g. the wifi penalty, local window size, request
timeout, tq global window size, broadcast number ... and nobody cried about
setting these values or changing them.

I understand that it would be nicer to get all data in public, but open
software is used in private and/or commercial environments as well and we
should respect that these people don't want their network topology revealed.

These networks are not public playground. Of course, if you want you can
repeat these kind of experiments in your community or test mesh networks
(weren't there some EU projects who offered that kind of stuff? :] )

> 
> Damn it, why don't we have the stupid hop count in the measurements 
> from the last WBM? Would have been very easy to verify with that.

Very easy ...? Well, if you think so, please propose/perform/evaluate these
tests in the next battlemesh. :)

> 
> Maybe we could try using the WBM to transparently find better default 
> values in the future (again; I remember that you had made nice graphs 
> for the decision of having interface-alternating or interface-bonding 
> as the default back then at WBMv3 in Italy - that was awesome!)?

Yeah, that wasn't so bad, but the tests were not very extensive too - 3
devices with special hardware and setup. We could show the gains of
alternating/bonding after all ... ;)

In any case, feel free to propose these kind of tests for next WBM.

> 
> > But I can certainly explain how I tested: We were running Antonios 
> > throughput meter on these devices and saw some unusual slow 
> > throughput and too long paths (4 hops were 2 were possible). We then 
> > increase the hop penalty to the suggested value, and both the 
> > hopcount decreased and the throughput increase. We repeated that 
> > with other 6 networks and had either similar improvement or no 
> > change at all (since all hopcounts were already one).
> 
> What mcast-rate were you using? Will this make things worse for setups 
> with a different mcast-rate?

The mcast rate was 18M. I don't know if it gets "worse" for different MCS
rates, and it depends what we think is "worse". In general, I'd expect that
the protocol chooses longer links /shorter paths, for all mcast rates.

Cheers,
    Simon


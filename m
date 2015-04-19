Return-Path: <linus.luessing@c0d3.blue>
Date: Sun, 19 Apr 2015 20:25:36 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20150419182536.GJ2396@odroid>
References: <20150330212726.46ff30c5@i3.local>
 <2776853.MalcVFtyXS@prime>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2776853.MalcVFtyXS@prime>
Subject: Re: [B.A.T.M.A.N.] batman-adv: increased default hop penalty
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
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org, felix@freifunk-nrw.de

Hi,

at the last Wireless Battle Mesh there were some nice graphs for
the throughput and number of hops chosen - except for batman-adv
because they used the layer 3 ping-tool for that.

We should probably look into having a graph about that for
batman-adv at the next WBM, I think. Then we can compare with
the other routing protocols via the throughput statistics whether
batman-adv chooses too short routes and therefore.


For my current experiences with the number of hops, I can't say
anything for sure yet. Years ago I had issues with batman-adv
selecting too short routes in a specific indoor setup. But that
turned out to be a mean hidden-node problem instead: batman-adv
switched to a shorter - and unusable - route a few seconds after
starting iperf.

From the Freifunk community mesh in Lübeck, I had been playing a
little with increasing the hop penalty on the VPN gateways a few
weeks ago, with the intent to make the wifi-mesh more preferable
compared to the VPN uplinks.

I wasn't able to get a workable route from this node:
http://map.luebeck.freifunk.net/#!n:24a43c99ac30
to this node:
http://map.luebeck.freifunk.net/#!n:647002d15c36

It'd take about six hops to get there. All links on this path
are green, meaning they have a TQ above 200.

Unfortunately with the last hop the TQ dropped too low, the nodes
aren't within each others horizon.

Also, we are still using batman-adv 2013.4.0 here, so we actually
still have the hop penalty of 15.

Cheers, Linus


PS: Though I guess it doesn't make much sense to fiddle some more
with the hop penalty now. The new throughput metric with BATMAN V
is probably the better approach to mobile adhoc networking :).


On Tue, Mar 31, 2015 at 02:18:56PM +0200, Simon Wunderlich wrote:
> Hi,
> 
> to cite from my original answer:
> 
> We did have some discussion on that patch too:
> 
> https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2014-June/012155.html
> 
> I wrote that patch because we had problems in commercial installations and 
> dual radio access points, which were fixed by this patch (as described in the 
> mail). I didn't hear any practical problems so far, you are the first one.
> 
> I guess its not easy to have a "one value fixes all problems" hop penalty, but 
> its at least worth to discuss it - so thank you very much for your input.
> 
> Since we got this mail on the mailing list now, I'd like to hear opinions from 
> other people and/or communities.
> 
> Thanks,
>      Simon
> 
> On Monday 30 March 2015 21:27:26 Ruben Wisniewski wrote:
> > Forwarded private message, on request by Simon.
> > 
> > On Friday 27 March 2015 16:52:14 Ruben Wisniewski wrote:
> > > Hello Simon,
> > > 
> > > 
> > > we just updated our mesh, to the batman-adv-version 2014.4. Now your
> > > patch batman-adv: increase default hop penalty[1] is included.
> > > 
> > > Since we got very large mesh-networks, we have some troubles with your
> > > patch, which makes long (needed) pathes unusable, because they TQ drop
> > > to lower zero.
> > > 
> > > Else, we got some old and some new batman-adv versions, this change
> > > overloads the old nodes, because their TQ are better, and similiar
> > > links over new nodes got ignored.
> > > 
> > > Else I see no improvement overall, because the usual urban link-wide
> > > is about 30-50 meteres, and we got parts of the net where we need 4-5
> > > hops to reach the last node. Your Patch seem to limit these pathes to
> > > something around 3 hops. So parts of our net are now offline, and the
> > > speed overall doesn't seem to be improved.
> > > 
> > > After these experience I like to ask you, if you mind reverting this
> > > patch again. Else we have to work around with resetting to 15 again on
> > > boot, which I think is not the prefered solution.
> > > 
> > > 
> > > [1]
> > > http://www.open-mesh.org/projects/batman-adv/repository/revisions/7644650b
> > > b7 66bd4c7b6be5d97e6b1c3ed93a38d7
> > > 
> > > 
> > > Best regards,
> > > 
> > > 
> > > Ruben



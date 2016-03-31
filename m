Return-Path: <linus.luessing@c0d3.blue>
Date: Thu, 31 Mar 2016 19:17:55 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160331171755.GD2989@otheros>
References: <56F5AF2F.6060904@t-online.de> <34764958.y3lWsCmXTL@prime>
 <20160330135842.GA19985@r2d2.s.lihas.de> <3605600.IEJkB4EzUh@prime>
 <20160331160141.GG5258@prodigo.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160331160141.GG5258@prodigo.lan>
Subject: Re: [B.A.T.M.A.N.] No rebroadcast on mesh links
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

On Fri, Apr 01, 2016 at 12:01:41AM +0800, Antonio Quartulli wrote:
> On Thu, Mar 31, 2016 at 02:11:19PM +0200, Simon Wunderlich wrote:
> > I thought a little more on automation, but I'm now at a point to agree that 
> > there is no good way to do it - at least I'm out of ideas. If anyone else has 
> > some ideas, please speak up NOW. :)
> 
> Some time ago we had a proposal (by Linus I believe) which was about detecting
> transitive interfaces by exchanging neighbour tables between peers. This way a
> node can understand if every other node behind an interface can talk to each
> other or not.

Basically the first ELP patches had provided that information
already, there was a table of neighbors together with the measured
link RX metric. But the ELP version merged now is simpler with less overhead
and does not have such a table anymore, as the link metric is now
provided by mac80211 / the rate selection algorithm.


> Although this approach sounds more complex, it would also help optimizing the wifi
> case: a node can understand if the hosts in an adhoc cells can all talk to each
> other and then avoid the retransmission (thus saving previous airtime - as we
> would save bandwidth in a VPN).

Indeed.

> 
> The only problem is that this would work only after extending BATMAN V and would
> unlikely be implemented in BATMAN IV.

I wouldn't see it as a problem but a feature instead, helping to
motivate to migrate to BATMAN V ;). Also, Matthias provides Debian
packages for BATMAN IV which includes the manual switch, so
it shouldn't be too painful for BATMAN IV users either.

> 
> Not sure if Linus (?) or anybody else is willing to work on this....but I guess
> people would like a solution to be used on BATMAN IV ? Or is this an option ?

Back then I think I said (and this is still the case) I would love
to work on a detection mechanism, but only once the multicast
things are finished. I don't want to drag multiple patchsets along
for years.

If anyone else wants to work on that, great :).

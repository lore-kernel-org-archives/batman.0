Return-Path: <fuumind@openmailbox.org>
Message-ID: <1493376248.28193.6.camel@openmailbox.org>
From: fuumind <fuumind@openmailbox.org>
Date: Fri, 28 Apr 2017 12:44:08 +0200
In-Reply-To: <1504855.vmUtePouqW@prime>
References: <1493216459.18414.3.camel@openmailbox.org>
 <1504855.vmUtePouqW@prime>
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] how well does batman-adv scale
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

Ok, so clouds of a few hundred nodes would work reasonably well and at
the same time keep customization to a minimum.

What makes OSPF a better candidate for interfacing between the clouds?
Does it keep a more limited routing table and thus minimize overhead
traffic? I haven't been able to figure it out good enough yet.

fuumind

ons 2017-04-26 klockan 18:05 +0200 skrev Simon Wunderlich:
> Hi,
> 
> "works well" depends much on  your scenario.
> 
> I've seen many well-working networks with 100-300 nodes. There are
> Freifunk 
> community networks with over 1000 nodes running batman-adv (i.e.
> "standard" 
> users like laptops and smartphones), but they employ a lot of
> filtering to 
> avoid too much broadcast.
> 
> Unless you have special restrictions like minimal broadcast traffic
> or high 
> capacity on the wireless links, memory and CPU, I would not recommend
> to plan 
> for 10 000 nodes and beyond.
> 
> Cheers,
>      Simon
> 
> On Wednesday, April 26, 2017 4:20:59 PM CEST fuumind wrote:
> > 
> > Hi list!
> > 
> > Been lurking for almost a year on the battlemesh list and recently
> > joined here as well. 
> > 
> > I'm curious about how well batman-adv scales. Would a network of 10
> > 000
> > nodes work well? What about 100 000 nodes or 1 000 000?
> > 
> > Thanks!
> > fuumind

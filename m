Return-Path: <fuumind@openmailbox.org>
Message-ID: <1493222768.13937.11.camel@openmailbox.org>
From: fuumind <fuumind@openmailbox.org>
Date: Wed, 26 Apr 2017 18:06:08 +0200
In-Reply-To: <c63cb109-81bf-4a08-6b29-813a89590170@viisauksena.de>
References: <1493216459.18414.3.camel@openmailbox.org>
 <c63cb109-81bf-4a08-6b29-813a89590170@viisauksena.de>
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

Hi Jens! 

By 'sufficient power', do you mean processing power to handle overhead
traffic? I'm imagining a network which primarily connects WLANs.

Clouds of batman-adv networks sounds like a good idea. Any idea about
how to implement the interfaces between these clouds? How big should
they be allowed to grow before forming a new cloud?

fuumind


ons 2017-04-26 klockan 17:10 +0200 skrev jens:
> i think this could scale , but you will need sufficient power /
> ethernet
> capacities at the nodes.
> 
> and the biggest problem may be that these endpoints make much noise
> on
> the layer2 level.
> (disovery protocolls and stuff like this)
> 
> you could easily imagine what would happen if you have a layer2
> switch
> with 100000 ports.
> 
> i think that most of the time you will not do this, and implement
> some
> sort of routing between some clouds of batman-adv networks.
> 
> 
> 
> On 26.04.2017 16:20, fuumind wrote:
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
> > 

From: elektra <onelektra@gmx.net>
Subject: Re: [B.A.T.M.A.N.] batman routing clarification
Date: Wed, 19 Sep 2007 19:44:07 +0200
References: <2bda28cd0709190519r74f0c58ncc1c23553c925091@mail.gmail.com>
	<200709191525.12422.onelektra@gmx.net>
	<2bda28cd0709190924o217a3686vabf481bd66927971@mail.gmail.com>
In-Reply-To: <2bda28cd0709190924o217a3686vabf481bd66927971@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200709191944.07884.onelektra@gmx.net>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

Thanks!

One thing that just came to my mind: when you used -o 3000 it takes very long 
to fill the sliding window size of OGM statistics. A sliding window size of 
128 will take 384 seconds to fill up - more than 6 minutes! So if you just 
fire up the daemon and quickly start your measurements, the routing results 
can be quite arbitrary since there are not enough packets to make a 
reasonable decision.

But it might very well be the case that the broadcasts of the stretched link 
are propagating too far. In this case there is a workaround: You can increase 
the broadcast datarate if your wireless drivers/cards support this feature. 
This way you will decrease the range of OGM broadcasts. This has proven to be 
a good solution for mesh networks using OLSR at Freifunk.

Batman-0.2 still has some flaws in the routing metrics. The routing algorithm 
works nicely, but the metrics are sometimes unfortunate (choosing routes with 
bad performance in transmit direction, rumors saying it is preferring routes 
with small hopcount too much.) We are addressing this with 0.3 and in the 
experimental branch of batmand.

Also it could indicate a problem with the wireless devices.

cu elektra



> 2007/9/19, elektra <onelektra@gmx.net>:
> > Hi -
> >
> > which version of batman are you using? And you should provide us with
> > more
>
> batman 0.2
>
>
> details. Just saying Link is 'poor' or 'good' is very unprecise. Remember:
> A
>
> > direct route with 6 Megabit performs similar to a two-hop link with 12
> > Megabits on each link, since no retransmissions have to be made.
>
> poor respectly to radio signal, A to C without B give 100kbit/s unstable
>
> If you set the routes manually, it would be interesting to know the
> transfer
>
> > performance of the following:
>
> A->C: 100kbit
>
> > A->B: full
> > A->B->C: 1000kbit
> > C->A: 100kbi
> > C->B: 2500kbit
> > C->B->A: 1000kbit
> >
> >
> > How many OGMs does A count directly from C and via B? (And vice versa)
> > By the way: -o 3000 is quite slow for sending Originator messages if you
> > have
> > 20 nodes only. The default should be fine.
>
> Ok, I removed -o 3000 and changed antenna in A node (less sensitive to node
> C).
> Now default route for A is B, that it is correct.
>
> > > I am switching a 20 mesh node from olsrd but I have some problem in
> > > routing. I have no gateway node because I use openvpn to have a tunnel
> >
> > with
> >
> > > PC. All nodes have:
> > >   batman -g 0 -r 3 -o 3000 <interface>
> > >
> > > node C has:
> > >   batman -g 0 -r 3 -o 3000 -a 10.0.0.0/24 <interface>
> > >
> > > I have several case like this:
> > >
> > > A----good----B----good-----C-----10.0.0.0/24----PC
> > > \---------------poor-------------/
> > >
> > > three node can communicate with all others but radio link from A to C
> > > is poor.
> > >
> > > When node A want to communicate to node C it goes directly to C because
> > > batman calculate a direct route to it.
> > > But if I manually set routes to use node B connection from A to C is
> >
> > good.
> >
> > > What is my mistake?
> > >
> > > -r parameter in batmand daemon works only in searching gateway node?
> >
> > ...or
> >
> > > it works every time, also with normal node?



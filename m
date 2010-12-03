Return-Path: <xxx@nei.mv.com>
Date: Fri, 3 Dec 2010 05:21:13 -0500 (EST)
From: RHS Linux User <xxx@nei.mv.com>
In-Reply-To: <56064E4A-CCC8-4D1C-BE37-FA0F7C0E14BB@lo-res.org>
Message-ID: <Pine.LNX.3.95.1101203051928.29387K-100000@nei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [B.A.T.M.A.N.] global mesh
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


Hi,

   VillageTelco is interesting to watch grow. More like Linux and
the Bazaar :).

   A boss of mine put it nicely: "I must hurry for there go my people!"

   Wiz


On Fri, 3 Dec 2010, L. Aaron Kaplan wrote:

> 
> 
> Kosta, some remarks upfront:
> 
> There *are* alredy mesh networks on satellites in place. 
> http://en.wikipedia.org/wiki/Iridium_satellite_constellation
> http://en.wikipedia.org/wiki/Wireless_mesh_network
>  ("been there, done that, let's move to the next topic" ;-))
> 
> 
> On Nov 30, 2010, at 4:55 PM, Michael van der Kolff wrote:
> 
> > And just reiterating:  BATMAN works just fine for larger networks,
> > just so long as you're happy to use BGP between disparate BATMAN
> > islands.  But first, ask yourself whether you really need a network
> > with 500 routers involved in decision making on that little piece of
> > paradise...
> > 
> 
> 500 nodes can be easily achieved. Even the "small" Freifunk networks (and Funkfeuer.at networks) 
> get bigger than 500 nodes (and yes, they run OLSR and that provably scales up to n * 1000 nodes on 200Mhz devices).
> So, yes, IMHO it definitely makes sense for a MANET protocol to support more than 500 nodes in a single mesh cloud.
> AWMN and Guifi.net have 5000+ and 10000+ nodes, so... it is a real issue.
> 
> 
> If you want, you can then *always* make a two layered approach (BGP + {OLSR,OSPF,MANET-OSPF,BATMAN,TORA,BABEL,HSLR, even RIPv2,... you name it, there are hundreds of MANET protocols out there}) and in fact this is the usual best practice approach to networking. Almost all ISPs that I know do it this way. Interior routing protocol and exterior (BGP). No problem with that.
> 
> I even know of one WISP who uses no routing protocol at all, he just uses a pure switched Wi-Fi network for his customers.  And you won't believe it - he is perfectly happy. But he spends a great deal of time to optimize layer 1 (the actual links). Also a possibility - maybe even a pretty good solution ;-))
> (ok, but this guy does not have more than 1000 customers for sure)
> 
> a.
> 
> PS: My gut feeling says netsukkuku always talks about endless scalability but they never actually showed something which works in practice, or did they? can you update me on any real world netsukkuku deployment?
> 
> 
> 
> 


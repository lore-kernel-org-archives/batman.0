Return-Path: <andrew@lunn.ch>
Date: Wed, 20 Mar 2013 12:35:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20130320113554.GB30638@lunn.ch>
References: <5148D0CB.3090907@altermundi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5148D0CB.3090907@altermundi.net>
Subject: Re: [B.A.T.M.A.N.] Multiple border gateways between bat-networks
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Tue, Mar 19, 2013 at 09:55:39PM +0100, Gui Iribarren wrote:
> Hey folks!
> today we bring you a riddle to start the week
> /me grins...
> 
> First, some clues:
> http://comments.gmane.org/gmane.org.freifunk.batman/6603
> http://www.open-mesh.org/projects/open-mesh/wiki/FAQ#How-do-I-announce-IP-subnets-using-batman-adv
> 
> now, given the attached diagram .png
> 
>  * the description given in the wiki still applies, i.e. A, B, C...
> nodes run your favourite layer3 dynamic routing protocol, and all
> nodes run batman, in segmented (colored) clouds = subnets.
>  * i am one of the clients connected to F
>  * in the blue cloud, there's one preferred gw_mode=server which is
> D (or E for that matter, but certainly not F or G)
>  * D gave me a DHCP OFFER and since then is my default gw, which i
> use to access the internet. I have no other routes setup.
>  * the violet link G <-> H although it looks "long" is in fact a
> superb link, 0% packet loss, high bw. F <-> G also works great.
> 
> Now, i want to send a file to H. Visibly, the optimal route would be
> F -> G -> H.
> BUT, i only have a default gw, which is D. I pass the packet to D.
> Thanks to the layer3 routing protocol, D knows that both E and G
> have access to the red network.  However, E is closer so it relays
> the packet there,

Hi Gui

So D, E, G and H are L3 routers. I'm assuming they all know of each
other in terms of L3 routing protocol. They are all speaking OSPF or
something.

At L3, there are two sensible routes F->E->H and F->G->H. Both are two
L3 hops, so if you are going on plain number of hops, you have a 50/50
chance of taking G->H. 

However, OSPF is not really hop based. You assign costs to each
link. Higher bandwidth links have lower cost. OSPF will optimize the
cost. So if the total cost of F-G->H is lower than F->E->H, it will
take that route.

Set the cost correct in the L3 routing protocol.

    Andrew

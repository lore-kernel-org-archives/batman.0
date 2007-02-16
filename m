From: axel <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] First batman tests
Date: Fri, 16 Feb 2007 19:35:17 +0100
References: <560c7c9a0702140437l21bad4f4v7d12854ee932a7c0@mail.gmail.com>
In-Reply-To: <560c7c9a0702140437l21bad4f4v7d12854ee932a7c0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200702161935.18277.axel@open-mesh.net>
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

Hello,

Another comment on your scenario:
Each node should always be reachable (if a suitable path in the mesh exists) 
via the IP of the first configured interface ( eth0 if launched as: batmand 
eth0 ath0 ).

Some more background:
If batman is configured to serve multiple interfaces only one of them (the 
first defined one) is announced with a TTL=50. The second and further 
interfaces are by default announced with a TTL=2 only. The reason for that 
is, that one known IP-address is sufficient for distant nodes to reach that 
node and therefore at least one of the configured interfaces and 
corresponding IP must be announced with a high (50) TTL.
Announcing all interfaces with a high TTL would only cause increased routing 
tables and a waste of bandwidth due to additional OGM messages traversing the 
mesh. 
However, all configured interfaces need to announce their existence at least 
to their neighbors in order to indicate the existence of a link so that they 
can be used (thats why the remaining interfaces are configured with a 
TTL=2 ). 
Because all IPs are announced (with seperate OGMs) via all interfaces, it does 
not matter which interfaces have a good connectivity to its' neighbors and 
which not.
That is one interesting thing with batman: A node does not know the exact path 
to a destination node, it only knows the best neighbor towards the 
destination node. Therefore, in a multi-hop-scenario, you can even configure 
intermediate nodes with a TTL=2 for all interfaces, making such nodes fully 
invisible for all more-than-two-hops-away-nodes. Such invisible intermediate 
nodes would still be used for routing end2end traffic.

ciao,
axel


On Wednesday, 14. February 2007 13:37, Benjamin Henrion wrote:
> Hi,
>
> We met with several people in Brussels active on the reseaucitoyen
> project to test Batman.
>
> Our configuration was 4 laptops like this:
>
> laptop1 <----ethernet----> laptop2
> +                                               +
> +                                               +
> +                                               +
> wlan1                                    wlan11
> +                                               +
> +                                               +
> +                                               +
> laptop3 <----ethernet----> laptop4
>
> With 8 different IPs for the 8 interfaces.
>
> We launched batman-0.10 on all the nodes, but it appeared that one of
> the interfaces was not reachable via ping. And the experience was
> reproductible when we restarted the dameon, sometimes with a different
> IP unreachable.
>
> We are going to test the same configuration soon to see if batman
> chooses the fastest route in terms of throughput.
>
> Best,
>
> --
> Benjamin Henrion <bhenrion at ffii.org>
> FFII Brussels - +32-484-566109 - +32-2-4148403
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n

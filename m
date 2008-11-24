From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] BATMAN routing (via gate0)
Date: Mon, 24 Nov 2008 10:24:00 +0800
References: <57356.149.5.32.200.1227370855.squirrel@www.rivertowermail.com>
	<20081123121627.GA15419@pandem0nium>
	<53187.149.5.32.200.1227469817.squirrel@www.rivertowermail.com>
In-Reply-To: <53187.149.5.32.200.1227469817.squirrel@www.rivertowermail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200811241024.01650.lindner_marek@yahoo.de>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


Hey,

> How does the routing work for inter-node communications for > 1 hop
> neighbors?
>
> If the gate0 tunnel is the default route for Internet communications how
> does a node know how to talk to a node two hops (or more) away (that
> doesn't go though the gate0 tunnel)?
>
> I can understand how it works with OLSRd because each node has a big
> routing table but I'm still confused about how BATMAN does it

Batman also has a "big" routing table - nothing is different to OLSR (in this 
aspect). To get information about the routing tables read here:
https://dev.open-mesh.net/batman/wiki/RoutingVodoo

The major difference to OLSR is that batman does not know every single step 
towards the final node. Consider this example:

source node -> neighbour1 -> neighbour2 -> destination

The source node will have a routing entry for the destination in its routing 
table which says "use neighbour1 as next hop". In that very moment the source 
node does not know how neighbour1 will route the packets. It simply assumes 
that neighbour1 knows the following step. Once the packet arrives at 
neighbour1 it will get forwarded according to the routing table of neighbour1 
until it arrives neighbour2 and then the destination.

Why does it work that way ?
We think its impossible to keep all nodes of the network in sync about all 
routing changes between all the nodes. If some nodes are out of sync you will 
encounter routing loops. Furthermore, it does not make sense to know the whole 
path because every node can send the packets to its neighbours only. Once the 
packet leaves the host it can't be influenced anymore. Your neighbour may have 
a totally different view regarding the routing and will send the packet into 
another direction. Neighbour2 even does not know what neighbour1 considered 
being the best route.


> This is the bit I don't understand - I thought that range mentioned by
> Marek did mean radio range for local (one hop) neighbors.

Ok, thanks Simon for clarifying that.  :-)

Regards,
Marek


Message-Id: <90C733EE-D757-431F-85EA-765257488668@mac.com>
From: Andrew de Andrade <andrew.de.andrade@mac.com>
In-Reply-To: <200905131825.39007.lindner_marek@yahoo.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v930.3)
Date: Wed, 13 May 2009 16:33:23 -0300
References: <1240609318-18133-1-git-send-email-sven.eckelmann@gmx.de>
	<200905131825.39007.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] Has anyone considered the addition of GPS in BATMAN?
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hello all, I'm new to the BATMAN project and have only been following  
it a short while, but I was curious if any thought had been given to  
having B.A.T.M.A.N. use GPS data to aid in calculating best routes  
through a network.

i.e. once a node joins the mesh network, it not only broadcasts its  
presence and who it is connected to, but also it's physical location,  
assuming it has a GPS dongle connected to it.

The way I see it, only a few nodes in the network would need to be GPS  
capable to greatly increase the ability to calculate a route through  
the network.

Using response time to its closest neighbors, a node theoretically  
would only need to be connected to three other nodes the are GPS  
capable to triangulate its location. Once this node has triangulated  
its location it could then broadcast it to the rest of the network,  
thereby aiding other nodes figure out where they are located.

So long as each location-aware node is connected to at least 3 other  
nodes on average and assuming they are fairly evenly distributed,  
every node in the network with at least three links should be able to  
calculate it's location.

This location awareness plus congestion (node health) data would  
increase the efficiency of calculating the network topology at each  
node, and calculating the most efficient route to route the data.

Anyways, just an idea. As I said, I'm new here and will try to  
contribute where I can.

Andrew


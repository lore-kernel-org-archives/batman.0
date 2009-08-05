Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 5 Aug 2009 19:31:06 +0800
References: <200908051533.26117.lindner_marek@yahoo.de>
	<SNT107-W1743C6216DE9D4A6F5A50BA60D0@phx.gbl>
In-Reply-To: <SNT107-W1743C6216DE9D4A6F5A50BA60D0@phx.gbl>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200908051931.10324.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Routing help?
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


Hi,

> I had thought that as they all on the same subnet and bridged that this
> would be sufficient just relying on standard arps across the entire network
> as there is no routing. On this basis I assumed there is no need to
> announce any networks/hosts. Is this a correct understanding?

for this to work .1, .2 and .3 would need to rebroadcast the ARP requests. In 
a normal wifi ad-hoc network this will not happen. Also, in a ordinary ethernet 
network no router will rebroadcast ARP requests.

Basically, you can solve this in two different ways:
* You use routing and flood the network with IP addresses using the batman 
daemon.
* You create a bridge over the whole setup using batman advanced (batman-adv 
will handle the ARP rebroadcast).

Regards,
Marek


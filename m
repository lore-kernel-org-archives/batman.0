Message-ID: <6fc7e744ebfbdddaff4637bb5451544d.squirrel@wm.ddmesh.de>
In-Reply-To: <200812191115.20610.neumann@cgws.de>
References: <83b3410f8105237b1e68c92065dec7d0.squirrel@wm.ddmesh.de>
	<200812172114.43427.neumann@cgws.de>
	<3f7879383457743711ac3341637ff601.squirrel@wm.ddmesh.de>
	<200812191115.20610.neumann@cgws.de>
Date: Fri, 19 Dec 2008 12:19:40 +0100 (CET)
From: "Stephan Enderlein (Freifunk Dresden)" <freifunk@ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] dublicate HNAs / certificates
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


Hi again,

is there a way to set a TTL value for each hna that is different from OGM TTL?
If I assume that an HNA internet host is reachable via two nodes (e.g. running icvpn - bgp)
batmand currently ignores one of this hna and also the node and its traffic (right?).

What if we use the ttl value as metric to decide which hna is used? In this
case both nodes are still present in network but you don't have a address conflict.
Batman should not accept HNA that belongs to the ipranges of the batman network.
So a node with ip 10.12.0.1 can not send a HNA with 10.12.10.17 and disturbing the
routing. Perhaps batmand already checks this?

/stephan


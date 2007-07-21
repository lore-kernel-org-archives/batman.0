Message-ID: <46A21D01.3000406@ddmesh.de>
Date: Sat, 21 Jul 2007 16:49:37 +0200
From: Freifunk Dresden <freifunk@ddmesh.de>
MIME-Version: 1.0
References: <200707211000.l6LA02R6018086@open-mesh.net>
In-Reply-To: <200707211000.l6LA02R6018086@open-mesh.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] Re: TTL-Interface specific
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

Hello,

thanks for your explainations. Of cource I mean processes instead of
"instances".
As setting up a TTL per interface and per command line you may extent
the interface name like the following examble:
batmand eth1:32 bbs:2 bbc

which could mean to setup the eth1 with TTL 32, bbs with TTL 2 and bbc
with the default TTL value.

Question: the olsrd allows to send a list of services (http,ftp)
provided by the node. Is there a way to send such messages with batmand?

Regards
 Stephan

Message-ID: <36260.159.213.72.82.1190373036.squirrel@krisma.oltrelinux.com>
Date: Fri, 21 Sep 2007 13:10:36 +0200 (CEST)
From: a.anselmi@oltrelinux.com
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] batman 0.3-exp-rv623
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

Hi,

I use 0.3-exp-rv623 and looking at d3 debug on gateway it seems work:
gateway assign an ip to a client which wants an outdoor connection:

Gateway - assigned 1.0.254.169 to client 5.1.8.5

client 5.1.8.5 well see its gateway: I've tried issuing:
batmand -c -d 2 -b

...all is ok but client don't browse internet, it never reach any outdoor IP!

The 2 nodes run batman as:
(at gateway) batmand --bmx-default -g 5000 ath0
(at client)  batmand --bmx-default -r 3 ath0

and see eachother so I believe is not a firewall problem...

From a second ssh session at client, I see no default route is assigned
(issuing ip route show) while node is trying to ping outside the mesh: I
really do not understand why... issuing a logread at repeater I see:

Trying to name tunnel to bat0 ...
success!

but no default route is set

Where I'm wrong?
Where I can see on debug in order to fix problem?
I've to change something in batman arguments string ?


Antonio


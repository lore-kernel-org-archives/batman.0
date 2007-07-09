Message-ID: <59806.85.41.146.90.1183999326.squirrel@krisma.oltrelinux.com>
Date: Mon, 9 Jul 2007 18:42:06 +0200 (CEST)
From: a.anselmi@oltrelinux.com
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] originator timeout
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

I'm testing batmand 0.2 in two hardware-different nodes:
6.17.0.1/8 is a Fonera running its standard firmware
6.17.190.172/8 is a Fonera running Kamikaze

From kamikaze(d) node I see:

Received BATMAN packet via NB: 6.17.0.1, IF: ath0 6.17.190.172 (from OG:
6.17.0.1, seqno 926, TTL 50, V 3, UDF 0, IDF 0)
Creating new originator: 6.17.0.1
schedule_forward_packet():
Forward packet: rebroadcast neighbour packet with direct link and
unidirectional flag
Forwarding packet (originator 6.17.0.1, seqno 926, TTL 49) on interface ath0
Orginator timeout: originator 6.17.0.1, last_valid 0
update_routes()

but the same node, issuing the command "batmand -c -d 1 -b" tells me "No
batman nodes in range".
I'm afraid of the message "Orginator timeout: originator 6.17.0.1" in the
above lines... is this the problem?

--
Antonio



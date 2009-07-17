Return-Path: <andrew.lunn@ascom.ch>
Date: Fri, 17 Jul 2009 12:57:27 +0200
From: Andrew Lunn <andrew.lunn@ascom.ch>
Message-ID: <20090717105727.GA32143@ma.tech.ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [batctl] Fix compiler warning in tcpdump.c
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
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>

Compiling batctl/tcpdump.c with gcc version 4.3.3 gives a compiler
warning. Add a cast to fix this.

Signed-off-by: Andrew Lunn <andrew.lunn@ascom.ch>
Index: batctl/tcpdump.c
===================================================================
--- batctl/tcpdump.c	(revision 1347)
+++ batctl/tcpdump.c	(working copy)
@@ -191,7 +191,7 @@
 
 		switch (ntohs(udphdr->dest)) {
 		case 67:
-			LEN_CHECK((size_t)buff_len - (iphdr->ihl * 4) - sizeof(struct udphdr), 44, "DHCP");
+                        LEN_CHECK((size_t)buff_len - (iphdr->ihl * 4) - sizeof(struct udphdr), (size_t) 44, "DHCP");
 			printf("%s.67: BOOTP/DHCP, Request from %s, length %zd\n",
 				inet_ntoa(*(struct in_addr *)&iphdr->daddr),
 				ether_ntoa_long((struct ether_addr *)(((char *)udphdr) + sizeof(struct udphdr) + 28)),

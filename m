Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 30 Oct 2010 17:00:53 +0200
Message-Id: <1288450858-14753-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/6] batctl: Correct format strings for 8 bit
	ttl
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batctl/tcpdump.c    |    4 ++--
 batctl/traceroute.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/batctl/tcpdump.c b/batctl/tcpdump.c
index 0f62e65..8898cf8 100644
--- a/batctl/tcpdump.c
+++ b/batctl/tcpdump.c
@@ -335,7 +335,7 @@ static void dump_batman_ucast(unsigned char *packet_buff, ssize_t buff_len, int
 	printf("BAT %s > ",
 	       get_name_by_macaddr((struct ether_addr *)ether_header->ether_shost, read_opt));
 
-	printf("%s: UCAST, ttl %hu, ",
+	printf("%s: UCAST, ttl %hhu, ",
 	       get_name_by_macaddr((struct ether_addr *)unicast_packet->dest, read_opt),
 	       unicast_packet->ttl);
 
@@ -388,7 +388,7 @@ static void dump_batman_frag(unsigned char *packet_buff, ssize_t buff_len, int r
 	printf("BAT %s > ",
 	       get_name_by_macaddr((struct ether_addr *)unicast_frag_packet->orig, read_opt));
 
-	printf("%s: FRAG, seq %hu, ttl %hu, flags [%c], ",
+	printf("%s: FRAG, seq %hu, ttl %hhu, flags [%c], ",
 	       get_name_by_macaddr((struct ether_addr *)unicast_frag_packet->dest, read_opt),
 	       ntohs(unicast_frag_packet->seqno), unicast_frag_packet->ttl,
 	       (unicast_frag_packet->flags & UNI_FRAG_HEAD ? 'H' : '.'));
diff --git a/batctl/traceroute.c b/batctl/traceroute.c
index dc97a01..0dc796a 100644
--- a/batctl/traceroute.c
+++ b/batctl/traceroute.c
@@ -199,9 +199,9 @@ int traceroute(char *mesh_iface, int argc, char **argv)
 		}
 
 		if (!bat_host)
-			printf("%2hu: %s", icmp_packet_out.ttl, (return_mac ? return_mac : "*"));
+			printf("%2hhu: %s", icmp_packet_out.ttl, (return_mac ? return_mac : "*"));
 		else
-			printf("%2hu: %s (%s)",	icmp_packet_out.ttl, bat_host->name, return_mac);
+			printf("%2hhu: %s (%s)", icmp_packet_out.ttl, bat_host->name, return_mac);
 
 		for (i = 0; i < NUM_PACKETS; i++) {
 			if (time_delta[i])
-- 
1.7.2.3


Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 26 Jan 2011 15:28:33 +0100
Message-Id: <1296052113-5983-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: tcpdump - support LARGETAIL flag
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 batctl/tcpdump.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/batctl/tcpdump.c b/batctl/tcpdump.c
index bdf81bc..09a7e16 100644
--- a/batctl/tcpdump.c
+++ b/batctl/tcpdump.c
@@ -385,10 +385,11 @@ static void dump_batman_frag(unsigned char *packet_buff, ssize_t buff_len, int r
 	printf("BAT %s > ",
 	       get_name_by_macaddr((struct ether_addr *)unicast_frag_packet->orig, read_opt));
 
-	printf("%s: FRAG, seq %hu, ttl %hhu, flags [%c], ",
+	printf("%s: FRAG, seq %hu, ttl %hhu, flags [%c%c], ",
 	       get_name_by_macaddr((struct ether_addr *)unicast_frag_packet->dest, read_opt),
 	       ntohs(unicast_frag_packet->seqno), unicast_frag_packet->ttl,
-	       (unicast_frag_packet->flags & UNI_FRAG_HEAD ? 'H' : '.'));
+	       (unicast_frag_packet->flags & UNI_FRAG_HEAD ? 'H' : '.'),
+	       (unicast_frag_packet->flags & UNI_FRAG_LARGETAIL ? 'L' : '.'));
 
 	if (unicast_frag_packet->flags & UNI_FRAG_HEAD)
 		parse_eth_hdr(packet_buff + ETH_HLEN + sizeof(struct unicast_frag_packet),
-- 
1.7.2.3


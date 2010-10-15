Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 15 Oct 2010 17:43:37 +0200
Message-Id: <1287157417-15369-3-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1287157417-15369-1-git-send-email-lindner_marek@yahoo.de>
References: <1287157417-15369-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: process OGMs bigger than
	MAX_AGGREGATION_BYTES
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

Reported-by: Sam Yeung <sam.cwyeung@gmail.com>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 batman-adv/aggregation.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/batman-adv/aggregation.c b/batman-adv/aggregation.c
index 16b268e..08624d4 100644
--- a/batman-adv/aggregation.c
+++ b/batman-adv/aggregation.c
@@ -257,9 +257,7 @@ void receive_aggr_bat_packet(struct ethhdr *ethhdr, unsigned char *packet_buff,
 
 	batman_packet = (struct batman_packet *)packet_buff;
 
-	while (aggregated_packet(buff_pos, packet_len,
-				 batman_packet->num_hna)) {
-
+	do {
 		/* network to host order for our 32bit seqno, and the
 		   orig_interval. */
 		batman_packet->seqno = ntohl(batman_packet->seqno);
@@ -272,5 +270,6 @@ void receive_aggr_bat_packet(struct ethhdr *ethhdr, unsigned char *packet_buff,
 		buff_pos += BAT_PACKET_LEN + hna_len(batman_packet);
 		batman_packet = (struct batman_packet *)
 			(packet_buff + buff_pos);
-	}
+	} while (aggregated_packet(buff_pos, packet_len,
+				   batman_packet->num_hna));
 }
-- 
1.7.1


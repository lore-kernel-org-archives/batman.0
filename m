Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon,  4 Mar 2013 10:43:30 +0800
Message-Id: <1362365010-21698-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: verify whether tt len exceeds
	packet len upon receipt of OGM
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 bat_iv_ogm.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 7654b76..99cab3b 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -1272,7 +1272,7 @@ static int batadv_iv_ogm_receive(struct sk_buff *skb,
 	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct batadv_ogm_packet *batadv_ogm_packet;
 	struct ethhdr *ethhdr;
-	int buff_pos = 0, packet_len;
+	int buff_pos = 0, tt_len, packet_len;
 	unsigned char *tt_buff, *packet_buff;
 	bool ret;
 	uint8_t *packet_pos;
@@ -1298,14 +1298,17 @@ static int batadv_iv_ogm_receive(struct sk_buff *skb,
 
 	/* unpack the aggregated packets and process them one by one */
 	do {
+		tt_len = batadv_tt_len(batadv_ogm_packet->tt_num_changes);
+
+		if (buff_pos + BATADV_OGM_HLEN + tt_len > packet_len)
+			break;
+
 		tt_buff = packet_buff + buff_pos + BATADV_OGM_HLEN;
 
 		batadv_iv_ogm_process(ethhdr, batadv_ogm_packet, tt_buff,
 				      if_incoming);
 
-		buff_pos += BATADV_OGM_HLEN;
-		buff_pos += batadv_tt_len(batadv_ogm_packet->tt_num_changes);
-
+		buff_pos += BATADV_OGM_HLEN + tt_len;
 		packet_pos = packet_buff + buff_pos;
 		batadv_ogm_packet = (struct batadv_ogm_packet *)packet_pos;
 	} while (batadv_iv_ogm_aggr_packet(buff_pos, packet_len,
-- 
1.7.10.4


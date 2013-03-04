Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon,  4 Mar 2013 20:26:05 +0800
Message-Id: <1362399965-4843-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: verify tt len does not exceed
	packet len
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

v2:
 - simplified approach of same check

 bat_iv_ogm.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 7654b76..2ce7b28 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -1297,7 +1297,8 @@ static int batadv_iv_ogm_receive(struct sk_buff *skb,
 	batadv_ogm_packet = (struct batadv_ogm_packet *)packet_buff;
 
 	/* unpack the aggregated packets and process them one by one */
-	do {
+	while (batadv_iv_ogm_aggr_packet(buff_pos, packet_len,
+					 batadv_ogm_packet->tt_num_changes)) {
 		tt_buff = packet_buff + buff_pos + BATADV_OGM_HLEN;
 
 		batadv_iv_ogm_process(ethhdr, batadv_ogm_packet, tt_buff,
@@ -1308,8 +1309,7 @@ static int batadv_iv_ogm_receive(struct sk_buff *skb,
 
 		packet_pos = packet_buff + buff_pos;
 		batadv_ogm_packet = (struct batadv_ogm_packet *)packet_pos;
-	} while (batadv_iv_ogm_aggr_packet(buff_pos, packet_len,
-					   batadv_ogm_packet->tt_num_changes));
+	}
 
 	kfree_skb(skb);
 	return NET_RX_SUCCESS;
-- 
1.7.10.4


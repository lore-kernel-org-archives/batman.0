Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 26 May 2013 06:15:21 +0800
Message-Id: <1369520121-5998-2-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1369520121-5998-1-git-send-email-lindner_marek@yahoo.de>
References: <1369520121-5998-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: properly align roaming tvlv
	container
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

4bytes long members must start at an address multiple of 4
in order to avoid unaligned memory access.

Introduced by 3de4e64df0f1326db7cc0ef25f5af8522850252d
"batman-adv: tvlv - convert roaming adv packet to use
tvlv unicast packets"

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 packet.h            |    4 +++-
 translation-table.c |    1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/packet.h b/packet.h
index 840d73d..22494f7 100644
--- a/packet.h
+++ b/packet.h
@@ -389,9 +389,11 @@ struct batadv_tvlv_tt_change {
 /**
  * struct batadv_tvlv_roam_adv - roaming advertisement
  * @client: mac address of roaming client
+ * @reserved: field reserved for future use
  */
 struct batadv_tvlv_roam_adv {
-	uint8_t client[ETH_ALEN];
+	uint8_t  client[ETH_ALEN];
+	uint16_t reserved;
 };
 
 #endif /* _NET_BATMAN_ADV_PACKET_H_ */
diff --git a/translation-table.c b/translation-table.c
index 44e7789..d53c212 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -2208,6 +2208,7 @@ static void batadv_send_roam_adv(struct batadv_priv *bat_priv, uint8_t *client,
 	batadv_inc_counter(bat_priv, BATADV_CNT_TT_ROAM_ADV_TX);
 
 	memcpy(tvlv_roam.client, client, sizeof(tvlv_roam.client));
+	tvlv_roam.reserved = 0;
 
 	batadv_tvlv_unicast_send(bat_priv, primary_if->net_dev->dev_addr,
 				 orig_node->orig, BATADV_TVLV_ROAM, 1,
-- 
1.7.10.4


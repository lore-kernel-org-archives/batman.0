Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 14 Jul 2012 01:41:50 +0200
Message-Id: <1342222910-20627-9-git-send-email-ordex@autistici.org>
In-Reply-To: <1342222910-20627-1-git-send-email-ordex@autistici.org>
References: <1342222910-20627-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv9 8/8] batman-adv: Add get_ethtool_stats()
	support for DAT
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
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>

From: Martin Hundebøll <martin@hundeboll.net>

Added additional counters for D.A.T.

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 distributed-arp-table.c |   17 +++++++++++++++--
 soft-interface.c        |    7 +++++++
 types.h                 |    7 +++++++
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 40d61c6..57f6f49 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -605,9 +605,20 @@ static bool batadv_dht_send_data(struct batadv_priv *bat_priv,
 		send_status = batadv_send_skb_packet(tmp_skb,
 						     neigh_node->if_incoming,
 						     neigh_node->addr);
-		if (send_status == NET_XMIT_SUCCESS)
+		if (send_status == NET_XMIT_SUCCESS) {
+			/* count the sent packet */
+			switch (packet_subtype) {
+			case BATADV_P_DAT_DHT_GET:
+				batadv_inc_counter(bat_priv,
+						   BATADV_CNT_DAT_REQUEST_TX);
+			case BATADV_P_DAT_DHT_PUT:
+				batadv_inc_counter(bat_priv,
+						   BATADV_CNT_DAT_REPLY_TX);
+			}
+
 			/* packet sent to a candidate: we can return true */
 			ret = true;
+		}
 free_neigh:
 		batadv_neigh_node_free_ref(neigh_node);
 free_orig:
@@ -947,8 +958,10 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 	else
 		err = batadv_unicast_send_skb(skb_new, bat_priv);
 
-	if (!err)
+	if (!err) {
+		batadv_inc_counter(bat_priv, BATADV_CNT_DAT_CACHED_REPLY_TX);
 		ret = true;
+	}
 out:
 	if (dat_entry)
 		batadv_dat_entry_free_ref(dat_entry);
diff --git a/soft-interface.c b/soft-interface.c
index b881e34..0dae7e9 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -565,6 +565,13 @@ static const struct {
 	{ "tt_response_rx" },
 	{ "tt_roam_adv_tx" },
 	{ "tt_roam_adv_rx" },
+#ifdef CONFIG_BATMAN_ADV_DAT
+	{ "dat_request_tx" },
+	{ "dat_request_rx" },
+	{ "dat_reply_tx" },
+	{ "dat_reply_rx" },
+	{ "dat_cached_reply_tx" },
+#endif
 };
 
 static void batadv_get_strings(struct net_device *dev, uint32_t stringset,
diff --git a/types.h b/types.h
index 8ffdf5f..bc194bc 100644
--- a/types.h
+++ b/types.h
@@ -175,6 +175,13 @@ enum batadv_counters {
 	BATADV_CNT_TT_RESPONSE_RX,
 	BATADV_CNT_TT_ROAM_ADV_TX,
 	BATADV_CNT_TT_ROAM_ADV_RX,
+#ifdef CONFIG_BATMAN_ADV_DAT
+	BATADV_CNT_DAT_REQUEST_TX,
+	BATADV_CNT_DAT_REQUEST_RX,
+	BATADV_CNT_DAT_REPLY_TX,
+	BATADV_CNT_DAT_REPLY_RX,
+	BATADV_CNT_DAT_CACHED_REPLY_TX,
+#endif
 	BATADV_CNT_NUM,
 };
 
-- 
1.7.9.4


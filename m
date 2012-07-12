Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 12 Jul 2012 22:35:27 +0200
Message-Id: <1342125327-11676-9-git-send-email-ordex@autistici.org>
In-Reply-To: <1342125327-11676-1-git-send-email-ordex@autistici.org>
References: <1342125327-11676-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv8 8/8] batman-adv: Add get_ethtool_stats()
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
 distributed-arp-table.c |    5 +++++
 soft-interface.c        |    6 ++++++
 types.h                 |    6 ++++++
 3 files changed, 17 insertions(+)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index cb3f709..f8fed0b 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -729,6 +729,7 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 		ret = true;
 	} else {
 		/* Send the request on the DHT */
+		batadv_inc_counter(bat_priv, BATADV_CNT_DAT_REQUEST_TX);
 		ret = batadv_dht_send_data(bat_priv, skb, ip_dst,
 					   BATADV_P_DAT_DHT_GET);
 	}
@@ -785,6 +786,8 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 	if (!skb_new)
 		goto out;
 
+	batadv_inc_counter(bat_priv, BATADV_CNT_DAT_REPLY_TX);
+
 	/* to preserve backwards compatibility, here we have to answer using
 	 * the same packet type we received for the request. This is due to
 	 * that if a node is not using the 4addr packet format it may not
@@ -833,6 +836,8 @@ bool batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
 	batadv_dat_entry_add(bat_priv, ip_src, hw_src);
 	batadv_dat_entry_add(bat_priv, ip_dst, hw_dst);
 
+	batadv_inc_counter(bat_priv, BATADV_CNT_DAT_REPLY_TX);
+
 	/* Send the ARP reply to the candidates for both the IP addresses we
 	 * fetched from the ARP reply
 	 */
diff --git a/soft-interface.c b/soft-interface.c
index b881e34..942c4c5 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -565,6 +565,12 @@ static const struct {
 	{ "tt_response_rx" },
 	{ "tt_roam_adv_tx" },
 	{ "tt_roam_adv_rx" },
+#ifdef CONFIG_BATMAN_ADV_DAT
+	{ "dat_request_tx" },
+	{ "dat_request_rx" },
+	{ "dat_reply_tx" },
+	{ "dat_reply_rx" },
+#endif
 };
 
 static void batadv_get_strings(struct net_device *dev, uint32_t stringset,
diff --git a/types.h b/types.h
index 8ffdf5f..261c520 100644
--- a/types.h
+++ b/types.h
@@ -175,6 +175,12 @@ enum batadv_counters {
 	BATADV_CNT_TT_RESPONSE_RX,
 	BATADV_CNT_TT_ROAM_ADV_TX,
 	BATADV_CNT_TT_ROAM_ADV_RX,
+#ifdef CONFIG_BATMAN_ADV_DAT
+	BATADV_CNT_DAT_REQUEST_TX,
+	BATADV_CNT_DAT_REQUEST_RX,
+	BATADV_CNT_DAT_REPLY_TX,
+	BATADV_CNT_DAT_REPLY_RX,
+#endif
 	BATADV_CNT_NUM,
 };
 
-- 
1.7.9.4


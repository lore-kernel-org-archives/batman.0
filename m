Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun,  5 Jun 2011 23:01:04 +0200
Message-Id: <1307307664-19910-4-git-send-email-ordex@autistici.org>
In-Reply-To: <1307307664-19910-1-git-send-email-ordex@autistici.org>
References: <1307307664-19910-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: implement AP-isolation on
	the receiver side
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
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

When a node receives a unicast packet it checks if the source and the
destination client can communicate or not due to the AP isolation

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 soft-interface.c    |    3 +++
 translation-table.c |   30 ++++++++++++++++++++++++++++++
 translation-table.h |    1 +
 3 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/soft-interface.c b/soft-interface.c
index 6489665..714a2af 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -733,6 +733,9 @@ void interface_rx(struct net_device *soft_iface,
 
 	soft_iface->last_rx = jiffies;
 
+	if (is_ap_isolated(bat_priv, ethhdr->h_source, ethhdr->h_dest))
+		goto dropped;
+
 	netif_rx(skb);
 	goto out;
 
diff --git a/translation-table.c b/translation-table.c
index e0c5945..24e48e7 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1683,3 +1683,33 @@ void tt_free(struct bat_priv *bat_priv)
 
 	kfree(bat_priv->tt_buff);
 }
+
+bool is_ap_isolated(struct bat_priv *bat_priv, uint8_t *src, uint8_t *dst)
+{
+	struct tt_local_entry *tt_local_entry = NULL;
+	struct tt_global_entry *tt_global_entry = NULL;
+	bool ret = true;
+
+	if (!atomic_read(&bat_priv->ap_isolation))
+		return false;
+
+	tt_local_entry = tt_local_hash_find(bat_priv, dst);
+	if (!tt_local_entry)
+		goto out;
+
+	tt_global_entry = tt_global_hash_find(bat_priv, src);
+	if (!tt_global_entry)
+		goto out;
+
+	if (_is_ap_isolated(tt_local_entry, tt_global_entry))
+		goto out;
+
+	ret = false;
+
+out:
+	if (tt_global_entry)
+		tt_global_entry_free_ref(tt_global_entry);
+	if (tt_local_entry)
+		tt_local_entry_free_ref(tt_local_entry);
+	return ret;
+}
diff --git a/translation-table.h b/translation-table.h
index 3055b8b..8080153 100644
--- a/translation-table.h
+++ b/translation-table.h
@@ -67,5 +67,6 @@ void handle_tt_response(struct bat_priv *bat_priv,
 			struct tt_query_packet *tt_response);
 void send_roam_adv(struct bat_priv *bat_priv, uint8_t *client,
 		   struct orig_node *orig_node);
+bool is_ap_isolated(struct bat_priv *bat_priv, uint8_t *src, uint8_t *dst);
 
 #endif /* _NET_BATMAN_ADV_TRANSLATION_TABLE_H_ */
-- 
1.7.3.4


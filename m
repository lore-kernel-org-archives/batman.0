Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun,  5 Jun 2011 23:01:02 +0200
Message-Id: <1307307664-19910-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1307307664-19910-1-git-send-email-ordex@autistici.org>
References: <1307307664-19910-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: detect clients connected
	through a 802.11 device
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

Clients connected through a 802.11 device are now marked with the
TT_CLIENT_WIFI flag. This flag is also advertised with the tt
announcement.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 compat.h            |    2 +
 main.c              |    2 +-
 packet.h            |    3 +-
 routing.c           |    2 +-
 soft-interface.c    |    4 +-
 translation-table.c |   59 ++++++++++++++++++++++++++++++++++++++++----------
 translation-table.h |   17 +++++++++-----
 types.h             |    2 +-
 8 files changed, 67 insertions(+), 24 deletions(-)

diff --git a/compat.h b/compat.h
index 66a8adc..f1965d0 100644
--- a/compat.h
+++ b/compat.h
@@ -263,6 +263,8 @@ int bat_seq_printf(struct seq_file *m, const char *f, ...);
 
 #define __always_unused			__attribute__((unused))
 
+#define skb_iif iif
+
 #endif /* < KERNEL_VERSION(2, 6, 33) */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 34)
diff --git a/main.c b/main.c
index c2b06b7..9f3ff52 100644
--- a/main.c
+++ b/main.c
@@ -108,7 +108,7 @@ int mesh_init(struct net_device *soft_iface)
 	if (tt_init(bat_priv) < 1)
 		goto err;
 
-	tt_local_add(soft_iface, soft_iface->dev_addr);
+	tt_local_add(soft_iface, soft_iface->dev_addr, 0);
 
 	if (vis_init(bat_priv) < 1)
 		goto err;
diff --git a/packet.h b/packet.h
index 0c3e44d..d1bbdbc 100644
--- a/packet.h
+++ b/packet.h
@@ -75,7 +75,8 @@ enum tt_query_flags {
 /* TT_CHANGE flags */
 enum tt_change_flags {
 	TT_CHANGE_DEL  = 0x01,
-	TT_CLIENT_ROAM = 0x02
+	TT_CLIENT_ROAM = 0x02,
+	TT_CLIENT_WIFI = 0x04
 };
 
 struct batman_packet {
diff --git a/routing.c b/routing.c
index c620d4f..70c39dd 100644
--- a/routing.c
+++ b/routing.c
@@ -1290,7 +1290,7 @@ int recv_roam_adv(struct sk_buff *skb, struct hard_iface *recv_if)
 		roam_adv_packet->client);
 
 	tt_global_add(bat_priv, orig_node, roam_adv_packet->client,
-		      atomic_read(&orig_node->last_ttvn) + 1, true);
+		      atomic_read(&orig_node->last_ttvn) + 1, true, false);
 
 	/* Roaming phase starts: I have new information but the ttvn has not
 	 * been incremented yet. This flag will make me check all the incoming
diff --git a/soft-interface.c b/soft-interface.c
index b268f85..60234af 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -535,7 +535,7 @@ static int interface_set_mac_addr(struct net_device *dev, void *p)
 	if (atomic_read(&bat_priv->mesh_state) == MESH_ACTIVE) {
 		tt_local_remove(bat_priv, dev->dev_addr,
 				"mac address changed", false);
-		tt_local_add(dev, addr->sa_data);
+		tt_local_add(dev, addr->sa_data, 0);
 	}
 
 	memcpy(dev->dev_addr, addr->sa_data, ETH_ALEN);
@@ -593,7 +593,7 @@ int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 		goto dropped;
 
 	/* Register the client MAC in the transtable */
-	tt_local_add(soft_iface, ethhdr->h_source);
+	tt_local_add(soft_iface, ethhdr->h_source, skb->skb_iif);
 
 	if (is_multicast_ether_addr(ethhdr->h_dest)) {
 		ret = gw_is_target(bat_priv, skb);
diff --git a/translation-table.c b/translation-table.c
index d2a9f80..1d4c34c 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -144,7 +144,7 @@ static void tt_global_entry_free_ref(struct tt_global_entry *tt_global_entry)
 }
 
 static void tt_local_event(struct bat_priv *bat_priv, uint8_t op,
-			   const uint8_t *addr, bool roaming)
+			   const uint8_t *addr, bool roaming, bool wifi)
 {
 	struct tt_change_node *tt_change_node;
 
@@ -158,6 +158,9 @@ static void tt_local_event(struct bat_priv *bat_priv, uint8_t op,
 	if (roaming)
 		tt_change_node->change.flags |= TT_CLIENT_ROAM;
 
+	if (wifi)
+		tt_change_node->change.flags |= TT_CLIENT_WIFI;
+
 	memcpy(tt_change_node->change.addr, addr, ETH_ALEN);
 
 	spin_lock_bh(&bat_priv->tt_changes_list_lock);
@@ -187,7 +190,31 @@ static int tt_local_init(struct bat_priv *bat_priv)
 	return 1;
 }
 
-void tt_local_add(struct net_device *soft_iface, const uint8_t *addr)
+/* This function check whether the interface represented by ifindex is a
+ * 802.11 wireless device or not. If so the tt_local_entry is marked with the
+ * TT_CLIENT_WIFI flag */
+static void tt_check_iface(struct tt_local_entry *tt_local_entry, int ifindex)
+{
+	struct net_device *net_device;
+
+	net_device = dev_get_by_index(&init_net, ifindex);
+	if (!net_device)
+		return;
+
+#ifdef CONFIG_WIRELESS_EXT
+	/* pre-cfg80211 driver have to implement WEXT, so it is possible to
+	 * check for wireless_handlers != NULL */
+	if (net_device->wireless_handlers)
+		tt_local_entry->flags |= TT_CLIENT_WIFI;
+	else
+#endif
+		/* cfg80211 drivers have to set ieee80211_ptr */
+		if (net_device->ieee80211_ptr)
+			tt_local_entry->flags |= TT_CLIENT_WIFI;
+}
+
+void tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
+		  int ifindex)
 {
 	struct bat_priv *bat_priv = netdev_priv(soft_iface);
 	struct tt_local_entry *tt_local_entry = NULL;
@@ -204,21 +231,22 @@ void tt_local_add(struct net_device *soft_iface, const uint8_t *addr)
 	if (!tt_local_entry)
 		goto out;
 
-	tt_local_event(bat_priv, NO_FLAGS, addr, false);
-
 	bat_dbg(DBG_TT, bat_priv,
 		"Creating new local tt entry: %pM (ttvn: %d)\n", addr,
 		(uint8_t)atomic_read(&bat_priv->ttvn));
 
 	memcpy(tt_local_entry->addr, addr, ETH_ALEN);
 	tt_local_entry->last_seen = jiffies;
+	tt_local_entry->flags = 0;
+	tt_check_iface(tt_local_entry, ifindex);
 	atomic_set(&tt_local_entry->refcount, 2);
 
 	/* the batman interface mac address should never be purged */
 	if (compare_eth(addr, soft_iface->dev_addr))
-		tt_local_entry->never_purge = 1;
-	else
-		tt_local_entry->never_purge = 0;
+		tt_local_entry->flags |= TT_LOCAL_NOPURGE;
+
+	tt_local_event(bat_priv, NO_FLAGS, addr, false,
+		       tt_local_entry->flags & TT_CLIENT_WIFI);
 
 	hash_add(bat_priv->tt_local_hash, compare_ltt, choose_orig,
 		 tt_local_entry, &tt_local_entry->hash_entry);
@@ -388,7 +416,8 @@ void tt_local_remove(struct bat_priv *bat_priv, const uint8_t *addr,
 	if (!tt_local_entry)
 		goto out;
 
-	tt_local_event(bat_priv, TT_CHANGE_DEL, tt_local_entry->addr, roaming);
+	tt_local_event(bat_priv, TT_CHANGE_DEL, tt_local_entry->addr, roaming,
+		       false);
 	tt_local_del(bat_priv, tt_local_entry, message);
 out:
 	if (tt_local_entry)
@@ -411,7 +440,7 @@ static void tt_local_purge(struct bat_priv *bat_priv)
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(tt_local_entry, node, node_tmp,
 					  head, hash_entry) {
-			if (tt_local_entry->never_purge)
+			if (tt_local_entry->flags & TT_LOCAL_NOPURGE)
 				continue;
 
 			if (!is_out_of_time(tt_local_entry->last_seen,
@@ -419,7 +448,7 @@ static void tt_local_purge(struct bat_priv *bat_priv)
 				continue;
 
 			tt_local_event(bat_priv, TT_CHANGE_DEL,
-				       tt_local_entry->addr, false);
+				       tt_local_entry->addr, false, false);
 			atomic_dec(&bat_priv->num_local_tt);
 			bat_dbg(DBG_TT, bat_priv, "Deleting local "
 				"tt entry (%pM): timed out\n",
@@ -495,7 +524,8 @@ static void tt_changes_list_free(struct bat_priv *bat_priv)
 
 /* caller must hold orig_node refcount */
 int tt_global_add(struct bat_priv *bat_priv, struct orig_node *orig_node,
-		  const unsigned char *tt_addr, uint8_t ttvn, bool roaming)
+		  const unsigned char *tt_addr, uint8_t ttvn, bool roaming,
+		  bool wifi)
 {
 	struct tt_global_entry *tt_global_entry;
 	struct orig_node *orig_node_tmp;
@@ -537,6 +567,9 @@ int tt_global_add(struct bat_priv *bat_priv, struct orig_node *orig_node,
 		tt_global_entry->roam_at = 0;
 	}
 
+	if (wifi)
+		tt_global_entry->flags |= TT_CLIENT_WIFI;
+
 	bat_dbg(DBG_TT, bat_priv,
 		"Creating new global tt entry: %pM (via %pM)\n",
 		tt_global_entry->addr, orig_node->orig);
@@ -1342,7 +1375,9 @@ static void _tt_update_changes(struct bat_priv *bat_priv,
 				      (tt_change + i)->flags & TT_CLIENT_ROAM);
 		else
 			if (!tt_global_add(bat_priv, orig_node,
-					   (tt_change + i)->addr, ttvn, false))
+					   (tt_change + i)->addr, ttvn, false,
+					   (tt_change + i)->flags &
+							TT_CLIENT_WIFI))
 				/* In case of problem while storing a
 				 * global_entry, we stop the updating
 				 * procedure without committing the
diff --git a/translation-table.h b/translation-table.h
index 1cd2d39..b62ae00 100644
--- a/translation-table.h
+++ b/translation-table.h
@@ -22,20 +22,25 @@
 #ifndef _NET_BATMAN_ADV_TRANSLATION_TABLE_H_
 #define _NET_BATMAN_ADV_TRANSLATION_TABLE_H_
 
+/* Transtable local entry flags */
+enum tt_local_flags {
+	TT_LOCAL_NOPURGE = 0x01
+};
+
 int tt_len(int changes_num);
 int tt_changes_fill_buffer(struct bat_priv *bat_priv,
 			   unsigned char *buff, int buff_len);
 int tt_init(struct bat_priv *bat_priv);
-void tt_local_add(struct net_device *soft_iface, const uint8_t *addr);
+void tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
+		  int ifindex);
 void tt_local_remove(struct bat_priv *bat_priv,
 		     const uint8_t *addr, const char *message, bool roaming);
 int tt_local_seq_print_text(struct seq_file *seq, void *offset);
-void tt_global_add_orig(struct bat_priv *bat_priv,
-			struct orig_node *orig_node,
+void tt_global_add_orig(struct bat_priv *bat_priv, struct orig_node *orig_node,
 			const unsigned char *tt_buff, int tt_buff_len);
-int tt_global_add(struct bat_priv *bat_priv,
-		  struct orig_node *orig_node, const unsigned char *addr,
-		  uint8_t ttvn, bool roaming);
+int tt_global_add(struct bat_priv *bat_priv, struct orig_node *orig_node,
+		  const unsigned char *addr, uint8_t ttvn, bool roaming,
+		  bool wifi);
 int tt_global_seq_print_text(struct seq_file *seq, void *offset);
 void tt_global_del_orig(struct bat_priv *bat_priv,
 			struct orig_node *orig_node, const char *message);
diff --git a/types.h b/types.h
index 11e8569..0d85ba7 100644
--- a/types.h
+++ b/types.h
@@ -223,7 +223,7 @@ struct socket_packet {
 struct tt_local_entry {
 	uint8_t addr[ETH_ALEN];
 	unsigned long last_seen;
-	char never_purge;
+	uint8_t flags;
 	atomic_t refcount;
 	struct rcu_head rcu;
 	struct hlist_node hash_entry;
-- 
1.7.3.4


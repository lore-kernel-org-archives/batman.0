Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun, 26 Jun 2011 23:00:14 +0200
Message-Id: <1309122017-29823-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1307307664-19910-1-git-send-email-ordex@autistici.org>
References: <1307307664-19910-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 1/4] batman-adv: detect clients connected
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


This patchset is based on top of:
"batman-adv: pass a unique flag arg instead of a sequence of bool ones"
which is on the ML but has not been applied yet.

Several stuff have been fixed in this version following Andrew's and Marek's suggestion.
** Patch4 adds support for showing client flags in the transtables output. **
For more details look at the following mails:

- patch 1:
http://www.mail-archive.com/b.a.t.m.a.n@lists.open-mesh.org/msg04814.html
http://www.mail-archive.com/b.a.t.m.a.n@lists.open-mesh.org/msg04892.html

- patch 2:
http://www.mail-archive.com/b.a.t.m.a.n@lists.open-mesh.org/msg04816.html

- patch 3:
http://www.mail-archive.com/b.a.t.m.a.n@lists.open-mesh.org/msg04817.html
http://www.mail-archive.com/b.a.t.m.a.n@lists.open-mesh.org/msg04894.html


 compat.h            |    2 ++
 hard-interface.c    |   30 ++++++++++++++++++++++++++++++
 hard-interface.h    |    1 +
 main.c              |    2 +-
 main.h              |    2 ++
 packet.h            |    3 ++-
 routing.c           |    2 +-
 soft-interface.c    |    4 ++--
 translation-table.c |   15 ++++++++++++---
 translation-table.h |    9 +++++----
 10 files changed, 58 insertions(+), 12 deletions(-)

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
diff --git a/hard-interface.c b/hard-interface.c
index db7aacf..f2b6fd9 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -681,6 +681,36 @@ err_out:
 	return NET_RX_DROP;
 }
 
+/* This function returns true if the interface represented by ifindex is a
+ * 802.11 wireless device */
+bool is_wifi_iface(int ifindex)
+{
+	struct net_device *net_device = NULL;
+	bool ret = false;
+
+	if (ifindex == NULL_IFINDEX)
+		goto out;
+
+	net_device = dev_get_by_index(&init_net, ifindex);
+	if (!net_device)
+		goto out;
+
+#ifdef CONFIG_WIRELESS_EXT
+	/* pre-cfg80211 drivers have to implement WEXT, so it is possible to
+	 * check for wireless_handlers != NULL */
+	if (net_device->wireless_handlers)
+		ret = true;
+	else
+#endif
+		/* cfg80211 drivers have to set ieee80211_ptr */
+		if (net_device->ieee80211_ptr)
+			ret = true;
+out:
+	if (net_device)
+		dev_put(net_device);
+	return ret;
+}
+
 struct notifier_block hard_if_notifier = {
 	.notifier_call = hard_if_event,
 };
diff --git a/hard-interface.h b/hard-interface.h
index 442eacb..67f78d1 100644
--- a/hard-interface.h
+++ b/hard-interface.h
@@ -42,6 +42,7 @@ void hardif_remove_interfaces(void);
 int hardif_min_mtu(struct net_device *soft_iface);
 void update_min_mtu(struct net_device *soft_iface);
 void hardif_free_rcu(struct rcu_head *rcu);
+bool is_wifi_iface(int ifindex);
 
 static inline void hardif_free_ref(struct hard_iface *hard_iface)
 {
diff --git a/main.c b/main.c
index e367e69..5dc47a3 100644
--- a/main.c
+++ b/main.c
@@ -108,7 +108,7 @@ int mesh_init(struct net_device *soft_iface)
 	if (tt_init(bat_priv) < 1)
 		goto err;
 
-	tt_local_add(soft_iface, soft_iface->dev_addr);
+	tt_local_add(soft_iface, soft_iface->dev_addr, NULL_IFINDEX);
 
 	if (vis_init(bat_priv) < 1)
 		goto err;
diff --git a/main.h b/main.h
index f3fe9f4..4e2bbe3 100644
--- a/main.h
+++ b/main.h
@@ -61,6 +61,8 @@
 
 #define NO_FLAGS 0
 
+#define NULL_IFINDEX 0 /* dummy ifindex used to avoid iface checks */
+
 #define NUM_WORDS (TQ_LOCAL_WINDOW_SIZE / WORD_BIT_SIZE)
 
 #define LOG_BUF_LEN 8192	  /* has to be a power of 2 */
diff --git a/packet.h b/packet.h
index 8fd2fde..b17baa5 100644
--- a/packet.h
+++ b/packet.h
@@ -82,7 +82,8 @@ enum tt_query_flags {
 enum tt_client_flags {
 	TT_CLIENT_DEL     = 0x01,
 	TT_CLIENT_ROAM    = 0x02,
-	TT_CLIENT_NOPURGE = 0x04
+	TT_CLIENT_NOPURGE = 0x04,
+	TT_CLIENT_WIFI    = 0x08
 };
 
 struct batman_packet {
diff --git a/routing.c b/routing.c
index 2cb98be..d86fbd9 100644
--- a/routing.c
+++ b/routing.c
@@ -1288,7 +1288,7 @@ int recv_roam_adv(struct sk_buff *skb, struct hard_iface *recv_if)
 		roam_adv_packet->client);
 
 	tt_global_add(bat_priv, orig_node, roam_adv_packet->client,
-		      atomic_read(&orig_node->last_ttvn) + 1, true);
+		      atomic_read(&orig_node->last_ttvn) + 1, true, false);
 
 	/* Roaming phase starts: I have new information but the ttvn has not
 	 * been incremented yet. This flag will make me check all the incoming
diff --git a/soft-interface.c b/soft-interface.c
index 3f20332..48146e5 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -536,7 +536,7 @@ static int interface_set_mac_addr(struct net_device *dev, void *p)
 	if (atomic_read(&bat_priv->mesh_state) == MESH_ACTIVE) {
 		tt_local_remove(bat_priv, dev->dev_addr,
 				"mac address changed", false);
-		tt_local_add(dev, addr->sa_data);
+		tt_local_add(dev, addr->sa_data, NULL_IFINDEX);
 	}
 
 	memcpy(dev->dev_addr, addr->sa_data, ETH_ALEN);
@@ -595,7 +595,7 @@ static int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 		goto dropped;
 
 	/* Register the client MAC in the transtable */
-	tt_local_add(soft_iface, ethhdr->h_source);
+	tt_local_add(soft_iface, ethhdr->h_source, skb->skb_iif);
 
 	orig_node = transtable_search(bat_priv, ethhdr->h_dest);
 	if (is_multicast_ether_addr(ethhdr->h_dest) ||
diff --git a/translation-table.c b/translation-table.c
index 796303d..e1dede1 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -186,7 +186,8 @@ static int tt_local_init(struct bat_priv *bat_priv)
 	return 1;
 }
 
-void tt_local_add(struct net_device *soft_iface, const uint8_t *addr)
+void tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
+		  int ifindex)
 {
 	struct bat_priv *bat_priv = netdev_priv(soft_iface);
 	struct tt_local_entry *tt_local_entry = NULL;
@@ -210,6 +211,8 @@ void tt_local_add(struct net_device *soft_iface, const uint8_t *addr)
 	memcpy(tt_local_entry->addr, addr, ETH_ALEN);
 	tt_local_entry->last_seen = jiffies;
 	tt_local_entry->flags = NO_FLAGS;
+	if (is_wifi_iface(ifindex))
+		tt_local_entry->flags |= TT_CLIENT_WIFI;
 	atomic_set(&tt_local_entry->refcount, 2);
 
 	/* the batman interface mac address should never be purged */
@@ -494,7 +497,8 @@ static void tt_changes_list_free(struct bat_priv *bat_priv)
 
 /* caller must hold orig_node refcount */
 int tt_global_add(struct bat_priv *bat_priv, struct orig_node *orig_node,
-		  const unsigned char *tt_addr, uint8_t ttvn, bool roaming)
+		  const unsigned char *tt_addr, uint8_t ttvn, bool roaming,
+		  bool wifi)
 {
 	struct tt_global_entry *tt_global_entry;
 	struct orig_node *orig_node_tmp;
@@ -536,6 +540,9 @@ int tt_global_add(struct bat_priv *bat_priv, struct orig_node *orig_node,
 		tt_global_entry->roam_at = 0;
 	}
 
+	if (wifi)
+		tt_global_entry->flags |= TT_CLIENT_WIFI;
+
 	bat_dbg(DBG_TT, bat_priv,
 		"Creating new global tt entry: %pM (via %pM)\n",
 		tt_global_entry->addr, orig_node->orig);
@@ -1342,7 +1349,9 @@ static void _tt_update_changes(struct bat_priv *bat_priv,
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
index 460e583..e244858 100644
--- a/translation-table.h
+++ b/translation-table.h
@@ -26,15 +26,16 @@ int tt_len(int changes_num);
 int tt_changes_fill_buffer(struct bat_priv *bat_priv,
 			   unsigned char *buff, int buff_len);
 int tt_init(struct bat_priv *bat_priv);
-void tt_local_add(struct net_device *soft_iface, const uint8_t *addr);
+void tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
+		  int ifindex);
 void tt_local_remove(struct bat_priv *bat_priv,
 		     const uint8_t *addr, const char *message, bool roaming);
 int tt_local_seq_print_text(struct seq_file *seq, void *offset);
 void tt_global_add_orig(struct bat_priv *bat_priv, struct orig_node *orig_node,
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
-- 
1.7.3.4


Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 27 Jun 2012 10:23:06 +0200
Message-Id: <1340785387-3821-4-git-send-email-ordex@autistici.org>
In-Reply-To: <1340785387-3821-1-git-send-email-ordex@autistici.org>
References: <1340785387-3821-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 3/4] batman-adv: detect not yet announced
	clients
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

With the current TT mechanism a new client joining the network is not
immediately able to communicate with other hosts because its MAC address has not
been announced yet. This situation holds until the first OGM containing its
joining event will be spread over the mesh network.

This behaviour can be acceptable in networks where the originator interval is a
small value (e.g. 1sec) but if that value is set to an higher time (e.g. 5secs)
the client could suffer from several malfunctions like DHCP client timeouts,
etc.

This patch adds an early detection mechanism that makes nodes in the network
able to recognise "not yet announced clients" by means of the broadcast packets
they emitted on connection (e.g. ARP or DHCP request). The added client will
then be confirmed upon receiving the OGM claiming it or purged if such OGM
is not received within a fixed amount of time.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 main.h              |    4 ++
 packet.h            |    1 +
 translation-table.c |  123 ++++++++++++++++++++++++++++++++++++++++-----------
 translation-table.h |    4 +-
 types.h             |    1 +
 5 files changed, 105 insertions(+), 28 deletions(-)

diff --git a/main.h b/main.h
index 6dca9c4..a4297ea 100644
--- a/main.h
+++ b/main.h
@@ -43,6 +43,10 @@
 #define BATADV_PURGE_TIMEOUT 200000 /* 200 seconds */
 #define BATADV_TT_LOCAL_TIMEOUT 3600000 /* in miliseconds */
 #define BATADV_TT_CLIENT_ROAM_TIMEOUT 600000 /* in miliseconds */
+/* Used to compute the timeout value for the entries marked with TT_CLIENT_TEMP:
+ * temp_timeout_value = temp_timeout_fact * orig_int
+ */
+#define BATADV_TT_CLIENT_TEMP_TIMEOUT_FACT 10UL
 /* sliding packet range of received originator messages in sequence numbers
  * (should be a multiple of our word size)
  */
diff --git a/packet.h b/packet.h
index 65d66e4..db21230 100644
--- a/packet.h
+++ b/packet.h
@@ -85,6 +85,7 @@ enum batadv_tt_client_flags {
 	BATADV_TT_CLIENT_DEL     = 1 << 0,
 	BATADV_TT_CLIENT_ROAM    = 1 << 1,
 	BATADV_TT_CLIENT_WIFI    = 1 << 2,
+	BATADV_TT_CLIENT_TEMP	 = 1 << 3,
 	BATADV_TT_CLIENT_NOPURGE = 1 << 8,
 	BATADV_TT_CLIENT_NEW     = 1 << 9,
 	BATADV_TT_CLIENT_PENDING = 1 << 10,
diff --git a/translation-table.c b/translation-table.c
index bcbd9aa..48b7cf2 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -34,6 +34,19 @@ static void batadv_send_roam_adv(struct batadv_priv *bat_priv, uint8_t *client,
 static void batadv_tt_purge(struct work_struct *work);
 static void
 batadv_tt_global_del_orig_list(struct batadv_tt_global_entry *tt_global_entry);
+static void batadv_tt_global_del(struct batadv_priv *bat_priv,
+				 struct batadv_orig_node *orig_node,
+				 const unsigned char *addr,
+				 const char *message, bool roaming);
+
+/* the temporary client timeout is defined as a multiple of the originator
+ * interval
+ */
+static unsigned long batadv_tt_client_temp_timeout(struct batadv_priv *bat_priv)
+{
+	return BATADV_TT_CLIENT_TEMP_TIMEOUT_FACT *
+	       atomic_read(&bat_priv->orig_interval);
+}
 
 /* returns 1 if they are the same mac addr */
 static int batadv_compare_tt(const struct hlist_node *node, const void *data2)
@@ -267,6 +280,7 @@ void batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 		tt_local_entry->common.flags |= BATADV_TT_CLIENT_WIFI;
 	atomic_set(&tt_local_entry->common.refcount, 2);
 	tt_local_entry->last_seen = jiffies;
+	tt_local_entry->common.added_at = tt_local_entry->last_seen;
 
 	/* the batman interface mac address should never be purged */
 	if (batadv_compare_eth(addr, soft_iface->dev_addr))
@@ -719,6 +733,8 @@ int batadv_tt_global_add(struct batadv_priv *bat_priv,
 		common->flags = flags;
 		tt_global_entry->roam_at = 0;
 		atomic_set(&common->refcount, 2);
+		common->added_at = jiffies;
+
 
 		INIT_HLIST_HEAD(&tt_global_entry->orig_list);
 		spin_lock_init(&tt_global_entry->list_lock);
@@ -738,6 +754,16 @@ int batadv_tt_global_add(struct batadv_priv *bat_priv,
 						ttvn);
 	} else {
 		/* there is already a global entry, use this one. */
+		/* if we are trying to add a temporary node, but we found an
+		 * already existent entry, we can exit directly
+		 */
+		if (flags & BATADV_TT_CLIENT_TEMP)
+			goto out;
+
+		/* if the client was temporary added before receiving the first
+		 * OGM announcing it, we have to clear the TEMP flag
+		 */
+		tt_global_entry->common.flags &= ~BATADV_TT_CLIENT_TEMP;
 
 		/* If there is the BATADV_TT_CLIENT_ROAM flag set, there is only
 		 * one originator left in the list and we previously received a
@@ -795,11 +821,12 @@ batadv_tt_global_print_entry(struct batadv_tt_global_entry *tt_global_entry,
 	hlist_for_each_entry_rcu(orig_entry, node, head, list) {
 		flags = tt_common_entry->flags;
 		last_ttvn = atomic_read(&orig_entry->orig_node->last_ttvn);
-		seq_printf(seq, " * %pM  (%3u) via %pM     (%3u)   [%c%c]\n",
+		seq_printf(seq,	" * %pM  (%3u) via %pM     (%3u)   [%c%c%c]\n",
 			   tt_global_entry->common.addr, orig_entry->ttvn,
 			   orig_entry->orig_node->orig, last_ttvn,
 			   (flags & BATADV_TT_CLIENT_ROAM ? 'R' : '.'),
-			   (flags & BATADV_TT_CLIENT_WIFI ? 'W' : '.'));
+			   (flags & BATADV_TT_CLIENT_WIFI ? 'W' : '.'),
+			   (flags & BATADV_TT_CLIENT_TEMP ? 'T' : '.'));
 	}
 }
 
@@ -1054,46 +1081,63 @@ void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
 	orig_node->tt_initialised = false;
 }
 
-static void batadv_tt_global_roam_purge_list(struct batadv_priv *bat_priv,
-					     struct hlist_head *head)
+static bool batadv_tt_global_to_purge(struct batadv_priv *bat_priv,
+				      struct batadv_tt_common_entry *tt_common,
+				      char **msg)
 {
-	struct batadv_tt_common_entry *tt_common_entry;
-	struct batadv_tt_global_entry *tt_global_entry;
-	struct hlist_node *node, *node_tmp;
+	bool purge = false;
+	unsigned long roam_timeout = BATADV_TT_CLIENT_ROAM_TIMEOUT;
+	unsigned long temp_timeout = batadv_tt_client_temp_timeout(bat_priv);
 
-	hlist_for_each_entry_safe(tt_common_entry, node, node_tmp, head,
-				  hash_entry) {
-		tt_global_entry = container_of(tt_common_entry,
-					       struct batadv_tt_global_entry,
-					       common);
-		if (!(tt_global_entry->common.flags & BATADV_TT_CLIENT_ROAM))
-			continue;
-		if (!batadv_has_timed_out(tt_global_entry->roam_at,
-					  BATADV_TT_CLIENT_ROAM_TIMEOUT))
-			continue;
-
-		batadv_dbg(BATADV_DBG_TT, bat_priv,
-			   "Deleting global tt entry (%pM): Roaming timeout\n",
-			   tt_global_entry->common.addr);
+	if ((tt_common->flags & BATADV_TT_CLIENT_ROAM) &&
+	    batadv_has_timed_out(tt_common->added_at, roam_timeout)) {
+		purge = true;
+		*msg = "Roaming timeout\n";
+	}
 
-		hlist_del_rcu(node);
-		batadv_tt_global_entry_free_ref(tt_global_entry);
+	if ((tt_common->flags & BATADV_TT_CLIENT_TEMP) &&
+	    batadv_has_timed_out(tt_common->added_at, temp_timeout)) {
+		purge = true;
+		*msg = "Temporary client timeout\n";
 	}
+
+	return purge;
 }
 
-static void batadv_tt_global_roam_purge(struct batadv_priv *bat_priv)
+static void batadv_tt_global_purge(struct batadv_priv *bat_priv)
 {
 	struct batadv_hashtable *hash = bat_priv->tt_global_hash;
 	struct hlist_head *head;
+	struct hlist_node *node, *node_tmp;
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	uint32_t i;
+	char *msg = NULL;
+	struct batadv_tt_common_entry *tt_common;
+	struct batadv_tt_global_entry *tt_global;
 
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
 		list_lock = &hash->list_locks[i];
 
 		spin_lock_bh(list_lock);
-		batadv_tt_global_roam_purge_list(bat_priv, head);
+		hlist_for_each_entry_safe(tt_common, node, node_tmp, head,
+					  hash_entry) {
+			if (!batadv_tt_global_to_purge(bat_priv, tt_common,
+						       &msg))
+				continue;
+
+			tt_global = container_of(tt_common,
+						 struct batadv_tt_global_entry,
+						 common);
+
+			batadv_dbg(BATADV_DBG_TT, bat_priv,
+				   "Deleting global tt entry (%pM): %s\n",
+				   tt_global->common.addr, msg);
+
+			hlist_del_rcu(node);
+
+			batadv_tt_global_entry_free_ref(tt_global);
+		}
 		spin_unlock_bh(list_lock);
 	}
 
@@ -1234,6 +1278,11 @@ static uint16_t batadv_tt_global_crc(struct batadv_priv *bat_priv,
 			 */
 			if (tt_common->flags & BATADV_TT_CLIENT_ROAM)
 				continue;
+			/* Temporary clients have not been announced yet, so
+			 * they have to be skipped while computing the global
+			 * crc */
+			if (tt_common->flags & BATADV_TT_CLIENT_TEMP)
+				continue;
 
 			/* find out if this global entry is announced by this
 			 * originator
@@ -1387,7 +1436,8 @@ static int batadv_tt_global_valid(const void *entry_ptr,
 	const struct batadv_tt_global_entry *tt_global_entry;
 	const struct batadv_orig_node *orig_node = data_ptr;
 
-	if (tt_common_entry->flags & BATADV_TT_CLIENT_ROAM)
+	if (tt_common_entry->flags & BATADV_TT_CLIENT_ROAM ||
+	    tt_common_entry->flags & BATADV_TT_CLIENT_TEMP)
 		return 0;
 
 	tt_global_entry = container_of(tt_common_entry,
@@ -2115,7 +2165,7 @@ static void batadv_tt_purge(struct work_struct *work)
 	bat_priv = container_of(delayed_work, struct batadv_priv, tt_work);
 
 	batadv_tt_local_purge(bat_priv);
-	batadv_tt_global_roam_purge(bat_priv);
+	batadv_tt_global_purge(bat_priv);
 	batadv_tt_req_purge(bat_priv);
 	batadv_tt_roam_purge(bat_priv);
 
@@ -2389,3 +2439,22 @@ bool batadv_tt_global_client_is_roaming(struct batadv_priv *bat_priv,
 out:
 	return ret;
 }
+
+bool batadv_tt_add_temporary_global_entry(struct batadv_priv *bat_priv,
+					  struct batadv_orig_node *orig_node,
+					  const unsigned char *addr)
+{
+	bool ret = false;
+
+	if (!batadv_tt_global_add(bat_priv, orig_node, addr,
+				  BATADV_TT_CLIENT_TEMP,
+				  atomic_read(&orig_node->last_ttvn)))
+		goto out;
+
+	batadv_dbg(BATADV_DBG_TT, bat_priv,
+		   "Added temporary global client (addr: %pM orig: %pM)\n",
+		   addr, orig_node->orig);
+	ret = true;
+out:
+	return ret;
+}
diff --git a/translation-table.h b/translation-table.h
index ffa8735..811fffd 100644
--- a/translation-table.h
+++ b/translation-table.h
@@ -59,6 +59,8 @@ int batadv_tt_append_diff(struct batadv_priv *bat_priv,
 			  int packet_min_len);
 bool batadv_tt_global_client_is_roaming(struct batadv_priv *bat_priv,
 					uint8_t *addr);
-
+bool batadv_tt_add_temporary_global_entry(struct batadv_priv *bat_priv,
+					  struct batadv_orig_node *orig_node,
+					  const unsigned char *addr);
 
 #endif /* _NET_BATMAN_ADV_TRANSLATION_TABLE_H_ */
diff --git a/types.h b/types.h
index 82b97c3..591bd28 100644
--- a/types.h
+++ b/types.h
@@ -262,6 +262,7 @@ struct batadv_tt_common_entry {
 	uint8_t addr[ETH_ALEN];
 	struct hlist_node hash_entry;
 	uint16_t flags;
+	unsigned long added_at;
 	atomic_t refcount;
 	struct rcu_head rcu;
 };
-- 
1.7.9.4


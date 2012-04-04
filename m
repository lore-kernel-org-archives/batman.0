Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed,  4 Apr 2012 14:42:12 +0200
Message-Id: <1333543332-26942-5-git-send-email-ordex@autistici.org>
In-Reply-To: <1333543332-26942-1-git-send-email-ordex@autistici.org>
References: <1333543332-26942-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 4/4] batman-adv: enable nodes to detect not
	yet announced clients
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

A client that connects to the mesh network is not visible to any node until it
has been announced by its serving node in the next TT diff sent out by means of
the next OGM.

During this period the client is not able to communicate to anyone because no
node has a route towards it yet. This is usually acceptable in networks with
short OGM interval (=the maximum waiting time before the next announcement), but
it is definitely problematic in networks where the OGM interval has been set to
an higher value (e.g. 5 seconds). The client, that probably issued an ARP or
DHCP request upon connection will suffer from several timeouts before being able
to communicate with the rest of the network.

This patch enable nodes to detect such "new born" clients and to add a temporary
route towards them in order to be able to communicate. If the client is not
claimed by any node within a certain amount of time, it will then be deleted.

Roaming operations have been adapted accordingly in order to be let clients
switch serving node even during the first OGM interval (when they have not been
announced yet)

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 main.h              |    2 +
 packet.h            |   15 +++----
 routing.c           |   26 +++++++++---
 soft-interface.c    |    6 ++-
 soft-interface.h    |    2 +-
 translation-table.c |  111 +++++++++++++++++++++++++++++++++++++++++----------
 translation-table.h |    4 +-
 types.h             |    1 +
 8 files changed, 130 insertions(+), 37 deletions(-)

diff --git a/main.h b/main.h
index c8bfe28..7340542 100644
--- a/main.h
+++ b/main.h
@@ -44,6 +44,8 @@
 #define PURGE_TIMEOUT 200000 /* 200 seconds */
 #define TT_LOCAL_TIMEOUT 3600000 /* in miliseconds */
 #define TT_CLIENT_ROAM_TIMEOUT 600000 /* in miliseconds */
+#define TT_CLIENT_TEMP_TIMEOUT_FACT 10 /* multiply factor for the current orig
+					* interval */
 /* sliding packet range of received originator messages in sequence numbers
  * (should be a multiple of our word size) */
 #define TQ_LOCAL_WINDOW_SIZE 64
diff --git a/packet.h b/packet.h
index 3c4c533..496d633 100644
--- a/packet.h
+++ b/packet.h
@@ -91,12 +91,13 @@ enum tt_query_flags {
  * Flags from 1 to 1 << 7 are sent on the wire, while flags from 1 << 8 to
  * 1 << 15 are used for local computation only */
 enum tt_client_flags {
-	TT_CLIENT_DEL     = 1 << 0,
-	TT_CLIENT_ROAM    = 1 << 1,
-	TT_CLIENT_WIFI    = 1 << 2,
-	TT_CLIENT_NOPURGE = 1 << 8,
-	TT_CLIENT_NEW     = 1 << 9,
-	TT_CLIENT_PENDING = 1 << 10
+	TT_CLIENT_DEL		= 1 << 0,
+	TT_CLIENT_ROAM		= 1 << 1,
+	TT_CLIENT_WIFI		= 1 << 2,
+	TT_CLIENT_TEMP		= 1 << 3,
+	TT_CLIENT_NOPURGE	= 1 << 8,
+	TT_CLIENT_NEW		= 1 << 9,
+	TT_CLIENT_PENDING	= 1 << 10,
 };
 
 /* claim frame types for the bridge loop avoidance */
@@ -224,7 +225,7 @@ struct tt_query_packet {
 
 struct roam_adv_packet {
 	struct batman_header header;
-	uint8_t  reserved;
+	uint8_t  flags;
 	uint8_t  dst[ETH_ALEN];
 	uint8_t  src[ETH_ALEN];
 	uint8_t  client[ETH_ALEN];
diff --git a/routing.c b/routing.c
index 2435237..44bd471 100644
--- a/routing.c
+++ b/routing.c
@@ -679,11 +679,13 @@ int recv_roam_adv(struct sk_buff *skb, struct hard_iface *recv_if)
 		goto out;
 
 	bat_dbg(DBG_TT, bat_priv,
-		"Received ROAMING_ADV from %pM (client %pM)\n",
-		roam_adv_packet->src, roam_adv_packet->client);
+		"Received ROAMING_ADV from %pM (client: %pM flags: 0x%.2x)\n",
+		roam_adv_packet->src, roam_adv_packet->client,
+		roam_adv_packet->flags);
 
 	tt_global_add(bat_priv, orig_node, roam_adv_packet->client,
-		      TT_CLIENT_ROAM, atomic_read(&orig_node->last_ttvn) + 1);
+		      roam_adv_packet->flags | TT_CLIENT_ROAM,
+		      atomic_read(&orig_node->last_ttvn) + 1);
 
 	/* Roaming phase starts: I have new information but the ttvn has not
 	 * been incremented yet. This flag will make me check all the incoming
@@ -959,6 +961,7 @@ int recv_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	struct unicast_packet *unicast_packet;
 	int hdr_size = sizeof(*unicast_packet);
+	struct orig_node *orig_node = NULL;
 
 	unicast_packet = (struct unicast_packet *)skb->data;
 
@@ -974,7 +977,18 @@ int recv_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 
 	/* packet for me */
 	if (is_my_mac(unicast_packet->dest)) {
-		interface_rx(recv_if->soft_iface, skb, recv_if, hdr_size);
+		/* now we can look at the source field and retrieve the orig
+		 * node */
+		if (unicast_packet->header.packet_type == BAT_UNICAST_4ADDR)
+			orig_node = orig_hash_find(bat_priv,
+			       ((struct unicast_4addr_packet *)skb->data)->src);
+
+		interface_rx(recv_if->soft_iface, skb, recv_if, hdr_size,
+			     orig_node);
+
+		if (orig_node)
+			orig_node_free_ref(orig_node);
+
 		return NET_RX_SUCCESS;
 	}
 
@@ -1010,7 +1024,7 @@ int recv_ucast_frag_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 			return NET_RX_SUCCESS;
 
 		interface_rx(recv_if->soft_iface, new_skb, recv_if,
-			     sizeof(struct unicast_packet));
+			     sizeof(struct unicast_packet), NULL);
 		return NET_RX_SUCCESS;
 	}
 
@@ -1094,7 +1108,7 @@ int recv_bcast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 		goto out;
 
 	/* broadcast for me */
-	interface_rx(recv_if->soft_iface, skb, recv_if, hdr_size);
+	interface_rx(recv_if->soft_iface, skb, recv_if, hdr_size, orig_node);
 	ret = NET_RX_SUCCESS;
 	goto out;
 
diff --git a/soft-interface.c b/soft-interface.c
index 92137af..9e2781d 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -256,7 +256,7 @@ end:
 
 void interface_rx(struct net_device *soft_iface,
 		  struct sk_buff *skb, struct hard_iface *recv_if,
-		  int hdr_size)
+		  int hdr_size, struct orig_node *orig_node)
 {
 	struct bat_priv *bat_priv = netdev_priv(soft_iface);
 	struct ethhdr *ethhdr;
@@ -307,6 +307,10 @@ void interface_rx(struct net_device *soft_iface,
 
 	soft_iface->last_rx = jiffies;
 
+	if (orig_node)
+		tt_add_temporary_global_entry(bat_priv, orig_node,
+					      ethhdr->h_source);
+
 	if (is_ap_isolated(bat_priv, ethhdr->h_source, ethhdr->h_dest))
 		goto dropped;
 
diff --git a/soft-interface.h b/soft-interface.h
index 0203006..b91d8ff 100644
--- a/soft-interface.h
+++ b/soft-interface.h
@@ -25,7 +25,7 @@
 int my_skb_head_push(struct sk_buff *skb, unsigned int len);
 void interface_rx(struct net_device *soft_iface,
 		  struct sk_buff *skb, struct hard_iface *recv_if,
-		  int hdr_size);
+		  int hdr_size, struct orig_node *orig_node);
 struct net_device *softif_create(const char *name);
 void softif_destroy(struct net_device *soft_iface);
 int softif_is_valid(const struct net_device *net_dev);
diff --git a/translation-table.c b/translation-table.c
index 0ce2ed9..2831fe9 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -31,10 +31,21 @@
 
 #include <linux/crc16.h>
 
-static void send_roam_adv(struct bat_priv *bat_priv, uint8_t *client,
+/* the temporary client timeout is defined as a multiple of the originator
+ * interval */
+#define TT_CLIENT_TEMP_TIMEOUT (TT_CLIENT_TEMP_TIMEOUT_FACT * \
+				atomic_read(&bat_priv->orig_interval))
+
+
+static void send_roam_adv(struct bat_priv *bat_priv,
+			  struct tt_global_entry *tt_global_entry,
 			  struct orig_node *orig_node);
 static void tt_purge(struct work_struct *work);
 static void tt_global_del_orig_list(struct tt_global_entry *tt_global_entry);
+static void tt_global_del(struct bat_priv *bat_priv,
+			  struct orig_node *orig_node,
+			  const unsigned char *addr,
+			  const char *message, bool roaming);
 
 /* returns 1 if they are the same mac addr */
 static int compare_tt(const struct hlist_node *node, const void *data2)
@@ -250,6 +261,7 @@ void tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 		tt_local_entry->common.flags |= TT_CLIENT_WIFI;
 	atomic_set(&tt_local_entry->common.refcount, 2);
 	tt_local_entry->last_seen = jiffies;
+	tt_local_entry->common.added_at = tt_local_entry->last_seen;
 
 	/* the batman interface mac address should never be purged */
 	if (compare_eth(addr, soft_iface->dev_addr))
@@ -283,15 +295,25 @@ void tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 		hlist_for_each_entry_rcu(orig_entry, node, head, list) {
 			orig_entry->orig_node->tt_poss_change = true;
 
-			send_roam_adv(bat_priv, tt_global_entry->common.addr,
+			send_roam_adv(bat_priv, tt_global_entry,
 				      orig_entry->orig_node);
 		}
 		rcu_read_unlock();
-		/* The global entry has to be marked as ROAMING and
-		 * has to be kept for consistency purpose */
 
-		tt_global_entry->common.flags |= TT_CLIENT_ROAM;
-		tt_global_entry->roam_at = jiffies;
+		/* if the global client is marked as TEMP or ROAM we can
+		 * directly delete it because it has never been announced yet
+		 * and we don't need to keep it for consistency purposes */
+		if ((tt_global_entry->common.flags & TT_CLIENT_TEMP) ||
+		    (tt_global_entry->common.flags & TT_CLIENT_ROAM))
+			tt_global_del(bat_priv, NULL, addr,
+				      "Not yet announced global client roamed to us",
+				      true);
+		else {
+			/* The global entry has to be marked as ROAMING and
+			 * has to be kept for consistency purpose */
+			tt_global_entry->common.flags |= TT_CLIENT_ROAM;
+			tt_global_entry->roam_at = jiffies;
+		}
 	}
 out:
 	if (tt_local_entry)
@@ -607,6 +629,8 @@ int tt_global_add(struct bat_priv *bat_priv, struct orig_node *orig_node,
 		tt_global_entry->common.flags = flags;
 		tt_global_entry->roam_at = 0;
 		atomic_set(&tt_global_entry->common.refcount, 2);
+		tt_global_entry->common.added_at = jiffies;
+
 
 		INIT_HLIST_HEAD(&tt_global_entry->orig_list);
 		spin_lock_init(&tt_global_entry->list_lock);
@@ -624,6 +648,14 @@ int tt_global_add(struct bat_priv *bat_priv, struct orig_node *orig_node,
 		tt_global_add_orig_entry(tt_global_entry, orig_node, ttvn);
 	} else {
 		/* there is already a global entry, use this one. */
+		/* if we are trying to add a temporary node, but we found an
+		 * already existent entry, we can exit directly */
+		if (flags & TT_CLIENT_TEMP)
+			goto out;
+
+		/* if the client was temporary added before receiving the first
+		 * OGM announcing it, we have to clear the TEMP flag */
+		tt_global_entry->common.flags &= ~TT_CLIENT_TEMP;
 
 		/* If there is the TT_CLIENT_ROAM flag set, there is only one
 		 * originator left in the list and we previously received a
@@ -686,11 +718,12 @@ static void tt_global_print_entry(struct tt_global_entry *tt_global_entry,
 	hlist_for_each_entry_rcu(orig_entry, node, head, list) {
 		flags = tt_common_entry->flags;
 		last_ttvn = atomic_read(&orig_entry->orig_node->last_ttvn);
-		seq_printf(seq, " * %pM  (%3u) via %pM     (%3u)   [%c%c]\n",
+		seq_printf(seq,	" * %pM  (%3u) via %pM     (%3u)   [%c%c%c]\n",
 			   tt_global_entry->common.addr, orig_entry->ttvn,
 			   orig_entry->orig_node->orig, last_ttvn,
 			   (flags & TT_CLIENT_ROAM ? 'R' : '.'),
-			   (flags & TT_CLIENT_WIFI ? 'W' : '.'));
+			   (flags & TT_CLIENT_WIFI ? 'W' : '.'),
+			   (flags & TT_CLIENT_TEMP ? 'T' : '.'));
 	}
 }
 
@@ -941,7 +974,7 @@ void tt_global_del_orig(struct bat_priv *bat_priv,
 	orig_node->tt_initialised = false;
 }
 
-static void tt_global_roam_purge(struct bat_priv *bat_priv)
+static void tt_global_purge(struct bat_priv *bat_priv)
 {
 	struct hashtable_t *hash = bat_priv->tt_global_hash;
 	struct tt_common_entry *tt_common_entry;
@@ -950,6 +983,8 @@ static void tt_global_roam_purge(struct bat_priv *bat_priv)
 	struct hlist_head *head;
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	uint32_t i;
+	bool purge;
+	char *msg = NULL;
 
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
@@ -958,18 +993,29 @@ static void tt_global_roam_purge(struct bat_priv *bat_priv)
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(tt_common_entry, node, node_tmp,
 					  head, hash_entry) {
+			purge = false;
 			tt_global_entry = container_of(tt_common_entry,
 						       struct tt_global_entry,
 						       common);
-			if (!(tt_global_entry->common.flags & TT_CLIENT_ROAM))
-				continue;
-			if (!has_timed_out(tt_global_entry->roam_at,
-					   TT_CLIENT_ROAM_TIMEOUT))
+			if ((tt_global_entry->common.flags & TT_CLIENT_ROAM) &&
+			    has_timed_out(tt_global_entry->roam_at,
+					  TT_CLIENT_ROAM_TIMEOUT)) {
+				purge = true;
+				msg = "Roaming timeout\n";
+			}
+
+			if ((tt_global_entry->common.flags & TT_CLIENT_TEMP) &&
+			    has_timed_out(tt_global_entry->common.added_at,
+					  TT_CLIENT_TEMP_TIMEOUT)) {
+				purge = true;
+				msg = "Temporary client timeout\n";
+			}
+
+			if (!purge)
 				continue;
 
-			bat_dbg(DBG_TT, bat_priv,
-				"Deleting global tt entry (%pM): Roaming timeout\n",
-				tt_global_entry->common.addr);
+			bat_dbg(DBG_TT, bat_priv, "Deleting global tt entry (%pM): %s\n",
+				tt_global_entry->common.addr, msg);
 
 			hlist_del_rcu(node);
 			tt_global_entry_free_ref(tt_global_entry);
@@ -1878,7 +1924,8 @@ unlock:
 	return ret;
 }
 
-static void send_roam_adv(struct bat_priv *bat_priv, uint8_t *client,
+static void send_roam_adv(struct bat_priv *bat_priv,
+			  struct tt_global_entry *tt_global_entry,
 			  struct orig_node *orig_node)
 {
 	struct neigh_node *neigh_node = NULL;
@@ -1889,7 +1936,7 @@ static void send_roam_adv(struct bat_priv *bat_priv, uint8_t *client,
 
 	/* before going on we have to check whether the client has
 	 * already roamed to us too many times */
-	if (!tt_check_roam_count(bat_priv, client))
+	if (!tt_check_roam_count(bat_priv, tt_global_entry->common.addr))
 		goto out;
 
 	skb = dev_alloc_skb(sizeof(struct roam_adv_packet) + ETH_HLEN);
@@ -1910,7 +1957,10 @@ static void send_roam_adv(struct bat_priv *bat_priv, uint8_t *client,
 	memcpy(roam_adv_packet->src, primary_if->net_dev->dev_addr, ETH_ALEN);
 	hardif_free_ref(primary_if);
 	memcpy(roam_adv_packet->dst, orig_node->orig, ETH_ALEN);
-	memcpy(roam_adv_packet->client, client, ETH_ALEN);
+	memcpy(roam_adv_packet->client, tt_global_entry->common.addr, ETH_ALEN);
+	roam_adv_packet->flags = NO_FLAGS;
+	if (tt_global_entry->common.flags & TT_CLIENT_TEMP)
+		roam_adv_packet->flags |= TT_CLIENT_TEMP;
 
 	neigh_node = orig_node_get_router(orig_node);
 	if (!neigh_node)
@@ -1918,7 +1968,8 @@ static void send_roam_adv(struct bat_priv *bat_priv, uint8_t *client,
 
 	bat_dbg(DBG_TT, bat_priv,
 		"Sending ROAMING_ADV to %pM (client %pM) via %pM\n",
-		orig_node->orig, client, neigh_node->addr);
+		orig_node->orig, tt_global_entry->common.addr,
+		neigh_node->addr);
 
 	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	ret = 0;
@@ -1939,7 +1990,7 @@ static void tt_purge(struct work_struct *work)
 		container_of(delayed_work, struct bat_priv, tt_work);
 
 	tt_local_purge(bat_priv);
-	tt_global_roam_purge(bat_priv);
+	tt_global_purge(bat_priv);
 	tt_req_purge(bat_priv);
 	tt_roam_purge(bat_priv);
 
@@ -2162,3 +2213,21 @@ bool tt_global_client_is_roaming(struct bat_priv *bat_priv, uint8_t *addr)
 out:
 	return ret;
 }
+
+bool tt_add_temporary_global_entry(struct bat_priv *bat_priv,
+				   struct orig_node *orig_node,
+				   const unsigned char *addr)
+{
+	bool ret = false;
+
+	if (!tt_global_add(bat_priv, orig_node, addr, TT_CLIENT_TEMP,
+			   atomic_read(&orig_node->last_ttvn)))
+		goto out;
+
+	bat_dbg(DBG_TT, bat_priv,
+		"Added temporary global client (addr: %pM orig: %pM)\n",
+		addr, orig_node->orig);
+	ret = true;
+out:
+	return ret;
+}
diff --git a/translation-table.h b/translation-table.h
index 3239b72..9475c44 100644
--- a/translation-table.h
+++ b/translation-table.h
@@ -53,6 +53,8 @@ void tt_update_orig(struct bat_priv *bat_priv, struct orig_node *orig_node,
 		    const unsigned char *tt_buff, uint8_t tt_num_changes,
 		    uint8_t ttvn, uint16_t tt_crc);
 bool tt_global_client_is_roaming(struct bat_priv *bat_priv, uint8_t *addr);
-
+bool tt_add_temporary_global_entry(struct bat_priv *bat_priv,
+				   struct orig_node *orig_node,
+				   const unsigned char *addr);
 
 #endif /* _NET_BATMAN_ADV_TRANSLATION_TABLE_H_ */
diff --git a/types.h b/types.h
index 15f538a..08c51c4 100644
--- a/types.h
+++ b/types.h
@@ -261,6 +261,7 @@ struct tt_common_entry {
 	uint8_t addr[ETH_ALEN];
 	struct hlist_node hash_entry;
 	uint16_t flags;
+	unsigned long added_at;
 	atomic_t refcount;
 	struct rcu_head rcu;
 };
-- 
1.7.9.4


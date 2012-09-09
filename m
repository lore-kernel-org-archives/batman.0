Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun,  9 Sep 2012 10:27:10 +0200
Message-Id: <1347179230-11005-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: substitute tt_poss_change with a
	per-tt_entry flag
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

tt_poss_change is a node-wide flag which tells whether the node is in a roaming
state (a client recently moved to/away from it) in order to let it apply special
re-routing rules. However this flag does not give a clear idea of the current
state because it is not possible to understand *which client* is actually
involved in the roaming. For this reason a better approach has been chosen:
instead of using a node-wide variable, the roaming state is now given by a
per-tt_entry ROAM flag which, in case of packet coming through the node, tells
the it whether the real destination is in roaming state or not.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 originator.c        |  1 -
 routing.c           | 62 +++++++++++++++++++++++++++++------------------------
 soft-interface.c    |  1 -
 translation-table.c | 46 ++++++++++++++++++++++++++++-----------
 translation-table.h |  2 ++
 types.h             |  8 -------
 6 files changed, 69 insertions(+), 51 deletions(-)

diff --git a/originator.c b/originator.c
index d9c14b8..bf27edc 100644
--- a/originator.c
+++ b/originator.c
@@ -220,7 +220,6 @@ struct batadv_orig_node *batadv_get_orig_node(struct batadv_priv *bat_priv,
 	atomic_set(&orig_node->refcount, 2);
 
 	orig_node->tt_initialised = false;
-	orig_node->tt_poss_change = false;
 	orig_node->bat_priv = bat_priv;
 	memcpy(orig_node->orig, addr, ETH_ALEN);
 	orig_node->router = NULL;
diff --git a/routing.c b/routing.c
index 44109cc..b994ee4 100644
--- a/routing.c
+++ b/routing.c
@@ -710,12 +710,6 @@ int batadv_recv_roam_adv(struct sk_buff *skb, struct batadv_hard_iface *recv_if)
 			     BATADV_TT_CLIENT_ROAM,
 			     atomic_read(&orig_node->last_ttvn) + 1);
 
-	/* Roaming phase starts: I have new information but the ttvn has not
-	 * been incremented yet. This flag will make me check all the incoming
-	 * packets for the correct destination.
-	 */
-	bat_priv->tt.poss_change = true;
-
 	batadv_orig_node_free_ref(orig_node);
 out:
 	/* returning NET_RX_DROP will make the caller function kfree the skb */
@@ -900,13 +894,13 @@ out:
 
 static int batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 				     struct sk_buff *skb) {
-	uint8_t curr_ttvn;
+	uint8_t curr_ttvn, new_ttvn;
 	struct batadv_orig_node *orig_node;
 	struct ethhdr *ethhdr;
 	struct batadv_hard_iface *primary_if;
 	struct batadv_unicast_packet *unicast_packet;
-	bool tt_poss_change;
 	int is_old_ttvn;
+	atomic_t *ttvn_ptr;
 
 	/* check if there is enough data before accessing it */
 	if (pskb_may_pull(skb, sizeof(*unicast_packet) + ETH_HLEN) < 0)
@@ -917,9 +911,37 @@ static int batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 		return 0;
 
 	unicast_packet = (struct batadv_unicast_packet *)skb->data;
+	ethhdr = (struct ethhdr *)(skb->data + sizeof(*unicast_packet));
 
 	if (batadv_is_my_mac(unicast_packet->dest)) {
-		tt_poss_change = bat_priv->tt.poss_change;
+		if (batadv_tt_local_client_is_roaming(bat_priv,
+						      ethhdr->h_dest)) {
+			/* If the client is roaming, it means that the node has
+			 * got a ROAM_ADV packet and therefore it is possible to
+			 * look into the translation table for the real
+			 * destination
+			 */
+			orig_node = batadv_transtable_search(bat_priv, NULL,
+							     ethhdr->h_dest);
+			if (orig_node) {
+				memcpy(unicast_packet->dest, orig_node->orig,
+				       ETH_ALEN);
+				ttvn_ptr = &orig_node->last_ttvn;
+				curr_ttvn = (uint8_t)atomic_read(ttvn_ptr);
+				unicast_packet->ttvn = curr_ttvn;
+				batadv_orig_node_free_ref(orig_node);
+				net_ratelimited_function(batadv_dbg,
+							 BATADV_DBG_TT,
+							 bat_priv,
+							 "Local client (%pM) is roaming! Rerouting unicast packet to %pM\n",
+							 ethhdr->h_dest,
+							 unicast_packet->dest);
+			}
+			return 1;
+		}
+		/* It is now possible to move to the second step and check the
+		 * TTVN
+		 */
 		curr_ttvn = (uint8_t)atomic_read(&bat_priv->tt.vn);
 	} else {
 		orig_node = batadv_orig_hash_find(bat_priv,
@@ -929,30 +951,14 @@ static int batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 			return 0;
 
 		curr_ttvn = (uint8_t)atomic_read(&orig_node->last_ttvn);
-		tt_poss_change = orig_node->tt_poss_change;
 		batadv_orig_node_free_ref(orig_node);
 	}
 
-	/* Check whether I have to reroute the packet */
+	/* Check whether this packet has to be rerouted because of old ttvn */
 	is_old_ttvn = batadv_seq_before(unicast_packet->ttvn, curr_ttvn);
-	if (is_old_ttvn || tt_poss_change) {
-		/* check if there is enough data before accessing it */
-		if (pskb_may_pull(skb, sizeof(struct batadv_unicast_packet) +
-				  ETH_HLEN) < 0)
-			return 0;
-
-		ethhdr = (struct ethhdr *)(skb->data + sizeof(*unicast_packet));
-
-		/* we don't have an updated route for this client, so we should
-		 * not try to reroute the packet!!
-		 */
-		if (batadv_tt_global_client_is_roaming(bat_priv,
-						       ethhdr->h_dest))
-			return 1;
-
+	if (is_old_ttvn) {
 		orig_node = batadv_transtable_search(bat_priv, NULL,
 						     ethhdr->h_dest);
-
 		if (!orig_node) {
 			if (!batadv_is_my_client(bat_priv, ethhdr->h_dest))
 				return 0;
@@ -965,7 +971,7 @@ static int batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 		} else {
 			memcpy(unicast_packet->dest, orig_node->orig,
 			       ETH_ALEN);
-			curr_ttvn = (uint8_t)atomic_read(&orig_node->last_ttvn);
+			new_ttvn = (uint8_t)atomic_read(&orig_node->last_ttvn);
 			batadv_orig_node_free_ref(orig_node);
 		}
 
diff --git a/soft-interface.c b/soft-interface.c
index a584f62..ddee4a4 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -462,7 +462,6 @@ struct net_device *batadv_softif_create(const char *name)
 #endif
 	bat_priv->tt.last_changeset = NULL;
 	bat_priv->tt.last_changeset_len = 0;
-	bat_priv->tt.poss_change = false;
 
 	bat_priv->primary_if = NULL;
 	bat_priv->num_ifaces = 0;
diff --git a/translation-table.c b/translation-table.c
index a570d95..21830f5 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -306,8 +306,6 @@ void batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 		head = &tt_global_entry->orig_list;
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_entry, node, head, list) {
-			orig_entry->orig_node->tt_poss_change = true;
-
 			batadv_send_roam_adv(bat_priv,
 					     tt_global_entry->common.addr,
 					     orig_entry->orig_node);
@@ -512,8 +510,11 @@ uint16_t batadv_tt_local_remove(struct batadv_priv *bat_priv,
 	curr_flags = tt_local_entry->common.flags;
 
 	flags = BATADV_TT_CLIENT_DEL;
-	if (roaming)
+	if (roaming) {
 		flags |= BATADV_TT_CLIENT_ROAM;
+		/* mark the local client as ROAMed */
+		tt_local_entry->common.flags |= BATADV_TT_CLIENT_ROAM;
+	}
 
 	batadv_tt_local_set_pending(bat_priv, tt_local_entry, flags, message);
 
@@ -1996,10 +1997,6 @@ void batadv_handle_tt_response(struct batadv_priv *bat_priv,
 
 	/* Recalculate the CRC for this orig_node and store it */
 	orig_node->tt_crc = batadv_tt_global_crc(bat_priv, orig_node);
-	/* Roaming phase is over: tables are in sync again. I can
-	 * unset the flag
-	 */
-	orig_node->tt_poss_change = false;
 out:
 	if (orig_node)
 		batadv_orig_node_free_ref(orig_node);
@@ -2290,7 +2287,6 @@ static int batadv_tt_commit_changes(struct batadv_priv *bat_priv,
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Local changes committed, updating to ttvn %u\n",
 		   (uint8_t)atomic_read(&bat_priv->tt.vn));
-	bat_priv->tt.poss_change = false;
 
 	/* reset the sending counter */
 	atomic_set(&bat_priv->tt.ogm_append_cnt, BATADV_TT_OGM_APPEND_MAX);
@@ -2402,11 +2398,6 @@ void batadv_tt_update_orig(struct batadv_priv *bat_priv,
 		 */
 		if (orig_node->tt_crc != tt_crc)
 			goto request_table;
-
-		/* Roaming phase is over: tables are in sync again. I can
-		 * unset the flag
-		 */
-		orig_node->tt_poss_change = false;
 	} else {
 		/* if we missed more than one change or our tables are not
 		 * in sync anymore -> request fresh tt data
@@ -2445,6 +2436,35 @@ out:
 	return ret;
 }
 
+/**
+ * batadv_tt_local_client_is_roaming - tells whether the client is roaming or not
+ * @bat_priv: the bat priv with all the soft interface information
+ * @addr: the MAC address of the local client to query
+ *
+ * Returns true if the local client is known to be roaming (it is not served by
+ * this node anymore) or not. The client in this state is still present in the
+ * table to keep it consistent with the node TTVN value
+ */
+bool batadv_tt_local_client_is_roaming(struct batadv_priv *bat_priv,
+				       uint8_t *addr)
+{
+	struct batadv_tt_local_entry *tt_local_entry;
+	bool ret = false;
+
+	tt_local_entry = batadv_tt_local_hash_find(bat_priv, addr);
+	if (!tt_local_entry)
+		goto out;
+
+	/*if (tt_local_entry->common.flags & BATADV_TT_CLIENT_PENDING)
+		goto out;*/
+
+	ret = !!(tt_local_entry->common.flags & BATADV_TT_CLIENT_ROAM);
+	batadv_tt_local_entry_free_ref(tt_local_entry);
+out:
+	return ret;
+
+}
+
 bool batadv_tt_add_temporary_global_entry(struct batadv_priv *bat_priv,
 					  struct batadv_orig_node *orig_node,
 					  const unsigned char *addr)
diff --git a/translation-table.h b/translation-table.h
index 9fa4fe4..46d4451 100644
--- a/translation-table.h
+++ b/translation-table.h
@@ -59,6 +59,8 @@ int batadv_tt_append_diff(struct batadv_priv *bat_priv,
 			  int packet_min_len);
 bool batadv_tt_global_client_is_roaming(struct batadv_priv *bat_priv,
 					uint8_t *addr);
+bool batadv_tt_local_client_is_roaming(struct batadv_priv *bat_priv,
+				       uint8_t *addr);
 bool batadv_tt_add_temporary_global_entry(struct batadv_priv *bat_priv,
 					  struct batadv_orig_node *orig_node,
 					  const unsigned char *addr);
diff --git a/types.h b/types.h
index dc126e7..7e69340 100644
--- a/types.h
+++ b/types.h
@@ -87,13 +87,6 @@ struct batadv_orig_node {
 	spinlock_t tt_buff_lock; /* protects tt_buff */
 	atomic_t tt_size;
 	bool tt_initialised;
-	/* The tt_poss_change flag is used to detect an ongoing roaming phase.
-	 * If true, then I sent a Roaming_adv to this orig_node and I have to
-	 * inspect every packet directed to it to check whether it is still
-	 * the true destination or not. This flag will be reset to false as
-	 * soon as I receive a new TTVN from this orig_node
-	 */
-	bool tt_poss_change;
 	uint32_t last_real_seqno;
 	uint8_t last_ttl;
 	DECLARE_BITMAP(bcast_bits, BATADV_TQ_LOCAL_WINDOW_SIZE);
@@ -191,7 +184,6 @@ struct batadv_priv_tt {
 	atomic_t vn;
 	atomic_t ogm_append_cnt;
 	atomic_t local_changes;
-	bool poss_change;
 	struct list_head changes_list;
 	struct batadv_hashtable *local_hash;
 	struct batadv_hashtable *global_hash;
-- 
1.7.12


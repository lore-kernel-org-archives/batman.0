Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 30 Aug 2012 17:04:24 +0200
Message-Id: <1346339064-4348-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: roaming re-routing mechanism
	redesign
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

The roaming re-routing procedure has been slightly revised in order to get rid
of the tt_poss_change variable that was not clearly representing the node/client
states. Now the code directly relies on the TT_CLIENT_ROAM flag that can be
set on the involved local/global clients.

This improvement also allow clients to roam multiple times in the same
originator-interval, because nodes now let packets go to the node that was
originally serving the roamed client which will then reroute the data to the
correct destination at any point in time.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

- This patch is based on top of:
  "batman-adv: substitute tt_poss_change with a per-tt_entry flag"

 translation-table.c | 216 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 152 insertions(+), 64 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index 21830f5..e5afcee 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -238,90 +238,138 @@ static int batadv_tt_local_init(struct batadv_priv *bat_priv)
 	return 0;
 }
 
+static void
+batadv_tt_global_del_struct(struct batadv_priv *bat_priv,
+			    struct batadv_tt_global_entry *tt_global_entry,
+			    const char *message)
+{
+	batadv_dbg(BATADV_DBG_TT, bat_priv,
+		   "Deleting global tt entry %pM: %s\n",
+		   tt_global_entry->common.addr, message);
+
+	batadv_hash_remove(bat_priv->tt.global_hash, batadv_compare_tt,
+			   batadv_choose_orig, tt_global_entry->common.addr);
+	batadv_tt_global_entry_free_ref(tt_global_entry);
+
+}
+
 void batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 			 int ifindex)
 {
 	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
-	struct batadv_tt_local_entry *tt_local_entry = NULL;
-	struct batadv_tt_global_entry *tt_global_entry = NULL;
+	struct batadv_tt_local_entry *tt_local = NULL;
+	struct batadv_tt_global_entry *tt_global = NULL;
 	struct hlist_head *head;
 	struct hlist_node *node;
 	struct batadv_tt_orig_list_entry *orig_entry;
 	int hash_added;
+	bool back_roam = false;
 
-	tt_local_entry = batadv_tt_local_hash_find(bat_priv, addr);
+	tt_local = batadv_tt_local_hash_find(bat_priv, addr);
+	/* look for the global entry so that we can eventually operate on it */
+	tt_global = batadv_tt_global_hash_find(bat_priv, addr);
 
-	if (tt_local_entry) {
-		tt_local_entry->last_seen = jiffies;
-		/* possibly unset the BATADV_TT_CLIENT_PENDING flag */
-		tt_local_entry->common.flags &= ~BATADV_TT_CLIENT_PENDING;
-		goto out;
+
+	if (tt_local) {
+		tt_local->last_seen = jiffies;
+		if (tt_local->common.flags & BATADV_TT_CLIENT_PENDING) {
+			/* if this client is marked as pending it means that it
+			 * was purged out before.
+			 */
+			batadv_dbg(BATADV_DBG_TT, bat_priv,
+				   "Readding pending client %pM\n", addr);
+			tt_local->common.flags &= ~BATADV_TT_CLIENT_PENDING;
+			goto add_event;
+		}
+		/* if the entry is marked as NEW, it means that the node is not
+		 * the original owner of this client (in this orig-interval),
+		 * therefore it does need to  eventually send a roaming
+		 * advertisement
+		 */
+		/*if (tt_local->common.flags & BATADV_TT_CLIENT_NEW)
+			goto out;*/
+
+		if (tt_local->common.flags & BATADV_TT_CLIENT_ROAM) {
+			batadv_dbg(BATADV_DBG_TT, bat_priv,
+				   "Roaming client %pM came back to its original location\n",
+				   addr);
+			tt_local->common.flags &= ~BATADV_TT_CLIENT_ROAM;
+			back_roam = true;
+			goto check_roaming;
+		}
+		goto check_roaming;
 	}
 
-	tt_local_entry = kmalloc(sizeof(*tt_local_entry), GFP_ATOMIC);
-	if (!tt_local_entry)
+	tt_local = kmalloc(sizeof(*tt_local), GFP_ATOMIC);
+	if (!tt_local)
 		goto out;
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Creating new local tt entry: %pM (ttvn: %d)\n", addr,
 		   (uint8_t)atomic_read(&bat_priv->tt.vn));
 
-	memcpy(tt_local_entry->common.addr, addr, ETH_ALEN);
-	tt_local_entry->common.flags = BATADV_NO_FLAGS;
+	memcpy(tt_local->common.addr, addr, ETH_ALEN);
+	tt_local->common.flags = BATADV_NO_FLAGS;
 	if (batadv_is_wifi_iface(ifindex))
-		tt_local_entry->common.flags |= BATADV_TT_CLIENT_WIFI;
-	atomic_set(&tt_local_entry->common.refcount, 2);
-	tt_local_entry->last_seen = jiffies;
-	tt_local_entry->common.added_at = tt_local_entry->last_seen;
+		tt_local->common.flags |= BATADV_TT_CLIENT_WIFI;
+	atomic_set(&tt_local->common.refcount, 2);
+	tt_local->last_seen = jiffies;
+	tt_local->common.added_at = tt_local->last_seen;
 
 	/* the batman interface mac address should never be purged */
 	if (batadv_compare_eth(addr, soft_iface->dev_addr))
-		tt_local_entry->common.flags |= BATADV_TT_CLIENT_NOPURGE;
+		tt_local->common.flags |= BATADV_TT_CLIENT_NOPURGE;
 
 	/* The local entry has to be marked as NEW to avoid to send it in
 	 * a full table response going out before the next ttvn increment
 	 * (consistency check)
 	 */
-	tt_local_entry->common.flags |= BATADV_TT_CLIENT_NEW;
+	tt_local->common.flags |= BATADV_TT_CLIENT_NEW;
 
 	hash_added = batadv_hash_add(bat_priv->tt.local_hash, batadv_compare_tt,
 				     batadv_choose_orig,
-				     &tt_local_entry->common,
-				     &tt_local_entry->common.hash_entry);
+				     &tt_local->common,
+				     &tt_local->common.hash_entry);
 
 	if (unlikely(hash_added != 0)) {
 		/* remove the reference for the hash */
-		batadv_tt_local_entry_free_ref(tt_local_entry);
+		batadv_tt_local_entry_free_ref(tt_local);
 		goto out;
 	}
 
-	batadv_tt_local_event(bat_priv, addr, tt_local_entry->common.flags);
-
-	/* remove address from global hash if present */
-	tt_global_entry = batadv_tt_global_hash_find(bat_priv, addr);
+add_event:
+	batadv_tt_local_event(bat_priv, addr, tt_local->common.flags);
 
+check_roaming:
 	/* Check whether it is a roaming! */
-	if (tt_global_entry) {
+	if (tt_global) {
 		/* These node are probably going to update their tt table */
-		head = &tt_global_entry->orig_list;
+		head = &tt_global->orig_list;
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_entry, node, head, list) {
 			batadv_send_roam_adv(bat_priv,
-					     tt_global_entry->common.addr,
+					     tt_global->common.addr,
 					     orig_entry->orig_node);
 		}
 		rcu_read_unlock();
-		/* The global entry has to be marked as ROAMING and
-		 * has to be kept for consistency purpose
-		 */
-		tt_global_entry->common.flags |= BATADV_TT_CLIENT_ROAM;
-		tt_global_entry->roam_at = jiffies;
+		if (back_roam) {
+			batadv_tt_global_del_struct(bat_priv, tt_global,
+						    "Roaming canceled");
+			tt_global = NULL;
+		} else {
+			/* The global entry has to be marked as ROAMING and
+			 * has to be kept for consistency purpose
+			 */
+			tt_global->common.flags |= BATADV_TT_CLIENT_ROAM;
+			tt_global->roam_at = jiffies;
+		}
 	}
+
 out:
-	if (tt_local_entry)
-		batadv_tt_local_entry_free_ref(tt_local_entry);
-	if (tt_global_entry)
-		batadv_tt_global_entry_free_ref(tt_global_entry);
+	if (tt_local)
+		batadv_tt_local_entry_free_ref(tt_local);
+	if (tt_global)
+		batadv_tt_global_entry_free_ref(tt_global);
 }
 
 static void batadv_tt_realloc_packet_buff(unsigned char **packet_buff,
@@ -510,13 +558,28 @@ uint16_t batadv_tt_local_remove(struct batadv_priv *bat_priv,
 	curr_flags = tt_local_entry->common.flags;
 
 	flags = BATADV_TT_CLIENT_DEL;
+	/* if this global entry addition is due to a roaming, the node has to
+	 * mark the local entry as "roamed" in order to correctly reroute
+	 * packets later
+	 */
 	if (roaming) {
 		flags |= BATADV_TT_CLIENT_ROAM;
 		/* mark the local client as ROAMed */
 		tt_local_entry->common.flags |= BATADV_TT_CLIENT_ROAM;
 	}
 
-	batadv_tt_local_set_pending(bat_priv, tt_local_entry, flags, message);
+	if (!(tt_local_entry->common.flags & BATADV_TT_CLIENT_NEW)) {
+		batadv_tt_local_set_pending(bat_priv, tt_local_entry, flags,
+					    message);
+		goto out;
+	}
+	/* if this client has been added right now, it is possible to
+	 * immediately purge it
+	 */
+	batadv_tt_local_event(bat_priv, tt_local_entry->common.addr,
+			      curr_flags | BATADV_TT_CLIENT_DEL);
+	hlist_del_rcu(&tt_local_entry->common.hash_entry);
+	batadv_tt_local_entry_free_ref(tt_local_entry);
 
 out:
 	if (tt_local_entry)
@@ -726,12 +789,22 @@ int batadv_tt_global_add(struct batadv_priv *bat_priv,
 			 uint8_t ttvn)
 {
 	struct batadv_tt_global_entry *tt_global_entry = NULL;
+	struct batadv_tt_local_entry *tt_local_entry = NULL;
 	int ret = 0;
 	int hash_added;
 	struct batadv_tt_common_entry *common;
 	uint16_t local_flags;
 
 	tt_global_entry = batadv_tt_global_hash_find(bat_priv, tt_addr);
+	tt_local_entry = batadv_tt_local_hash_find(bat_priv, tt_addr);
+
+	/* if the node already has a local client for this entry, it has to wait
+	 * for a roaming advertisement instead of manually messing up the global
+	 * table
+	 */
+	if ((flags & BATADV_TT_CLIENT_TEMP) && tt_local_entry &&
+	    !(tt_local_entry->common.flags & BATADV_TT_CLIENT_NEW))
+		goto out;
 
 	if (!tt_global_entry) {
 		tt_global_entry = kzalloc(sizeof(*tt_global_entry), GFP_ATOMIC);
@@ -766,19 +839,39 @@ int batadv_tt_global_add(struct batadv_priv *bat_priv,
 			goto out_remove;
 		}
 	} else {
+		common = &tt_global_entry->common;
 		/* If there is already a global entry, we can use this one for
 		 * our processing.
-		 * But if we are trying to add a temporary client we can exit
-		 * directly because the temporary information should never
-		 * override any already known client state (whatever it is)
+		 * But if we are trying to add a temporary client then here are
+		 * two options at this point:
+		 * 1) the global client is not a temporary client: the global
+		 *    client has to be left as it is, temporary information
+		 *    should never override any already known client state
+		 * 2) the global client is a temporary client: purge the
+		 *    originator list and add the new one orig_entry
 		 */
-		if (flags & BATADV_TT_CLIENT_TEMP)
-			goto out;
+		if (flags & BATADV_TT_CLIENT_TEMP) {
+			if (!(common->flags & BATADV_TT_CLIENT_TEMP))
+				goto out;
+			if (batadv_tt_global_entry_has_orig(tt_global_entry,
+							    orig_node))
+				goto out_remove;
+			batadv_tt_global_del_orig_list(tt_global_entry);
+			goto add_orig_entry;
+		}
 
 		/* if the client was temporary added before receiving the first
 		 * OGM announcing it, we have to clear the TEMP flag
 		 */
-		tt_global_entry->common.flags &= ~BATADV_TT_CLIENT_TEMP;
+		common->flags &= ~BATADV_TT_CLIENT_TEMP;
+
+		/* if this is a normal add, possibly unset the ROAM flag. This
+		 * flag could have been set before because the client was
+		 * roaming, but now that the node got the ADD event, the flag
+		 * can be unset
+		 */
+		if (!(flags & BATADV_TT_CLIENT_ROAM))
+			common->flags &= ~BATADV_TT_CLIENT_ROAM;
 
 		/* If there is the BATADV_TT_CLIENT_ROAM flag set, there is only
 		 * one originator left in the list and we previously received a
@@ -787,18 +880,19 @@ int batadv_tt_global_add(struct batadv_priv *bat_priv,
 		 * We should first delete the old originator before adding the
 		 * new one.
 		 */
-		if (tt_global_entry->common.flags & BATADV_TT_CLIENT_ROAM) {
+		if (common->flags & BATADV_TT_CLIENT_ROAM) {
 			batadv_tt_global_del_orig_list(tt_global_entry);
-			tt_global_entry->common.flags &= ~BATADV_TT_CLIENT_ROAM;
+			common->flags &= ~BATADV_TT_CLIENT_ROAM;
 			tt_global_entry->roam_at = 0;
 		}
 	}
+add_orig_entry:
 	/* add the new orig_entry (if needed) or update it */
 	batadv_tt_global_orig_entry_add(tt_global_entry, orig_node, ttvn);
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Creating new global tt entry: %pM (via %pM)\n",
-		   tt_global_entry->common.addr, orig_node->orig);
+		   common->addr, orig_node->orig);
 	ret = 1;
 
 out_remove:
@@ -806,12 +900,20 @@ out_remove:
 	/* remove address from local hash if present */
 	local_flags = batadv_tt_local_remove(bat_priv, tt_addr,
 					     "global tt received",
-					     flags & BATADV_TT_CLIENT_ROAM);
+					     !!(flags & BATADV_TT_CLIENT_ROAM));
 	tt_global_entry->common.flags |= local_flags & BATADV_TT_CLIENT_WIFI;
 
+	if (!(flags & BATADV_TT_CLIENT_ROAM))
+		/* this is a normal global add. Therefore the client is not in a
+		 * roaming state anymore.
+		 */
+		tt_global_entry->common.flags &= ~BATADV_TT_CLIENT_ROAM;
+
 out:
 	if (tt_global_entry)
 		batadv_tt_global_entry_free_ref(tt_global_entry);
+	if (tt_local_entry)
+		batadv_tt_local_entry_free_ref(tt_local_entry);
 	return ret;
 }
 
@@ -929,21 +1031,6 @@ batadv_tt_global_del_orig_entry(struct batadv_priv *bat_priv,
 	spin_unlock_bh(&tt_global_entry->list_lock);
 }
 
-static void
-batadv_tt_global_del_struct(struct batadv_priv *bat_priv,
-			    struct batadv_tt_global_entry *tt_global_entry,
-			    const char *message)
-{
-	batadv_dbg(BATADV_DBG_TT, bat_priv,
-		   "Deleting global tt entry %pM: %s\n",
-		   tt_global_entry->common.addr, message);
-
-	batadv_hash_remove(bat_priv->tt.global_hash, batadv_compare_tt,
-			   batadv_choose_orig, tt_global_entry->common.addr);
-	batadv_tt_global_entry_free_ref(tt_global_entry);
-
-}
-
 /* If the client is to be deleted, we check if it is the last origantor entry
  * within tt_global entry. If yes, we set the BATADV_TT_CLIENT_ROAM flag and the
  * timer, otherwise we simply remove the originator scheduled for deletion.
@@ -1207,7 +1294,8 @@ struct batadv_orig_node *batadv_transtable_search(struct batadv_priv *bat_priv,
 
 	if (src && atomic_read(&bat_priv->ap_isolation)) {
 		tt_local_entry = batadv_tt_local_hash_find(bat_priv, src);
-		if (!tt_local_entry)
+		if (!tt_local_entry ||
+		    (tt_local_entry->common.flags & BATADV_TT_CLIENT_PENDING))
 			goto out;
 	}
 
-- 
1.7.12


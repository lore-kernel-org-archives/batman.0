Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 29 Jun 2016 23:44:54 +0200
Message-Id: <1467236695-6180-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Place kref_get near use of
	reference
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

It is hard to understand why the refcnt is increased when it isn't done
near the actual place the new reference is used. So using kref_get right
before the place which requires the reference and in the same function
helps to avoid accidental problems causedy incorrect reference counting.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_iv_ogm.c            | 7 ++++---
 net/batman-adv/bat_v_ogm.c             | 5 ++---
 net/batman-adv/bridge_loop_avoidance.c | 9 ++++-----
 net/batman-adv/distributed-arp-table.c | 2 +-
 net/batman-adv/gateway_client.c        | 8 ++++++--
 net/batman-adv/hard-interface.c        | 6 ++----
 net/batman-adv/network-coding.c        | 9 ++++-----
 net/batman-adv/originator.c            | 8 ++++----
 net/batman-adv/soft-interface.c        | 4 ++++
 net/batman-adv/translation-table.c     | 6 +++---
 net/batman-adv/tvlv.c                  | 9 +++++++++
 11 files changed, 43 insertions(+), 30 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 6af4462..cdeb48e 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -318,17 +318,18 @@ batadv_iv_ogm_orig_get(struct batadv_priv *bat_priv, const u8 *addr)
 	if (!orig_node->bat_iv.bcast_own_sum)
 		goto free_orig_node;
 
+	kref_get(&orig_node->refcount);
 	hash_added = batadv_hash_add(bat_priv->orig_hash, batadv_compare_orig,
 				     batadv_choose_orig, orig_node,
 				     &orig_node->hash_entry);
 	if (hash_added != 0)
-		goto free_orig_node;
+		goto free_orig_node_hash;
 
 	return orig_node;
 
-free_orig_node:
-	/* free twice, as batadv_orig_node_new sets refcount to 2 */
+free_orig_node_hash:
 	batadv_orig_node_put(orig_node);
+free_orig_node:
 	batadv_orig_node_put(orig_node);
 
 	return NULL;
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 6fbba4e..1aeeadc 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -73,13 +73,12 @@ struct batadv_orig_node *batadv_v_ogm_orig_get(struct batadv_priv *bat_priv,
 	if (!orig_node)
 		return NULL;
 
+	kref_get(&orig_node->refcount);
 	hash_added = batadv_hash_add(bat_priv->orig_hash, batadv_compare_orig,
 				     batadv_choose_orig, orig_node,
 				     &orig_node->hash_entry);
 	if (hash_added != 0) {
-		/* orig_node->refcounter is initialised to 2 by
-		 * batadv_orig_node_new()
-		 */
+		/* remove refcnt for newly created orig_node and hash entry */
 		batadv_orig_node_put(orig_node);
 		batadv_orig_node_put(orig_node);
 		orig_node = NULL;
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index e4f7494..c5e62fa 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -505,11 +505,9 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, u8 *orig,
 	atomic_set(&entry->wait_periods, 0);
 	ether_addr_copy(entry->orig, orig);
 	INIT_WORK(&entry->report_work, batadv_bla_loopdetect_report);
-
-	/* one for the hash, one for returning */
 	kref_init(&entry->refcount);
-	kref_get(&entry->refcount);
 
+	kref_get(&entry->refcount);
 	hash_added = batadv_hash_add(bat_priv->bla.backbone_hash,
 				     batadv_compare_backbone_gw,
 				     batadv_choose_backbone_gw, entry,
@@ -693,12 +691,13 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 		claim->vid = vid;
 		claim->lasttime = jiffies;
 		claim->backbone_gw = backbone_gw;
-
 		kref_init(&claim->refcount);
-		kref_get(&claim->refcount);
+
 		batadv_dbg(BATADV_DBG_BLA, bat_priv,
 			   "bla_add_claim(): adding new entry %pM, vid %d to hash ...\n",
 			   mac, BATADV_PRINT_VID(vid));
+
+		kref_get(&claim->refcount);
 		hash_added = batadv_hash_add(bat_priv->bla.claim_hash,
 					     batadv_compare_claim,
 					     batadv_choose_claim, claim,
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index fa76465..0afaff4 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -343,8 +343,8 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 	ether_addr_copy(dat_entry->mac_addr, mac_addr);
 	dat_entry->last_update = jiffies;
 	kref_init(&dat_entry->refcount);
-	kref_get(&dat_entry->refcount);
 
+	kref_get(&dat_entry->refcount);
 	hash_added = batadv_hash_add(bat_priv->dat.hash, batadv_compare_dat,
 				     batadv_hash_dat, dat_entry,
 				     &dat_entry->hash_entry);
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 63a805d..cbb57e3 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -445,14 +445,15 @@ static void batadv_gw_node_add(struct batadv_priv *bat_priv,
 	if (!gw_node)
 		return;
 
-	kref_get(&orig_node->refcount);
+	kref_init(&gw_node->refcount);
 	INIT_HLIST_NODE(&gw_node->list);
+	kref_get(&orig_node->refcount);
 	gw_node->orig_node = orig_node;
 	gw_node->bandwidth_down = ntohl(gateway->bandwidth_down);
 	gw_node->bandwidth_up = ntohl(gateway->bandwidth_up);
-	kref_init(&gw_node->refcount);
 
 	spin_lock_bh(&bat_priv->gw.list_lock);
+	kref_get(&gw_node->refcount);
 	hlist_add_head_rcu(&gw_node->list, &bat_priv->gw.list);
 	spin_unlock_bh(&bat_priv->gw.list_lock);
 
@@ -463,6 +464,9 @@ static void batadv_gw_node_add(struct batadv_priv *bat_priv,
 		   ntohl(gateway->bandwidth_down) % 10,
 		   ntohl(gateway->bandwidth_up) / 10,
 		   ntohl(gateway->bandwidth_up) % 10);
+
+	/* don't return reference to new gw_node */
+	batadv_gw_node_put(gw_node);
 }
 
 /**
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 714af8e..adb0377 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -658,6 +658,7 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 	INIT_HLIST_HEAD(&hard_iface->neigh_list);
 
 	spin_lock_init(&hard_iface->neigh_list_lock);
+	kref_init(&hard_iface->refcount);
 
 	hard_iface->num_bcasts = BATADV_NUM_BCASTS_DEFAULT;
 	if (batadv_is_wifi_netdev(net_dev))
@@ -665,11 +666,8 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 
 	batadv_v_hardif_init(hard_iface);
 
-	/* extra reference for return */
-	kref_init(&hard_iface->refcount);
-	kref_get(&hard_iface->refcount);
-
 	batadv_check_known_mac_addr(hard_iface->net_dev);
+	kref_get(&hard_iface->refcount);
 	list_add_tail_rcu(&hard_iface->list, &batadv_hardif_list);
 
 	return hard_iface;
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 293ef4f..165cd27 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -856,14 +856,12 @@ batadv_nc_get_nc_node(struct batadv_priv *bat_priv,
 	if (!nc_node)
 		return NULL;
 
-	kref_get(&orig_neigh_node->refcount);
-
 	/* Initialize nc_node */
 	INIT_LIST_HEAD(&nc_node->list);
+	kref_init(&nc_node->refcount);
 	ether_addr_copy(nc_node->addr, orig_node->orig);
+	kref_get(&orig_neigh_node->refcount);
 	nc_node->orig_node = orig_neigh_node;
-	kref_init(&nc_node->refcount);
-	kref_get(&nc_node->refcount);
 
 	/* Select ingoing or outgoing coding node */
 	if (in_coding) {
@@ -879,6 +877,7 @@ batadv_nc_get_nc_node(struct batadv_priv *bat_priv,
 
 	/* Add nc_node to orig_node */
 	spin_lock_bh(lock);
+	kref_get(&nc_node->refcount);
 	list_add_tail_rcu(&nc_node->list, list);
 	spin_unlock_bh(lock);
 
@@ -979,7 +978,6 @@ static struct batadv_nc_path *batadv_nc_get_path(struct batadv_priv *bat_priv,
 	INIT_LIST_HEAD(&nc_path->packet_list);
 	spin_lock_init(&nc_path->packet_list_lock);
 	kref_init(&nc_path->refcount);
-	kref_get(&nc_path->refcount);
 	nc_path->last_valid = jiffies;
 	ether_addr_copy(nc_path->next_hop, dst);
 	ether_addr_copy(nc_path->prev_hop, src);
@@ -989,6 +987,7 @@ static struct batadv_nc_path *batadv_nc_get_path(struct batadv_priv *bat_priv,
 		   nc_path->next_hop);
 
 	/* Add nc_path to hash table */
+	kref_get(&nc_path->refcount);
 	hash_added = batadv_hash_add(hash, batadv_nc_hash_compare,
 				     batadv_nc_hash_choose, &nc_path_key,
 				     &nc_path->hash_entry);
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 7d1e542..8755e5c 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -127,9 +127,9 @@ batadv_orig_node_vlan_new(struct batadv_orig_node *orig_node,
 		goto out;
 
 	kref_init(&vlan->refcount);
-	kref_get(&vlan->refcount);
 	vlan->vid = vid;
 
+	kref_get(&vlan->refcount);
 	hlist_add_head_rcu(&vlan->list, &orig_node->vlan_list);
 
 out:
@@ -380,6 +380,7 @@ batadv_orig_ifinfo_new(struct batadv_orig_node *orig_node,
 	orig_ifinfo->if_outgoing = if_outgoing;
 	INIT_HLIST_NODE(&orig_ifinfo->list);
 	kref_init(&orig_ifinfo->refcount);
+
 	kref_get(&orig_ifinfo->refcount);
 	hlist_add_head_rcu(&orig_ifinfo->list,
 			   &orig_node->ifinfo_list);
@@ -453,9 +454,9 @@ batadv_neigh_ifinfo_new(struct batadv_neigh_node *neigh,
 
 	INIT_HLIST_NODE(&neigh_ifinfo->list);
 	kref_init(&neigh_ifinfo->refcount);
-	kref_get(&neigh_ifinfo->refcount);
 	neigh_ifinfo->if_outgoing = if_outgoing;
 
+	kref_get(&neigh_ifinfo->refcount);
 	hlist_add_head_rcu(&neigh_ifinfo->list, &neigh->ifinfo_list);
 
 out:
@@ -647,8 +648,8 @@ batadv_neigh_node_create(struct batadv_orig_node *orig_node,
 
 	/* extra reference for return */
 	kref_init(&neigh_node->refcount);
-	kref_get(&neigh_node->refcount);
 
+	kref_get(&neigh_node->refcount);
 	hlist_add_head_rcu(&neigh_node->list, &orig_node->neigh_list);
 
 	batadv_dbg(BATADV_DBG_BATMAN, orig_node->bat_priv,
@@ -890,7 +891,6 @@ struct batadv_orig_node *batadv_orig_node_new(struct batadv_priv *bat_priv,
 
 	/* extra reference for return */
 	kref_init(&orig_node->refcount);
-	kref_get(&orig_node->refcount);
 
 	orig_node->bat_priv = bat_priv;
 	ether_addr_copy(orig_node->orig, addr);
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index e508bf5..49e16b6 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -594,6 +594,7 @@ int batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
 	}
 
 	spin_lock_bh(&bat_priv->softif_vlan_list_lock);
+	kref_get(&vlan->refcount);
 	hlist_add_head_rcu(&vlan->list, &bat_priv->softif_vlan_list);
 	spin_unlock_bh(&bat_priv->softif_vlan_list_lock);
 
@@ -604,6 +605,9 @@ int batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
 			    bat_priv->soft_iface->dev_addr, vid,
 			    BATADV_NULL_IFINDEX, BATADV_NO_MARK);
 
+	/* don't return reference to new softif_vlan */
+	batadv_softif_vlan_put(vlan);
+
 	return 0;
 }
 
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 3c32f5f..0929d46 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -676,7 +676,6 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
 	if (batadv_is_wifi_netdev(in_dev))
 		tt_local->common.flags |= BATADV_TT_CLIENT_WIFI;
 	kref_init(&tt_local->common.refcount);
-	kref_get(&tt_local->common.refcount);
 	tt_local->last_seen = jiffies;
 	tt_local->common.added_at = tt_local->last_seen;
 	tt_local->vlan = vlan;
@@ -688,6 +687,7 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
 	    is_multicast_ether_addr(addr))
 		tt_local->common.flags |= BATADV_TT_CLIENT_NOPURGE;
 
+	kref_get(&tt_local->common.refcount);
 	hash_added = batadv_hash_add(bat_priv->tt.local_hash, batadv_compare_tt,
 				     batadv_choose_tt, &tt_local->common,
 				     &tt_local->common.hash_entry);
@@ -1351,9 +1351,9 @@ batadv_tt_global_orig_entry_add(struct batadv_tt_global_entry *tt_global,
 	orig_entry->orig_node = orig_node;
 	orig_entry->ttvn = ttvn;
 	kref_init(&orig_entry->refcount);
-	kref_get(&orig_entry->refcount);
 
 	spin_lock_bh(&tt_global->list_lock);
+	kref_get(&orig_entry->refcount);
 	hlist_add_head_rcu(&orig_entry->list,
 			   &tt_global->orig_list);
 	spin_unlock_bh(&tt_global->list_lock);
@@ -1428,13 +1428,13 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 		if (flags & BATADV_TT_CLIENT_ROAM)
 			tt_global_entry->roam_at = jiffies;
 		kref_init(&common->refcount);
-		kref_get(&common->refcount);
 		common->added_at = jiffies;
 
 		INIT_HLIST_HEAD(&tt_global_entry->orig_list);
 		atomic_set(&tt_global_entry->orig_list_count, 0);
 		spin_lock_init(&tt_global_entry->list_lock);
 
+		kref_get(&common->refcount);
 		hash_added = batadv_hash_add(bat_priv->tt.global_hash,
 					     batadv_compare_tt,
 					     batadv_choose_tt, common,
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index 8c59420..fde2193 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -257,8 +257,13 @@ void batadv_tvlv_container_register(struct batadv_priv *bat_priv,
 	spin_lock_bh(&bat_priv->tvlv.container_list_lock);
 	tvlv_old = batadv_tvlv_container_get(bat_priv, type, version);
 	batadv_tvlv_container_remove(bat_priv, tvlv_old);
+
+	kref_get(&tvlv_new->refcount);
 	hlist_add_head(&tvlv_new->list, &bat_priv->tvlv.container_list);
 	spin_unlock_bh(&bat_priv->tvlv.container_list_lock);
+
+	/* don't return reference to new tvlv_container */
+	batadv_tvlv_container_put(tvlv_new);
 }
 
 /**
@@ -542,8 +547,12 @@ void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
 	INIT_HLIST_NODE(&tvlv_handler->list);
 
 	spin_lock_bh(&bat_priv->tvlv.handler_list_lock);
+	kref_get(&tvlv_handler->refcount);
 	hlist_add_head_rcu(&tvlv_handler->list, &bat_priv->tvlv.handler_list);
 	spin_unlock_bh(&bat_priv->tvlv.handler_list_lock);
+
+	/* don't return reference to new tvlv_handler */
+	batadv_tvlv_handler_put(tvlv_handler);
 }
 
 /**
-- 
2.8.1


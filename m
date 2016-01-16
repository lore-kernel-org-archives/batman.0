Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 16 Jan 2016 10:29:58 +0100
Message-Id: <1452936598-28619-20-git-send-email-sven@narfation.org>
In-Reply-To: <1452936598-28619-1-git-send-email-sven@narfation.org>
References: <1452936598-28619-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v6 20/20] batman-adv: Rename *_free_ref
	function to *_put
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

The batman-adv source code is the only place in the kernel which uses the
*_free_ref naming scheme for the *_put functions. Changing it to *_put
makes it more consistent and makes it easier to understand the connection
to the *_get functions.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v6:
 - removed patches which are now applied in the branch next
 - rebased remaining patches on the patch
   "batman-adv: Avoid recursive call_rcu for batadv_nc_node" which was
   modified by Marek while he applied the patches (this unfortunately made
   some of the remaining patches slightly harder to apply)
v5:
 - add hack which allows to compile against stable kernel like 3.2.44 which
   also added the kref_get_unless_zero function
v4:
 - fix function names in commit messages
 - fix double whitespace in batadv_tt_orig_list_entry_release kerneldoc
 - add extra patch for batadv_claim_free_ref kerneldoc fix
 - change the phrase "free it" in all *_free_ref/*_put functions to "release it"
v3:
 - update copyright year
v2:
 - split patchset into fixes and kref migration to make it easier when the
   decision is made where each patch will be applied

 net/batman-adv/bat_iv_ogm.c            |  72 +++++++++---------
 net/batman-adv/bridge_loop_avoidance.c |  63 ++++++++--------
 net/batman-adv/distributed-arp-table.c |  24 +++---
 net/batman-adv/fragmentation.c         |   6 +-
 net/batman-adv/gateway_client.c        |  73 +++++++++---------
 net/batman-adv/hard-interface.c        |  20 ++---
 net/batman-adv/hard-interface.h        |   4 +-
 net/batman-adv/icmp_socket.c           |   6 +-
 net/batman-adv/main.c                  |  27 ++++---
 net/batman-adv/network-coding.c        |  38 +++++-----
 net/batman-adv/originator.c            |  76 +++++++++----------
 net/batman-adv/originator.h            |  12 +--
 net/batman-adv/routing.c               |  48 ++++++------
 net/batman-adv/send.c                  |  12 +--
 net/batman-adv/soft-interface.c        |  20 ++---
 net/batman-adv/soft-interface.h        |   2 +-
 net/batman-adv/sysfs.c                 |  12 +--
 net/batman-adv/translation-table.c     | 132 ++++++++++++++++-----------------
 18 files changed, 322 insertions(+), 325 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index bf0e7d6..5651e33 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -287,8 +287,8 @@ batadv_iv_ogm_orig_get(struct batadv_priv *bat_priv, const u8 *addr)
 
 free_orig_node:
 	/* free twice, as batadv_orig_node_new sets refcount to 2 */
-	batadv_orig_node_free_ref(orig_node);
-	batadv_orig_node_free_ref(orig_node);
+	batadv_orig_node_put(orig_node);
+	batadv_orig_node_put(orig_node);
 
 	return NULL;
 }
@@ -515,7 +515,7 @@ static void batadv_iv_ogm_emit(struct batadv_forw_packet *forw_packet)
 
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 }
 
 /**
@@ -617,7 +617,7 @@ batadv_iv_ogm_can_aggregate(const struct batadv_ogm_packet *new_bat_ogm_packet,
 
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 	return res;
 }
 
@@ -711,9 +711,9 @@ out_nomem:
 	if (!own_packet)
 		atomic_inc(&bat_priv->batman_queue_left);
 out_free_outgoing:
-	batadv_hardif_free_ref(if_outgoing);
+	batadv_hardif_put(if_outgoing);
 out_free_incoming:
-	batadv_hardif_free_ref(if_incoming);
+	batadv_hardif_put(if_incoming);
 }
 
 /* aggregate a new packet into the existing ogm packet */
@@ -958,7 +958,7 @@ static void batadv_iv_ogm_schedule(struct batadv_hard_iface *hard_iface)
 
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 }
 
 /**
@@ -1005,7 +1005,7 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 		    tmp_neigh_node->if_incoming == if_incoming &&
 		    kref_get_unless_zero(&tmp_neigh_node->refcount)) {
 			if (WARN(neigh_node, "too many matching neigh_nodes"))
-				batadv_neigh_node_free_ref(neigh_node);
+				batadv_neigh_node_put(neigh_node);
 			neigh_node = tmp_neigh_node;
 			continue;
 		}
@@ -1026,7 +1026,7 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 		neigh_ifinfo->bat_iv.tq_avg = tq_avg;
 		spin_unlock_bh(&tmp_neigh_node->ifinfo_lock);
 
-		batadv_neigh_ifinfo_free_ref(neigh_ifinfo);
+		batadv_neigh_ifinfo_put(neigh_ifinfo);
 		neigh_ifinfo = NULL;
 	}
 
@@ -1041,7 +1041,7 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 						     ethhdr->h_source,
 						     orig_node, orig_tmp);
 
-		batadv_orig_node_free_ref(orig_tmp);
+		batadv_orig_node_put(orig_tmp);
 		if (!neigh_node)
 			goto unlock;
 	} else {
@@ -1116,13 +1116,13 @@ unlock:
 	rcu_read_unlock();
 out:
 	if (neigh_node)
-		batadv_neigh_node_free_ref(neigh_node);
+		batadv_neigh_node_put(neigh_node);
 	if (router)
-		batadv_neigh_node_free_ref(router);
+		batadv_neigh_node_put(router);
 	if (neigh_ifinfo)
-		batadv_neigh_ifinfo_free_ref(neigh_ifinfo);
+		batadv_neigh_ifinfo_put(neigh_ifinfo);
 	if (router_ifinfo)
-		batadv_neigh_ifinfo_free_ref(router_ifinfo);
+		batadv_neigh_ifinfo_put(router_ifinfo);
 }
 
 /**
@@ -1192,7 +1192,7 @@ static int batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
 	neigh_ifinfo = batadv_neigh_ifinfo_new(neigh_node, if_outgoing);
 	if (neigh_ifinfo) {
 		neigh_rq_count = neigh_ifinfo->bat_iv.real_packet_count;
-		batadv_neigh_ifinfo_free_ref(neigh_ifinfo);
+		batadv_neigh_ifinfo_put(neigh_ifinfo);
 	} else {
 		neigh_rq_count = 0;
 	}
@@ -1265,7 +1265,7 @@ static int batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
 
 out:
 	if (neigh_node)
-		batadv_neigh_node_free_ref(neigh_node);
+		batadv_neigh_node_put(neigh_node);
 	return ret;
 }
 
@@ -1306,7 +1306,7 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 
 	orig_ifinfo = batadv_orig_ifinfo_new(orig_node, if_outgoing);
 	if (WARN_ON(!orig_ifinfo)) {
-		batadv_orig_node_free_ref(orig_node);
+		batadv_orig_node_put(orig_node);
 		return 0;
 	}
 
@@ -1353,7 +1353,7 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 		packet_count = bitmap_weight(bitmap,
 					     BATADV_TQ_LOCAL_WINDOW_SIZE);
 		neigh_ifinfo->bat_iv.real_packet_count = packet_count;
-		batadv_neigh_ifinfo_free_ref(neigh_ifinfo);
+		batadv_neigh_ifinfo_put(neigh_ifinfo);
 	}
 	rcu_read_unlock();
 
@@ -1367,8 +1367,8 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 
 out:
 	spin_unlock_bh(&orig_node->bat_iv.ogm_cnt_lock);
-	batadv_orig_node_free_ref(orig_node);
-	batadv_orig_ifinfo_free_ref(orig_ifinfo);
+	batadv_orig_node_put(orig_node);
+	batadv_orig_ifinfo_put(orig_ifinfo);
 	return ret;
 }
 
@@ -1514,7 +1514,7 @@ batadv_iv_ogm_process_per_outif(const struct sk_buff *skb, int ogm_offset,
 					  ogm_packet, if_incoming,
 					  if_outgoing, dup_status);
 	}
-	batadv_orig_ifinfo_free_ref(orig_ifinfo);
+	batadv_orig_ifinfo_put(orig_ifinfo);
 
 	/* only forward for specific interface, not for the default one. */
 	if (if_outgoing == BATADV_IF_DEFAULT)
@@ -1563,18 +1563,18 @@ batadv_iv_ogm_process_per_outif(const struct sk_buff *skb, int ogm_offset,
 
 out_neigh:
 	if ((orig_neigh_node) && (!is_single_hop_neigh))
-		batadv_orig_node_free_ref(orig_neigh_node);
+		batadv_orig_node_put(orig_neigh_node);
 out:
 	if (router_ifinfo)
-		batadv_neigh_ifinfo_free_ref(router_ifinfo);
+		batadv_neigh_ifinfo_put(router_ifinfo);
 	if (router)
-		batadv_neigh_node_free_ref(router);
+		batadv_neigh_node_put(router);
 	if (router_router)
-		batadv_neigh_node_free_ref(router_router);
+		batadv_neigh_node_put(router_router);
 	if (orig_neigh_router)
-		batadv_neigh_node_free_ref(orig_neigh_router);
+		batadv_neigh_node_put(orig_neigh_router);
 	if (hardif_neigh)
-		batadv_hardif_neigh_free_ref(hardif_neigh);
+		batadv_hardif_neigh_put(hardif_neigh);
 
 	kfree_skb(skb_priv);
 }
@@ -1697,7 +1697,7 @@ static void batadv_iv_ogm_process(const struct sk_buff *skb, int ogm_offset,
 
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Drop packet: originator packet from myself (via neighbor)\n");
-		batadv_orig_node_free_ref(orig_neigh_node);
+		batadv_orig_node_put(orig_neigh_node);
 		return;
 	}
 
@@ -1735,7 +1735,7 @@ static void batadv_iv_ogm_process(const struct sk_buff *skb, int ogm_offset,
 	}
 	rcu_read_unlock();
 
-	batadv_orig_node_free_ref(orig_node);
+	batadv_orig_node_put(orig_node);
 }
 
 static int batadv_iv_ogm_receive(struct sk_buff *skb,
@@ -1805,7 +1805,7 @@ batadv_iv_ogm_orig_print_neigh(struct batadv_orig_node *orig_node,
 			   neigh_node->addr,
 			   n_ifinfo->bat_iv.tq_avg);
 
-		batadv_neigh_ifinfo_free_ref(n_ifinfo);
+		batadv_neigh_ifinfo_put(n_ifinfo);
 	}
 }
 
@@ -1868,9 +1868,9 @@ static void batadv_iv_ogm_orig_print(struct batadv_priv *bat_priv,
 			batman_count++;
 
 next:
-			batadv_neigh_node_free_ref(neigh_node);
+			batadv_neigh_node_put(neigh_node);
 			if (n_ifinfo)
-				batadv_neigh_ifinfo_free_ref(n_ifinfo);
+				batadv_neigh_ifinfo_put(n_ifinfo);
 		}
 		rcu_read_unlock();
 	}
@@ -1964,9 +1964,9 @@ static int batadv_iv_ogm_neigh_cmp(struct batadv_neigh_node *neigh1,
 
 out:
 	if (neigh1_ifinfo)
-		batadv_neigh_ifinfo_free_ref(neigh1_ifinfo);
+		batadv_neigh_ifinfo_put(neigh1_ifinfo);
 	if (neigh2_ifinfo)
-		batadv_neigh_ifinfo_free_ref(neigh2_ifinfo);
+		batadv_neigh_ifinfo_put(neigh2_ifinfo);
 
 	return diff;
 }
@@ -2007,9 +2007,9 @@ batadv_iv_ogm_neigh_is_sob(struct batadv_neigh_node *neigh1,
 
 out:
 	if (neigh1_ifinfo)
-		batadv_neigh_ifinfo_free_ref(neigh1_ifinfo);
+		batadv_neigh_ifinfo_put(neigh1_ifinfo);
 	if (neigh2_ifinfo)
-		batadv_neigh_ifinfo_free_ref(neigh2_ifinfo);
+		batadv_neigh_ifinfo_put(neigh2_ifinfo);
 
 	return ret;
 }
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 7781f39..0a6c8b8 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -159,12 +159,11 @@ static void batadv_backbone_gw_release(struct kref *ref)
 }
 
 /**
- * batadv_backbone_gw_free_ref - decrement the backbone gw refcounter and
- *  possibly release it
+ * batadv_backbone_gw_put - decrement the backbone gw refcounter and possibly
+ *  release it
  * @backbone_gw: backbone gateway to be free'd
  */
-static void
-batadv_backbone_gw_free_ref(struct batadv_bla_backbone_gw *backbone_gw)
+static void batadv_backbone_gw_put(struct batadv_bla_backbone_gw *backbone_gw)
 {
 	kref_put(&backbone_gw->refcount, batadv_backbone_gw_release);
 }
@@ -180,16 +179,16 @@ static void batadv_claim_release(struct kref *ref)
 
 	claim = container_of(ref, struct batadv_bla_claim, refcount);
 
-	batadv_backbone_gw_free_ref(claim->backbone_gw);
+	batadv_backbone_gw_put(claim->backbone_gw);
 	kfree_rcu(claim, rcu);
 }
 
 /**
- * batadv_claim_free_ref - decrement the claim refcounter and possibly
+ * batadv_claim_put - decrement the claim refcounter and possibly
  *  release it
  * @claim: claim to be free'd
  */
-static void batadv_claim_free_ref(struct batadv_bla_claim *claim)
+static void batadv_claim_put(struct batadv_bla_claim *claim)
 {
 	kref_put(&claim->refcount, batadv_claim_release);
 }
@@ -305,7 +304,7 @@ batadv_bla_del_backbone_claims(struct batadv_bla_backbone_gw *backbone_gw)
 			if (claim->backbone_gw != backbone_gw)
 				continue;
 
-			batadv_claim_free_ref(claim);
+			batadv_claim_put(claim);
 			hlist_del_rcu(&claim->hash_entry);
 		}
 		spin_unlock_bh(list_lock);
@@ -424,7 +423,7 @@ static void batadv_bla_send_claim(struct batadv_priv *bat_priv, u8 *mac,
 	netif_rx(skb);
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 }
 
 /**
@@ -486,7 +485,7 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, u8 *orig,
 	if (orig_node) {
 		batadv_tt_global_del_orig(bat_priv, orig_node, vid,
 					  "became a backbone gateway");
-		batadv_orig_node_free_ref(orig_node);
+		batadv_orig_node_put(orig_node);
 	}
 
 	if (own_backbone) {
@@ -524,7 +523,7 @@ batadv_bla_update_own_backbone_gw(struct batadv_priv *bat_priv,
 		return;
 
 	backbone_gw->lasttime = jiffies;
-	batadv_backbone_gw_free_ref(backbone_gw);
+	batadv_backbone_gw_put(backbone_gw);
 }
 
 /**
@@ -573,7 +572,7 @@ static void batadv_bla_answer_request(struct batadv_priv *bat_priv,
 
 	/* finally, send an announcement frame */
 	batadv_bla_send_announce(bat_priv, backbone_gw);
-	batadv_backbone_gw_free_ref(backbone_gw);
+	batadv_backbone_gw_put(backbone_gw);
 }
 
 /**
@@ -682,7 +681,7 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 		spin_lock_bh(&claim->backbone_gw->crc_lock);
 		claim->backbone_gw->crc ^= crc16(0, claim->addr, ETH_ALEN);
 		spin_unlock_bh(&claim->backbone_gw->crc_lock);
-		batadv_backbone_gw_free_ref(claim->backbone_gw);
+		batadv_backbone_gw_put(claim->backbone_gw);
 	}
 	/* set (new) backbone gw */
 	kref_get(&backbone_gw->refcount);
@@ -694,7 +693,7 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 	backbone_gw->lasttime = jiffies;
 
 claim_free_ref:
-	batadv_claim_free_ref(claim);
+	batadv_claim_put(claim);
 }
 
 /**
@@ -719,14 +718,14 @@ static void batadv_bla_del_claim(struct batadv_priv *bat_priv,
 
 	batadv_hash_remove(bat_priv->bla.claim_hash, batadv_compare_claim,
 			   batadv_choose_claim, claim);
-	batadv_claim_free_ref(claim); /* reference from the hash is gone */
+	batadv_claim_put(claim); /* reference from the hash is gone */
 
 	spin_lock_bh(&claim->backbone_gw->crc_lock);
 	claim->backbone_gw->crc ^= crc16(0, claim->addr, ETH_ALEN);
 	spin_unlock_bh(&claim->backbone_gw->crc_lock);
 
 	/* don't need the reference from hash_find() anymore */
-	batadv_claim_free_ref(claim);
+	batadv_claim_put(claim);
 }
 
 /**
@@ -783,7 +782,7 @@ static int batadv_handle_announce(struct batadv_priv *bat_priv, u8 *an_addr,
 		}
 	}
 
-	batadv_backbone_gw_free_ref(backbone_gw);
+	batadv_backbone_gw_put(backbone_gw);
 	return 1;
 }
 
@@ -854,7 +853,7 @@ static int batadv_handle_unclaim(struct batadv_priv *bat_priv,
 		   claim_addr, BATADV_PRINT_VID(vid), backbone_gw->orig);
 
 	batadv_bla_del_claim(bat_priv, claim_addr, vid);
-	batadv_backbone_gw_free_ref(backbone_gw);
+	batadv_backbone_gw_put(backbone_gw);
 	return 1;
 }
 
@@ -891,7 +890,7 @@ static int batadv_handle_claim(struct batadv_priv *bat_priv,
 
 	/* TODO: we could call something like tt_local_del() here. */
 
-	batadv_backbone_gw_free_ref(backbone_gw);
+	batadv_backbone_gw_put(backbone_gw);
 	return 1;
 }
 
@@ -965,7 +964,7 @@ static int batadv_check_claim_group(struct batadv_priv *bat_priv,
 		bla_dst_own->group = bla_dst->group;
 	}
 
-	batadv_orig_node_free_ref(orig_node);
+	batadv_orig_node_put(orig_node);
 
 	return 2;
 }
@@ -1154,7 +1153,7 @@ purge_now:
 			batadv_bla_del_backbone_claims(backbone_gw);
 
 			hlist_del_rcu(&backbone_gw->hash_entry);
-			batadv_backbone_gw_free_ref(backbone_gw);
+			batadv_backbone_gw_put(backbone_gw);
 		}
 		spin_unlock_bh(list_lock);
 	}
@@ -1282,7 +1281,7 @@ void batadv_bla_status_update(struct net_device *net_dev)
 	 * so just call that one.
 	 */
 	batadv_bla_update_orig_address(bat_priv, primary_if, primary_if);
-	batadv_hardif_free_ref(primary_if);
+	batadv_hardif_put(primary_if);
 }
 
 /**
@@ -1356,7 +1355,7 @@ static void batadv_bla_periodic_work(struct work_struct *work)
 	}
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 
 	queue_delayed_work(batadv_event_workqueue, &bat_priv->bla.work,
 			   msecs_to_jiffies(BATADV_BLA_PERIOD_LENGTH));
@@ -1395,7 +1394,7 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
 	if (primary_if) {
 		crc = crc16(0, primary_if->net_dev->dev_addr, ETH_ALEN);
 		bat_priv->bla.claim_dest.group = htons(crc);
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 	} else {
 		bat_priv->bla.claim_dest.group = 0; /* will be set later */
 	}
@@ -1571,7 +1570,7 @@ int batadv_bla_is_backbone_gw(struct sk_buff *skb,
 	if (!backbone_gw)
 		return 0;
 
-	batadv_backbone_gw_free_ref(backbone_gw);
+	batadv_backbone_gw_put(backbone_gw);
 	return 1;
 }
 
@@ -1599,7 +1598,7 @@ void batadv_bla_free(struct batadv_priv *bat_priv)
 		bat_priv->bla.backbone_hash = NULL;
 	}
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 }
 
 /**
@@ -1692,9 +1691,9 @@ handled:
 
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 	if (claim)
-		batadv_claim_free_ref(claim);
+		batadv_claim_put(claim);
 	return ret;
 }
 
@@ -1781,9 +1780,9 @@ handled:
 	ret = 1;
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 	if (claim)
-		batadv_claim_free_ref(claim);
+		batadv_claim_put(claim);
 	return ret;
 }
 
@@ -1839,7 +1838,7 @@ int batadv_bla_claim_table_seq_print_text(struct seq_file *seq, void *offset)
 	}
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 	return 0;
 }
 
@@ -1904,6 +1903,6 @@ int batadv_bla_backbone_table_seq_print_text(struct seq_file *seq, void *offset)
 	}
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 	return 0;
 }
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index e326111..4c9b69d 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -77,11 +77,11 @@ static void batadv_dat_entry_release(struct kref *ref)
 }
 
 /**
- * batadv_dat_entry_free_ref - decrement the dat_entry refcounter and possibly
+ * batadv_dat_entry_put - decrement the dat_entry refcounter and possibly
  *  release it
  * @dat_entry: dat_entry to be free'd
  */
-static void batadv_dat_entry_free_ref(struct batadv_dat_entry *dat_entry)
+static void batadv_dat_entry_put(struct batadv_dat_entry *dat_entry)
 {
 	kref_put(&dat_entry->refcount, batadv_dat_entry_release);
 }
@@ -135,7 +135,7 @@ static void __batadv_dat_purge(struct batadv_priv *bat_priv,
 				continue;
 
 			hlist_del_rcu(&dat_entry->hash_entry);
-			batadv_dat_entry_free_ref(dat_entry);
+			batadv_dat_entry_put(dat_entry);
 		}
 		spin_unlock_bh(list_lock);
 	}
@@ -349,7 +349,7 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 
 	if (unlikely(hash_added != 0)) {
 		/* remove the reference for the hash */
-		batadv_dat_entry_free_ref(dat_entry);
+		batadv_dat_entry_put(dat_entry);
 		goto out;
 	}
 
@@ -358,7 +358,7 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 
 out:
 	if (dat_entry)
-		batadv_dat_entry_free_ref(dat_entry);
+		batadv_dat_entry_put(dat_entry);
 }
 
 #ifdef CONFIG_BATMAN_ADV_DEBUG
@@ -547,7 +547,7 @@ static void batadv_choose_next_candidate(struct batadv_priv *bat_priv,
 
 			max = tmp_max;
 			if (max_orig_node)
-				batadv_orig_node_free_ref(max_orig_node);
+				batadv_orig_node_put(max_orig_node);
 			max_orig_node = orig_node;
 		}
 		rcu_read_unlock();
@@ -674,9 +674,9 @@ static bool batadv_dat_send_data(struct batadv_priv *bat_priv,
 			ret = true;
 		}
 free_neigh:
-		batadv_neigh_node_free_ref(neigh_node);
+		batadv_neigh_node_put(neigh_node);
 free_orig:
-		batadv_orig_node_free_ref(cand[i].orig_node);
+		batadv_orig_node_put(cand[i].orig_node);
 	}
 
 out:
@@ -840,7 +840,7 @@ int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset)
 
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 	return 0;
 }
 
@@ -1029,7 +1029,7 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 	}
 out:
 	if (dat_entry)
-		batadv_dat_entry_free_ref(dat_entry);
+		batadv_dat_entry_put(dat_entry);
 	return ret;
 }
 
@@ -1109,7 +1109,7 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 	}
 out:
 	if (dat_entry)
-		batadv_dat_entry_free_ref(dat_entry);
+		batadv_dat_entry_put(dat_entry);
 	if (ret)
 		kfree_skb(skb);
 	return ret;
@@ -1262,6 +1262,6 @@ bool batadv_dat_drop_broadcast_packet(struct batadv_priv *bat_priv,
 
 out:
 	if (dat_entry)
-		batadv_dat_entry_free_ref(dat_entry);
+		batadv_dat_entry_put(dat_entry);
 	return ret;
 }
diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 55656e8..adb9c39 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -385,9 +385,9 @@ bool batadv_frag_skb_fwd(struct sk_buff *skb,
 
 out:
 	if (orig_node_dst)
-		batadv_orig_node_free_ref(orig_node_dst);
+		batadv_orig_node_put(orig_node_dst);
 	if (neigh_node)
-		batadv_neigh_node_free_ref(neigh_node);
+		batadv_neigh_node_put(neigh_node);
 	return ret;
 }
 
@@ -512,7 +512,7 @@ bool batadv_frag_send_packet(struct sk_buff *skb,
 
 out_err:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 
 	return ret;
 }
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 261866e..346d5f7 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -71,16 +71,15 @@ static void batadv_gw_node_release(struct kref *ref)
 
 	gw_node = container_of(ref, struct batadv_gw_node, refcount);
 
-	batadv_orig_node_free_ref(gw_node->orig_node);
+	batadv_orig_node_put(gw_node->orig_node);
 	kfree_rcu(gw_node, rcu);
 }
 
 /**
- * batadv_gw_node_free_ref - decrement the gw_node refcounter and possibly
- *  release it
+ * batadv_gw_node_put - decrement the gw_node refcounter and possibly release it
  * @gw_node: gateway node to free
  */
-static void batadv_gw_node_free_ref(struct batadv_gw_node *gw_node)
+static void batadv_gw_node_put(struct batadv_gw_node *gw_node)
 {
 	kref_put(&gw_node->refcount, batadv_gw_node_release);
 }
@@ -125,7 +124,7 @@ unlock:
 	rcu_read_unlock();
 out:
 	if (gw_node)
-		batadv_gw_node_free_ref(gw_node);
+		batadv_gw_node_put(gw_node);
 	return orig_node;
 }
 
@@ -143,7 +142,7 @@ static void batadv_gw_select(struct batadv_priv *bat_priv,
 	rcu_assign_pointer(bat_priv->gw.curr_gw, new_gw_node);
 
 	if (curr_gw_node)
-		batadv_gw_node_free_ref(curr_gw_node);
+		batadv_gw_node_put(curr_gw_node);
 
 	spin_unlock_bh(&bat_priv->gw.list_lock);
 }
@@ -204,7 +203,7 @@ batadv_gw_get_best_gw_node(struct batadv_priv *bat_priv)
 			    ((tmp_gw_factor == max_gw_factor) &&
 			     (tq_avg > max_tq))) {
 				if (curr_gw)
-					batadv_gw_node_free_ref(curr_gw);
+					batadv_gw_node_put(curr_gw);
 				curr_gw = gw_node;
 				kref_get(&curr_gw->refcount);
 			}
@@ -219,7 +218,7 @@ batadv_gw_get_best_gw_node(struct batadv_priv *bat_priv)
 			  */
 			if (tq_avg > max_tq) {
 				if (curr_gw)
-					batadv_gw_node_free_ref(curr_gw);
+					batadv_gw_node_put(curr_gw);
 				curr_gw = gw_node;
 				kref_get(&curr_gw->refcount);
 			}
@@ -232,12 +231,12 @@ batadv_gw_get_best_gw_node(struct batadv_priv *bat_priv)
 		if (tmp_gw_factor > max_gw_factor)
 			max_gw_factor = tmp_gw_factor;
 
-		batadv_gw_node_free_ref(gw_node);
+		batadv_gw_node_put(gw_node);
 
 next:
-		batadv_neigh_node_free_ref(router);
+		batadv_neigh_node_put(router);
 		if (router_ifinfo)
-			batadv_neigh_ifinfo_free_ref(router_ifinfo);
+			batadv_neigh_ifinfo_put(router_ifinfo);
 	}
 	rcu_read_unlock();
 
@@ -273,7 +272,7 @@ void batadv_gw_check_client_stop(struct batadv_priv *bat_priv)
 	 */
 	batadv_throw_uevent(bat_priv, BATADV_UEV_GW, BATADV_UEV_DEL, NULL);
 
-	batadv_gw_node_free_ref(curr_gw);
+	batadv_gw_node_put(curr_gw);
 }
 
 void batadv_gw_election(struct batadv_priv *bat_priv)
@@ -348,13 +347,13 @@ void batadv_gw_election(struct batadv_priv *bat_priv)
 
 out:
 	if (curr_gw)
-		batadv_gw_node_free_ref(curr_gw);
+		batadv_gw_node_put(curr_gw);
 	if (next_gw)
-		batadv_gw_node_free_ref(next_gw);
+		batadv_gw_node_put(next_gw);
 	if (router)
-		batadv_neigh_node_free_ref(router);
+		batadv_neigh_node_put(router);
 	if (router_ifinfo)
-		batadv_neigh_ifinfo_free_ref(router_ifinfo);
+		batadv_neigh_ifinfo_put(router_ifinfo);
 }
 
 void batadv_gw_check_election(struct batadv_priv *bat_priv,
@@ -415,15 +414,15 @@ reselect:
 	batadv_gw_reselect(bat_priv);
 out:
 	if (curr_gw_orig)
-		batadv_orig_node_free_ref(curr_gw_orig);
+		batadv_orig_node_put(curr_gw_orig);
 	if (router_gw)
-		batadv_neigh_node_free_ref(router_gw);
+		batadv_neigh_node_put(router_gw);
 	if (router_orig)
-		batadv_neigh_node_free_ref(router_orig);
+		batadv_neigh_node_put(router_orig);
 	if (router_gw_tq)
-		batadv_neigh_ifinfo_free_ref(router_gw_tq);
+		batadv_neigh_ifinfo_put(router_gw_tq);
 	if (router_orig_tq)
-		batadv_neigh_ifinfo_free_ref(router_orig_tq);
+		batadv_neigh_ifinfo_put(router_orig_tq);
 }
 
 /**
@@ -446,7 +445,7 @@ static void batadv_gw_node_add(struct batadv_priv *bat_priv,
 
 	gw_node = kzalloc(sizeof(*gw_node), GFP_ATOMIC);
 	if (!gw_node) {
-		batadv_orig_node_free_ref(orig_node);
+		batadv_orig_node_put(orig_node);
 		return;
 	}
 
@@ -548,19 +547,19 @@ void batadv_gw_node_update(struct batadv_priv *bat_priv,
 		hlist_del_init_rcu(&gw_node->list);
 		spin_unlock_bh(&bat_priv->gw.list_lock);
 
-		batadv_gw_node_free_ref(gw_node);
+		batadv_gw_node_put(gw_node);
 
 		curr_gw = batadv_gw_get_selected_gw_node(bat_priv);
 		if (gw_node == curr_gw)
 			batadv_gw_reselect(bat_priv);
 
 		if (curr_gw)
-			batadv_gw_node_free_ref(curr_gw);
+			batadv_gw_node_put(curr_gw);
 	}
 
 out:
 	if (gw_node)
-		batadv_gw_node_free_ref(gw_node);
+		batadv_gw_node_put(gw_node);
 }
 
 void batadv_gw_node_delete(struct batadv_priv *bat_priv,
@@ -583,7 +582,7 @@ void batadv_gw_node_free(struct batadv_priv *bat_priv)
 	hlist_for_each_entry_safe(gw_node, node_tmp,
 				  &bat_priv->gw.list, list) {
 		hlist_del_init_rcu(&gw_node->list);
-		batadv_gw_node_free_ref(gw_node);
+		batadv_gw_node_put(gw_node);
 	}
 	spin_unlock_bh(&bat_priv->gw.list_lock);
 }
@@ -620,12 +619,12 @@ static int batadv_write_buffer_text(struct batadv_priv *bat_priv,
 	ret = seq_has_overflowed(seq) ? -1 : 0;
 
 	if (curr_gw)
-		batadv_gw_node_free_ref(curr_gw);
+		batadv_gw_node_put(curr_gw);
 out:
 	if (router_ifinfo)
-		batadv_neigh_ifinfo_free_ref(router_ifinfo);
+		batadv_neigh_ifinfo_put(router_ifinfo);
 	if (router)
-		batadv_neigh_node_free_ref(router);
+		batadv_neigh_node_put(router);
 	return ret;
 }
 
@@ -662,7 +661,7 @@ int batadv_gw_client_seq_print_text(struct seq_file *seq, void *offset)
 
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 	return 0;
 }
 
@@ -856,7 +855,7 @@ bool batadv_gw_out_of_range(struct batadv_priv *bat_priv,
 			goto out;
 
 		curr_tq_avg = curr_ifinfo->bat_iv.tq_avg;
-		batadv_neigh_ifinfo_free_ref(curr_ifinfo);
+		batadv_neigh_ifinfo_put(curr_ifinfo);
 
 		break;
 	case BATADV_GW_MODE_OFF:
@@ -874,18 +873,18 @@ bool batadv_gw_out_of_range(struct batadv_priv *bat_priv,
 
 	if ((curr_tq_avg - old_ifinfo->bat_iv.tq_avg) > BATADV_GW_THRESHOLD)
 		out_of_range = true;
-	batadv_neigh_ifinfo_free_ref(old_ifinfo);
+	batadv_neigh_ifinfo_put(old_ifinfo);
 
 out:
 	if (orig_dst_node)
-		batadv_orig_node_free_ref(orig_dst_node);
+		batadv_orig_node_put(orig_dst_node);
 	if (curr_gw)
-		batadv_gw_node_free_ref(curr_gw);
+		batadv_gw_node_put(curr_gw);
 	if (gw_node)
-		batadv_gw_node_free_ref(gw_node);
+		batadv_gw_node_put(gw_node);
 	if (neigh_old)
-		batadv_neigh_node_free_ref(neigh_old);
+		batadv_neigh_node_put(neigh_old);
 	if (neigh_curr)
-		batadv_neigh_node_free_ref(neigh_curr);
+		batadv_neigh_node_put(neigh_curr);
 	return out_of_range;
 }
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index fb2d9c0..d6229fb 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -201,7 +201,7 @@ static void batadv_primary_if_update_addr(struct batadv_priv *bat_priv,
 	batadv_bla_update_orig_address(bat_priv, primary_if, oldif);
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 }
 
 static void batadv_primary_if_select(struct batadv_priv *bat_priv,
@@ -225,7 +225,7 @@ static void batadv_primary_if_select(struct batadv_priv *bat_priv,
 
 out:
 	if (curr_hard_iface)
-		batadv_hardif_free_ref(curr_hard_iface);
+		batadv_hardif_put(curr_hard_iface);
 }
 
 static bool
@@ -384,7 +384,7 @@ batadv_hardif_activate_interface(struct batadv_hard_iface *hard_iface)
 
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 }
 
 static void
@@ -537,7 +537,7 @@ err_dev:
 	hard_iface->soft_iface = NULL;
 	dev_put(soft_iface);
 err:
-	batadv_hardif_free_ref(hard_iface);
+	batadv_hardif_put(hard_iface);
 	return ret;
 }
 
@@ -568,7 +568,7 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface,
 		batadv_primary_if_select(bat_priv, new_if);
 
 		if (new_if)
-			batadv_hardif_free_ref(new_if);
+			batadv_hardif_put(new_if);
 	}
 
 	bat_priv->bat_algo_ops->bat_iface_disable(hard_iface);
@@ -591,11 +591,11 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface,
 	}
 
 	hard_iface->soft_iface = NULL;
-	batadv_hardif_free_ref(hard_iface);
+	batadv_hardif_put(hard_iface);
 
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 }
 
 /**
@@ -614,7 +614,7 @@ static void batadv_hardif_remove_interface_finish(struct work_struct *work)
 
 	batadv_debugfs_del_hardif(hard_iface);
 	batadv_sysfs_del_hardif(&hard_iface->hardif_obj);
-	batadv_hardif_free_ref(hard_iface);
+	batadv_hardif_put(hard_iface);
 }
 
 static struct batadv_hard_iface *
@@ -769,10 +769,10 @@ static int batadv_hard_if_event(struct notifier_block *this,
 	}
 
 hardif_put:
-	batadv_hardif_free_ref(hard_iface);
+	batadv_hardif_put(hard_iface);
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 	return NOTIFY_DONE;
 }
 
diff --git a/net/batman-adv/hard-interface.h b/net/batman-adv/hard-interface.h
index 5cecc6b..d74f198 100644
--- a/net/batman-adv/hard-interface.h
+++ b/net/batman-adv/hard-interface.h
@@ -64,11 +64,11 @@ void batadv_update_min_mtu(struct net_device *soft_iface);
 void batadv_hardif_release(struct kref *ref);
 
 /**
- * batadv_hardif_free_ref - decrement the hard interface refcounter and possibly
+ * batadv_hardif_put - decrement the hard interface refcounter and possibly
  *  release it
  * @hard_iface: the hard interface to free
  */
-static inline void batadv_hardif_free_ref(struct batadv_hard_iface *hard_iface)
+static inline void batadv_hardif_put(struct batadv_hard_iface *hard_iface)
 {
 	kref_put(&hard_iface->refcount, batadv_hardif_release);
 }
diff --git a/net/batman-adv/icmp_socket.c b/net/batman-adv/icmp_socket.c
index a69da37..6268f08 100644
--- a/net/batman-adv/icmp_socket.c
+++ b/net/batman-adv/icmp_socket.c
@@ -288,11 +288,11 @@ free_skb:
 	kfree_skb(skb);
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 	if (neigh_node)
-		batadv_neigh_node_free_ref(neigh_node);
+		batadv_neigh_node_put(neigh_node);
 	if (orig_node)
-		batadv_orig_node_free_ref(orig_node);
+		batadv_orig_node_put(orig_node);
 	return len;
 }
 
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 568c550..e3d7051 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -287,7 +287,7 @@ batadv_seq_print_text_primary_if_get(struct seq_file *seq)
 	seq_printf(seq,
 		   "BATMAN mesh %s disabled - primary interface not active\n",
 		   net_dev->name);
-	batadv_hardif_free_ref(primary_if);
+	batadv_hardif_put(primary_if);
 	primary_if = NULL;
 
 out:
@@ -638,12 +638,11 @@ static void batadv_tvlv_handler_release(struct kref *ref)
 }
 
 /**
- * batadv_tvlv_handler_free_ref - decrement the tvlv container refcounter and
+ * batadv_tvlv_handler_put - decrement the tvlv container refcounter and
  *  possibly release it
  * @tvlv_handler: the tvlv handler to free
  */
-static void
-batadv_tvlv_handler_free_ref(struct batadv_tvlv_handler *tvlv_handler)
+static void batadv_tvlv_handler_put(struct batadv_tvlv_handler *tvlv_handler)
 {
 	kref_put(&tvlv_handler->refcount, batadv_tvlv_handler_release);
 }
@@ -695,11 +694,11 @@ static void batadv_tvlv_container_release(struct kref *ref)
 }
 
 /**
- * batadv_tvlv_container_free_ref - decrement the tvlv container refcounter and
+ * batadv_tvlv_container_put - decrement the tvlv container refcounter and
  *  possibly release it
  * @tvlv: the tvlv container to free
  */
-static void batadv_tvlv_container_free_ref(struct batadv_tvlv_container *tvlv)
+static void batadv_tvlv_container_put(struct batadv_tvlv_container *tvlv)
 {
 	kref_put(&tvlv->refcount, batadv_tvlv_container_release);
 }
@@ -785,8 +784,8 @@ static void batadv_tvlv_container_remove(struct batadv_priv *bat_priv,
 	hlist_del(&tvlv->list);
 
 	/* first call to decrement the counter, second call to free */
-	batadv_tvlv_container_free_ref(tvlv);
-	batadv_tvlv_container_free_ref(tvlv);
+	batadv_tvlv_container_put(tvlv);
+	batadv_tvlv_container_put(tvlv);
 }
 
 /**
@@ -1031,7 +1030,7 @@ int batadv_tvlv_containers_process(struct batadv_priv *bat_priv,
 						src, dst, tvlv_value,
 						tvlv_value_cont_len);
 		if (tvlv_handler)
-			batadv_tvlv_handler_free_ref(tvlv_handler);
+			batadv_tvlv_handler_put(tvlv_handler);
 		tvlv_value = (u8 *)tvlv_value + tvlv_value_cont_len;
 		tvlv_value_len -= tvlv_value_cont_len;
 	}
@@ -1111,7 +1110,7 @@ void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
 
 	tvlv_handler = batadv_tvlv_handler_get(bat_priv, type, version);
 	if (tvlv_handler) {
-		batadv_tvlv_handler_free_ref(tvlv_handler);
+		batadv_tvlv_handler_put(tvlv_handler);
 		return;
 	}
 
@@ -1148,11 +1147,11 @@ void batadv_tvlv_handler_unregister(struct batadv_priv *bat_priv,
 	if (!tvlv_handler)
 		return;
 
-	batadv_tvlv_handler_free_ref(tvlv_handler);
+	batadv_tvlv_handler_put(tvlv_handler);
 	spin_lock_bh(&bat_priv->tvlv.handler_list_lock);
 	hlist_del_rcu(&tvlv_handler->list);
 	spin_unlock_bh(&bat_priv->tvlv.handler_list_lock);
-	batadv_tvlv_handler_free_ref(tvlv_handler);
+	batadv_tvlv_handler_put(tvlv_handler);
 }
 
 /**
@@ -1212,7 +1211,7 @@ void batadv_tvlv_unicast_send(struct batadv_priv *bat_priv, u8 *src,
 	if (batadv_send_skb_to_orig(skb, orig_node, NULL) == NET_XMIT_DROP)
 		kfree_skb(skb);
 out:
-	batadv_orig_node_free_ref(orig_node);
+	batadv_orig_node_put(orig_node);
 }
 
 /**
@@ -1262,7 +1261,7 @@ bool batadv_vlan_ap_isola_get(struct batadv_priv *bat_priv, unsigned short vid)
 	vlan = batadv_softif_vlan_get(bat_priv, vid);
 	if (vlan) {
 		ap_isolation_enabled = atomic_read(&vlan->ap_isolation);
-		batadv_softif_vlan_free_ref(vlan);
+		batadv_softif_vlan_put(vlan);
 	}
 
 	return ap_isolation_enabled;
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index a4eb8ee..d253bb2 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -218,16 +218,16 @@ static void batadv_nc_node_release(struct kref *ref)
 
 	nc_node = container_of(ref, struct batadv_nc_node, refcount);
 
-	batadv_orig_node_free_ref(nc_node->orig_node);
+	batadv_orig_node_put(nc_node->orig_node);
 	kfree_rcu(nc_node, rcu);
 }
 
 /**
- * batadv_nc_node_free_ref - decrement the nc_node refcounter and possibly
+ * batadv_nc_node_put - decrement the nc_node refcounter and possibly
  *  release it
  * @nc_node: nc_node to be free'd
  */
-static void batadv_nc_node_free_ref(struct batadv_nc_node *nc_node)
+static void batadv_nc_node_put(struct batadv_nc_node *nc_node)
 {
 	kref_put(&nc_node->refcount, batadv_nc_node_release);
 }
@@ -247,11 +247,11 @@ static void batadv_nc_path_release(struct kref *ref)
 }
 
 /**
- * batadv_nc_path_free_ref - decrement the nc_path refcounter and possibly
+ * batadv_nc_path_put - decrement the nc_path refcounter and possibly
  *  release it
  * @nc_path: nc_path to be free'd
  */
-static void batadv_nc_path_free_ref(struct batadv_nc_path *nc_path)
+static void batadv_nc_path_put(struct batadv_nc_path *nc_path)
 {
 	kref_put(&nc_path->refcount, batadv_nc_path_release);
 }
@@ -263,7 +263,7 @@ static void batadv_nc_path_free_ref(struct batadv_nc_path *nc_path)
 static void batadv_nc_packet_free(struct batadv_nc_packet *nc_packet)
 {
 	kfree_skb(nc_packet->skb);
-	batadv_nc_path_free_ref(nc_packet->nc_path);
+	batadv_nc_path_put(nc_packet->nc_path);
 	kfree(nc_packet);
 }
 
@@ -356,7 +356,7 @@ batadv_nc_purge_orig_nc_nodes(struct batadv_priv *bat_priv,
 			   "Removing nc_node %pM -> %pM\n",
 			   nc_node->addr, nc_node->orig_node->orig);
 		list_del_rcu(&nc_node->list);
-		batadv_nc_node_free_ref(nc_node);
+		batadv_nc_node_put(nc_node);
 	}
 	spin_unlock_bh(lock);
 }
@@ -467,7 +467,7 @@ static void batadv_nc_purge_paths(struct batadv_priv *bat_priv,
 				   "Remove nc_path %pM -> %pM\n",
 				   nc_path->prev_hop, nc_path->next_hop);
 			hlist_del_rcu(&nc_path->hash_entry);
-			batadv_nc_path_free_ref(nc_path);
+			batadv_nc_path_put(nc_path);
 		}
 		spin_unlock_bh(lock);
 	}
@@ -772,7 +772,7 @@ static bool batadv_can_nc_with_orig(struct batadv_priv *bat_priv,
 
 	last_ttl = orig_ifinfo->last_ttl;
 	last_real_seqno = orig_ifinfo->last_real_seqno;
-	batadv_orig_ifinfo_free_ref(orig_ifinfo);
+	batadv_orig_ifinfo_put(orig_ifinfo);
 
 	if (last_real_seqno != ntohl(ogm_packet->seqno))
 		return false;
@@ -942,9 +942,9 @@ void batadv_nc_update_nc_node(struct batadv_priv *bat_priv,
 
 out:
 	if (in_nc_node)
-		batadv_nc_node_free_ref(in_nc_node);
+		batadv_nc_node_put(in_nc_node);
 	if (out_nc_node)
-		batadv_nc_node_free_ref(out_nc_node);
+		batadv_nc_node_put(out_nc_node);
 }
 
 /**
@@ -1228,13 +1228,13 @@ static bool batadv_nc_code_packets(struct batadv_priv *bat_priv,
 	res = true;
 out:
 	if (router_neigh)
-		batadv_neigh_node_free_ref(router_neigh);
+		batadv_neigh_node_put(router_neigh);
 	if (router_coding)
-		batadv_neigh_node_free_ref(router_coding);
+		batadv_neigh_node_put(router_coding);
 	if (router_neigh_ifinfo)
-		batadv_neigh_ifinfo_free_ref(router_neigh_ifinfo);
+		batadv_neigh_ifinfo_put(router_neigh_ifinfo);
 	if (router_coding_ifinfo)
-		batadv_neigh_ifinfo_free_ref(router_coding_ifinfo);
+		batadv_neigh_ifinfo_put(router_coding_ifinfo);
 	return res;
 }
 
@@ -1372,7 +1372,7 @@ batadv_nc_skb_src_search(struct batadv_priv *bat_priv,
 	}
 	rcu_read_unlock();
 
-	batadv_orig_node_free_ref(orig_node);
+	batadv_orig_node_put(orig_node);
 	return nc_packet;
 }
 
@@ -1555,7 +1555,7 @@ bool batadv_nc_skb_forward(struct sk_buff *skb,
 	return true;
 
 free_nc_path:
-	batadv_nc_path_free_ref(nc_path);
+	batadv_nc_path_put(nc_path);
 out:
 	/* Packet is not consumed */
 	return false;
@@ -1617,7 +1617,7 @@ void batadv_nc_skb_store_for_decoding(struct batadv_priv *bat_priv,
 free_skb:
 	kfree_skb(skb);
 free_nc_path:
-	batadv_nc_path_free_ref(nc_path);
+	batadv_nc_path_put(nc_path);
 out:
 	return;
 }
@@ -1950,7 +1950,7 @@ int batadv_nc_nodes_seq_print_text(struct seq_file *seq, void *offset)
 
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 	return 0;
 }
 
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index eacd0e5..e4cbb07 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -151,11 +151,11 @@ static void batadv_orig_node_vlan_release(struct kref *ref)
 }
 
 /**
- * batadv_orig_node_vlan_free_ref - decrement the refcounter and possibly
- *  release the originator-vlan object
+ * batadv_orig_node_vlan_put - decrement the refcounter and possibly release
+ *  the originator-vlan object
  * @orig_vlan: the originator-vlan object to release
  */
-void batadv_orig_node_vlan_free_ref(struct batadv_orig_node_vlan *orig_vlan)
+void batadv_orig_node_vlan_put(struct batadv_orig_node_vlan *orig_vlan)
 {
 	kref_put(&orig_vlan->refcount, batadv_orig_node_vlan_release);
 }
@@ -196,17 +196,17 @@ static void batadv_neigh_ifinfo_release(struct kref *ref)
 	neigh_ifinfo = container_of(ref, struct batadv_neigh_ifinfo, refcount);
 
 	if (neigh_ifinfo->if_outgoing != BATADV_IF_DEFAULT)
-		batadv_hardif_free_ref(neigh_ifinfo->if_outgoing);
+		batadv_hardif_put(neigh_ifinfo->if_outgoing);
 
 	kfree_rcu(neigh_ifinfo, rcu);
 }
 
 /**
- * batadv_neigh_ifinfo_free_ref - decrement the refcounter and possibly release
+ * batadv_neigh_ifinfo_put - decrement the refcounter and possibly release
  *  the neigh_ifinfo
  * @neigh_ifinfo: the neigh_ifinfo object to release
  */
-void batadv_neigh_ifinfo_free_ref(struct batadv_neigh_ifinfo *neigh_ifinfo)
+void batadv_neigh_ifinfo_put(struct batadv_neigh_ifinfo *neigh_ifinfo)
 {
 	kref_put(&neigh_ifinfo->refcount, batadv_neigh_ifinfo_release);
 }
@@ -227,16 +227,16 @@ static void batadv_hardif_neigh_release(struct kref *ref)
 	hlist_del_init_rcu(&hardif_neigh->list);
 	spin_unlock_bh(&hardif_neigh->if_incoming->neigh_list_lock);
 
-	batadv_hardif_free_ref(hardif_neigh->if_incoming);
+	batadv_hardif_put(hardif_neigh->if_incoming);
 	kfree_rcu(hardif_neigh, rcu);
 }
 
 /**
- * batadv_hardif_neigh_free_ref - decrement the hardif neighbors refcounter
+ * batadv_hardif_neigh_put - decrement the hardif neighbors refcounter
  *  and possibly release it
  * @hardif_neigh: hardif neigh neighbor to free
  */
-void batadv_hardif_neigh_free_ref(struct batadv_hardif_neigh_node *hardif_neigh)
+void batadv_hardif_neigh_put(struct batadv_hardif_neigh_node *hardif_neigh)
 {
 	kref_put(&hardif_neigh->refcount, batadv_hardif_neigh_release);
 }
@@ -259,31 +259,31 @@ static void batadv_neigh_node_release(struct kref *ref)
 
 	hlist_for_each_entry_safe(neigh_ifinfo, node_tmp,
 				  &neigh_node->ifinfo_list, list) {
-		batadv_neigh_ifinfo_free_ref(neigh_ifinfo);
+		batadv_neigh_ifinfo_put(neigh_ifinfo);
 	}
 
 	hardif_neigh = batadv_hardif_neigh_get(neigh_node->if_incoming,
 					       neigh_node->addr);
 	if (hardif_neigh) {
 		/* batadv_hardif_neigh_get() increases refcount too */
-		batadv_hardif_neigh_free_ref(hardif_neigh);
-		batadv_hardif_neigh_free_ref(hardif_neigh);
+		batadv_hardif_neigh_put(hardif_neigh);
+		batadv_hardif_neigh_put(hardif_neigh);
 	}
 
 	if (bao->bat_neigh_free)
 		bao->bat_neigh_free(neigh_node);
 
-	batadv_hardif_free_ref(neigh_node->if_incoming);
+	batadv_hardif_put(neigh_node->if_incoming);
 
 	kfree_rcu(neigh_node, rcu);
 }
 
 /**
- * batadv_neigh_node_free_ref - decrement the neighbors refcounter and possibly
+ * batadv_neigh_node_put - decrement the neighbors refcounter and possibly
  *  release it
  * @neigh_node: neigh neighbor to free
  */
-void batadv_neigh_node_free_ref(struct batadv_neigh_node *neigh_node)
+void batadv_neigh_node_put(struct batadv_neigh_node *neigh_node)
 {
 	kref_put(&neigh_node->refcount, batadv_neigh_node_release);
 }
@@ -544,7 +544,7 @@ batadv_hardif_neigh_create(struct batadv_hard_iface *hard_iface,
 
 	hardif_neigh = kzalloc(sizeof(*hardif_neigh), GFP_ATOMIC);
 	if (!hardif_neigh) {
-		batadv_hardif_free_ref(hard_iface);
+		batadv_hardif_put(hard_iface);
 		goto out;
 	}
 
@@ -681,7 +681,7 @@ batadv_neigh_node_new(struct batadv_orig_node *orig_node,
 
 out:
 	if (hardif_neigh)
-		batadv_hardif_neigh_free_ref(hardif_neigh);
+		batadv_hardif_neigh_put(hardif_neigh);
 	return neigh_node;
 }
 
@@ -707,7 +707,7 @@ int batadv_hardif_neigh_seq_print_text(struct seq_file *seq, void *offset)
 		   primary_if->net_dev->dev_addr, net_dev->name,
 		   bat_priv->bat_algo_ops->name);
 
-	batadv_hardif_free_ref(primary_if);
+	batadv_hardif_put(primary_if);
 
 	if (!bat_priv->bat_algo_ops->bat_neigh_print) {
 		seq_puts(seq,
@@ -732,22 +732,22 @@ static void batadv_orig_ifinfo_release(struct kref *ref)
 	orig_ifinfo = container_of(ref, struct batadv_orig_ifinfo, refcount);
 
 	if (orig_ifinfo->if_outgoing != BATADV_IF_DEFAULT)
-		batadv_hardif_free_ref(orig_ifinfo->if_outgoing);
+		batadv_hardif_put(orig_ifinfo->if_outgoing);
 
 	/* this is the last reference to this object */
 	router = rcu_dereference_protected(orig_ifinfo->router, true);
 	if (router)
-		batadv_neigh_node_free_ref(router);
+		batadv_neigh_node_put(router);
 
 	kfree_rcu(orig_ifinfo, rcu);
 }
 
 /**
- * batadv_orig_ifinfo_free_ref - decrement the refcounter and possibly release
+ * batadv_orig_ifinfo_put - decrement the refcounter and possibly release
  *  the orig_ifinfo
  * @orig_ifinfo: the orig_ifinfo object to release
  */
-void batadv_orig_ifinfo_free_ref(struct batadv_orig_ifinfo *orig_ifinfo)
+void batadv_orig_ifinfo_put(struct batadv_orig_ifinfo *orig_ifinfo)
 {
 	kref_put(&orig_ifinfo->refcount, batadv_orig_ifinfo_release);
 }
@@ -793,13 +793,13 @@ static void batadv_orig_node_release(struct kref *ref)
 	hlist_for_each_entry_safe(neigh_node, node_tmp,
 				  &orig_node->neigh_list, list) {
 		hlist_del_rcu(&neigh_node->list);
-		batadv_neigh_node_free_ref(neigh_node);
+		batadv_neigh_node_put(neigh_node);
 	}
 
 	hlist_for_each_entry_safe(orig_ifinfo, node_tmp,
 				  &orig_node->ifinfo_list, list) {
 		hlist_del_rcu(&orig_ifinfo->list);
-		batadv_orig_ifinfo_free_ref(orig_ifinfo);
+		batadv_orig_ifinfo_put(orig_ifinfo);
 	}
 	spin_unlock_bh(&orig_node->neigh_list_lock);
 
@@ -810,11 +810,11 @@ static void batadv_orig_node_release(struct kref *ref)
 }
 
 /**
- * batadv_orig_node_free_ref - decrement the orig node refcounter and possibly
+ * batadv_orig_node_put - decrement the orig node refcounter and possibly
  *  release it
  * @orig_node: the orig node to free
  */
-void batadv_orig_node_free_ref(struct batadv_orig_node *orig_node)
+void batadv_orig_node_put(struct batadv_orig_node *orig_node)
 {
 	kref_put(&orig_node->refcount, batadv_orig_node_release);
 }
@@ -843,7 +843,7 @@ void batadv_originator_free(struct batadv_priv *bat_priv)
 		hlist_for_each_entry_safe(orig_node, node_tmp,
 					  head, hash_entry) {
 			hlist_del_rcu(&orig_node->hash_entry);
-			batadv_orig_node_free_ref(orig_node);
+			batadv_orig_node_put(orig_node);
 		}
 		spin_unlock_bh(list_lock);
 	}
@@ -917,7 +917,7 @@ struct batadv_orig_node *batadv_orig_node_new(struct batadv_priv *bat_priv,
 	 * Immediately release vlan since it is not needed anymore in this
 	 * context
 	 */
-	batadv_orig_node_vlan_free_ref(vlan);
+	batadv_orig_node_vlan_put(vlan);
 
 	for (i = 0; i < BATADV_FRAG_BUFFER_COUNT; i++) {
 		INIT_HLIST_HEAD(&orig_node->fragments[i].head);
@@ -966,7 +966,7 @@ batadv_purge_neigh_ifinfo(struct batadv_priv *bat_priv,
 			   neigh->addr, if_outgoing->net_dev->name);
 
 		hlist_del_rcu(&neigh_ifinfo->list);
-		batadv_neigh_ifinfo_free_ref(neigh_ifinfo);
+		batadv_neigh_ifinfo_put(neigh_ifinfo);
 	}
 
 	spin_unlock_bh(&neigh->ifinfo_lock);
@@ -1012,10 +1012,10 @@ batadv_purge_orig_ifinfo(struct batadv_priv *bat_priv,
 		ifinfo_purged = true;
 
 		hlist_del_rcu(&orig_ifinfo->list);
-		batadv_orig_ifinfo_free_ref(orig_ifinfo);
+		batadv_orig_ifinfo_put(orig_ifinfo);
 		if (orig_node->last_bonding_candidate == orig_ifinfo) {
 			orig_node->last_bonding_candidate = NULL;
-			batadv_orig_ifinfo_free_ref(orig_ifinfo);
+			batadv_orig_ifinfo_put(orig_ifinfo);
 		}
 	}
 
@@ -1069,7 +1069,7 @@ batadv_purge_orig_neighbors(struct batadv_priv *bat_priv,
 			neigh_purged = true;
 
 			hlist_del_rcu(&neigh_node->list);
-			batadv_neigh_node_free_ref(neigh_node);
+			batadv_neigh_node_put(neigh_node);
 		} else {
 			/* only necessary if not the whole neighbor is to be
 			 * deleted, but some interface has been removed.
@@ -1108,7 +1108,7 @@ batadv_find_best_neighbor(struct batadv_priv *bat_priv,
 			continue;
 
 		if (best)
-			batadv_neigh_node_free_ref(best);
+			batadv_neigh_node_put(best);
 
 		best = neigh;
 	}
@@ -1154,7 +1154,7 @@ static bool batadv_purge_orig_node(struct batadv_priv *bat_priv,
 	batadv_update_route(bat_priv, orig_node, BATADV_IF_DEFAULT,
 			    best_neigh_node);
 	if (best_neigh_node)
-		batadv_neigh_node_free_ref(best_neigh_node);
+		batadv_neigh_node_put(best_neigh_node);
 
 	/* ... then for all other interfaces. */
 	rcu_read_lock();
@@ -1171,7 +1171,7 @@ static bool batadv_purge_orig_node(struct batadv_priv *bat_priv,
 		batadv_update_route(bat_priv, orig_node, hard_iface,
 				    best_neigh_node);
 		if (best_neigh_node)
-			batadv_neigh_node_free_ref(best_neigh_node);
+			batadv_neigh_node_put(best_neigh_node);
 	}
 	rcu_read_unlock();
 
@@ -1204,7 +1204,7 @@ static void _batadv_purge_orig(struct batadv_priv *bat_priv)
 				batadv_tt_global_del_orig(orig_node->bat_priv,
 							  orig_node, -1,
 							  "originator timed out");
-				batadv_orig_node_free_ref(orig_node);
+				batadv_orig_node_put(orig_node);
 				continue;
 			}
 
@@ -1250,7 +1250,7 @@ int batadv_orig_seq_print_text(struct seq_file *seq, void *offset)
 		   primary_if->net_dev->dev_addr, net_dev->name,
 		   bat_priv->bat_algo_ops->name);
 
-	batadv_hardif_free_ref(primary_if);
+	batadv_hardif_put(primary_if);
 
 	if (!bat_priv->bat_algo_ops->bat_orig_print) {
 		seq_puts(seq,
@@ -1306,7 +1306,7 @@ int batadv_orig_hardif_seq_print_text(struct seq_file *seq, void *offset)
 
 out:
 	if (hard_iface)
-		batadv_hardif_free_ref(hard_iface);
+		batadv_hardif_put(hard_iface);
 	return 0;
 }
 
diff --git a/net/batman-adv/originator.h b/net/batman-adv/originator.h
index 9950740..4e8b67f 100644
--- a/net/batman-adv/originator.h
+++ b/net/batman-adv/originator.h
@@ -37,19 +37,19 @@ int batadv_compare_orig(const struct hlist_node *node, const void *data2);
 int batadv_originator_init(struct batadv_priv *bat_priv);
 void batadv_originator_free(struct batadv_priv *bat_priv);
 void batadv_purge_orig_ref(struct batadv_priv *bat_priv);
-void batadv_orig_node_free_ref(struct batadv_orig_node *orig_node);
+void batadv_orig_node_put(struct batadv_orig_node *orig_node);
 struct batadv_orig_node *batadv_orig_node_new(struct batadv_priv *bat_priv,
 					      const u8 *addr);
 struct batadv_hardif_neigh_node *
 batadv_hardif_neigh_get(const struct batadv_hard_iface *hard_iface,
 			const u8 *neigh_addr);
 void
-batadv_hardif_neigh_free_ref(struct batadv_hardif_neigh_node *hardif_neigh);
+batadv_hardif_neigh_put(struct batadv_hardif_neigh_node *hardif_neigh);
 struct batadv_neigh_node *
 batadv_neigh_node_new(struct batadv_orig_node *orig_node,
 		      struct batadv_hard_iface *hard_iface,
 		      const u8 *neigh_addr);
-void batadv_neigh_node_free_ref(struct batadv_neigh_node *neigh_node);
+void batadv_neigh_node_put(struct batadv_neigh_node *neigh_node);
 struct batadv_neigh_node *
 batadv_orig_router_get(struct batadv_orig_node *orig_node,
 		       const struct batadv_hard_iface *if_outgoing);
@@ -59,7 +59,7 @@ batadv_neigh_ifinfo_new(struct batadv_neigh_node *neigh,
 struct batadv_neigh_ifinfo *
 batadv_neigh_ifinfo_get(struct batadv_neigh_node *neigh,
 			struct batadv_hard_iface *if_outgoing);
-void batadv_neigh_ifinfo_free_ref(struct batadv_neigh_ifinfo *neigh_ifinfo);
+void batadv_neigh_ifinfo_put(struct batadv_neigh_ifinfo *neigh_ifinfo);
 
 int batadv_hardif_neigh_seq_print_text(struct seq_file *seq, void *offset);
 
@@ -69,7 +69,7 @@ batadv_orig_ifinfo_get(struct batadv_orig_node *orig_node,
 struct batadv_orig_ifinfo *
 batadv_orig_ifinfo_new(struct batadv_orig_node *orig_node,
 		       struct batadv_hard_iface *if_outgoing);
-void batadv_orig_ifinfo_free_ref(struct batadv_orig_ifinfo *orig_ifinfo);
+void batadv_orig_ifinfo_put(struct batadv_orig_ifinfo *orig_ifinfo);
 
 int batadv_orig_seq_print_text(struct seq_file *seq, void *offset);
 int batadv_orig_hardif_seq_print_text(struct seq_file *seq, void *offset);
@@ -83,7 +83,7 @@ batadv_orig_node_vlan_new(struct batadv_orig_node *orig_node,
 struct batadv_orig_node_vlan *
 batadv_orig_node_vlan_get(struct batadv_orig_node *orig_node,
 			  unsigned short vid);
-void batadv_orig_node_vlan_free_ref(struct batadv_orig_node_vlan *orig_vlan);
+void batadv_orig_node_vlan_put(struct batadv_orig_node_vlan *orig_vlan);
 
 /* hashfunction to choose an entry in a hash table of given size
  * hash algorithm from http://en.wikipedia.org/wiki/Hash_table
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 205310b..4dd646a 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -98,7 +98,7 @@ static void _batadv_update_route(struct batadv_priv *bat_priv,
 	}
 
 	if (curr_router)
-		batadv_neigh_node_free_ref(curr_router);
+		batadv_neigh_node_put(curr_router);
 
 	/* increase refcount of new best neighbor */
 	if (neigh_node && !kref_get_unless_zero(&neigh_node->refcount))
@@ -107,11 +107,11 @@ static void _batadv_update_route(struct batadv_priv *bat_priv,
 	spin_lock_bh(&orig_node->neigh_list_lock);
 	rcu_assign_pointer(orig_ifinfo->router, neigh_node);
 	spin_unlock_bh(&orig_node->neigh_list_lock);
-	batadv_orig_ifinfo_free_ref(orig_ifinfo);
+	batadv_orig_ifinfo_put(orig_ifinfo);
 
 	/* decrease refcount of previous best neighbor */
 	if (curr_router)
-		batadv_neigh_node_free_ref(curr_router);
+		batadv_neigh_node_put(curr_router);
 }
 
 /**
@@ -138,7 +138,7 @@ void batadv_update_route(struct batadv_priv *bat_priv,
 
 out:
 	if (router)
-		batadv_neigh_node_free_ref(router);
+		batadv_neigh_node_put(router);
 }
 
 /**
@@ -269,9 +269,9 @@ static int batadv_recv_my_icmp_packet(struct batadv_priv *bat_priv,
 	}
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 	if (orig_node)
-		batadv_orig_node_free_ref(orig_node);
+		batadv_orig_node_put(orig_node);
 	return ret;
 }
 
@@ -317,9 +317,9 @@ static int batadv_recv_icmp_ttl_exceeded(struct batadv_priv *bat_priv,
 
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 	if (orig_node)
-		batadv_orig_node_free_ref(orig_node);
+		batadv_orig_node_put(orig_node);
 	return ret;
 }
 
@@ -403,7 +403,7 @@ int batadv_recv_icmp_packet(struct sk_buff *skb,
 
 out:
 	if (orig_node)
-		batadv_orig_node_free_ref(orig_node);
+		batadv_orig_node_put(orig_node);
 	return ret;
 }
 
@@ -545,16 +545,16 @@ batadv_find_router(struct batadv_priv *bat_priv,
 next:
 		/* free references */
 		if (cand_router) {
-			batadv_neigh_node_free_ref(cand_router);
+			batadv_neigh_node_put(cand_router);
 			cand_router = NULL;
 		}
-		batadv_orig_ifinfo_free_ref(cand);
+		batadv_orig_ifinfo_put(cand);
 	}
 	rcu_read_unlock();
 
 	/* last_bonding_candidate is reset below, remove the old reference. */
 	if (orig_node->last_bonding_candidate)
-		batadv_orig_ifinfo_free_ref(orig_node->last_bonding_candidate);
+		batadv_orig_ifinfo_put(orig_node->last_bonding_candidate);
 
 	/* After finding candidates, handle the three cases:
 	 * 1) there is a next candidate, use that
@@ -562,17 +562,17 @@ next:
 	 * 3) there is no candidate at all, return the default router
 	 */
 	if (next_candidate) {
-		batadv_neigh_node_free_ref(router);
+		batadv_neigh_node_put(router);
 
 		/* remove references to first candidate, we don't need it. */
 		if (first_candidate) {
-			batadv_neigh_node_free_ref(first_candidate_router);
-			batadv_orig_ifinfo_free_ref(first_candidate);
+			batadv_neigh_node_put(first_candidate_router);
+			batadv_orig_ifinfo_put(first_candidate);
 		}
 		router = next_candidate_router;
 		orig_node->last_bonding_candidate = next_candidate;
 	} else if (first_candidate) {
-		batadv_neigh_node_free_ref(router);
+		batadv_neigh_node_put(router);
 
 		/* refcounting has already been done in the loop above. */
 		router = first_candidate_router;
@@ -649,7 +649,7 @@ static int batadv_route_unicast_packet(struct sk_buff *skb,
 
 out:
 	if (orig_node)
-		batadv_orig_node_free_ref(orig_node);
+		batadv_orig_node_put(orig_node);
 	return ret;
 }
 
@@ -702,9 +702,9 @@ batadv_reroute_unicast_packet(struct batadv_priv *bat_priv,
 	ret = true;
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 	if (orig_node)
-		batadv_orig_node_free_ref(orig_node);
+		batadv_orig_node_put(orig_node);
 
 	return ret;
 }
@@ -768,7 +768,7 @@ static int batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 			return 0;
 
 		curr_ttvn = (u8)atomic_read(&orig_node->last_ttvn);
-		batadv_orig_node_free_ref(orig_node);
+		batadv_orig_node_put(orig_node);
 	}
 
 	/* check if the TTVN contained in the packet is fresher than what the
@@ -808,7 +808,7 @@ static int batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 
 	ether_addr_copy(unicast_packet->dest, primary_if->net_dev->dev_addr);
 
-	batadv_hardif_free_ref(primary_if);
+	batadv_hardif_put(primary_if);
 
 	unicast_packet->ttvn = curr_ttvn;
 
@@ -908,7 +908,7 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 
 rx_success:
 		if (orig_node)
-			batadv_orig_node_free_ref(orig_node);
+			batadv_orig_node_put(orig_node);
 
 		return NET_RX_SUCCESS;
 	}
@@ -1019,7 +1019,7 @@ int batadv_recv_frag_packet(struct sk_buff *skb,
 
 out:
 	if (orig_node_src)
-		batadv_orig_node_free_ref(orig_node_src);
+		batadv_orig_node_put(orig_node_src);
 
 	return ret;
 }
@@ -1124,6 +1124,6 @@ spin_unlock:
 	spin_unlock_bh(&orig_node->bcast_seqno_lock);
 out:
 	if (orig_node)
-		batadv_orig_node_free_ref(orig_node);
+		batadv_orig_node_put(orig_node);
 	return ret;
 }
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index d8b03fd..caff32c 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -153,7 +153,7 @@ int batadv_send_skb_to_orig(struct sk_buff *skb,
 
 out:
 	if (neigh_node)
-		batadv_neigh_node_free_ref(neigh_node);
+		batadv_neigh_node_put(neigh_node);
 
 	return ret;
 }
@@ -246,7 +246,7 @@ bool batadv_send_skb_prepare_unicast_4addr(struct batadv_priv *bat_priv,
 	ret = true;
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 	return ret;
 }
 
@@ -317,7 +317,7 @@ int batadv_send_skb_unicast(struct batadv_priv *bat_priv,
 
 out:
 	if (orig_node)
-		batadv_orig_node_free_ref(orig_node);
+		batadv_orig_node_put(orig_node);
 	if (ret == NET_XMIT_DROP)
 		kfree_skb(skb);
 	return ret;
@@ -409,9 +409,9 @@ static void batadv_forw_packet_free(struct batadv_forw_packet *forw_packet)
 {
 	kfree_skb(forw_packet->skb);
 	if (forw_packet->if_incoming)
-		batadv_hardif_free_ref(forw_packet->if_incoming);
+		batadv_hardif_put(forw_packet->if_incoming);
 	if (forw_packet->if_outgoing)
-		batadv_hardif_free_ref(forw_packet->if_outgoing);
+		batadv_hardif_put(forw_packet->if_outgoing);
 	kfree(forw_packet);
 }
 
@@ -497,7 +497,7 @@ out_and_inc:
 	atomic_inc(&bat_priv->bcast_queue_left);
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 	return NETDEV_TX_BUSY;
 }
 
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index d4490ff..0710379 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -377,7 +377,7 @@ dropped_freed:
 	batadv_inc_counter(bat_priv, BATADV_CNT_TX_DROPPED);
 end:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 	return NETDEV_TX_OK;
 }
 
@@ -497,11 +497,11 @@ static void batadv_softif_vlan_release(struct kref *ref)
 }
 
 /**
- * batadv_softif_vlan_free_ref - decrease the vlan object refcounter and
+ * batadv_softif_vlan_put - decrease the vlan object refcounter and
  *  possibly release it
  * @vlan: the vlan object to release
  */
-void batadv_softif_vlan_free_ref(struct batadv_softif_vlan *vlan)
+void batadv_softif_vlan_put(struct batadv_softif_vlan *vlan)
 {
 	if (!vlan)
 		return;
@@ -552,7 +552,7 @@ int batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
 
 	vlan = batadv_softif_vlan_get(bat_priv, vid);
 	if (vlan) {
-		batadv_softif_vlan_free_ref(vlan);
+		batadv_softif_vlan_put(vlan);
 		return -EEXIST;
 	}
 
@@ -601,7 +601,7 @@ static void batadv_softif_destroy_vlan(struct batadv_priv *bat_priv,
 			       vlan->vid, "vlan interface destroyed", false);
 
 	batadv_sysfs_del_vlan(bat_priv, vlan);
-	batadv_softif_vlan_free_ref(vlan);
+	batadv_softif_vlan_put(vlan);
 }
 
 /**
@@ -646,7 +646,7 @@ static int batadv_interface_add_vid(struct net_device *dev, __be16 proto,
 	if (!vlan->kobj) {
 		ret = batadv_sysfs_add_vlan(bat_priv->soft_iface, vlan);
 		if (ret) {
-			batadv_softif_vlan_free_ref(vlan);
+			batadv_softif_vlan_put(vlan);
 			return ret;
 		}
 	}
@@ -693,7 +693,7 @@ static int batadv_interface_kill_vid(struct net_device *dev, __be16 proto,
 	batadv_softif_destroy_vlan(bat_priv, vlan);
 
 	/* finally free the vlan object */
-	batadv_softif_vlan_free_ref(vlan);
+	batadv_softif_vlan_put(vlan);
 
 	return 0;
 }
@@ -749,7 +749,7 @@ static void batadv_softif_destroy_finish(struct work_struct *work)
 	vlan = batadv_softif_vlan_get(bat_priv, BATADV_NO_FLAGS);
 	if (vlan) {
 		batadv_softif_destroy_vlan(bat_priv, vlan);
-		batadv_softif_vlan_free_ref(vlan);
+		batadv_softif_vlan_put(vlan);
 	}
 
 	batadv_sysfs_del_meshif(soft_iface);
@@ -878,7 +878,7 @@ static int batadv_softif_slave_add(struct net_device *dev,
 
 out:
 	if (hard_iface)
-		batadv_hardif_free_ref(hard_iface);
+		batadv_hardif_put(hard_iface);
 	return ret;
 }
 
@@ -905,7 +905,7 @@ static int batadv_softif_slave_del(struct net_device *dev,
 
 out:
 	if (hard_iface)
-		batadv_hardif_free_ref(hard_iface);
+		batadv_hardif_put(hard_iface);
 	return ret;
 }
 
diff --git a/net/batman-adv/soft-interface.h b/net/batman-adv/soft-interface.h
index d17cfba..9ae2657 100644
--- a/net/batman-adv/soft-interface.h
+++ b/net/batman-adv/soft-interface.h
@@ -34,7 +34,7 @@ void batadv_softif_destroy_sysfs(struct net_device *soft_iface);
 int batadv_softif_is_valid(const struct net_device *net_dev);
 extern struct rtnl_link_ops batadv_link_ops;
 int batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid);
-void batadv_softif_vlan_free_ref(struct batadv_softif_vlan *softif_vlan);
+void batadv_softif_vlan_put(struct batadv_softif_vlan *softif_vlan);
 struct batadv_softif_vlan *batadv_softif_vlan_get(struct batadv_priv *bat_priv,
 						  unsigned short vid);
 
diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index ab4382b..4d70d44 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -216,7 +216,7 @@ ssize_t batadv_store_vlan_##_name(struct kobject *kobj,			\
 					      attr, &vlan->_name,	\
 					      bat_priv->soft_iface);	\
 									\
-	batadv_softif_vlan_free_ref(vlan);				\
+	batadv_softif_vlan_put(vlan);					\
 	return res;							\
 }
 
@@ -231,7 +231,7 @@ ssize_t batadv_show_vlan_##_name(struct kobject *kobj,			\
 			     atomic_read(&vlan->_name) == 0 ?		\
 			     "disabled" : "enabled");			\
 									\
-	batadv_softif_vlan_free_ref(vlan);				\
+	batadv_softif_vlan_put(vlan);					\
 	return res;							\
 }
 
@@ -771,7 +771,7 @@ static ssize_t batadv_show_mesh_iface(struct kobject *kobj,
 
 	length = sprintf(buff, "%s\n", ifname);
 
-	batadv_hardif_free_ref(hard_iface);
+	batadv_hardif_put(hard_iface);
 
 	return length;
 }
@@ -795,7 +795,7 @@ static ssize_t batadv_store_mesh_iface(struct kobject *kobj,
 	if (strlen(buff) >= IFNAMSIZ) {
 		pr_err("Invalid parameter for 'mesh_iface' setting received: interface name too long '%s'\n",
 		       buff);
-		batadv_hardif_free_ref(hard_iface);
+		batadv_hardif_put(hard_iface);
 		return -EINVAL;
 	}
 
@@ -829,7 +829,7 @@ static ssize_t batadv_store_mesh_iface(struct kobject *kobj,
 unlock:
 	rtnl_unlock();
 out:
-	batadv_hardif_free_ref(hard_iface);
+	batadv_hardif_put(hard_iface);
 	return ret;
 }
 
@@ -863,7 +863,7 @@ static ssize_t batadv_show_iface_status(struct kobject *kobj,
 		break;
 	}
 
-	batadv_hardif_free_ref(hard_iface);
+	batadv_hardif_put(hard_iface);
 
 	return length;
 }
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 1188279..2fd5b28 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -219,12 +219,12 @@ static void batadv_tt_local_entry_release(struct kref *ref)
 }
 
 /**
- * batadv_tt_local_entry_free_ref - decrement the tt_local_entry refcounter and
+ * batadv_tt_local_entry_put - decrement the tt_local_entry refcounter and
  *  possibly release it
  * @tt_local_entry: tt_local_entry to be free'd
  */
 static void
-batadv_tt_local_entry_free_ref(struct batadv_tt_local_entry *tt_local_entry)
+batadv_tt_local_entry_put(struct batadv_tt_local_entry *tt_local_entry)
 {
 	kref_put(&tt_local_entry->common.refcount,
 		 batadv_tt_local_entry_release);
@@ -247,12 +247,12 @@ static void batadv_tt_global_entry_release(struct kref *ref)
 }
 
 /**
- * batadv_tt_global_entry_free_ref - decrement the tt_global_entry refcounter
- *  and possibly release it
+ * batadv_tt_global_entry_put - decrement the tt_global_entry refcounter and
+ *  possibly release it
  * @tt_global_entry: tt_global_entry to be free'd
  */
 static void
-batadv_tt_global_entry_free_ref(struct batadv_tt_global_entry *tt_global_entry)
+batadv_tt_global_entry_put(struct batadv_tt_global_entry *tt_global_entry)
 {
 	kref_put(&tt_global_entry->common.refcount,
 		 batadv_tt_global_entry_release);
@@ -278,7 +278,7 @@ int batadv_tt_global_hash_count(struct batadv_priv *bat_priv,
 		return 0;
 
 	count = atomic_read(&tt_global_entry->orig_list_count);
-	batadv_tt_global_entry_free_ref(tt_global_entry);
+	batadv_tt_global_entry_put(tt_global_entry);
 
 	return count;
 }
@@ -301,7 +301,7 @@ static void batadv_tt_local_size_mod(struct batadv_priv *bat_priv,
 
 	atomic_add(v, &vlan->tt.num_entries);
 
-	batadv_softif_vlan_free_ref(vlan);
+	batadv_softif_vlan_put(vlan);
 }
 
 /**
@@ -348,10 +348,10 @@ static void batadv_tt_global_size_mod(struct batadv_orig_node *orig_node,
 		spin_lock_bh(&orig_node->vlan_list_lock);
 		hlist_del_init_rcu(&vlan->list);
 		spin_unlock_bh(&orig_node->vlan_list_lock);
-		batadv_orig_node_vlan_free_ref(vlan);
+		batadv_orig_node_vlan_put(vlan);
 	}
 
-	batadv_orig_node_vlan_free_ref(vlan);
+	batadv_orig_node_vlan_put(vlan);
 }
 
 /**
@@ -390,17 +390,17 @@ static void batadv_tt_orig_list_entry_release(struct kref *ref)
 	orig_entry = container_of(ref, struct batadv_tt_orig_list_entry,
 				  refcount);
 
-	batadv_orig_node_free_ref(orig_entry->orig_node);
+	batadv_orig_node_put(orig_entry->orig_node);
 	kfree_rcu(orig_entry, rcu);
 }
 
 /**
- * batadv_tt_orig_list_entry_free_ref - decrement the tt orig entry refcounter
- *  and possibly release it
+ * batadv_tt_orig_list_entry_put - decrement the tt orig entry refcounter and
+ *  possibly release it
  * @orig_entry: tt orig entry to be free'd
  */
 static void
-batadv_tt_orig_list_entry_free_ref(struct batadv_tt_orig_list_entry *orig_entry)
+batadv_tt_orig_list_entry_put(struct batadv_tt_orig_list_entry *orig_entry)
 {
 	kref_put(&orig_entry->refcount, batadv_tt_orig_list_entry_release);
 }
@@ -559,7 +559,7 @@ static void batadv_tt_global_free(struct batadv_priv *bat_priv,
 
 	batadv_hash_remove(bat_priv->tt.global_hash, batadv_compare_tt,
 			   batadv_choose_tt, &tt_global->common);
-	batadv_tt_global_entry_free_ref(tt_global);
+	batadv_tt_global_entry_put(tt_global);
 }
 
 /**
@@ -685,8 +685,8 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
 
 	if (unlikely(hash_added != 0)) {
 		/* remove the reference for the hash */
-		batadv_tt_local_entry_free_ref(tt_local);
-		batadv_softif_vlan_free_ref(vlan);
+		batadv_tt_local_entry_put(tt_local);
+		batadv_softif_vlan_put(vlan);
 		goto out;
 	}
 
@@ -752,9 +752,9 @@ out:
 	if (in_dev)
 		dev_put(in_dev);
 	if (tt_local)
-		batadv_tt_local_entry_free_ref(tt_local);
+		batadv_tt_local_entry_put(tt_local);
 	if (tt_global)
-		batadv_tt_global_entry_free_ref(tt_global);
+		batadv_tt_global_entry_put(tt_global);
 	return ret;
 }
 
@@ -1052,13 +1052,13 @@ int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 				   no_purge ? 0 : last_seen_msecs,
 				   vlan->tt.crc);
 
-			batadv_softif_vlan_free_ref(vlan);
+			batadv_softif_vlan_put(vlan);
 		}
 		rcu_read_unlock();
 	}
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 	return 0;
 }
 
@@ -1135,19 +1135,19 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 		goto out;
 
 	/* extra call to free the local tt entry */
-	batadv_tt_local_entry_free_ref(tt_local_entry);
+	batadv_tt_local_entry_put(tt_local_entry);
 
 	/* decrease the reference held for this vlan */
 	vlan = batadv_softif_vlan_get(bat_priv, vid);
 	if (!vlan)
 		goto out;
 
-	batadv_softif_vlan_free_ref(vlan);
-	batadv_softif_vlan_free_ref(vlan);
+	batadv_softif_vlan_put(vlan);
+	batadv_softif_vlan_put(vlan);
 
 out:
 	if (tt_local_entry)
-		batadv_tt_local_entry_free_ref(tt_local_entry);
+		batadv_tt_local_entry_put(tt_local_entry);
 
 	return curr_flags;
 }
@@ -1243,11 +1243,11 @@ static void batadv_tt_local_table_free(struct batadv_priv *bat_priv)
 			vlan = batadv_softif_vlan_get(bat_priv,
 						      tt_common_entry->vid);
 			if (vlan) {
-				batadv_softif_vlan_free_ref(vlan);
-				batadv_softif_vlan_free_ref(vlan);
+				batadv_softif_vlan_put(vlan);
+				batadv_softif_vlan_put(vlan);
 			}
 
-			batadv_tt_local_entry_free_ref(tt_local);
+			batadv_tt_local_entry_put(tt_local);
 		}
 		spin_unlock_bh(list_lock);
 	}
@@ -1343,7 +1343,7 @@ batadv_tt_global_entry_has_orig(const struct batadv_tt_global_entry *entry,
 	orig_entry = batadv_tt_global_orig_entry_find(entry, orig_node);
 	if (orig_entry) {
 		found = true;
-		batadv_tt_orig_list_entry_free_ref(orig_entry);
+		batadv_tt_orig_list_entry_put(orig_entry);
 	}
 
 	return found;
@@ -1384,7 +1384,7 @@ batadv_tt_global_orig_entry_add(struct batadv_tt_global_entry *tt_global,
 
 out:
 	if (orig_entry)
-		batadv_tt_orig_list_entry_free_ref(orig_entry);
+		batadv_tt_orig_list_entry_put(orig_entry);
 }
 
 /**
@@ -1465,7 +1465,7 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 
 		if (unlikely(hash_added != 0)) {
 			/* remove the reference for the hash */
-			batadv_tt_global_entry_free_ref(tt_global_entry);
+			batadv_tt_global_entry_put(tt_global_entry);
 			goto out_remove;
 		}
 	} else {
@@ -1551,9 +1551,9 @@ out_remove:
 
 out:
 	if (tt_global_entry)
-		batadv_tt_global_entry_free_ref(tt_global_entry);
+		batadv_tt_global_entry_put(tt_global_entry);
 	if (tt_local_entry)
-		batadv_tt_local_entry_free_ref(tt_local_entry);
+		batadv_tt_local_entry_put(tt_local_entry);
 	return ret;
 }
 
@@ -1584,20 +1584,20 @@ batadv_transtable_best_orig(struct batadv_priv *bat_priv,
 		if (best_router &&
 		    bao->bat_neigh_cmp(router, BATADV_IF_DEFAULT,
 				       best_router, BATADV_IF_DEFAULT) <= 0) {
-			batadv_neigh_node_free_ref(router);
+			batadv_neigh_node_put(router);
 			continue;
 		}
 
 		/* release the refcount for the "old" best */
 		if (best_router)
-			batadv_neigh_node_free_ref(best_router);
+			batadv_neigh_node_put(best_router);
 
 		best_entry = orig_entry;
 		best_router = router;
 	}
 
 	if (best_router)
-		batadv_neigh_node_free_ref(best_router);
+		batadv_neigh_node_put(best_router);
 
 	return best_entry;
 }
@@ -1650,7 +1650,7 @@ batadv_tt_global_print_entry(struct batadv_priv *bat_priv,
 			   ((flags & BATADV_TT_CLIENT_ISOLA) ? 'I' : '.'),
 			   ((flags & BATADV_TT_CLIENT_TEMP) ? 'T' : '.'));
 
-		batadv_orig_node_vlan_free_ref(vlan);
+		batadv_orig_node_vlan_put(vlan);
 	}
 
 print_list:
@@ -1682,7 +1682,7 @@ print_list:
 			   ((flags & BATADV_TT_CLIENT_ISOLA) ? 'I' : '.'),
 			   ((flags & BATADV_TT_CLIENT_TEMP) ? 'T' : '.'));
 
-		batadv_orig_node_vlan_free_ref(vlan);
+		batadv_orig_node_vlan_put(vlan);
 	}
 }
 
@@ -1723,7 +1723,7 @@ int batadv_tt_global_seq_print_text(struct seq_file *seq, void *offset)
 	}
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 	return 0;
 }
 
@@ -1751,7 +1751,7 @@ _batadv_tt_global_del_orig_entry(struct batadv_tt_global_entry *tt_global_entry,
 	 * being part of a list
 	 */
 	hlist_del_rcu(&orig_entry->list);
-	batadv_tt_orig_list_entry_free_ref(orig_entry);
+	batadv_tt_orig_list_entry_put(orig_entry);
 }
 
 /* deletes the orig list of a tt_global_entry */
@@ -1907,9 +1907,9 @@ static void batadv_tt_global_del(struct batadv_priv *bat_priv,
 
 out:
 	if (tt_global_entry)
-		batadv_tt_global_entry_free_ref(tt_global_entry);
+		batadv_tt_global_entry_put(tt_global_entry);
 	if (local_entry)
-		batadv_tt_local_entry_free_ref(local_entry);
+		batadv_tt_local_entry_put(local_entry);
 }
 
 /**
@@ -1963,7 +1963,7 @@ void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
 					   tt_global->common.addr,
 					   BATADV_PRINT_VID(vid), message);
 				hlist_del_rcu(&tt_common_entry->hash_entry);
-				batadv_tt_global_entry_free_ref(tt_global);
+				batadv_tt_global_entry_put(tt_global);
 			}
 		}
 		spin_unlock_bh(list_lock);
@@ -2026,7 +2026,7 @@ static void batadv_tt_global_purge(struct batadv_priv *bat_priv)
 
 			hlist_del_rcu(&tt_common->hash_entry);
 
-			batadv_tt_global_entry_free_ref(tt_global);
+			batadv_tt_global_entry_put(tt_global);
 		}
 		spin_unlock_bh(list_lock);
 	}
@@ -2058,7 +2058,7 @@ static void batadv_tt_global_table_free(struct batadv_priv *bat_priv)
 			tt_global = container_of(tt_common_entry,
 						 struct batadv_tt_global_entry,
 						 common);
-			batadv_tt_global_entry_free_ref(tt_global);
+			batadv_tt_global_entry_put(tt_global);
 		}
 		spin_unlock_bh(list_lock);
 	}
@@ -2139,9 +2139,9 @@ struct batadv_orig_node *batadv_transtable_search(struct batadv_priv *bat_priv,
 
 out:
 	if (tt_global_entry)
-		batadv_tt_global_entry_free_ref(tt_global_entry);
+		batadv_tt_global_entry_put(tt_global_entry);
 	if (tt_local_entry)
-		batadv_tt_local_entry_free_ref(tt_local_entry);
+		batadv_tt_local_entry_put(tt_local_entry);
 
 	return orig_node;
 }
@@ -2501,7 +2501,7 @@ static bool batadv_tt_global_check_crc(struct batadv_orig_node *orig_node,
 			return false;
 
 		crc = vlan->tt.crc;
-		batadv_orig_node_vlan_free_ref(vlan);
+		batadv_orig_node_vlan_put(vlan);
 
 		if (crc != ntohl(tt_vlan_tmp->crc))
 			return false;
@@ -2636,7 +2636,7 @@ static int batadv_send_tt_request(struct batadv_priv *bat_priv,
 
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 	if (ret && tt_req_node) {
 		spin_lock_bh(&bat_priv->tt.req_list_lock);
 		/* hlist_del_init() verifies tt_req_node still is in the list */
@@ -2774,9 +2774,9 @@ unlock:
 
 out:
 	if (res_dst_orig_node)
-		batadv_orig_node_free_ref(res_dst_orig_node);
+		batadv_orig_node_put(res_dst_orig_node);
 	if (req_dst_orig_node)
-		batadv_orig_node_free_ref(req_dst_orig_node);
+		batadv_orig_node_put(req_dst_orig_node);
 	kfree(tvlv_tt_data);
 	return ret;
 }
@@ -2891,9 +2891,9 @@ unlock:
 out:
 	spin_unlock_bh(&bat_priv->tt.commit_lock);
 	if (orig_node)
-		batadv_orig_node_free_ref(orig_node);
+		batadv_orig_node_put(orig_node);
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 	kfree(tvlv_tt_data);
 	/* The packet was for this host, so it doesn't need to be re-routed */
 	return true;
@@ -2979,7 +2979,7 @@ static void batadv_tt_fill_gtable(struct batadv_priv *bat_priv,
 
 out:
 	if (orig_node)
-		batadv_orig_node_free_ref(orig_node);
+		batadv_orig_node_put(orig_node);
 }
 
 static void batadv_tt_update_changes(struct batadv_priv *bat_priv,
@@ -3021,7 +3021,7 @@ bool batadv_is_my_client(struct batadv_priv *bat_priv, const u8 *addr,
 	ret = true;
 out:
 	if (tt_local_entry)
-		batadv_tt_local_entry_free_ref(tt_local_entry);
+		batadv_tt_local_entry_put(tt_local_entry);
 	return ret;
 }
 
@@ -3085,7 +3085,7 @@ static void batadv_handle_tt_response(struct batadv_priv *bat_priv,
 	spin_unlock_bh(&bat_priv->tt.req_list_lock);
 out:
 	if (orig_node)
-		batadv_orig_node_free_ref(orig_node);
+		batadv_orig_node_put(orig_node);
 }
 
 static void batadv_tt_roam_list_free(struct batadv_priv *bat_priv)
@@ -3216,7 +3216,7 @@ static void batadv_send_roam_adv(struct batadv_priv *bat_priv, u8 *client,
 
 out:
 	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
+		batadv_hardif_put(primary_if);
 }
 
 static void batadv_tt_purge(struct work_struct *work)
@@ -3340,11 +3340,11 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 			/* decrease the reference held for this vlan */
 			vlan = batadv_softif_vlan_get(bat_priv, tt_common->vid);
 			if (vlan) {
-				batadv_softif_vlan_free_ref(vlan);
-				batadv_softif_vlan_free_ref(vlan);
+				batadv_softif_vlan_put(vlan);
+				batadv_softif_vlan_put(vlan);
 			}
 
-			batadv_tt_local_entry_free_ref(tt_local);
+			batadv_tt_local_entry_put(tt_local);
 		}
 		spin_unlock_bh(list_lock);
 	}
@@ -3427,11 +3427,11 @@ bool batadv_is_ap_isolated(struct batadv_priv *bat_priv, u8 *src, u8 *dst,
 	ret = true;
 
 out:
-	batadv_softif_vlan_free_ref(vlan);
+	batadv_softif_vlan_put(vlan);
 	if (tt_global_entry)
-		batadv_tt_global_entry_free_ref(tt_global_entry);
+		batadv_tt_global_entry_put(tt_global_entry);
 	if (tt_local_entry)
-		batadv_tt_local_entry_free_ref(tt_local_entry);
+		batadv_tt_local_entry_put(tt_local_entry);
 	return ret;
 }
 
@@ -3541,7 +3541,7 @@ bool batadv_tt_global_client_is_roaming(struct batadv_priv *bat_priv,
 		goto out;
 
 	ret = tt_global_entry->common.flags & BATADV_TT_CLIENT_ROAM;
-	batadv_tt_global_entry_free_ref(tt_global_entry);
+	batadv_tt_global_entry_put(tt_global_entry);
 out:
 	return ret;
 }
@@ -3567,7 +3567,7 @@ bool batadv_tt_local_client_is_roaming(struct batadv_priv *bat_priv,
 		goto out;
 
 	ret = tt_local_entry->common.flags & BATADV_TT_CLIENT_ROAM;
-	batadv_tt_local_entry_free_ref(tt_local_entry);
+	batadv_tt_local_entry_put(tt_local_entry);
 out:
 	return ret;
 }
@@ -3800,7 +3800,7 @@ static int batadv_roam_tvlv_unicast_handler_v1(struct batadv_priv *bat_priv,
 
 out:
 	if (orig_node)
-		batadv_orig_node_free_ref(orig_node);
+		batadv_orig_node_put(orig_node);
 	return NET_RX_SUCCESS;
 }
 
@@ -3861,7 +3861,7 @@ bool batadv_tt_global_is_isolated(struct batadv_priv *bat_priv,
 
 	ret = tt->common.flags & BATADV_TT_CLIENT_ISOLA;
 
-	batadv_tt_global_entry_free_ref(tt);
+	batadv_tt_global_entry_put(tt);
 
 	return ret;
 }
-- 
2.7.0.rc3


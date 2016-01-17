Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 17 Jan 2016 11:01:09 +0100
Message-Id: <1453024887-7215-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v7 01/19] batman-adv: Rename batadv_orig_node
	*_free_ref function to *_put
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
v7:
 - removed patches which are now applied in the branch master
 - split *_get -> *_put rename patches into smaller patches only renaming single
   functions
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

 net/batman-adv/bat_iv_ogm.c            | 16 ++++++++--------
 net/batman-adv/bridge_loop_avoidance.c |  4 ++--
 net/batman-adv/distributed-arp-table.c |  4 ++--
 net/batman-adv/fragmentation.c         |  2 +-
 net/batman-adv/gateway_client.c        |  8 ++++----
 net/batman-adv/icmp_socket.c           |  2 +-
 net/batman-adv/main.c                  |  2 +-
 net/batman-adv/network-coding.c        |  4 ++--
 net/batman-adv/originator.c            |  8 ++++----
 net/batman-adv/originator.h            |  2 +-
 net/batman-adv/routing.c               | 18 +++++++++---------
 net/batman-adv/send.c                  |  2 +-
 net/batman-adv/translation-table.c     | 14 +++++++-------
 13 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index bf0e7d6..32df38b 100644
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
@@ -1041,7 +1041,7 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 						     ethhdr->h_source,
 						     orig_node, orig_tmp);
 
-		batadv_orig_node_free_ref(orig_tmp);
+		batadv_orig_node_put(orig_tmp);
 		if (!neigh_node)
 			goto unlock;
 	} else {
@@ -1306,7 +1306,7 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 
 	orig_ifinfo = batadv_orig_ifinfo_new(orig_node, if_outgoing);
 	if (WARN_ON(!orig_ifinfo)) {
-		batadv_orig_node_free_ref(orig_node);
+		batadv_orig_node_put(orig_node);
 		return 0;
 	}
 
@@ -1367,7 +1367,7 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 
 out:
 	spin_unlock_bh(&orig_node->bat_iv.ogm_cnt_lock);
-	batadv_orig_node_free_ref(orig_node);
+	batadv_orig_node_put(orig_node);
 	batadv_orig_ifinfo_free_ref(orig_ifinfo);
 	return ret;
 }
@@ -1563,7 +1563,7 @@ batadv_iv_ogm_process_per_outif(const struct sk_buff *skb, int ogm_offset,
 
 out_neigh:
 	if ((orig_neigh_node) && (!is_single_hop_neigh))
-		batadv_orig_node_free_ref(orig_neigh_node);
+		batadv_orig_node_put(orig_neigh_node);
 out:
 	if (router_ifinfo)
 		batadv_neigh_ifinfo_free_ref(router_ifinfo);
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
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 7781f39..49008d9 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -486,7 +486,7 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, u8 *orig,
 	if (orig_node) {
 		batadv_tt_global_del_orig(bat_priv, orig_node, vid,
 					  "became a backbone gateway");
-		batadv_orig_node_free_ref(orig_node);
+		batadv_orig_node_put(orig_node);
 	}
 
 	if (own_backbone) {
@@ -965,7 +965,7 @@ static int batadv_check_claim_group(struct batadv_priv *bat_priv,
 		bla_dst_own->group = bla_dst->group;
 	}
 
-	batadv_orig_node_free_ref(orig_node);
+	batadv_orig_node_put(orig_node);
 
 	return 2;
 }
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index e326111..8f466e7 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -547,7 +547,7 @@ static void batadv_choose_next_candidate(struct batadv_priv *bat_priv,
 
 			max = tmp_max;
 			if (max_orig_node)
-				batadv_orig_node_free_ref(max_orig_node);
+				batadv_orig_node_put(max_orig_node);
 			max_orig_node = orig_node;
 		}
 		rcu_read_unlock();
@@ -676,7 +676,7 @@ static bool batadv_dat_send_data(struct batadv_priv *bat_priv,
 free_neigh:
 		batadv_neigh_node_free_ref(neigh_node);
 free_orig:
-		batadv_orig_node_free_ref(cand[i].orig_node);
+		batadv_orig_node_put(cand[i].orig_node);
 	}
 
 out:
diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 55656e8..67cb224 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -385,7 +385,7 @@ bool batadv_frag_skb_fwd(struct sk_buff *skb,
 
 out:
 	if (orig_node_dst)
-		batadv_orig_node_free_ref(orig_node_dst);
+		batadv_orig_node_put(orig_node_dst);
 	if (neigh_node)
 		batadv_neigh_node_free_ref(neigh_node);
 	return ret;
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 261866e..a42dd2a 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -71,7 +71,7 @@ static void batadv_gw_node_release(struct kref *ref)
 
 	gw_node = container_of(ref, struct batadv_gw_node, refcount);
 
-	batadv_orig_node_free_ref(gw_node->orig_node);
+	batadv_orig_node_put(gw_node->orig_node);
 	kfree_rcu(gw_node, rcu);
 }
 
@@ -415,7 +415,7 @@ reselect:
 	batadv_gw_reselect(bat_priv);
 out:
 	if (curr_gw_orig)
-		batadv_orig_node_free_ref(curr_gw_orig);
+		batadv_orig_node_put(curr_gw_orig);
 	if (router_gw)
 		batadv_neigh_node_free_ref(router_gw);
 	if (router_orig)
@@ -446,7 +446,7 @@ static void batadv_gw_node_add(struct batadv_priv *bat_priv,
 
 	gw_node = kzalloc(sizeof(*gw_node), GFP_ATOMIC);
 	if (!gw_node) {
-		batadv_orig_node_free_ref(orig_node);
+		batadv_orig_node_put(orig_node);
 		return;
 	}
 
@@ -878,7 +878,7 @@ bool batadv_gw_out_of_range(struct batadv_priv *bat_priv,
 
 out:
 	if (orig_dst_node)
-		batadv_orig_node_free_ref(orig_dst_node);
+		batadv_orig_node_put(orig_dst_node);
 	if (curr_gw)
 		batadv_gw_node_free_ref(curr_gw);
 	if (gw_node)
diff --git a/net/batman-adv/icmp_socket.c b/net/batman-adv/icmp_socket.c
index a69da37..7d944af 100644
--- a/net/batman-adv/icmp_socket.c
+++ b/net/batman-adv/icmp_socket.c
@@ -292,7 +292,7 @@ out:
 	if (neigh_node)
 		batadv_neigh_node_free_ref(neigh_node);
 	if (orig_node)
-		batadv_orig_node_free_ref(orig_node);
+		batadv_orig_node_put(orig_node);
 	return len;
 }
 
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 568c550..5b573d1 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -1212,7 +1212,7 @@ void batadv_tvlv_unicast_send(struct batadv_priv *bat_priv, u8 *src,
 	if (batadv_send_skb_to_orig(skb, orig_node, NULL) == NET_XMIT_DROP)
 		kfree_skb(skb);
 out:
-	batadv_orig_node_free_ref(orig_node);
+	batadv_orig_node_put(orig_node);
 }
 
 /**
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index a4eb8ee..00f74d4 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -218,7 +218,7 @@ static void batadv_nc_node_release(struct kref *ref)
 
 	nc_node = container_of(ref, struct batadv_nc_node, refcount);
 
-	batadv_orig_node_free_ref(nc_node->orig_node);
+	batadv_orig_node_put(nc_node->orig_node);
 	kfree_rcu(nc_node, rcu);
 }
 
@@ -1372,7 +1372,7 @@ batadv_nc_skb_src_search(struct batadv_priv *bat_priv,
 	}
 	rcu_read_unlock();
 
-	batadv_orig_node_free_ref(orig_node);
+	batadv_orig_node_put(orig_node);
 	return nc_packet;
 }
 
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index eacd0e5..4df9be4 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
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
@@ -1204,7 +1204,7 @@ static void _batadv_purge_orig(struct batadv_priv *bat_priv)
 				batadv_tt_global_del_orig(orig_node->bat_priv,
 							  orig_node, -1,
 							  "originator timed out");
-				batadv_orig_node_free_ref(orig_node);
+				batadv_orig_node_put(orig_node);
 				continue;
 			}
 
diff --git a/net/batman-adv/originator.h b/net/batman-adv/originator.h
index 9950740..c151f6a 100644
--- a/net/batman-adv/originator.h
+++ b/net/batman-adv/originator.h
@@ -37,7 +37,7 @@ int batadv_compare_orig(const struct hlist_node *node, const void *data2);
 int batadv_originator_init(struct batadv_priv *bat_priv);
 void batadv_originator_free(struct batadv_priv *bat_priv);
 void batadv_purge_orig_ref(struct batadv_priv *bat_priv);
-void batadv_orig_node_free_ref(struct batadv_orig_node *orig_node);
+void batadv_orig_node_put(struct batadv_orig_node *orig_node);
 struct batadv_orig_node *batadv_orig_node_new(struct batadv_priv *bat_priv,
 					      const u8 *addr);
 struct batadv_hardif_neigh_node *
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 205310b..d2c490d 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -271,7 +271,7 @@ out:
 	if (primary_if)
 		batadv_hardif_free_ref(primary_if);
 	if (orig_node)
-		batadv_orig_node_free_ref(orig_node);
+		batadv_orig_node_put(orig_node);
 	return ret;
 }
 
@@ -319,7 +319,7 @@ out:
 	if (primary_if)
 		batadv_hardif_free_ref(primary_if);
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
 
@@ -649,7 +649,7 @@ static int batadv_route_unicast_packet(struct sk_buff *skb,
 
 out:
 	if (orig_node)
-		batadv_orig_node_free_ref(orig_node);
+		batadv_orig_node_put(orig_node);
 	return ret;
 }
 
@@ -704,7 +704,7 @@ out:
 	if (primary_if)
 		batadv_hardif_free_ref(primary_if);
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
index d8b03fd..261309e 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -317,7 +317,7 @@ int batadv_send_skb_unicast(struct batadv_priv *bat_priv,
 
 out:
 	if (orig_node)
-		batadv_orig_node_free_ref(orig_node);
+		batadv_orig_node_put(orig_node);
 	if (ret == NET_XMIT_DROP)
 		kfree_skb(skb);
 	return ret;
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 1188279..4de02ea 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -390,7 +390,7 @@ static void batadv_tt_orig_list_entry_release(struct kref *ref)
 	orig_entry = container_of(ref, struct batadv_tt_orig_list_entry,
 				  refcount);
 
-	batadv_orig_node_free_ref(orig_entry->orig_node);
+	batadv_orig_node_put(orig_entry->orig_node);
 	kfree_rcu(orig_entry, rcu);
 }
 
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
@@ -2891,7 +2891,7 @@ unlock:
 out:
 	spin_unlock_bh(&bat_priv->tt.commit_lock);
 	if (orig_node)
-		batadv_orig_node_free_ref(orig_node);
+		batadv_orig_node_put(orig_node);
 	if (primary_if)
 		batadv_hardif_free_ref(primary_if);
 	kfree(tvlv_tt_data);
@@ -2979,7 +2979,7 @@ static void batadv_tt_fill_gtable(struct batadv_priv *bat_priv,
 
 out:
 	if (orig_node)
-		batadv_orig_node_free_ref(orig_node);
+		batadv_orig_node_put(orig_node);
 }
 
 static void batadv_tt_update_changes(struct batadv_priv *bat_priv,
@@ -3085,7 +3085,7 @@ static void batadv_handle_tt_response(struct batadv_priv *bat_priv,
 	spin_unlock_bh(&bat_priv->tt.req_list_lock);
 out:
 	if (orig_node)
-		batadv_orig_node_free_ref(orig_node);
+		batadv_orig_node_put(orig_node);
 }
 
 static void batadv_tt_roam_list_free(struct batadv_priv *bat_priv)
@@ -3800,7 +3800,7 @@ static int batadv_roam_tvlv_unicast_handler_v1(struct batadv_priv *bat_priv,
 
 out:
 	if (orig_node)
-		batadv_orig_node_free_ref(orig_node);
+		batadv_orig_node_put(orig_node);
 	return NET_RX_SUCCESS;
 }
 
-- 
2.7.0.rc3


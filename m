Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 16 Dec 2015 00:31:49 +0100
Message-Id: <1450222316-1764-16-git-send-email-sven@narfation.org>
In-Reply-To: <1450222316-1764-1-git-send-email-sven@narfation.org>
References: <1450222316-1764-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 16/23] batman-adv: Convert
	batadv_neigh_ifinfo to kref
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

So switch to kref instead of using the self-made, atomic_t-based
implementation.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_iv_ogm.c     | 24 ++++++++++++------------
 net/batman-adv/gateway_client.c | 14 +++++++-------
 net/batman-adv/network-coding.c |  4 ++--
 net/batman-adv/originator.c     | 41 +++++++++++++++--------------------------
 net/batman-adv/originator.h     |  2 +-
 net/batman-adv/types.h          |  2 +-
 6 files changed, 38 insertions(+), 49 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index b9db667..cfd2afe 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1023,7 +1023,7 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 		neigh_ifinfo->bat_iv.tq_avg = tq_avg;
 		spin_unlock_bh(&tmp_neigh_node->ifinfo_lock);
 
-		batadv_neigh_ifinfo_free_ref(neigh_ifinfo);
+		batadv_neigh_ifinfo_put(neigh_ifinfo);
 		neigh_ifinfo = NULL;
 	}
 
@@ -1117,9 +1117,9 @@ out:
 	if (router)
 		batadv_neigh_node_free_ref(router);
 	if (neigh_ifinfo)
-		batadv_neigh_ifinfo_free_ref(neigh_ifinfo);
+		batadv_neigh_ifinfo_put(neigh_ifinfo);
 	if (router_ifinfo)
-		batadv_neigh_ifinfo_free_ref(router_ifinfo);
+		batadv_neigh_ifinfo_put(router_ifinfo);
 }
 
 /**
@@ -1189,7 +1189,7 @@ static int batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
 	neigh_ifinfo = batadv_neigh_ifinfo_new(neigh_node, if_outgoing);
 	if (neigh_ifinfo) {
 		neigh_rq_count = neigh_ifinfo->bat_iv.real_packet_count;
-		batadv_neigh_ifinfo_free_ref(neigh_ifinfo);
+		batadv_neigh_ifinfo_put(neigh_ifinfo);
 	} else {
 		neigh_rq_count = 0;
 	}
@@ -1350,7 +1350,7 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 		packet_count = bitmap_weight(bitmap,
 					     BATADV_TQ_LOCAL_WINDOW_SIZE);
 		neigh_ifinfo->bat_iv.real_packet_count = packet_count;
-		batadv_neigh_ifinfo_free_ref(neigh_ifinfo);
+		batadv_neigh_ifinfo_put(neigh_ifinfo);
 	}
 	rcu_read_unlock();
 
@@ -1563,7 +1563,7 @@ out_neigh:
 		batadv_orig_node_free_ref(orig_neigh_node);
 out:
 	if (router_ifinfo)
-		batadv_neigh_ifinfo_free_ref(router_ifinfo);
+		batadv_neigh_ifinfo_put(router_ifinfo);
 	if (router)
 		batadv_neigh_node_free_ref(router);
 	if (router_router)
@@ -1802,7 +1802,7 @@ batadv_iv_ogm_orig_print_neigh(struct batadv_orig_node *orig_node,
 			   neigh_node->addr,
 			   n_ifinfo->bat_iv.tq_avg);
 
-		batadv_neigh_ifinfo_free_ref(n_ifinfo);
+		batadv_neigh_ifinfo_put(n_ifinfo);
 	}
 }
 
@@ -1867,7 +1867,7 @@ static void batadv_iv_ogm_orig_print(struct batadv_priv *bat_priv,
 next:
 			batadv_neigh_node_free_ref(neigh_node);
 			if (n_ifinfo)
-				batadv_neigh_ifinfo_free_ref(n_ifinfo);
+				batadv_neigh_ifinfo_put(n_ifinfo);
 		}
 		rcu_read_unlock();
 	}
@@ -1961,9 +1961,9 @@ static int batadv_iv_ogm_neigh_cmp(struct batadv_neigh_node *neigh1,
 
 out:
 	if (neigh1_ifinfo)
-		batadv_neigh_ifinfo_free_ref(neigh1_ifinfo);
+		batadv_neigh_ifinfo_put(neigh1_ifinfo);
 	if (neigh2_ifinfo)
-		batadv_neigh_ifinfo_free_ref(neigh2_ifinfo);
+		batadv_neigh_ifinfo_put(neigh2_ifinfo);
 
 	return diff;
 }
@@ -2004,9 +2004,9 @@ batadv_iv_ogm_neigh_is_sob(struct batadv_neigh_node *neigh1,
 
 out:
 	if (neigh1_ifinfo)
-		batadv_neigh_ifinfo_free_ref(neigh1_ifinfo);
+		batadv_neigh_ifinfo_put(neigh1_ifinfo);
 	if (neigh2_ifinfo)
-		batadv_neigh_ifinfo_free_ref(neigh2_ifinfo);
+		batadv_neigh_ifinfo_put(neigh2_ifinfo);
 
 	return ret;
 }
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index a7b9698..8d9933a 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -236,7 +236,7 @@ batadv_gw_get_best_gw_node(struct batadv_priv *bat_priv)
 next:
 		batadv_neigh_node_free_ref(router);
 		if (router_ifinfo)
-			batadv_neigh_ifinfo_free_ref(router_ifinfo);
+			batadv_neigh_ifinfo_put(router_ifinfo);
 	}
 	rcu_read_unlock();
 
@@ -353,7 +353,7 @@ out:
 	if (router)
 		batadv_neigh_node_free_ref(router);
 	if (router_ifinfo)
-		batadv_neigh_ifinfo_free_ref(router_ifinfo);
+		batadv_neigh_ifinfo_put(router_ifinfo);
 }
 
 void batadv_gw_check_election(struct batadv_priv *bat_priv,
@@ -420,9 +420,9 @@ out:
 	if (router_orig)
 		batadv_neigh_node_free_ref(router_orig);
 	if (router_gw_tq)
-		batadv_neigh_ifinfo_free_ref(router_gw_tq);
+		batadv_neigh_ifinfo_put(router_gw_tq);
 	if (router_orig_tq)
-		batadv_neigh_ifinfo_free_ref(router_orig_tq);
+		batadv_neigh_ifinfo_put(router_orig_tq);
 }
 
 /**
@@ -622,7 +622,7 @@ static int batadv_write_buffer_text(struct batadv_priv *bat_priv,
 		batadv_gw_node_put(curr_gw);
 out:
 	if (router_ifinfo)
-		batadv_neigh_ifinfo_free_ref(router_ifinfo);
+		batadv_neigh_ifinfo_put(router_ifinfo);
 	if (router)
 		batadv_neigh_node_free_ref(router);
 	return ret;
@@ -855,7 +855,7 @@ bool batadv_gw_out_of_range(struct batadv_priv *bat_priv,
 			goto out;
 
 		curr_tq_avg = curr_ifinfo->bat_iv.tq_avg;
-		batadv_neigh_ifinfo_free_ref(curr_ifinfo);
+		batadv_neigh_ifinfo_put(curr_ifinfo);
 
 		break;
 	case BATADV_GW_MODE_OFF:
@@ -873,7 +873,7 @@ bool batadv_gw_out_of_range(struct batadv_priv *bat_priv,
 
 	if ((curr_tq_avg - old_ifinfo->bat_iv.tq_avg) > BATADV_GW_THRESHOLD)
 		out_of_range = true;
-	batadv_neigh_ifinfo_free_ref(old_ifinfo);
+	batadv_neigh_ifinfo_put(old_ifinfo);
 
 out:
 	if (orig_dst_node)
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index a2655ad..9e96e7c 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -1232,9 +1232,9 @@ out:
 	if (router_coding)
 		batadv_neigh_node_free_ref(router_coding);
 	if (router_neigh_ifinfo)
-		batadv_neigh_ifinfo_free_ref(router_neigh_ifinfo);
+		batadv_neigh_ifinfo_put(router_neigh_ifinfo);
 	if (router_coding_ifinfo)
-		batadv_neigh_ifinfo_free_ref(router_coding_ifinfo);
+		batadv_neigh_ifinfo_put(router_coding_ifinfo);
 	return res;
 }
 
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 0e836bd..0a00757 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -170,42 +170,30 @@ err:
 }
 
 /**
- * batadv_neigh_ifinfo_free_rcu - free the neigh_ifinfo object
- * @rcu: rcu pointer of the neigh_ifinfo object
+ * batadv_neigh_ifinfo_release - release neigh_ifinfo from lists and queue for
+ *  free after rcu grace period
+ * * @ref: kref pointer of the neigh_ifinfo
  */
-static void batadv_neigh_ifinfo_free_rcu(struct rcu_head *rcu)
+static void batadv_neigh_ifinfo_release(struct kref *ref)
 {
 	struct batadv_neigh_ifinfo *neigh_ifinfo;
 
-	neigh_ifinfo = container_of(rcu, struct batadv_neigh_ifinfo, rcu);
+	neigh_ifinfo = container_of(ref, struct batadv_neigh_ifinfo, refcount);
 
 	if (neigh_ifinfo->if_outgoing != BATADV_IF_DEFAULT)
-		batadv_hardif_free_ref_now(neigh_ifinfo->if_outgoing);
+		batadv_hardif_free_ref(neigh_ifinfo->if_outgoing);
 
-	kfree(neigh_ifinfo);
+	kfree_rcu(neigh_ifinfo, rcu);
 }
 
 /**
- * batadv_neigh_ifinfo_free_now - decrement the refcounter and possibly free
- *  the neigh_ifinfo (without rcu callback)
- * @neigh_ifinfo: the neigh_ifinfo object to release
- */
-static void
-batadv_neigh_ifinfo_free_ref_now(struct batadv_neigh_ifinfo *neigh_ifinfo)
-{
-	if (atomic_dec_and_test(&neigh_ifinfo->refcount))
-		batadv_neigh_ifinfo_free_rcu(&neigh_ifinfo->rcu);
-}
-
-/**
- * batadv_neigh_ifinfo_free_ref - decrement the refcounter and possibly free
+ * batadv_neigh_ifinfo_put - decrement the refcounter and possibly free
  *  the neigh_ifinfo
  * @neigh_ifinfo: the neigh_ifinfo object to release
  */
-void batadv_neigh_ifinfo_free_ref(struct batadv_neigh_ifinfo *neigh_ifinfo)
+void batadv_neigh_ifinfo_put(struct batadv_neigh_ifinfo *neigh_ifinfo)
 {
-	if (atomic_dec_and_test(&neigh_ifinfo->refcount))
-		call_rcu(&neigh_ifinfo->rcu, batadv_neigh_ifinfo_free_rcu);
+	kref_put(&neigh_ifinfo->refcount, batadv_neigh_ifinfo_release);
 }
 
 /**
@@ -255,7 +243,7 @@ static void batadv_neigh_node_free_rcu(struct rcu_head *rcu)
 
 	hlist_for_each_entry_safe(neigh_ifinfo, node_tmp,
 				  &neigh_node->ifinfo_list, list) {
-		batadv_neigh_ifinfo_free_ref_now(neigh_ifinfo);
+		batadv_neigh_ifinfo_put(neigh_ifinfo);
 	}
 
 	hardif_neigh = batadv_hardif_neigh_get(neigh_node->if_incoming,
@@ -432,7 +420,7 @@ batadv_neigh_ifinfo_get(struct batadv_neigh_node *neigh,
 		if (tmp_neigh_ifinfo->if_outgoing != if_outgoing)
 			continue;
 
-		if (!atomic_inc_not_zero(&tmp_neigh_ifinfo->refcount))
+		if (!kref_get_unless_zero(&tmp_neigh_ifinfo->refcount))
 			continue;
 
 		neigh_ifinfo = tmp_neigh_ifinfo;
@@ -477,7 +465,8 @@ batadv_neigh_ifinfo_new(struct batadv_neigh_node *neigh,
 	}
 
 	INIT_HLIST_NODE(&neigh_ifinfo->list);
-	atomic_set(&neigh_ifinfo->refcount, 2);
+	kref_init(&neigh_ifinfo->refcount);
+	kref_get(&neigh_ifinfo->refcount);
 	neigh_ifinfo->if_outgoing = if_outgoing;
 
 	hlist_add_head_rcu(&neigh_ifinfo->list, &neigh->ifinfo_list);
@@ -965,7 +954,7 @@ batadv_purge_neigh_ifinfo(struct batadv_priv *bat_priv,
 			   neigh->addr, if_outgoing->net_dev->name);
 
 		hlist_del_rcu(&neigh_ifinfo->list);
-		batadv_neigh_ifinfo_free_ref(neigh_ifinfo);
+		batadv_neigh_ifinfo_put(neigh_ifinfo);
 	}
 
 	spin_unlock_bh(&neigh->ifinfo_lock);
diff --git a/net/batman-adv/originator.h b/net/batman-adv/originator.h
index dc5cefa..5b2dc06 100644
--- a/net/batman-adv/originator.h
+++ b/net/batman-adv/originator.h
@@ -59,7 +59,7 @@ batadv_neigh_ifinfo_new(struct batadv_neigh_node *neigh,
 struct batadv_neigh_ifinfo *
 batadv_neigh_ifinfo_get(struct batadv_neigh_node *neigh,
 			struct batadv_hard_iface *if_outgoing);
-void batadv_neigh_ifinfo_free_ref(struct batadv_neigh_ifinfo *neigh_ifinfo);
+void batadv_neigh_ifinfo_put(struct batadv_neigh_ifinfo *neigh_ifinfo);
 
 int batadv_hardif_neigh_seq_print_text(struct seq_file *seq, void *offset);
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 58ae09e..7831bf0 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -420,7 +420,7 @@ struct batadv_neigh_ifinfo {
 	struct batadv_hard_iface *if_outgoing;
 	struct batadv_neigh_ifinfo_bat_iv bat_iv;
 	u8 last_ttl;
-	atomic_t refcount;
+	struct kref refcount;
 	struct rcu_head rcu;
 };
 
-- 
2.6.4


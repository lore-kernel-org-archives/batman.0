Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 16 Dec 2015 00:31:55 +0100
Message-Id: <1450222316-1764-22-git-send-email-sven@narfation.org>
In-Reply-To: <1450222316-1764-1-git-send-email-sven@narfation.org>
References: <1450222316-1764-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 22/23] batman-adv: Convert
	batadv_tt_common_entry to kref
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
 net/batman-adv/translation-table.c | 116 ++++++++++++++++++++++++-------------
 net/batman-adv/types.h             |   2 +-
 2 files changed, 77 insertions(+), 41 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index dad9060..f717b5e 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -142,7 +142,7 @@ batadv_tt_hash_find(struct batadv_hashtable *hash, const u8 *addr,
 		if (tt->vid != vid)
 			continue;
 
-		if (!atomic_inc_not_zero(&tt->refcount))
+		if (!kref_get_unless_zero(&tt->refcount))
 			continue;
 
 		tt_tmp = tt;
@@ -203,25 +203,59 @@ batadv_tt_global_hash_find(struct batadv_priv *bat_priv, const u8 *addr,
 	return tt_global_entry;
 }
 
-static void
-batadv_tt_local_entry_free_ref(struct batadv_tt_local_entry *tt_local_entry)
+/**
+ * batadv_tt_local_entry_release - release tt_local_entry from lists and queue
+ *  for free after rcu grace period
+ * * @ref: kref pointer of the nc_node
+ */
+static void batadv_tt_local_entry_release(struct kref *ref)
 {
-	if (atomic_dec_and_test(&tt_local_entry->common.refcount))
-		kfree_rcu(tt_local_entry, common.rcu);
+	struct batadv_tt_local_entry *tt_local_entry;
+
+	tt_local_entry = container_of(ref, struct batadv_tt_local_entry,
+				      common.refcount);
+
+	kfree_rcu(tt_local_entry, common.rcu);
 }
 
 /**
- * batadv_tt_global_entry_free_ref - decrement the refcounter for a
- *  tt_global_entry and possibly free it
- * @tt_global_entry: the object to free
+ * batadv_tt_local_entry_put - decrement the tt_local_entry refcounter and
+ *  possibly release it
+ * @tt_local_entry: tt_local_entry to be free'd
  */
 static void
-batadv_tt_global_entry_free_ref(struct batadv_tt_global_entry *tt_global_entry)
+batadv_tt_local_entry_put(struct batadv_tt_local_entry *tt_local_entry)
 {
-	if (atomic_dec_and_test(&tt_global_entry->common.refcount)) {
-		batadv_tt_global_del_orig_list(tt_global_entry);
-		kfree_rcu(tt_global_entry, common.rcu);
-	}
+	kref_put(&tt_local_entry->common.refcount,
+		 batadv_tt_local_entry_release);
+}
+
+/**
+ * batadv_tt_global_entry_release - release tt_global_entry from lists and queue
+ *  for free after rcu grace period
+ * * @ref: kref pointer of the nc_node
+ */
+static void batadv_tt_global_entry_release(struct kref *ref)
+{
+	struct batadv_tt_global_entry *tt_global_entry;
+
+	tt_global_entry = container_of(ref, struct batadv_tt_global_entry,
+				       common.refcount);
+
+	batadv_tt_global_del_orig_list(tt_global_entry);
+	kfree_rcu(tt_global_entry, common.rcu);
+}
+
+/**
+ * batadv_tt_global_entry_put - decrement the tt_global_entry refcounter and
+ *  possibly release it
+ * @tt_global_entry: tt_global_entry to be free'd
+ */
+static void
+batadv_tt_global_entry_put(struct batadv_tt_global_entry *tt_global_entry)
+{
+	kref_put(&tt_global_entry->common.refcount,
+		 batadv_tt_global_entry_release);
 }
 
 /**
@@ -244,7 +278,7 @@ int batadv_tt_global_hash_count(struct batadv_priv *bat_priv,
 		return 0;
 
 	count = atomic_read(&tt_global_entry->orig_list_count);
-	batadv_tt_global_entry_free_ref(tt_global_entry);
+	batadv_tt_global_entry_put(tt_global_entry);
 
 	return count;
 }
@@ -525,7 +559,7 @@ static void batadv_tt_global_free(struct batadv_priv *bat_priv,
 
 	batadv_hash_remove(bat_priv->tt.global_hash, batadv_compare_tt,
 			   batadv_choose_tt, &tt_global->common);
-	batadv_tt_global_entry_free_ref(tt_global);
+	batadv_tt_global_entry_put(tt_global);
 }
 
 /**
@@ -633,7 +667,8 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
 	tt_local->common.vid = vid;
 	if (batadv_is_wifi_netdev(in_dev))
 		tt_local->common.flags |= BATADV_TT_CLIENT_WIFI;
-	atomic_set(&tt_local->common.refcount, 2);
+	kref_init(&tt_local->common.refcount);
+	kref_get(&tt_local->common.refcount);
 	tt_local->last_seen = jiffies;
 	tt_local->common.added_at = tt_local->last_seen;
 
@@ -650,7 +685,7 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
 
 	if (unlikely(hash_added != 0)) {
 		/* remove the reference for the hash */
-		batadv_tt_local_entry_free_ref(tt_local);
+		batadv_tt_local_entry_put(tt_local);
 		batadv_softif_vlan_put(vlan);
 		goto out;
 	}
@@ -717,9 +752,9 @@ out:
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
 
@@ -1100,7 +1135,7 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 		goto out;
 
 	/* extra call to free the local tt entry */
-	batadv_tt_local_entry_free_ref(tt_local_entry);
+	batadv_tt_local_entry_put(tt_local_entry);
 
 	/* decrease the reference held for this vlan */
 	vlan = batadv_softif_vlan_get(bat_priv, vid);
@@ -1112,7 +1147,7 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 
 out:
 	if (tt_local_entry)
-		batadv_tt_local_entry_free_ref(tt_local_entry);
+		batadv_tt_local_entry_put(tt_local_entry);
 
 	return curr_flags;
 }
@@ -1212,7 +1247,7 @@ static void batadv_tt_local_table_free(struct batadv_priv *bat_priv)
 				batadv_softif_vlan_put(vlan);
 			}
 
-			batadv_tt_local_entry_free_ref(tt_local);
+			batadv_tt_local_entry_put(tt_local);
 		}
 		spin_unlock_bh(list_lock);
 	}
@@ -1415,7 +1450,8 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 		 */
 		if (flags & BATADV_TT_CLIENT_ROAM)
 			tt_global_entry->roam_at = jiffies;
-		atomic_set(&common->refcount, 2);
+		kref_init(&common->refcount);
+		kref_get(&common->refcount);
 		common->added_at = jiffies;
 
 		INIT_HLIST_HEAD(&tt_global_entry->orig_list);
@@ -1429,7 +1465,7 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 
 		if (unlikely(hash_added != 0)) {
 			/* remove the reference for the hash */
-			batadv_tt_global_entry_free_ref(tt_global_entry);
+			batadv_tt_global_entry_put(tt_global_entry);
 			goto out_remove;
 		}
 	} else {
@@ -1515,9 +1551,9 @@ out_remove:
 
 out:
 	if (tt_global_entry)
-		batadv_tt_global_entry_free_ref(tt_global_entry);
+		batadv_tt_global_entry_put(tt_global_entry);
 	if (tt_local_entry)
-		batadv_tt_local_entry_free_ref(tt_local_entry);
+		batadv_tt_local_entry_put(tt_local_entry);
 	return ret;
 }
 
@@ -1871,9 +1907,9 @@ static void batadv_tt_global_del(struct batadv_priv *bat_priv,
 
 out:
 	if (tt_global_entry)
-		batadv_tt_global_entry_free_ref(tt_global_entry);
+		batadv_tt_global_entry_put(tt_global_entry);
 	if (local_entry)
-		batadv_tt_local_entry_free_ref(local_entry);
+		batadv_tt_local_entry_put(local_entry);
 }
 
 /**
@@ -1927,7 +1963,7 @@ void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
 					   tt_global->common.addr,
 					   BATADV_PRINT_VID(vid), message);
 				hlist_del_rcu(&tt_common_entry->hash_entry);
-				batadv_tt_global_entry_free_ref(tt_global);
+				batadv_tt_global_entry_put(tt_global);
 			}
 		}
 		spin_unlock_bh(list_lock);
@@ -1990,7 +2026,7 @@ static void batadv_tt_global_purge(struct batadv_priv *bat_priv)
 
 			hlist_del_rcu(&tt_common->hash_entry);
 
-			batadv_tt_global_entry_free_ref(tt_global);
+			batadv_tt_global_entry_put(tt_global);
 		}
 		spin_unlock_bh(list_lock);
 	}
@@ -2022,7 +2058,7 @@ static void batadv_tt_global_table_free(struct batadv_priv *bat_priv)
 			tt_global = container_of(tt_common_entry,
 						 struct batadv_tt_global_entry,
 						 common);
-			batadv_tt_global_entry_free_ref(tt_global);
+			batadv_tt_global_entry_put(tt_global);
 		}
 		spin_unlock_bh(list_lock);
 	}
@@ -2103,9 +2139,9 @@ struct batadv_orig_node *batadv_transtable_search(struct batadv_priv *bat_priv,
 
 out:
 	if (tt_global_entry)
-		batadv_tt_global_entry_free_ref(tt_global_entry);
+		batadv_tt_global_entry_put(tt_global_entry);
 	if (tt_local_entry)
-		batadv_tt_local_entry_free_ref(tt_local_entry);
+		batadv_tt_local_entry_put(tt_local_entry);
 
 	return orig_node;
 }
@@ -2985,7 +3021,7 @@ bool batadv_is_my_client(struct batadv_priv *bat_priv, const u8 *addr,
 	ret = true;
 out:
 	if (tt_local_entry)
-		batadv_tt_local_entry_free_ref(tt_local_entry);
+		batadv_tt_local_entry_put(tt_local_entry);
 	return ret;
 }
 
@@ -3308,7 +3344,7 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 				batadv_softif_vlan_put(vlan);
 			}
 
-			batadv_tt_local_entry_free_ref(tt_local);
+			batadv_tt_local_entry_put(tt_local);
 		}
 		spin_unlock_bh(list_lock);
 	}
@@ -3393,9 +3429,9 @@ bool batadv_is_ap_isolated(struct batadv_priv *bat_priv, u8 *src, u8 *dst,
 out:
 	batadv_softif_vlan_put(vlan);
 	if (tt_global_entry)
-		batadv_tt_global_entry_free_ref(tt_global_entry);
+		batadv_tt_global_entry_put(tt_global_entry);
 	if (tt_local_entry)
-		batadv_tt_local_entry_free_ref(tt_local_entry);
+		batadv_tt_local_entry_put(tt_local_entry);
 	return ret;
 }
 
@@ -3505,7 +3541,7 @@ bool batadv_tt_global_client_is_roaming(struct batadv_priv *bat_priv,
 		goto out;
 
 	ret = tt_global_entry->common.flags & BATADV_TT_CLIENT_ROAM;
-	batadv_tt_global_entry_free_ref(tt_global_entry);
+	batadv_tt_global_entry_put(tt_global_entry);
 out:
 	return ret;
 }
@@ -3531,7 +3567,7 @@ bool batadv_tt_local_client_is_roaming(struct batadv_priv *bat_priv,
 		goto out;
 
 	ret = tt_local_entry->common.flags & BATADV_TT_CLIENT_ROAM;
-	batadv_tt_local_entry_free_ref(tt_local_entry);
+	batadv_tt_local_entry_put(tt_local_entry);
 out:
 	return ret;
 }
@@ -3825,7 +3861,7 @@ bool batadv_tt_global_is_isolated(struct batadv_priv *bat_priv,
 
 	ret = tt->common.flags & BATADV_TT_CLIENT_ISOLA;
 
-	batadv_tt_global_entry_free_ref(tt);
+	batadv_tt_global_entry_put(tt);
 
 	return ret;
 }
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index c8c7ab8..ef421ba 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -972,7 +972,7 @@ struct batadv_tt_common_entry {
 	struct hlist_node hash_entry;
 	u16 flags;
 	unsigned long added_at;
-	atomic_t refcount;
+	struct kref refcount;
 	struct rcu_head rcu;
 };
 
-- 
2.6.4


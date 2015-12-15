Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 16 Dec 2015 00:31:53 +0100
Message-Id: <1450222316-1764-20-git-send-email-sven@narfation.org>
In-Reply-To: <1450222316-1764-1-git-send-email-sven@narfation.org>
References: <1450222316-1764-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 20/23] batman-adv: Convert
	batadv_orig_node_vlan to kref
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
 net/batman-adv/originator.c        | 28 +++++++++++++++++++++-------
 net/batman-adv/originator.h        |  2 +-
 net/batman-adv/translation-table.c | 10 +++++-----
 net/batman-adv/types.h             |  2 +-
 4 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index a6eac81..a7b70b5 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -82,7 +82,7 @@ batadv_orig_node_vlan_get(struct batadv_orig_node *orig_node,
 		if (tmp->vid != vid)
 			continue;
 
-		if (!atomic_inc_not_zero(&tmp->refcount))
+		if (!kref_get_unless_zero(&tmp->refcount))
 			continue;
 
 		vlan = tmp;
@@ -123,7 +123,8 @@ batadv_orig_node_vlan_new(struct batadv_orig_node *orig_node,
 	if (!vlan)
 		goto out;
 
-	atomic_set(&vlan->refcount, 2);
+	kref_init(&vlan->refcount);
+	kref_get(&vlan->refcount);
 	vlan->vid = vid;
 
 	hlist_add_head_rcu(&vlan->list, &orig_node->vlan_list);
@@ -135,14 +136,27 @@ out:
 }
 
 /**
- * batadv_orig_node_vlan_free_ref - decrement the refcounter and possibly free
+ * batadv_orig_node_vlan_release - release originator-vlan object from lists
+ *  and queue for free after rcu grace period
+ * * @ref: kref pointer of the originator-vlan object
+ */
+static void batadv_orig_node_vlan_release(struct kref *ref)
+{
+	struct batadv_orig_node_vlan *orig_vlan;
+
+	orig_vlan = container_of(ref, struct batadv_orig_node_vlan, refcount);
+
+	kfree_rcu(orig_vlan, rcu);
+}
+
+/**
+ * batadv_orig_node_vlan_put - decrement the refcounter and possibly free
  *  the originator-vlan object
  * @orig_vlan: the originator-vlan object to release
  */
-void batadv_orig_node_vlan_free_ref(struct batadv_orig_node_vlan *orig_vlan)
+void batadv_orig_node_vlan_put(struct batadv_orig_node_vlan *orig_vlan)
 {
-	if (atomic_dec_and_test(&orig_vlan->refcount))
-		kfree_rcu(orig_vlan, rcu);
+	kref_put(&orig_vlan->refcount, batadv_orig_node_vlan_release);
 }
 
 int batadv_originator_init(struct batadv_priv *bat_priv)
@@ -883,7 +897,7 @@ struct batadv_orig_node *batadv_orig_node_new(struct batadv_priv *bat_priv,
 	 * Immediately release vlan since it is not needed anymore in this
 	 * context
 	 */
-	batadv_orig_node_vlan_free_ref(vlan);
+	batadv_orig_node_vlan_put(vlan);
 
 	for (i = 0; i < BATADV_FRAG_BUFFER_COUNT; i++) {
 		INIT_HLIST_HEAD(&orig_node->fragments[i].head);
diff --git a/net/batman-adv/originator.h b/net/batman-adv/originator.h
index b0506ba..0bad6cc 100644
--- a/net/batman-adv/originator.h
+++ b/net/batman-adv/originator.h
@@ -83,7 +83,7 @@ batadv_orig_node_vlan_new(struct batadv_orig_node *orig_node,
 struct batadv_orig_node_vlan *
 batadv_orig_node_vlan_get(struct batadv_orig_node *orig_node,
 			  unsigned short vid);
-void batadv_orig_node_vlan_free_ref(struct batadv_orig_node_vlan *orig_vlan);
+void batadv_orig_node_vlan_put(struct batadv_orig_node_vlan *orig_vlan);
 
 /* hashfunction to choose an entry in a hash table of given size
  * hash algorithm from http://en.wikipedia.org/wiki/Hash_table
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 1ebdcd7..ac66771 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -314,10 +314,10 @@ static void batadv_tt_global_size_mod(struct batadv_orig_node *orig_node,
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
@@ -1614,7 +1614,7 @@ batadv_tt_global_print_entry(struct batadv_priv *bat_priv,
 			   ((flags & BATADV_TT_CLIENT_ISOLA) ? 'I' : '.'),
 			   ((flags & BATADV_TT_CLIENT_TEMP) ? 'T' : '.'));
 
-		batadv_orig_node_vlan_free_ref(vlan);
+		batadv_orig_node_vlan_put(vlan);
 	}
 
 print_list:
@@ -1646,7 +1646,7 @@ print_list:
 			   ((flags & BATADV_TT_CLIENT_ISOLA) ? 'I' : '.'),
 			   ((flags & BATADV_TT_CLIENT_TEMP) ? 'T' : '.'));
 
-		batadv_orig_node_vlan_free_ref(vlan);
+		batadv_orig_node_vlan_put(vlan);
 	}
 }
 
@@ -2465,7 +2465,7 @@ static bool batadv_tt_global_check_crc(struct batadv_orig_node *orig_node,
 			return false;
 
 		crc = vlan->tt.crc;
-		batadv_orig_node_vlan_free_ref(vlan);
+		batadv_orig_node_vlan_put(vlan);
 
 		if (crc != ntohl(tt_vlan_tmp->crc))
 			return false;
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index d69be62..441ebd9 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -197,7 +197,7 @@ struct batadv_orig_node_vlan {
 	unsigned short vid;
 	struct batadv_vlan_tt tt;
 	struct hlist_node list;
-	atomic_t refcount;
+	struct kref refcount;
 	struct rcu_head rcu;
 };
 
-- 
2.6.4


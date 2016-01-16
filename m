Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 16 Jan 2016 10:29:55 +0100
Message-Id: <1452936598-28619-17-git-send-email-sven@narfation.org>
In-Reply-To: <1452936598-28619-1-git-send-email-sven@narfation.org>
References: <1452936598-28619-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v6 17/20] batman-adv: Convert
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

batman-adv uses a self-written reference implementation which is just based
on atomic_t. This is less obvious when reading the code than kref and
therefore increases the change that the reference counting will be missed.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v6:
 - removed patches which are now applied in the branch next
 - rebased remaining patches on the patch
   "batman-adv: Avoid recursive call_rcu for batadv_nc_node" which was
   modified by Marek while he applied the patches (this unfortunately made
   some of the remaining patches "hard" to apply)
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

 net/batman-adv/originator.c | 26 ++++++++++++++++++++------
 net/batman-adv/types.h      |  2 +-
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index bf27007..8b2ef8d 100644
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
- *  the originator-vlan object
+ * batadv_orig_node_vlan_release - release originator-vlan object from lists
+ *  and queue for free after rcu grace period
+ * @ref: kref pointer of the originator-vlan object
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
+ * batadv_orig_node_vlan_free_ref - decrement the refcounter and possibly
+ *  release the originator-vlan object
  * @orig_vlan: the originator-vlan object to release
  */
 void batadv_orig_node_vlan_free_ref(struct batadv_orig_node_vlan *orig_vlan)
 {
-	if (atomic_dec_and_test(&orig_vlan->refcount))
-		kfree_rcu(orig_vlan, rcu);
+	kref_put(&orig_vlan->refcount, batadv_orig_node_vlan_release);
 }
 
 int batadv_originator_init(struct batadv_priv *bat_priv)
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 74cb263..504f3db 100644
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
2.7.0.rc3


Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 16 Jan 2016 10:29:46 +0100
Message-Id: <1452936598-28619-8-git-send-email-sven@narfation.org>
In-Reply-To: <1452936598-28619-1-git-send-email-sven@narfation.org>
References: <1452936598-28619-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v6 08/20] batman-adv: Convert batadv_nc_path
	to kref
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

 net/batman-adv/network-coding.c | 28 +++++++++++++++++++++-------
 net/batman-adv/types.h          |  2 +-
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 7a1216e..371fc6b 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -233,14 +233,27 @@ static void batadv_nc_node_free_ref(struct batadv_nc_node *nc_node)
 }
 
 /**
- * batadv_nc_path_free_ref - decrements the nc path refcounter and possibly
- * frees it
- * @nc_path: the nc node to free
+ * batadv_nc_path_release - release nc_path from lists and queue for free after
+ *  rcu grace period
+ * @ref: kref pointer of the nc_path
+ */
+static void batadv_nc_path_release(struct kref *ref)
+{
+	struct batadv_nc_path *nc_path;
+
+	nc_path = container_of(ref, struct batadv_nc_path, refcount);
+
+	kfree_rcu(nc_path, rcu);
+}
+
+/**
+ * batadv_nc_path_free_ref - decrement the nc_path refcounter and possibly
+ *  release it
+ * @nc_path: nc_path to be free'd
  */
 static void batadv_nc_path_free_ref(struct batadv_nc_path *nc_path)
 {
-	if (atomic_dec_and_test(&nc_path->refcount))
-		kfree_rcu(nc_path, rcu);
+	kref_put(&nc_path->refcount, batadv_nc_path_release);
 }
 
 /**
@@ -545,7 +558,7 @@ batadv_nc_hash_find(struct batadv_hashtable *hash,
 		if (!batadv_nc_hash_compare(&nc_path->hash_entry, data))
 			continue;
 
-		if (!atomic_inc_not_zero(&nc_path->refcount))
+		if (!kref_get_unless_zero(&nc_path->refcount))
 			continue;
 
 		nc_path_tmp = nc_path;
@@ -972,7 +985,8 @@ static struct batadv_nc_path *batadv_nc_get_path(struct batadv_priv *bat_priv,
 	/* Initialize nc_path */
 	INIT_LIST_HEAD(&nc_path->packet_list);
 	spin_lock_init(&nc_path->packet_list_lock);
-	atomic_set(&nc_path->refcount, 2);
+	kref_init(&nc_path->refcount);
+	kref_get(&nc_path->refcount);
 	nc_path->last_valid = jiffies;
 	ether_addr_copy(nc_path->next_hop, dst);
 	ether_addr_copy(nc_path->prev_hop, src);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 05421af..b3d9b5b 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1087,7 +1087,7 @@ struct batadv_nc_node {
 struct batadv_nc_path {
 	struct hlist_node hash_entry;
 	struct rcu_head rcu;
-	atomic_t refcount;
+	struct kref refcount;
 	struct list_head packet_list;
 	spinlock_t packet_list_lock; /* Protects packet_list */
 	u8 next_hop[ETH_ALEN];
-- 
2.7.0.rc3


Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue,  5 Jan 2016 12:06:19 +0100
Message-Id: <1451992006-13191-4-git-send-email-sven@narfation.org>
In-Reply-To: <1451992006-13191-1-git-send-email-sven@narfation.org>
References: <1451992006-13191-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v4 04/31] batman-adv: Avoid recursive
	call_rcu for batadv_nc_node
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

The batadv_nc_node_free_ref function uses call_rcu to delay the free of the
batadv_nc_node object until no (already started) rcu_read_lock is enabled
anymore. This makes sure that no context is still trying to access the
object which should be removed. But batadv_nc_node also contains a
reference to orig_node which must be removed.

The reference drop of orig_node was done in the call_rcu function
batadv_nc_node_free_rcu but should actually be done in the
batadv_nc_node_release function to avoid nested call_rcus. This is
important because rcu_barrier (e.g. batadv_softif_free or batadv_exit) will
not detect the inner call_rcu as relevant for its execution. Otherwise this
barrier will most likely be inserted in the queue before the callback of
the first call_rcu was executed. The caller of rcu_barrier will therefore
continue to run before the inner call_rcu callback finished.

Fixes: 3ed7ada3f0bb ("batman-adv: network coding - detect coding nodes and remove these after timeout")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
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

 net/batman-adv/network-coding.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 56100c5..50af93f 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -207,28 +207,25 @@ void batadv_nc_init_orig(struct batadv_orig_node *orig_node)
 }
 
 /**
- * batadv_nc_node_free_rcu - rcu callback to free an nc node and remove
- *  its refcount on the orig_node
- * @rcu: rcu pointer of the nc node
+ * batadv_nc_node_release - release nc_node from lists and queue for free after
+ *  rcu grace period
+ * @nc_node: the nc node to free
  */
-static void batadv_nc_node_free_rcu(struct rcu_head *rcu)
+static void batadv_nc_node_release(struct batadv_nc_node *nc_node)
 {
-	struct batadv_nc_node *nc_node;
-
-	nc_node = container_of(rcu, struct batadv_nc_node, rcu);
 	batadv_orig_node_free_ref(nc_node->orig_node);
-	kfree(nc_node);
+	kfree_rcu(nc_node, rcu);
 }
 
 /**
  * batadv_nc_node_free_ref - decrements the nc node refcounter and possibly
- * frees it
+ *  release it
  * @nc_node: the nc node to free
  */
 static void batadv_nc_node_free_ref(struct batadv_nc_node *nc_node)
 {
 	if (atomic_dec_and_test(&nc_node->refcount))
-		call_rcu(&nc_node->rcu, batadv_nc_node_free_rcu);
+		batadv_nc_node_release(nc_node);
 }
 
 /**
-- 
2.6.4


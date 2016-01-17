Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 17 Jan 2016 11:01:14 +0100
Message-Id: <1453024887-7215-6-git-send-email-sven@narfation.org>
In-Reply-To: <1453024887-7215-1-git-send-email-sven@narfation.org>
References: <1453024887-7215-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v7 06/19] batman-adv: Rename
	batadv_hardif_neigh *_free_ref function to *_put
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

 net/batman-adv/bat_iv_ogm.c |  2 +-
 net/batman-adv/originator.c | 10 +++++-----
 net/batman-adv/originator.h |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index ba48fb2..5651e33 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1574,7 +1574,7 @@ out:
 	if (orig_neigh_router)
 		batadv_neigh_node_put(orig_neigh_router);
 	if (hardif_neigh)
-		batadv_hardif_neigh_free_ref(hardif_neigh);
+		batadv_hardif_neigh_put(hardif_neigh);
 
 	kfree_skb(skb_priv);
 }
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 6056415..0b1a77d 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -232,11 +232,11 @@ static void batadv_hardif_neigh_release(struct kref *ref)
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
@@ -266,8 +266,8 @@ static void batadv_neigh_node_release(struct kref *ref)
 					       neigh_node->addr);
 	if (hardif_neigh) {
 		/* batadv_hardif_neigh_get() increases refcount too */
-		batadv_hardif_neigh_free_ref(hardif_neigh);
-		batadv_hardif_neigh_free_ref(hardif_neigh);
+		batadv_hardif_neigh_put(hardif_neigh);
+		batadv_hardif_neigh_put(hardif_neigh);
 	}
 
 	if (bao->bat_neigh_free)
@@ -681,7 +681,7 @@ batadv_neigh_node_new(struct batadv_orig_node *orig_node,
 
 out:
 	if (hardif_neigh)
-		batadv_hardif_neigh_free_ref(hardif_neigh);
+		batadv_hardif_neigh_put(hardif_neigh);
 	return neigh_node;
 }
 
diff --git a/net/batman-adv/originator.h b/net/batman-adv/originator.h
index adbe7aa..97748e8 100644
--- a/net/batman-adv/originator.h
+++ b/net/batman-adv/originator.h
@@ -44,7 +44,7 @@ struct batadv_hardif_neigh_node *
 batadv_hardif_neigh_get(const struct batadv_hard_iface *hard_iface,
 			const u8 *neigh_addr);
 void
-batadv_hardif_neigh_free_ref(struct batadv_hardif_neigh_node *hardif_neigh);
+batadv_hardif_neigh_put(struct batadv_hardif_neigh_node *hardif_neigh);
 struct batadv_neigh_node *
 batadv_neigh_node_new(struct batadv_orig_node *orig_node,
 		      struct batadv_hard_iface *hard_iface,
-- 
2.7.0.rc3


Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 17 Jan 2016 11:01:22 +0100
Message-Id: <1453024887-7215-14-git-send-email-sven@narfation.org>
In-Reply-To: <1453024887-7215-1-git-send-email-sven@narfation.org>
References: <1453024887-7215-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v7 14/19] batman-adv: Rename batadv_nc_node
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

 net/batman-adv/network-coding.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 9180ff1..6105cfb 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -223,11 +223,11 @@ static void batadv_nc_node_release(struct kref *ref)
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
@@ -356,7 +356,7 @@ batadv_nc_purge_orig_nc_nodes(struct batadv_priv *bat_priv,
 			   "Removing nc_node %pM -> %pM\n",
 			   nc_node->addr, nc_node->orig_node->orig);
 		list_del_rcu(&nc_node->list);
-		batadv_nc_node_free_ref(nc_node);
+		batadv_nc_node_put(nc_node);
 	}
 	spin_unlock_bh(lock);
 }
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
-- 
2.7.0.rc3


Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 17 Jan 2016 11:01:23 +0100
Message-Id: <1453024887-7215-15-git-send-email-sven@narfation.org>
In-Reply-To: <1453024887-7215-1-git-send-email-sven@narfation.org>
References: <1453024887-7215-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v7 15/19] batman-adv: Rename batadv_nc_path
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

 net/batman-adv/network-coding.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 6105cfb..d253bb2 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
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
 
@@ -467,7 +467,7 @@ static void batadv_nc_purge_paths(struct batadv_priv *bat_priv,
 				   "Remove nc_path %pM -> %pM\n",
 				   nc_path->prev_hop, nc_path->next_hop);
 			hlist_del_rcu(&nc_path->hash_entry);
-			batadv_nc_path_free_ref(nc_path);
+			batadv_nc_path_put(nc_path);
 		}
 		spin_unlock_bh(lock);
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
-- 
2.7.0.rc3


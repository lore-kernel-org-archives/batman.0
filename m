Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 17 Jan 2016 11:01:24 +0100
Message-Id: <1453024887-7215-16-git-send-email-sven@narfation.org>
In-Reply-To: <1453024887-7215-1-git-send-email-sven@narfation.org>
References: <1453024887-7215-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v7 16/19] batman-adv: Rename
	batadv_orig_node_vlan *_free_ref function to *_put
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

 net/batman-adv/originator.c        |  8 ++++----
 net/batman-adv/originator.h        |  2 +-
 net/batman-adv/translation-table.c | 10 +++++-----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 0b1a77d..e4cbb07 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -151,11 +151,11 @@ static void batadv_orig_node_vlan_release(struct kref *ref)
 }
 
 /**
- * batadv_orig_node_vlan_free_ref - decrement the refcounter and possibly
- *  release the originator-vlan object
+ * batadv_orig_node_vlan_put - decrement the refcounter and possibly release
+ *  the originator-vlan object
  * @orig_vlan: the originator-vlan object to release
  */
-void batadv_orig_node_vlan_free_ref(struct batadv_orig_node_vlan *orig_vlan)
+void batadv_orig_node_vlan_put(struct batadv_orig_node_vlan *orig_vlan)
 {
 	kref_put(&orig_vlan->refcount, batadv_orig_node_vlan_release);
 }
@@ -917,7 +917,7 @@ struct batadv_orig_node *batadv_orig_node_new(struct batadv_priv *bat_priv,
 	 * Immediately release vlan since it is not needed anymore in this
 	 * context
 	 */
-	batadv_orig_node_vlan_free_ref(vlan);
+	batadv_orig_node_vlan_put(vlan);
 
 	for (i = 0; i < BATADV_FRAG_BUFFER_COUNT; i++) {
 		INIT_HLIST_HEAD(&orig_node->fragments[i].head);
diff --git a/net/batman-adv/originator.h b/net/batman-adv/originator.h
index 97748e8..4e8b67f 100644
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
index 02ba63c..c4f12ef 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -348,10 +348,10 @@ static void batadv_tt_global_size_mod(struct batadv_orig_node *orig_node,
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
@@ -1650,7 +1650,7 @@ batadv_tt_global_print_entry(struct batadv_priv *bat_priv,
 			   ((flags & BATADV_TT_CLIENT_ISOLA) ? 'I' : '.'),
 			   ((flags & BATADV_TT_CLIENT_TEMP) ? 'T' : '.'));
 
-		batadv_orig_node_vlan_free_ref(vlan);
+		batadv_orig_node_vlan_put(vlan);
 	}
 
 print_list:
@@ -1682,7 +1682,7 @@ print_list:
 			   ((flags & BATADV_TT_CLIENT_ISOLA) ? 'I' : '.'),
 			   ((flags & BATADV_TT_CLIENT_TEMP) ? 'T' : '.'));
 
-		batadv_orig_node_vlan_free_ref(vlan);
+		batadv_orig_node_vlan_put(vlan);
 	}
 }
 
@@ -2501,7 +2501,7 @@ static bool batadv_tt_global_check_crc(struct batadv_orig_node *orig_node,
 			return false;
 
 		crc = vlan->tt.crc;
-		batadv_orig_node_vlan_free_ref(vlan);
+		batadv_orig_node_vlan_put(vlan);
 
 		if (crc != ntohl(tt_vlan_tmp->crc))
 			return false;
-- 
2.7.0.rc3


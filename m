Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 17 Jan 2016 11:01:27 +0100
Message-Id: <1453024887-7215-19-git-send-email-sven@narfation.org>
In-Reply-To: <1453024887-7215-1-git-send-email-sven@narfation.org>
References: <1453024887-7215-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v7 19/19] batman-adv: Rename
	batadv_tt_orig_list_entry *_free_ref function to *_put
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

 net/batman-adv/translation-table.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index bfd1c0d..2fd5b28 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -395,12 +395,12 @@ static void batadv_tt_orig_list_entry_release(struct kref *ref)
 }
 
 /**
- * batadv_tt_orig_list_entry_free_ref - decrement the tt orig entry refcounter
- *  and possibly release it
+ * batadv_tt_orig_list_entry_put - decrement the tt orig entry refcounter and
+ *  possibly release it
  * @orig_entry: tt orig entry to be free'd
  */
 static void
-batadv_tt_orig_list_entry_free_ref(struct batadv_tt_orig_list_entry *orig_entry)
+batadv_tt_orig_list_entry_put(struct batadv_tt_orig_list_entry *orig_entry)
 {
 	kref_put(&orig_entry->refcount, batadv_tt_orig_list_entry_release);
 }
@@ -1343,7 +1343,7 @@ batadv_tt_global_entry_has_orig(const struct batadv_tt_global_entry *entry,
 	orig_entry = batadv_tt_global_orig_entry_find(entry, orig_node);
 	if (orig_entry) {
 		found = true;
-		batadv_tt_orig_list_entry_free_ref(orig_entry);
+		batadv_tt_orig_list_entry_put(orig_entry);
 	}
 
 	return found;
@@ -1384,7 +1384,7 @@ batadv_tt_global_orig_entry_add(struct batadv_tt_global_entry *tt_global,
 
 out:
 	if (orig_entry)
-		batadv_tt_orig_list_entry_free_ref(orig_entry);
+		batadv_tt_orig_list_entry_put(orig_entry);
 }
 
 /**
@@ -1751,7 +1751,7 @@ _batadv_tt_global_del_orig_entry(struct batadv_tt_global_entry *tt_global_entry,
 	 * being part of a list
 	 */
 	hlist_del_rcu(&orig_entry->list);
-	batadv_tt_orig_list_entry_free_ref(orig_entry);
+	batadv_tt_orig_list_entry_put(orig_entry);
 }
 
 /* deletes the orig list of a tt_global_entry */
-- 
2.7.0.rc3


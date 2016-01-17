Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 17 Jan 2016 11:01:25 +0100
Message-Id: <1453024887-7215-17-git-send-email-sven@narfation.org>
In-Reply-To: <1453024887-7215-1-git-send-email-sven@narfation.org>
References: <1453024887-7215-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v7 17/19] batman-adv: Rename
	batadv_tt_local_entry *_free_ref function to *_put
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

 net/batman-adv/translation-table.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index c4f12ef..df08cfd 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -219,12 +219,12 @@ static void batadv_tt_local_entry_release(struct kref *ref)
 }
 
 /**
- * batadv_tt_local_entry_free_ref - decrement the tt_local_entry refcounter and
+ * batadv_tt_local_entry_put - decrement the tt_local_entry refcounter and
  *  possibly release it
  * @tt_local_entry: tt_local_entry to be free'd
  */
 static void
-batadv_tt_local_entry_free_ref(struct batadv_tt_local_entry *tt_local_entry)
+batadv_tt_local_entry_put(struct batadv_tt_local_entry *tt_local_entry)
 {
 	kref_put(&tt_local_entry->common.refcount,
 		 batadv_tt_local_entry_release);
@@ -685,7 +685,7 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
 
 	if (unlikely(hash_added != 0)) {
 		/* remove the reference for the hash */
-		batadv_tt_local_entry_free_ref(tt_local);
+		batadv_tt_local_entry_put(tt_local);
 		batadv_softif_vlan_put(vlan);
 		goto out;
 	}
@@ -752,7 +752,7 @@ out:
 	if (in_dev)
 		dev_put(in_dev);
 	if (tt_local)
-		batadv_tt_local_entry_free_ref(tt_local);
+		batadv_tt_local_entry_put(tt_local);
 	if (tt_global)
 		batadv_tt_global_entry_free_ref(tt_global);
 	return ret;
@@ -1135,7 +1135,7 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 		goto out;
 
 	/* extra call to free the local tt entry */
-	batadv_tt_local_entry_free_ref(tt_local_entry);
+	batadv_tt_local_entry_put(tt_local_entry);
 
 	/* decrease the reference held for this vlan */
 	vlan = batadv_softif_vlan_get(bat_priv, vid);
@@ -1147,7 +1147,7 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 
 out:
 	if (tt_local_entry)
-		batadv_tt_local_entry_free_ref(tt_local_entry);
+		batadv_tt_local_entry_put(tt_local_entry);
 
 	return curr_flags;
 }
@@ -1247,7 +1247,7 @@ static void batadv_tt_local_table_free(struct batadv_priv *bat_priv)
 				batadv_softif_vlan_put(vlan);
 			}
 
-			batadv_tt_local_entry_free_ref(tt_local);
+			batadv_tt_local_entry_put(tt_local);
 		}
 		spin_unlock_bh(list_lock);
 	}
@@ -1553,7 +1553,7 @@ out:
 	if (tt_global_entry)
 		batadv_tt_global_entry_free_ref(tt_global_entry);
 	if (tt_local_entry)
-		batadv_tt_local_entry_free_ref(tt_local_entry);
+		batadv_tt_local_entry_put(tt_local_entry);
 	return ret;
 }
 
@@ -1909,7 +1909,7 @@ out:
 	if (tt_global_entry)
 		batadv_tt_global_entry_free_ref(tt_global_entry);
 	if (local_entry)
-		batadv_tt_local_entry_free_ref(local_entry);
+		batadv_tt_local_entry_put(local_entry);
 }
 
 /**
@@ -2141,7 +2141,7 @@ out:
 	if (tt_global_entry)
 		batadv_tt_global_entry_free_ref(tt_global_entry);
 	if (tt_local_entry)
-		batadv_tt_local_entry_free_ref(tt_local_entry);
+		batadv_tt_local_entry_put(tt_local_entry);
 
 	return orig_node;
 }
@@ -3021,7 +3021,7 @@ bool batadv_is_my_client(struct batadv_priv *bat_priv, const u8 *addr,
 	ret = true;
 out:
 	if (tt_local_entry)
-		batadv_tt_local_entry_free_ref(tt_local_entry);
+		batadv_tt_local_entry_put(tt_local_entry);
 	return ret;
 }
 
@@ -3344,7 +3344,7 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 				batadv_softif_vlan_put(vlan);
 			}
 
-			batadv_tt_local_entry_free_ref(tt_local);
+			batadv_tt_local_entry_put(tt_local);
 		}
 		spin_unlock_bh(list_lock);
 	}
@@ -3431,7 +3431,7 @@ out:
 	if (tt_global_entry)
 		batadv_tt_global_entry_free_ref(tt_global_entry);
 	if (tt_local_entry)
-		batadv_tt_local_entry_free_ref(tt_local_entry);
+		batadv_tt_local_entry_put(tt_local_entry);
 	return ret;
 }
 
@@ -3567,7 +3567,7 @@ bool batadv_tt_local_client_is_roaming(struct batadv_priv *bat_priv,
 		goto out;
 
 	ret = tt_local_entry->common.flags & BATADV_TT_CLIENT_ROAM;
-	batadv_tt_local_entry_free_ref(tt_local_entry);
+	batadv_tt_local_entry_put(tt_local_entry);
 out:
 	return ret;
 }
-- 
2.7.0.rc3


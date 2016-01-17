Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 17 Jan 2016 11:01:21 +0100
Message-Id: <1453024887-7215-13-git-send-email-sven@narfation.org>
In-Reply-To: <1453024887-7215-1-git-send-email-sven@narfation.org>
References: <1453024887-7215-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v7 13/19] batman-adv: Rename
	batadv_softif_vlan *_free_ref function to *_put
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

 net/batman-adv/main.c              |  2 +-
 net/batman-adv/soft-interface.c    | 14 +++++++-------
 net/batman-adv/soft-interface.h    |  2 +-
 net/batman-adv/sysfs.c             |  4 ++--
 net/batman-adv/translation-table.c | 20 ++++++++++----------
 5 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index bf8a01b..e3d7051 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -1261,7 +1261,7 @@ bool batadv_vlan_ap_isola_get(struct batadv_priv *bat_priv, unsigned short vid)
 	vlan = batadv_softif_vlan_get(bat_priv, vid);
 	if (vlan) {
 		ap_isolation_enabled = atomic_read(&vlan->ap_isolation);
-		batadv_softif_vlan_free_ref(vlan);
+		batadv_softif_vlan_put(vlan);
 	}
 
 	return ap_isolation_enabled;
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index ca8fa4e..0710379 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -497,11 +497,11 @@ static void batadv_softif_vlan_release(struct kref *ref)
 }
 
 /**
- * batadv_softif_vlan_free_ref - decrease the vlan object refcounter and
+ * batadv_softif_vlan_put - decrease the vlan object refcounter and
  *  possibly release it
  * @vlan: the vlan object to release
  */
-void batadv_softif_vlan_free_ref(struct batadv_softif_vlan *vlan)
+void batadv_softif_vlan_put(struct batadv_softif_vlan *vlan)
 {
 	if (!vlan)
 		return;
@@ -552,7 +552,7 @@ int batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
 
 	vlan = batadv_softif_vlan_get(bat_priv, vid);
 	if (vlan) {
-		batadv_softif_vlan_free_ref(vlan);
+		batadv_softif_vlan_put(vlan);
 		return -EEXIST;
 	}
 
@@ -601,7 +601,7 @@ static void batadv_softif_destroy_vlan(struct batadv_priv *bat_priv,
 			       vlan->vid, "vlan interface destroyed", false);
 
 	batadv_sysfs_del_vlan(bat_priv, vlan);
-	batadv_softif_vlan_free_ref(vlan);
+	batadv_softif_vlan_put(vlan);
 }
 
 /**
@@ -646,7 +646,7 @@ static int batadv_interface_add_vid(struct net_device *dev, __be16 proto,
 	if (!vlan->kobj) {
 		ret = batadv_sysfs_add_vlan(bat_priv->soft_iface, vlan);
 		if (ret) {
-			batadv_softif_vlan_free_ref(vlan);
+			batadv_softif_vlan_put(vlan);
 			return ret;
 		}
 	}
@@ -693,7 +693,7 @@ static int batadv_interface_kill_vid(struct net_device *dev, __be16 proto,
 	batadv_softif_destroy_vlan(bat_priv, vlan);
 
 	/* finally free the vlan object */
-	batadv_softif_vlan_free_ref(vlan);
+	batadv_softif_vlan_put(vlan);
 
 	return 0;
 }
@@ -749,7 +749,7 @@ static void batadv_softif_destroy_finish(struct work_struct *work)
 	vlan = batadv_softif_vlan_get(bat_priv, BATADV_NO_FLAGS);
 	if (vlan) {
 		batadv_softif_destroy_vlan(bat_priv, vlan);
-		batadv_softif_vlan_free_ref(vlan);
+		batadv_softif_vlan_put(vlan);
 	}
 
 	batadv_sysfs_del_meshif(soft_iface);
diff --git a/net/batman-adv/soft-interface.h b/net/batman-adv/soft-interface.h
index d17cfba..9ae2657 100644
--- a/net/batman-adv/soft-interface.h
+++ b/net/batman-adv/soft-interface.h
@@ -34,7 +34,7 @@ void batadv_softif_destroy_sysfs(struct net_device *soft_iface);
 int batadv_softif_is_valid(const struct net_device *net_dev);
 extern struct rtnl_link_ops batadv_link_ops;
 int batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid);
-void batadv_softif_vlan_free_ref(struct batadv_softif_vlan *softif_vlan);
+void batadv_softif_vlan_put(struct batadv_softif_vlan *softif_vlan);
 struct batadv_softif_vlan *batadv_softif_vlan_get(struct batadv_priv *bat_priv,
 						  unsigned short vid);
 
diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index 0db7591..4d70d44 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -216,7 +216,7 @@ ssize_t batadv_store_vlan_##_name(struct kobject *kobj,			\
 					      attr, &vlan->_name,	\
 					      bat_priv->soft_iface);	\
 									\
-	batadv_softif_vlan_free_ref(vlan);				\
+	batadv_softif_vlan_put(vlan);					\
 	return res;							\
 }
 
@@ -231,7 +231,7 @@ ssize_t batadv_show_vlan_##_name(struct kobject *kobj,			\
 			     atomic_read(&vlan->_name) == 0 ?		\
 			     "disabled" : "enabled");			\
 									\
-	batadv_softif_vlan_free_ref(vlan);				\
+	batadv_softif_vlan_put(vlan);					\
 	return res;							\
 }
 
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 557d7f5..02ba63c 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -301,7 +301,7 @@ static void batadv_tt_local_size_mod(struct batadv_priv *bat_priv,
 
 	atomic_add(v, &vlan->tt.num_entries);
 
-	batadv_softif_vlan_free_ref(vlan);
+	batadv_softif_vlan_put(vlan);
 }
 
 /**
@@ -686,7 +686,7 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
 	if (unlikely(hash_added != 0)) {
 		/* remove the reference for the hash */
 		batadv_tt_local_entry_free_ref(tt_local);
-		batadv_softif_vlan_free_ref(vlan);
+		batadv_softif_vlan_put(vlan);
 		goto out;
 	}
 
@@ -1052,7 +1052,7 @@ int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 				   no_purge ? 0 : last_seen_msecs,
 				   vlan->tt.crc);
 
-			batadv_softif_vlan_free_ref(vlan);
+			batadv_softif_vlan_put(vlan);
 		}
 		rcu_read_unlock();
 	}
@@ -1142,8 +1142,8 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 	if (!vlan)
 		goto out;
 
-	batadv_softif_vlan_free_ref(vlan);
-	batadv_softif_vlan_free_ref(vlan);
+	batadv_softif_vlan_put(vlan);
+	batadv_softif_vlan_put(vlan);
 
 out:
 	if (tt_local_entry)
@@ -1243,8 +1243,8 @@ static void batadv_tt_local_table_free(struct batadv_priv *bat_priv)
 			vlan = batadv_softif_vlan_get(bat_priv,
 						      tt_common_entry->vid);
 			if (vlan) {
-				batadv_softif_vlan_free_ref(vlan);
-				batadv_softif_vlan_free_ref(vlan);
+				batadv_softif_vlan_put(vlan);
+				batadv_softif_vlan_put(vlan);
 			}
 
 			batadv_tt_local_entry_free_ref(tt_local);
@@ -3340,8 +3340,8 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 			/* decrease the reference held for this vlan */
 			vlan = batadv_softif_vlan_get(bat_priv, tt_common->vid);
 			if (vlan) {
-				batadv_softif_vlan_free_ref(vlan);
-				batadv_softif_vlan_free_ref(vlan);
+				batadv_softif_vlan_put(vlan);
+				batadv_softif_vlan_put(vlan);
 			}
 
 			batadv_tt_local_entry_free_ref(tt_local);
@@ -3427,7 +3427,7 @@ bool batadv_is_ap_isolated(struct batadv_priv *bat_priv, u8 *src, u8 *dst,
 	ret = true;
 
 out:
-	batadv_softif_vlan_free_ref(vlan);
+	batadv_softif_vlan_put(vlan);
 	if (tt_global_entry)
 		batadv_tt_global_entry_free_ref(tt_global_entry);
 	if (tt_local_entry)
-- 
2.7.0.rc3


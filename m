Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue,  5 Jan 2016 12:06:30 +0100
Message-Id: <1451992006-13191-15-git-send-email-sven@narfation.org>
In-Reply-To: <1451992006-13191-1-git-send-email-sven@narfation.org>
References: <1451992006-13191-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v4 15/31] batman-adv: Convert
	batadv_softif_vlan to kref
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

 net/batman-adv/soft-interface.c | 33 +++++++++++++++++++++++----------
 net/batman-adv/sysfs.c          |  3 ++-
 net/batman-adv/types.h          |  2 +-
 3 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 6c65de9..4b55b5f 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -30,6 +30,7 @@
 #include <linux/if_vlan.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
+#include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/lockdep.h>
 #include <linux/netdevice.h>
@@ -478,8 +479,26 @@ out:
 }
 
 /**
+ * batadv_softif_vlan_release - release vlan from lists and queue for free after
+ *  rcu grace period
+ * @ref: kref pointer of the vlan object
+ */
+static void batadv_softif_vlan_release(struct kref *ref)
+{
+	struct batadv_softif_vlan *vlan;
+
+	vlan = container_of(ref, struct batadv_softif_vlan, refcount);
+
+	spin_lock_bh(&vlan->bat_priv->softif_vlan_list_lock);
+	hlist_del_rcu(&vlan->list);
+	spin_unlock_bh(&vlan->bat_priv->softif_vlan_list_lock);
+
+	kfree_rcu(vlan, rcu);
+}
+
+/**
  * batadv_softif_vlan_free_ref - decrease the vlan object refcounter and
- *  possibly free it
+ *  possibly release it
  * @vlan: the vlan object to release
  */
 void batadv_softif_vlan_free_ref(struct batadv_softif_vlan *vlan)
@@ -487,13 +506,7 @@ void batadv_softif_vlan_free_ref(struct batadv_softif_vlan *vlan)
 	if (!vlan)
 		return;
 
-	if (atomic_dec_and_test(&vlan->refcount)) {
-		spin_lock_bh(&vlan->bat_priv->softif_vlan_list_lock);
-		hlist_del_rcu(&vlan->list);
-		spin_unlock_bh(&vlan->bat_priv->softif_vlan_list_lock);
-
-		kfree_rcu(vlan, rcu);
-	}
+	kref_put(&vlan->refcount, batadv_softif_vlan_release);
 }
 
 /**
@@ -514,7 +527,7 @@ struct batadv_softif_vlan *batadv_softif_vlan_get(struct batadv_priv *bat_priv,
 		if (vlan_tmp->vid != vid)
 			continue;
 
-		if (!atomic_inc_not_zero(&vlan_tmp->refcount))
+		if (!kref_get_unless_zero(&vlan_tmp->refcount))
 			continue;
 
 		vlan = vlan_tmp;
@@ -549,7 +562,7 @@ int batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
 
 	vlan->bat_priv = bat_priv;
 	vlan->vid = vid;
-	atomic_set(&vlan->refcount, 1);
+	kref_init(&vlan->refcount);
 
 	atomic_set(&vlan->ap_isolation, 0);
 
diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index f38d7b7..4f578ac 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -25,6 +25,7 @@
 #include <linux/fs.h>
 #include <linux/if.h>
 #include <linux/if_vlan.h>
+#include <linux/kref.h>
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
 #include <linux/printk.h>
@@ -97,7 +98,7 @@ batadv_kobj_to_vlan(struct batadv_priv *bat_priv, struct kobject *obj)
 		if (vlan_tmp->kobj != obj)
 			continue;
 
-		if (!atomic_inc_not_zero(&vlan_tmp->refcount))
+		if (!kref_get_unless_zero(&vlan_tmp->refcount))
 			continue;
 
 		vlan = vlan_tmp;
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 0b3cbdb..c6c3f0f 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -746,7 +746,7 @@ struct batadv_softif_vlan {
 	atomic_t ap_isolation;		/* boolean */
 	struct batadv_vlan_tt tt;
 	struct hlist_node list;
-	atomic_t refcount;
+	struct kref refcount;
 	struct rcu_head rcu;
 };
 
-- 
2.6.4


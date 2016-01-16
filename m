Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 16 Jan 2016 10:29:43 +0100
Message-Id: <1452936598-28619-5-git-send-email-sven@narfation.org>
In-Reply-To: <1452936598-28619-1-git-send-email-sven@narfation.org>
References: <1452936598-28619-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v6 05/20] batman-adv: Convert
	batadv_bla_backbone_gw to kref
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

 net/batman-adv/bridge_loop_avoidance.c | 29 +++++++++++++++++++++++------
 net/batman-adv/types.h                 |  2 +-
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 7e92fd1..0937097 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -31,6 +31,7 @@
 #include <linux/jhash.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
+#include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/lockdep.h>
 #include <linux/netdevice.h>
@@ -143,14 +144,29 @@ static int batadv_compare_claim(const struct hlist_node *node,
 }
 
 /**
- * batadv_compare_backbone_gw - free backbone gw
+ * batadv_backbone_gw_release - release backbone gw from lists and queue for
+ *  free after rcu grace period
+ * @ref: kref pointer of the backbone gw
+ */
+static void batadv_backbone_gw_release(struct kref *ref)
+{
+	struct batadv_bla_backbone_gw *backbone_gw;
+
+	backbone_gw = container_of(ref, struct batadv_bla_backbone_gw,
+				   refcount);
+
+	kfree_rcu(backbone_gw, rcu);
+}
+
+/**
+ * batadv_backbone_gw_free_ref - decrement the backbone gw refcounter and
+ *  possibly release it
  * @backbone_gw: backbone gateway to be free'd
  */
 static void
 batadv_backbone_gw_free_ref(struct batadv_bla_backbone_gw *backbone_gw)
 {
-	if (atomic_dec_and_test(&backbone_gw->refcount))
-		kfree_rcu(backbone_gw, rcu);
+	kref_put(&backbone_gw->refcount, batadv_backbone_gw_release);
 }
 
 /**
@@ -247,7 +263,7 @@ batadv_backbone_hash_find(struct batadv_priv *bat_priv, u8 *addr,
 						&search_entry))
 			continue;
 
-		if (!atomic_inc_not_zero(&backbone_gw->refcount))
+		if (!kref_get_unless_zero(&backbone_gw->refcount))
 			continue;
 
 		backbone_gw_tmp = backbone_gw;
@@ -448,7 +464,8 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, u8 *orig,
 	ether_addr_copy(entry->orig, orig);
 
 	/* one for the hash, one for returning */
-	atomic_set(&entry->refcount, 2);
+	kref_init(&entry->refcount);
+	kref_get(&entry->refcount);
 
 	hash_added = batadv_hash_add(bat_priv->bla.backbone_hash,
 				     batadv_compare_backbone_gw,
@@ -664,7 +681,7 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 		batadv_backbone_gw_free_ref(claim->backbone_gw);
 	}
 	/* set (new) backbone gw */
-	atomic_inc(&backbone_gw->refcount);
+	kref_get(&backbone_gw->refcount);
 	claim->backbone_gw = backbone_gw;
 
 	spin_lock_bh(&backbone_gw->crc_lock);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 868f6b5..595f524 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -930,7 +930,7 @@ struct batadv_bla_backbone_gw {
 	atomic_t request_sent;
 	u16 crc;
 	spinlock_t crc_lock; /* protects crc */
-	atomic_t refcount;
+	struct kref refcount;
 	struct rcu_head rcu;
 };
 
-- 
2.7.0.rc3


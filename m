Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 16 Jan 2016 10:29:48 +0100
Message-Id: <1452936598-28619-10-git-send-email-sven@narfation.org>
In-Reply-To: <1452936598-28619-1-git-send-email-sven@narfation.org>
References: <1452936598-28619-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v6 10/20] batman-adv: Convert
	batadv_tvlv_container to kref
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

 net/batman-adv/main.c  | 22 +++++++++++++++++-----
 net/batman-adv/types.h |  2 +-
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index a9b4f75..4b6c258 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -29,6 +29,7 @@
 #include <linux/ip.h>
 #include <linux/ipv6.h>
 #include <linux/kernel.h>
+#include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/lockdep.h>
 #include <linux/module.h>
@@ -670,14 +671,25 @@ static struct batadv_tvlv_handler
 }
 
 /**
+ * batadv_tvlv_container_release - release tvlv from lists and free
+ * @ref: kref pointer of the tvlv
+ */
+static void batadv_tvlv_container_release(struct kref *ref)
+{
+	struct batadv_tvlv_container *tvlv;
+
+	tvlv = container_of(ref, struct batadv_tvlv_container, refcount);
+	kfree(tvlv);
+}
+
+/**
  * batadv_tvlv_container_free_ref - decrement the tvlv container refcounter and
- *  possibly free it
+ *  possibly release it
  * @tvlv: the tvlv container to free
  */
 static void batadv_tvlv_container_free_ref(struct batadv_tvlv_container *tvlv)
 {
-	if (atomic_dec_and_test(&tvlv->refcount))
-		kfree(tvlv);
+	kref_put(&tvlv->refcount, batadv_tvlv_container_release);
 }
 
 /**
@@ -706,7 +718,7 @@ static struct batadv_tvlv_container
 		if (tvlv_tmp->tvlv_hdr.version != version)
 			continue;
 
-		if (!atomic_inc_not_zero(&tvlv_tmp->refcount))
+		if (!kref_get_unless_zero(&tvlv_tmp->refcount))
 			continue;
 
 		tvlv = tvlv_tmp;
@@ -814,7 +826,7 @@ void batadv_tvlv_container_register(struct batadv_priv *bat_priv,
 
 	memcpy(tvlv_new + 1, tvlv_value, ntohs(tvlv_new->tvlv_hdr.len));
 	INIT_HLIST_NODE(&tvlv_new->list);
-	atomic_set(&tvlv_new->refcount, 1);
+	kref_init(&tvlv_new->refcount);
 
 	spin_lock_bh(&bat_priv->tvlv.container_list_lock);
 	tvlv_old = batadv_tvlv_container_get(bat_priv, type, version);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 9df8f39..c55925b 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1266,7 +1266,7 @@ struct batadv_dat_candidate {
 struct batadv_tvlv_container {
 	struct hlist_node list;
 	struct batadv_tvlv_hdr tvlv_hdr;
-	atomic_t refcount;
+	struct kref refcount;
 };
 
 /**
-- 
2.7.0.rc3


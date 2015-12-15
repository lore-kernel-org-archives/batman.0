Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 16 Dec 2015 00:31:46 +0100
Message-Id: <1450222316-1764-13-git-send-email-sven@narfation.org>
In-Reply-To: <1450222316-1764-1-git-send-email-sven@narfation.org>
References: <1450222316-1764-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 13/23] batman-adv: Convert
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

So switch to kref instead of using the self-made, atomic_t-based
implementation.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/main.c  | 28 ++++++++++++++++++++--------
 net/batman-adv/types.h |  2 +-
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index cfcc448..0f9ed4d 100644
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
- * batadv_tvlv_container_free_ref - decrement the tvlv container refcounter and
+ * batadv_tvlv_container_release - release tvlv from lists and free
+ * * @ref: kref pointer of the tvlv
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
+ * batadv_tvlv_container_put - decrement the tvlv container refcounter and
  *  possibly free it
  * @tvlv: the tvlv container to free
  */
-static void batadv_tvlv_container_free_ref(struct batadv_tvlv_container *tvlv)
+static void batadv_tvlv_container_put(struct batadv_tvlv_container *tvlv)
 {
-	if (atomic_dec_and_test(&tvlv->refcount))
-		kfree(tvlv);
+	kref_put(&tvlv->refcount, batadv_tvlv_container_release);
 }
 
 /**
@@ -704,7 +716,7 @@ static struct batadv_tvlv_container
 		if (tvlv_tmp->tvlv_hdr.version != version)
 			continue;
 
-		if (!atomic_inc_not_zero(&tvlv_tmp->refcount))
+		if (!kref_get_unless_zero(&tvlv_tmp->refcount))
 			continue;
 
 		tvlv = tvlv_tmp;
@@ -757,8 +769,8 @@ static void batadv_tvlv_container_remove(struct batadv_priv *bat_priv,
 	hlist_del(&tvlv->list);
 
 	/* first call to decrement the counter, second call to free */
-	batadv_tvlv_container_free_ref(tvlv);
-	batadv_tvlv_container_free_ref(tvlv);
+	batadv_tvlv_container_put(tvlv);
+	batadv_tvlv_container_put(tvlv);
 }
 
 /**
@@ -810,7 +822,7 @@ void batadv_tvlv_container_register(struct batadv_priv *bat_priv,
 
 	memcpy(tvlv_new + 1, tvlv_value, ntohs(tvlv_new->tvlv_hdr.len));
 	INIT_HLIST_NODE(&tvlv_new->list);
-	atomic_set(&tvlv_new->refcount, 1);
+	kref_init(&tvlv_new->refcount);
 
 	spin_lock_bh(&bat_priv->tvlv.container_list_lock);
 	tvlv_old = batadv_tvlv_container_get(bat_priv, type, version);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index a6ba6c0..0ebd5a4 100644
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
2.6.4


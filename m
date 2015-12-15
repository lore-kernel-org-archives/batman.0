Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 16 Dec 2015 00:31:47 +0100
Message-Id: <1450222316-1764-14-git-send-email-sven@narfation.org>
In-Reply-To: <1450222316-1764-1-git-send-email-sven@narfation.org>
References: <1450222316-1764-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 14/23] batman-adv: Convert
	batadv_tvlv_handler to kref
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
 net/batman-adv/main.c  | 33 ++++++++++++++++++++++-----------
 net/batman-adv/types.h |  2 +-
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 0f9ed4d..eee2d82 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -625,15 +625,26 @@ __be32 batadv_skb_crc32(struct sk_buff *skb, u8 *payload_ptr)
 }
 
 /**
- * batadv_tvlv_handler_free_ref - decrement the tvlv handler refcounter and
+ * batadv_tvlv_handler_release - release tvlv handler from lists and queue for
+ *  free after rcu grace period
+ * * @ref: kref pointer of the tvlv
+ */
+static void batadv_tvlv_handler_release(struct kref *ref)
+{
+	struct batadv_tvlv_handler *tvlv_handler;
+
+	tvlv_handler = container_of(ref, struct batadv_tvlv_handler, refcount);
+	kfree_rcu(tvlv_handler, rcu);
+}
+
+/**
+ * batadv_tvlv_handler_put - decrement the tvlv container refcounter and
  *  possibly free it
  * @tvlv_handler: the tvlv handler to free
  */
-static void
-batadv_tvlv_handler_free_ref(struct batadv_tvlv_handler *tvlv_handler)
+static void batadv_tvlv_handler_put(struct batadv_tvlv_handler *tvlv_handler)
 {
-	if (atomic_dec_and_test(&tvlv_handler->refcount))
-		kfree_rcu(tvlv_handler, rcu);
+	kref_put(&tvlv_handler->refcount, batadv_tvlv_handler_release);
 }
 
 /**
@@ -659,7 +670,7 @@ static struct batadv_tvlv_handler
 		if (tvlv_handler_tmp->version != version)
 			continue;
 
-		if (!atomic_inc_not_zero(&tvlv_handler_tmp->refcount))
+		if (!kref_get_unless_zero(&tvlv_handler_tmp->refcount))
 			continue;
 
 		tvlv_handler = tvlv_handler_tmp;
@@ -1015,7 +1026,7 @@ int batadv_tvlv_containers_process(struct batadv_priv *bat_priv,
 						src, dst, tvlv_value,
 						tvlv_value_cont_len);
 		if (tvlv_handler)
-			batadv_tvlv_handler_free_ref(tvlv_handler);
+			batadv_tvlv_handler_put(tvlv_handler);
 		tvlv_value = (u8 *)tvlv_value + tvlv_value_cont_len;
 		tvlv_value_len -= tvlv_value_cont_len;
 	}
@@ -1095,7 +1106,7 @@ void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
 
 	tvlv_handler = batadv_tvlv_handler_get(bat_priv, type, version);
 	if (tvlv_handler) {
-		batadv_tvlv_handler_free_ref(tvlv_handler);
+		batadv_tvlv_handler_put(tvlv_handler);
 		return;
 	}
 
@@ -1108,7 +1119,7 @@ void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
 	tvlv_handler->type = type;
 	tvlv_handler->version = version;
 	tvlv_handler->flags = flags;
-	atomic_set(&tvlv_handler->refcount, 1);
+	kref_init(&tvlv_handler->refcount);
 	INIT_HLIST_NODE(&tvlv_handler->list);
 
 	spin_lock_bh(&bat_priv->tvlv.handler_list_lock);
@@ -1132,11 +1143,11 @@ void batadv_tvlv_handler_unregister(struct batadv_priv *bat_priv,
 	if (!tvlv_handler)
 		return;
 
-	batadv_tvlv_handler_free_ref(tvlv_handler);
+	batadv_tvlv_handler_put(tvlv_handler);
 	spin_lock_bh(&bat_priv->tvlv.handler_list_lock);
 	hlist_del_rcu(&tvlv_handler->list);
 	spin_unlock_bh(&bat_priv->tvlv.handler_list_lock);
-	batadv_tvlv_handler_free_ref(tvlv_handler);
+	batadv_tvlv_handler_put(tvlv_handler);
 }
 
 /**
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 0ebd5a4..60d304b 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1293,7 +1293,7 @@ struct batadv_tvlv_handler {
 	u8 type;
 	u8 version;
 	u8 flags;
-	atomic_t refcount;
+	struct kref refcount;
 	struct rcu_head rcu;
 };
 
-- 
2.6.4


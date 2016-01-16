Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 16 Jan 2016 10:29:49 +0100
Message-Id: <1452936598-28619-11-git-send-email-sven@narfation.org>
In-Reply-To: <1452936598-28619-1-git-send-email-sven@narfation.org>
References: <1452936598-28619-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v6 11/20] batman-adv: Convert
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

 net/batman-adv/main.c  | 24 ++++++++++++++++++------
 net/batman-adv/types.h |  2 +-
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 4b6c258..568c550 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -625,15 +625,27 @@ __be32 batadv_skb_crc32(struct sk_buff *skb, u8 *payload_ptr)
 }
 
 /**
- * batadv_tvlv_handler_free_ref - decrement the tvlv handler refcounter and
- *  possibly free it
+ * batadv_tvlv_handler_release - release tvlv handler from lists and queue for
+ *  free after rcu grace period
+ * @ref: kref pointer of the tvlv
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
+ * batadv_tvlv_handler_free_ref - decrement the tvlv container refcounter and
+ *  possibly release it
  * @tvlv_handler: the tvlv handler to free
  */
 static void
 batadv_tvlv_handler_free_ref(struct batadv_tvlv_handler *tvlv_handler)
 {
-	if (atomic_dec_and_test(&tvlv_handler->refcount))
-		kfree_rcu(tvlv_handler, rcu);
+	kref_put(&tvlv_handler->refcount, batadv_tvlv_handler_release);
 }
 
 /**
@@ -659,7 +671,7 @@ static struct batadv_tvlv_handler
 		if (tvlv_handler_tmp->version != version)
 			continue;
 
-		if (!atomic_inc_not_zero(&tvlv_handler_tmp->refcount))
+		if (!kref_get_unless_zero(&tvlv_handler_tmp->refcount))
 			continue;
 
 		tvlv_handler = tvlv_handler_tmp;
@@ -1112,7 +1124,7 @@ void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
 	tvlv_handler->type = type;
 	tvlv_handler->version = version;
 	tvlv_handler->flags = flags;
-	atomic_set(&tvlv_handler->refcount, 1);
+	kref_init(&tvlv_handler->refcount);
 	INIT_HLIST_NODE(&tvlv_handler->list);
 
 	spin_lock_bh(&bat_priv->tvlv.handler_list_lock);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index c55925b..f89dd97 100644
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
2.7.0.rc3


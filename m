Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Tue, 23 Feb 2016 14:08:15 +0800
Message-Id: <1456207703-903-13-git-send-email-a@unstable.cc>
In-Reply-To: <1456207703-903-1-git-send-email-a@unstable.cc>
References: <1456207703-903-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH 12/20] batman-adv: Rename batadv_tvlv_handler
	*_free_ref function to *_put
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>, Marek Lindner <mareklindner@neomailbox.ch>

From: Sven Eckelmann <sven@narfation.org>

The batman-adv source code is the only place in the kernel which uses the
*_free_ref naming scheme for the *_put functions. Changing it to *_put
makes it more consistent and makes it easier to understand the connection
to the *_get functions.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/main.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 476554b3adce..95aaff371966 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -638,12 +638,11 @@ static void batadv_tvlv_handler_release(struct kref *ref)
 }
 
 /**
- * batadv_tvlv_handler_free_ref - decrement the tvlv container refcounter and
+ * batadv_tvlv_handler_put - decrement the tvlv container refcounter and
  *  possibly release it
  * @tvlv_handler: the tvlv handler to free
  */
-static void
-batadv_tvlv_handler_free_ref(struct batadv_tvlv_handler *tvlv_handler)
+static void batadv_tvlv_handler_put(struct batadv_tvlv_handler *tvlv_handler)
 {
 	kref_put(&tvlv_handler->refcount, batadv_tvlv_handler_release);
 }
@@ -1031,7 +1030,7 @@ int batadv_tvlv_containers_process(struct batadv_priv *bat_priv,
 						src, dst, tvlv_value,
 						tvlv_value_cont_len);
 		if (tvlv_handler)
-			batadv_tvlv_handler_free_ref(tvlv_handler);
+			batadv_tvlv_handler_put(tvlv_handler);
 		tvlv_value = (u8 *)tvlv_value + tvlv_value_cont_len;
 		tvlv_value_len -= tvlv_value_cont_len;
 	}
@@ -1111,7 +1110,7 @@ void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
 
 	tvlv_handler = batadv_tvlv_handler_get(bat_priv, type, version);
 	if (tvlv_handler) {
-		batadv_tvlv_handler_free_ref(tvlv_handler);
+		batadv_tvlv_handler_put(tvlv_handler);
 		return;
 	}
 
@@ -1148,11 +1147,11 @@ void batadv_tvlv_handler_unregister(struct batadv_priv *bat_priv,
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
-- 
2.7.1


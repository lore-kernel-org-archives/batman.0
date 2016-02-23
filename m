Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Tue, 23 Feb 2016 14:08:16 +0800
Message-Id: <1456207703-903-14-git-send-email-a@unstable.cc>
In-Reply-To: <1456207703-903-1-git-send-email-a@unstable.cc>
References: <1456207703-903-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH 13/20] batman-adv: Rename
	batadv_tvlv_container *_free_ref function to *_put
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
 net/batman-adv/main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 95aaff371966..bf8a01b8f026 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -694,11 +694,11 @@ static void batadv_tvlv_container_release(struct kref *ref)
 }
 
 /**
- * batadv_tvlv_container_free_ref - decrement the tvlv container refcounter and
+ * batadv_tvlv_container_put - decrement the tvlv container refcounter and
  *  possibly release it
  * @tvlv: the tvlv container to free
  */
-static void batadv_tvlv_container_free_ref(struct batadv_tvlv_container *tvlv)
+static void batadv_tvlv_container_put(struct batadv_tvlv_container *tvlv)
 {
 	kref_put(&tvlv->refcount, batadv_tvlv_container_release);
 }
@@ -784,8 +784,8 @@ static void batadv_tvlv_container_remove(struct batadv_priv *bat_priv,
 	hlist_del(&tvlv->list);
 
 	/* first call to decrement the counter, second call to free */
-	batadv_tvlv_container_free_ref(tvlv);
-	batadv_tvlv_container_free_ref(tvlv);
+	batadv_tvlv_container_put(tvlv);
+	batadv_tvlv_container_put(tvlv);
 }
 
 /**
-- 
2.7.1


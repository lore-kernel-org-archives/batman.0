Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Tue, 23 Feb 2016 14:08:18 +0800
Message-Id: <1456207703-903-16-git-send-email-a@unstable.cc>
In-Reply-To: <1456207703-903-1-git-send-email-a@unstable.cc>
References: <1456207703-903-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH 15/20] batman-adv: Rename batadv_nc_node
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
 net/batman-adv/network-coding.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 9180ff114a26..6105cfb0574c 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -223,11 +223,11 @@ static void batadv_nc_node_release(struct kref *ref)
 }
 
 /**
- * batadv_nc_node_free_ref - decrement the nc_node refcounter and possibly
+ * batadv_nc_node_put - decrement the nc_node refcounter and possibly
  *  release it
  * @nc_node: nc_node to be free'd
  */
-static void batadv_nc_node_free_ref(struct batadv_nc_node *nc_node)
+static void batadv_nc_node_put(struct batadv_nc_node *nc_node)
 {
 	kref_put(&nc_node->refcount, batadv_nc_node_release);
 }
@@ -356,7 +356,7 @@ batadv_nc_purge_orig_nc_nodes(struct batadv_priv *bat_priv,
 			   "Removing nc_node %pM -> %pM\n",
 			   nc_node->addr, nc_node->orig_node->orig);
 		list_del_rcu(&nc_node->list);
-		batadv_nc_node_free_ref(nc_node);
+		batadv_nc_node_put(nc_node);
 	}
 	spin_unlock_bh(lock);
 }
@@ -942,9 +942,9 @@ void batadv_nc_update_nc_node(struct batadv_priv *bat_priv,
 
 out:
 	if (in_nc_node)
-		batadv_nc_node_free_ref(in_nc_node);
+		batadv_nc_node_put(in_nc_node);
 	if (out_nc_node)
-		batadv_nc_node_free_ref(out_nc_node);
+		batadv_nc_node_put(out_nc_node);
 }
 
 /**
-- 
2.7.1


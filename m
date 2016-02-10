Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Wed, 10 Feb 2016 23:57:15 +0800
Message-Id: <1455119847-5862-10-git-send-email-a@unstable.cc>
In-Reply-To: <1455119847-5862-1-git-send-email-a@unstable.cc>
References: <1455119847-5862-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH 09/21] batman-adv: Convert batadv_nc_node to
	kref
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

batman-adv uses a self-written reference implementation which is just based
on atomic_t. This is less obvious when reading the code than kref and
therefore increases the change that the reference counting will be missed.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/network-coding.c | 21 +++++++++++++--------
 net/batman-adv/types.h          |  2 +-
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 0b30c15eee5f..7a1216eeb4cf 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -32,6 +32,7 @@
 #include <linux/jhash.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
+#include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/lockdep.h>
 #include <linux/netdevice.h>
@@ -209,23 +210,26 @@ void batadv_nc_init_orig(struct batadv_orig_node *orig_node)
 /**
  * batadv_nc_node_release - release nc_node from lists and queue for free after
  *  rcu grace period
- * @nc_node: the nc node to free
+ * @ref: kref pointer of the nc_node
  */
-static void batadv_nc_node_release(struct batadv_nc_node *nc_node)
+static void batadv_nc_node_release(struct kref *ref)
 {
+	struct batadv_nc_node *nc_node;
+
+	nc_node = container_of(ref, struct batadv_nc_node, refcount);
+
 	batadv_orig_node_free_ref(nc_node->orig_node);
 	kfree_rcu(nc_node, rcu);
 }
 
 /**
- * batadv_nc_node_free_ref - decrement the nc node refcounter and possibly
+ * batadv_nc_node_free_ref - decrement the nc_node refcounter and possibly
  *  release it
- * @nc_node: the nc node to free
+ * @nc_node: nc_node to be free'd
  */
 static void batadv_nc_node_free_ref(struct batadv_nc_node *nc_node)
 {
-	if (atomic_dec_and_test(&nc_node->refcount))
-		batadv_nc_node_release(nc_node);
+	kref_put(&nc_node->refcount, batadv_nc_node_release);
 }
 
 /**
@@ -797,7 +801,7 @@ static struct batadv_nc_node
 		if (!batadv_compare_eth(nc_node->addr, orig_node->orig))
 			continue;
 
-		if (!atomic_inc_not_zero(&nc_node->refcount))
+		if (!kref_get_unless_zero(&nc_node->refcount))
 			continue;
 
 		/* Found a match */
@@ -848,7 +852,8 @@ static struct batadv_nc_node
 	INIT_LIST_HEAD(&nc_node->list);
 	ether_addr_copy(nc_node->addr, orig_node->orig);
 	nc_node->orig_node = orig_neigh_node;
-	atomic_set(&nc_node->refcount, 2);
+	kref_init(&nc_node->refcount);
+	kref_get(&nc_node->refcount);
 
 	/* Select ingoing or outgoing coding node */
 	if (in_coding) {
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 34c13b65bec2..05421afb1d74 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1067,7 +1067,7 @@ struct batadv_tt_roam_node {
 struct batadv_nc_node {
 	struct list_head list;
 	u8 addr[ETH_ALEN];
-	atomic_t refcount;
+	struct kref refcount;
 	struct rcu_head rcu;
 	struct batadv_orig_node *orig_node;
 	unsigned long last_seen;
-- 
2.7.1


Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 16 Dec 2015 00:31:44 +0100
Message-Id: <1450222316-1764-11-git-send-email-sven@narfation.org>
In-Reply-To: <1450222316-1764-1-git-send-email-sven@narfation.org>
References: <1450222316-1764-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 11/23] batman-adv: Convert batadv_nc_path to
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
To: b.a.t.m.a.n@lists.open-mesh.org

So switch to kref instead of using the self-made, atomic_t-based
implementation.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/network-coding.c | 38 ++++++++++++++++++++++++++------------
 net/batman-adv/types.h          |  2 +-
 2 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 246cd90..a2655ad 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -233,14 +233,27 @@ static void batadv_nc_node_put(struct batadv_nc_node *nc_node)
 }
 
 /**
- * batadv_nc_path_free_ref - decrements the nc path refcounter and possibly
- * frees it
- * @nc_path: the nc node to free
+ * batadv_nc_path_release - release nc_path from lists and queue for free after
+ *  rcu grace period
+ * * @ref: kref pointer of the nc_path
  */
-static void batadv_nc_path_free_ref(struct batadv_nc_path *nc_path)
+static void batadv_nc_path_release(struct kref *ref)
 {
-	if (atomic_dec_and_test(&nc_path->refcount))
-		kfree_rcu(nc_path, rcu);
+	struct batadv_nc_path *nc_path;
+
+	nc_path = container_of(ref, struct batadv_nc_path, refcount);
+
+	kfree_rcu(nc_path, rcu);
+}
+
+/**
+ * batadv_nc_path_put - decrement the nc_path refcounter and possibly
+ *  release it
+ * @nc_path: nc_path to be free'd
+ */
+static void batadv_nc_path_put(struct batadv_nc_path *nc_path)
+{
+	kref_put(&nc_path->refcount, batadv_nc_path_release);
 }
 
 /**
@@ -250,7 +263,7 @@ static void batadv_nc_path_free_ref(struct batadv_nc_path *nc_path)
 static void batadv_nc_packet_free(struct batadv_nc_packet *nc_packet)
 {
 	kfree_skb(nc_packet->skb);
-	batadv_nc_path_free_ref(nc_packet->nc_path);
+	batadv_nc_path_put(nc_packet->nc_path);
 	kfree(nc_packet);
 }
 
@@ -454,7 +467,7 @@ static void batadv_nc_purge_paths(struct batadv_priv *bat_priv,
 				   "Remove nc_path %pM -> %pM\n",
 				   nc_path->prev_hop, nc_path->next_hop);
 			hlist_del_rcu(&nc_path->hash_entry);
-			batadv_nc_path_free_ref(nc_path);
+			batadv_nc_path_put(nc_path);
 		}
 		spin_unlock_bh(lock);
 	}
@@ -545,7 +558,7 @@ batadv_nc_hash_find(struct batadv_hashtable *hash,
 		if (!batadv_nc_hash_compare(&nc_path->hash_entry, data))
 			continue;
 
-		if (!atomic_inc_not_zero(&nc_path->refcount))
+		if (!kref_get_unless_zero(&nc_path->refcount))
 			continue;
 
 		nc_path_tmp = nc_path;
@@ -972,7 +985,8 @@ static struct batadv_nc_path *batadv_nc_get_path(struct batadv_priv *bat_priv,
 	/* Initialize nc_path */
 	INIT_LIST_HEAD(&nc_path->packet_list);
 	spin_lock_init(&nc_path->packet_list_lock);
-	atomic_set(&nc_path->refcount, 2);
+	kref_init(&nc_path->refcount);
+	kref_get(&nc_path->refcount);
 	nc_path->last_valid = jiffies;
 	ether_addr_copy(nc_path->next_hop, dst);
 	ether_addr_copy(nc_path->prev_hop, src);
@@ -1541,7 +1555,7 @@ bool batadv_nc_skb_forward(struct sk_buff *skb,
 	return true;
 
 free_nc_path:
-	batadv_nc_path_free_ref(nc_path);
+	batadv_nc_path_put(nc_path);
 out:
 	/* Packet is not consumed */
 	return false;
@@ -1603,7 +1617,7 @@ void batadv_nc_skb_store_for_decoding(struct batadv_priv *bat_priv,
 free_skb:
 	kfree_skb(skb);
 free_nc_path:
-	batadv_nc_path_free_ref(nc_path);
+	batadv_nc_path_put(nc_path);
 out:
 	return;
 }
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 9a2371a..49f0270 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1087,7 +1087,7 @@ struct batadv_nc_node {
 struct batadv_nc_path {
 	struct hlist_node hash_entry;
 	struct rcu_head rcu;
-	atomic_t refcount;
+	struct kref refcount;
 	struct list_head packet_list;
 	spinlock_t packet_list_lock; /* Protects packet_list */
 	u8 next_hop[ETH_ALEN];
-- 
2.6.4


Return-Path: <linus.luessing@ascom.ch>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Tue, 15 Feb 2011 18:12:20 +0100
Message-Id: <1297789948-16948-6-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1297789948-16948-1-git-send-email-linus.luessing@ascom.ch>
References: <1297789948-16948-1-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 05/13] batman-adv: Add rcu-refcount wrapper
	for orig_node hash_find()
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>

This structure is being used in several places - removing some
redundancy.

Signed-off-by: Linus Lüssing <linus.luessing@ascom.ch>
---
 hash.h        |   18 +++++++++++++++
 icmp_socket.c |   21 +++++------------
 originator.c  |   11 +-------
 routing.c     |   67 +++++++++++++-------------------------------------------
 send.c        |   20 +++++------------
 unicast.c     |   14 +----------
 6 files changed, 50 insertions(+), 101 deletions(-)

diff --git a/batman-adv/hash.h b/batman-adv/hash.h
index 3c48c6b..2b6a8ae 100644
--- a/batman-adv/hash.h
+++ b/batman-adv/hash.h
@@ -23,6 +23,7 @@
 #define _NET_BATMAN_ADV_HASH_H_
 
 #include <linux/list.h>
+#include "originator.h"
 
 /* callback to a compare function.  should
  * compare 2 element datas for their keys,
@@ -193,4 +194,21 @@ static inline void *hash_find(struct hashtable_t *hash,
 	return bucket_data;
 }
 
+/* increases the orig_node's refcount, if found */
+static inline struct orig_node *hash_find_orig(struct bat_priv *bat_priv,
+					       uint8_t *dest)
+{
+	struct hashtable_t *hash = bat_priv->orig_hash;
+	struct orig_node *orig_node;
+
+	rcu_read_lock();
+
+	orig_node = hash_find(hash, compare_orig, choose_orig, dest);
+	if (orig_node)
+		kref_get(&orig_node->refcount);
+
+	rcu_read_unlock();
+	return orig_node;
+}
+
 #endif /* _NET_BATMAN_ADV_HASH_H_ */
diff --git a/batman-adv/icmp_socket.c b/batman-adv/icmp_socket.c
index 869c9aa..90fb0b7 100644
--- a/batman-adv/icmp_socket.c
+++ b/batman-adv/icmp_socket.c
@@ -218,23 +218,16 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 	if (atomic_read(&bat_priv->mesh_state) != MESH_ACTIVE)
 		goto dst_unreach;
 
-	rcu_read_lock();
-	orig_node = ((struct orig_node *)hash_find(bat_priv->orig_hash,
-						   compare_orig, choose_orig,
-						   icmp_packet->dst));
-
+	orig_node = hash_find_orig(bat_priv, icmp_packet->dst);
 	if (!orig_node)
-		goto unlock;
+		goto dst_unreach;
 
-	kref_get(&orig_node->refcount);
+	rcu_read_lock();
 	neigh_node = orig_node->router;
-
-	if (!neigh_node)
-		goto unlock;
-
-	if (!atomic_inc_not_zero(&neigh_node->refcount)) {
+	if (!neigh_node || !atomic_inc_not_zero(&neigh_node->refcount)) {
 		neigh_node = NULL;
-		goto unlock;
+		rcu_read_unlock();
+		goto dst_unreach;
 	}
 
 	rcu_read_unlock();
@@ -255,8 +248,6 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	goto out;
 
-unlock:
-	rcu_read_unlock();
 dst_unreach:
 	icmp_packet->msg_type = DESTINATION_UNREACHABLE;
 	bat_socket_add_packet(socket_client, icmp_packet, packet_len);
diff --git a/batman-adv/originator.c b/batman-adv/originator.c
index bde9778..af3f338 100644
--- a/batman-adv/originator.c
+++ b/batman-adv/originator.c
@@ -189,16 +189,9 @@ struct orig_node *get_orig_node(struct bat_priv *bat_priv, uint8_t *addr)
 	int size;
 	int hash_added;
 
-	rcu_read_lock();
-	orig_node = ((struct orig_node *)hash_find(bat_priv->orig_hash,
-						   compare_orig, choose_orig,
-						   addr));
-	rcu_read_unlock();
-
-	if (orig_node) {
-		kref_get(&orig_node->refcount);
+	orig_node = hash_find_orig(bat_priv, addr);
+	if (orig_node)
 		return orig_node;
-	}
 
 	bat_dbg(DBG_BATMAN, bat_priv,
 		"Creating new originator: %pM\n", addr);
diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index e53f6f5..081c461 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -897,22 +897,16 @@ static int recv_my_icmp_packet(struct bat_priv *bat_priv,
 
 	/* answer echo request (ping) */
 	/* get routing information */
-	rcu_read_lock();
-	orig_node = ((struct orig_node *)hash_find(bat_priv->orig_hash,
-						   compare_orig, choose_orig,
-						   icmp_packet->orig));
+	orig_node = hash_find_orig(bat_priv, icmp_packet->orig);
 	if (!orig_node)
-		goto unlock;
+		goto out;
 
-	kref_get(&orig_node->refcount);
+	rcu_read_lock();
 	neigh_node = orig_node->router;
-
-	if (!neigh_node)
-		goto unlock;
-
-	if (!atomic_inc_not_zero(&neigh_node->refcount)) {
+	if (!neigh_node || !atomic_inc_not_zero(&neigh_node->refcount)) {
 		neigh_node = NULL;
-		goto unlock;
+		rcu_read_unlock();
+		goto out;
 	}
 
 	rcu_read_unlock();
@@ -933,8 +927,6 @@ static int recv_my_icmp_packet(struct bat_priv *bat_priv,
 	ret = NET_RX_SUCCESS;
 	goto out;
 
-unlock:
-	rcu_read_unlock();
 out:
 	if (neigh_node)
 		neigh_node_free_ref(neigh_node);
@@ -992,22 +984,16 @@ int recv_icmp_packet(struct sk_buff *skb, struct batman_if *recv_if)
 		return recv_my_icmp_packet(bat_priv, skb, hdr_size);
 
 	/* get routing information */
-	rcu_read_lock();
-	orig_node = ((struct orig_node *)
-		     hash_find(bat_priv->orig_hash, compare_orig, choose_orig,
-			       icmp_packet->dst));
+	orig_node = hash_find_orig(bat_priv, icmp_packet->dst);
 	if (!orig_node)
-		goto unlock;
+		goto out;
 
-	kref_get(&orig_node->refcount);
+	rcu_read_lock();
 	neigh_node = orig_node->router;
-
-	if (!neigh_node)
-		goto unlock;
-
-	if (!atomic_inc_not_zero(&neigh_node->refcount)) {
+	if (!neigh_node || !atomic_inc_not_zero(&neigh_node->refcount)) {
 		neigh_node = NULL;
-		goto unlock;
+		rcu_read_unlock();
+		goto out;
 	}
 
 	rcu_read_unlock();
@@ -1023,8 +1009,6 @@ int recv_icmp_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	ret = NET_RX_SUCCESS;
 	goto out;
 
-unlock:
-	rcu_read_unlock();
 out:
 	if (neigh_node)
 		neigh_node_free_ref(neigh_node);
@@ -1214,16 +1198,9 @@ int route_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if,
 	struct sk_buff *new_skb;
 
 	/* get routing information */
-	rcu_read_lock();
-	orig_node = ((struct orig_node *)
-		     hash_find(bat_priv->orig_hash, compare_orig, choose_orig,
-			       dest));
-
+	orig_node = hash_find_orig(bat_priv, dest);
 	if (!orig_node)
-		goto unlock;
-
-	kref_get(&orig_node->refcount);
-	rcu_read_unlock();
+		goto out;
 
 	/* find_router() increases neigh_nodes refcount if found. */
 	neigh_node = find_router(bat_priv, orig_node, recv_if);
@@ -1265,8 +1242,6 @@ int route_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if,
 	ret = NET_RX_SUCCESS;
 	goto out;
 
-unlock:
-	rcu_read_unlock();
 out:
 	if (neigh_node)
 		neigh_node_free_ref(neigh_node);
@@ -1364,16 +1339,9 @@ int recv_bcast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	if (is_my_mac(bcast_packet->orig))
 		goto out;
 
-	rcu_read_lock();
-	orig_node = ((struct orig_node *)
-		     hash_find(bat_priv->orig_hash, compare_orig, choose_orig,
-			       bcast_packet->orig));
-
+	orig_node = hash_find_orig(bat_priv, bcast_packet->orig);
 	if (!orig_node)
-		goto rcu_unlock;
-
-	kref_get(&orig_node->refcount);
-	rcu_read_unlock();
+		goto out;
 
 	spin_lock_bh(&orig_node->bcast_seqno_lock);
 
@@ -1404,9 +1372,6 @@ int recv_bcast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	ret = NET_RX_SUCCESS;
 	goto out;
 
-rcu_unlock:
-	rcu_read_unlock();
-	goto out;
 spin_unlock:
 	spin_unlock_bh(&orig_node->bcast_seqno_lock);
 out:
diff --git a/batman-adv/send.c b/batman-adv/send.c
index f3e8895..df4cd34 100644
--- a/batman-adv/send.c
+++ b/batman-adv/send.c
@@ -76,22 +76,16 @@ static int recv_icmp_ttl_exceeded(struct bat_priv *bat_priv,
 		goto out;
 
 	/* get routing information */
-	rcu_read_lock();
-	orig_node = ((struct orig_node *)
-		     hash_find(bat_priv->orig_hash, compare_orig, choose_orig,
-			       icmp_packet->orig));
+	orig_node = hash_find_orig(bat_priv, icmp_packet->orig);
 	if (!orig_node)
-		goto unlock;
+		goto out;
 
-	kref_get(&orig_node->refcount);
+	rcu_read_lock();
 	neigh_node = orig_node->router;
-
-	if (!neigh_node)
-		goto unlock;
-
-	if (!atomic_inc_not_zero(&neigh_node->refcount)) {
+	if (!neigh_node || !atomic_inc_not_zero(&neigh_node->refcount)) {
 		neigh_node = NULL;
-		goto unlock;
+		rcu_read_unlock();
+		goto out;
 	}
 
 	rcu_read_unlock();
@@ -112,8 +106,6 @@ static int recv_icmp_ttl_exceeded(struct bat_priv *bat_priv,
 	ret = NET_RX_SUCCESS;
 	goto out;
 
-unlock:
-	rcu_read_unlock();
 out:
 	if (neigh_node)
 		neigh_node_free_ref(neigh_node);
diff --git a/batman-adv/unicast.c b/batman-adv/unicast.c
index 4cbc011..4d794cb 100644
--- a/batman-adv/unicast.c
+++ b/batman-adv/unicast.c
@@ -184,15 +184,9 @@ int frag_reassemble_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 
 	*new_skb = NULL;
 
-	rcu_read_lock();
-	orig_node = ((struct orig_node *)
-		    hash_find(bat_priv->orig_hash, compare_orig, choose_orig,
-			      unicast_packet->orig));
+	orig_node = hash_find_orig(bat_priv, unicast_packet->orig);
 	if (!orig_node)
-		goto unlock;
-
-	kref_get(&orig_node->refcount);
-	rcu_read_unlock();
+		goto out;
 
 	orig_node->last_frag_packet = jiffies;
 
@@ -217,10 +211,6 @@ int frag_reassemble_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 	if (*new_skb)
 		ret = NET_RX_SUCCESS;
 
-	goto out;
-
-unlock:
-	rcu_read_unlock();
 out:
 	if (orig_node)
 		kref_put(&orig_node->refcount, orig_node_free_ref);
-- 
1.7.2.3


Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  5 Mar 2011 13:28:30 +0100
Message-Id: <1299328122-21468-17-git-send-email-sven@narfation.org>
In-Reply-To: <1299328122-21468-1-git-send-email-sven@narfation.org>
References: <1299328122-21468-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 16/28] batman-adv: make broadcast seqno
	operations atomic
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Marek Lindner <lindner_marek@yahoo.de>

Batman-adv could receive several payload broadcasts at the same time
that would trigger access to the broadcast seqno sliding window to
determine whether this is a new broadcast or not. If these incoming
broadcasts are accessing the sliding window simultaneously it could
be left in an inconsistent state. Therefore it is necessary to make
sure this access is atomic.

Reported-by: Linus Lüssing <linus.luessing@web.de>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 net/batman-adv/originator.c |    1 +
 net/batman-adv/routing.c    |   56 ++++++++++++++++++++++++++-----------------
 net/batman-adv/types.h      |    2 +
 3 files changed, 37 insertions(+), 22 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 61299da..d9a8e31 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -215,6 +215,7 @@ struct orig_node *get_orig_node(struct bat_priv *bat_priv, uint8_t *addr)
 	INIT_HLIST_HEAD(&orig_node->neigh_list);
 	INIT_LIST_HEAD(&orig_node->bond_list);
 	spin_lock_init(&orig_node->ogm_cnt_lock);
+	spin_lock_init(&orig_node->bcast_seqno_lock);
 	spin_lock_init(&orig_node->neigh_list_lock);
 	kref_init(&orig_node->refcount);
 
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 29a689a..ce68815 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1473,81 +1473,93 @@ int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if)
 int recv_bcast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 {
 	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
-	struct orig_node *orig_node;
+	struct orig_node *orig_node = NULL;
 	struct bcast_packet *bcast_packet;
 	struct ethhdr *ethhdr;
 	int hdr_size = sizeof(struct bcast_packet);
+	int ret = NET_RX_DROP;
 	int32_t seq_diff;
 
 	/* drop packet if it has not necessary minimum size */
 	if (unlikely(!pskb_may_pull(skb, hdr_size)))
-		return NET_RX_DROP;
+		goto out;
 
 	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
 	/* packet with broadcast indication but unicast recipient */
 	if (!is_broadcast_ether_addr(ethhdr->h_dest))
-		return NET_RX_DROP;
+		goto out;
 
 	/* packet with broadcast sender address */
 	if (is_broadcast_ether_addr(ethhdr->h_source))
-		return NET_RX_DROP;
+		goto out;
 
 	/* ignore broadcasts sent by myself */
 	if (is_my_mac(ethhdr->h_source))
-		return NET_RX_DROP;
+		goto out;
 
 	bcast_packet = (struct bcast_packet *)skb->data;
 
 	/* ignore broadcasts originated by myself */
 	if (is_my_mac(bcast_packet->orig))
-		return NET_RX_DROP;
+		goto out;
 
 	if (bcast_packet->ttl < 2)
-		return NET_RX_DROP;
+		goto out;
 
 	spin_lock_bh(&bat_priv->orig_hash_lock);
 	rcu_read_lock();
 	orig_node = ((struct orig_node *)
 		     hash_find(bat_priv->orig_hash, compare_orig, choose_orig,
 			       bcast_packet->orig));
+
+	if (!orig_node)
+		goto rcu_unlock;
+
+	kref_get(&orig_node->refcount);
 	rcu_read_unlock();
 
-	if (!orig_node) {
-		spin_unlock_bh(&bat_priv->orig_hash_lock);
-		return NET_RX_DROP;
-	}
+	spin_lock_bh(&orig_node->bcast_seqno_lock);
 
 	/* check whether the packet is a duplicate */
-	if (get_bit_status(orig_node->bcast_bits,
-			   orig_node->last_bcast_seqno,
-			   ntohl(bcast_packet->seqno))) {
-		spin_unlock_bh(&bat_priv->orig_hash_lock);
-		return NET_RX_DROP;
-	}
+	if (get_bit_status(orig_node->bcast_bits, orig_node->last_bcast_seqno,
+			   ntohl(bcast_packet->seqno)))
+		goto spin_unlock;
 
 	seq_diff = ntohl(bcast_packet->seqno) - orig_node->last_bcast_seqno;
 
 	/* check whether the packet is old and the host just restarted. */
 	if (window_protected(bat_priv, seq_diff,
-			     &orig_node->bcast_seqno_reset)) {
-		spin_unlock_bh(&bat_priv->orig_hash_lock);
-		return NET_RX_DROP;
-	}
+			     &orig_node->bcast_seqno_reset))
+		goto spin_unlock;
 
 	/* mark broadcast in flood history, update window position
 	 * if required. */
 	if (bit_get_packet(bat_priv, orig_node->bcast_bits, seq_diff, 1))
 		orig_node->last_bcast_seqno = ntohl(bcast_packet->seqno);
 
+	spin_unlock_bh(&orig_node->bcast_seqno_lock);
 	spin_unlock_bh(&bat_priv->orig_hash_lock);
+
 	/* rebroadcast packet */
 	add_bcast_packet_to_list(bat_priv, skb);
 
 	/* broadcast for me */
 	interface_rx(recv_if->soft_iface, skb, recv_if, hdr_size);
+	ret = NET_RX_SUCCESS;
+	goto out;
 
-	return NET_RX_SUCCESS;
+rcu_unlock:
+	rcu_read_unlock();
+	spin_unlock_bh(&bat_priv->orig_hash_lock);
+	goto out;
+spin_unlock:
+	spin_unlock_bh(&orig_node->bcast_seqno_lock);
+	spin_unlock_bh(&bat_priv->orig_hash_lock);
+out:
+	if (orig_node)
+		kref_put(&orig_node->refcount, orig_node_free_ref);
+	return ret;
 }
 
 int recv_vis_packet(struct sk_buff *skb, struct batman_if *recv_if)
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 9a14276..e1f3e5e 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -90,6 +90,8 @@ struct orig_node {
 	spinlock_t ogm_cnt_lock; /* protects: bcast_own, bcast_own_sum,
 				  * neigh_node->real_bits,
 				  * neigh_node->real_packet_count */
+	spinlock_t bcast_seqno_lock; /* protects bcast_bits,
+				      *	 last_bcast_seqno */
 	atomic_t bond_candidates;
 	struct list_head bond_list;
 };
-- 
1.7.2.3


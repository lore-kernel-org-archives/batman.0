Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@saxnet.de>
Date: Sat, 22 Jan 2011 02:21:40 +0100
Message-Id: <1295659302-7171-18-git-send-email-linus.luessing@saxnet.de>
In-Reply-To: <1295659302-7171-1-git-send-email-linus.luessing@saxnet.de>
References: <1295659302-7171-1-git-send-email-linus.luessing@saxnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 17/19] batman-adv: Add duplicate checks for
	multicast data
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
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@saxnet.de>

This commit adds duplicate checks to avoid endless rebroadcasts in the
case of forwarding multicast data packets via broadcasting.

Signed-off-by: Linus Lüssing <linus.luessing@saxnet.de>
---
 originator.c |    2 ++
 routing.c    |   57 +++++++++++++++++++++++++++++++++++++++++++++++++++++----
 types.h      |    3 +++
 3 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/batman-adv/originator.c b/batman-adv/originator.c
index 6c964e5..c819189 100644
--- a/batman-adv/originator.c
+++ b/batman-adv/originator.c
@@ -234,6 +234,8 @@ struct orig_node *get_orig_node(struct bat_priv *bat_priv, uint8_t *addr)
 	orig_node->num_mca = 0;
 	orig_node->bcast_seqno_reset = jiffies - 1
 					- msecs_to_jiffies(RESET_PROTECTION_MS);
+	orig_node->mcast_seqno_reset = jiffies - 1
+					- msecs_to_jiffies(RESET_PROTECTION_MS);
 	orig_node->batman_seqno_reset = jiffies - 1
 					- msecs_to_jiffies(RESET_PROTECTION_MS);
 
diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index 512d9ba..8167526 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -1513,20 +1513,61 @@ out:
 int recv_mcast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 {
 	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
+	struct orig_node *orig_node = NULL;
+	struct mcast_packet *mcast_packet;
 	struct ethhdr *ethhdr;
 	MC_LIST *mc_entry;
-	int ret = 1;
+	int32_t seq_diff;
+	int ret = NET_RX_DROP;
 	int hdr_size = sizeof(struct mcast_packet);
 
 	/* multicast data packets might be received via unicast or broadcast */
 	if (check_unicast_packet(skb, hdr_size) < 0 &&
 	    check_broadcast_packet(skb, hdr_size) < 0)
-		return NET_RX_DROP;
+		goto out;
+
+	mcast_packet = (struct mcast_packet *)skb->data;
+
+	/* ignore broadcasts originated by myself */
+	if (is_my_mac(mcast_packet->orig))
+		goto out;
+
+	if (mcast_packet->ttl < 2)
+		goto out;
+
+	rcu_read_lock();
+	orig_node = ((struct orig_node *)
+		     hash_find(bat_priv->orig_hash, compare_orig, choose_orig,
+			       mcast_packet->orig));
+
+	if (!orig_node)
+		goto unlock;
+
+	kref_get(&orig_node->refcount);
+	rcu_read_unlock();
+
+	/* check whether the packet is a duplicate */
+	if (get_bit_status(orig_node->mcast_bits,
+			   orig_node->last_mcast_seqno,
+			   ntohl(mcast_packet->seqno)))
+		goto out;
+
+	seq_diff = ntohl(mcast_packet->seqno) - orig_node->last_mcast_seqno;
+
+	/* check whether the packet is old and the host just restarted. */
+	if (window_protected(bat_priv, seq_diff,
+			     &orig_node->mcast_seqno_reset))
+		goto out;
+
+	/* mark broadcast in flood history, update window position
+	 * if required. */
+	if (bit_get_packet(bat_priv, orig_node->mcast_bits, seq_diff, 1))
+		orig_node->last_mcast_seqno = ntohl(mcast_packet->seqno);
 
 	/* forward multicast packet if necessary */
 	route_mcast_packet(skb, bat_priv);
 
-	ethhdr = (struct ethhdr *)(skb->data + sizeof(struct mcast_packet));
+	ethhdr = (struct ethhdr *)(mcast_packet + 1);
 
 	/* multicast for me? */
 	netif_addr_lock_bh(recv_if->soft_iface);
@@ -1540,7 +1581,15 @@ int recv_mcast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	if (!ret)
 		interface_rx(recv_if->soft_iface, skb, recv_if, hdr_size);
 
-	return NET_RX_SUCCESS;
+	ret = NET_RX_SUCCESS;
+	goto out;
+
+unlock:
+	rcu_read_unlock();
+out:
+	if (orig_node)
+		kref_put(&orig_node->refcount, orig_node_free_ref);
+	return ret;
 }
 
 int recv_mcast_tracker_packet(struct sk_buff *skb, struct batman_if *recv_if)
diff --git a/batman-adv/types.h b/batman-adv/types.h
index 2857fba..d9b0429 100644
--- a/batman-adv/types.h
+++ b/batman-adv/types.h
@@ -74,6 +74,7 @@ struct orig_node {
 	int tq_asym_penalty;
 	unsigned long last_valid;
 	unsigned long bcast_seqno_reset;
+	unsigned long mcast_seqno_reset;
 	unsigned long batman_seqno_reset;
 	uint8_t gw_flags;
 	uint8_t flags;
@@ -84,7 +85,9 @@ struct orig_node {
 	uint32_t last_real_seqno;
 	uint8_t last_ttl;
 	unsigned long bcast_bits[NUM_WORDS];
+	unsigned long mcast_bits[NUM_WORDS];
 	uint32_t last_bcast_seqno;
+	uint32_t last_mcast_seqno;
 	struct hlist_head neigh_list;
 	struct list_head frag_list;
 	spinlock_t neigh_list_lock; /* protects neighbor list */
-- 
1.7.2.3


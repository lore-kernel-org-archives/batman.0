Return-Path: <linus.luessing@ascom.ch>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Wed,  2 Mar 2011 18:18:40 +0100
Message-Id: <1299086321-25116-12-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1299086321-25116-1-git-send-email-linus.luessing@ascom.ch>
References: <1299086321-25116-1-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 11/12] batman-adv: Generic sequence number
	checking for data packets
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

This reduces the size of recv_bcast_packet, increasing its readability.
It further introduces a generic function for duplicate checking for data
packets (which might later be used for multicast or promiscous unicast
packet handling or other packets).

Signed-off-by: Linus Lüssing <linus.luessing@ascom.ch>
---
 originator.c |    2 +-
 routing.c    |   63 ++++++++++++++++++++++++++++++++++-----------------------
 types.h      |   10 ++++++--
 3 files changed, 45 insertions(+), 30 deletions(-)

diff --git a/originator.c b/originator.c
index 53753d3..57cb5c9 100644
--- a/originator.c
+++ b/originator.c
@@ -207,7 +207,7 @@ struct orig_node *get_orig_node(struct bat_priv *bat_priv, uint8_t *addr)
 	memcpy(orig_node->orig, addr, ETH_ALEN);
 	orig_node->router = NULL;
 	orig_node->hna_buff = NULL;
-	orig_node->bcast_seqno_reset = jiffies - 1
+	orig_node->bcast_seqno_state.seqno_reset = jiffies - 1
 					- msecs_to_jiffies(RESET_PROTECTION_MS);
 	orig_node->batman_seqno_reset = jiffies - 1
 					- msecs_to_jiffies(RESET_PROTECTION_MS);
diff --git a/routing.c b/routing.c
index d31a7ad..a2c55fd 100644
--- a/routing.c
+++ b/routing.c
@@ -1293,6 +1293,36 @@ static int check_unicast_packet(struct sk_buff *skb, int hdr_size)
 	return 0;
 }
 
+static inline int check_duplicate(struct bat_priv *bat_priv, uint32_t seqno,
+				  struct seqno_state *seqno_state,
+				  spinlock_t *seqno_lock)
+{
+	int32_t seq_diff;
+	int ret = NET_RX_DROP;
+
+	spin_lock_bh(seqno_lock);
+
+	/* check whether the packet is a duplicate */
+	if (get_bit_status(seqno_state->bits, seqno_state->last_seqno, seqno))
+		goto spin_unlock;
+
+	seq_diff = seqno - seqno_state->last_seqno;
+
+	/* check whether the packet is old and the host just restarted. */
+	if (window_protected(bat_priv, seq_diff, &seqno_state->seqno_reset))
+		goto spin_unlock;
+
+	/* mark broadcast in flood history, update window position
+	 * if required. */
+	if (bit_get_packet(bat_priv, seqno_state->bits, seq_diff, 1))
+		seqno_state->last_seqno = seqno;
+
+	ret = NET_RX_SUCCESS;
+spin_unlock:
+	spin_unlock_bh(seqno_lock);
+	return ret;
+}
+
 int route_unicast_packet(int bonding_mode, struct sk_buff *skb,
 			 struct hard_iface *recv_if,
 			 struct orig_node *orig_node)
@@ -1433,7 +1463,7 @@ int recv_ucast_safe_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 	else
 		set_unicast_safe_options(bat_priv, unicast_packet);
 
-	orig_node = hash_find_orig(bat_priv, unicast_packet->dest);
+	orig_node = orig_hash_find(bat_priv, unicast_packet->dest);
 	return route_unicast_packet(bonding_mode, skb, recv_if, orig_node);
 }
 
@@ -1445,7 +1475,6 @@ int recv_bcast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 	struct ethhdr *ethhdr;
 	int hdr_size = sizeof(struct bcast_packet);
 	int ret = NET_RX_DROP;
-	int32_t seq_diff;
 
 	/* drop packet if it has not necessary minimum size */
 	if (unlikely(!pskb_may_pull(skb, hdr_size)))
@@ -1479,26 +1508,13 @@ int recv_bcast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 
 	rcu_read_unlock();
 
-	spin_lock_bh(&orig_node->bcast_seqno_lock);
-
-	/* check whether the packet is a duplicate */
-	if (get_bit_status(orig_node->bcast_bits, orig_node->last_bcast_seqno,
-			   ntohl(bcast_packet->seqno)))
-		goto spin_unlock;
-
-	seq_diff = ntohl(bcast_packet->seqno) - orig_node->last_bcast_seqno;
-
-	/* check whether the packet is old and the host just restarted. */
-	if (window_protected(bat_priv, seq_diff,
-			     &orig_node->bcast_seqno_reset))
-		goto spin_unlock;
+	ret = check_duplicate(bat_priv, ntohl(bcast_packet->seqno),
+			      &orig_node->bcast_seqno_state,
+			      &orig_node->bcast_seqno_lock);
 
-	/* mark broadcast in flood history, update window position
-	 * if required. */
-	if (bit_get_packet(bat_priv, orig_node->bcast_bits, seq_diff, 1))
-		orig_node->last_bcast_seqno = ntohl(bcast_packet->seqno);
-
-	spin_unlock_bh(&orig_node->bcast_seqno_lock);
+	orig_node_free_ref(orig_node);
+	if (ret == NET_RX_DROP)
+		goto out;
 
 	/* rebroadcast packet */
 	add_bcast_packet_to_list(bat_priv, skb);
@@ -1510,12 +1526,7 @@ int recv_bcast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 
 rcu_unlock:
 	rcu_read_unlock();
-	goto out;
-spin_unlock:
-	spin_unlock_bh(&orig_node->bcast_seqno_lock);
 out:
-	if (orig_node)
-		orig_node_free_ref(orig_node);
 	return ret;
 }
 
diff --git a/types.h b/types.h
index 3f625aa..cceff07 100644
--- a/types.h
+++ b/types.h
@@ -49,6 +49,12 @@ struct hard_iface {
 	struct rcu_head rcu;
 };
 
+struct seqno_state {
+	unsigned long seqno_reset;
+	uint32_t last_seqno;
+	unsigned long bits[NUM_WORDS];
+};
+
 /**
  *	orig_node - structure for orig_list maintaining nodes of mesh
  *	@primary_addr: hosts primary interface address
@@ -71,7 +77,6 @@ struct orig_node {
 	unsigned long *bcast_own;
 	uint8_t *bcast_own_sum;
 	unsigned long last_valid;
-	unsigned long bcast_seqno_reset;
 	unsigned long batman_seqno_reset;
 	uint8_t gw_flags;
 	uint8_t flags;
@@ -79,8 +84,6 @@ struct orig_node {
 	int16_t hna_buff_len;
 	uint32_t last_real_seqno;
 	uint8_t last_ttl;
-	unsigned long bcast_bits[NUM_WORDS];
-	uint32_t last_bcast_seqno;
 	struct hlist_head neigh_list;
 	struct list_head frag_list;
 	spinlock_t neigh_list_lock; /* protects neighbor list */
@@ -89,6 +92,7 @@ struct orig_node {
 	struct hlist_node hash_entry;
 	struct bat_priv *bat_priv;
 	unsigned long last_frag_packet;
+	struct seqno_state bcast_seqno_state;
 	spinlock_t ogm_cnt_lock; /* protects: bcast_own, bcast_own_sum,
 				  * neigh_node->real_bits,
 				  * neigh_node->real_packet_count */
-- 
1.7.2.3


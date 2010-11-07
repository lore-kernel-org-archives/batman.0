Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sun,  7 Nov 2010 17:46:00 +0100
Message-Id: <1289148361-16019-3-git-send-email-linus.luessing@web.de>
In-Reply-To: <1289148361-16019-1-git-send-email-linus.luessing@web.de>
References: <1289148361-16019-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: Generic sequence number
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

From: Linus Lüssing <linus.luessing@ascom.ch>

This reduces the size of recv_bcast_packet, increasing its readability.
It further introduces a generic function for duplicate checking for data
packets (which might later be used for multicast or promiscous unicast
packet handling or other packets).

Signed-off-by: Linus Lüssing <linus.luessing@ascom.ch>
---
 originator.c |    2 +-
 routing.c    |   86 +++++++++++++++++++++++++++++++++++----------------------
 types.h      |   10 +++++--
 3 files changed, 61 insertions(+), 37 deletions(-)

diff --git a/originator.c b/originator.c
index 8930446..e888416 100644
--- a/originator.c
+++ b/originator.c
@@ -147,7 +147,7 @@ struct orig_node *get_orig_node(struct bat_priv *bat_priv, uint8_t *addr)
 	memcpy(orig_node->orig, addr, ETH_ALEN);
 	orig_node->router = NULL;
 	orig_node->hna_buff = NULL;
-	orig_node->bcast_seqno_reset = jiffies - 1
+	orig_node->bcast_seqno_state.seqno_reset = jiffies - 1
 					- msecs_to_jiffies(RESET_PROTECTION_MS);
 	orig_node->batman_seqno_reset = jiffies - 1
 					- msecs_to_jiffies(RESET_PROTECTION_MS);
diff --git a/routing.c b/routing.c
index b61821a..761fd84 100644
--- a/routing.c
+++ b/routing.c
@@ -1129,6 +1129,55 @@ static int check_unicast_packet(struct sk_buff *skb, int hdr_size)
 	return 0;
 }
 
+static inline int check_duplicate(struct bat_priv *bat_priv, uint8_t *orig,
+				  uint32_t seqno, uint8_t packet_type)
+{
+	struct orig_node *orig_node;
+	struct seqno_state *seqno_state;
+	int32_t seq_diff;
+	int ret = 1;
+
+	spin_lock_bh(&bat_priv->orig_hash_lock);
+	orig_node = ((struct orig_node *)
+		     hash_find(bat_priv->orig_hash, compare_orig, choose_orig,
+			       orig));
+
+	switch (packet_type) {
+		case BAT_BCAST:
+			seqno_state = &orig_node->bcast_seqno_state;
+			break;
+		default:
+			goto out;
+	}
+
+	if (orig_node == NULL)
+		goto out;
+
+	/* check whether the packet is a duplicate */
+	if (get_bit_status(seqno_state->bits,
+			   seqno_state->last_seqno,
+			   seqno))
+		goto out;
+
+	seq_diff = seqno - seqno_state->last_seqno;
+
+	/* check whether the packet is old and the host just restarted. */
+	if (window_protected(bat_priv, seq_diff,
+			     &seqno_state->seqno_reset))
+		goto out;
+
+	/* mark broadcast in flood history, update window position
+	 * if required. */
+	if (bit_get_packet(bat_priv, seqno_state->bits, seq_diff, 1))
+		seqno_state->last_seqno = seqno;
+
+	ret = 0;
+
+out:
+	spin_unlock_bh(&bat_priv->orig_hash_lock);
+	return ret;
+}
+
 int route_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if,
 			 int hdr_size)
 {
@@ -1275,11 +1324,10 @@ int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if)
 int recv_bcast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 {
 	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
-	struct orig_node *orig_node;
 	struct bcast_packet *bcast_packet;
 	struct ethhdr *ethhdr;
 	int hdr_size = sizeof(struct bcast_packet);
-	int32_t seq_diff;
+	int ret;
 
 	/* drop packet if it has not necessary minimum size */
 	if (unlikely(!pskb_may_pull(skb, hdr_size)))
@@ -1308,39 +1356,11 @@ int recv_bcast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	if (bcast_packet->ttl < 2)
 		return NET_RX_DROP;
 
-	spin_lock_bh(&bat_priv->orig_hash_lock);
-	orig_node = ((struct orig_node *)
-		     hash_find(bat_priv->orig_hash, compare_orig, choose_orig,
-			       bcast_packet->orig));
-
-	if (orig_node == NULL) {
-		spin_unlock_bh(&bat_priv->orig_hash_lock);
+	ret = check_duplicate(bat_priv, bcast_packet->orig,
+			      ntohl(bcast_packet->seqno), BAT_BCAST);
+	if (ret)
 		return NET_RX_DROP;
-	}
 
-	/* check whether the packet is a duplicate */
-	if (get_bit_status(orig_node->bcast_bits,
-			   orig_node->last_bcast_seqno,
-			   ntohl(bcast_packet->seqno))) {
-		spin_unlock_bh(&bat_priv->orig_hash_lock);
-		return NET_RX_DROP;
-	}
-
-	seq_diff = ntohl(bcast_packet->seqno) - orig_node->last_bcast_seqno;
-
-	/* check whether the packet is old and the host just restarted. */
-	if (window_protected(bat_priv, seq_diff,
-			     &orig_node->bcast_seqno_reset)) {
-		spin_unlock_bh(&bat_priv->orig_hash_lock);
-		return NET_RX_DROP;
-	}
-
-	/* mark broadcast in flood history, update window position
-	 * if required. */
-	if (bit_get_packet(bat_priv, orig_node->bcast_bits, seq_diff, 1))
-		orig_node->last_bcast_seqno = ntohl(bcast_packet->seqno);
-
-	spin_unlock_bh(&bat_priv->orig_hash_lock);
 	/* rebroadcast packet */
 	add_bcast_packet_to_list(bat_priv, skb);
 
diff --git a/types.h b/types.h
index 2678ce1..87eb780 100644
--- a/types.h
+++ b/types.h
@@ -49,6 +49,12 @@ struct batman_if {
 	struct rcu_head rcu;
 };
 
+struct seqno_state {
+	unsigned long seqno_reset;
+	uint32_t last_seqno;
+	TYPE_OF_WORD bits[NUM_WORDS];
+};
+
 /**
  *	orig_node - structure for orig_list maintaining nodes of mesh
  *	@primary_addr: hosts primary interface address
@@ -73,7 +79,6 @@ struct orig_node {
 	uint8_t tq_own;
 	int tq_asym_penalty;
 	unsigned long last_valid;
-	unsigned long bcast_seqno_reset;
 	unsigned long batman_seqno_reset;
 	uint8_t gw_flags;
 	uint8_t flags;
@@ -81,11 +86,10 @@ struct orig_node {
 	int16_t hna_buff_len;
 	uint32_t last_real_seqno;
 	uint8_t last_ttl;
-	TYPE_OF_WORD bcast_bits[NUM_WORDS];
-	uint32_t last_bcast_seqno;
 	struct list_head neigh_list;
 	struct list_head frag_list;
 	unsigned long last_frag_packet;
+	struct seqno_state bcast_seqno_state;
 	struct {
 		uint8_t candidates;
 		struct neigh_node *selected;
-- 
1.7.1


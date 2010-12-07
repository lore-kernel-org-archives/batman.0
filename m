Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@saxnet.de>
Date: Tue,  7 Dec 2010 23:32:27 +0100
Message-Id: <1291761150-29818-17-git-send-email-linus.luessing@saxnet.de>
In-Reply-To: <20101207221351.GA19474@Sellars>
References: <20101207221351.GA19474@Sellars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 17/20] batman-adv: Add duplicate checks for
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
 routing.c    |   48 +++++++++++++++++++++++++++++++++++++++++++++++-
 types.h      |    3 +++
 3 files changed, 52 insertions(+), 1 deletions(-)

diff --git a/originator.c b/originator.c
index 39ce8d5..f882292 100644
--- a/originator.c
+++ b/originator.c
@@ -154,6 +154,8 @@ struct orig_node *get_orig_node(struct bat_priv *bat_priv, uint8_t *addr)
 	orig_node->num_mca = 0;
 	orig_node->bcast_seqno_reset = jiffies - 1
 					- msecs_to_jiffies(RESET_PROTECTION_MS);
+	orig_node->mcast_seqno_reset = jiffies - 1
+					- msecs_to_jiffies(RESET_PROTECTION_MS);
 	orig_node->batman_seqno_reset = jiffies - 1
 					- msecs_to_jiffies(RESET_PROTECTION_MS);
 
diff --git a/routing.c b/routing.c
index f9582be..19f045a 100644
--- a/routing.c
+++ b/routing.c
@@ -1391,8 +1391,11 @@ int recv_bcast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 int recv_mcast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 {
 	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
+	struct orig_node *orig_node;
+	struct mcast_packet *mcast_packet;
 	struct ethhdr *ethhdr;
 	MC_LIST *mc_entry;
+	int32_t seq_diff;
 	unsigned long flags;
 	int ret = 1;
 	int hdr_size = sizeof(struct mcast_packet);
@@ -1402,10 +1405,53 @@ int recv_mcast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	    check_broadcast_packet(skb, hdr_size) < 0)
 		return NET_RX_DROP;
 
+	mcast_packet = (struct mcast_packet *)skb->data;
+
+	/* ignore broadcasts originated by myself */
+	if (is_my_mac(mcast_packet->orig))
+		return NET_RX_DROP;
+
+	if (mcast_packet->ttl < 2)
+		return NET_RX_DROP;
+
+	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
+	orig_node = ((struct orig_node *)
+		     hash_find(bat_priv->orig_hash, compare_orig, choose_orig,
+			       mcast_packet->orig));
+
+	if (orig_node == NULL) {
+		spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+		return NET_RX_DROP;
+	}
+
+	/* check whether the packet is a duplicate */
+	if (get_bit_status(orig_node->mcast_bits,
+			   orig_node->last_mcast_seqno,
+			   ntohl(mcast_packet->seqno))) {
+		spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+		return NET_RX_DROP;
+	}
+
+	seq_diff = ntohl(mcast_packet->seqno) - orig_node->last_mcast_seqno;
+
+	/* check whether the packet is old and the host just restarted. */
+	if (window_protected(bat_priv, seq_diff,
+			     &orig_node->mcast_seqno_reset)) {
+		spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+		return NET_RX_DROP;
+	}
+
+	/* mark broadcast in flood history, update window position
+	 * if required. */
+	if (bit_get_packet(bat_priv, orig_node->mcast_bits, seq_diff, 1))
+		orig_node->last_mcast_seqno = ntohl(mcast_packet->seqno);
+
+	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+
 	/* forward multicast packet if necessary */
 	route_mcast_packet(skb, bat_priv);
 
-	ethhdr = (struct ethhdr *)(skb->data + sizeof(struct mcast_packet));
+	ethhdr = (struct ethhdr *)(mcast_packet + 1);
 
 	/* multicast for me? */
 	MC_LIST_LOCK(recv_if->soft_iface, flags);
diff --git a/types.h b/types.h
index c12fd2c..890822f 100644
--- a/types.h
+++ b/types.h
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
 	TYPE_OF_WORD bcast_bits[NUM_WORDS];
+	TYPE_OF_WORD mcast_bits[NUM_WORDS];
 	uint32_t last_bcast_seqno;
+	uint32_t last_mcast_seqno;
 	struct list_head neigh_list;
 	struct list_head frag_list;
 	unsigned long last_frag_packet;
-- 
1.7.1


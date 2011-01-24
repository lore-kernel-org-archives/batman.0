Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 24 Jan 2011 15:12:01 +0100
Message-Id: <1295878321-17159-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: make broadcast seqno operations
	atomic
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Batman-adv could receive several payload broadcasts at the same time
that would trigger access to the broadcast seqno sliding window to
determine whether this is a new broadcast or not. If these incoming
broadcasts are accessing the sliding window simultaneously it could
be left in an inconsistent state. Therefore it is necessary to make
sure this access is atomic.

Reported-by: Linus Lüssing <linus.luessing@web.de>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 batman-adv/originator.c |    1 +
 batman-adv/routing.c    |   15 +++++++++++----
 batman-adv/types.h      |    2 ++
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/batman-adv/originator.c b/batman-adv/originator.c
index cf2ec37..b1a3d92 100644
--- a/batman-adv/originator.c
+++ b/batman-adv/originator.c
@@ -220,6 +220,7 @@ struct orig_node *get_orig_node(struct bat_priv *bat_priv, uint8_t *addr)
 	INIT_HLIST_HEAD(&orig_node->neigh_list);
 	INIT_LIST_HEAD(&orig_node->bond_list);
 	spin_lock_init(&orig_node->ogm_cnt_lock);
+	spin_lock_init(&orig_node->bcast_seqno_lock);
 	spin_lock_init(&orig_node->neigh_list_lock);
 	kref_init(&orig_node->refcount);
 
diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index 06201dc..2cf595d 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -1427,28 +1427,32 @@ int recv_bcast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 			       bcast_packet->orig));
 
 	if (!orig_node)
-		goto unlock;
+		goto rcu_unlock;
 
 	kref_get(&orig_node->refcount);
 	rcu_read_unlock();
 
+	spin_lock_bh(&orig_node->bcast_seqno_lock);
+
 	/* check whether the packet is a duplicate */
 	if (get_bit_status(orig_node->bcast_bits, orig_node->last_bcast_seqno,
 			   ntohl(bcast_packet->seqno)))
-		goto out;
+		goto spin_unlock;
 
 	seq_diff = ntohl(bcast_packet->seqno) - orig_node->last_bcast_seqno;
 
 	/* check whether the packet is old and the host just restarted. */
 	if (window_protected(bat_priv, seq_diff,
 			     &orig_node->bcast_seqno_reset))
-		goto out;
+		goto spin_unlock;
 
 	/* mark broadcast in flood history, update window position
 	 * if required. */
 	if (bit_get_packet(bat_priv, orig_node->bcast_bits, seq_diff, 1))
 		orig_node->last_bcast_seqno = ntohl(bcast_packet->seqno);
 
+	spin_unlock_bh(&orig_node->bcast_seqno_lock);
+
 	/* rebroadcast packet */
 	add_bcast_packet_to_list(bat_priv, skb);
 
@@ -1457,8 +1461,11 @@ int recv_bcast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	ret = NET_RX_SUCCESS;
 	goto out;
 
-unlock:
+rcu_unlock:
 	rcu_read_unlock();
+	goto out;
+spin_unlock:
+	spin_unlock_bh(&orig_node->bcast_seqno_lock);
 out:
 	if (orig_node)
 		kref_put(&orig_node->refcount, orig_node_free_ref);
diff --git a/batman-adv/types.h b/batman-adv/types.h
index 56309bf..b7b9561 100644
--- a/batman-adv/types.h
+++ b/batman-adv/types.h
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


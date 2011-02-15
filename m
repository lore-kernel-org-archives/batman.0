Return-Path: <linus.luessing@ascom.ch>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Tue, 15 Feb 2011 18:12:28 +0100
Message-Id: <1297789948-16948-14-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1297789948-16948-1-git-send-email-linus.luessing@ascom.ch>
References: <1297789948-16948-1-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 13/13] batman-adv: Add sequence number and
	duplicate checks for unicasts_safe
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

With the new redundant bonding mode a node might receive a unicast_safe
packet more than once. Therefore duplicate checks on any unicast_safe
packet need to be performed before further processing.

Signed-off-by: Linus Lüssing <linus.luessing@ascom.ch>
---
 originator.c |    3 +++
 routing.c    |   14 +++++++++++++-
 types.h      |    2 ++
 3 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/batman-adv/originator.c b/batman-adv/originator.c
index 4845421..7dc090c 100644
--- a/batman-adv/originator.c
+++ b/batman-adv/originator.c
@@ -204,6 +204,7 @@ struct orig_node *get_orig_node(struct bat_priv *bat_priv, uint8_t *addr)
 	INIT_LIST_HEAD(&orig_node->bond_list);
 	spin_lock_init(&orig_node->ogm_cnt_lock);
 	spin_lock_init(&orig_node->bcast_seqno_lock);
+	spin_lock_init(&orig_node->ucast_safe_seqno_lock);
 	spin_lock_init(&orig_node->neigh_list_lock);
 	kref_init(&orig_node->refcount);
 
@@ -213,6 +214,8 @@ struct orig_node *get_orig_node(struct bat_priv *bat_priv, uint8_t *addr)
 	orig_node->hna_buff = NULL;
 	orig_node->bcast_seqno_state.seqno_reset = jiffies - 1
 					- msecs_to_jiffies(RESET_PROTECTION_MS);
+	orig_node->ucast_safe_seqno_state.seqno_reset = jiffies - 1
+					- msecs_to_jiffies(RESET_PROTECTION_MS);
 	orig_node->batman_seqno_reset = jiffies - 1
 					- msecs_to_jiffies(RESET_PROTECTION_MS);
 
diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index afbeef8..f92e5d3 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -1439,13 +1439,25 @@ int recv_ucast_safe_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	struct unicast_packet_safe *unicast_packet;
 	struct orig_node *orig_node;
 	int hdr_size = sizeof(struct unicast_packet);
-	int bonding_mode;
+	int ret, bonding_mode;
 
 	if (check_unicast_packet(skb, hdr_size) < 0)
 		return NET_RX_DROP;
 
 	unicast_packet = (struct unicast_packet_safe *)skb->data;
 
+	orig_node = hash_find_orig(bat_priv, unicast_packet->orig);
+	if (!orig_node)
+		return NET_RX_DROP;
+
+	ret = check_duplicate(bat_priv, ntohl(unicast_packet->seqno),
+			      &orig_node->ucast_safe_seqno_state,
+			      &orig_node->ucast_safe_seqno_lock);
+
+	kref_put(&orig_node->refcount, orig_node_free_ref);
+	if (ret == NET_RX_DROP)
+		return NET_RX_DROP;
+
 	/* packet for me */
 	if (is_my_mac(unicast_packet->dest)) {
 		unicast_safe_to_unicast(skb);
diff --git a/batman-adv/types.h b/batman-adv/types.h
index 5a2035a..d0ab22f 100644
--- a/batman-adv/types.h
+++ b/batman-adv/types.h
@@ -91,11 +91,13 @@ struct orig_node {
 	struct bat_priv *bat_priv;
 	unsigned long last_frag_packet;
 	struct seqno_state bcast_seqno_state;
+	struct seqno_state ucast_safe_seqno_state;
 	spinlock_t ogm_cnt_lock; /* protects: bcast_own, bcast_own_sum,
 				  * neigh_node->real_bits,
 				  * neigh_node->real_packet_count */
 	spinlock_t bcast_seqno_lock; /* protects bcast_bits,
 				      *	 last_bcast_seqno */
+	spinlock_t ucast_safe_seqno_lock; /* protects ucast_safe_seqno_state */
 	atomic_t bond_candidates;
 	struct list_head bond_list;
 };
-- 
1.7.2.3


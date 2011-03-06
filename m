Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sun,  6 Mar 2011 03:19:14 +0100
Message-Id: <1299377954-8690-2-git-send-email-linus.luessing@web.de>
In-Reply-To: <1299377954-8690-1-git-send-email-linus.luessing@web.de>
References: <1299377954-8690-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Protect global TQ value and
	window with a spinlock
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

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 originator.c |    1 +
 routing.c    |    4 ++++
 types.h      |    1 +
 3 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/originator.c b/originator.c
index 31c6b5a..8db9c33 100644
--- a/originator.c
+++ b/originator.c
@@ -87,6 +87,7 @@ struct neigh_node *create_neighbor(struct orig_node *orig_node,
 
 	INIT_HLIST_NODE(&neigh_node->list);
 	INIT_LIST_HEAD(&neigh_node->bonding_list);
+	spin_lock_init(&neigh_node->tq_lock);
 
 	memcpy(neigh_node->addr, neigh, ETH_ALEN);
 	neigh_node->orig_node = orig_neigh_node;
diff --git a/routing.c b/routing.c
index db4f72c..0f13857 100644
--- a/routing.c
+++ b/routing.c
@@ -408,10 +408,12 @@ static void update_orig(struct bat_priv *bat_priv,
 		if (is_duplicate)
 			continue;
 
+		spin_lock_bh(&tmp_neigh_node->tq_lock);
 		ring_buffer_set(tmp_neigh_node->tq_recv,
 				&tmp_neigh_node->tq_index, 0);
 		tmp_neigh_node->tq_avg =
 			ring_buffer_avg(tmp_neigh_node->tq_recv);
+		spin_unlock_bh(&tmp_neigh_node->tq_lock);
 	}
 
 	if (!neigh_node) {
@@ -436,10 +438,12 @@ static void update_orig(struct bat_priv *bat_priv,
 	orig_node->flags = batman_packet->flags;
 	neigh_node->last_valid = jiffies;
 
+	spin_lock_bh(&neigh_node->tq_lock);
 	ring_buffer_set(neigh_node->tq_recv,
 			&neigh_node->tq_index,
 			batman_packet->tq);
 	neigh_node->tq_avg = ring_buffer_avg(neigh_node->tq_recv);
+	spin_unlock_bh(&neigh_node->tq_lock);
 
 	if (!is_duplicate) {
 		orig_node->last_ttl = batman_packet->ttl;
diff --git a/types.h b/types.h
index 1854cbb..e4a0bcf 100644
--- a/types.h
+++ b/types.h
@@ -125,6 +125,7 @@ struct neigh_node {
 	struct rcu_head rcu;
 	struct orig_node *orig_node;
 	struct hard_iface *if_incoming;
+	spinlock_t tq_lock;	/* protects: tq_recv, tq_index, tq_avg */
 };
 
 
-- 
1.7.4.1


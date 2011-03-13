Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sun, 13 Mar 2011 20:52:25 +0100
Message-Id: <1300045945-28734-6-git-send-email-linus.luessing@web.de>
In-Reply-To: <1300045945-28734-1-git-send-email-linus.luessing@web.de>
References: <1300045945-28734-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 5/5] batman-adv: Protect global TQ window
	with a spinlock
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

diff --git a/batman-adv/originator.c b/batman-adv/originator.c
index 4989bbb..4905619 100644
--- a/batman-adv/originator.c
+++ b/batman-adv/originator.c
@@ -102,6 +102,7 @@ struct neigh_node *create_neighbor(struct orig_node *orig_node,
 
 	INIT_HLIST_NODE(&neigh_node->list);
 	INIT_LIST_HEAD(&neigh_node->bonding_list);
+	spin_lock_init(&neigh_node->tq_lock);
 
 	memcpy(neigh_node->addr, neigh, ETH_ALEN);
 	neigh_node->orig_node = orig_neigh_node;
diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index 9780a62..cd578d4 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
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
diff --git a/batman-adv/types.h b/batman-adv/types.h
index 1854cbb..091476d 100644
--- a/batman-adv/types.h
+++ b/batman-adv/types.h
@@ -125,6 +125,7 @@ struct neigh_node {
 	struct rcu_head rcu;
 	struct orig_node *orig_node;
 	struct hard_iface *if_incoming;
+	spinlock_t tq_lock;	/* protects: tq_recv, tq_index */
 };
 
 
-- 
1.7.4.1


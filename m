Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Fri, 15 Apr 2011 20:16:56 +0200
Message-Id: <1302891416-31451-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: orig_hash_find() manages
	rcu_lock/unlock internally
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
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

orig_hash_find() manages rcu_lock/unlock internally and doesn't need to
be surrounded by rcu_read_lock() / rcu_read_unlock() anymore

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 routing.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/routing.c b/routing.c
index f6c6422..634a44d 100644
--- a/routing.c
+++ b/routing.c
@@ -1310,14 +1310,11 @@ int route_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 	}
 
 	/* get routing information */
-	rcu_read_lock();
 	orig_node = orig_hash_find(bat_priv, unicast_packet->dest);
 
 	if (!orig_node)
 		goto unlock;
 
-	rcu_read_unlock();
-
 	/* find_router() increases neigh_nodes refcount if found. */
 	neigh_node = find_router(bat_priv, orig_node, recv_if);
 
@@ -1464,14 +1461,11 @@ int recv_bcast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 	if (bcast_packet->ttl < 2)
 		goto out;
 
-	rcu_read_lock();
 	orig_node = orig_hash_find(bat_priv, bcast_packet->orig);
 
 	if (!orig_node)
 		goto rcu_unlock;
 
-	rcu_read_unlock();
-
 	spin_lock_bh(&orig_node->bcast_seqno_lock);
 
 	/* check whether the packet is a duplicate */
-- 
1.7.3.4


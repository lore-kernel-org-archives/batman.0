Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 16 Apr 2011 11:30:57 +0200
Message-Id: <1302946257-25173-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1302891416-31451-1-git-send-email-ordex@autistici.org>
References: <1302891416-31451-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv3] batman-adv: orig_hash_find() manages
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
 routing.c |   16 ++--------------
 1 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/routing.c b/routing.c
index f6c6422..2d77bd3 100644
--- a/routing.c
+++ b/routing.c
@@ -1310,13 +1310,10 @@ int route_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 	}
 
 	/* get routing information */
-	rcu_read_lock();
 	orig_node = orig_hash_find(bat_priv, unicast_packet->dest);
 
 	if (!orig_node)
-		goto unlock;
-
-	rcu_read_unlock();
+		goto out;
 
 	/* find_router() increases neigh_nodes refcount if found. */
 	neigh_node = find_router(bat_priv, orig_node, recv_if);
@@ -1362,10 +1359,7 @@ int route_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 	/* route it */
 	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	ret = NET_RX_SUCCESS;
-	goto out;
 
-unlock:
-	rcu_read_unlock();
 out:
 	if (neigh_node)
 		neigh_node_free_ref(neigh_node);
@@ -1464,13 +1458,10 @@ int recv_bcast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 	if (bcast_packet->ttl < 2)
 		goto out;
 
-	rcu_read_lock();
 	orig_node = orig_hash_find(bat_priv, bcast_packet->orig);
 
 	if (!orig_node)
-		goto rcu_unlock;
-
-	rcu_read_unlock();
+		goto out;
 
 	spin_lock_bh(&orig_node->bcast_seqno_lock);
 
@@ -1501,9 +1492,6 @@ int recv_bcast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 	ret = NET_RX_SUCCESS;
 	goto out;
 
-rcu_unlock:
-	rcu_read_unlock();
-	goto out;
 spin_unlock:
 	spin_unlock_bh(&orig_node->bcast_seqno_lock);
 out:
-- 
1.7.3.4


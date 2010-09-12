Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun, 12 Sep 2010 23:00:42 +0200
Message-Id: <1284325242-29661-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <201009122244.00861.sven.eckelmann@gmx.de>
References: <201009122244.00861.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Unlock on failure during
	fragmentation rx
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

When we detect a failure in create_frag_buffer we must drop the packet
and unlock the orig_has which was locked before.
69d187ffb8e22024a87d8457e5dcb10e297108e9 forgot that and created a
potential deadlock of the complete system.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 routing.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/routing.c b/routing.c
index 23a12cd..a07e0e0 100644
--- a/routing.c
+++ b/routing.c
@@ -1233,9 +1233,11 @@ int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if)
 
 		orig_node->last_frag_packet = jiffies;
 
-		if (list_empty(&orig_node->frag_list)) {
-			if (create_frag_buffer(&orig_node->frag_list))
-				return NET_RX_DROP;
+		if (list_empty(&orig_node->frag_list) &&
+			create_frag_buffer(&orig_node->frag_list)) {
+			spin_unlock_irqrestore(&bat_priv->orig_hash_lock,
+					       flags);
+			return NET_RX_DROP;
 		}
 
 		tmp_frag_entry =
-- 
1.7.2.3


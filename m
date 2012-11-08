Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu,  8 Nov 2012 21:55:30 +0100
Message-Id: <1352408130-22971-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1352408130-22971-1-git-send-email-ordex@autistici.org>
References: <1352408130-22971-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH maint 2/2] batman-adv: process broadcast
	packets in BLA earlier
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

The logic in the BLA mechanism may decide to drop broadcast packets
because the node may still be in the setup phase. For this reason,
further broadcast processing like the early client detection mechanism
must be done only after the BLA check.

This patches moves the invocation to BLA before any other broadcast
processing.

This was introduced by 724d05c8215e4e8186097121595ef20b6ba601b7
("batman-adv: detect not yet announced clients")

Reported-by: Glen Page <glen.page@thet.net>
Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 soft-interface.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/soft-interface.c b/soft-interface.c
index b9a28d2..ce0684a 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -325,6 +325,12 @@ void batadv_interface_rx(struct net_device *soft_iface,
 
 	soft_iface->last_rx = jiffies;
 
+	/* Let the bridge loop avoidance check the packet. If will
+	 * not handle it, we can safely push it up.
+	 */
+	if (batadv_bla_rx(bat_priv, skb, vid, is_bcast))
+		goto out;
+
 	if (orig_node)
 		batadv_tt_add_temporary_global_entry(bat_priv, orig_node,
 						     ethhdr->h_source);
@@ -332,12 +338,6 @@ void batadv_interface_rx(struct net_device *soft_iface,
 	if (batadv_is_ap_isolated(bat_priv, ethhdr->h_source, ethhdr->h_dest))
 		goto dropped;
 
-	/* Let the bridge loop avoidance check the packet. If will
-	 * not handle it, we can safely push it up.
-	 */
-	if (batadv_bla_rx(bat_priv, skb, vid, is_bcast))
-		goto out;
-
 	netif_rx(skb);
 	goto out;
 
-- 
1.8.0


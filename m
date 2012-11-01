Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu,  1 Nov 2012 01:08:46 +0100
Message-Id: <1351728526-7311-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: remove useless assignment
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

Introduced by ("batman-adv: Fix broadcast duplist for fragmentation")

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 routing.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/routing.c b/routing.c
index 5da7724..d5a01d1 100644
--- a/routing.c
+++ b/routing.c
@@ -1185,8 +1185,6 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 	if (batadv_bla_check_bcast_duplist(bat_priv, skb))
 		goto out;
 
-	bcast_packet = (struct batadv_bcast_packet *)skb->data;
-
 	/* rebroadcast packet */
 	batadv_add_bcast_packet_to_list(bat_priv, skb, 1);
 
-- 
1.7.12.4


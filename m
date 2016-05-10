Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Wed, 11 May 2016 03:29:50 +0800
Message-Id: <1462908605-27412-3-git-send-email-a@unstable.cc>
In-Reply-To: <1462908605-27412-1-git-send-email-a@unstable.cc>
References: <1462908605-27412-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH 02/17] batman-adv: Remove hdr_size skb size
	check in batadv_interface_rx
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>, Marek Lindner <mareklindner@neomailbox.ch>

From: Sven Eckelmann <sven@narfation.org>

The callers of batadv_interface_rx have to make sure that enough data can
be pulled from the skb when they read the batman-adv header. The only two
functions using it are either calling pskb_may_pull with hdr_size directly
(batadv_recv_bcast_packet) or indirectly via batadv_check_unicast_packet
(batadv_recv_unicast_packet).

Reported-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/soft-interface.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index dc9a61a5122d..d72f88707736 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -413,10 +413,6 @@ void batadv_interface_rx(struct net_device *soft_iface,
 	batadv_bcast_packet = (struct batadv_bcast_packet *)skb->data;
 	is_bcast = (batadv_bcast_packet->packet_type == BATADV_BCAST);
 
-	/* check if enough space is available for pulling, and pull */
-	if (!pskb_may_pull(skb, hdr_size))
-		goto dropped;
-
 	skb_pull_rcsum(skb, hdr_size);
 	skb_reset_mac_header(skb);
 
-- 
2.8.2


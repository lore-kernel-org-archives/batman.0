Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 28 Feb 2016 11:38:52 +0100
Message-Id: <1456655932-22746-3-git-send-email-sven@narfation.org>
In-Reply-To: <3805562.RtX9XxSZnx@sven-edge>
References: <3805562.RtX9XxSZnx@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: Remove hdr_size skb size
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
To: b.a.t.m.a.n@lists.open-mesh.org

The callers of batadv_interface_rx have to make sure that enough data can
be pulled from the skb when they read the batman-adv header. The only two
functions using it are either calling pskb_may_pull with hdr_size directly
(batadv_recv_bcast_packet) or indirectly via batadv_check_unicast_packet
(batadv_recv_unicast_packet).

Reported-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/soft-interface.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index bdda984..f24dc59 100644
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
2.7.0


Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri,  8 Jul 2016 11:49:22 +0200
Message-Id: <1467971362-3607-8-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1467971362-3607-1-git-send-email-sw@simonwunderlich.de>
References: <1467971362-3607-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 7/7] batman-adv: Fix speedy join in gateway
	client mode
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>

From: Sven Eckelmann <sven@narfation.org>

Speedy join only works when the received packet is either broadcast or an
4addr unicast packet. Thus packets converted from broadcast to unicast via
the gateway handling code have to be converted to 4addr packets to allow
the receiving gateway server to add the sender address as temporary entry
to the translation table.

Not doing it will make the batman-adv gateway server drop the DHCP response
in many situations because it doesn't yet have the TT entry for the
destination of the DHCP response.

Fixes: 371351731e9c ("batman-adv: change interface_rx to get orig node")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Acked-by: Antonio Quartulli <a@unstable.cc>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/send.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index f2f1256..0103976 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -424,8 +424,8 @@ int batadv_send_skb_via_gw(struct batadv_priv *bat_priv, struct sk_buff *skb,
 	struct batadv_orig_node *orig_node;
 
 	orig_node = batadv_gw_get_selected_orig(bat_priv);
-	return batadv_send_skb_unicast(bat_priv, skb, BATADV_UNICAST, 0,
-				       orig_node, vid);
+	return batadv_send_skb_unicast(bat_priv, skb, BATADV_UNICAST_4ADDR,
+				       BATADV_P_DATA, orig_node, vid);
 }
 
 void batadv_schedule_bat_ogm(struct batadv_hard_iface *hard_iface)
-- 
2.8.1


Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 12 Jun 2016 10:43:19 +0200
Message-Id: <1465721000-9174-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Fix speedy join in gateway
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
To: b.a.t.m.a.n@lists.open-mesh.org

Speedy join only works when the received packet is either broadcast or an
4addr unicast packet. Thus packets converted from broadcast to unicast via
the gateway handling code have to be converted to 4addr packets to allow
the receiving gateway server to add the sender address as temporary entry
to the translation table.

Not doing it will make the batman-adv gateway server drop the DHCP response
in many situations because it doesn't yet have the TT entry for the
destination of the DHCP response.

Fixes: 9cbc67d9da47 ("batman-adv: change interface_rx to get orig node")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/send.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 49836da..0e9445b 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -426,8 +426,8 @@ int batadv_send_skb_via_gw(struct batadv_priv *bat_priv, struct sk_buff *skb,
 	struct batadv_orig_node *orig_node;
 
 	orig_node = batadv_gw_get_selected_orig(bat_priv);
-	return batadv_send_skb_unicast(bat_priv, skb, BATADV_UNICAST, 0,
-				       orig_node, vid);
+	return batadv_send_skb_unicast(bat_priv, skb, BATADV_UNICAST_4ADDR,
+				       BATADV_P_DATA, orig_node, vid);
 }
 
 void batadv_forw_packet_free(struct batadv_forw_packet *forw_packet)
-- 
2.8.1


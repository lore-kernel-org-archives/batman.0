Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed,  7 Nov 2012 20:11:42 +0100
Message-Id: <1352315502-20324-13-git-send-email-ordex@autistici.org>
In-Reply-To: <1352315502-20324-1-git-send-email-ordex@autistici.org>
References: <1352315502-20324-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 12/12] batman-adv: enable fast client
	detection using unicast_4addr packets
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

The "early client detection mechanism" can be extended to find new clients by
means of unicast_4addr packets.

The unicast_4addr packet contains as well as the broadcast packet (which is
currently used in this mechanism) the address of the originating node and can
therefore be used to install new entries in the Global Translation Table

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 net/batman-adv/routing.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 3f21c09..32aa4d4 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -986,6 +986,8 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 	struct batadv_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	struct batadv_unicast_packet *unicast_packet;
 	struct batadv_unicast_4addr_packet *unicast_4addr_packet;
+	uint8_t *orig_addr;
+	struct batadv_orig_node *orig_node = NULL;
 	int hdr_size = sizeof(*unicast_packet);
 	bool is4addr;
 
@@ -1005,9 +1007,12 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 
 	/* packet for me */
 	if (batadv_is_my_mac(unicast_packet->dest)) {
-		if (is4addr)
+		if (is4addr) {
 			batadv_dat_inc_counter(bat_priv,
 					       unicast_4addr_packet->subtype);
+			orig_addr = unicast_4addr_packet->src;
+			orig_node = batadv_orig_hash_find(bat_priv, orig_addr);
+		}
 
 		if (batadv_dat_snoop_incoming_arp_request(bat_priv, skb,
 							  hdr_size))
@@ -1017,9 +1022,12 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 			goto rx_success;
 
 		batadv_interface_rx(recv_if->soft_iface, skb, recv_if, hdr_size,
-				    NULL);
+				    orig_node);
 
 rx_success:
+		if (orig_node)
+			batadv_orig_node_free_ref(orig_node);
+
 		return NET_RX_SUCCESS;
 	}
 
-- 
1.8.0


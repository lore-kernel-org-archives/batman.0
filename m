Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu,  6 Apr 2017 16:07:32 +0200
Message-Id: <20170406140741.30745-11-sw@simonwunderlich.de>
In-Reply-To: <20170406140741.30745-1-sw@simonwunderlich.de>
References: <20170406140741.30745-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 10/19] batman-adv: drop unicast packets from
	other backbone gw
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Andreas Pape <APape@phoenixcontact.com>

Additional dropping of unicast packets received from another backbone gw if
the same backbone network before being forwarded to the same backbone again
is necessary. It was observed in a test setup that in rare cases these
frames lead to looping unicast traffic backbone->mesh->backbone.

Signed-off-by: Andreas Pape <apape@phoenixcontact.com>
Acked-by: Simon Wunderlich <sw@simonwunderlich.de>
[sven@narfation.org: fix conflicts with current version]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/routing.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 7fd740b6e36d..c85dc3102519 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -941,15 +941,17 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 	struct batadv_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	struct batadv_unicast_packet *unicast_packet;
 	struct batadv_unicast_4addr_packet *unicast_4addr_packet;
-	u8 *orig_addr;
-	struct batadv_orig_node *orig_node = NULL;
+	u8 *orig_addr, *orig_addr_gw;
+	struct batadv_orig_node *orig_node = NULL, *orig_node_gw = NULL;
 	int check, hdr_size = sizeof(*unicast_packet);
 	enum batadv_subtype subtype;
-	bool is4addr;
+	struct ethhdr *ethhdr;
 	int ret = NET_RX_DROP;
+	bool is4addr, is_gw;
 
 	unicast_packet = (struct batadv_unicast_packet *)skb->data;
 	unicast_4addr_packet = (struct batadv_unicast_4addr_packet *)skb->data;
+	ethhdr = eth_hdr(skb);
 
 	is4addr = unicast_packet->packet_type == BATADV_UNICAST_4ADDR;
 	/* the caller function should have already pulled 2 bytes */
@@ -972,6 +974,23 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 
 	/* packet for me */
 	if (batadv_is_my_mac(bat_priv, unicast_packet->dest)) {
+		/* If this is a unicast packet from another backgone gw,
+		 * drop it.
+		 */
+		orig_addr_gw = ethhdr->h_source;
+		orig_node_gw = batadv_orig_hash_find(bat_priv, orig_addr_gw);
+		if (orig_node_gw) {
+			is_gw = batadv_bla_is_backbone_gw(skb, orig_node_gw,
+							  hdr_size);
+			batadv_orig_node_put(orig_node_gw);
+			if (is_gw) {
+				batadv_dbg(BATADV_DBG_BLA, bat_priv,
+					   "Dropped unicast pkt received from another backbone gw %pM.\n",
+					   orig_addr_gw);
+				return NET_RX_DROP;
+			}
+		}
+
 		if (is4addr) {
 			subtype = unicast_4addr_packet->subtype;
 			batadv_dat_inc_counter(bat_priv, subtype);
-- 
2.11.0


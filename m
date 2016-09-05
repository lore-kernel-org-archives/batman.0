Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon,  5 Sep 2016 13:20:27 +0200
Message-Id: <20160905112029.32533-3-sven@narfation.org>
In-Reply-To: <20160905112029.32533-1-sven@narfation.org>
References: <20160905112029.32533-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v7 3/5] batman-adv: drop unicast packets from
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
To: b.a.t.m.a.n@lists.open-mesh.org

From: Andreas Pape <APape@phoenixcontact.com>

Additional dropping of unicast packets received from another backbone gw of
the same backbone network before being forwarded to the same backbone again
is necessary. It was observed in a test setup that in rare cases these
frames lead to looping unicast traffic backbone->mesh->backbone.

Signed-off-by: Andreas Pape <apape@phoenixcontact.com>
Acked-by: Simon Wunderlich <sw@simonwunderlich.de>
[sven@narfation.org: fix conflicts with current version]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/routing.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 7e8dc64..03631ee 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -918,14 +918,16 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
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
+	bool is4addr, is_gw;
+	struct ethhdr *ethhdr;
 
 	unicast_packet = (struct batadv_unicast_packet *)skb->data;
 	unicast_4addr_packet = (struct batadv_unicast_4addr_packet *)skb->data;
+	ethhdr = eth_hdr(skb);
 
 	is4addr = unicast_packet->packet_type == BATADV_UNICAST_4ADDR;
 	/* the caller function should have already pulled 2 bytes */
@@ -948,6 +950,23 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 
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
2.9.3


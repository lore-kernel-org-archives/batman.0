Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue,  9 Oct 2012 15:04:47 +0200
Message-Id: <1349787887-26501-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: enable fast client detection
	using unicast_4addr packets
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

The "early client detection mechanism" introduced with ("batman-adv: detect not
yet announced clients") can be extended to find new clients by means of
unicast_4addr packets.

The unicast_4addr packet contains as well as the broadcast packet (which is
currently used in this mechanism) the address of the originating node and can
therefore be used to install new entries in the Global Translation Table

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

**
this patch is based on top of:

batman-adv: fix DAT packet counting
**

 routing.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/routing.c b/routing.c
index 75615cc..5df765a 100644
--- a/routing.c
+++ b/routing.c
@@ -1042,6 +1042,8 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 	struct batadv_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	struct batadv_unicast_packet *unicast_packet;
 	struct batadv_unicast_4addr_packet *unicast_4addr_packet;
+	uint8_t *orig_addr;
+	struct batadv_orig_node *orig_node = NULL;
 	int hdr_size = sizeof(*unicast_packet);
 	bool is4addr;
 
@@ -1061,9 +1063,12 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 
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
@@ -1073,7 +1078,7 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 			goto rx_success;
 
 		batadv_interface_rx(recv_if->soft_iface, skb, recv_if, hdr_size,
-				    NULL);
+				    orig_node);
 
 rx_success:
 		return NET_RX_SUCCESS;
-- 
1.7.12


Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 19 Mar 2018 17:37:26 +0100
Message-Id: <20180319163726.10921-6-sw@simonwunderlich.de>
In-Reply-To: <20180319163726.10921-1-sw@simonwunderlich.de>
References: <20180319163726.10921-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 5/5] batman-adv: Fix skbuff rcsum on packet
 reroute
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

batadv_check_unicast_ttvn may redirect a packet to itself or another
originator. This involves rewriting the ttvn and the destination address in
the batadv unicast header. These field were not yet pulled (with skb rcsum
update) and thus any change to them also requires a change in the receive
checksum.

Reported-by: Matthias Schiffer <mschiffer@universe-factory.net>
Fixes: a73105b8d4c7 ("batman-adv: improved client announcement mechanism")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/routing.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 6a9242658c8d..e61dc1293bb5 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -759,6 +759,7 @@ static int batadv_route_unicast_packet(struct sk_buff *skb,
 /**
  * batadv_reroute_unicast_packet() - update the unicast header for re-routing
  * @bat_priv: the bat priv with all the soft interface information
+ * @skb: unicast packet to process
  * @unicast_packet: the unicast header to be updated
  * @dst_addr: the payload destination
  * @vid: VLAN identifier
@@ -770,7 +771,7 @@ static int batadv_route_unicast_packet(struct sk_buff *skb,
  * Return: true if the packet header has been updated, false otherwise
  */
 static bool
-batadv_reroute_unicast_packet(struct batadv_priv *bat_priv,
+batadv_reroute_unicast_packet(struct batadv_priv *bat_priv, struct sk_buff *skb,
 			      struct batadv_unicast_packet *unicast_packet,
 			      u8 *dst_addr, unsigned short vid)
 {
@@ -799,8 +800,10 @@ batadv_reroute_unicast_packet(struct batadv_priv *bat_priv,
 	}
 
 	/* update the packet header */
+	skb_postpull_rcsum(skb, unicast_packet, sizeof(*unicast_packet));
 	ether_addr_copy(unicast_packet->dest, orig_addr);
 	unicast_packet->ttvn = orig_ttvn;
+	skb_postpush_rcsum(skb, unicast_packet, sizeof(*unicast_packet));
 
 	ret = true;
 out:
@@ -841,7 +844,7 @@ static bool batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 	 * the packet to
 	 */
 	if (batadv_tt_local_client_is_roaming(bat_priv, ethhdr->h_dest, vid)) {
-		if (batadv_reroute_unicast_packet(bat_priv, unicast_packet,
+		if (batadv_reroute_unicast_packet(bat_priv, skb, unicast_packet,
 						  ethhdr->h_dest, vid))
 			batadv_dbg_ratelimited(BATADV_DBG_TT,
 					       bat_priv,
@@ -887,7 +890,7 @@ static bool batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 	 * destination can possibly be updated and forwarded towards the new
 	 * target host
 	 */
-	if (batadv_reroute_unicast_packet(bat_priv, unicast_packet,
+	if (batadv_reroute_unicast_packet(bat_priv, skb, unicast_packet,
 					  ethhdr->h_dest, vid)) {
 		batadv_dbg_ratelimited(BATADV_DBG_TT, bat_priv,
 				       "Rerouting unicast packet to %pM (dst=%pM): TTVN mismatch old_ttvn=%u new_ttvn=%u\n",
@@ -910,12 +913,14 @@ static bool batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 	if (!primary_if)
 		return false;
 
+	/* update the packet header */
+	skb_postpull_rcsum(skb, unicast_packet, sizeof(*unicast_packet));
 	ether_addr_copy(unicast_packet->dest, primary_if->net_dev->dev_addr);
+	unicast_packet->ttvn = curr_ttvn;
+	skb_postpush_rcsum(skb, unicast_packet, sizeof(*unicast_packet));
 
 	batadv_hardif_put(primary_if);
 
-	unicast_packet->ttvn = curr_ttvn;
-
 	return true;
 }
 
-- 
2.11.0


Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 18 Mar 2018 13:12:01 +0100
Message-Id: <20180318121201.29052-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix skbuff rcsum on packet
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
To: b.a.t.m.a.n@lists.open-mesh.org

batadv_check_unicast_ttvn may redirect a packet to itself or another
originator. This involves rewriting the ttvn and the destination address in
the batadv unicast header. These field were not yet pulled (with skb rcsum
update) and thus any change to them also requires a change in the receive
checksum.

Reported-by: Matthias Schiffer <mschiffer@universe-factory.net>
Fixes: cea194d90b11 ("batman-adv: improved client announcement mechanism")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Cc: Matthias Schiffer <mschiffer@universe-factory.net>

This is an alternative fix for the problem reported by Matthias and his
patch https://patchwork.open-mesh.org/patch/17305/. I've prepared it
because I don't feel good about fixing one thing and at the same time add
regression to another thing (even when it is only the debug output for arp
packets) - at least not when this patch should end up at
stable@vger.kernel.org

This patch was not actually tested. But it should help to see a different
approach. Other code in the kernel which does something similar is:

* seg6_do_srh_inline
* set_eth_addr (openvswitch)
* set_nsh (openvswitch)

I would still like to merge the cleanup patches from Matthias - just not
for net.git/stable@vger.kernel.org. Maybe Simon can decide about the maint
patch - at least he will be the one who forwards them to DaveM.

Btw. in theory, only ttl+ttvn+dest have to be read to update the checksum
correctly - but this patch also reads packet_type+version to keep the
change simple.
---
 compat-include/linux/skbuff.h    | 12 ++++++++++++
 compat-sources/net/core/skbuff.c | 17 -----------------
 net/batman-adv/routing.c         | 15 ++++++++++-----
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/compat-include/linux/skbuff.h b/compat-include/linux/skbuff.h
index 1983dbeb..6f739464 100644
--- a/compat-include/linux/skbuff.h
+++ b/compat-include/linux/skbuff.h
@@ -77,6 +77,18 @@ struct sk_buff *skb_checksum_trimmed(struct sk_buff *skb,
 
 #endif /* < KERNEL_VERSION(4, 2, 0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 5, 0)
+
+static inline void skb_postpush_rcsum(struct sk_buff *skb,
+				      const void *start, unsigned int len)
+{
+	if (skb->ip_summed == CHECKSUM_COMPLETE)
+		skb->csum = csum_block_add(skb->csum,
+					   csum_partial(start, len, 0), 0);
+}
+
+#endif /* < KERNEL_VERSION(4, 5, 0) */
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4, 13, 0)
 
 static inline void *batadv_skb_put(struct sk_buff *skb, unsigned int len)
diff --git a/compat-sources/net/core/skbuff.c b/compat-sources/net/core/skbuff.c
index 3827f5c7..30fbfbfb 100644
--- a/compat-sources/net/core/skbuff.c
+++ b/compat-sources/net/core/skbuff.c
@@ -93,23 +93,6 @@ skb_checksum_validate(struct sk_buff *skb, int proto,
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4, 2, 0)
 
-static inline void skb_postpush_rcsum(struct sk_buff *skb,
-				      const void *start, unsigned int len)
-{
-	/* For performing the reverse operation to skb_postpull_rcsum(),
-	 * we can instead of ...
-	 *
-	 *   skb->csum = csum_add(skb->csum, csum_partial(start, len, 0));
-	 *
-	 * ... just use this equivalent version here to save a few
-	 * instructions. Feeding csum of 0 in csum_partial() and later
-	 * on adding skb->csum is equivalent to feed skb->csum in the
-	 * first place.
-	 */
-	if (skb->ip_summed == CHECKSUM_COMPLETE)
-		skb->csum = csum_partial(start, len, skb->csum);
-}
-
 /**
  *	skb_push_rcsum - push skb and update receive checksum
  *	@skb: buffer to update
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 0f10c565..cc3ed93a 100644
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
2.16.2


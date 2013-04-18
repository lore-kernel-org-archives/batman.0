Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Thu, 18 Apr 2013 12:14:59 +0200
Message-Id: <1366280099-6372-1-git-send-email-martin@hundeboll.net>
In-Reply-To: <1366279893-5607-1-git-send-email-martin@hundeboll.net>
References: <1366279893-5607-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv3] batman-adv: Move call to
	batadv_nc_skb_forward() from routing.c to send.c
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
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>

The call to batadv_nc_skb_forward() fits better in
batadv_send_skb_to_orig(), as this is where the actual next hop is
looked up.

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
---

v2: I should make random defines lowercase :)
v3: Do git add before committing and sending patches :|

 network-coding.c | 5 ++---
 network-coding.h | 6 ++----
 routing.c        | 9 +++------
 send.c           | 9 +++++++--
 4 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/network-coding.c b/network-coding.c
index c93df9e..dc94b76 100644
--- a/network-coding.c
+++ b/network-coding.c
@@ -1359,18 +1359,17 @@ static bool batadv_nc_skb_add_to_path(struct sk_buff *skb,
  *  buffer
  * @skb: data skb to forward
  * @neigh_node: next hop to forward packet to
- * @ethhdr: pointer to the ethernet header inside the skb
  *
  * Returns true if the skb was consumed (encoded packet sent) or false otherwise
  */
 bool batadv_nc_skb_forward(struct sk_buff *skb,
-			   struct batadv_neigh_node *neigh_node,
-			   struct ethhdr *ethhdr)
+			   struct batadv_neigh_node *neigh_node)
 {
 	const struct net_device *netdev = neigh_node->if_incoming->soft_iface;
 	struct batadv_priv *bat_priv = netdev_priv(netdev);
 	struct batadv_unicast_packet *packet;
 	struct batadv_nc_path *nc_path;
+	struct ethhdr *ethhdr = eth_hdr(skb);
 	__be32 packet_id;
 	u8 *payload;
 
diff --git a/network-coding.h b/network-coding.h
index 4fa6d0c..85a4ec8 100644
--- a/network-coding.h
+++ b/network-coding.h
@@ -36,8 +36,7 @@ void batadv_nc_purge_orig(struct batadv_priv *bat_priv,
 void batadv_nc_init_bat_priv(struct batadv_priv *bat_priv);
 void batadv_nc_init_orig(struct batadv_orig_node *orig_node);
 bool batadv_nc_skb_forward(struct sk_buff *skb,
-			   struct batadv_neigh_node *neigh_node,
-			   struct ethhdr *ethhdr);
+			   struct batadv_neigh_node *neigh_node);
 void batadv_nc_skb_store_for_decoding(struct batadv_priv *bat_priv,
 				      struct sk_buff *skb);
 void batadv_nc_skb_store_sniffed_unicast(struct batadv_priv *bat_priv,
@@ -87,8 +86,7 @@ static inline void batadv_nc_init_orig(struct batadv_orig_node *orig_node)
 }
 
 static inline bool batadv_nc_skb_forward(struct sk_buff *skb,
-					 struct batadv_neigh_node *neigh_node,
-					 struct ethhdr *ethhdr)
+					 struct batadv_neigh_node *neigh_node)
 {
 	return false;
 }
diff --git a/routing.c b/routing.c
index 0e10720..19cf8b6 100644
--- a/routing.c
+++ b/routing.c
@@ -835,16 +835,13 @@ static int batadv_route_unicast_packet(struct sk_buff *skb,
 	/* decrement ttl */
 	unicast_packet->header.ttl--;
 
-	/* network code packet if possible */
-	if (batadv_nc_skb_forward(skb, neigh_node, ethhdr)) {
-		ret = NET_RX_SUCCESS;
-	} else if (batadv_send_skb_to_orig(skb, orig_node, recv_if)) {
-		ret = NET_RX_SUCCESS;
-
+	if (batadv_send_skb_to_orig(skb, orig_node, recv_if)) {
 		/* Update stats counter */
 		batadv_inc_counter(bat_priv, BATADV_CNT_FORWARD);
 		batadv_add_counter(bat_priv, BATADV_CNT_FORWARD_BYTES,
 				   skb->len + ETH_HLEN);
+
+		ret = NET_RX_SUCCESS;
 	}
 
 out:
diff --git a/send.c b/send.c
index ed7072a..fa8077a 100644
--- a/send.c
+++ b/send.c
@@ -110,8 +110,13 @@ bool batadv_send_skb_to_orig(struct sk_buff *skb,
 	if (!neigh_node)
 		return false;
 
-	/* route it */
-	batadv_send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
+	/* try to network code the packet, if it is received on an interface
+	 * (i.e. being forwarded). If the packet originates from this node or if
+	 * network coding fails, then send the packet as usual.
+	 */
+	if (!recv_if || !batadv_nc_skb_forward(skb, neigh_node))
+		batadv_send_skb_packet(skb, neigh_node->if_incoming, 
+				       neigh_node->addr);
 
 	batadv_neigh_node_free_ref(neigh_node);
 
-- 
1.8.2.1


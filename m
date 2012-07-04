Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed,  4 Jul 2012 15:59:34 +0200
Message-Id: <1341410374-11389-1-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <CAHD-aqKo=uzeu6_oc4BXj2WRWObMADyWCHp0sNFn8cJDX8sdjA@mail.gmail.com>
References: <CAHD-aqKo=uzeu6_oc4BXj2WRWObMADyWCHp0sNFn8cJDX8sdjA@mail.gmail.com>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: check incoming packet type for
	bla
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

If the gateway functionality is used, some broadcast packets (DHCP
requests) may be transmitted as unicast packets. As the bridge loop
avoidance code now only considers the payload Ethernet destination,
it may drop the DHCP request for clients which are claimed by other
backbone gateways, because it falsely infers from the broadcast address
that the right backbone gateway should havehandled the broadcast.

Fix this by checking and delegating the batman-adv packet type used
for transmission.

Reported-by: Guido Iribarren <guidoiribarren@buenosaireslibre.org>
Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 bridge_loop_avoidance.c |    6 ++++--
 bridge_loop_avoidance.h |    5 +++--
 soft-interface.c        |    6 +++++-
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 6452e2f..8478083 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -1368,6 +1368,7 @@ void batadv_bla_free(struct batadv_priv *bat_priv)
 /* @bat_priv: the bat priv with all the soft interface information
  * @skb: the frame to be checked
  * @vid: the VLAN ID of the frame
+ * @is_bcast: the packet came in a broadcast packet type
  *
  * bla_rx avoidance checks if:
  *  * we have to race for a claim
@@ -1377,7 +1378,8 @@ void batadv_bla_free(struct batadv_priv *bat_priv)
  * returns 1, otherwise it returns 0 and the caller shall further
  * process the skb.
  */
-int batadv_bla_rx(struct batadv_priv *bat_priv, struct sk_buff *skb, short vid)
+int batadv_bla_rx(struct batadv_priv *bat_priv, struct sk_buff *skb, short vid,
+		  bool is_bcast)
 {
 	struct ethhdr *ethhdr;
 	struct batadv_claim search_claim, *claim = NULL;
@@ -1422,7 +1424,7 @@ int batadv_bla_rx(struct batadv_priv *bat_priv, struct sk_buff *skb, short vid)
 	}
 
 	/* if it is a broadcast ... */
-	if (is_multicast_ether_addr(ethhdr->h_dest)) {
+	if (is_multicast_ether_addr(ethhdr->h_dest) && is_bcast) {
 		/* ... drop it. the responsible gateway is in charge. */
 		goto handled;
 	} else {
diff --git a/bridge_loop_avoidance.h b/bridge_loop_avoidance.h
index 35d39e3..789cb73 100644
--- a/bridge_loop_avoidance.h
+++ b/bridge_loop_avoidance.h
@@ -21,7 +21,8 @@
 #define _NET_BATMAN_ADV_BLA_H_
 
 #ifdef CONFIG_BATMAN_ADV_BLA
-int batadv_bla_rx(struct batadv_priv *bat_priv, struct sk_buff *skb, short vid);
+int batadv_bla_rx(struct batadv_priv *bat_priv, struct sk_buff *skb, short vid,
+		  bool is_bcast);
 int batadv_bla_tx(struct batadv_priv *bat_priv, struct sk_buff *skb, short vid);
 int batadv_bla_is_backbone_gw(struct sk_buff *skb,
 			      struct batadv_orig_node *orig_node, int hdr_size);
@@ -42,7 +43,7 @@ void batadv_bla_free(struct batadv_priv *bat_priv);
 #else /* ifdef CONFIG_BATMAN_ADV_BLA */
 
 static inline int batadv_bla_rx(struct batadv_priv *bat_priv,
-				struct sk_buff *skb, short vid)
+				struct sk_buff *skb, short vid, bool is_bcast)
 {
 	return 0;
 }
diff --git a/soft-interface.c b/soft-interface.c
index 96736ea..be39f89 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -274,9 +274,13 @@ void batadv_interface_rx(struct net_device *soft_iface,
 	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
 	struct ethhdr *ethhdr;
 	struct vlan_ethhdr *vhdr;
+	struct batadv_header *batadv_header = (struct batadv_header *)skb->data;
 	short vid __maybe_unused = -1;
+	bool is_bcast;
 	__be16 ethertype = __constant_htons(BATADV_ETH_P_BATMAN);
 
+	is_bcast = !!(batadv_header->packet_type == BATADV_BCAST);
+
 	/* check if enough space is available for pulling, and pull */
 	if (!pskb_may_pull(skb, hdr_size))
 		goto dropped;
@@ -323,7 +327,7 @@ void batadv_interface_rx(struct net_device *soft_iface,
 	/* Let the bridge loop avoidance check the packet. If will
 	 * not handle it, we can safely push it up.
 	 */
-	if (batadv_bla_rx(bat_priv, skb, vid))
+	if (batadv_bla_rx(bat_priv, skb, vid, is_bcast))
 		goto out;
 
 	netif_rx(skb);
-- 
1.7.10


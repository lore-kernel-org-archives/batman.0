Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 4/5] batman-adv: Drop repeated words in comments
Date: Mon, 24 Aug 2020 18:27:40 +0200
Message-Id: <20200824162741.880-5-sw@simonwunderlich.de>
In-Reply-To: <20200824162741.880-1-sw@simonwunderlich.de>
References: <20200824162741.880-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

checkpatch found various instances of "Possible repeated word" in various
comments.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bridge_loop_avoidance.c | 2 +-
 net/batman-adv/fragmentation.c         | 2 +-
 net/batman-adv/hard-interface.c        | 2 +-
 net/batman-adv/multicast.c             | 2 +-
 net/batman-adv/network-coding.c        | 2 +-
 net/batman-adv/send.c                  | 2 +-
 net/batman-adv/soft-interface.c        | 4 ++--
 7 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 91a04ca373dc..5c41cc52bc53 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1795,7 +1795,7 @@ batadv_bla_loopdetect_check(struct batadv_priv *bat_priv, struct sk_buff *skb,
 
 	ret = queue_work(batadv_event_workqueue, &backbone_gw->report_work);
 
-	/* backbone_gw is unreferenced in the report work function function
+	/* backbone_gw is unreferenced in the report work function
 	 * if queue_work() call was successful
 	 */
 	if (!ret)
diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 9fdbe3068153..9a47ef8b95c4 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -306,7 +306,7 @@ batadv_frag_merge_packets(struct hlist_head *chain)
  * set *skb to merged packet; 2) Packet is buffered: Return true and set *skb
  * to NULL; 3) Error: Return false and free skb.
  *
- * Return: true when the packet is merged or buffered, false when skb is not not
+ * Return: true when the packet is merged or buffered, false when skb is not
  * used.
  */
 bool batadv_frag_skb_buffer(struct sk_buff **skb,
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index f95be90adaab..dad99641df2a 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -599,7 +599,7 @@ int batadv_hardif_min_mtu(struct net_device *soft_iface)
 	/* report to the other components the maximum amount of bytes that
 	 * batman-adv can send over the wire (without considering the payload
 	 * overhead). For example, this value is used by TT to compute the
-	 * maximum local table table size
+	 * maximum local table size
 	 */
 	atomic_set(&bat_priv->packet_size_max, min_mtu);
 
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index bdc4a1fba1c6..1622c3f5898f 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -207,7 +207,7 @@ static u8 batadv_mcast_mla_rtr_flags_bridge_get(struct batadv_priv *bat_priv,
 		return BATADV_MCAST_WANT_NO_RTR4 | BATADV_MCAST_WANT_NO_RTR6;
 
 	/* TODO: ask the bridge if a multicast router is present (the bridge
-	 * is capable of performing proper RFC4286 multicast multicast router
+	 * is capable of performing proper RFC4286 multicast router
 	 * discovery) instead of searching for a ff02::2 listener here
 	 */
 	ret = br_multicast_list_adjacent(dev, &bridge_mcast_list);
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 48d707850f3e..64619b7a3a77 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -250,7 +250,7 @@ static void batadv_nc_path_put(struct batadv_nc_path *nc_path)
 /**
  * batadv_nc_packet_free() - frees nc packet
  * @nc_packet: the nc packet to free
- * @dropped: whether the packet is freed because is is dropped
+ * @dropped: whether the packet is freed because is dropped
  */
 static void batadv_nc_packet_free(struct batadv_nc_packet *nc_packet,
 				  bool dropped)
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index d267b94800d6..87017332b567 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -461,7 +461,7 @@ int batadv_send_skb_via_gw(struct batadv_priv *bat_priv, struct sk_buff *skb,
 /**
  * batadv_forw_packet_free() - free a forwarding packet
  * @forw_packet: The packet to free
- * @dropped: whether the packet is freed because is is dropped
+ * @dropped: whether the packet is freed because is dropped
  *
  * This frees a forwarding packet and releases any resources it might
  * have claimed.
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 23833a0ba5e6..9d3974ba11ed 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -649,7 +649,7 @@ static void batadv_softif_destroy_vlan(struct batadv_priv *bat_priv,
 /**
  * batadv_interface_add_vid() - ndo_add_vid API implementation
  * @dev: the netdev of the mesh interface
- * @proto: protocol of the the vlan id
+ * @proto: protocol of the vlan id
  * @vid: identifier of the new vlan
  *
  * Set up all the internal structures for handling the new vlan on top of the
@@ -707,7 +707,7 @@ static int batadv_interface_add_vid(struct net_device *dev, __be16 proto,
 /**
  * batadv_interface_kill_vid() - ndo_kill_vid API implementation
  * @dev: the netdev of the mesh interface
- * @proto: protocol of the the vlan id
+ * @proto: protocol of the vlan id
  * @vid: identifier of the deleted vlan
  *
  * Destroy all the internal structures used to handle the vlan identified by vid
-- 
2.20.1


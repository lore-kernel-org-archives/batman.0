Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Sun,  5 Feb 2017 07:45:49 +0100
Message-Id: <20170205064550.30262-4-linus.luessing@c0d3.blue>
In-Reply-To: <20170205064550.30262-1-linus.luessing@c0d3.blue>
References: <20170205064550.30262-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH v4 3/4] batman-adv: Introduce packet type
	independent TVLV handler API
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

Instead of having one TVLV registration function for OGMs and one for
unicast packets, this patch adds a new, generic tvlv handler
registratiorn function, which simply uses a packet type as parameter.

For now, this patch only migrates the multicast and gateway tvlv
handlers to this new API, as these two have been tested and verified
to work by the author.

The benefits of this new API:

* A more unified TVLV handling
* Easier to add TVLV capabilities to any new, upcoming packet type
* Does not rely on linearized skb data

Further ToDos (for later patches):

* Insert handler hooks for unicast_tvlv packets too and
  migrate BATADV_TVLV_{DAT,NC,TT,ROAM} to new API after
  further testing.
* Remove old TVLV handler API

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>

---

Changes in v4:
* remove unnecessary bug.h include (not needed anymore
  since the removal of the wrappers in v3)

Changes in v3:
* remove unnecessary skb_reset_network_header() call
  shortly before kfree_skb() batadv_iv_ogm_receive()
* remove tvlv (un)pack_ctx wrappers
(thanks Sven!)

Changes in v2:
* add includes for linux/{bug,printk}.h
* update forward declaration to "struct sk_buff;" in tvlv.h
* kerneldoc:
  - change a "@tvlv_type" to "@packet_type",
  - fixed batadv_tvlv_ogm_unpack_ctx() parameter kerneldoc
(thanks Sven!)
---
 net/batman-adv/bat_iv_ogm.c            |   6 +-
 net/batman-adv/bat_v_ogm.c             |  17 +-
 net/batman-adv/distributed-arp-table.c |   4 +-
 net/batman-adv/gateway_common.c        |  44 +++--
 net/batman-adv/multicast.c             |  37 +++--
 net/batman-adv/network-coding.c        |   4 +-
 net/batman-adv/tvlv.c                  | 295 ++++++++++++++++++++++++++++++---
 net/batman-adv/tvlv.h                  |  22 ++-
 net/batman-adv/types.h                 |  24 ++-
 9 files changed, 373 insertions(+), 80 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 7c3d994..c79699d 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1491,7 +1491,7 @@ batadv_iv_ogm_process_per_outif(const struct sk_buff *skb, int ogm_offset,
 	}
 
 	if (if_outgoing == BATADV_IF_DEFAULT)
-		batadv_tvlv_ogm_receive(bat_priv, ogm_packet, orig_node);
+		batadv_tvlv_ogm_receive(bat_priv, skb, orig_node);
 
 	/* if sender is a direct neighbor the sender mac equals
 	 * originator mac
@@ -1836,6 +1836,8 @@ static int batadv_iv_ogm_receive(struct sk_buff *skb,
 	ogm_offset = 0;
 	ogm_packet = (struct batadv_ogm_packet *)skb->data;
 
+	WARN_ON(skb_network_offset(skb) != 0);
+
 	/* unpack the aggregated packets and process them one by one */
 	while (batadv_iv_ogm_aggr_packet(ogm_offset, skb_headlen(skb),
 					 ogm_packet->tvlv_len)) {
@@ -1846,6 +1848,8 @@ static int batadv_iv_ogm_receive(struct sk_buff *skb,
 
 		packet_pos = skb->data + ogm_offset;
 		ogm_packet = (struct batadv_ogm_packet *)packet_pos;
+
+		skb_set_network_header(skb, ogm_offset);
 	}
 
 	ret = NET_RX_SUCCESS;
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 03a35c9..cfc9228 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -594,7 +594,7 @@ out:
 /**
  * batadv_v_ogm_process_per_outif - process a batman v OGM for an outgoing if
  * @bat_priv: the bat priv with all the soft interface information
- * @ethhdr: the Ethernet header of the OGM2
+ * @skb: the skb containing the OGM2
  * @ogm2: OGM2 structure
  * @orig_node: Originator structure for which the OGM has been received
  * @neigh_node: the neigh_node through with the OGM has been received
@@ -603,13 +603,15 @@ out:
  */
 static void
 batadv_v_ogm_process_per_outif(struct batadv_priv *bat_priv,
-			       const struct ethhdr *ethhdr,
+			       const struct sk_buff *skb,
 			       const struct batadv_ogm2_packet *ogm2,
 			       struct batadv_orig_node *orig_node,
 			       struct batadv_neigh_node *neigh_node,
 			       struct batadv_hard_iface *if_incoming,
 			       struct batadv_hard_iface *if_outgoing)
 {
+	const struct ethhdr *ethhdr = eth_hdr(skb);
+	unsigned int tvlv_offset = sizeof(*ogm2);
 	int seqno_age;
 	bool forward;
 
@@ -623,11 +625,16 @@ batadv_v_ogm_process_per_outif(struct batadv_priv *bat_priv,
 		return;
 
 	/* only unknown & newer OGMs contain TVLVs we are interested in */
-	if ((seqno_age > 0) && (if_outgoing == BATADV_IF_DEFAULT))
+	if ((seqno_age > 0) && (if_outgoing == BATADV_IF_DEFAULT)) {
+		batadv_tvlv_containers_process2(bat_priv, skb, BATADV_OGM2,
+						tvlv_offset,
+						ntohs(ogm2->tvlv_len),
+						orig_node);
 		batadv_tvlv_containers_process(bat_priv, true, orig_node,
 					       NULL, NULL,
 					       (unsigned char *)(ogm2 + 1),
 					       ntohs(ogm2->tvlv_len));
+	}
 
 	/* if the metric update went through, update routes if needed */
 	forward = batadv_v_ogm_route_update(bat_priv, ethhdr, ogm2, orig_node,
@@ -728,7 +735,7 @@ static void batadv_v_ogm_process(const struct sk_buff *skb, int ogm_offset,
 	path_throughput = min_t(u32, link_throughput, ogm_throughput);
 	ogm_packet->throughput = htonl(path_throughput);
 
-	batadv_v_ogm_process_per_outif(bat_priv, ethhdr, ogm_packet, orig_node,
+	batadv_v_ogm_process_per_outif(bat_priv, skb, ogm_packet, orig_node,
 				       neigh_node, if_incoming,
 				       BATADV_IF_DEFAULT);
 
@@ -772,7 +779,7 @@ static void batadv_v_ogm_process(const struct sk_buff *skb, int ogm_offset,
 			continue;
 		}
 
-		batadv_v_ogm_process_per_outif(bat_priv, ethhdr, ogm_packet,
+		batadv_v_ogm_process_per_outif(bat_priv, skb, ogm_packet,
 					       orig_node, neigh_node,
 					       if_incoming, hard_iface);
 
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 1bfd1db..fa3768a 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -733,7 +733,7 @@ static void batadv_dat_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 					   u8 flags,
 					   void *tvlv_value, u16 tvlv_value_len)
 {
-	if (flags & BATADV_TVLV_HANDLER_OGM_CIFNOTFND)
+	if (flags & BATADV_TVLV_HANDLER_CIFNOTFND)
 		clear_bit(BATADV_ORIG_CAPA_HAS_DAT, &orig->capabilities);
 	else
 		set_bit(BATADV_ORIG_CAPA_HAS_DAT, &orig->capabilities);
@@ -775,7 +775,7 @@ int batadv_dat_init(struct batadv_priv *bat_priv)
 
 	batadv_tvlv_handler_register(bat_priv, batadv_dat_tvlv_ogm_handler_v1,
 				     NULL, BATADV_TVLV_DAT, 1,
-				     BATADV_TVLV_HANDLER_OGM_CIFNOTFND);
+				     BATADV_TVLV_HANDLER_CIFNOTFND);
 	batadv_dat_tvlv_container_update(bat_priv);
 	return 0;
 }
diff --git a/net/batman-adv/gateway_common.c b/net/batman-adv/gateway_common.c
index 5db2e43..b2c7039 100644
--- a/net/batman-adv/gateway_common.c
+++ b/net/batman-adv/gateway_common.c
@@ -207,25 +207,26 @@ ssize_t batadv_gw_bandwidth_set(struct net_device *net_dev, char *buff,
 }
 
 /**
- * batadv_gw_tvlv_ogm_handler_v1 - process incoming gateway tvlv container
+ * batadv_gw_tvlv_ogm_handler - process incoming gateway tvlv container
  * @bat_priv: the bat priv with all the soft interface information
- * @orig: the orig_node of the ogm
- * @flags: flags indicating the tvlv state (see batadv_tvlv_handler_flags)
  * @tvlv_value: tvlv buffer containing the gateway data
  * @tvlv_value_len: tvlv buffer length
+ * @ctx: handler specific context information (here: orig_node)
+ *
+ * Return: Always NET_RX_SUCCESS.
  */
-static void batadv_gw_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
-					  struct batadv_orig_node *orig,
-					  u8 flags,
-					  void *tvlv_value, u16 tvlv_value_len)
+static int batadv_gw_tvlv_ogm_handler(struct batadv_priv *bat_priv,
+				      void *tvlv_value,
+				      u16 tvlv_value_len,
+				      void *ctx)
 {
+	struct batadv_orig_node *orig_node = ctx;
 	struct batadv_tvlv_gateway_data gateway, *gateway_ptr;
 
-	/* only fetch the tvlv value if the handler wasn't called via the
-	 * CIFNOTFND flag and if there is data to fetch
+	/* might either be too small due to a broken packet,
+	 * or zero because no matching TVLV was found in the provided OGM
 	 */
-	if ((flags & BATADV_TVLV_HANDLER_OGM_CIFNOTFND) ||
-	    (tvlv_value_len < sizeof(gateway))) {
+	if (tvlv_value_len < sizeof(gateway)) {
 		gateway.bandwidth_down = 0;
 		gateway.bandwidth_up = 0;
 	} else {
@@ -239,12 +240,14 @@ static void batadv_gw_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 		}
 	}
 
-	batadv_gw_node_update(bat_priv, orig, &gateway);
+	batadv_gw_node_update(bat_priv, orig_node, &gateway);
 
 	/* restart gateway selection */
 	if ((gateway.bandwidth_down != 0) &&
 	    (atomic_read(&bat_priv->gw.mode) == BATADV_GW_MODE_CLIENT))
-		batadv_gw_check_election(bat_priv, orig);
+		batadv_gw_check_election(bat_priv, orig_node);
+
+	return NET_RX_SUCCESS;
 }
 
 /**
@@ -253,9 +256,12 @@ static void batadv_gw_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
  */
 void batadv_gw_init(struct batadv_priv *bat_priv)
 {
-	batadv_tvlv_handler_register(bat_priv, batadv_gw_tvlv_ogm_handler_v1,
-				     NULL, BATADV_TVLV_GW, 1,
-				     BATADV_TVLV_HANDLER_OGM_CIFNOTFND);
+	batadv_tvlv_handler_register2(bat_priv, batadv_gw_tvlv_ogm_handler,
+				      BATADV_IV_OGM, BATADV_TVLV_GW, 1,
+				      BATADV_TVLV_HANDLER_CIFNOTFND);
+	batadv_tvlv_handler_register2(bat_priv, batadv_gw_tvlv_ogm_handler,
+				      BATADV_OGM2, BATADV_TVLV_GW, 1,
+				      BATADV_TVLV_HANDLER_CIFNOTFND);
 }
 
 /**
@@ -265,5 +271,9 @@ void batadv_gw_init(struct batadv_priv *bat_priv)
 void batadv_gw_free(struct batadv_priv *bat_priv)
 {
 	batadv_tvlv_container_unregister(bat_priv, BATADV_TVLV_GW, 1);
-	batadv_tvlv_handler_unregister(bat_priv, BATADV_TVLV_GW, 1);
+
+	batadv_tvlv_handler_unregister2(bat_priv, BATADV_IV_OGM, BATADV_TVLV_GW,
+					1);
+	batadv_tvlv_handler_unregister2(bat_priv, BATADV_OGM2, BATADV_TVLV_GW,
+					1);
 }
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 952ba81..9e3a20d 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -1112,23 +1112,23 @@ static void batadv_mcast_want_ipv6_update(struct batadv_priv *bat_priv,
 /**
  * batadv_mcast_tvlv_ogm_handler - process incoming multicast tvlv container
  * @bat_priv: the bat priv with all the soft interface information
- * @orig: the orig_node of the ogm
- * @flags: flags indicating the tvlv state (see batadv_tvlv_handler_flags)
  * @tvlv_value: tvlv buffer containing the multicast data
  * @tvlv_value_len: tvlv buffer length
+ * @ctx: handler specific context information (here: orig_node)
+ *
+ * Return: Always NET_RX_SUCCESS.
  */
-static void batadv_mcast_tvlv_ogm_handler(struct batadv_priv *bat_priv,
-					  struct batadv_orig_node *orig,
-					  u8 flags,
-					  void *tvlv_value,
-					  u16 tvlv_value_len)
+static int batadv_mcast_tvlv_ogm_handler(struct batadv_priv *bat_priv,
+					 void *tvlv_value,
+					 u16 tvlv_value_len,
+					 void *ctx)
 {
-	bool orig_mcast_enabled = !(flags & BATADV_TVLV_HANDLER_OGM_CIFNOTFND);
+	struct batadv_orig_node *orig = ctx;
+	bool orig_mcast_enabled = !!tvlv_value;
 	u8 mcast_flags = BATADV_NO_FLAGS;
 	bool orig_initialized;
 
-	if (orig_mcast_enabled && tvlv_value &&
-	    (tvlv_value_len >= sizeof(mcast_flags)))
+	if (orig_mcast_enabled && (tvlv_value_len >= sizeof(mcast_flags)))
 		mcast_flags = *(u8 *)tvlv_value;
 
 	spin_lock_bh(&orig->mcast_handler_lock);
@@ -1163,6 +1163,8 @@ static void batadv_mcast_tvlv_ogm_handler(struct batadv_priv *bat_priv,
 
 	orig->mcast_flags = mcast_flags;
 	spin_unlock_bh(&orig->mcast_handler_lock);
+
+	return NET_RX_SUCCESS;
 }
 
 /**
@@ -1171,9 +1173,12 @@ static void batadv_mcast_tvlv_ogm_handler(struct batadv_priv *bat_priv,
  */
 void batadv_mcast_init(struct batadv_priv *bat_priv)
 {
-	batadv_tvlv_handler_register(bat_priv, batadv_mcast_tvlv_ogm_handler,
-				     NULL, BATADV_TVLV_MCAST, 2,
-				     BATADV_TVLV_HANDLER_OGM_CIFNOTFND);
+	batadv_tvlv_handler_register2(bat_priv, batadv_mcast_tvlv_ogm_handler,
+				      BATADV_IV_OGM, BATADV_TVLV_MCAST, 2,
+				      BATADV_TVLV_HANDLER_CIFNOTFND);
+	batadv_tvlv_handler_register2(bat_priv, batadv_mcast_tvlv_ogm_handler,
+				      BATADV_OGM2, BATADV_TVLV_MCAST, 2,
+				      BATADV_TVLV_HANDLER_CIFNOTFND);
 
 	INIT_DELAYED_WORK(&bat_priv->mcast.work, batadv_mcast_mla_update);
 	batadv_mcast_start_timer(bat_priv);
@@ -1291,7 +1296,11 @@ void batadv_mcast_free(struct batadv_priv *bat_priv)
 	cancel_delayed_work_sync(&bat_priv->mcast.work);
 
 	batadv_tvlv_container_unregister(bat_priv, BATADV_TVLV_MCAST, 2);
-	batadv_tvlv_handler_unregister(bat_priv, BATADV_TVLV_MCAST, 2);
+
+	batadv_tvlv_handler_unregister2(bat_priv, BATADV_IV_OGM,
+					BATADV_TVLV_MCAST, 2);
+	batadv_tvlv_handler_unregister2(bat_priv, BATADV_OGM2,
+					BATADV_TVLV_MCAST, 2);
 
 	/* safely calling outside of worker, as worker was canceled above */
 	batadv_mcast_mla_tt_retract(bat_priv, NULL);
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index e1f6fc7..e340662 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -137,7 +137,7 @@ static void batadv_nc_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 					  u8 flags,
 					  void *tvlv_value, u16 tvlv_value_len)
 {
-	if (flags & BATADV_TVLV_HANDLER_OGM_CIFNOTFND)
+	if (flags & BATADV_TVLV_HANDLER_CIFNOTFND)
 		clear_bit(BATADV_ORIG_CAPA_HAS_NC, &orig->capabilities);
 	else
 		set_bit(BATADV_ORIG_CAPA_HAS_NC, &orig->capabilities);
@@ -176,7 +176,7 @@ int batadv_nc_mesh_init(struct batadv_priv *bat_priv)
 
 	batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
 				     NULL, BATADV_TVLV_NC, 1,
-				     BATADV_TVLV_HANDLER_OGM_CIFNOTFND);
+				     BATADV_TVLV_HANDLER_CIFNOTFND);
 	batadv_nc_tvlv_container_update(bat_priv);
 	return 0;
 
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index 1d9e267..7dbda3a 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -27,6 +27,7 @@
 #include <linux/lockdep.h>
 #include <linux/netdevice.h>
 #include <linux/pkt_sched.h>
+#include <linux/printk.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
 #include <linux/skbuff.h>
@@ -68,23 +69,28 @@ static void batadv_tvlv_handler_put(struct batadv_tvlv_handler *tvlv_handler)
  * batadv_tvlv_handler_get - retrieve tvlv handler from the tvlv handler list
  *  based on the provided type and version (both need to match)
  * @bat_priv: the bat priv with all the soft interface information
- * @type: tvlv handler type to look for
- * @version: tvlv handler version to look for
+ * @packet_type: packet type to look for
+ * @tvlv_type: tvlv handler type to look for
+ * @tvlv_version: tvlv handler version to look for
  *
  * Return: tvlv handler if found or NULL otherwise.
  */
 static struct batadv_tvlv_handler *
-batadv_tvlv_handler_get(struct batadv_priv *bat_priv, u8 type, u8 version)
+batadv_tvlv_handler_get(struct batadv_priv *bat_priv, int packet_type,
+			u8 tvlv_type, u8 tvlv_version)
 {
 	struct batadv_tvlv_handler *tvlv_handler_tmp, *tvlv_handler = NULL;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(tvlv_handler_tmp,
 				 &bat_priv->tvlv.handler_list, list) {
-		if (tvlv_handler_tmp->type != type)
+		if (tvlv_handler_tmp->packet_type != packet_type)
 			continue;
 
-		if (tvlv_handler_tmp->version != version)
+		if (tvlv_handler_tmp->tvlv_type != tvlv_type)
+			continue;
+
+		if (tvlv_handler_tmp->tvlv_version != tvlv_version)
 			continue;
 
 		if (!kref_get_unless_zero(&tvlv_handler_tmp->refcount))
@@ -387,7 +393,7 @@ static int batadv_tvlv_call_handler(struct batadv_priv *bat_priv,
 		tvlv_handler->ogm_handler(bat_priv, orig_node,
 					  BATADV_NO_FLAGS,
 					  tvlv_value, tvlv_value_len);
-		tvlv_handler->flags |= BATADV_TVLV_HANDLER_OGM_CALLED;
+		tvlv_handler->flags |= BATADV_TVLV_HANDLER_CALLED;
 	} else {
 		if (!src)
 			return NET_RX_SUCCESS;
@@ -407,6 +413,139 @@ static int batadv_tvlv_call_handler(struct batadv_priv *bat_priv,
 }
 
 /**
+ * batadv_tvlv_call_handler2 - call the appropriate tvlv handler
+ * @bat_priv: the bat priv with all the soft interface information
+ * @packet_type: packet type to look and call for
+ * @tvlv_type: tvlv handler type to look and call for
+ * @tvlv_version: tvlv handler version to look and call for
+ * @tvlv_value: tvlv content
+ * @tvlv_value_len: tvlv content length
+ * @ctx: handler specific context information
+ *
+ * Return: NET_RX_SUCCESS if handler was found and called successfully,
+ * NET_RX_DROP otherwise.
+ */
+static int batadv_tvlv_call_handler2(struct batadv_priv *bat_priv,
+				     u8 packet_type, u8 tvlv_type,
+				     u8 tvlv_version, void *tvlv_value,
+				     u16 tvlv_value_len, void *ctx)
+{
+	struct batadv_tvlv_handler *tvlv_handler;
+	int ret;
+
+	tvlv_handler = batadv_tvlv_handler_get(bat_priv, packet_type, tvlv_type,
+					       tvlv_version);
+	if (!tvlv_handler)
+		return NET_RX_DROP;
+
+	ret = tvlv_handler->handler(bat_priv, tvlv_value, tvlv_value_len, ctx);
+	tvlv_handler->flags |= BATADV_TVLV_HANDLER_CALLED;
+
+	batadv_tvlv_handler_put(tvlv_handler);
+
+	return ret;
+}
+
+/**
+ * batadv_tvlv_call_unfound_handlers - call any handler not called yet
+ * @bat_priv: the bat priv with all the soft interface information
+ * @packet_type: the packet type to call handlers of unfound TVLVs for
+ * @ctx: handler specific context information
+ *
+ * For any registered TVLV handler with a CIFNOTFND flag: If a matching
+ * tvlv type was not found in a specific packet (type) then this calls the
+ * according handler with an empty (NULL) tvlv_value and tvlv_value_len of
+ * zero now.
+ */
+static void batadv_tvlv_call_unfound_handlers(struct batadv_priv *bat_priv,
+					      int packet_type, void *ctx)
+{
+	struct batadv_tvlv_handler *tvlv_handler;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(tvlv_handler,
+				 &bat_priv->tvlv.handler_list, list) {
+		if (tvlv_handler->packet_type != packet_type)
+			continue;
+
+		if ((tvlv_handler->flags & BATADV_TVLV_HANDLER_CIFNOTFND) &&
+		    !(tvlv_handler->flags & BATADV_TVLV_HANDLER_CALLED))
+			tvlv_handler->handler(bat_priv, NULL, 0, ctx);
+
+		tvlv_handler->flags &= ~BATADV_TVLV_HANDLER_CALLED;
+	}
+	rcu_read_unlock();
+}
+
+/**
+ * batadv_tvlv_containers_process2 - parse and process TVLV content of a packet
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: the packet to parse and process TVLV data from
+ * @packet_type: the packet type to call handlers for
+ * @tvlv_offset: offset from the skb data pointer to the first tvlv header
+ * @tvlv_value_len: total tvlv content length (sum of all tvlv headers+values)
+ * @ctx: handler specific context information
+ *
+ * This function parses TVLV options of the given skb and tries to call the
+ * appropriate, registered handlers.
+ *
+ * In the end, all not yet called handlers (because no appropriate TVLV was
+ * found in the packet) which were registered with a CIFNOTFND flag are
+ * called with empty tvlv_value pointers.
+ *
+ * Return: NET_RX_SUCCESS if all TVLVs were known and parsed, as well as
+ * any TVLV handler called successfully. Returns NET_RX_DROP otherwise.
+ */
+int batadv_tvlv_containers_process2(struct batadv_priv *bat_priv,
+				    const struct sk_buff *skb, u8 packet_type,
+				    unsigned int tvlv_offset,
+				    u16 tvlv_value_len, void *ctx)
+{
+	struct batadv_tvlv_hdr *tvlv_hdr, tvlv_hdr_buff;
+	u8 *tvlv_value, tvlv_value_buff[128];
+	u16 tvlv_value_cont_len;
+	int ret = NET_RX_SUCCESS;
+
+	while (tvlv_value_len >= sizeof(*tvlv_hdr)) {
+		tvlv_hdr = skb_header_pointer(skb, tvlv_offset,
+					      sizeof(tvlv_hdr_buff),
+					      &tvlv_hdr_buff);
+		if (!tvlv_hdr)
+			return NET_RX_DROP;
+
+		tvlv_value_cont_len = ntohs(tvlv_hdr->len);
+		tvlv_offset += sizeof(*tvlv_hdr);
+		tvlv_value_len -= sizeof(*tvlv_hdr);
+
+		if (tvlv_value_cont_len > sizeof(tvlv_value_buff)) {
+			pr_warn_once("batman-adv: TVLVs greater than 128 bytes unsupported for now, ignoring\n");
+			goto skip_handler_call;
+		}
+
+		if (tvlv_value_cont_len > tvlv_value_len)
+			return NET_RX_DROP;
+
+		tvlv_value = skb_header_pointer(skb, tvlv_offset,
+						tvlv_value_cont_len,
+						tvlv_value_buff);
+		if (!tvlv_value)
+			return NET_RX_DROP;
+
+		ret |= batadv_tvlv_call_handler2(bat_priv, packet_type,
+						 tvlv_hdr->type,
+						 tvlv_hdr->version, tvlv_value,
+						 tvlv_value_cont_len, ctx);
+skip_handler_call:
+		tvlv_offset += tvlv_value_cont_len;
+		tvlv_value_len -= tvlv_value_cont_len;
+	}
+
+	batadv_tvlv_call_unfound_handlers(bat_priv, packet_type, ctx);
+
+	return ret;
+}
+
+/**
  * batadv_tvlv_containers_process - parse the given tvlv buffer to call the
  *  appropriate handlers
  * @bat_priv: the bat priv with all the soft interface information
@@ -429,7 +568,7 @@ int batadv_tvlv_containers_process(struct batadv_priv *bat_priv,
 	struct batadv_tvlv_handler *tvlv_handler;
 	struct batadv_tvlv_hdr *tvlv_hdr;
 	u16 tvlv_value_cont_len;
-	u8 cifnotfound = BATADV_TVLV_HANDLER_OGM_CIFNOTFND;
+	u8 cifnotfound = BATADV_TVLV_HANDLER_CIFNOTFND;
 	int ret = NET_RX_SUCCESS;
 
 	while (tvlv_value_len >= sizeof(*tvlv_hdr)) {
@@ -441,7 +580,7 @@ int batadv_tvlv_containers_process(struct batadv_priv *bat_priv,
 		if (tvlv_value_cont_len > tvlv_value_len)
 			break;
 
-		tvlv_handler = batadv_tvlv_handler_get(bat_priv,
+		tvlv_handler = batadv_tvlv_handler_get(bat_priv, -1,
 						       tvlv_hdr->type,
 						       tvlv_hdr->version);
 
@@ -461,12 +600,15 @@ int batadv_tvlv_containers_process(struct batadv_priv *bat_priv,
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(tvlv_handler,
 				 &bat_priv->tvlv.handler_list, list) {
-		if ((tvlv_handler->flags & BATADV_TVLV_HANDLER_OGM_CIFNOTFND) &&
-		    !(tvlv_handler->flags & BATADV_TVLV_HANDLER_OGM_CALLED))
+		if (tvlv_handler->packet_type != -1)
+			continue;
+
+		if ((tvlv_handler->flags & BATADV_TVLV_HANDLER_CIFNOTFND) &&
+		    !(tvlv_handler->flags & BATADV_TVLV_HANDLER_CALLED))
 			tvlv_handler->ogm_handler(bat_priv, orig_node,
 						  cifnotfound, NULL, 0);
 
-		tvlv_handler->flags &= ~BATADV_TVLV_HANDLER_OGM_CALLED;
+		tvlv_handler->flags &= ~BATADV_TVLV_HANDLER_CALLED;
 	}
 	rcu_read_unlock();
 
@@ -477,27 +619,95 @@ int batadv_tvlv_containers_process(struct batadv_priv *bat_priv,
  * batadv_tvlv_ogm_receive - process an incoming ogm and call the appropriate
  *  handlers
  * @bat_priv: the bat priv with all the soft interface information
- * @batadv_ogm_packet: ogm packet containing the tvlv containers
+ * @skb: ogm packet containing the tvlv containers
  * @orig_node: orig node emitting the ogm packet
+ *
+ * Caller needs to ensure that the skb network header points to the appropriate
+ * OGM header.
  */
 void batadv_tvlv_ogm_receive(struct batadv_priv *bat_priv,
-			     struct batadv_ogm_packet *batadv_ogm_packet,
+			     const struct sk_buff *skb,
 			     struct batadv_orig_node *orig_node)
 {
+	struct batadv_ogm_packet *ogm_packet;
+	unsigned int tvlv_offset;
 	void *tvlv_value;
 	u16 tvlv_value_len;
 
-	if (!batadv_ogm_packet)
+	ogm_packet = (struct batadv_ogm_packet *)skb_network_header(skb);
+	if (!ogm_packet)
 		return;
 
-	tvlv_value_len = ntohs(batadv_ogm_packet->tvlv_len);
+	tvlv_value_len = ntohs(ogm_packet->tvlv_len);
 	if (!tvlv_value_len)
 		return;
 
-	tvlv_value = batadv_ogm_packet + 1;
+	tvlv_offset = skb_network_offset(skb) + sizeof(*ogm_packet);
+	tvlv_value = ogm_packet + 1;
 
 	batadv_tvlv_containers_process(bat_priv, true, orig_node, NULL, NULL,
 				       tvlv_value, tvlv_value_len);
+	batadv_tvlv_containers_process2(bat_priv, skb, BATADV_IV_OGM,
+					tvlv_offset, tvlv_value_len, orig_node);
+}
+
+/**
+ * batadv_tvlv_handler_register - register a tvlv handler
+ * @bat_priv: the bat priv with all the soft interface information
+ * @handler: TVLV handler callback function
+ * @packet_type: packet type to register this handler for
+ * @tvlv_type: tvlv handler type to be registered
+ * @tvlv_version: tvlv handler version to be registered
+ * @flags: flags to enable or disable TVLV API behavior
+ *
+ * Registers a handler for incoming packets of the provided packet type.
+ * When a packet of this type with a matching TVLV (both tvlv type and version)
+ * is received then the registered handler is called with the according TVLV
+ * value, length and packet context.
+ *
+ * If 'flags' is set to BATADV_TVLV_HANDLER_CIFNOTFND:
+ * Then the handler might be called with an empty tvlv_value (NULL) and
+ * tvlv_value_len (zero) if a packet with a matching packet type but no
+ * matching TVLV was received.
+ */
+void batadv_tvlv_handler_register2(struct batadv_priv *bat_priv,
+				   int (*handler)(struct batadv_priv *bat_priv,
+						  void *tvlv_value,
+						  u16 tvlv_value_len,
+						  void *ctx),
+				   u8 packet_type, u8 tvlv_type,
+				   u8 tvlv_version, u8 flags)
+{
+	struct batadv_tvlv_handler *tvlv_handler;
+
+	tvlv_handler = batadv_tvlv_handler_get(bat_priv, packet_type, tvlv_type,
+					       tvlv_version);
+	if (tvlv_handler) {
+		batadv_tvlv_handler_put(tvlv_handler);
+		return;
+	}
+
+	tvlv_handler = kzalloc(sizeof(*tvlv_handler), GFP_ATOMIC);
+	if (!tvlv_handler)
+		return;
+
+	tvlv_handler->ogm_handler = NULL;
+	tvlv_handler->unicast_handler = NULL;
+	tvlv_handler->handler = handler;
+	tvlv_handler->packet_type = packet_type;
+	tvlv_handler->tvlv_type = tvlv_type;
+	tvlv_handler->tvlv_version = tvlv_version;
+	tvlv_handler->flags = flags;
+	kref_init(&tvlv_handler->refcount);
+	INIT_HLIST_NODE(&tvlv_handler->list);
+
+	spin_lock_bh(&bat_priv->tvlv.handler_list_lock);
+	kref_get(&tvlv_handler->refcount);
+	hlist_add_head_rcu(&tvlv_handler->list, &bat_priv->tvlv.handler_list);
+	spin_unlock_bh(&bat_priv->tvlv.handler_list_lock);
+
+	/* don't return reference to new tvlv_handler */
+	batadv_tvlv_handler_put(tvlv_handler);
 }
 
 /**
@@ -510,8 +720,8 @@ void batadv_tvlv_ogm_receive(struct batadv_priv *bat_priv,
  * @uptr: unicast tvlv handler callback function. This function receives the
  *  source & destination of the unicast packet as well as the tvlv content
  *  to process.
- * @type: tvlv handler type to be registered
- * @version: tvlv handler version to be registered
+ * @tvlv_type: tvlv handler type to be registered
+ * @tvlv_version: tvlv handler version to be registered
  * @flags: flags to enable or disable TVLV API behavior
  */
 void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
@@ -524,11 +734,13 @@ void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
 					      u8 *src, u8 *dst,
 					      void *tvlv_value,
 					      u16 tvlv_value_len),
-				  u8 type, u8 version, u8 flags)
+				  u8 tvlv_type, u8 tvlv_version,
+				  u8 flags)
 {
 	struct batadv_tvlv_handler *tvlv_handler;
 
-	tvlv_handler = batadv_tvlv_handler_get(bat_priv, type, version);
+	tvlv_handler = batadv_tvlv_handler_get(bat_priv, -1, tvlv_type,
+					       tvlv_version);
 	if (tvlv_handler) {
 		batadv_tvlv_handler_put(tvlv_handler);
 		return;
@@ -540,8 +752,10 @@ void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
 
 	tvlv_handler->ogm_handler = optr;
 	tvlv_handler->unicast_handler = uptr;
-	tvlv_handler->type = type;
-	tvlv_handler->version = version;
+	tvlv_handler->handler = NULL;
+	tvlv_handler->packet_type = -1;
+	tvlv_handler->tvlv_type = tvlv_type;
+	tvlv_handler->tvlv_version = tvlv_version;
 	tvlv_handler->flags = flags;
 	kref_init(&tvlv_handler->refcount);
 	INIT_HLIST_NODE(&tvlv_handler->list);
@@ -556,18 +770,47 @@ void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
 }
 
 /**
+ * batadv_tvlv_handler_unregister2 - unregister a tvlv handler
+ * @bat_priv: the bat priv with all the soft interface information
+ * @packet_type: packet type to unregister for
+ * @tvlv_type: tvlv handler type to be unregistered
+ * @tvlv_version: tvlv handler version to be unregistered
+ *
+ * Unregisters a TVLV handler based on the provided packet type, tvlv type
+ * and version (all need to match).
+ */
+void batadv_tvlv_handler_unregister2(struct batadv_priv *bat_priv,
+				     u8 packet_type, u8 tvlv_type,
+				     u8 tvlv_version)
+{
+	struct batadv_tvlv_handler *tvlv_handler;
+
+	tvlv_handler = batadv_tvlv_handler_get(bat_priv, packet_type, tvlv_type,
+					       tvlv_version);
+	if (!tvlv_handler)
+		return;
+
+	batadv_tvlv_handler_put(tvlv_handler);
+	spin_lock_bh(&bat_priv->tvlv.handler_list_lock);
+	hlist_del_rcu(&tvlv_handler->list);
+	spin_unlock_bh(&bat_priv->tvlv.handler_list_lock);
+	batadv_tvlv_handler_put(tvlv_handler);
+}
+
+/**
  * batadv_tvlv_handler_unregister - unregister tvlv handler based on the
  *  provided type and version (both need to match)
  * @bat_priv: the bat priv with all the soft interface information
- * @type: tvlv handler type to be unregistered
- * @version: tvlv handler version to be unregistered
+ * @tvlv_type: tvlv handler type to be unregistered
+ * @tvlv_version: tvlv handler version to be unregistered
  */
 void batadv_tvlv_handler_unregister(struct batadv_priv *bat_priv,
-				    u8 type, u8 version)
+				    u8 tvlv_type, u8 tvlv_version)
 {
 	struct batadv_tvlv_handler *tvlv_handler;
 
-	tvlv_handler = batadv_tvlv_handler_get(bat_priv, type, version);
+	tvlv_handler = batadv_tvlv_handler_get(bat_priv, -1, tvlv_type,
+					       tvlv_version);
 	if (!tvlv_handler)
 		return;
 
diff --git a/net/batman-adv/tvlv.h b/net/batman-adv/tvlv.h
index 4d01400..3496f36 100644
--- a/net/batman-adv/tvlv.h
+++ b/net/batman-adv/tvlv.h
@@ -22,7 +22,7 @@
 
 #include <linux/types.h>
 
-struct batadv_ogm_packet;
+struct sk_buff;
 
 void batadv_tvlv_container_register(struct batadv_priv *bat_priv,
 				    u8 type, u8 version,
@@ -31,11 +31,18 @@ u16 batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
 				     unsigned char **packet_buff,
 				     int *packet_buff_len, int packet_min_len);
 void batadv_tvlv_ogm_receive(struct batadv_priv *bat_priv,
-			     struct batadv_ogm_packet *batadv_ogm_packet,
+			     const struct sk_buff *skb,
 			     struct batadv_orig_node *orig_node);
 void batadv_tvlv_container_unregister(struct batadv_priv *bat_priv,
 				      u8 type, u8 version);
 
+void batadv_tvlv_handler_register2(struct batadv_priv *bat_priv,
+				   int (*handler)(struct batadv_priv *bat_priv,
+						  void *tvlv_value,
+						  u16 tvlv_value_len,
+						  void *ctx),
+				   u8 packet_type, u8 tvlv_type,
+				   u8 tvlv_version, u8 flags);
 void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
 				  void (*optr)(struct batadv_priv *bat_priv,
 					       struct batadv_orig_node *orig,
@@ -46,14 +53,21 @@ void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
 					      u8 *src, u8 *dst,
 					      void *tvlv_value,
 					      u16 tvlv_value_len),
-				  u8 type, u8 version, u8 flags);
+				  u8 tvlv_type, u8 tvlv_version, u8 flags);
+void batadv_tvlv_handler_unregister2(struct batadv_priv *bat_priv,
+				     u8 packet_type, u8 tvlv_type,
+				     u8 tvlv_version);
 void batadv_tvlv_handler_unregister(struct batadv_priv *bat_priv,
-				    u8 type, u8 version);
+				    u8 tvlv_type, u8 tvlv_version);
 int batadv_tvlv_containers_process(struct batadv_priv *bat_priv,
 				   bool ogm_source,
 				   struct batadv_orig_node *orig_node,
 				   u8 *src, u8 *dst,
 				   void *tvlv_buff, u16 tvlv_buff_len);
+int batadv_tvlv_containers_process2(struct batadv_priv *bat_priv,
+				    const struct sk_buff *skb, u8 packet_type,
+				    unsigned int tvlv_offset,
+				    u16 tvlv_value_len, void *ctx);
 void batadv_tvlv_unicast_send(struct batadv_priv *bat_priv, u8 *src,
 			      u8 *dst, u8 type, u8 version,
 			      void *tvlv_value, u16 tvlv_value_len);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 000a26d..6dbdbf6 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1603,8 +1603,11 @@ struct batadv_tvlv_container {
  *  incoming OGM packets
  * @unicast_handler: handler callback which is given the tvlv payload to process
  *  on incoming unicast tvlv packets
- * @type: tvlv type this handler feels responsible for
- * @version: tvlv version this handler feels responsible for
+ * @handler: handler callback which is given the tvlv payload to process on
+ *  incoming packets of the given packet type
+ * @packet_type: packet type this handler feels responsible for
+ * @tvlv_type: tvlv type this handler feels responsible for
+ * @tvlv_version: tvlv version this handler feels responsible for
  * @flags: tvlv handler flags
  * @refcount: number of contexts the object is used
  * @rcu: struct used for freeing in an RCU-safe manner
@@ -1617,8 +1620,11 @@ struct batadv_tvlv_handler {
 	int (*unicast_handler)(struct batadv_priv *bat_priv,
 			       u8 *src, u8 *dst,
 			       void *tvlv_value, u16 tvlv_value_len);
-	u8 type;
-	u8 version;
+	int (*handler)(struct batadv_priv *bat_priv, void *tvlv_value,
+		       u16 tvlv_value_len, void *ctx);
+	int packet_type;
+	u8 tvlv_type;
+	u8 tvlv_version;
 	u8 flags;
 	struct kref refcount;
 	struct rcu_head rcu;
@@ -1626,15 +1632,15 @@ struct batadv_tvlv_handler {
 
 /**
  * enum batadv_tvlv_handler_flags - tvlv handler flags definitions
- * @BATADV_TVLV_HANDLER_OGM_CIFNOTFND: tvlv ogm processing function will call
+ * @BATADV_TVLV_HANDLER_CIFNOTFND: tvlv processing function will call
  *  this handler even if its type was not found (with no data)
- * @BATADV_TVLV_HANDLER_OGM_CALLED: interval tvlv handling flag - the API marks
+ * @BATADV_TVLV_HANDLER_CALLED: internal tvlv handling flag - the API marks
  *  a handler as being called, so it won't be called if the
- *  BATADV_TVLV_HANDLER_OGM_CIFNOTFND flag was set
+ *  BATADV_TVLV_HANDLER_CIFNOTFND flag was set
  */
 enum batadv_tvlv_handler_flags {
-	BATADV_TVLV_HANDLER_OGM_CIFNOTFND = BIT(1),
-	BATADV_TVLV_HANDLER_OGM_CALLED = BIT(2),
+	BATADV_TVLV_HANDLER_CIFNOTFND = BIT(1),
+	BATADV_TVLV_HANDLER_CALLED = BIT(2),
 };
 
 /**
-- 
2.1.4


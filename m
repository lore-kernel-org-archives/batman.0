Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 18 Feb 2012 17:38:51 +0100
Message-Id: <1329583133-11681-6-git-send-email-ordex@autistici.org>
In-Reply-To: <1329583133-11681-1-git-send-email-ordex@autistici.org>
References: <1329583133-11681-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv6 5/7] batman-adv: Distributed ARP Table -
	add snooping functions for ARP messages
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

In case of an ARP message going in or out the soft_iface, it is intercepted and
a special action is performed. In particular the DHT helper functions previously
implemented are used to store all the ARP entries belonging to the network in
order to provide a fast and unicast lookup instead of the classic broadcast
flooding mechanism.
Each node stores the entries it is responsible for (following the DHT rules) in
its soft_iface ARP table. This makes it possible to reuse the kernel data
structures and functions for ARP management.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 distributed-arp-table.c |  246 +++++++++++++++++++++++++++++++++++++++++++++++
 distributed-arp-table.h |   11 ++
 main.h                  |    2 +
 send.c                  |    6 +
 soft-interface.c        |   18 ++++-
 5 files changed, 282 insertions(+), 1 deletions(-)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 84e4630..3693879 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -21,6 +21,8 @@
 
 #include <linux/if_ether.h>
 #include <linux/if_arp.h>
+/* needed to use arp_tbl */
+#include <net/arp.h>
 
 #include "main.h"
 #include "distributed-arp-table.h"
@@ -28,6 +30,7 @@
 #include "originator.h"
 #include "send.h"
 #include "types.h"
+#include "translation-table.h"
 #include "unicast.h"
 
 #ifdef CONFIG_BATMAN_ADV_DEBUG
@@ -276,6 +279,31 @@ out:
 	return ret;
 }
 
+/* Update the neighbour entry corresponding to the IP passed as parameter with
+ * the hw address hw. If the neighbour entry doesn't exists, then it will be
+ * created */
+static void arp_neigh_update(struct bat_priv *bat_priv, uint32_t ip,
+			     uint8_t *hw)
+{
+	struct neighbour *n = NULL;
+	struct hard_iface *primary_if = primary_if_get_selected(bat_priv);
+	if (!primary_if)
+		goto out;
+
+	n = __neigh_lookup(&arp_tbl, &ip, primary_if->soft_iface, 1);
+	if (!n)
+		goto out;
+
+	bat_dbg(DBG_ARP, bat_priv, "Updating neighbour: %pI4 - %pM\n", &ip, hw);
+
+	neigh_update(n, hw, NUD_REACHABLE, NEIGH_UPDATE_F_OVERRIDE);
+out:
+	if (n && !IS_ERR(n))
+		neigh_release(n);
+	if (primary_if)
+		hardif_free_ref(primary_if);
+}
+
 /* Returns arphdr->ar_op if the skb contains a valid ARP packet, otherwise
  * returns 0 */
 static uint16_t arp_get_type(struct bat_priv *bat_priv, struct sk_buff *skb,
@@ -327,3 +355,221 @@ static uint16_t arp_get_type(struct bat_priv *bat_priv, struct sk_buff *skb,
 out:
 	return type;
 }
+
+/* return true if the message has been sent to the dht candidates, false
+ * otherwise. In case of true the message has to be enqueued to permit the
+ * fallback */
+bool dat_snoop_outgoing_arp_request(struct bat_priv *bat_priv,
+				    struct sk_buff *skb)
+{
+	uint16_t type = 0;
+	uint32_t ip_dst, ip_src;
+	uint8_t *hw_src;
+	bool ret = false;
+	struct neighbour *n = NULL;
+	struct hard_iface *primary_if = NULL;
+	struct sk_buff *skb_new;
+
+	type = arp_get_type(bat_priv, skb, 0);
+	/* If we get an ARP_REQUEST we have to send the unicast message to the
+	 * selected DHT candidates */
+	if (type != ARPOP_REQUEST)
+		goto out;
+
+	bat_dbg_arp(bat_priv, skb, type, 0, "Parsing outgoing ARP REQUEST");
+
+	ip_src = ARP_IP_SRC(skb, 0);
+	hw_src = ARP_HW_SRC(skb, 0);
+	ip_dst = ARP_IP_DST(skb, 0);
+
+	primary_if = primary_if_get_selected(bat_priv);
+	if (!primary_if)
+		goto out;
+
+	arp_neigh_update(bat_priv, ip_src, hw_src);
+
+	n = neigh_lookup(&arp_tbl, &ip_dst, primary_if->soft_iface);
+	/* check if it is a valid neigh entry */
+	if (n && (n->nud_state & NUD_CONNECTED)) {
+		skb_new = arp_create(ARPOP_REPLY, ETH_P_ARP, ip_src,
+				     primary_if->soft_iface, ip_dst, hw_src,
+				     n->ha, hw_src);
+		if (!skb_new)
+			goto out;
+
+		skb_reset_mac_header(skb_new);
+		skb_new->protocol = eth_type_trans(skb_new,
+						   primary_if->soft_iface);
+		bat_priv->stats.rx_packets++;
+		bat_priv->stats.rx_bytes += skb->len + ETH_HLEN;
+		primary_if->soft_iface->last_rx = jiffies;
+
+		netif_rx(skb_new);
+		bat_dbg(DBG_ARP, bat_priv, "ARP request replied locally\n");
+	} else
+		/* Send the request on the DHT */
+		ret = dht_send_data(bat_priv, skb, ip_dst, BAT_P_DAT_DHT_GET);
+out:
+	if (n)
+		neigh_release(n);
+	if (primary_if)
+		hardif_free_ref(primary_if);
+	return ret;
+}
+
+/* This function is meant to be invoked for an ARP request which is coming into
+ * the bat0 interfaces from the mesh network. It will check for the needed data
+ * into the local table. If found, an ARP reply is sent immediately, otherwise
+ * the caller has to deliver the ARP request to the upper layer */
+bool dat_snoop_incoming_arp_request(struct bat_priv *bat_priv,
+				    struct sk_buff *skb, int hdr_size)
+{
+	uint16_t type;
+	uint32_t ip_src, ip_dst;
+	uint8_t *hw_src;
+	struct hard_iface *primary_if = NULL;
+	struct sk_buff *skb_new;
+	struct neighbour *n = NULL;
+	bool ret = false;
+
+	type = arp_get_type(bat_priv, skb, hdr_size);
+	if (type != ARPOP_REQUEST)
+		goto out;
+
+	hw_src = ARP_HW_SRC(skb, hdr_size);
+	ip_src = ARP_IP_SRC(skb, hdr_size);
+	ip_dst = ARP_IP_DST(skb, hdr_size);
+
+	bat_dbg_arp(bat_priv, skb, type, hdr_size,
+		    "Parsing incoming ARP REQUEST");
+
+	primary_if = primary_if_get_selected(bat_priv);
+	if (!primary_if)
+		goto out;
+
+	arp_neigh_update(bat_priv, ip_src, hw_src);
+
+	n = neigh_lookup(&arp_tbl, &ip_dst, primary_if->soft_iface);
+	/* check if it is a valid neigh entry */
+	if (!n || !(n->nud_state & NUD_CONNECTED))
+		goto out;
+
+	skb_new = arp_create(ARPOP_REPLY, ETH_P_ARP, ip_src,
+			     primary_if->soft_iface, ip_dst, hw_src, n->ha,
+			     hw_src);
+
+	if (!skb_new)
+		goto out;
+
+	unicast_4addr_send_skb(skb_new, bat_priv, BAT_P_DAT_CACHE_REPLY);
+
+	ret = true;
+out:
+	if (n)
+		neigh_release(n);
+	if (primary_if)
+		hardif_free_ref(primary_if);
+	if (ret)
+		kfree_skb(skb);
+	return ret;
+}
+
+/* This function is meant to be invoked on an ARP reply packet going into the
+ * soft interface. The related neighbour entry has to be updated and the DHT has
+ * to be populated as well */
+bool dat_snoop_outgoing_arp_reply(struct bat_priv *bat_priv,
+				  struct sk_buff *skb)
+{
+	uint16_t type;
+	uint32_t ip_src, ip_dst;
+	uint8_t *hw_src, *hw_dst;
+	bool ret = false;
+
+	type = arp_get_type(bat_priv, skb, 0);
+	if (type != ARPOP_REPLY)
+		goto out;
+
+	bat_dbg_arp(bat_priv, skb, type, 0, "Parsing outgoing ARP REPLY");
+
+	hw_src = ARP_HW_SRC(skb, 0);
+	ip_src = ARP_IP_SRC(skb, 0);
+	hw_dst = ARP_HW_DST(skb, 0);
+	ip_dst = ARP_IP_DST(skb, 0);
+
+	arp_neigh_update(bat_priv, ip_src, hw_src);
+	arp_neigh_update(bat_priv, ip_dst, hw_dst);
+
+	/* Send the ARP reply to the candidates for both the IP addresses we
+	 * fetched from the ARP reply */
+	dht_send_data(bat_priv, skb, ip_src, BAT_P_DAT_DHT_PUT);
+	dht_send_data(bat_priv, skb, ip_dst, BAT_P_DAT_DHT_PUT);
+	ret = true;
+out:
+	return ret;
+}
+
+/* This function has to be invoked on an ARP reply coming into the soft
+ * interface from the mesh network. The local table has to be updated */
+bool dat_snoop_incoming_arp_reply(struct bat_priv *bat_priv,
+				  struct sk_buff *skb, int hdr_size)
+{
+	uint16_t type;
+	uint32_t ip_src, ip_dst;
+	uint8_t *hw_src, *hw_dst;
+	bool ret = false;
+
+	type = arp_get_type(bat_priv, skb, hdr_size);
+	if (type != ARPOP_REPLY)
+		goto out;
+
+	bat_dbg_arp(bat_priv, skb, type, hdr_size,
+		    "Parsing incoming ARP REPLY");
+
+	hw_src = ARP_HW_SRC(skb, hdr_size);
+	ip_src = ARP_IP_SRC(skb, hdr_size);
+	hw_dst = ARP_HW_DST(skb, hdr_size);
+	ip_dst = ARP_IP_DST(skb, hdr_size);
+
+	/* Update our internal cache with both the IP addresses we fetched from
+	 * the ARP reply */
+	arp_neigh_update(bat_priv, ip_src, hw_src);
+	arp_neigh_update(bat_priv, ip_dst, hw_dst);
+
+	/* if this REPLY is directed to a client of mine, let's deliver the
+	 * packet to the interface */
+	ret = !is_my_client(bat_priv, hw_dst);
+out:
+	/* if ret == false packet has to be delivered to the interface */
+	return ret;
+}
+
+bool arp_drop_broadcast_packet(struct bat_priv *bat_priv,
+			       struct forw_packet *forw_packet)
+{
+	struct neighbour *n;
+
+	/* If this packet is an ARP_REQUEST and we already have the information
+	 * that it is going to ask, we can drop the packet */
+	if (!forw_packet->num_packets &&
+			(arp_get_type(bat_priv, forw_packet->skb,
+				      sizeof(struct bcast_packet)) ==
+							ARPOP_REQUEST)) {
+		n = neigh_lookup(&arp_tbl,
+				 &ARP_IP_DST(forw_packet->skb,
+					     sizeof(struct bcast_packet)),
+				 forw_packet->if_incoming->soft_iface);
+		/* check if we already know this neigh */
+		if (n && (n->nud_state & NUD_CONNECTED)) {
+			bat_dbg(DBG_ARP, bat_priv, "ARP Request for %pI4: "
+				"fallback prevented\n",
+				&ARP_IP_DST(forw_packet->skb,
+					    sizeof(struct bcast_packet)));
+			return true;
+		}
+
+		bat_dbg(DBG_ARP, bat_priv, "ARP Request for %pI4: fallback\n",
+			&ARP_IP_DST(forw_packet->skb,
+				    sizeof(struct bcast_packet)));
+	}
+	return false;
+}
diff --git a/distributed-arp-table.h b/distributed-arp-table.h
index b5bf2d1..3b90b73 100644
--- a/distributed-arp-table.h
+++ b/distributed-arp-table.h
@@ -37,6 +37,17 @@
 #define ARP_IP_DST(skb, hdr_size) (*(uint32_t *)(ARP_HW_SRC(skb, hdr_size) + \
 				   ETH_ALEN * 2 + 4))
 
+bool dat_snoop_outgoing_arp_request(struct bat_priv *bat_priv,
+				    struct sk_buff *skb);
+bool dat_snoop_incoming_arp_request(struct bat_priv *bat_priv,
+				    struct sk_buff *skb, int hdr_size);
+bool dat_snoop_outgoing_arp_reply(struct bat_priv *bat_priv,
+				  struct sk_buff *skb);
+bool dat_snoop_incoming_arp_reply(struct bat_priv *bat_priv,
+				  struct sk_buff *skb, int hdr_size);
+bool arp_drop_broadcast_packet(struct bat_priv *bat_priv,
+			       struct forw_packet *forw_packet);
+
 /* hash function to choose an entry in a hash table of given size */
 /* hash algorithm from http://en.wikipedia.org/wiki/Hash_table */
 static inline uint32_t hash_ipv4(const void *data, uint32_t size)
diff --git a/main.h b/main.h
index 86a3d4a..7384abb 100644
--- a/main.h
+++ b/main.h
@@ -67,6 +67,8 @@
 
 #define NUM_WORDS BITS_TO_LONGS(TQ_LOCAL_WINDOW_SIZE)
 
+/* msecs after which an ARP_REQUEST is sent in broadcast as fallback */
+#define ARP_REQ_DELAY 250
 /* numbers of originator to contact for any PUT/GET DHT operation */
 #define DHT_CANDIDATES_NUM 3
 
diff --git a/send.c b/send.c
index 1d5353f..8bd31bb 100644
--- a/send.c
+++ b/send.c
@@ -20,6 +20,7 @@
  */
 
 #include "main.h"
+#include "distributed-arp-table.h"
 #include "send.h"
 #include "routing.h"
 #include "translation-table.h"
@@ -29,6 +30,8 @@
 #include "gateway_common.h"
 #include "originator.h"
 
+#include <net/arp.h>
+
 static void send_outstanding_bcast_packet(struct work_struct *work);
 
 /* send out an already prepared packet to the given address via the
@@ -274,6 +277,9 @@ static void send_outstanding_bcast_packet(struct work_struct *work)
 	if (atomic_read(&bat_priv->mesh_state) == MESH_DEACTIVATING)
 		goto out;
 
+	if (arp_drop_broadcast_packet(bat_priv, forw_packet))
+		goto out;
+
 	/* rebroadcast packet */
 	rcu_read_lock();
 	list_for_each_entry_rcu(hard_iface, &hardif_list, list) {
diff --git a/soft-interface.c b/soft-interface.c
index 3297c40..f27ea7e 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -22,6 +22,7 @@
 #include "main.h"
 #include "soft-interface.h"
 #include "hard-interface.h"
+#include "distributed-arp-table.h"
 #include "routing.h"
 #include "send.h"
 #include "bat_debugfs.h"
@@ -136,6 +137,7 @@ static int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 	int data_len = skb->len, ret;
 	short vid __maybe_unused = -1;
 	bool do_bcast = false;
+	unsigned long brd_delay = 1;
 
 	if (atomic_read(&bat_priv->mesh_state) != MESH_ACTIVE)
 		goto dropped;
@@ -196,6 +198,9 @@ static int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 		if (!primary_if)
 			goto dropped;
 
+		if (dat_snoop_outgoing_arp_request(bat_priv, skb))
+			brd_delay = msecs_to_jiffies(ARP_REQ_DELAY);
+
 		if (my_skb_head_push(skb, sizeof(*bcast_packet)) < 0)
 			goto dropped;
 
@@ -215,7 +220,7 @@ static int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 		bcast_packet->seqno =
 			htonl(atomic_inc_return(&bat_priv->bcast_seqno));
 
-		add_bcast_packet_to_list(bat_priv, skb, 1);
+		add_bcast_packet_to_list(bat_priv, skb, brd_delay);
 
 		/* a copy is stored in the bcast list, therefore removing
 		 * the original skb. */
@@ -229,6 +234,8 @@ static int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 				goto dropped;
 		}
 
+		dat_snoop_outgoing_arp_reply(bat_priv, skb);
+
 		ret = unicast_send_skb(skb, bat_priv);
 		if (ret != 0)
 			goto dropped_freed;
@@ -253,6 +260,7 @@ void interface_rx(struct net_device *soft_iface,
 		  int hdr_size)
 {
 	struct bat_priv *bat_priv = netdev_priv(soft_iface);
+	struct unicast_4addr_packet *unicast_4addr_packet;
 	struct ethhdr *ethhdr;
 	struct vlan_ethhdr *vhdr;
 	short vid __maybe_unused = -1;
@@ -261,6 +269,14 @@ void interface_rx(struct net_device *soft_iface,
 	if (!pskb_may_pull(skb, hdr_size))
 		goto dropped;
 
+	unicast_4addr_packet = (struct unicast_4addr_packet *)skb->data;
+
+	if (dat_snoop_incoming_arp_request(bat_priv, skb, hdr_size))
+		goto out;
+
+	if (dat_snoop_incoming_arp_reply(bat_priv, skb, hdr_size))
+		goto out;
+
 	skb_pull_rcsum(skb, hdr_size);
 	skb_reset_mac_header(skb);
 
-- 
1.7.3.4


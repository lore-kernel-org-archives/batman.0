Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Mon, 20 Aug 2012 13:48:09 +0200
Message-Id: <1345463292-19712-3-git-send-email-martin@hundeboll.net>
In-Reply-To: <1345463292-19712-1-git-send-email-martin@hundeboll.net>
References: <1345463292-19712-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC 2/5] batman-adv: Remove old fragmentation code
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

Remove the existing fragmentation code before adding the new version
and delete unicast.{h,c}.

batadv_unicast_send_skb() is moved to send.c and renamed to
batadv_send_skb_unicast().

fragmentation entry in sysfs (bat_priv->fragmentation) is kept for use in
the new fragmentation code.

BATADV_UNICAST_FRAG packet type is renamed to BATADV_FRAG for use in the
new fragmentation code.

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
---
 Makefile.kbuild  |   1 -
 main.c           |   2 -
 originator.c     |   9 --
 packet.h         |  18 +--
 routing.c        |  80 +-----------
 send.c           |  58 +++++++++
 send.h           |   1 +
 soft-interface.c |   3 +-
 unicast.c        | 373 -------------------------------------------------------
 unicast.h        |  58 ---------
 10 files changed, 62 insertions(+), 541 deletions(-)
 delete mode 100644 unicast.c
 delete mode 100644 unicast.h

diff --git a/Makefile.kbuild b/Makefile.kbuild
index 8676d2b..9d622ad 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -36,5 +36,4 @@ batman-adv-y += send.o
 batman-adv-y += soft-interface.o
 batman-adv-y += sysfs.o
 batman-adv-y += translation-table.o
-batman-adv-y += unicast.o
 batman-adv-y += vis.o
diff --git a/main.c b/main.c
index b4aa470..a93328f 100644
--- a/main.c
+++ b/main.c
@@ -276,8 +276,6 @@ static void batadv_recv_handler_init(void)
 	batadv_rx_handler[BATADV_ICMP] = batadv_recv_icmp_packet;
 	/* unicast packet */
 	batadv_rx_handler[BATADV_UNICAST] = batadv_recv_unicast_packet;
-	/* fragmented unicast packet */
-	batadv_rx_handler[BATADV_UNICAST_FRAG] = batadv_recv_ucast_frag_packet;
 	/* broadcast packet */
 	batadv_rx_handler[BATADV_BCAST] = batadv_recv_bcast_packet;
 	/* vis packet */
diff --git a/originator.c b/originator.c
index ac9bdf8..6ebf771 100644
--- a/originator.c
+++ b/originator.c
@@ -24,7 +24,6 @@
 #include "routing.h"
 #include "gateway_client.h"
 #include "hard-interface.h"
-#include "unicast.h"
 #include "soft-interface.h"
 #include "bridge_loop_avoidance.h"
 
@@ -138,7 +137,6 @@ static void batadv_orig_node_free_rcu(struct rcu_head *rcu)
 
 	spin_unlock_bh(&orig_node->neigh_list_lock);
 
-	batadv_frag_list_free(&orig_node->frag_list);
 	batadv_tt_global_del_orig(orig_node->bat_priv, orig_node,
 				  "originator timed out");
 
@@ -244,9 +242,6 @@ struct batadv_orig_node *batadv_get_orig_node(struct batadv_priv *bat_priv,
 	size = bat_priv->num_ifaces * sizeof(uint8_t);
 	orig_node->bcast_own_sum = kzalloc(size, GFP_ATOMIC);
 
-	INIT_LIST_HEAD(&orig_node->frag_list);
-	orig_node->last_frag_packet = 0;
-
 	if (!orig_node->bcast_own_sum)
 		goto free_bcast_own;
 
@@ -372,10 +367,6 @@ static void _batadv_purge_orig(struct batadv_priv *bat_priv)
 				batadv_orig_node_free_ref(orig_node);
 				continue;
 			}
-
-			if (batadv_has_timed_out(orig_node->last_frag_packet,
-						 BATADV_FRAG_TIMEOUT))
-				batadv_frag_list_free(&orig_node->frag_list);
 		}
 		spin_unlock_bh(list_lock);
 	}
diff --git a/packet.h b/packet.h
index 2d23a14..ce6e502 100644
--- a/packet.h
+++ b/packet.h
@@ -28,7 +28,7 @@ enum batadv_packettype {
 	BATADV_UNICAST	    = 0x03,
 	BATADV_BCAST	    = 0x04,
 	BATADV_VIS	    = 0x05,
-	BATADV_UNICAST_FRAG = 0x06,
+	BATADV_FRAG	    = 0x06,
 	BATADV_TT_QUERY	    = 0x07,
 	BATADV_ROAM_ADV	    = 0x08,
 };
@@ -58,12 +58,6 @@ enum batadv_vis_packettype {
 	BATADV_VIS_TYPE_CLIENT_UPDATE = 1,
 };
 
-/* fragmentation defines */
-enum batadv_unicast_frag_flags {
-	BATADV_UNI_FRAG_HEAD	  = BIT(0),
-	BATADV_UNI_FRAG_LARGETAIL = BIT(1),
-};
-
 /* TT_QUERY subtypes */
 #define BATADV_TT_QUERY_TYPE_MASK 0x3
 
@@ -161,16 +155,6 @@ struct batadv_unicast_packet {
 	uint8_t  dest[ETH_ALEN];
 } __packed;
 
-struct batadv_unicast_frag_packet {
-	struct batadv_header header;
-	uint8_t  ttvn; /* destination translation table version number */
-	uint8_t  dest[ETH_ALEN];
-	uint8_t  flags;
-	uint8_t  align;
-	uint8_t  orig[ETH_ALEN];
-	__be16   seqno;
-} __packed;
-
 struct batadv_bcast_packet {
 	struct batadv_header header;
 	uint8_t  reserved;
diff --git a/routing.c b/routing.c
index 53d991c..ca4847e 100644
--- a/routing.c
+++ b/routing.c
@@ -26,7 +26,6 @@
 #include "translation-table.h"
 #include "originator.h"
 #include "vis.h"
-#include "unicast.h"
 #include "bridge_loop_avoidance.h"
 
 static int batadv_route_unicast_packet(struct sk_buff *skb,
@@ -816,11 +815,9 @@ static int batadv_route_unicast_packet(struct sk_buff *skb,
 {
 	struct batadv_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	struct batadv_orig_node *orig_node = NULL;
-	struct batadv_neigh_node *neigh_node = NULL;
 	struct batadv_unicast_packet *unicast_packet;
 	struct ethhdr *ethhdr = (struct ethhdr *)skb_mac_header(skb);
 	int ret = NET_RX_DROP;
-	struct sk_buff *new_skb;
 
 	unicast_packet = (struct batadv_unicast_packet *)skb->data;
 
@@ -837,47 +834,12 @@ static int batadv_route_unicast_packet(struct sk_buff *skb,
 	if (!orig_node)
 		goto out;
 
-	/* find_router() increases neigh_nodes refcount if found. */
-	neigh_node = batadv_find_router(bat_priv, orig_node, recv_if);
-
-	if (!neigh_node)
-		goto out;
-
 	/* create a copy of the skb, if needed, to modify it. */
 	if (skb_cow(skb, ETH_HLEN) < 0)
 		goto out;
 
-	unicast_packet = (struct batadv_unicast_packet *)skb->data;
-
-	if (unicast_packet->header.packet_type == BATADV_UNICAST &&
-	    atomic_read(&bat_priv->fragmentation) &&
-	    skb->len > neigh_node->if_incoming->net_dev->mtu) {
-		ret = batadv_frag_send_skb(skb, bat_priv,
-					   neigh_node->if_incoming,
-					   neigh_node->addr);
-		goto out;
-	}
-
-	if (unicast_packet->header.packet_type == BATADV_UNICAST_FRAG &&
-	    batadv_frag_can_reassemble(skb,
-				       neigh_node->if_incoming->net_dev->mtu)) {
-
-		ret = batadv_frag_reassemble_skb(skb, bat_priv, &new_skb);
-
-		if (ret == NET_RX_DROP)
-			goto out;
-
-		/* packet was buffered for late merge */
-		if (!new_skb) {
-			ret = NET_RX_SUCCESS;
-			goto out;
-		}
-
-		skb = new_skb;
-		unicast_packet = (struct batadv_unicast_packet *)skb->data;
-	}
-
 	/* decrement ttl */
+	unicast_packet = (struct batadv_unicast_packet *)skb->data;
 	unicast_packet->header.ttl--;
 
 	/* Update stats counter */
@@ -890,8 +852,6 @@ static int batadv_route_unicast_packet(struct sk_buff *skb,
 		ret = NET_RX_SUCCESS;
 
 out:
-	if (neigh_node)
-		batadv_neigh_node_free_ref(neigh_node);
 	if (orig_node)
 		batadv_orig_node_free_ref(orig_node);
 	return ret;
@@ -1000,44 +960,6 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 	return batadv_route_unicast_packet(skb, recv_if);
 }
 
-int batadv_recv_ucast_frag_packet(struct sk_buff *skb,
-				  struct batadv_hard_iface *recv_if)
-{
-	struct batadv_priv *bat_priv = netdev_priv(recv_if->soft_iface);
-	struct batadv_unicast_frag_packet *unicast_packet;
-	int hdr_size = sizeof(*unicast_packet);
-	struct sk_buff *new_skb = NULL;
-	int ret;
-
-	if (batadv_check_unicast_packet(skb, hdr_size) < 0)
-		return NET_RX_DROP;
-
-	if (!batadv_check_unicast_ttvn(bat_priv, skb))
-		return NET_RX_DROP;
-
-	unicast_packet = (struct batadv_unicast_frag_packet *)skb->data;
-
-	/* packet for me */
-	if (batadv_is_my_mac(unicast_packet->dest)) {
-
-		ret = batadv_frag_reassemble_skb(skb, bat_priv, &new_skb);
-
-		if (ret == NET_RX_DROP)
-			return NET_RX_DROP;
-
-		/* packet was buffered for late merge */
-		if (!new_skb)
-			return NET_RX_SUCCESS;
-
-		batadv_interface_rx(recv_if->soft_iface, new_skb, recv_if,
-				    sizeof(struct batadv_unicast_packet), NULL);
-		return NET_RX_SUCCESS;
-	}
-
-	return batadv_route_unicast_packet(skb, recv_if);
-}
-
-
 int batadv_recv_bcast_packet(struct sk_buff *skb,
 			     struct batadv_hard_iface *recv_if)
 {
diff --git a/send.c b/send.c
index 4a6400f..f894903 100644
--- a/send.c
+++ b/send.c
@@ -25,6 +25,7 @@
 #include "hard-interface.h"
 #include "vis.h"
 #include "gateway_common.h"
+#include "gateway_client.h"
 #include "originator.h"
 
 static void batadv_send_outstanding_bcast_packet(struct work_struct *work);
@@ -97,6 +98,63 @@ bool batadv_send_skb_to_orig(struct sk_buff *skb,
 	return true;
 }
 
+int batadv_send_skb_unicast(struct batadv_priv *bat_priv, struct sk_buff *skb)
+{
+	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
+	struct batadv_unicast_packet *unicast_packet;
+	struct batadv_orig_node *orig_node;
+	int ret = NET_RX_DROP;
+
+	/* If the packet is and DHCP request and the gateway selection finds
+	 * a gateway, translation table lookup is skipped.
+	 * */
+	if (!is_multicast_ether_addr(ethhdr->h_dest) ||
+	    (orig_node = batadv_gw_get_selected_orig(bat_priv)) == NULL) {
+		/* check for tt host - increases orig_node refcount.
+		 * returns NULL in case of AP isolation and the packet is
+		 * eventually dropped.
+		 */
+		orig_node = batadv_transtable_search(bat_priv, ethhdr->h_source,
+						     ethhdr->h_dest);
+	}
+
+	if (!orig_node)
+		goto out;
+
+	if (batadv_skb_head_push(skb, sizeof(*unicast_packet)) < 0)
+		goto out;
+
+	unicast_packet = (struct batadv_unicast_packet *)skb->data;
+
+	unicast_packet->header.version = BATADV_COMPAT_VERSION;
+	/* batman packet type: unicast */
+	unicast_packet->header.packet_type = BATADV_UNICAST;
+	/* set unicast ttl */
+	unicast_packet->header.ttl = BATADV_TTL;
+	/* copy the destination for faster routing */
+	memcpy(unicast_packet->dest, orig_node->orig, ETH_ALEN);
+	/* set the destination tt version number */
+	unicast_packet->ttvn = (uint8_t)atomic_read(&orig_node->last_ttvn);
+
+	/* inform the destination node that we are still missing a correct route
+	 * for this client. The destination will receive this packet and will
+	 * try to reroute it because the ttvn contained in the header is less
+	 * than the current one
+	 */
+	if (batadv_tt_global_client_is_roaming(bat_priv, ethhdr->h_dest))
+		unicast_packet->ttvn = unicast_packet->ttvn - 1;
+
+	if (batadv_send_skb_to_orig(skb, orig_node, NULL))
+		ret = NET_RX_SUCCESS;
+
+out:
+	if (orig_node)
+		batadv_orig_node_free_ref(orig_node);
+	if (ret == NET_RX_DROP)
+		kfree_skb(skb);
+	return ret;
+}
+
 void batadv_schedule_bat_ogm(struct batadv_hard_iface *hard_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
diff --git a/send.h b/send.h
index 0078dec..2e2b880 100644
--- a/send.h
+++ b/send.h
@@ -26,6 +26,7 @@ int batadv_send_skb_packet(struct sk_buff *skb,
 bool batadv_send_skb_to_orig(struct sk_buff *skb,
 			     struct batadv_orig_node *orig_node,
 			     struct batadv_hard_iface *recv_if);
+int batadv_send_skb_unicast(struct batadv_priv *bat_priv, struct sk_buff *skb);
 void batadv_schedule_bat_ogm(struct batadv_hard_iface *hard_iface);
 int batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
 				    const struct sk_buff *skb,
diff --git a/soft-interface.c b/soft-interface.c
index 1aee7db..fbec8a4 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -33,7 +33,6 @@
 #include <linux/ethtool.h>
 #include <linux/etherdevice.h>
 #include <linux/if_vlan.h>
-#include "unicast.h"
 #include "bridge_loop_avoidance.h"
 
 
@@ -249,7 +248,7 @@ static int batadv_interface_tx(struct sk_buff *skb,
 				goto dropped;
 		}
 
-		ret = batadv_unicast_send_skb(skb, bat_priv);
+		ret = batadv_send_skb_unicast(bat_priv, skb);
 		if (ret != 0)
 			goto dropped_freed;
 	}
diff --git a/unicast.c b/unicast.c
deleted file mode 100644
index add5d1f..0000000
--- a/unicast.c
+++ /dev/null
@@ -1,373 +0,0 @@
-/* Copyright (C) 2010-2012 B.A.T.M.A.N. contributors:
- *
- * Andreas Langer
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- */
-
-#include "main.h"
-#include "unicast.h"
-#include "send.h"
-#include "soft-interface.h"
-#include "gateway_client.h"
-#include "originator.h"
-#include "hash.h"
-#include "translation-table.h"
-#include "routing.h"
-#include "hard-interface.h"
-
-
-static struct sk_buff *
-batadv_frag_merge_packet(struct list_head *head,
-			 struct batadv_frag_packet_list_entry *tfp,
-			 struct sk_buff *skb)
-{
-	struct batadv_unicast_frag_packet *up;
-	struct sk_buff *tmp_skb;
-	struct batadv_unicast_packet *unicast_packet;
-	int hdr_len = sizeof(*unicast_packet);
-	int uni_diff = sizeof(*up) - hdr_len;
-	uint8_t *packet_pos;
-
-	up = (struct batadv_unicast_frag_packet *)skb->data;
-	/* set skb to the first part and tmp_skb to the second part */
-	if (up->flags & BATADV_UNI_FRAG_HEAD) {
-		tmp_skb = tfp->skb;
-	} else {
-		tmp_skb = skb;
-		skb = tfp->skb;
-	}
-
-	if (skb_linearize(skb) < 0 || skb_linearize(tmp_skb) < 0)
-		goto err;
-
-	skb_pull(tmp_skb, sizeof(*up));
-	if (pskb_expand_head(skb, 0, tmp_skb->len, GFP_ATOMIC) < 0)
-		goto err;
-
-	/* move free entry to end */
-	tfp->skb = NULL;
-	tfp->seqno = 0;
-	list_move_tail(&tfp->list, head);
-
-	memcpy(skb_put(skb, tmp_skb->len), tmp_skb->data, tmp_skb->len);
-	kfree_skb(tmp_skb);
-
-	memmove(skb->data + uni_diff, skb->data, hdr_len);
-	packet_pos = skb_pull(skb, uni_diff);
-	unicast_packet = (struct batadv_unicast_packet *)packet_pos;
-	unicast_packet->header.packet_type = BATADV_UNICAST;
-
-	return skb;
-
-err:
-	/* free buffered skb, skb will be freed later */
-	kfree_skb(tfp->skb);
-	return NULL;
-}
-
-static void batadv_frag_create_entry(struct list_head *head,
-				     struct sk_buff *skb)
-{
-	struct batadv_frag_packet_list_entry *tfp;
-	struct batadv_unicast_frag_packet *up;
-
-	up = (struct batadv_unicast_frag_packet *)skb->data;
-
-	/* free and oldest packets stand at the end */
-	tfp = list_entry((head)->prev, typeof(*tfp), list);
-	kfree_skb(tfp->skb);
-
-	tfp->seqno = ntohs(up->seqno);
-	tfp->skb = skb;
-	list_move(&tfp->list, head);
-	return;
-}
-
-static int batadv_frag_create_buffer(struct list_head *head)
-{
-	int i;
-	struct batadv_frag_packet_list_entry *tfp;
-
-	for (i = 0; i < BATADV_FRAG_BUFFER_SIZE; i++) {
-		tfp = kmalloc(sizeof(*tfp), GFP_ATOMIC);
-		if (!tfp) {
-			batadv_frag_list_free(head);
-			return -ENOMEM;
-		}
-		tfp->skb = NULL;
-		tfp->seqno = 0;
-		INIT_LIST_HEAD(&tfp->list);
-		list_add(&tfp->list, head);
-	}
-
-	return 0;
-}
-
-static struct batadv_frag_packet_list_entry *
-batadv_frag_search_packet(struct list_head *head,
-			  const struct batadv_unicast_frag_packet *up)
-{
-	struct batadv_frag_packet_list_entry *tfp;
-	struct batadv_unicast_frag_packet *tmp_up = NULL;
-	int is_head_tmp, is_head;
-	uint16_t search_seqno;
-
-	if (up->flags & BATADV_UNI_FRAG_HEAD)
-		search_seqno = ntohs(up->seqno)+1;
-	else
-		search_seqno = ntohs(up->seqno)-1;
-
-	is_head = !!(up->flags & BATADV_UNI_FRAG_HEAD);
-
-	list_for_each_entry(tfp, head, list) {
-
-		if (!tfp->skb)
-			continue;
-
-		if (tfp->seqno == ntohs(up->seqno))
-			goto mov_tail;
-
-		tmp_up = (struct batadv_unicast_frag_packet *)tfp->skb->data;
-
-		if (tfp->seqno == search_seqno) {
-			is_head_tmp = !!(tmp_up->flags & BATADV_UNI_FRAG_HEAD);
-			if (is_head_tmp != is_head)
-				return tfp;
-			else
-				goto mov_tail;
-		}
-	}
-	return NULL;
-
-mov_tail:
-	list_move_tail(&tfp->list, head);
-	return NULL;
-}
-
-void batadv_frag_list_free(struct list_head *head)
-{
-	struct batadv_frag_packet_list_entry *pf, *tmp_pf;
-
-	if (!list_empty(head)) {
-
-		list_for_each_entry_safe(pf, tmp_pf, head, list) {
-			kfree_skb(pf->skb);
-			list_del(&pf->list);
-			kfree(pf);
-		}
-	}
-	return;
-}
-
-/* frag_reassemble_skb():
- * returns NET_RX_DROP if the operation failed - skb is left intact
- * returns NET_RX_SUCCESS if the fragment was buffered (skb_new will be NULL)
- * or the skb could be reassembled (skb_new will point to the new packet and
- * skb was freed)
- */
-int batadv_frag_reassemble_skb(struct sk_buff *skb,
-			       struct batadv_priv *bat_priv,
-			       struct sk_buff **new_skb)
-{
-	struct batadv_orig_node *orig_node;
-	struct batadv_frag_packet_list_entry *tmp_frag_entry;
-	int ret = NET_RX_DROP;
-	struct batadv_unicast_frag_packet *unicast_packet;
-
-	unicast_packet = (struct batadv_unicast_frag_packet *)skb->data;
-	*new_skb = NULL;
-
-	orig_node = batadv_orig_hash_find(bat_priv, unicast_packet->orig);
-	if (!orig_node)
-		goto out;
-
-	orig_node->last_frag_packet = jiffies;
-
-	if (list_empty(&orig_node->frag_list) &&
-	    batadv_frag_create_buffer(&orig_node->frag_list)) {
-		pr_debug("couldn't create frag buffer\n");
-		goto out;
-	}
-
-	tmp_frag_entry = batadv_frag_search_packet(&orig_node->frag_list,
-						   unicast_packet);
-
-	if (!tmp_frag_entry) {
-		batadv_frag_create_entry(&orig_node->frag_list, skb);
-		ret = NET_RX_SUCCESS;
-		goto out;
-	}
-
-	*new_skb = batadv_frag_merge_packet(&orig_node->frag_list,
-					    tmp_frag_entry, skb);
-	/* if not, merge failed */
-	if (*new_skb)
-		ret = NET_RX_SUCCESS;
-
-out:
-	if (orig_node)
-		batadv_orig_node_free_ref(orig_node);
-	return ret;
-}
-
-int batadv_frag_send_skb(struct sk_buff *skb, struct batadv_priv *bat_priv,
-			 struct batadv_hard_iface *hard_iface,
-			 const uint8_t dstaddr[])
-{
-	struct batadv_unicast_packet tmp_uc, *unicast_packet;
-	struct batadv_hard_iface *primary_if;
-	struct sk_buff *frag_skb;
-	struct batadv_unicast_frag_packet *frag1, *frag2;
-	int uc_hdr_len = sizeof(*unicast_packet);
-	int ucf_hdr_len = sizeof(*frag1);
-	int data_len = skb->len - uc_hdr_len;
-	int large_tail = 0, ret = NET_RX_DROP;
-	uint16_t seqno;
-
-	primary_if = batadv_primary_if_get_selected(bat_priv);
-	if (!primary_if)
-		goto dropped;
-
-	frag_skb = dev_alloc_skb(data_len - (data_len / 2) + ucf_hdr_len);
-	if (!frag_skb)
-		goto dropped;
-	skb_reserve(frag_skb, ucf_hdr_len);
-
-	unicast_packet = (struct batadv_unicast_packet *)skb->data;
-	memcpy(&tmp_uc, unicast_packet, uc_hdr_len);
-	skb_split(skb, frag_skb, data_len / 2 + uc_hdr_len);
-
-	if (batadv_skb_head_push(skb, ucf_hdr_len - uc_hdr_len) < 0 ||
-	    batadv_skb_head_push(frag_skb, ucf_hdr_len) < 0)
-		goto drop_frag;
-
-	frag1 = (struct batadv_unicast_frag_packet *)skb->data;
-	frag2 = (struct batadv_unicast_frag_packet *)frag_skb->data;
-
-	memcpy(frag1, &tmp_uc, sizeof(tmp_uc));
-
-	frag1->header.ttl--;
-	frag1->header.version = BATADV_COMPAT_VERSION;
-	frag1->header.packet_type = BATADV_UNICAST_FRAG;
-
-	memcpy(frag1->orig, primary_if->net_dev->dev_addr, ETH_ALEN);
-	memcpy(frag2, frag1, sizeof(*frag2));
-
-	if (data_len & 1)
-		large_tail = BATADV_UNI_FRAG_LARGETAIL;
-
-	frag1->flags = BATADV_UNI_FRAG_HEAD | large_tail;
-	frag2->flags = large_tail;
-
-	seqno = atomic_add_return(2, &hard_iface->frag_seqno);
-	frag1->seqno = htons(seqno - 1);
-	frag2->seqno = htons(seqno);
-
-	batadv_send_skb_packet(skb, hard_iface, dstaddr);
-	batadv_send_skb_packet(frag_skb, hard_iface, dstaddr);
-	ret = NET_RX_SUCCESS;
-	goto out;
-
-drop_frag:
-	kfree_skb(frag_skb);
-dropped:
-	kfree_skb(skb);
-out:
-	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
-	return ret;
-}
-
-int batadv_unicast_send_skb(struct sk_buff *skb, struct batadv_priv *bat_priv)
-{
-	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
-	struct batadv_unicast_packet *unicast_packet;
-	struct batadv_orig_node *orig_node;
-	struct batadv_neigh_node *neigh_node;
-	int data_len = skb->len;
-	int ret = NET_RX_DROP;
-	unsigned int dev_mtu;
-
-	/* get routing information */
-	if (is_multicast_ether_addr(ethhdr->h_dest)) {
-		orig_node = batadv_gw_get_selected_orig(bat_priv);
-		if (orig_node)
-			goto find_router;
-	}
-
-	/* check for tt host - increases orig_node refcount.
-	 * returns NULL in case of AP isolation
-	 */
-	orig_node = batadv_transtable_search(bat_priv, ethhdr->h_source,
-					     ethhdr->h_dest);
-
-find_router:
-	/* find_router():
-	 *  - if orig_node is NULL it returns NULL
-	 *  - increases neigh_nodes refcount if found.
-	 */
-	neigh_node = batadv_find_router(bat_priv, orig_node, NULL);
-
-	if (!neigh_node)
-		goto out;
-
-	if (batadv_skb_head_push(skb, sizeof(*unicast_packet)) < 0)
-		goto out;
-
-	unicast_packet = (struct batadv_unicast_packet *)skb->data;
-
-	unicast_packet->header.version = BATADV_COMPAT_VERSION;
-	/* batman packet type: unicast */
-	unicast_packet->header.packet_type = BATADV_UNICAST;
-	/* set unicast ttl */
-	unicast_packet->header.ttl = BATADV_TTL;
-	/* copy the destination for faster routing */
-	memcpy(unicast_packet->dest, orig_node->orig, ETH_ALEN);
-	/* set the destination tt version number */
-	unicast_packet->ttvn = (uint8_t)atomic_read(&orig_node->last_ttvn);
-
-	/* inform the destination node that we are still missing a correct route
-	 * for this client. The destination will receive this packet and will
-	 * try to reroute it because the ttvn contained in the header is less
-	 * than the current one
-	 */
-	if (batadv_tt_global_client_is_roaming(bat_priv, ethhdr->h_dest))
-		unicast_packet->ttvn = unicast_packet->ttvn - 1;
-
-	dev_mtu = neigh_node->if_incoming->net_dev->mtu;
-	if (atomic_read(&bat_priv->fragmentation) &&
-	    data_len + sizeof(*unicast_packet) > dev_mtu) {
-		/* send frag skb decreases ttl */
-		unicast_packet->header.ttl++;
-		ret = batadv_frag_send_skb(skb, bat_priv,
-					   neigh_node->if_incoming,
-					   neigh_node->addr);
-		goto out;
-	}
-
-
-	if (batadv_send_skb_to_orig(skb, orig_node, NULL))
-		ret = NET_RX_SUCCESS;
-
-out:
-	if (neigh_node)
-		batadv_neigh_node_free_ref(neigh_node);
-	if (orig_node)
-		batadv_orig_node_free_ref(orig_node);
-	if (ret == NET_RX_DROP)
-		kfree_skb(skb);
-	return ret;
-}
diff --git a/unicast.h b/unicast.h
deleted file mode 100644
index 1c46e2e..0000000
--- a/unicast.h
+++ /dev/null
@@ -1,58 +0,0 @@
-/* Copyright (C) 2010-2012 B.A.T.M.A.N. contributors:
- *
- * Andreas Langer
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- */
-
-#ifndef _NET_BATMAN_ADV_UNICAST_H_
-#define _NET_BATMAN_ADV_UNICAST_H_
-
-#include "packet.h"
-
-#define BATADV_FRAG_TIMEOUT 10000 /* purge frag list entries after time in ms */
-#define BATADV_FRAG_BUFFER_SIZE 6 /* number of list elements in buffer */
-
-int batadv_frag_reassemble_skb(struct sk_buff *skb,
-			       struct batadv_priv *bat_priv,
-			       struct sk_buff **new_skb);
-void batadv_frag_list_free(struct list_head *head);
-int batadv_unicast_send_skb(struct sk_buff *skb, struct batadv_priv *bat_priv);
-int batadv_frag_send_skb(struct sk_buff *skb, struct batadv_priv *bat_priv,
-			 struct batadv_hard_iface *hard_iface,
-			 const uint8_t dstaddr[]);
-
-static inline int batadv_frag_can_reassemble(const struct sk_buff *skb, int mtu)
-{
-	const struct batadv_unicast_frag_packet *unicast_packet;
-	int uneven_correction = 0;
-	unsigned int merged_size;
-
-	unicast_packet = (struct batadv_unicast_frag_packet *)skb->data;
-
-	if (unicast_packet->flags & BATADV_UNI_FRAG_LARGETAIL) {
-		if (unicast_packet->flags & BATADV_UNI_FRAG_HEAD)
-			uneven_correction = 1;
-		else
-			uneven_correction = -1;
-	}
-
-	merged_size = (skb->len - sizeof(*unicast_packet)) * 2;
-	merged_size += sizeof(struct batadv_unicast_packet) + uneven_correction;
-
-	return merged_size <= mtu;
-}
-
-#endif /* _NET_BATMAN_ADV_UNICAST_H_ */
-- 
1.7.11.5


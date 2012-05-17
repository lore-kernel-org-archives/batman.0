Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 17 May 2012 17:18:33 +0200
Message-Id: <1337267913-14693-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Revert Distributed ARP Table
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

David S. Miller did not like the idea of batman-adv modifying and reading the
ARP table and refused to pull this feature. It has to be rewritten after an
acceptable solution was found.

This reverts following commits:
 * batman-adv: add UNICAST_4ADDR packet type
 * batman-adv: add a new log level for DAT debugging
 * batman-adv: Distributed ARP Table - create DHT helper functions
 * batman-adv: Distributed ARP Table - add ARP parsing functions
 * batman-adv: Distributed ARP Table - add snooping functions for ARP messages
 * batman-adv: Distributed ARP Table - increase default soft_iface ARP table timeout
 * batman-adv: Distributed ARP Table - add compile option

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
This patch is for next... I repeat: this patch is for the branch next

 Makefile                |    2 -
 Makefile.kbuild         |    1 -
 README                  |    3 +-
 README.external         |    1 -
 bat_sysfs.c             |    2 +-
 distributed-arp-table.c |  605 -----------------------------------------------
 distributed-arp-table.h |  140 -----------
 gen-compat-autoconf.sh  |    1 -
 hard-interface.c        |    3 -
 main.c                  |    2 -
 main.h                  |   15 +-
 originator.c            |    2 -
 packet.h                |   30 +--
 routing.c               |    8 +-
 send.c                  |    4 -
 soft-interface.c        |   17 +-
 types.h                 |   22 --
 unicast.c               |  101 ++------
 unicast.h               |   21 +-
 19 files changed, 33 insertions(+), 947 deletions(-)
 delete mode 100644 distributed-arp-table.c
 delete mode 100644 distributed-arp-table.h

diff --git a/Makefile b/Makefile
index ac84fba..08f8c39 100644
--- a/Makefile
+++ b/Makefile
@@ -23,8 +23,6 @@
 export CONFIG_BATMAN_ADV_DEBUG=n
 # B.A.T.M.A.N. bridge loop avoidance:
 export CONFIG_BATMAN_ADV_BLA=y
-# B.A.T.M.A.N. distributed ARP table:
-export CONFIG_BATMAN_ADV_DAT=y
 
 PWD:=$(shell pwd)
 KERNELPATH ?= /lib/modules/$(shell uname -r)/build
diff --git a/Makefile.kbuild b/Makefile.kbuild
index ad002cd..6d5c194 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -24,7 +24,6 @@ batman-adv-y += bat_iv_ogm.o
 batman-adv-y += bat_sysfs.o
 batman-adv-y += bitarray.o
 batman-adv-$(CONFIG_BATMAN_ADV_BLA) += bridge_loop_avoidance.o
-batman-adv-$(CONFIG_BATMAN_ADV_DAT) += distributed-arp-table.o
 batman-adv-y += gateway_client.o
 batman-adv-y += gateway_common.o
 batman-adv-y += hard-interface.o
diff --git a/README b/README
index 82c075f..75a5923 100644
--- a/README
+++ b/README
@@ -202,8 +202,7 @@ abled  during run time. Following log_levels are defined:
 2 - Enable messages related to route added / changed / deleted
 4 - Enable messages related to translation table operations
 8 - Enable messages related to bridge loop avoidance
-16 - Enable messaged related to DAT, ARP snooping and parsing
-31 - Enable all messages
+15 - enable all messages
 
 The debug output can be changed at runtime  using  the  file
 /sys/class/net/bat0/mesh/log_level. e.g.
diff --git a/README.external b/README.external
index 874ee7f..da5afd4 100644
--- a/README.external
+++ b/README.external
@@ -37,7 +37,6 @@ module).  Available  options  and  their    possible   values are
 
  * CONFIG_BATMAN_ADV_DEBUG=[y|n*] (B.A.T.M.A.N. debugging)
  * CONFIG_BATMAN_ADV_BLA=[y*|n] (B.A.T.M.A.N. bridge loop avoidance)
- * CONFIG_BATMAN_ADV_DAT=[y*|n] (B.A.T.M.A.N. Distributed ARP Table)
 
 e.g., debugging can be enabled by
 
diff --git a/bat_sysfs.c b/bat_sysfs.c
index acb2640..5bc7b66 100644
--- a/bat_sysfs.c
+++ b/bat_sysfs.c
@@ -445,7 +445,7 @@ BAT_ATTR_SIF_UINT(gw_sel_class, S_IRUGO | S_IWUSR, 1, TQ_MAX_VALUE,
 static BAT_ATTR(gw_bandwidth, S_IRUGO | S_IWUSR, show_gw_bwidth,
 		store_gw_bwidth);
 #ifdef CONFIG_BATMAN_ADV_DEBUG
-BAT_ATTR_SIF_UINT(log_level, S_IRUGO | S_IWUSR, 0, 31, NULL);
+BAT_ATTR_SIF_UINT(log_level, S_IRUGO | S_IWUSR, 0, 15, NULL);
 #endif
 
 static struct bat_attribute *mesh_attrs[] = {
diff --git a/distributed-arp-table.c b/distributed-arp-table.c
deleted file mode 100644
index 6935be9..0000000
--- a/distributed-arp-table.c
+++ /dev/null
@@ -1,605 +0,0 @@
-/*
- * Copyright (C) 2011-2012 B.A.T.M.A.N. contributors:
- *
- * Antonio Quartulli
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
- *
- */
-
-#include <linux/if_ether.h>
-#include <linux/if_arp.h>
-/* needed to use arp_tbl */
-#include <net/arp.h>
-#include <linux/inetdevice.h>
-
-#include "main.h"
-#include "distributed-arp-table.h"
-#include "hard-interface.h"
-#include "originator.h"
-#include "send.h"
-#include "types.h"
-#include "translation-table.h"
-#include "unicast.h"
-
-#ifdef CONFIG_BATMAN_ADV_DEBUG
-
-static void bat_dbg_arp(struct bat_priv *bat_priv, struct sk_buff *skb,
-			uint16_t type, int hdr_size, char *msg)
-{
-	struct unicast_4addr_packet *unicast_4addr_packet;
-
-	if (msg)
-		bat_dbg(DBG_DAT, bat_priv, "%s\n", msg);
-
-	bat_dbg(DBG_DAT, bat_priv, "ARP MSG = [src: %pM-%pI4 dst: %pM-%pI4]\n",
-		ARP_HW_SRC(skb, hdr_size), &ARP_IP_SRC(skb, hdr_size),
-		ARP_HW_DST(skb, hdr_size), &ARP_IP_DST(skb, hdr_size));
-
-	if (hdr_size == 0)
-		return;
-
-	/* if the AP packet is encapsulated in a batman packet, let's print some
-	 * debug messages
-	 */
-	unicast_4addr_packet = (struct unicast_4addr_packet *)skb->data;
-
-	switch (unicast_4addr_packet->u.header.packet_type) {
-	case BAT_UNICAST:
-		bat_dbg(DBG_DAT, bat_priv,
-			"* encapsulated within a UNICAST packet\n");
-		break;
-	case BAT_UNICAST_4ADDR:
-		bat_dbg(DBG_DAT, bat_priv,
-			"* encapsulated within a UNICAST_4ADDR packet (src: %pM)\n",
-			unicast_4addr_packet->src);
-		switch (unicast_4addr_packet->subtype) {
-		case BAT_P_DAT_DHT_PUT:
-			bat_dbg(DBG_DAT, bat_priv, "* type: DAT_DHT_PUT\n");
-			break;
-		case BAT_P_DAT_DHT_GET:
-			bat_dbg(DBG_DAT, bat_priv, "* type: DAT_DHT_GET\n");
-			break;
-		case BAT_P_DAT_CACHE_REPLY:
-			bat_dbg(DBG_DAT, bat_priv, "* type: DAT_CACHE_REPLY\n");
-			break;
-		case BAT_P_DATA:
-			bat_dbg(DBG_DAT, bat_priv, "* type: DATA\n");
-			break;
-		default:
-			bat_dbg(DBG_DAT, bat_priv, "* type: Unknown!\n");
-		}
-		break;
-	case BAT_BCAST:
-		bat_dbg(DBG_DAT, bat_priv,
-			"* encapsulated within a BCAST packet (src: %pM)\n",
-			((struct bcast_packet *)unicast_4addr_packet)->orig);
-		break;
-	default:
-		bat_dbg(DBG_DAT, bat_priv,
-			"* encapsulated within an unknown packet type (0x%x)\n",
-			unicast_4addr_packet->u.header.packet_type);
-	}
-}
-
-#else
-
-static void bat_dbg_arp(struct bat_priv *bat_priv, struct sk_buff *skb,
-			uint16_t type, int hdr_size, char *msg)
-{
-}
-
-#endif /* CONFIG_BATMAN_ADV_DEBUG */
-
-static bool is_orig_node_eligible(struct dht_candidate *res, int select,
-				  dat_addr_t tmp_max, dat_addr_t max,
-				  dat_addr_t last_max,
-				  struct orig_node *candidate,
-				  struct orig_node *max_orig_node)
-{
-	bool ret = false;
-	int j;
-
-	/* Check if we have already selected this neighbour... */
-	for (j = 0; j < select; j++)
-		if (res[j].orig_node == candidate)
-			break;
-	/* ..and possibly skip it */
-	if (j < select)
-		goto out;
-	/* sanity check: has it already been selected? This should not happen */
-	if (tmp_max > last_max)
-		goto out;
-	/* check if during this iteration we have already found an originator
-	 * with a closer dht address
-	 */
-	if (tmp_max < max)
-		goto out;
-	/* this is an hash collision with the temporary selected node. Choose
-	 * the one with the lowest address
-	 */
-	if ((tmp_max == max) &&
-	    (compare_eth(candidate->orig, max_orig_node->orig) > 0))
-		goto out;
-
-	ret = true;
-out:
-	return ret;
-}
-
-/* selects the next candidate by populating cands[select] and modifies last_max
- * accordingly
- */
-static void choose_next_candidate(struct bat_priv *bat_priv,
-				  struct dht_candidate *cands, int select,
-				  dat_addr_t ip_key, dat_addr_t *last_max)
-{
-	dat_addr_t max = 0, tmp_max = 0;
-	struct orig_node *orig_node, *max_orig_node = NULL;
-	struct hashtable_t *hash = bat_priv->orig_hash;
-	struct hlist_node *node;
-	struct hlist_head *head;
-	int i;
-
-	/* if no node is eligible as candidate, we will leave the candidate as
-	 * NOT_FOUND
-	 */
-	cands[select].type = DHT_CANDIDATE_NOT_FOUND;
-
-	/* iterate over the originator list and find the node with closest
-	 * dht_address which has not been selected yet
-	 */
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
-
-		rcu_read_lock();
-		hlist_for_each_entry_rcu(orig_node, node, head, hash_entry) {
-			/* the dht space is a ring and addresses are unsigned */
-			tmp_max = DAT_ADDR_MAX - orig_node->dht_addr + ip_key;
-
-			if (!is_orig_node_eligible(cands, select, tmp_max, max,
-						   *last_max, orig_node,
-						   max_orig_node))
-				continue;
-
-			if (!atomic_inc_not_zero(&orig_node->refcount))
-				continue;
-
-			max = tmp_max;
-			if (max_orig_node)
-				orig_node_free_ref(max_orig_node);
-			max_orig_node = orig_node;
-		}
-		rcu_read_unlock();
-	}
-	if (max_orig_node) {
-		cands[select].type = DHT_CANDIDATE_ORIG;
-		cands[select].orig_node = max_orig_node;
-		bat_dbg(DBG_DAT, bat_priv,
-			"dht_select_candidates() %d: selected %pM addr=%u dist=%u\n",
-			select, max_orig_node->orig, max_orig_node->dht_addr,
-			max);
-	}
-	*last_max = max;
-}
-
-/* Given a key, selects the candidates which the DHT message has to be sent to.
- * An originator O is selected if and only if its DHT_ID value is one of three
- * closest values (from the LEFT, with wrap around if needed) then the hash
- * value of the key. ip_dst is the key.
- *
- * return an array of size DHT_CANDIDATES_NUM
- */
-static struct dht_candidate *dht_select_candidates(struct bat_priv *bat_priv,
-						   uint32_t ip_dst)
-{
-	int select;
-	dat_addr_t last_max = DAT_ADDR_MAX, ip_key;
-	struct dht_candidate *res;
-
-	if (!bat_priv->orig_hash)
-		return NULL;
-
-	res = kmalloc(DHT_CANDIDATES_NUM * sizeof(*res), GFP_ATOMIC);
-	if (!res)
-		return NULL;
-
-	ip_key = (dat_addr_t)hash_ipv4(&ip_dst, DAT_ADDR_MAX);
-
-	bat_dbg(DBG_DAT, bat_priv,
-		"dht_select_candidates(): IP=%pI4 hash(IP)=%u\n", &ip_dst,
-		ip_key);
-
-	for (select = 0; select < DHT_CANDIDATES_NUM; select++)
-		choose_next_candidate(bat_priv, res, select, ip_key, &last_max);
-
-	return res;
-}
-
-/* Sends the skb payload passed as argument to the candidates selected for
- * the data represented by 'ip'. The skb is copied by means of pskb_copy()
- * and is sent as unicast packet to each of the selected candidate.
- *
- * If the packet is successfully sent to at least one candidate, then this
- * function returns true
- */
-static bool dht_send_data(struct bat_priv *bat_priv, struct sk_buff *skb,
-			  uint32_t ip, int packet_subtype)
-{
-	int i;
-	bool ret = false;
-	struct neigh_node *neigh_node = NULL;
-	struct sk_buff *tmp_skb;
-	struct dht_candidate *cand = dht_select_candidates(bat_priv, ip);
-
-	if (!cand)
-		goto out;
-
-	bat_dbg(DBG_DAT, bat_priv, "DHT_SEND for %pI4\n", &ip);
-
-	for (i = 0; i < DHT_CANDIDATES_NUM; i++) {
-		if (cand[i].type == DHT_CANDIDATE_NOT_FOUND)
-			continue;
-
-		neigh_node = orig_node_get_router(cand[i].orig_node);
-		if (!neigh_node)
-			goto free_orig;
-
-		tmp_skb = pskb_copy(skb, GFP_ATOMIC);
-		if (!prepare_unicast_4addr_packet(bat_priv, tmp_skb,
-						  cand[i].orig_node,
-						  packet_subtype)) {
-			kfree_skb(tmp_skb);
-			goto free_neigh;
-		}
-		if (send_skb_packet(tmp_skb, neigh_node->if_incoming,
-				    neigh_node->addr) == NET_XMIT_SUCCESS)
-			/* packet sent to a candidate: we can return true */
-			ret = true;
-free_neigh:
-		neigh_node_free_ref(neigh_node);
-free_orig:
-		orig_node_free_ref(cand[i].orig_node);
-	}
-
-out:
-	kfree(cand);
-	return ret;
-}
-
-/* Update the neighbour entry corresponding to the IP passed as parameter with
- * the hw address hw. If the neighbour entry doesn't exists, then it will be
- * created
- */
-static void arp_neigh_update(struct bat_priv *bat_priv, uint32_t ip,
-			     uint8_t *hw)
-{
-	struct neighbour *n = NULL;
-	struct hard_iface *primary_if = primary_if_get_selected(bat_priv);
-	if (!primary_if)
-		goto out;
-
-	n = __neigh_lookup(&arp_tbl, &ip, primary_if->soft_iface, 1);
-	if (!n)
-		goto out;
-
-	bat_dbg(DBG_DAT, bat_priv, "Updating neighbour: %pI4 - %pM\n", &ip, hw);
-
-	neigh_update(n, hw, NUD_REACHABLE, NEIGH_UPDATE_F_OVERRIDE);
-out:
-	if (n && !IS_ERR(n))
-		neigh_release(n);
-	if (primary_if)
-		hardif_free_ref(primary_if);
-}
-
-/* Returns arphdr->ar_op if the skb contains a valid ARP packet, otherwise
- * returns 0
- */
-static uint16_t arp_get_type(struct bat_priv *bat_priv, struct sk_buff *skb,
-			     int hdr_size)
-{
-	struct arphdr *arphdr;
-	struct ethhdr *ethhdr;
-	uint32_t ip_src, ip_dst;
-	uint16_t type = 0;
-
-	/* pull the ethernet header */
-	if (unlikely(!pskb_may_pull(skb, hdr_size + ETH_HLEN)))
-		goto out;
-
-	ethhdr = (struct ethhdr *)(skb->data + hdr_size);
-
-	if (ethhdr->h_proto != htons(ETH_P_ARP))
-		goto out;
-
-	/* pull the ARP payload */
-	if (unlikely(!pskb_may_pull(skb, hdr_size + ETH_HLEN +
-				    arp_hdr_len(skb->dev))))
-		goto out;
-
-	arphdr = (struct arphdr *)(skb->data + hdr_size + ETH_HLEN);
-
-	/* Check whether the ARP packet carries a valid
-	 * IP information */
-	if (arphdr->ar_hrd != htons(ARPHRD_ETHER))
-		goto out;
-
-	if (arphdr->ar_pro != htons(ETH_P_IP))
-		goto out;
-
-	if (arphdr->ar_hln != ETH_ALEN)
-		goto out;
-
-	if (arphdr->ar_pln != 4)
-		goto out;
-
-	/* Check for bad reply/request. If the ARP message is not sane, DAT
-	 * will simply ignore it */
-	ip_src = ARP_IP_SRC(skb, hdr_size);
-	ip_dst = ARP_IP_DST(skb, hdr_size);
-	if (ipv4_is_loopback(ip_src) || ipv4_is_multicast(ip_src) ||
-	    ipv4_is_loopback(ip_dst) || ipv4_is_multicast(ip_dst))
-		goto out;
-
-	type = ntohs(arphdr->ar_op);
-out:
-	return type;
-}
-
-/* return true if the message has been sent to the dht candidates, false
- * otherwise. In case of true the message has to be enqueued to permit the
- * fallback
- */
-bool dat_snoop_outgoing_arp_request(struct bat_priv *bat_priv,
-				    struct sk_buff *skb)
-{
-	uint16_t type = 0;
-	uint32_t ip_dst, ip_src;
-	uint8_t *hw_src;
-	bool ret = false;
-	struct neighbour *n = NULL;
-	struct hard_iface *primary_if = NULL;
-	struct sk_buff *skb_new;
-
-	type = arp_get_type(bat_priv, skb, 0);
-	/* If we get an ARP_REQUEST we have to send the unicast message to the
-	 * selected DHT candidates
-	 */
-	if (type != ARPOP_REQUEST)
-		goto out;
-
-	bat_dbg_arp(bat_priv, skb, type, 0, "Parsing outgoing ARP REQUEST");
-
-	ip_src = ARP_IP_SRC(skb, 0);
-	hw_src = ARP_HW_SRC(skb, 0);
-	ip_dst = ARP_IP_DST(skb, 0);
-
-	primary_if = primary_if_get_selected(bat_priv);
-	if (!primary_if)
-		goto out;
-
-	arp_neigh_update(bat_priv, ip_src, hw_src);
-
-	n = neigh_lookup(&arp_tbl, &ip_dst, primary_if->soft_iface);
-	/* check if it is a valid neigh entry */
-	if (n && (n->nud_state & NUD_CONNECTED)) {
-		skb_new = arp_create(ARPOP_REPLY, ETH_P_ARP, ip_src,
-				     primary_if->soft_iface, ip_dst, hw_src,
-				     n->ha, hw_src);
-		if (!skb_new)
-			goto out;
-
-		skb_reset_mac_header(skb_new);
-		skb_new->protocol = eth_type_trans(skb_new,
-						   primary_if->soft_iface);
-		bat_priv->stats.rx_packets++;
-		bat_priv->stats.rx_bytes += skb->len + ETH_HLEN;
-		primary_if->soft_iface->last_rx = jiffies;
-
-		netif_rx(skb_new);
-		bat_dbg(DBG_DAT, bat_priv, "ARP request replied locally\n");
-	} else
-		/* Send the request on the DHT */
-		ret = dht_send_data(bat_priv, skb, ip_dst, BAT_P_DAT_DHT_GET);
-out:
-	if (n)
-		neigh_release(n);
-	if (primary_if)
-		hardif_free_ref(primary_if);
-	return ret;
-}
-
-/* This function is meant to be invoked for an ARP request which is coming into
- * the bat0 interfaces from the mesh network. It will check for the needed data
- * into the local table. If found, an ARP reply is sent immediately, otherwise
- * the caller has to deliver the ARP request to the upper layer
- */
-bool dat_snoop_incoming_arp_request(struct bat_priv *bat_priv,
-				    struct sk_buff *skb, int hdr_size)
-{
-	uint16_t type;
-	uint32_t ip_src, ip_dst;
-	uint8_t *hw_src;
-	struct hard_iface *primary_if = NULL;
-	struct sk_buff *skb_new;
-	struct neighbour *n = NULL;
-	bool ret = false;
-
-	type = arp_get_type(bat_priv, skb, hdr_size);
-	if (type != ARPOP_REQUEST)
-		goto out;
-
-	hw_src = ARP_HW_SRC(skb, hdr_size);
-	ip_src = ARP_IP_SRC(skb, hdr_size);
-	ip_dst = ARP_IP_DST(skb, hdr_size);
-
-	bat_dbg_arp(bat_priv, skb, type, hdr_size,
-		    "Parsing incoming ARP REQUEST");
-
-	primary_if = primary_if_get_selected(bat_priv);
-	if (!primary_if)
-		goto out;
-
-	arp_neigh_update(bat_priv, ip_src, hw_src);
-
-	n = neigh_lookup(&arp_tbl, &ip_dst, primary_if->soft_iface);
-	/* check if it is a valid neigh entry */
-	if (!n || !(n->nud_state & NUD_CONNECTED))
-		goto out;
-
-	skb_new = arp_create(ARPOP_REPLY, ETH_P_ARP, ip_src,
-			     primary_if->soft_iface, ip_dst, hw_src, n->ha,
-			     hw_src);
-
-	if (!skb_new)
-		goto out;
-
-	unicast_4addr_send_skb(skb_new, bat_priv, BAT_P_DAT_CACHE_REPLY);
-
-	ret = true;
-out:
-	if (n)
-		neigh_release(n);
-	if (primary_if)
-		hardif_free_ref(primary_if);
-	if (ret)
-		kfree_skb(skb);
-	return ret;
-}
-
-/* This function is meant to be invoked on an ARP reply packet going into the
- * soft interface. The related neighbour entry has to be updated and the DHT has
- * to be populated as well
- */
-bool dat_snoop_outgoing_arp_reply(struct bat_priv *bat_priv,
-				  struct sk_buff *skb)
-{
-	uint16_t type;
-	uint32_t ip_src, ip_dst;
-	uint8_t *hw_src, *hw_dst;
-	bool ret = false;
-
-	type = arp_get_type(bat_priv, skb, 0);
-	if (type != ARPOP_REPLY)
-		goto out;
-
-	bat_dbg_arp(bat_priv, skb, type, 0, "Parsing outgoing ARP REPLY");
-
-	hw_src = ARP_HW_SRC(skb, 0);
-	ip_src = ARP_IP_SRC(skb, 0);
-	hw_dst = ARP_HW_DST(skb, 0);
-	ip_dst = ARP_IP_DST(skb, 0);
-
-	arp_neigh_update(bat_priv, ip_src, hw_src);
-	arp_neigh_update(bat_priv, ip_dst, hw_dst);
-
-	/* Send the ARP reply to the candidates for both the IP addresses we
-	 * fetched from the ARP reply
-	 */
-	dht_send_data(bat_priv, skb, ip_src, BAT_P_DAT_DHT_PUT);
-	dht_send_data(bat_priv, skb, ip_dst, BAT_P_DAT_DHT_PUT);
-	ret = true;
-out:
-	return ret;
-}
-
-/* This function has to be invoked on an ARP reply coming into the soft
- * interface from the mesh network. The local table has to be updated
- */
-bool dat_snoop_incoming_arp_reply(struct bat_priv *bat_priv,
-				  struct sk_buff *skb, int hdr_size)
-{
-	uint16_t type;
-	uint32_t ip_src, ip_dst;
-	uint8_t *hw_src, *hw_dst;
-	bool ret = false;
-
-	type = arp_get_type(bat_priv, skb, hdr_size);
-	if (type != ARPOP_REPLY)
-		goto out;
-
-	bat_dbg_arp(bat_priv, skb, type, hdr_size,
-		    "Parsing incoming ARP REPLY");
-
-	hw_src = ARP_HW_SRC(skb, hdr_size);
-	ip_src = ARP_IP_SRC(skb, hdr_size);
-	hw_dst = ARP_HW_DST(skb, hdr_size);
-	ip_dst = ARP_IP_DST(skb, hdr_size);
-
-	/* Update our internal cache with both the IP addresses we fetched from
-	 * the ARP reply
-	 */
-	arp_neigh_update(bat_priv, ip_src, hw_src);
-	arp_neigh_update(bat_priv, ip_dst, hw_dst);
-
-	/* if this REPLY is directed to a client of mine, let's deliver the
-	 * packet to the interface
-	 */
-	ret = !is_my_client(bat_priv, hw_dst);
-out:
-	/* if ret == false packet has to be delivered to the interface */
-	return ret;
-}
-
-bool dat_drop_broadcast_packet(struct bat_priv *bat_priv,
-			       struct forw_packet *forw_packet)
-{
-	struct neighbour *n;
-
-	/* If this packet is an ARP_REQUEST and we already have the information
-	 * that it is going to ask, we can drop the packet
-	 */
-	if (!forw_packet->num_packets &&
-	    (ARPOP_REQUEST == arp_get_type(bat_priv, forw_packet->skb,
-					   sizeof(struct bcast_packet)))) {
-		n = neigh_lookup(&arp_tbl,
-				 &ARP_IP_DST(forw_packet->skb,
-					     sizeof(struct bcast_packet)),
-				 forw_packet->if_incoming->soft_iface);
-		/* check if we already know this neigh */
-		if (n && (n->nud_state & NUD_CONNECTED)) {
-			bat_dbg(DBG_DAT, bat_priv,
-				"ARP Request for %pI4: fallback prevented\n",
-				&ARP_IP_DST(forw_packet->skb,
-					    sizeof(struct bcast_packet)));
-			return true;
-		}
-
-		bat_dbg(DBG_DAT, bat_priv, "ARP Request for %pI4: fallback\n",
-			&ARP_IP_DST(forw_packet->skb,
-				    sizeof(struct bcast_packet)));
-	}
-	return false;
-}
-
-void arp_change_timeout(struct net_device *soft_iface, const char *name)
-{
-	struct in_device *in_dev = in_dev_get(soft_iface);
-	if (!in_dev) {
-		pr_err("Unable to set ARP parameters for the batman interface '%s'\n",
-		       name);
-		return;
-	}
-
-	/* Introduce a delay in the ARP state-machine transactions. Entries
-	 * will be kept in the ARP table for the default time multiplied by 4
-	 */
-	in_dev->arp_parms->base_reachable_time *= ARP_TIMEOUT_FACTOR;
-	in_dev->arp_parms->gc_staletime *= ARP_TIMEOUT_FACTOR;
-	in_dev->arp_parms->reachable_time *= ARP_TIMEOUT_FACTOR;
-
-	in_dev_put(in_dev);
-}
diff --git a/distributed-arp-table.h b/distributed-arp-table.h
deleted file mode 100644
index 6c0acde..0000000
--- a/distributed-arp-table.h
+++ /dev/null
@@ -1,140 +0,0 @@
-/*
- * Copyright (C) 2011-2012 B.A.T.M.A.N. contributors:
- *
- * Antonio Quartulli
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
- *
- */
-
-#ifndef _NET_BATMAN_ADV_ARP_H_
-#define _NET_BATMAN_ADV_ARP_H_
-
-#ifdef CONFIG_BATMAN_ADV_DAT
-
-#include "types.h"
-#include "originator.h"
-
-#include <linux/if_arp.h>
-
-#define DAT_ADDR_MAX ((dat_addr_t)~(dat_addr_t)0)
-
-#define ARP_HW_SRC(skb, hdr_size) ((uint8_t *)(skb->data + hdr_size) + \
-				   ETH_HLEN + sizeof(struct arphdr))
-#define ARP_IP_SRC(skb, hdr_size) (*(uint32_t *)(ARP_HW_SRC(skb, hdr_size) + \
-				   ETH_ALEN))
-#define ARP_HW_DST(skb, hdr_size) (ARP_HW_SRC(skb, hdr_size) + ETH_ALEN + 4)
-#define ARP_IP_DST(skb, hdr_size) (*(uint32_t *)(ARP_HW_SRC(skb, hdr_size) + \
-				   ETH_ALEN * 2 + 4))
-
-bool dat_snoop_outgoing_arp_request(struct bat_priv *bat_priv,
-				    struct sk_buff *skb);
-bool dat_snoop_incoming_arp_request(struct bat_priv *bat_priv,
-				    struct sk_buff *skb, int hdr_size);
-bool dat_snoop_outgoing_arp_reply(struct bat_priv *bat_priv,
-				  struct sk_buff *skb);
-bool dat_snoop_incoming_arp_reply(struct bat_priv *bat_priv,
-				  struct sk_buff *skb, int hdr_size);
-bool dat_drop_broadcast_packet(struct bat_priv *bat_priv,
-			       struct forw_packet *forw_packet);
-void arp_change_timeout(struct net_device *soft_iface, const char *name);
-
-/* hash function to choose an entry in a hash table of given size.
- * hash algorithm from http://en.wikipedia.org/wiki/Hash_table
- */
-static inline uint32_t hash_ipv4(const void *data, uint32_t size)
-{
-	const unsigned char *key = data;
-	uint32_t hash = 0;
-	size_t i;
-
-	for (i = 0; i < 4; i++) {
-		hash += key[i];
-		hash += (hash << 10);
-		hash ^= (hash >> 6);
-	}
-
-	hash += (hash << 3);
-	hash ^= (hash >> 11);
-	hash += (hash << 15);
-
-	return hash % size;
-}
-
-static inline void dat_init_orig_node_dht_addr(struct orig_node *orig_node)
-{
-	orig_node->dht_addr = (dat_addr_t)choose_orig(orig_node->orig,
-						      DAT_ADDR_MAX);
-}
-
-static inline void dat_init_own_dht_addr(struct bat_priv *bat_priv,
-					 struct hard_iface *primary_if)
-{
-	bat_priv->dht_addr = (dat_addr_t)
-				choose_orig(primary_if->net_dev->dev_addr,
-					    DAT_ADDR_MAX);
-}
-
-#else
-
-static inline bool dat_snoop_outgoing_arp_request(struct bat_priv *bat_priv,
-						  struct sk_buff *skb)
-{
-	return false;
-}
-
-static inline bool dat_snoop_incoming_arp_request(struct bat_priv *bat_priv,
-						  struct sk_buff *skb,
-						  int hdr_size)
-{
-	return false;
-}
-
-static inline bool dat_snoop_outgoing_arp_reply(struct bat_priv *bat_priv,
-						struct sk_buff *skb)
-{
-	return false;
-}
-
-static inline bool dat_snoop_incoming_arp_reply(struct bat_priv *bat_priv,
-						struct sk_buff *skb,
-						int hdr_size)
-{
-	return false;
-}
-
-static inline bool dat_drop_broadcast_packet(struct bat_priv *bat_priv,
-					     struct forw_packet *forw_packet)
-{
-	return false;
-}
-
-static inline void dat_init_orig_node_dht_addr(struct orig_node *orig_node)
-{
-}
-
-static inline void dat_init_own_dht_addr(struct bat_priv *bat_priv,
-					 struct hard_iface *primary_if)
-{
-}
-
-static inline void arp_change_timeout(struct net_device *soft_iface,
-				      const char *name)
-{
-}
-
-#endif /* CONFIG_BATMAN_ADV_DAT */
-
-#endif /* _NET_BATMAN_ADV_ARP_H_ */
diff --git a/gen-compat-autoconf.sh b/gen-compat-autoconf.sh
index 7ea42aa..7cf621b 100755
--- a/gen-compat-autoconf.sh
+++ b/gen-compat-autoconf.sh
@@ -38,7 +38,6 @@ gen_config() {
 # write config variables
 gen_config 'CONFIG_BATMAN_ADV_DEBUG' ${CONFIG_BATMAN_ADV_DEBUG:="n"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_BLA' ${CONFIG_BATMAN_ADV_BLA:="y"} >> "${TMP}"
-gen_config 'CONFIG_BATMAN_ADV_DAT' ${CONFIG_BATMAN_ADV_DAT:="y"} >> "${TMP}"
 
 # only regenerate compat-autoconf.h when config was changed
 diff "${TMP}" "${TARGET}" > /dev/null 2>&1 || cp "${TMP}" "${TARGET}"
diff --git a/hard-interface.c b/hard-interface.c
index 843caa7..ce78c6d 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -20,7 +20,6 @@
  */
 
 #include "main.h"
-#include "distributed-arp-table.h"
 #include "hard-interface.h"
 #include "soft-interface.h"
 #include "send.h"
@@ -113,8 +112,6 @@ static void primary_if_update_addr(struct bat_priv *bat_priv,
 	if (!primary_if)
 		goto out;
 
-	dat_init_own_dht_addr(bat_priv, primary_if);
-
 	vis_packet = (struct vis_packet *)
 				bat_priv->my_vis_info->skb_packet->data;
 	memcpy(vis_packet->vis_orig, primary_if->net_dev->dev_addr, ETH_ALEN);
diff --git a/main.c b/main.c
index 9137aa0..083a299 100644
--- a/main.c
+++ b/main.c
@@ -268,8 +268,6 @@ static void recv_handler_init(void)
 
 	/* batman icmp packet */
 	recv_packet_handler[BAT_ICMP] = recv_icmp_packet;
-	/* unicast with 4 addresses packet */
-	recv_packet_handler[BAT_UNICAST_4ADDR] = recv_unicast_packet;
 	/* unicast packet */
 	recv_packet_handler[BAT_UNICAST] = recv_unicast_packet;
 	/* fragmented unicast packet */
diff --git a/main.h b/main.h
index 426a0d5..19e5881 100644
--- a/main.h
+++ b/main.h
@@ -67,15 +67,6 @@
 
 #define NUM_WORDS BITS_TO_LONGS(TQ_LOCAL_WINDOW_SIZE)
 
-/* msecs after which an ARP_REQUEST is sent in broadcast as fallback */
-#define ARP_REQ_DELAY 250
-/* numbers of originator to contact for any PUT/GET DHT operation */
-#define DHT_CANDIDATES_NUM 3
-/* Factor which default ARP timeout values of the soft_iface table are
- * multiplied by
- */
-#define ARP_TIMEOUT_FACTOR 4
-
 #define LOG_BUF_LEN 8192	  /* has to be a power of 2 */
 
 #define VIS_INTERVAL 5000	/* 5 seconds */
@@ -120,9 +111,6 @@ enum uev_type {
 
 #define GW_THRESHOLD	50
 
-#define DHT_CANDIDATE_NOT_FOUND	0
-#define DHT_CANDIDATE_ORIG	1
-
 /* Debug Messages */
 #ifdef pr_fmt
 #undef pr_fmt
@@ -136,8 +124,7 @@ enum dbg_level {
 	DBG_ROUTES = 1 << 1, /* route added / changed / deleted */
 	DBG_TT	   = 1 << 2, /* translation table operations */
 	DBG_BLA    = 1 << 3, /* bridge loop avoidance */
-	DBG_DAT    = 1 << 4, /* snooped arp messages / dat operations */
-	DBG_ALL    = 31
+	DBG_ALL    = 15
 };
 
 /* Kernel headers */
diff --git a/originator.c b/originator.c
index c6a00b3..4114794 100644
--- a/originator.c
+++ b/originator.c
@@ -20,7 +20,6 @@
  */
 
 #include "main.h"
-#include "distributed-arp-table.h"
 #include "originator.h"
 #include "hash.h"
 #include "translation-table.h"
@@ -221,7 +220,6 @@ struct orig_node *get_orig_node(struct bat_priv *bat_priv, const uint8_t *addr)
 	orig_node->tt_poss_change = false;
 	orig_node->bat_priv = bat_priv;
 	memcpy(orig_node->orig, addr, ETH_ALEN);
-	dat_init_orig_node_dht_addr(orig_node);
 	orig_node->router = NULL;
 	orig_node->tt_crc = 0;
 	atomic_set(&orig_node->last_ttvn, 0);
diff --git a/packet.h b/packet.h
index 307dbb3..0ee1af7 100644
--- a/packet.h
+++ b/packet.h
@@ -25,22 +25,14 @@
 #define ETH_P_BATMAN  0x4305	/* unofficial/not registered Ethertype */
 
 enum bat_packettype {
-	BAT_IV_OGM		= 0x01,
-	BAT_ICMP		= 0x02,
-	BAT_UNICAST		= 0x03,
-	BAT_BCAST		= 0x04,
-	BAT_VIS			= 0x05,
-	BAT_UNICAST_FRAG	= 0x06,
-	BAT_TT_QUERY		= 0x07,
-	BAT_ROAM_ADV		= 0x08,
-	BAT_UNICAST_4ADDR	= 0x09
-};
-
-enum bat_subtype {
-	BAT_P_DATA		= 0x01,
-	BAT_P_DAT_DHT_GET	= 0x02,
-	BAT_P_DAT_DHT_PUT	= 0x03,
-	BAT_P_DAT_CACHE_REPLY	= 0x04
+	BAT_IV_OGM	 = 0x01,
+	BAT_ICMP	 = 0x02,
+	BAT_UNICAST	 = 0x03,
+	BAT_BCAST	 = 0x04,
+	BAT_VIS		 = 0x05,
+	BAT_UNICAST_FRAG = 0x06,
+	BAT_TT_QUERY	 = 0x07,
+	BAT_ROAM_ADV	 = 0x08
 };
 
 /* this file is included by batctl which needs these defines */
@@ -168,12 +160,6 @@ struct unicast_packet {
 	uint8_t  dest[ETH_ALEN];
 } __packed;
 
-struct unicast_4addr_packet {
-	struct unicast_packet u;
-	uint8_t src[ETH_ALEN];
-	uint8_t subtype;
-} __packed;
-
 struct unicast_frag_packet {
 	struct batman_header header;
 	uint8_t  ttvn; /* destination translation table version number */
diff --git a/routing.c b/routing.c
index 4f2059f..840e2c6 100644
--- a/routing.c
+++ b/routing.c
@@ -962,18 +962,14 @@ int recv_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 	struct unicast_packet *unicast_packet;
 	int hdr_size = sizeof(*unicast_packet);
 
-	unicast_packet = (struct unicast_packet *)skb->data;
-
-	/* the caller function should have already pulled 2 bytes */
-	if (unicast_packet->header.packet_type == BAT_UNICAST_4ADDR)
-		hdr_size = sizeof(struct unicast_4addr_packet);
-
 	if (check_unicast_packet(skb, hdr_size) < 0)
 		return NET_RX_DROP;
 
 	if (!check_unicast_ttvn(bat_priv, skb))
 		return NET_RX_DROP;
 
+	unicast_packet = (struct unicast_packet *)skb->data;
+
 	/* packet for me */
 	if (is_my_mac(unicast_packet->dest)) {
 		interface_rx(recv_if->soft_iface, skb, recv_if, hdr_size);
diff --git a/send.c b/send.c
index 815cc9c..f47299f 100644
--- a/send.c
+++ b/send.c
@@ -20,7 +20,6 @@
  */
 
 #include "main.h"
-#include "distributed-arp-table.h"
 #include "send.h"
 #include "routing.h"
 #include "translation-table.h"
@@ -275,9 +274,6 @@ static void send_outstanding_bcast_packet(struct work_struct *work)
 	if (atomic_read(&bat_priv->mesh_state) == MESH_DEACTIVATING)
 		goto out;
 
-	if (dat_drop_broadcast_packet(bat_priv, forw_packet))
-		goto out;
-
 	/* rebroadcast packet */
 	rcu_read_lock();
 	list_for_each_entry_rcu(hard_iface, &hardif_list, list) {
diff --git a/soft-interface.c b/soft-interface.c
index b56dafd..6e2530b 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -22,7 +22,6 @@
 #include "main.h"
 #include "soft-interface.h"
 #include "hard-interface.h"
-#include "distributed-arp-table.h"
 #include "routing.h"
 #include "send.h"
 #include "bat_debugfs.h"
@@ -137,7 +136,6 @@ static int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 	int data_len = skb->len, ret;
 	short vid __maybe_unused = -1;
 	bool do_bcast = false;
-	unsigned long brd_delay = 1;
 
 	if (atomic_read(&bat_priv->mesh_state) != MESH_ACTIVE)
 		goto dropped;
@@ -199,9 +197,6 @@ static int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 		if (!primary_if)
 			goto dropped;
 
-		if (dat_snoop_outgoing_arp_request(bat_priv, skb))
-			brd_delay = msecs_to_jiffies(ARP_REQ_DELAY);
-
 		if (my_skb_head_push(skb, sizeof(*bcast_packet)) < 0)
 			goto dropped;
 
@@ -221,7 +216,7 @@ static int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 		bcast_packet->seqno =
 			htonl(atomic_inc_return(&bat_priv->bcast_seqno));
 
-		add_bcast_packet_to_list(bat_priv, skb, brd_delay);
+		add_bcast_packet_to_list(bat_priv, skb, 1);
 
 		/* a copy is stored in the bcast list, therefore removing
 		 * the original skb. */
@@ -235,8 +230,6 @@ static int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 				goto dropped;
 		}
 
-		dat_snoop_outgoing_arp_reply(bat_priv, skb);
-
 		ret = unicast_send_skb(skb, bat_priv);
 		if (ret != 0)
 			goto dropped_freed;
@@ -269,12 +262,6 @@ void interface_rx(struct net_device *soft_iface,
 	if (!pskb_may_pull(skb, hdr_size))
 		goto dropped;
 
-	if (dat_snoop_incoming_arp_request(bat_priv, skb, hdr_size))
-		goto out;
-
-	if (dat_snoop_incoming_arp_reply(bat_priv, skb, hdr_size))
-		goto out;
-
 	skb_pull_rcsum(skb, hdr_size);
 	skb_reset_mac_header(skb);
 
@@ -381,8 +368,6 @@ struct net_device *softif_create(const char *name)
 		goto free_soft_iface;
 	}
 
-	arp_change_timeout(soft_iface, name);
-
 	bat_priv = netdev_priv(soft_iface);
 
 	atomic_set(&bat_priv->aggregated_ogms, 1);
diff --git a/types.h b/types.h
index 6474324..61308e8 100644
--- a/types.h
+++ b/types.h
@@ -27,17 +27,6 @@
 #include "packet.h"
 #include "bitarray.h"
 
-#ifdef CONFIG_BATMAN_ADV_DAT
-
-/* dat_addr_t is the type used for all DHT addresses. If it is changed,
- * DAT_ADDR_MAX is changed as well.
- *
- * *Please be careful: dat_addr_t must be UNSIGNED*
- */
-#define dat_addr_t uint16_t
-
-#endif /* CONFIG_BATMAN_ADV_DAT */
-
 #define BAT_HEADER_LEN (ETH_HLEN + \
 	((sizeof(struct unicast_packet) > sizeof(struct bcast_packet) ? \
 	 sizeof(struct unicast_packet) : \
@@ -78,9 +67,6 @@ struct hard_iface {
 struct orig_node {
 	uint8_t orig[ETH_ALEN];
 	uint8_t primary_addr[ETH_ALEN];
-#ifdef CONFIG_BATMAN_ADV_DAT
-	dat_addr_t dht_addr;
-#endif
 	struct neigh_node __rcu *router; /* rcu protected pointer */
 	unsigned long *bcast_own;
 	uint8_t *bcast_own_sum;
@@ -235,9 +221,6 @@ struct bat_priv {
 	struct gw_node __rcu *curr_gw;  /* rcu protected pointer */
 	atomic_t gw_reselect;
 	struct hard_iface __rcu *primary_if;  /* rcu protected pointer */
-#ifdef CONFIG_BATMAN_ADV_DAT
-	dat_addr_t dht_addr;
-#endif
 	struct vis_info *my_vis_info;
 	struct bat_algo_ops *bat_algo_ops;
 };
@@ -411,9 +394,4 @@ struct bat_algo_ops {
 	void (*bat_ogm_emit)(struct forw_packet *forw_packet);
 };
 
-struct dht_candidate {
-	int type;
-	struct orig_node *orig_node;
-};
-
 #endif /* _NET_BATMAN_ADV_TYPES_H_ */
diff --git a/unicast.c b/unicast.c
index e5c7999..74175c2 100644
--- a/unicast.c
+++ b/unicast.c
@@ -283,78 +283,13 @@ out:
 	return ret;
 }
 
-static bool pull_and_fill_unicast(struct sk_buff *skb, int hdr_size,
-				  struct orig_node *orig_node)
-{
-	struct unicast_packet *unicast_packet;
-
-	if (my_skb_head_push(skb, hdr_size) < 0)
-		return false;
-
-	unicast_packet = (struct unicast_packet *)skb->data;
-	unicast_packet->header.version = COMPAT_VERSION;
-	/* batman packet type: unicast */
-	unicast_packet->header.packet_type = BAT_UNICAST;
-	/* set unicast ttl */
-	unicast_packet->header.ttl = TTL;
-	/* copy the destination for faster routing */
-	memcpy(unicast_packet->dest, orig_node->orig, ETH_ALEN);
-	/* set the destination tt version number */
-	unicast_packet->ttvn =
-		(uint8_t)atomic_read(&orig_node->last_ttvn);
-
-	return true;
-}
-
-static bool prepare_unicast_packet(struct sk_buff *skb,
-				   struct orig_node *orig_node)
-{
-	return pull_and_fill_unicast(skb, sizeof(struct unicast_packet),
-				     orig_node);
-}
-
-bool prepare_unicast_4addr_packet(struct bat_priv *bat_priv,
-				  struct sk_buff *skb,
-				  struct orig_node *orig_node,
-				  int packet_subtype)
-{
-	struct hard_iface *primary_if;
-	struct unicast_4addr_packet *unicast_4addr_packet;
-	bool ret = false;
-
-	primary_if = primary_if_get_selected(bat_priv);
-	if (!primary_if)
-		goto out;
-
-	/* pull the header space and fill the unicast_packet substructure.
-	 * We can do that because the first member of the unicast_4addr_packet
-	 * is of type struct unicast_packet
-	 */
-	if (!pull_and_fill_unicast(skb, sizeof(*unicast_4addr_packet),
-				   orig_node))
-		goto out;
-
-	unicast_4addr_packet = (struct unicast_4addr_packet *)skb->data;
-	unicast_4addr_packet->u.header.packet_type = BAT_UNICAST_4ADDR;
-	memcpy(unicast_4addr_packet->src, primary_if->net_dev->dev_addr,
-	       ETH_ALEN);
-	unicast_4addr_packet->subtype = packet_subtype;
-
-	ret = true;
-out:
-	if (primary_if)
-		hardif_free_ref(primary_if);
-	return ret;
-}
-
-int unicast_generic_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
-			     int packet_type, int packet_subtype)
+int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
 {
 	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
+	struct unicast_packet *unicast_packet;
 	struct orig_node *orig_node;
 	struct neigh_node *neigh_node;
 	int data_len = skb->len;
-	struct unicast_packet *unicast_packet;
 	int ret = 1;
 
 	/* get routing information */
@@ -368,6 +303,7 @@ int unicast_generic_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 	 * returns NULL in case of AP isolation */
 	orig_node = transtable_search(bat_priv, ethhdr->h_source,
 				      ethhdr->h_dest);
+
 find_router:
 	/**
 	 * find_router():
@@ -375,26 +311,26 @@ find_router:
 	 *  - increases neigh_nodes refcount if found.
 	 */
 	neigh_node = find_router(bat_priv, orig_node, NULL);
+
 	if (!neigh_node)
 		goto out;
 
-	switch (packet_type) {
-	case BAT_UNICAST:
-		prepare_unicast_packet(skb, orig_node);
-		break;
-	case BAT_UNICAST_4ADDR:
-		prepare_unicast_4addr_packet(bat_priv, skb, orig_node,
-					     packet_subtype);
-		break;
-	default:
-		/* this function supports UNICAST and UNICAST_4ADDR only. It
-		 * should never be invoked with any other packet type
-		 */
+	if (my_skb_head_push(skb, sizeof(*unicast_packet)) < 0)
 		goto out;
-	}
 
 	unicast_packet = (struct unicast_packet *)skb->data;
 
+	unicast_packet->header.version = COMPAT_VERSION;
+	/* batman packet type: unicast */
+	unicast_packet->header.packet_type = BAT_UNICAST;
+	/* set unicast ttl */
+	unicast_packet->header.ttl = TTL;
+	/* copy the destination for faster routing */
+	memcpy(unicast_packet->dest, orig_node->orig, ETH_ALEN);
+	/* set the destination tt version number */
+	unicast_packet->ttvn =
+		(uint8_t)atomic_read(&orig_node->last_ttvn);
+
 	/* inform the destination node that we are still missing a correct route
 	 * for this client. The destination will receive this packet and will
 	 * try to reroute it because the ttvn contained in the header is less
@@ -403,9 +339,7 @@ find_router:
 	if (tt_global_client_is_roaming(bat_priv, ethhdr->h_dest))
 		unicast_packet->ttvn = unicast_packet->ttvn - 1;
 
-	/* fragmentation mechanism only works for UNICAST (now) */
-	if (packet_type == BAT_UNICAST &&
-	    atomic_read(&bat_priv->fragmentation) &&
+	if (atomic_read(&bat_priv->fragmentation) &&
 	    data_len + sizeof(*unicast_packet) >
 				neigh_node->if_incoming->net_dev->mtu) {
 		/* send frag skb decreases ttl */
@@ -417,6 +351,7 @@ find_router:
 
 	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	ret = 0;
+	goto out;
 
 out:
 	if (neigh_node)
diff --git a/unicast.h b/unicast.h
index e15aa62..a9faf6b 100644
--- a/unicast.h
+++ b/unicast.h
@@ -30,28 +30,9 @@
 int frag_reassemble_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 			struct sk_buff **new_skb);
 void frag_list_free(struct list_head *head);
+int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv);
 int frag_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 		  struct hard_iface *hard_iface, const uint8_t dstaddr[]);
-bool prepare_unicast_4addr_packet(struct bat_priv *bat_priv,
-				  struct sk_buff *skb,
-				  struct orig_node *orig_node,
-				  int packet_subtype);
-int unicast_generic_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
-			     int packet_type, int packet_subtype);
-
-static inline int unicast_send_skb(struct sk_buff *skb,
-				   struct bat_priv *bat_priv)
-{
-	return unicast_generic_send_skb(skb, bat_priv, BAT_UNICAST, 0);
-}
-
-static inline int unicast_4addr_send_skb(struct sk_buff *skb,
-					 struct bat_priv *bat_priv,
-					 int packet_subtype)
-{
-	return unicast_generic_send_skb(skb, bat_priv, BAT_UNICAST_4ADDR,
-					packet_subtype);
-}
 
 static inline int frag_can_reassemble(const struct sk_buff *skb, int mtu)
 {
-- 
1.7.10


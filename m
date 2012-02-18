Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 18 Feb 2012 17:38:49 +0100
Message-Id: <1329583133-11681-4-git-send-email-ordex@autistici.org>
In-Reply-To: <1329583133-11681-1-git-send-email-ordex@autistici.org>
References: <1329583133-11681-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv6 3/7] batman-adv: Distributed ARP Table -
	create DHT helper functions
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

Add all the relevant functions in order to manage a Distributed Hash Table over
the B.A.T.M.A.N.-adv network. It will later be used to store several ARP entries
and implement DAT (Distributed ARP Table)

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 Makefile.kbuild         |    1 +
 distributed-arp-table.c |  214 +++++++++++++++++++++++++++++++++++++++++++++++
 distributed-arp-table.h |   65 ++++++++++++++
 hard-interface.c        |    3 +
 main.h                  |    7 ++
 originator.c            |    2 +
 types.h                 |   15 ++++
 unicast.c               |    8 +-
 unicast.h               |    4 +
 9 files changed, 315 insertions(+), 4 deletions(-)
 create mode 100644 distributed-arp-table.c
 create mode 100644 distributed-arp-table.h

diff --git a/Makefile.kbuild b/Makefile.kbuild
index 6d5c194..84955b3 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -24,6 +24,7 @@ batman-adv-y += bat_iv_ogm.o
 batman-adv-y += bat_sysfs.o
 batman-adv-y += bitarray.o
 batman-adv-$(CONFIG_BATMAN_ADV_BLA) += bridge_loop_avoidance.o
+batman-adv-y += distributed-arp-table.o
 batman-adv-y += gateway_client.o
 batman-adv-y += gateway_common.o
 batman-adv-y += hard-interface.o
diff --git a/distributed-arp-table.c b/distributed-arp-table.c
new file mode 100644
index 0000000..f36b85c
--- /dev/null
+++ b/distributed-arp-table.c
@@ -0,0 +1,214 @@
+/*
+ * Copyright (C) 2011 B.A.T.M.A.N. contributors:
+ *
+ * Antonio Quartulli
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA
+ *
+ */
+
+#include <linux/if_ether.h>
+#include <linux/if_arp.h>
+
+#include "main.h"
+#include "distributed-arp-table.h"
+#include "hard-interface.h"
+#include "originator.h"
+#include "send.h"
+#include "types.h"
+#include "unicast.h"
+
+static bool is_orig_node_eligible(struct dht_candidate *res, int select,
+				  dat_addr_t tmp_max, dat_addr_t max,
+				  dat_addr_t last_max,
+				  struct orig_node *candidate,
+				  struct orig_node *max_orig_node)
+{
+	bool ret = false;
+	int j;
+
+	/* Check if we have already selected this neighbour... */
+	for (j = 0; j < select; j++)
+		if (res[j].orig_node == candidate)
+			break;
+	/* ..and possibly skip it */
+	if (j < select)
+		goto out;
+	/* sanity check: has it already been selected? This should not happen */
+	if (tmp_max > last_max)
+		goto out;
+	/* check if during this iteration we have already found an originator
+	 * with a closer dht address */
+	if (tmp_max < max)
+		goto out;
+	/* this is an hash collision with the temporary selected node. Choose
+	 * the one with the lowest address */
+	if (tmp_max == max && memcmp(candidate->orig, max_orig_node->orig,
+				     ETH_ALEN) > 0)
+		goto out;
+
+	ret = true;
+out:
+	return ret;
+}
+
+
+/* Given a key, selects the candidates which the DHT message has to be sent to.
+ * An originator O is selected if and only if its DHT_ID value is one of three
+ * closest values (from the LEFT, with wrap around if needed) then the hash
+ * value of the key. ip_dst is the key.
+ *
+ * return an array of size DHT_CANDIDATES_NUM */
+static struct dht_candidate *dht_select_candidates(struct bat_priv *bat_priv,
+						   uint32_t ip_dst)
+{
+	struct hashtable_t *hash = bat_priv->orig_hash;
+	struct hlist_node *node;
+	struct hlist_head *head;
+	struct orig_node *orig_node, *max_orig_node = NULL;
+	int select, i;
+	dat_addr_t last_max = DAT_ADDR_MAX, max, tmp_max, ip_key;
+	struct dht_candidate *res;
+	bool chosen_me = false;
+
+	if (!hash)
+		return NULL;
+
+	res = kmalloc(DHT_CANDIDATES_NUM * sizeof(*res), GFP_ATOMIC);
+	if (!res)
+		return NULL;
+
+	ip_key = (dat_addr_t)hash_ipv4(&ip_dst, DAT_ADDR_MAX);
+
+	bat_dbg(DBG_ARP, bat_priv, "dht_select_candidates(): IP=%pI4 "
+		"hash(IP)=%u\n", &ip_dst, ip_key);
+
+	for (select = 0; select < DHT_CANDIDATES_NUM; select++) {
+		max = 0;
+		max_orig_node = NULL;
+		/* Since the local node is not in the originator list, let's
+		 * first compute its distance from the key and assume it's the
+		 * maximum, then compare it to the other originators.
+		 * If the local node has already been chosen as candidate, jump
+		 * this step */
+		if (!chosen_me) {
+			/* if true, wrap around the key space */
+			if (bat_priv->dht_addr > ip_key)
+				max = DAT_ADDR_MAX - bat_priv->dht_addr +
+					ip_key;
+			else
+				max = ip_key - bat_priv->dht_addr;
+			res[select].type = DHT_CANDIDATE_ME;
+		} else
+			res[select].type = DHT_CANDIDATE_NULL;
+		/* iterate over the originator list and find the node with
+		 * closest dht_address which has not been selected yet */
+		for (i = 0; i < hash->size; i++) {
+			head = &hash->table[i];
+
+			rcu_read_lock();
+			hlist_for_each_entry_rcu(orig_node, node, head,
+						 hash_entry) {
+				/* the dht space is a ring, so we have to check
+				 * if we need to wrap around to compute the
+				 * distance from the key */
+				if (orig_node->dht_addr > ip_key)
+					tmp_max = DAT_ADDR_MAX -
+						  orig_node->dht_addr + ip_key;
+				else
+					tmp_max = ip_key - orig_node->dht_addr;
+				if (!is_orig_node_eligible(res, select, tmp_max,
+							   max, last_max,
+							   orig_node,
+							   max_orig_node))
+					continue;
+
+				if (!atomic_inc_not_zero(&orig_node->refcount))
+					continue;
+
+				max = tmp_max;
+				if (max_orig_node)
+					orig_node_free_ref(max_orig_node);
+				max_orig_node = orig_node;
+			}
+			rcu_read_unlock();
+		}
+		last_max = max;
+		if (max_orig_node) {
+			res[select].type = DHT_CANDIDATE_ORIG;
+			res[select].orig_node = max_orig_node;
+			bat_dbg(DBG_ARP, bat_priv, "dht_select_candidates() %d: "
+				"selected %pM addr=%u dist=%u\n", select,
+				max_orig_node->orig, max_orig_node->dht_addr,
+				max);
+		} else if (res[select].type == DHT_CANDIDATE_ME) {
+			chosen_me = true;
+			bat_dbg(DBG_ARP, bat_priv, "dht_select_candidates() %d: "
+				"selected ME addr=%u dist=%u\n", select,
+				bat_priv->dht_addr, max);
+		}
+
+		max_orig_node = NULL;
+	}
+
+	return res;
+}
+
+/*
+ * Sends the skb payload passed as argument to the candidates selected for
+ * 'ip'. The skb is copied by means of pskb_copy() and is sent as unicast packet
+ * to each of the selected candidate. */
+static bool dht_send_data(struct bat_priv *bat_priv, struct sk_buff *skb,
+			  uint32_t ip, int packet_subtype)
+{
+	int i;
+	bool ret = false;
+	struct neigh_node *neigh_node = NULL;
+	struct sk_buff *tmp_skb;
+	struct dht_candidate *cand = dht_select_candidates(bat_priv, ip);
+
+	if (!cand)
+		goto out;
+
+	bat_dbg(DBG_ARP, bat_priv, "DHT_SEND for %pI4\n", &ip);
+
+	for (i = 0; i < DHT_CANDIDATES_NUM; i++) {
+		if (cand[i].type == DHT_CANDIDATE_ME ||
+		    cand[i].type == DHT_CANDIDATE_NULL)
+			continue;
+
+		neigh_node = orig_node_get_router(cand[i].orig_node);
+		if (!neigh_node)
+			goto free_orig;
+
+		tmp_skb = pskb_copy(skb, GFP_ATOMIC);
+		if (prepare_unicast_4addr_packet(bat_priv, tmp_skb,
+						 cand[i].orig_node,
+						 packet_subtype))
+			send_skb_packet(tmp_skb, neigh_node->if_incoming,
+					neigh_node->addr);
+		else
+			kfree_skb(tmp_skb);
+		/* set ret to true only if we send at least one request */
+		ret = true;
+		neigh_node_free_ref(neigh_node);
+free_orig:
+		orig_node_free_ref(cand[i].orig_node);
+	}
+
+out:
+	kfree(cand);
+	return ret;
+}
diff --git a/distributed-arp-table.h b/distributed-arp-table.h
new file mode 100644
index 0000000..89d52c8
--- /dev/null
+++ b/distributed-arp-table.h
@@ -0,0 +1,65 @@
+/*
+ * Copyright (C) 2011 B.A.T.M.A.N. contributors:
+ *
+ * Antonio Quartulli
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA
+ *
+ */
+
+#ifndef _NET_BATMAN_ADV_ARP_H_
+#define _NET_BATMAN_ADV_ARP_H_
+
+#include "types.h"
+#include "originator.h"
+
+#define DAT_ADDR_MAX biggest_unsigned_int(dat_addr_t)
+
+/* hash function to choose an entry in a hash table of given size */
+/* hash algorithm from http://en.wikipedia.org/wiki/Hash_table */
+static inline uint32_t hash_ipv4(const void *data, uint32_t size)
+{
+	const unsigned char *key = data;
+	uint32_t hash = 0;
+	size_t i;
+
+	for (i = 0; i < 4; i++) {
+		hash += key[i];
+		hash += (hash << 10);
+		hash ^= (hash >> 6);
+	}
+
+	hash += (hash << 3);
+	hash ^= (hash >> 11);
+	hash += (hash << 15);
+
+	return hash % size;
+}
+
+static inline void dat_init_orig_node_dht_addr(struct orig_node *orig_node)
+{
+	orig_node->dht_addr = (dat_addr_t)choose_orig(orig_node->orig,
+						      DAT_ADDR_MAX);
+}
+
+static inline void dat_init_own_dht_addr(struct bat_priv *bat_priv,
+					 struct hard_iface *primary_if)
+{
+	bat_priv->dht_addr = (dat_addr_t)
+				choose_orig(primary_if->net_dev->dev_addr,
+					    DAT_ADDR_MAX);
+}
+
+#endif /* _NET_BATMAN_ADV_ARP_H_ */
diff --git a/hard-interface.c b/hard-interface.c
index f18459c..77e3163 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -20,6 +20,7 @@
  */
 
 #include "main.h"
+#include "distributed-arp-table.h"
 #include "hard-interface.h"
 #include "soft-interface.h"
 #include "send.h"
@@ -118,6 +119,8 @@ static void primary_if_update_addr(struct bat_priv *bat_priv,
 	if (!primary_if)
 		goto out;
 
+	dat_init_own_dht_addr(bat_priv, primary_if);
+
 	vis_packet = (struct vis_packet *)
 				bat_priv->my_vis_info->skb_packet->data;
 	memcpy(vis_packet->vis_orig, primary_if->net_dev->dev_addr, ETH_ALEN);
diff --git a/main.h b/main.h
index 3060f94..86a3d4a 100644
--- a/main.h
+++ b/main.h
@@ -67,6 +67,9 @@
 
 #define NUM_WORDS BITS_TO_LONGS(TQ_LOCAL_WINDOW_SIZE)
 
+/* numbers of originator to contact for any PUT/GET DHT operation */
+#define DHT_CANDIDATES_NUM 3
+
 #define LOG_BUF_LEN 8192	  /* has to be a power of 2 */
 
 #define VIS_INTERVAL 5000	/* 5 seconds */
@@ -111,6 +114,10 @@ enum uev_type {
 
 #define GW_THRESHOLD	50
 
+#define DHT_CANDIDATE_NULL 0
+#define DHT_CANDIDATE_ME   1
+#define DHT_CANDIDATE_ORIG 2
+
 /*
  * Debug Messages
  */
diff --git a/originator.c b/originator.c
index 2db4b53..1ee6e82 100644
--- a/originator.c
+++ b/originator.c
@@ -20,6 +20,7 @@
  */
 
 #include "main.h"
+#include "distributed-arp-table.h"
 #include "originator.h"
 #include "hash.h"
 #include "translation-table.h"
@@ -224,6 +225,7 @@ struct orig_node *get_orig_node(struct bat_priv *bat_priv, const uint8_t *addr)
 	orig_node->tt_poss_change = false;
 	orig_node->bat_priv = bat_priv;
 	memcpy(orig_node->orig, addr, ETH_ALEN);
+	dat_init_orig_node_dht_addr(orig_node);
 	orig_node->router = NULL;
 	orig_node->tt_crc = 0;
 	atomic_set(&orig_node->last_ttvn, 0);
diff --git a/types.h b/types.h
index 2f4848b..210ee3e 100644
--- a/types.h
+++ b/types.h
@@ -27,6 +27,14 @@
 #include "packet.h"
 #include "bitarray.h"
 
+/*
+ * dat_addr_t is the type used for all DHT addresses. If it is changed,
+ * DAT_ADDR_MAX is changed as well.
+ *
+ * *Please be careful: dat_addr_t must be UNSIGNED*
+ */
+#define dat_addr_t uint16_t
+
 #define BAT_HEADER_LEN (ETH_HLEN + \
 	((sizeof(struct unicast_packet) > sizeof(struct bcast_packet) ? \
 	 sizeof(struct unicast_packet) : \
@@ -67,6 +75,7 @@ struct hard_iface {
 struct orig_node {
 	uint8_t orig[ETH_ALEN];
 	uint8_t primary_addr[ETH_ALEN];
+	dat_addr_t dht_addr;
 	struct neigh_node __rcu *router; /* rcu protected pointer */
 	unsigned long *bcast_own;
 	uint8_t *bcast_own_sum;
@@ -221,6 +230,7 @@ struct bat_priv {
 	struct gw_node __rcu *curr_gw;  /* rcu protected pointer */
 	atomic_t gw_reselect;
 	struct hard_iface __rcu *primary_if;  /* rcu protected pointer */
+	dat_addr_t dht_addr;
 	struct vis_info *my_vis_info;
 	struct bat_algo_ops *bat_algo_ops;
 };
@@ -395,4 +405,9 @@ struct bat_algo_ops {
 				struct sk_buff *skb);
 };
 
+struct dht_candidate {
+	int type;
+	struct orig_node *orig_node;
+};
+
 #endif /* _NET_BATMAN_ADV_TYPES_H_ */
diff --git a/unicast.c b/unicast.c
index 18e5cfd..e363a48 100644
--- a/unicast.c
+++ b/unicast.c
@@ -313,10 +313,10 @@ static bool prepare_unicast_packet(struct sk_buff *skb,
 				     orig_node);
 }
 
-static bool prepare_unicast_4addr_packet(struct bat_priv *bat_priv,
-					 struct sk_buff *skb,
-					 struct orig_node *orig_node,
-					 int packet_subtype)
+bool prepare_unicast_4addr_packet(struct bat_priv *bat_priv,
+				  struct sk_buff *skb,
+				  struct orig_node *orig_node,
+				  int packet_subtype)
 {
 	struct hard_iface *primary_if;
 	struct unicast_4addr_packet *unicast_4addr_packet;
diff --git a/unicast.h b/unicast.h
index ae9775b..e15aa62 100644
--- a/unicast.h
+++ b/unicast.h
@@ -32,6 +32,10 @@ int frag_reassemble_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 void frag_list_free(struct list_head *head);
 int frag_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 		  struct hard_iface *hard_iface, const uint8_t dstaddr[]);
+bool prepare_unicast_4addr_packet(struct bat_priv *bat_priv,
+				  struct sk_buff *skb,
+				  struct orig_node *orig_node,
+				  int packet_subtype);
 int unicast_generic_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 			     int packet_type, int packet_subtype);
 
-- 
1.7.3.4


Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue,  8 Nov 2011 12:34:18 +0100
Message-Id: <1320752062-21776-4-git-send-email-ordex@autistici.org>
In-Reply-To: <1320752062-21776-1-git-send-email-ordex@autistici.org>
References: <1320752062-21776-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 3/7] batman-adv: Distributed ARP Table -
	create the DHT helper functions
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

* removed wrongly refcount increment in dht_send_data()
* removed useless brackets


 Makefile.kbuild         |    1 +
 distributed-arp-table.c |  181 +++++++++++++++++++++++++++++++++++++++++++++++
 distributed-arp-table.h |   46 ++++++++++++
 hard-interface.c        |    2 +
 main.h                  |    7 ++
 originator.c            |    1 +
 soft-interface.c        |    2 +
 types.h                 |    7 ++
 8 files changed, 247 insertions(+), 0 deletions(-)
 create mode 100644 distributed-arp-table.c
 create mode 100644 distributed-arp-table.h

diff --git a/Makefile.kbuild b/Makefile.kbuild
index bd7e93c..e8861cb 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -36,6 +36,7 @@ batman-adv-y += bat_debugfs.o
 batman-adv-y += bat_iv_ogm.o
 batman-adv-y += bat_sysfs.o
 batman-adv-y += bitarray.o
+batman-adv-y += distributed-arp-table.o
 batman-adv-y += gateway_client.o
 batman-adv-y += gateway_common.o
 batman-adv-y += hard-interface.o
diff --git a/distributed-arp-table.c b/distributed-arp-table.c
new file mode 100644
index 0000000..5bc3004
--- /dev/null
+++ b/distributed-arp-table.c
@@ -0,0 +1,181 @@
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
+/* Given a key, selects the candidates which the DHT message has to be sent to.
+ * An originator O is selected if and only if its DHT_ID value is one of three
+ * closest values (but not greater) then the hash value of the key.
+ * ip_dst is the key.
+ *
+ * return an array of size DHT_CANDIDATES_NUM */
+static struct dht_candidate *dht_select_candidates(struct bat_priv *bat_priv,
+						   uint32_t ip_dst)
+{
+	struct hashtable_t *hash = bat_priv->orig_hash;
+	struct hlist_node *node;
+	struct hlist_head *head;
+	struct orig_node *orig_node, *max_orig_node = NULL;
+	int select, i, j;
+	uint16_t last_max = USHRT_MAX, max, tmp_max, ip_key;
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
+	ip_key = hash_ipv4(&ip_dst, USHRT_MAX);
+
+	bat_dbg(DBG_ARP, bat_priv, "DHT_SEL_CAND key: %pI4 %u\n", &ip_dst,
+		ip_key);
+
+	for (select = 0; select < DHT_CANDIDATES_NUM; select++) {
+		max = 0;
+		max_orig_node = NULL;
+		if (!chosen_me) {
+			/* if true, wrap around the key space */
+			if (bat_priv->dht_hash > ip_key)
+				max = USHRT_MAX - bat_priv->dht_hash +
+					ip_key;
+			else
+				max = ip_key - bat_priv->dht_hash;
+			max = bat_priv->dht_hash;
+			res[select].type = DHT_CANDIDATE_ME;
+		} else
+			res[select].type = DHT_CANDIDATE_NULL;
+		/* for all origins... */
+		for (i = 0; i < hash->size; i++) {
+			head = &hash->table[i];
+
+			rcu_read_lock();
+			hlist_for_each_entry_rcu(orig_node, node, head,
+						 hash_entry) {
+				if (orig_node->dht_hash > ip_key)
+					tmp_max = USHRT_MAX -
+						orig_node->dht_hash + ip_key;
+				else
+					tmp_max = ip_key - orig_node->dht_hash;
+
+				/* this is closest! */
+				if (tmp_max <= max)
+					continue;
+
+				/* this has already been selected */
+				if (tmp_max > last_max)
+					continue;
+
+				/* In case of hash collision we can select two
+				 * nodes with the same hash, but we have ensure
+				 * they are different */
+				if (tmp_max == last_max) {
+					for (j = 0; j < select; j++)
+						if (res[j].orig_node ==
+						    orig_node)
+							break;
+					if (j < select)
+						continue;
+				}
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
+			bat_dbg(DBG_ARP, bat_priv, "DHT_SEL_CAND %d: %pM %u\n",
+				select, max_orig_node->orig, max);
+		}
+		if (res[select].type == DHT_CANDIDATE_ME) {
+			chosen_me = true;
+			bat_dbg(DBG_ARP, bat_priv, "DHT_SEL_CAND %d: ME %u\n",
+				select, bat_priv->dht_hash);
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
+			  uint32_t ip)
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
+		tmp_skb = prepare_unicast_packet(tmp_skb, cand[i].orig_node);
+		if (tmp_skb)
+			send_skb_packet(tmp_skb, neigh_node->if_incoming,
+					neigh_node->addr);
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
index 0000000..ee1a8b3
--- /dev/null
+++ b/distributed-arp-table.h
@@ -0,0 +1,46 @@
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
+#endif /* _NET_BATMAN_ADV_ARP_H_ */
diff --git a/hard-interface.c b/hard-interface.c
index 7704df4..3508934 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -117,6 +117,8 @@ static void primary_if_update_addr(struct bat_priv *bat_priv)
 	if (!primary_if)
 		goto out;
 
+	bat_priv->dht_hash = choose_orig(bat_priv, USHRT_MAX);
+
 	vis_packet = (struct vis_packet *)
 				bat_priv->my_vis_info->skb_packet->data;
 	memcpy(vis_packet->vis_orig, primary_if->net_dev->dev_addr, ETH_ALEN);
diff --git a/main.h b/main.h
index f3978c0..2ca7b08 100644
--- a/main.h
+++ b/main.h
@@ -64,6 +64,9 @@
 
 #define NULL_IFINDEX 0 /* dummy ifindex used to avoid iface checks */
 
+/* numbers of originator to contact for any STORE/GET DHT operation */
+#define DHT_CANDIDATES_NUM 3
+
 #define NUM_WORDS (TQ_LOCAL_WINDOW_SIZE / WORD_BIT_SIZE)
 
 #define LOG_BUF_LEN 8192	  /* has to be a power of 2 */
@@ -106,6 +109,10 @@ enum uev_type {
 
 #define GW_THRESHOLD	50
 
+#define DHT_CANDIDATE_NULL 0
+#define DHT_CANDIDATE_ME   1
+#define DHT_CANDIDATE_ORIG 2
+
 /*
  * Debug Messages
  */
diff --git a/originator.c b/originator.c
index 0bc2045..9673b44 100644
--- a/originator.c
+++ b/originator.c
@@ -222,6 +222,7 @@ struct orig_node *get_orig_node(struct bat_priv *bat_priv, const uint8_t *addr)
 	orig_node->tt_poss_change = false;
 	orig_node->bat_priv = bat_priv;
 	memcpy(orig_node->orig, addr, ETH_ALEN);
+	orig_node->dht_hash = choose_orig(addr, USHRT_MAX);
 	orig_node->router = NULL;
 	orig_node->tt_crc = 0;
 	atomic_set(&orig_node->last_ttvn, 0);
diff --git a/soft-interface.c b/soft-interface.c
index 45297c8..56a6e10 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -855,6 +855,8 @@ struct net_device *softif_create(const char *name)
 	bat_priv->primary_if = NULL;
 	bat_priv->num_ifaces = 0;
 
+	bat_priv->dht_hash = 0;
+
 	ret = sysfs_add_meshif(soft_iface);
 	if (ret < 0)
 		goto unreg_soft_iface;
diff --git a/types.h b/types.h
index ab8d0fe..837bc42 100644
--- a/types.h
+++ b/types.h
@@ -67,6 +67,7 @@ struct hard_iface {
 struct orig_node {
 	uint8_t orig[ETH_ALEN];
 	uint8_t primary_addr[ETH_ALEN];
+	uint16_t dht_hash;
 	struct neigh_node __rcu *router; /* rcu protected pointer */
 	unsigned long *bcast_own;
 	uint8_t *bcast_own_sum;
@@ -204,6 +205,7 @@ struct bat_priv {
 	struct gw_node __rcu *curr_gw;  /* rcu protected pointer */
 	atomic_t gw_reselect;
 	struct hard_iface __rcu *primary_if;  /* rcu protected pointer */
+	uint16_t dht_hash;
 	struct vis_info *my_vis_info;
 };
 
@@ -343,4 +345,9 @@ struct softif_neigh {
 	struct rcu_head rcu;
 };
 
+struct dht_candidate {
+	int type;
+	struct orig_node *orig_node;
+};
+
 #endif /* _NET_BATMAN_ADV_TYPES_H_ */
-- 
1.7.3.4


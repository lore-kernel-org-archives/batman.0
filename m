Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Fri, 10 Feb 2012 00:41:40 +0100
Message-Id: <1328830902-11574-8-git-send-email-ordex@autistici.org>
In-Reply-To: <1328830902-11574-1-git-send-email-ordex@autistici.org>
References: <1328830902-11574-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv5 7/9] batman-adv: Distributed ARP Table -
	add compile option
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

This patch makes it possible to decide whether to include DAT within the
batman-adv binary or not.
It is extremely useful when the user wants to reduce the size of the resulting
module by cutting off any not needed feature.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 Makefile                |    2 ++
 Makefile.kbuild         |    2 +-
 distributed-arp-table.c |    9 +++++++++
 distributed-arp-table.h |   16 +++++++++++++++-
 gen-compat-autoconf.sh  |    1 +
 hard-interface.c        |    2 ++
 originator.c            |    2 ++
 send.c                  |    2 --
 soft-interface.c        |    2 ++
 types.h                 |    4 ++++
 10 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 08f8c39..a54ffbc 100644
--- a/Makefile
+++ b/Makefile
@@ -23,6 +23,8 @@
 export CONFIG_BATMAN_ADV_DEBUG=n
 # B.A.T.M.A.N. bridge loop avoidance:
 export CONFIG_BATMAN_ADV_BLA=y
+# B.A.T.M.A.N. distributed ARP table:
+export CONFIG_BATMAN_ADV_DAT=n
 
 PWD:=$(shell pwd)
 KERNELPATH ?= /lib/modules/$(shell uname -r)/build
diff --git a/Makefile.kbuild b/Makefile.kbuild
index 84955b3..ad002cd 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -24,7 +24,7 @@ batman-adv-y += bat_iv_ogm.o
 batman-adv-y += bat_sysfs.o
 batman-adv-y += bitarray.o
 batman-adv-$(CONFIG_BATMAN_ADV_BLA) += bridge_loop_avoidance.o
-batman-adv-y += distributed-arp-table.o
+batman-adv-$(CONFIG_BATMAN_ADV_DAT) += distributed-arp-table.o
 batman-adv-y += gateway_client.o
 batman-adv-y += gateway_common.o
 batman-adv-y += hard-interface.o
diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 5c81086..48e97e0 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -30,10 +30,13 @@
 #include "hard-interface.h"
 #include "originator.h"
 #include "send.h"
+#include "soft-interface.h"
 #include "types.h"
 #include "translation-table.h"
 #include "unicast.h"
 
+#ifdef CONFIG_BATMAN_ADV_DEBUG
+
 static inline void bat_dbg_arp(struct bat_priv *bat_priv,
 			       struct sk_buff *skb, uint16_t type) {
 	bat_dbg(DBG_ARP, bat_priv, "ARP MSG = [src: %pM-%pI4 dst: %pM-%pI4]\n",
@@ -41,6 +44,12 @@ static inline void bat_dbg_arp(struct bat_priv *bat_priv,
 		&ARP_IP_DST(skb));
 }
 
+#else
+
+#define bat_dbg_arp(...)
+
+#endif /* CONFIG_BATMAN_ADV_DEBUG */
+
 /* Given a key, selects the candidates which the DHT message has to be sent to.
  * An originator O is selected if and only if its DHT_ID value is one of three
  * closest values (but not greater) then the hash value of the key.
diff --git a/distributed-arp-table.h b/distributed-arp-table.h
index c9c6624..98fc2e1 100644
--- a/distributed-arp-table.h
+++ b/distributed-arp-table.h
@@ -22,9 +22,12 @@
 #ifndef _NET_BATMAN_ADV_ARP_H_
 #define _NET_BATMAN_ADV_ARP_H_
 
+#ifdef CONFIG_BATMAN_ADV_DAT
+
 #include "main.h"
 
 #include <linux/if_arp.h>
+#include <linux/netdevice.h>
 
 struct bat_priv;
 struct forw_packet;
@@ -39,7 +42,7 @@ struct forw_packet;
 #define DAT_ADDR_MAX biggest_unsigned_int(dat_addr_t)
 
 #define ARP_HW_SRC(skb) ((uint8_t *)(skb->data) + sizeof(struct ethhdr) + \
-			sizeof(struct arphdr))
+		sizeof(struct arphdr))
 #define ARP_IP_SRC(skb) (*(uint32_t *)(ARP_HW_SRC(skb) + ETH_ALEN))
 #define ARP_HW_DST(skb) (ARP_HW_SRC(skb) + ETH_ALEN + 4)
 #define ARP_IP_DST(skb) (*(uint32_t *)(ARP_HW_SRC(skb) + ETH_ALEN * 2 + 4))
@@ -56,6 +59,17 @@ bool arp_drop_broadcast_packet(struct bat_priv *bat_priv,
 			       struct forw_packet *forw_packet);
 void arp_change_timeout(struct net_device *soft_iface, const char *name);
 
+#else
+
+#define dat_snoop_outgoing_arp_request(...) (0)
+#define dat_snoop_incoming_arp_request(...) (0)
+#define dat_snoop_outgoing_arp_reply(...)
+#define dat_snoop_incoming_arp_reply(...) (0)
+#define arp_drop_broadcast_packet(...) (0)
+#define arp_change_timeout(...)
+
+#endif /* CONFIG_BATMAN_ADV_DAT */
+
 /* hash function to choose an entry in a hash table of given size */
 /* hash algorithm from http://en.wikipedia.org/wiki/Hash_table */
 static inline uint32_t hash_ipv4(const void *data, uint32_t size)
diff --git a/gen-compat-autoconf.sh b/gen-compat-autoconf.sh
index 7cf621b..33de95d 100755
--- a/gen-compat-autoconf.sh
+++ b/gen-compat-autoconf.sh
@@ -38,6 +38,7 @@ gen_config() {
 # write config variables
 gen_config 'CONFIG_BATMAN_ADV_DEBUG' ${CONFIG_BATMAN_ADV_DEBUG:="n"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_BLA' ${CONFIG_BATMAN_ADV_BLA:="y"} >> "${TMP}"
+gen_config 'CONFIG_BATMAN_ADV_DAT' ${CONFIG_BATMAN_ADV_DAT:="n"} >> "${TMP}"
 
 # only regenerate compat-autoconf.h when config was changed
 diff "${TMP}" "${TARGET}" > /dev/null 2>&1 || cp "${TMP}" "${TARGET}"
diff --git a/hard-interface.c b/hard-interface.c
index 8cd4a3d..9ad30b8 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -119,9 +119,11 @@ static void primary_if_update_addr(struct bat_priv *bat_priv,
 	if (!primary_if)
 		goto out;
 
+#ifdef CONFIG_BATMAN_ADV_DAT
 	bat_priv->dht_hash = (dat_addr_t)
 				choose_orig(primary_if->net_dev->dev_addr,
 					    DAT_ADDR_MAX);
+#endif
 
 	vis_packet = (struct vis_packet *)
 				bat_priv->my_vis_info->skb_packet->data;
diff --git a/originator.c b/originator.c
index 3cade01..6130913 100644
--- a/originator.c
+++ b/originator.c
@@ -225,7 +225,9 @@ struct orig_node *get_orig_node(struct bat_priv *bat_priv, const uint8_t *addr)
 	orig_node->tt_poss_change = false;
 	orig_node->bat_priv = bat_priv;
 	memcpy(orig_node->orig, addr, ETH_ALEN);
+#ifdef CONFIG_BATMAN_ADV_DAT
 	orig_node->dht_hash = (dat_addr_t)choose_orig(addr, DAT_ADDR_MAX);
+#endif
 	orig_node->router = NULL;
 	orig_node->tt_crc = 0;
 	atomic_set(&orig_node->last_ttvn, 0);
diff --git a/send.c b/send.c
index 666a524..bc45044 100644
--- a/send.c
+++ b/send.c
@@ -30,8 +30,6 @@
 #include "gateway_common.h"
 #include "originator.h"
 
-#include <net/arp.h>
-
 static void send_outstanding_bcast_packet(struct work_struct *work);
 
 /* send out an already prepared packet to the given address via the
diff --git a/soft-interface.c b/soft-interface.c
index 7b11aef..4426e36 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -416,7 +416,9 @@ struct net_device *softif_create(const char *name)
 	if (ret < 0)
 		goto unreg_soft_iface;
 
+#ifdef CONFIG_BATMAN_ADV_DAT
 	bat_priv->dht_hash = 0;
+#endif
 
 	ret = sysfs_add_meshif(soft_iface);
 	if (ret < 0)
diff --git a/types.h b/types.h
index d1da20e..647e873 100644
--- a/types.h
+++ b/types.h
@@ -68,7 +68,9 @@ struct hard_iface {
 struct orig_node {
 	uint8_t orig[ETH_ALEN];
 	uint8_t primary_addr[ETH_ALEN];
+#ifdef CONFIG_BATMAN_ADV_DAT
 	dat_addr_t dht_hash;
+#endif
 	struct neigh_node __rcu *router; /* rcu protected pointer */
 	unsigned long *bcast_own;
 	uint8_t *bcast_own_sum;
@@ -217,7 +219,9 @@ struct bat_priv {
 	struct gw_node __rcu *curr_gw;  /* rcu protected pointer */
 	atomic_t gw_reselect;
 	struct hard_iface __rcu *primary_if;  /* rcu protected pointer */
+#ifdef CONFIG_BATMAN_ADV_DAT
 	dat_addr_t dht_hash;
+#endif
 	struct vis_info *my_vis_info;
 	struct bat_algo_ops *bat_algo_ops;
 };
-- 
1.7.3.4


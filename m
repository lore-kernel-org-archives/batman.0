Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 18 Feb 2012 17:38:53 +0100
Message-Id: <1329583133-11681-8-git-send-email-ordex@autistici.org>
In-Reply-To: <1329583133-11681-1-git-send-email-ordex@autistici.org>
References: <1329583133-11681-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv6 7/7] batman-adv: Distributed ARP Table -
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
 README.external         |    1 +
 distributed-arp-table.h |   15 +++++++++++++++
 gen-compat-autoconf.sh  |    1 +
 send.c                  |    2 --
 types.h                 |    8 ++++++++
 7 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 08f8c39..ac84fba 100644
--- a/Makefile
+++ b/Makefile
@@ -23,6 +23,8 @@
 export CONFIG_BATMAN_ADV_DEBUG=n
 # B.A.T.M.A.N. bridge loop avoidance:
 export CONFIG_BATMAN_ADV_BLA=y
+# B.A.T.M.A.N. distributed ARP table:
+export CONFIG_BATMAN_ADV_DAT=y
 
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
diff --git a/README.external b/README.external
index 1eff0f9..95a7eb4 100644
--- a/README.external
+++ b/README.external
@@ -37,6 +37,7 @@ module).  Available  options  and  their    possible   values are
 
  * CONFIG_BATMAN_ADV_DEBUG=[y|n*] (B.A.T.M.A.N. debugging)
  * CONFIG_BATMAN_ADV_BLA=[y*|n] (B.A.T.M.A.N. bridge loop avoidance)
+ * CONFIG_BATMAN_ADV_DAT=[y*|n] (B.A.T.M.A.N. Distributed ARP Table)
 
 e.g., debugging can be enabled by
 
diff --git a/distributed-arp-table.h b/distributed-arp-table.h
index bf4390d..2e37e3f 100644
--- a/distributed-arp-table.h
+++ b/distributed-arp-table.h
@@ -22,6 +22,8 @@
 #ifndef _NET_BATMAN_ADV_ARP_H_
 #define _NET_BATMAN_ADV_ARP_H_
 
+#ifdef CONFIG_BATMAN_ADV_DAT
+
 #include "types.h"
 #include "originator.h"
 
@@ -84,4 +86,17 @@ static inline void dat_init_own_dht_addr(struct bat_priv *bat_priv,
 					    DAT_ADDR_MAX);
 }
 
+#else
+
+#define dat_snoop_outgoing_arp_request(...) (0)
+#define dat_snoop_incoming_arp_request(...) (0)
+#define dat_snoop_outgoing_arp_reply(...)
+#define dat_snoop_incoming_arp_reply(...) (0)
+#define arp_drop_broadcast_packet(...) (0)
+#define arp_change_timeout(...)
+#define dat_init_orig_node_dht_addr(...)
+#define dat_init_own_dht_addr(...)
+
+#endif /* CONFIG_BATMAN_ADV_DAT */
+
 #endif /* _NET_BATMAN_ADV_ARP_H_ */
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
diff --git a/send.c b/send.c
index 8bd31bb..65c13b2 100644
--- a/send.c
+++ b/send.c
@@ -30,8 +30,6 @@
 #include "gateway_common.h"
 #include "originator.h"
 
-#include <net/arp.h>
-
 static void send_outstanding_bcast_packet(struct work_struct *work);
 
 /* send out an already prepared packet to the given address via the
diff --git a/types.h b/types.h
index 210ee3e..6a3cc88 100644
--- a/types.h
+++ b/types.h
@@ -27,6 +27,8 @@
 #include "packet.h"
 #include "bitarray.h"
 
+#ifdef CONFIG_BATMAN_ADV_DAT
+
 /*
  * dat_addr_t is the type used for all DHT addresses. If it is changed,
  * DAT_ADDR_MAX is changed as well.
@@ -35,6 +37,8 @@
  */
 #define dat_addr_t uint16_t
 
+#endif /* CONFIG_BATMAN_ADV_DAT */
+
 #define BAT_HEADER_LEN (ETH_HLEN + \
 	((sizeof(struct unicast_packet) > sizeof(struct bcast_packet) ? \
 	 sizeof(struct unicast_packet) : \
@@ -75,7 +79,9 @@ struct hard_iface {
 struct orig_node {
 	uint8_t orig[ETH_ALEN];
 	uint8_t primary_addr[ETH_ALEN];
+#ifdef CONFIG_BATMAN_ADV_DAT
 	dat_addr_t dht_addr;
+#endif
 	struct neigh_node __rcu *router; /* rcu protected pointer */
 	unsigned long *bcast_own;
 	uint8_t *bcast_own_sum;
@@ -230,7 +236,9 @@ struct bat_priv {
 	struct gw_node __rcu *curr_gw;  /* rcu protected pointer */
 	atomic_t gw_reselect;
 	struct hard_iface __rcu *primary_if;  /* rcu protected pointer */
+#ifdef CONFIG_BATMAN_ADV_DAT
 	dat_addr_t dht_addr;
+#endif
 	struct vis_info *my_vis_info;
 	struct bat_algo_ops *bat_algo_ops;
 };
-- 
1.7.3.4


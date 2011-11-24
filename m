Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 24 Nov 2011 23:21:19 +0100
Message-Id: <1322173279-18338-8-git-send-email-ordex@autistici.org>
In-Reply-To: <1322173279-18338-1-git-send-email-ordex@autistici.org>
References: <1322173279-18338-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv4 7/7] batman-adv: add Distributed ARP Table
	compile option
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

This patch makes it possible possible to decide whether to compile DAT or not.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 Makefile.kbuild         |    7 ++++++-
 README                  |    4 ++++
 distributed-arp-table.c |   28 ++++++++++++++++++++++++++++
 distributed-arp-table.h |   34 +++++++++++++++++++++++++---------
 hard-interface.c        |    2 ++
 originator.c            |    2 ++
 send.c                  |    2 --
 soft-interface.c        |   19 +++----------------
 types.h                 |    4 ++++
 9 files changed, 74 insertions(+), 28 deletions(-)

diff --git a/Makefile.kbuild b/Makefile.kbuild
index e8861cb..7e3b9e5 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -18,6 +18,9 @@
 # 02110-1301, USA
 #
 
+# uncomment the following line to enable the related feature
+# Distributed ARP Table:
+# CONFIG_BATMAN_ADV_DAT=y
 
 
 # openwrt integration
@@ -27,6 +30,8 @@ endif
 
 # ccflags-y += -DCONFIG_BATMAN_ADV_DEBUG
 
+ccflags-$(CONFIG_BATMAN_ADV_DAT) += -DCONFIG_BATMAN_ADV_DAT
+
 ifneq ($(REVISION),)
 ccflags-y += -DSOURCE_VERSION=\"$(REVISION)\"
 endif
@@ -36,7 +41,7 @@ batman-adv-y += bat_debugfs.o
 batman-adv-y += bat_iv_ogm.o
 batman-adv-y += bat_sysfs.o
 batman-adv-y += bitarray.o
-batman-adv-y += distributed-arp-table.o
+batman-adv-$(CONFIG_BATMAN_ADV_DAT) += distributed-arp-table.o
 batman-adv-y += gateway_client.o
 batman-adv-y += gateway_common.o
 batman-adv-y += hard-interface.o
diff --git a/README b/README
index 856ca7e..06f1469 100644
--- a/README
+++ b/README
@@ -26,6 +26,10 @@ it.  If you work on a backport, feel free to contact us.  :-)
 COMPILE
 -------
 
+Before compiling you want to have a look at the Makefile.kbuild
+file to enable/disable wanted features. Actually there are:
+- CONFIG_BATMAN_ADV_DAT enables the Distributed ARP Table
+
 To compile against your currently installed  kernel, just type:
 
 # make
diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index a1deb79..8876ec5 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -23,15 +23,19 @@
 #include <linux/if_arp.h>
 /* needed to use arp_tbl */
 #include <net/arp.h>
+#include <linux/inetdevice.h>
 
 #include "main.h"
 #include "distributed-arp-table.h"
 #include "hard-interface.h"
 #include "originator.h"
 #include "send.h"
+#include "soft-interface.h"
 #include "types.h"
 #include "unicast.h"
 
+#ifdef CONFIG_BATMAN_ADV_DEBUG
+
 static inline void bat_dbg_arp(struct bat_priv *bat_priv,
 			       struct sk_buff *skb, uint16_t type) {
 	char buf[30];
@@ -48,6 +52,12 @@ static inline void bat_dbg_arp(struct bat_priv *bat_priv,
 		ARP_HW_DST(skb), &ARP_IP_DST(skb));
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
@@ -465,3 +475,21 @@ bool arp_drop_broadcast_packet(struct bat_priv *bat_priv,
 	}
 	return false;
 }
+
+void arp_change_timeout(struct net_device *soft_iface, const char *name)
+{
+	struct in_device *in_dev = in_dev_get(soft_iface);
+	if (!in_dev) {
+		pr_err("Unable to set ARP parameters for the batman interface "
+		       "'%s'\n", name);
+		return;
+	}
+
+	/* Introduce a delay in the ARP state-machine transactions. Entries
+	 * will be kept in the ARP table for the default time multiplied by 4 */
+	in_dev->arp_parms->base_reachable_time *= ARP_TIMEOUT_FACTOR;
+	in_dev->arp_parms->gc_staletime *= ARP_TIMEOUT_FACTOR;
+	in_dev->arp_parms->reachable_time *= ARP_TIMEOUT_FACTOR;
+
+	in_dev_put(in_dev);
+}
diff --git a/distributed-arp-table.h b/distributed-arp-table.h
index 3747aad..71eaeaf 100644
--- a/distributed-arp-table.h
+++ b/distributed-arp-table.h
@@ -22,36 +22,52 @@
 #ifndef _NET_BATMAN_ADV_ARP_H_
 #define _NET_BATMAN_ADV_ARP_H_
 
+#ifdef CONFIG_BATMAN_ADV_DAT
+
 #include "main.h"
 
 #include <linux/if_arp.h>
+#include <linux/netdevice.h>
 
 struct bat_priv;
 struct forw_packet;
 
 /*
- * dat_addr_t is the type used for all DHT indexes. If it is changed,
- * DAT_ADDR_MAX is changed as well.
- *
- * *Please be careful: dat_addr_t must be UNSIGNED*
- */
+* dat_addr_t is the type used for all DHT indexes. If it is changed,
+* DAT_ADDR_MAX is changed as well.
+*
+* *Please be careful: dat_addr_t must be UNSIGNED*
+*/
 #define dat_addr_t uint16_t
 #define DAT_ADDR_MAX biggest_unsigned_int(dat_addr_t)
 
 #define ARP_HW_SRC(skb) ((uint8_t *)(skb->data) + sizeof(struct ethhdr) + \
-			sizeof(struct arphdr))
+		sizeof(struct arphdr))
 #define ARP_IP_SRC(skb) (*(uint32_t *)(ARP_HW_SRC(skb) + ETH_ALEN))
 #define ARP_HW_DST(skb) (ARP_HW_SRC(skb) + ETH_ALEN + 4)
 #define ARP_IP_DST(skb) (*(uint32_t *)(ARP_HW_SRC(skb) + ETH_ALEN * 2 + 4))
 
+
 bool arp_snoop_outgoing_request(struct bat_priv *bat_priv,
-				struct sk_buff *skb);
+			struct sk_buff *skb);
 bool arp_snoop_incoming_request(struct bat_priv *bat_priv,
-				struct sk_buff *skb);
+			struct sk_buff *skb);
 bool arp_snoop_outgoing_reply(struct bat_priv *bat_priv, struct sk_buff *skb);
 bool arp_snoop_incoming_reply(struct bat_priv *bat_priv, struct sk_buff *skb);
 bool arp_drop_broadcast_packet(struct bat_priv *bat_priv,
-			       struct forw_packet *forw_packet);
+		       struct forw_packet *forw_packet);
+void arp_change_timeout(struct net_device *soft_iface, const char *name);
+
+#else
+
+#define arp_snoop_outgoing_request(...) (0)
+#define arp_snoop_incoming_request(...) (0)
+#define arp_snoop_outgoing_reply(...)
+#define arp_snoop_incoming_reply(...)
+#define arp_drop_broadcast_packet(...) (0)
+#define arp_change_timeout(...)
+
+#endif /* CONFIG_BATMAN_ADV_DAT */
 
 /* hash function to choose an entry in a hash table of given size */
 /* hash algorithm from http://en.wikipedia.org/wiki/Hash_table */
diff --git a/hard-interface.c b/hard-interface.c
index 4a6948c..af17c9c 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -118,9 +118,11 @@ static void primary_if_update_addr(struct bat_priv *bat_priv)
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
index 14fb6d8..270c1c3 100644
--- a/originator.c
+++ b/originator.c
@@ -224,7 +224,9 @@ struct orig_node *get_orig_node(struct bat_priv *bat_priv, const uint8_t *addr)
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
index d625998..2b7ddc9 100644
--- a/send.c
+++ b/send.c
@@ -31,8 +31,6 @@
 #include "originator.h"
 #include "bat_ogm.h"
 
-#include <net/arp.h>
-
 static void send_outstanding_bcast_packet(struct work_struct *work);
 
 /* send out an already prepared packet to the given address via the
diff --git a/soft-interface.c b/soft-interface.c
index 1194cf7..96ebd38 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -36,7 +36,6 @@
 #include <linux/ethtool.h>
 #include <linux/etherdevice.h>
 #include <linux/if_vlan.h>
-#include <linux/inetdevice.h>
 #include "unicast.h"
 
 
@@ -826,7 +825,6 @@ static void interface_setup(struct net_device *dev)
 struct net_device *softif_create(const char *name)
 {
 	struct net_device *soft_iface;
-	struct in_device *in_dev;
 	struct bat_priv *bat_priv;
 	int ret;
 
@@ -842,20 +840,7 @@ struct net_device *softif_create(const char *name)
 		goto free_soft_iface;
 	}
 
-	in_dev = in_dev_get(soft_iface);
-	if (!in_dev) {
-		pr_err("Unable to set ARP parameters for the batman interface "
-		       "'%s'\n", name);
-		goto free_soft_iface;
-	}
-
-	/* Introduce a delay in the ARP state-machine transactions. Entries
-	 * will be kept in the ARP table for the default time multiplied by 4 */
-	in_dev->arp_parms->base_reachable_time *= ARP_TIMEOUT_FACTOR;
-	in_dev->arp_parms->gc_staletime *= ARP_TIMEOUT_FACTOR;
-	in_dev->arp_parms->reachable_time *= ARP_TIMEOUT_FACTOR;
-
-	in_dev_put(in_dev);
+	arp_change_timeout(soft_iface, name);
 
 	bat_priv = netdev_priv(soft_iface);
 
@@ -886,7 +871,9 @@ struct net_device *softif_create(const char *name)
 	bat_priv->primary_if = NULL;
 	bat_priv->num_ifaces = 0;
 
+#ifdef CONFIG_BATMAN_ADV_DAT
 	bat_priv->dht_hash = 0;
+#endif
 
 	ret = sysfs_add_meshif(soft_iface);
 	if (ret < 0)
diff --git a/types.h b/types.h
index afd166b..27751f2 100644
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
@@ -207,7 +209,9 @@ struct bat_priv {
 	struct gw_node __rcu *curr_gw;  /* rcu protected pointer */
 	atomic_t gw_reselect;
 	struct hard_iface __rcu *primary_if;  /* rcu protected pointer */
+#ifdef CONFIG_BATMAN_ADV_DAT
 	dat_addr_t dht_hash;
+#endif
 	struct vis_info *my_vis_info;
 };
 
-- 
1.7.3.4


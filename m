Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 25 Apr 2012 15:27:04 +0200
Message-Id: <1335360431-30027-9-git-send-email-ordex@autistici.org>
In-Reply-To: <1335360431-30027-1-git-send-email-ordex@autistici.org>
References: <1335360431-30027-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 08/15] batman-adv: Distributed ARP Table -
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

This patch makes it possible to decide whether to include DAT within the
batman-adv binary or not.
It is extremely useful when the user wants to reduce the size of the resulting
module by cutting off any not needed feature.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/Kconfig                 |   12 +++++++-
 net/batman-adv/Makefile                |    2 +-
 net/batman-adv/distributed-arp-table.h |   52 ++++++++++++++++++++++++++++++++
 net/batman-adv/types.h                 |    8 +++++
 4 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index b25e20f..250e0b5 100644
--- a/net/batman-adv/Kconfig
+++ b/net/batman-adv/Kconfig
@@ -4,7 +4,7 @@
 
 config BATMAN_ADV
 	tristate "B.A.T.M.A.N. Advanced Meshing Protocol"
-	depends on NET && INET
+	depends on NET
 	select CRC16
         default n
 	help
@@ -25,6 +25,16 @@ config BATMAN_ADV_BLA
 	  more than one mesh node in the same LAN, you can safely remove
 	  this feature and save some space.
 
+config BATMAN_ADV_DAT
+	bool "Distributed ARP Table"
+	depends on BATMAN_ADV && INET
+	default n
+	help
+	  This option enables DAT (Distributed ARP Table), a DHT based
+	  mechanism that increases ARP reliability on sparse wireless
+	  mesh networks. If you think that your network does not need
+	  this option you can safely remove it and save some space.
+
 config BATMAN_ADV_DEBUG
 	bool "B.A.T.M.A.N. debugging"
 	depends on BATMAN_ADV
diff --git a/net/batman-adv/Makefile b/net/batman-adv/Makefile
index 84955b3..ad002cd 100644
--- a/net/batman-adv/Makefile
+++ b/net/batman-adv/Makefile
@@ -24,7 +24,7 @@ batman-adv-y += bat_iv_ogm.o
 batman-adv-y += bat_sysfs.o
 batman-adv-y += bitarray.o
 batman-adv-$(CONFIG_BATMAN_ADV_BLA) += bridge_loop_avoidance.o
-batman-adv-y += distributed-arp-table.o
+batman-adv-$(CONFIG_BATMAN_ADV_DAT) += distributed-arp-table.o
 batman-adv-y += gateway_client.o
 batman-adv-y += gateway_common.o
 batman-adv-y += hard-interface.o
diff --git a/net/batman-adv/distributed-arp-table.h b/net/batman-adv/distributed-arp-table.h
index 3a4f710..e55067b 100644
--- a/net/batman-adv/distributed-arp-table.h
+++ b/net/batman-adv/distributed-arp-table.h
@@ -22,6 +22,8 @@
 #ifndef _NET_BATMAN_ADV_ARP_H_
 #define _NET_BATMAN_ADV_ARP_H_
 
+#ifdef CONFIG_BATMAN_ADV_DAT
+
 #include "types.h"
 #include "originator.h"
 
@@ -85,4 +87,54 @@ static inline void dat_init_own_dht_addr(struct bat_priv *bat_priv,
 					    DAT_ADDR_MAX);
 }
 
+#else
+
+static inline bool dat_snoop_outgoing_arp_request(struct bat_priv *bat_priv,
+						  struct sk_buff *skb)
+{
+	return false;
+}
+
+static inline bool dat_snoop_incoming_arp_request(struct bat_priv *bat_priv,
+						  struct sk_buff *skb,
+						  int hdr_size)
+{
+	return false;
+}
+
+static inline bool dat_snoop_outgoing_arp_reply(struct bat_priv *bat_priv,
+						struct sk_buff *skb)
+{
+	return false;
+}
+
+static inline bool dat_snoop_incoming_arp_reply(struct bat_priv *bat_priv,
+						struct sk_buff *skb,
+						int hdr_size)
+{
+	return false;
+}
+
+static inline bool dat_drop_broadcast_packet(struct bat_priv *bat_priv,
+					     struct forw_packet *forw_packet)
+{
+	return false;
+}
+
+static inline void dat_init_orig_node_dht_addr(struct orig_node *orig_node)
+{
+}
+
+static inline void dat_init_own_dht_addr(struct bat_priv *bat_priv,
+					 struct hard_iface *primary_if)
+{
+}
+
+static inline void arp_change_timeout(struct net_device *soft_iface,
+				      const char *name)
+{
+}
+
+#endif /* CONFIG_BATMAN_ADV_DAT */
+
 #endif /* _NET_BATMAN_ADV_ARP_H_ */
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 61e2d78..2b8ffcb 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -27,6 +27,8 @@
 #include "packet.h"
 #include "bitarray.h"
 
+#ifdef CONFIG_BATMAN_ADV_DAT
+
 /* dat_addr_t is the type used for all DHT addresses. If it is changed,
  * DAT_ADDR_MAX is changed as well.
  *
@@ -34,6 +36,8 @@
  */
 #define dat_addr_t uint16_t
 
+#endif /* CONFIG_BATMAN_ADV_DAT */
+
 #define BAT_HEADER_LEN (ETH_HLEN + \
 	((sizeof(struct unicast_packet) > sizeof(struct bcast_packet) ? \
 	 sizeof(struct unicast_packet) : \
@@ -74,7 +78,9 @@ struct hard_iface {
 struct orig_node {
 	uint8_t orig[ETH_ALEN];
 	uint8_t primary_addr[ETH_ALEN];
+#ifdef CONFIG_BATMAN_ADV_DAT
 	dat_addr_t dht_addr;
+#endif
 	struct neigh_node __rcu *router; /* rcu protected pointer */
 	unsigned long *bcast_own;
 	uint8_t *bcast_own_sum;
@@ -229,7 +235,9 @@ struct bat_priv {
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
1.7.9.4


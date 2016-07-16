Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 16 Jul 2016 09:31:20 +0200
Message-Id: <1468654280-10200-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v2] batman-adv: Allow to disable debugfs
	support
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

The files provided by batman-adv via debugfs are currently converted to
netlink. Tools which are not yet converted to use the netlink interface may
still rely on the old debugfs files. But systems which already upgraded
their tools can save some space by disabling this feature. The default
configuration of batman-adv on amd64 can reduce the size of the module by
around 11% when this feature is disabled.

    $ size net/batman-adv/batman-adv.ko*
       text    data     bss     dec     hex filename
     150507   10395    4160  165062   284c6 net/batman-adv/batman-adv.ko.y
     137106    7099    2112  146317   23b8d net/batman-adv/batman-adv.ko.n

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
 - remove bogus "Before:" line in commit message

 Makefile                               |  3 +++
 README.external                        |  1 +
 compat.h                               |  5 +++++
 gen-compat-autoconf.sh                 |  1 +
 net/batman-adv/Kconfig                 | 15 +++++++++++++--
 net/batman-adv/Makefile                |  4 ++--
 net/batman-adv/bat_algo.c              |  2 ++
 net/batman-adv/bat_iv_ogm.c            | 12 ++++++++++++
 net/batman-adv/bat_v.c                 | 12 ++++++++++++
 net/batman-adv/bridge_loop_avoidance.c |  4 ++++
 net/batman-adv/debugfs.h               |  2 +-
 net/batman-adv/distributed-arp-table.c |  2 ++
 net/batman-adv/gateway_client.c        |  2 ++
 net/batman-adv/icmp_socket.h           | 18 +++++++++++++++++-
 net/batman-adv/main.c                  |  2 ++
 net/batman-adv/multicast.c             |  2 ++
 net/batman-adv/network-coding.c        |  2 ++
 net/batman-adv/originator.c            |  4 ++++
 net/batman-adv/translation-table.c     |  4 ++++
 net/batman-adv/types.h                 |  6 ++++++
 20 files changed, 97 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 725c70b..d42bb56 100644
--- a/Makefile
+++ b/Makefile
@@ -17,6 +17,8 @@
 #
 
 # read README.external for more information about the configuration
+# batman-adv DebugFS entries:
+export CONFIG_BATMAN_ADV_DEBUGFS=y
 # B.A.T.M.A.N. debugging:
 export CONFIG_BATMAN_ADV_DEBUG=n
 # B.A.T.M.A.N. bridge loop avoidance:
@@ -66,6 +68,7 @@ BUILD_FLAGS := \
 	REVISION=$(REVISION) \
 	CONFIG_BATMAN_ADV=m \
 	CONFIG_BATMAN_ADV_DEBUG=$(CONFIG_BATMAN_ADV_DEBUG) \
+	CONFIG_BATMAN_ADV_DEBUGFS=$(CONFIG_BATMAN_ADV_DEBUGFS) \
 	CONFIG_BATMAN_ADV_BLA=$(CONFIG_BATMAN_ADV_BLA) \
 	CONFIG_BATMAN_ADV_DAT=$(CONFIG_BATMAN_ADV_DAT) \
 	CONFIG_BATMAN_ADV_NC=$(CONFIG_BATMAN_ADV_NC) \
diff --git a/README.external b/README.external
index 8393c27..ec04364 100644
--- a/README.external
+++ b/README.external
@@ -35,6 +35,7 @@ option  can be set to to y (enabled), n (disabled) or m (build as
 module).  Available  options  and  their    possible   values are
 (default marked with an "*")
 
+ * CONFIG_BATMAN_ADV_DEBUGFS=[y*|n] (B.A.T.M.A.N. debugfs entries)
  * CONFIG_BATMAN_ADV_DEBUG=[y|n*] (B.A.T.M.A.N. debugging)
  * CONFIG_BATMAN_ADV_BLA=[y*|n] (B.A.T.M.A.N. bridge loop avoidance)
  * CONFIG_BATMAN_ADV_DAT=[y*|n] (B.A.T.M.A.N. Distributed ARP Table)
diff --git a/compat.h b/compat.h
index fc78948..d987577 100644
--- a/compat.h
+++ b/compat.h
@@ -27,6 +27,11 @@
 
 #include "compat-autoconf.h"
 
+/* test for dependency CONFIG_BATMAN_ADV_DEBUG -> CONFIG_BATMAN_ADV_DEBUGFS */
+#if defined(CONFIG_BATMAN_ADV_DEBUG) && !defined(CONFIG_BATMAN_ADV_DEBUGFS)
+#error CONFIG_BATMAN_ADV_DEBUG=y requires CONFIG_BATMAN_ADV_DEBUGFS=y
+#endif
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 9, 0)
 
 #include <linux/netdevice.h>
diff --git a/gen-compat-autoconf.sh b/gen-compat-autoconf.sh
index 396357a..cf36e55 100755
--- a/gen-compat-autoconf.sh
+++ b/gen-compat-autoconf.sh
@@ -36,6 +36,7 @@ gen_config() {
 }
 
 # write config variables
+gen_config 'CONFIG_BATMAN_ADV_DEBUGFS' ${CONFIG_BATMAN_ADV_DEBUGFS:="y"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_DEBUG' ${CONFIG_BATMAN_ADV_DEBUG:="n"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_BLA' ${CONFIG_BATMAN_ADV_BLA:="y"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_DAT' ${CONFIG_BATMAN_ADV_DAT:="y"} >> "${TMP}"
diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index b7ba97d..d9b71a1 100644
--- a/net/batman-adv/Kconfig
+++ b/net/batman-adv/Kconfig
@@ -73,10 +73,21 @@ config BATMAN_ADV_MCAST
 	  reduce the air overhead while improving the reliability of
 	  multicast messages.
 
-config BATMAN_ADV_DEBUG
-	bool "B.A.T.M.A.N. debugging"
+config BATMAN_ADV_DEBUGFS
+	bool "batman-adv debugfs entries"
 	depends on BATMAN_ADV
 	depends on DEBUG_FS
+	default y
+	help
+	  Enable this to export routing related debug tables via debugfs.
+	  The information for each soft-interface and used hard-interface can be
+	  found under batman_adv/
+
+	  If unsure, say Y.
+
+config BATMAN_ADV_DEBUG
+	bool "B.A.T.M.A.N. debugging"
+	depends on BATMAN_ADV_DEBUGFS
 	help
 	  This is an option for use by developers; most people should
 	  say N here. This enables compilation of support for
diff --git a/net/batman-adv/Makefile b/net/batman-adv/Makefile
index a83fc6c..f724d3c 100644
--- a/net/batman-adv/Makefile
+++ b/net/batman-adv/Makefile
@@ -24,14 +24,14 @@ batman-adv-$(CONFIG_BATMAN_ADV_BATMAN_V) += bat_v_elp.o
 batman-adv-$(CONFIG_BATMAN_ADV_BATMAN_V) += bat_v_ogm.o
 batman-adv-y += bitarray.o
 batman-adv-$(CONFIG_BATMAN_ADV_BLA) += bridge_loop_avoidance.o
-batman-adv-$(CONFIG_DEBUG_FS) += debugfs.o
+batman-adv-$(CONFIG_BATMAN_ADV_DEBUGFS) += debugfs.o
 batman-adv-$(CONFIG_BATMAN_ADV_DAT) += distributed-arp-table.o
 batman-adv-y += fragmentation.o
 batman-adv-y += gateway_client.o
 batman-adv-y += gateway_common.o
 batman-adv-y += hard-interface.o
 batman-adv-y += hash.o
-batman-adv-y += icmp_socket.o
+batman-adv-$(CONFIG_BATMAN_ADV_DEBUGFS) += icmp_socket.o
 batman-adv-$(CONFIG_BATMAN_ADV_DEBUG) += log.o
 batman-adv-y += main.o
 batman-adv-$(CONFIG_BATMAN_ADV_MCAST) += multicast.o
diff --git a/net/batman-adv/bat_algo.c b/net/batman-adv/bat_algo.c
index f2cc50d..623d043 100644
--- a/net/batman-adv/bat_algo.c
+++ b/net/batman-adv/bat_algo.c
@@ -101,6 +101,7 @@ int batadv_algo_select(struct batadv_priv *bat_priv, char *name)
 	return 0;
 }
 
+#ifdef CONFIG_BATMAN_ADV_DEBUGFS
 int batadv_algo_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct batadv_algo_ops *bat_algo_ops;
@@ -113,6 +114,7 @@ int batadv_algo_seq_print_text(struct seq_file *seq, void *offset)
 
 	return 0;
 }
+#endif
 
 static int batadv_param_set_ra(const char *val, const struct kernel_param *kp)
 {
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 432a213..9b2e9d5 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1874,6 +1874,7 @@ static int batadv_iv_ogm_receive(struct sk_buff *skb,
 	return NET_RX_SUCCESS;
 }
 
+#ifdef CONFIG_BATMAN_ADV_DEBUGFS
 /**
  * batadv_iv_ogm_orig_print_neigh - print neighbors for the originator table
  * @orig_node: the orig_node for which the neighbors are printed
@@ -1971,6 +1972,7 @@ next:
 	if (batman_count == 0)
 		seq_puts(seq, "No batman nodes in range ...\n");
 }
+#endif
 
 /**
  * batadv_iv_ogm_neigh_get_tq_avg - Get the TQ average for a neighbour on a
@@ -2201,6 +2203,7 @@ batadv_iv_ogm_orig_dump(struct sk_buff *msg, struct netlink_callback *cb,
 	cb->args[2] = sub;
 }
 
+#ifdef CONFIG_BATMAN_ADV_DEBUGFS
 /**
  * batadv_iv_hardif_neigh_print - print a single hop neighbour node
  * @seq: neighbour table seq_file struct
@@ -2251,6 +2254,7 @@ static void batadv_iv_neigh_print(struct batadv_priv *bat_priv,
 	if (batman_count == 0)
 		seq_puts(seq, "No batman nodes in range ...\n");
 }
+#endif
 
 /**
  * batadv_iv_ogm_neigh_dump_neigh - Dump a neighbour into a netlink message
@@ -2620,6 +2624,7 @@ out:
 	return ret;
 }
 
+#ifdef CONFIG_BATMAN_ADV_DEBUGFS
 /* fails if orig_node has no router */
 static int batadv_iv_gw_write_buffer_text(struct batadv_priv *bat_priv,
 					  struct seq_file *seq,
@@ -2683,6 +2688,7 @@ static void batadv_iv_gw_print(struct batadv_priv *bat_priv,
 	if (gw_count == 0)
 		seq_puts(seq, "No gateways in range ...\n");
 }
+#endif
 
 /**
  * batadv_iv_gw_dump_entry - Dump a gateway into a message
@@ -2800,11 +2806,15 @@ static struct batadv_algo_ops batadv_batman_iv __read_mostly = {
 	.neigh = {
 		.cmp = batadv_iv_ogm_neigh_cmp,
 		.is_similar_or_better = batadv_iv_ogm_neigh_is_sob,
+#ifdef CONFIG_BATMAN_ADV_DEBUGFS
 		.print = batadv_iv_neigh_print,
+#endif
 		.dump = batadv_iv_ogm_neigh_dump,
 	},
 	.orig = {
+#ifdef CONFIG_BATMAN_ADV_DEBUGFS
 		.print = batadv_iv_ogm_orig_print,
+#endif
 		.dump = batadv_iv_ogm_orig_dump,
 		.free = batadv_iv_ogm_orig_free,
 		.add_if = batadv_iv_ogm_orig_add_if,
@@ -2813,7 +2823,9 @@ static struct batadv_algo_ops batadv_batman_iv __read_mostly = {
 	.gw = {
 		.get_best_gw_node = batadv_iv_gw_get_best_gw_node,
 		.is_eligible = batadv_iv_gw_is_eligible,
+#ifdef CONFIG_BATMAN_ADV_DEBUGFS
 		.print = batadv_iv_gw_print,
+#endif
 		.dump = batadv_iv_gw_dump,
 	},
 };
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 9e872dc..e79f6f0 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -129,6 +129,7 @@ batadv_v_hardif_neigh_init(struct batadv_hardif_neigh_node *hardif_neigh)
 		  batadv_v_elp_throughput_metric_update);
 }
 
+#ifdef CONFIG_BATMAN_ADV_DEBUGFS
 /**
  * batadv_v_orig_print_neigh - print neighbors for the originator table
  * @orig_node: the orig_node for which the neighbors are printed
@@ -212,6 +213,7 @@ static void batadv_v_neigh_print(struct batadv_priv *bat_priv,
 	if (batman_count == 0)
 		seq_puts(seq, "No batman nodes in range ...\n");
 }
+#endif
 
 /**
  * batadv_v_neigh_dump_neigh - Dump a neighbour into a message
@@ -345,6 +347,7 @@ batadv_v_neigh_dump(struct sk_buff *msg, struct netlink_callback *cb,
 	cb->args[1] = idx;
 }
 
+#ifdef CONFIG_BATMAN_ADV_DEBUGFS
 /**
  * batadv_v_orig_print - print the originator table
  * @bat_priv: the bat priv with all the soft interface information
@@ -411,6 +414,7 @@ next:
 	if (batman_count == 0)
 		seq_puts(seq, "No batman nodes in range ...\n");
 }
+#endif
 
 /**
  * batadv_v_orig_dump_subentry - Dump an originator subentry into a
@@ -827,6 +831,7 @@ out:
 	return ret;
 }
 
+#ifdef CONFIG_BATMAN_ADV_DEBUGFS
 /* fails if orig_node has no router */
 static int batadv_v_gw_write_buffer_text(struct batadv_priv *bat_priv,
 					 struct seq_file *seq,
@@ -896,6 +901,7 @@ static void batadv_v_gw_print(struct batadv_priv *bat_priv,
 	if (gw_count == 0)
 		seq_puts(seq, "No gateways in range ...\n");
 }
+#endif
 
 /**
  * batadv_v_gw_dump_entry - Dump a gateway into a message
@@ -1034,11 +1040,15 @@ static struct batadv_algo_ops batadv_batman_v __read_mostly = {
 		.hardif_init = batadv_v_hardif_neigh_init,
 		.cmp = batadv_v_neigh_cmp,
 		.is_similar_or_better = batadv_v_neigh_is_sob,
+#ifdef CONFIG_BATMAN_ADV_DEBUGFS
 		.print = batadv_v_neigh_print,
+#endif
 		.dump = batadv_v_neigh_dump,
 	},
 	.orig = {
+#ifdef CONFIG_BATMAN_ADV_DEBUGFS
 		.print = batadv_v_orig_print,
+#endif
 		.dump = batadv_v_orig_dump,
 	},
 	.gw = {
@@ -1046,7 +1056,9 @@ static struct batadv_algo_ops batadv_batman_v __read_mostly = {
 		.show_sel_class = batadv_v_show_sel_class,
 		.get_best_gw_node = batadv_v_gw_get_best_gw_node,
 		.is_eligible = batadv_v_gw_is_eligible,
+#ifdef CONFIG_BATMAN_ADV_DEBUGFS
 		.print = batadv_v_gw_print,
+#endif
 		.dump = batadv_v_gw_dump,
 	},
 };
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 42e216d..ece6b50 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1934,6 +1934,7 @@ out:
 	return ret;
 }
 
+#ifdef CONFIG_BATMAN_ADV_DEBUGFS
 /**
  * batadv_bla_claim_table_seq_print_text - print the claim table in a seq file
  * @seq: seq file to print on
@@ -1989,6 +1990,7 @@ out:
 		batadv_hardif_put(primary_if);
 	return 0;
 }
+#endif
 
 /**
  * batadv_bla_claim_dump_entry - dump one entry of the claim table
@@ -2152,6 +2154,7 @@ out:
 	return ret;
 }
 
+#ifdef CONFIG_BATMAN_ADV_DEBUGFS
 /**
  * batadv_bla_backbone_table_seq_print_text - print the backbone table in a seq
  *  file
@@ -2215,6 +2218,7 @@ out:
 		batadv_hardif_put(primary_if);
 	return 0;
 }
+#endif
 
 /**
  * batadv_bla_backbone_dump_entry - dump one entry of the backbone table
diff --git a/net/batman-adv/debugfs.h b/net/batman-adv/debugfs.h
index 1ab4e2e..c68ff3d 100644
--- a/net/batman-adv/debugfs.h
+++ b/net/batman-adv/debugfs.h
@@ -26,7 +26,7 @@ struct net_device;
 
 #define BATADV_DEBUGFS_SUBDIR "batman_adv"
 
-#if IS_ENABLED(CONFIG_DEBUG_FS)
+#if IS_ENABLED(CONFIG_BATMAN_ADV_DEBUGFS)
 
 void batadv_debugfs_init(void);
 void batadv_debugfs_destroy(void);
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index fa76465..599a255 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -795,6 +795,7 @@ void batadv_dat_free(struct batadv_priv *bat_priv)
 	batadv_dat_hash_free(bat_priv);
 }
 
+#ifdef CONFIG_BATMAN_ADV_DEBUGFS
 /**
  * batadv_dat_cache_seq_print_text - print the local DAT hash table
  * @seq: seq file to print on
@@ -846,6 +847,7 @@ out:
 		batadv_hardif_put(primary_if);
 	return 0;
 }
+#endif
 
 /**
  * batadv_arp_get_type - parse an ARP packet and gets the type
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index c2928c2..b6d4794 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -478,6 +478,7 @@ void batadv_gw_node_free(struct batadv_priv *bat_priv)
 	spin_unlock_bh(&bat_priv->gw.list_lock);
 }
 
+#ifdef CONFIG_BATMAN_ADV_DEBUGFS
 int batadv_gw_client_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
@@ -505,6 +506,7 @@ int batadv_gw_client_seq_print_text(struct seq_file *seq, void *offset)
 
 	return 0;
 }
+#endif
 
 /**
  * batadv_gw_dump - Dump gateways into a message
diff --git a/net/batman-adv/icmp_socket.h b/net/batman-adv/icmp_socket.h
index 618d5de..e44a7da 100644
--- a/net/batman-adv/icmp_socket.h
+++ b/net/batman-adv/icmp_socket.h
@@ -26,9 +26,25 @@ struct batadv_icmp_header;
 
 #define BATADV_ICMP_SOCKET "socket"
 
-void batadv_socket_init(void);
 int batadv_socket_setup(struct batadv_priv *bat_priv);
+
+#ifdef CONFIG_BATMAN_ADV_DEBUGFS
+
+void batadv_socket_init(void);
 void batadv_socket_receive_packet(struct batadv_icmp_header *icmph,
 				  size_t icmp_len);
 
+#else
+
+static inline void batadv_socket_init(void)
+{
+}
+
+static inline void
+batadv_socket_receive_packet(struct batadv_icmp_header *icmph, size_t icmp_len)
+{
+}
+
+#endif
+
 #endif /* _NET_BATMAN_ADV_ICMP_SOCKET_H_ */
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index f61479b..523dd73 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -270,6 +270,7 @@ bool batadv_is_my_mac(struct batadv_priv *bat_priv, const u8 *addr)
 	return is_my_mac;
 }
 
+#ifdef CONFIG_BATMAN_ADV_DEBUGFS
 /**
  * batadv_seq_print_text_primary_if_get - called from debugfs table printing
  *  function that requires the primary interface
@@ -305,6 +306,7 @@ batadv_seq_print_text_primary_if_get(struct seq_file *seq)
 out:
 	return primary_if;
 }
+#endif
 
 /**
  * batadv_max_header_len - calculate maximum encapsulation overhead for a
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index cc91507..ffedfc2 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -1134,6 +1134,7 @@ void batadv_mcast_init(struct batadv_priv *bat_priv)
 				     BATADV_TVLV_HANDLER_OGM_CIFNOTFND);
 }
 
+#ifdef CONFIG_BATMAN_ADV_DEBUGFS
 /**
  * batadv_mcast_flags_print_header - print own mcast flags to debugfs table
  * @bat_priv: the bat priv with all the soft interface information
@@ -1234,6 +1235,7 @@ int batadv_mcast_flags_seq_print_text(struct seq_file *seq, void *offset)
 
 	return 0;
 }
+#endif
 
 /**
  * batadv_mcast_free - free the multicast optimizations structures
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 293ef4f..8e6c5d8 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -1882,6 +1882,7 @@ void batadv_nc_mesh_free(struct batadv_priv *bat_priv)
 	batadv_hash_destroy(bat_priv->nc.decoding_hash);
 }
 
+#ifdef CONFIG_BATMAN_ADV_DEBUGFS
 /**
  * batadv_nc_nodes_seq_print_text - print the nc node information
  * @seq: seq file to print on
@@ -1981,3 +1982,4 @@ int batadv_nc_init_debugfs(struct batadv_priv *bat_priv)
 out:
 	return -ENOMEM;
 }
+#endif
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 703a6a2..72f4f8a 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -692,6 +692,7 @@ batadv_neigh_node_get_or_create(struct batadv_orig_node *orig_node,
 	return batadv_neigh_node_create(orig_node, hard_iface, neigh_addr);
 }
 
+#ifdef CONFIG_BATMAN_ADV_DEBUGFS
 /**
  * batadv_hardif_neigh_seq_print_text - print the single hop neighbour list
  * @seq: neighbour table seq_file struct
@@ -725,6 +726,7 @@ int batadv_hardif_neigh_seq_print_text(struct seq_file *seq, void *offset)
 	bat_priv->algo_ops->neigh.print(bat_priv, seq);
 	return 0;
 }
+#endif
 
 /**
  * batadv_hardif_neigh_dump - Dump to netlink the neighbor infos for a specific
@@ -1324,6 +1326,7 @@ void batadv_purge_orig_ref(struct batadv_priv *bat_priv)
 	_batadv_purge_orig(bat_priv);
 }
 
+#ifdef CONFIG_BATMAN_ADV_DEBUGFS
 int batadv_orig_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
@@ -1397,6 +1400,7 @@ out:
 		batadv_hardif_put(hard_iface);
 	return 0;
 }
+#endif
 
 /**
  * batadv_orig_dump - Dump to netlink the originator infos for a specific
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 84ae94d..36b0068 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -996,6 +996,7 @@ container_register:
 	kfree(tt_data);
 }
 
+#ifdef CONFIG_BATMAN_ADV_DEBUGFS
 int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
@@ -1063,6 +1064,7 @@ out:
 		batadv_hardif_put(primary_if);
 	return 0;
 }
+#endif
 
 /**
  * batadv_tt_local_dump_entry - Dump one TT local entry into a message
@@ -1744,6 +1746,7 @@ batadv_transtable_best_orig(struct batadv_priv *bat_priv,
 	return best_entry;
 }
 
+#ifdef CONFIG_BATMAN_ADV_DEBUGFS
 /**
  * batadv_tt_global_print_entry - print all orig nodes who announce the address
  *  for this global entry
@@ -1867,6 +1870,7 @@ out:
 		batadv_hardif_put(primary_if);
 	return 0;
 }
+#endif
 
 /**
  * batadv_tt_global_dump_subentry - Dump all TT local entries into a message
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index cda10e2..e3dd001 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1425,7 +1425,9 @@ struct batadv_algo_neigh_ops {
 				     struct batadv_hard_iface *if_outgoing1,
 				     struct batadv_neigh_node *neigh2,
 				     struct batadv_hard_iface *if_outgoing2);
+#ifdef CONFIG_BATMAN_ADV_DEBUGFS
 	void (*print)(struct batadv_priv *priv, struct seq_file *seq);
+#endif
 	void (*dump)(struct sk_buff *msg, struct netlink_callback *cb,
 		     struct batadv_priv *priv,
 		     struct batadv_hard_iface *hard_iface);
@@ -1447,8 +1449,10 @@ struct batadv_algo_orig_ops {
 	int (*add_if)(struct batadv_orig_node *orig_node, int max_if_num);
 	int (*del_if)(struct batadv_orig_node *orig_node, int max_if_num,
 		      int del_if_num);
+#ifdef CONFIG_BATMAN_ADV_DEBUGFS
 	void (*print)(struct batadv_priv *priv, struct seq_file *seq,
 		      struct batadv_hard_iface *hard_iface);
+#endif
 	void (*dump)(struct sk_buff *msg, struct netlink_callback *cb,
 		     struct batadv_priv *priv,
 		     struct batadv_hard_iface *hard_iface);
@@ -1474,7 +1478,9 @@ struct batadv_algo_gw_ops {
 	bool (*is_eligible)(struct batadv_priv *bat_priv,
 			    struct batadv_orig_node *curr_gw_orig,
 			    struct batadv_orig_node *orig_node);
+#ifdef CONFIG_BATMAN_ADV_DEBUGFS
 	void (*print)(struct batadv_priv *bat_priv, struct seq_file *seq);
+#endif
 	void (*dump)(struct sk_buff *msg, struct netlink_callback *cb,
 		     struct batadv_priv *priv);
 };
-- 
2.8.1


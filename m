Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 12 Jul 2012 22:35:26 +0200
Message-Id: <1342125327-11676-8-git-send-email-ordex@autistici.org>
In-Reply-To: <1342125327-11676-1-git-send-email-ordex@autistici.org>
References: <1342125327-11676-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv8 7/8] batman-adv: Distributed ARP Table -
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
 compat.c                |    2 ++
 debugfs.c               |    7 ++++-
 distributed-arp-table.h |   66 +++++++++++++++++++++++++++++++++++++++++++++++
 gen-compat-autoconf.sh  |    1 +
 types.h                 |   11 +++++++-
 8 files changed, 89 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index bd8d30c..c6266a2 100644
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
index 7604159..e45e3b4 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -23,7 +23,7 @@ batman-adv-y += bat_iv_ogm.o
 batman-adv-y += bitarray.o
 batman-adv-$(CONFIG_BATMAN_ADV_BLA) += bridge_loop_avoidance.o
 batman-adv-y += debugfs.o
-batman-adv-y += distributed-arp-table.o
+batman-adv-$(CONFIG_BATMAN_ADV_DAT) += distributed-arp-table.o
 batman-adv-y += gateway_client.o
 batman-adv-y += gateway_common.o
 batman-adv-y += hard-interface.o
diff --git a/README.external b/README.external
index e032ef1..9b2a973 100644
--- a/README.external
+++ b/README.external
@@ -37,6 +37,7 @@ module).  Available  options  and  their    possible   values are
 
  * CONFIG_BATMAN_ADV_DEBUG=[y|n*] (B.A.T.M.A.N. debugging)
  * CONFIG_BATMAN_ADV_BLA=[y*|n] (B.A.T.M.A.N. bridge loop avoidance)
+ * CONFIG_BATMAN_ADV_DAT=[y*|n] (B.A.T.M.A.N. Distributed ARP Table)
 
 e.g., debugging can be enabled by
 
diff --git a/compat.c b/compat.c
index 21f23fe..c8006c6 100644
--- a/compat.c
+++ b/compat.c
@@ -64,6 +64,7 @@ void batadv_free_rcu_backbone_gw(struct rcu_head *rcu)
 }
 #endif
 
+#ifdef CONFIG_BATMAN_ADV_DAT
 void batadv_free_rcu_dat_entry(struct rcu_head *rcu)
 {
 	struct batadv_dat_entry *dat_entry;
@@ -71,5 +72,6 @@ void batadv_free_rcu_dat_entry(struct rcu_head *rcu)
 	dat_entry = container_of(rcu, struct batadv_dat_entry, rcu);
 	kfree(dat_entry);
 }
+#endif
 
 #endif /* < KERNEL_VERSION(3, 0, 0) */
diff --git a/debugfs.c b/debugfs.c
index f7cf001..7e3d4ff 100644
--- a/debugfs.c
+++ b/debugfs.c
@@ -279,12 +279,13 @@ static int batadv_bla_backbone_table_open(struct inode *inode,
 
 #endif
 
+#ifdef CONFIG_BATMAN_ADV_DAT
 static int batadv_dat_cache_open(struct inode *inode, struct file *file)
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
 	return single_open(file, batadv_dat_cache_seq_print_text, net_dev);
 }
-
+#endif
 
 static int batadv_transtable_local_open(struct inode *inode, struct file *file)
 {
@@ -325,7 +326,9 @@ static BATADV_DEBUGINFO(bla_claim_table, S_IRUGO, batadv_bla_claim_table_open);
 static BATADV_DEBUGINFO(bla_backbone_table, S_IRUGO,
 			batadv_bla_backbone_table_open);
 #endif
+#ifdef CONFIG_BATMAN_ADV_DAT
 static BATADV_DEBUGINFO(dat_cache, S_IRUGO, batadv_dat_cache_open);
+#endif
 static BATADV_DEBUGINFO(transtable_local, S_IRUGO,
 			batadv_transtable_local_open);
 static BATADV_DEBUGINFO(vis_data, S_IRUGO, batadv_vis_data_open);
@@ -338,7 +341,9 @@ static struct batadv_debuginfo *batadv_mesh_debuginfos[] = {
 	&batadv_debuginfo_bla_claim_table,
 	&batadv_debuginfo_bla_backbone_table,
 #endif
+#ifdef CONFIG_BATMAN_ADV_DAT
 	&batadv_debuginfo_dat_cache,
+#endif
 	&batadv_debuginfo_transtable_local,
 	&batadv_debuginfo_vis_data,
 	NULL,
diff --git a/distributed-arp-table.h b/distributed-arp-table.h
index 9f366a3..9cc4337 100644
--- a/distributed-arp-table.h
+++ b/distributed-arp-table.h
@@ -20,6 +20,8 @@
 #ifndef _NET_BATMAN_ADV_ARP_H_
 #define _NET_BATMAN_ADV_ARP_H_
 
+#ifdef CONFIG_BATMAN_ADV_DAT
+
 #include "types.h"
 #include "originator.h"
 
@@ -63,4 +65,68 @@ int batadv_dat_init(struct batadv_priv *bat_priv);
 void batadv_dat_free(struct batadv_priv *bat_priv);
 int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset);
 
+#else
+
+static inline bool
+batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
+				      struct sk_buff *skb)
+{
+	return false;
+}
+
+static inline bool
+batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
+				      struct sk_buff *skb, int hdr_size,
+				      bool is4addr)
+{
+	return false;
+}
+
+static inline bool
+batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
+				    struct sk_buff *skb)
+{
+	return false;
+}
+
+static inline bool
+batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
+				    struct sk_buff *skb, int hdr_size)
+{
+	return false;
+}
+
+static inline bool
+batadv_dat_drop_broadcast_packet(struct batadv_priv *bat_priv,
+				 struct batadv_forw_packet *forw_packet)
+{
+	return false;
+}
+
+static inline void
+batadv_dat_init_orig_node_dht_addr(struct batadv_orig_node *orig_node)
+{
+}
+
+static inline void batadv_dat_init_own_dht_addr(struct batadv_priv *bat_priv,
+						struct batadv_hard_iface *iface)
+{
+}
+
+static inline void batadv_arp_change_timeout(struct net_device *soft_iface,
+					     const char *name)
+{
+}
+
+static inline int batadv_dat_init(struct batadv_priv *bat_priv)
+{
+	return 0;
+}
+
+static inline void batadv_dat_free(struct batadv_priv *bat_priv)
+{
+}
+
+#endif /* CONFIG_BATMAN_ADV_DAT */
+
 #endif /* _NET_BATMAN_ADV_ARP_H_ */
diff --git a/gen-compat-autoconf.sh b/gen-compat-autoconf.sh
index 7cf621b..7ea42aa 100755
--- a/gen-compat-autoconf.sh
+++ b/gen-compat-autoconf.sh
@@ -38,6 +38,7 @@ gen_config() {
 # write config variables
 gen_config 'CONFIG_BATMAN_ADV_DEBUG' ${CONFIG_BATMAN_ADV_DEBUG:="n"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_BLA' ${CONFIG_BATMAN_ADV_BLA:="y"} >> "${TMP}"
+gen_config 'CONFIG_BATMAN_ADV_DAT' ${CONFIG_BATMAN_ADV_DAT:="y"} >> "${TMP}"
 
 # only regenerate compat-autoconf.h when config was changed
 diff "${TMP}" "${TARGET}" > /dev/null 2>&1 || cp "${TMP}" "${TARGET}"
diff --git a/types.h b/types.h
index e826a7b..8ffdf5f 100644
--- a/types.h
+++ b/types.h
@@ -28,6 +28,8 @@
 	(ETH_HLEN + max(sizeof(struct batadv_unicast_packet), \
 			sizeof(struct batadv_bcast_packet)))
 
+#ifdef CONFIG_BATMAN_ADV_DAT
+
 /* batadv_dat_addr_t is the type used for all DHT addresses. If it is changed,
  * BATADV_DAT_ADDR_MAX is changed as well.
  *
@@ -35,6 +37,8 @@
  */
 #define batadv_dat_addr_t uint16_t
 
+#endif /* CONFIG_BATMAN_ADV_DAT */
+
 struct batadv_hard_iface {
 	struct list_head list;
 	int16_t if_num;
@@ -69,7 +73,9 @@ struct batadv_orig_node {
 	uint8_t orig[ETH_ALEN];
 	uint8_t primary_addr[ETH_ALEN];
 	struct batadv_neigh_node __rcu *router; /* rcu protected pointer */
+#ifdef CONFIG_BATMAN_ADV_DAT
 	batadv_dat_addr_t dht_addr;
+#endif
 	unsigned long *bcast_own;
 	uint8_t *bcast_own_sum;
 	unsigned long last_seen;
@@ -218,7 +224,9 @@ struct batadv_priv {
 	struct batadv_hashtable *claim_hash;
 	struct batadv_hashtable *backbone_hash;
 #endif
+#ifdef CONFIG_BATMAN_ADV_DAT
 	struct batadv_hashtable *dat_hash;
+#endif
 	struct list_head tt_req_list; /* list of pending tt_requests */
 	struct list_head tt_roam_list;
 	struct batadv_hashtable *vis_hash;
@@ -251,8 +259,9 @@ struct batadv_priv {
 	struct batadv_hard_iface __rcu *primary_if;  /* rcu protected pointer */
 	struct batadv_vis_info *my_vis_info;
 	struct batadv_algo_ops *bat_algo_ops;
+#ifdef CONFIG_BATMAN_ADV_DAT
 	batadv_dat_addr_t dht_addr;
-
+#endif
 };
 
 struct batadv_socket_client {
-- 
1.7.9.4


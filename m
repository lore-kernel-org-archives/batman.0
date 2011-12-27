Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Tue, 27 Dec 2011 17:51:22 +0100
Message-Id: <1325004682-16792-11-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1325004682-16792-1-git-send-email-siwu@hrz.tu-chemnitz.de>
References: <1325004682-16792-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCHv2 10/10] batman-adv: add bridge loop
	avoidance compile option
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

The define CONFIG_BATMAN_ADV_BLA switches the bridge loop avoidance
on - skip it, and the bridge loop avoidance is not compiled in.

This is useful if binary size should be saved or the feature is
not needed.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 Makefile                |    2 ++
 Makefile.kbuild         |    2 +-
 README.external         |    1 +
 bat_debugfs.c           |    7 ++++++-
 bat_sysfs.c             |    4 ++++
 bridge_loop_avoidance.h |   14 ++++++++++++++
 gen-compat-autoconf.sh  |    1 +
 7 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index e2276be..eac6bfc 100644
--- a/Makefile
+++ b/Makefile
@@ -21,6 +21,8 @@
 # changing the CONFIG_* line to 'y' enables the related feature
 # B.A.T.M.A.N. debugging:
 export CONFIG_BATMAN_ADV_DEBUG=n
+# B.A.T.M.A.N. bridge loop avoidance:
+export CONFIG_BATMAN_ADV_BLA=y
 
 PWD:=$(shell pwd)
 KERNELPATH ?= /lib/modules/$(shell uname -r)/build
diff --git a/Makefile.kbuild b/Makefile.kbuild
index 9a5c122..525df15 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -23,7 +23,7 @@ batman-adv-y += bat_debugfs.o
 batman-adv-y += bat_iv_ogm.o
 batman-adv-y += bat_sysfs.o
 batman-adv-y += bitarray.o
-batman-adv-y += bridge_loop_avoidance.o
+batman-adv-$(CONFIG_BATMAN_ADV_BLA) += bridge_loop_avoidance.o
 batman-adv-y += gateway_client.o
 batman-adv-y += gateway_common.o
 batman-adv-y += hard-interface.o
diff --git a/README.external b/README.external
index 4aa4763..4a3a504 100644
--- a/README.external
+++ b/README.external
@@ -36,6 +36,7 @@ module).  Available  options  and  their    possible   values are
 (default marked with an "*")
 
  * CONFIG_BATMAN_ADV_DEBUG=[y|n*] (B.A.T.M.A.N. debugging)
+ * CONFIG_BATMAN_ADV_BLA=[y*|n] (B.A.T.M.A.N. bridge loop avoidance)
 
 e.g., debugging can be enabled by
 
diff --git a/bat_debugfs.c b/bat_debugfs.c
index 476cce2..fe179fe 100644
--- a/bat_debugfs.c
+++ b/bat_debugfs.c
@@ -245,12 +245,13 @@ static int transtable_global_open(struct inode *inode, struct file *file)
 	return single_open(file, tt_global_seq_print_text, net_dev);
 }
 
+#ifdef CONFIG_BATMAN_ADV_BLA
 static int bla_claim_table_open(struct inode *inode, struct file *file)
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
 	return single_open(file, bla_claim_table_seq_print_text, net_dev);
 }
-
+#endif
 
 static int transtable_local_open(struct inode *inode, struct file *file)
 {
@@ -285,7 +286,9 @@ static BAT_DEBUGINFO(routing_algos, S_IRUGO, bat_algorithms_open);
 static BAT_DEBUGINFO(originators, S_IRUGO, originators_open);
 static BAT_DEBUGINFO(gateways, S_IRUGO, gateways_open);
 static BAT_DEBUGINFO(transtable_global, S_IRUGO, transtable_global_open);
+#ifdef CONFIG_BATMAN_ADV_BLA
 static BAT_DEBUGINFO(bla_claim_table, S_IRUGO, bla_claim_table_open);
+#endif
 static BAT_DEBUGINFO(transtable_local, S_IRUGO, transtable_local_open);
 static BAT_DEBUGINFO(vis_data, S_IRUGO, vis_data_open);
 
@@ -293,7 +296,9 @@ static struct bat_debuginfo *mesh_debuginfos[] = {
 	&bat_debuginfo_originators,
 	&bat_debuginfo_gateways,
 	&bat_debuginfo_transtable_global,
+#ifdef CONFIG_BATMAN_ADV_BLA
 	&bat_debuginfo_bla_claim_table,
+#endif
 	&bat_debuginfo_transtable_local,
 	&bat_debuginfo_vis_data,
 	NULL,
diff --git a/bat_sysfs.c b/bat_sysfs.c
index 21e46cb..fd4f786 100644
--- a/bat_sysfs.c
+++ b/bat_sysfs.c
@@ -386,7 +386,9 @@ static ssize_t store_gw_bwidth(struct kobject *kobj, struct attribute *attr,
 
 BAT_ATTR_BOOL(aggregated_ogms, S_IRUGO | S_IWUSR, NULL);
 BAT_ATTR_BOOL(bonding, S_IRUGO | S_IWUSR, NULL);
+#ifdef CONFIG_BATMAN_ADV_BLA
 BAT_ATTR_BOOL(bridge_loop_avoidance, S_IRUGO | S_IWUSR, NULL);
+#endif
 BAT_ATTR_BOOL(fragmentation, S_IRUGO | S_IWUSR, update_min_mtu);
 BAT_ATTR_BOOL(ap_isolation, S_IRUGO | S_IWUSR, NULL);
 static BAT_ATTR(vis_mode, S_IRUGO | S_IWUSR, show_vis_mode, store_vis_mode);
@@ -405,7 +407,9 @@ BAT_ATTR_UINT(log_level, S_IRUGO | S_IWUSR, 0, 15, NULL);
 static struct bat_attribute *mesh_attrs[] = {
 	&bat_attr_aggregated_ogms,
 	&bat_attr_bonding,
+#ifdef CONFIG_BATMAN_ADV_BLA
 	&bat_attr_bridge_loop_avoidance,
+#endif
 	&bat_attr_fragmentation,
 	&bat_attr_ap_isolation,
 	&bat_attr_vis_mode,
diff --git a/bridge_loop_avoidance.h b/bridge_loop_avoidance.h
index 9468c24..24d7f16 100644
--- a/bridge_loop_avoidance.h
+++ b/bridge_loop_avoidance.h
@@ -22,6 +22,7 @@
 #ifndef _NET_BATMAN_ADV_BLA_H_
 #define _NET_BATMAN_ADV_BLA_H_
 
+#ifdef CONFIG_BATMAN_ADV_BLA
 int bla_rx(struct bat_priv *bat_priv, struct sk_buff *skb, short vid);
 int bla_tx(struct bat_priv *bat_priv, struct sk_buff *skb, short vid);
 int bla_is_backbone_gw(struct sk_buff *skb,
@@ -37,5 +38,18 @@ int bla_init(struct bat_priv *bat_priv);
 void bla_free(struct bat_priv *bat_priv);
 
 #define BLA_CRC_INIT	0
+#else /* ifdef CONFIG_BATMAN_ADV_BLA */
+
+#define bla_rx(...)				(0)
+#define bla_tx(...)				(0)
+#define bla_is_backbone_gw(...)			(0)
+#define bla_claim_table_seq_print_text		(0)
+#define bla_is_backbone_gw_orig(...)		(0)
+#define bla_check_bcast_duplist(...)		(0)
+#define bla_update_orig_address(...)		{}
+#define bla_init(...)				(1)
+#define bla_free(...)				{}
+
+#endif /* ifdef CONFIG_BATMAN_ADV_BLA */
 
 #endif /* ifndef _NET_BATMAN_ADV_BLA_H_ */
diff --git a/gen-compat-autoconf.sh b/gen-compat-autoconf.sh
index 1a020c1..7cf621b 100755
--- a/gen-compat-autoconf.sh
+++ b/gen-compat-autoconf.sh
@@ -37,6 +37,7 @@ gen_config() {
 
 # write config variables
 gen_config 'CONFIG_BATMAN_ADV_DEBUG' ${CONFIG_BATMAN_ADV_DEBUG:="n"} >> "${TMP}"
+gen_config 'CONFIG_BATMAN_ADV_BLA' ${CONFIG_BATMAN_ADV_BLA:="y"} >> "${TMP}"
 
 # only regenerate compat-autoconf.h when config was changed
 diff "${TMP}" "${TARGET}" > /dev/null 2>&1 || cp "${TMP}" "${TARGET}"
-- 
1.7.7.3


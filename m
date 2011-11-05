Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sat,  5 Nov 2011 18:24:22 +0100
Message-Id: <1320513862-28360-12-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1320513862-28360-1-git-send-email-siwu@hrz.tu-chemnitz.de>
References: <1320513862-28360-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCH 11/11] batman-adv: add bridge loop avoidance
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
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

The define CONFIG_BATMAN_ADV_BLA switches the bridge loop avoidance
on - skip it, and the bridge loop avoidance is not compiled in.

This is useful if binary size should be saved or the feature is
not needed.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 Makefile.kbuild         |    1 +
 bat_debugfs.c           |    7 ++++++-
 bat_sysfs.c             |    4 ++++
 bridge_loop_avoidance.c |    3 +++
 bridge_loop_avoidance.h |   14 ++++++++++++++
 5 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/Makefile.kbuild b/Makefile.kbuild
index d626513..bbdbc9c 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -26,6 +26,7 @@ ifeq ($(MAKING_MODULES),1)
 endif
 
 # ccflags-y += -DCONFIG_BATMAN_ADV_DEBUG
+ccflags-y += -DCONFIG_BATMAN_ADV_BLA
 
 ifneq ($(REVISION),)
 ccflags-y += -DSOURCE_VERSION=\"$(REVISION)\"
diff --git a/bat_debugfs.c b/bat_debugfs.c
index 20d3fc9..7b6b889 100644
--- a/bat_debugfs.c
+++ b/bat_debugfs.c
@@ -240,12 +240,13 @@ static int transtable_global_open(struct inode *inode, struct file *file)
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
@@ -279,7 +280,9 @@ struct bat_debuginfo bat_debuginfo_##_name = {	\
 static BAT_DEBUGINFO(originators, S_IRUGO, originators_open);
 static BAT_DEBUGINFO(gateways, S_IRUGO, gateways_open);
 static BAT_DEBUGINFO(transtable_global, S_IRUGO, transtable_global_open);
+#ifdef CONFIG_BATMAN_ADV_BLA
 static BAT_DEBUGINFO(bla_claim_table, S_IRUGO, bla_claim_table_open);
+#endif
 static BAT_DEBUGINFO(transtable_local, S_IRUGO, transtable_local_open);
 static BAT_DEBUGINFO(vis_data, S_IRUGO, vis_data_open);
 
@@ -287,7 +290,9 @@ static struct bat_debuginfo *mesh_debuginfos[] = {
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
index cb7a524..728abfc 100644
--- a/bat_sysfs.c
+++ b/bat_sysfs.c
@@ -379,7 +379,9 @@ static ssize_t store_gw_bwidth(struct kobject *kobj, struct attribute *attr,
 
 BAT_ATTR_BOOL(aggregated_ogms, S_IRUGO | S_IWUSR, NULL);
 BAT_ATTR_BOOL(bonding, S_IRUGO | S_IWUSR, NULL);
+#ifdef CONFIG_BATMAN_ADV_BLA
 BAT_ATTR_BOOL(bridge_loop_avoidance, S_IRUGO | S_IWUSR, NULL);
+#endif
 BAT_ATTR_BOOL(fragmentation, S_IRUGO | S_IWUSR, update_min_mtu);
 BAT_ATTR_BOOL(ap_isolation, S_IRUGO | S_IWUSR, NULL);
 static BAT_ATTR(vis_mode, S_IRUGO | S_IWUSR, show_vis_mode, store_vis_mode);
@@ -397,7 +399,9 @@ BAT_ATTR_UINT(log_level, S_IRUGO | S_IWUSR, 0, 15, NULL);
 static struct bat_attribute *mesh_attrs[] = {
 	&bat_attr_aggregated_ogms,
 	&bat_attr_bonding,
+#ifdef CONFIG_BATMAN_ADV_BLA
 	&bat_attr_bridge_loop_avoidance,
+#endif
 	&bat_attr_fragmentation,
 	&bat_attr_ap_isolation,
 	&bat_attr_vis_mode,
diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 3935522..6e5e006 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -33,6 +33,8 @@
 #include <net/arp.h>
 #include <linux/if_vlan.h>
 
+#ifdef CONFIG_BATMAN_ADV_BLA
+
 static const uint8_t announce_mac[4] = {0x43, 0x05, 0x43, 0x05};
 
 static void bla_periodic_work(struct work_struct *work);
@@ -1587,3 +1589,4 @@ out:
 		hardif_free_ref(primary_if);
 	return ret;
 }
+#endif /* ifdef CONFIG_BATMAN_ADV_BLA */
diff --git a/bridge_loop_avoidance.h b/bridge_loop_avoidance.h
index 88394a8..ee97ba7 100644
--- a/bridge_loop_avoidance.h
+++ b/bridge_loop_avoidance.h
@@ -19,6 +19,7 @@
  *
  */
 
+#ifdef CONFIG_BATMAN_ADV_BLA
 int bla_rx(struct bat_priv *bat_priv, struct sk_buff *skb, short vid);
 int bla_tx(struct bat_priv *bat_priv, struct sk_buff *skb, short vid);
 int bla_is_backbone_gw(struct sk_buff *skb,
@@ -33,3 +34,16 @@ int bla_init(struct bat_priv *bat_priv);
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
+#define bla_init(...)				(0)
+#define bla_free(...)				{}
+
+#endif /* ifdef CONFIG_BATMAN_ADV_BLA */
-- 
1.7.7.1


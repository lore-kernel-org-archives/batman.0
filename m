Return-Path: <linus.luessing@ascom.ch>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Tue, 15 Feb 2011 18:12:24 +0100
Message-Id: <1297789948-16948-10-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1297789948-16948-1-git-send-email-linus.luessing@ascom.ch>
References: <1297789948-16948-1-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 09/13] batman-adv: Add sysfs option for
	enabling redundant bonding mode
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
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>

When bonding is enabled, then enabling red_bonding too changes the
behavior from throughput bonding (round robin sending on interfaces) to
redundant bonding (sending every packet on all interfaces available for
bonding).

Signed-off-by: Linus Lüssing <linus.luessing@ascom.ch>
---
 bat_sysfs.c      |   10 ++++++++++
 soft-interface.c |    1 +
 types.h          |    1 +
 3 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/batman-adv/bat_sysfs.c b/batman-adv/bat_sysfs.c
index 93ae20a..fb9f3e9 100644
--- a/batman-adv/bat_sysfs.c
+++ b/batman-adv/bat_sysfs.c
@@ -356,8 +356,17 @@ static ssize_t store_gw_bwidth(struct kobject *kobj, struct attribute *attr,
 	return gw_bandwidth_set(net_dev, buff, count);
 }
 
+static void print_bonding_notice(struct net_device *net_dev)
+{
+	bat_info(net_dev, "Redundant Bonding mode is currently not compatible "
+			"with batman-adv's link layer fragmentation and will "
+			"be ignored. Also make sure to activate general "
+			"bonding for redundant bonding to take effect.\n");
+}
+
 BAT_ATTR_BOOL(aggregated_ogms, S_IRUGO | S_IWUSR, NULL);
 BAT_ATTR_BOOL(bonding, S_IRUGO | S_IWUSR, NULL);
+BAT_ATTR_BOOL(red_bonding, S_IRUGO | S_IWUSR, print_bonding_notice);
 BAT_ATTR_BOOL(fragmentation, S_IRUGO | S_IWUSR, update_min_mtu);
 static BAT_ATTR(vis_mode, S_IRUGO | S_IWUSR, show_vis_mode, store_vis_mode);
 static BAT_ATTR(gw_mode, S_IRUGO | S_IWUSR, show_gw_mode, store_gw_mode);
@@ -374,6 +383,7 @@ BAT_ATTR_UINT(log_level, S_IRUGO | S_IWUSR, 0, 3, NULL);
 static struct bat_attribute *mesh_attrs[] = {
 	&bat_attr_aggregated_ogms,
 	&bat_attr_bonding,
+	&bat_attr_red_bonding,
 	&bat_attr_fragmentation,
 	&bat_attr_vis_mode,
 	&bat_attr_gw_mode,
diff --git a/batman-adv/soft-interface.c b/batman-adv/soft-interface.c
index f3c7141..25db300 100644
--- a/batman-adv/soft-interface.c
+++ b/batman-adv/soft-interface.c
@@ -590,6 +590,7 @@ struct net_device *softif_create(char *name)
 
 	atomic_set(&bat_priv->aggregated_ogms, 1);
 	atomic_set(&bat_priv->bonding, 0);
+	atomic_set(&bat_priv->red_bonding, 0);
 	atomic_set(&bat_priv->vis_mode, VIS_TYPE_CLIENT_UPDATE);
 	atomic_set(&bat_priv->gw_mode, GW_MODE_OFF);
 	atomic_set(&bat_priv->gw_sel_class, 20);
diff --git a/batman-adv/types.h b/batman-adv/types.h
index b6acb12..c2ddd0a 100644
--- a/batman-adv/types.h
+++ b/batman-adv/types.h
@@ -131,6 +131,7 @@ struct bat_priv {
 	struct net_device_stats stats;
 	atomic_t aggregated_ogms;	/* boolean */
 	atomic_t bonding;		/* boolean */
+	atomic_t red_bonding;		/* boolean */
 	atomic_t fragmentation;		/* boolean */
 	atomic_t vis_mode;		/* VIS_TYPE_* */
 	atomic_t gw_mode;		/* GW_MODE_* */
-- 
1.7.2.3


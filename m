Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Sun, 28 Feb 2016 05:04:08 +0800
Message-Id: <1456607048-24975-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [RFC next] batman-adv: ELP - use new
	ethtool_link_get_ksettings API
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
Cc: Antonio Quartulli <a@unstable.cc>

The ethtool API is changing in linux-4.6 and the B.A.T.M.A.N. V
code has to be changed accordingly.

Fixes: 5c3245172c01 ("batman-adv: ELP - compute the metric based on the estimated throughput")
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---

This patch contains some compat code which is an attempt to implement
backward compatibility with kernel <4.6. Unfortunately my attempt does
not work because it is not possible to redefine something like
link_settings.base.speed to something else (due to the '.' in the string).

Any suggestion? :)


 compat-include/linux/ethtool.h | 35 +++++++++++++++++++++++++++++++++++
 net/batman-adv/bat_v_elp.c     | 12 ++++++------
 2 files changed, 41 insertions(+), 6 deletions(-)
 create mode 100644 compat-include/linux/ethtool.h

diff --git a/compat-include/linux/ethtool.h b/compat-include/linux/ethtool.h
new file mode 100644
index 0000000..b11524d
--- /dev/null
+++ b/compat-include/linux/ethtool.h
@@ -0,0 +1,35 @@
+/* Copyright (C) 2016  B.A.T.M.A.N. contributors:
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
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * This file contains macros for maintaining compatibility with older versions
+ * of the Linux kernel.
+ */
+
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_ETHTOOL_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_ETHTOOL_H_
+
+#include <linux/version.h>
+#include_next <linux/ethtool.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 6, 0)
+
+#define ethtool_link_ksettings ethtool_cmd
+#define __ethtool_get_link_ksettings __ethtool_get_settings
+#define link_settings.base.speed ethtool_cmd_speed(&link_settings)
+
+#endif /* < KERNEL_VERSION(4, 6, 0) */
+
+#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_ETHTOOL_H_ */
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index e94b4a0..3844e7e 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -73,8 +73,8 @@ static void batadv_v_elp_start_timer(struct batadv_hard_iface *hard_iface)
 static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 {
 	struct batadv_hard_iface *hard_iface = neigh->if_incoming;
+	struct ethtool_link_ksettings link_settings;
 	struct station_info sinfo;
-	struct ethtool_cmd cmd;
 	u32 throughput;
 	int ret;
 
@@ -110,19 +110,19 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 	/* if not a wifi interface, check if this device provides data via
 	 * ethtool (e.g. an Ethernet adapter)
 	 */
-	memset(&cmd, 0, sizeof(cmd));
+	memset(&link_settings, 0, sizeof(link_settings));
 	rtnl_lock();
-	ret = __ethtool_get_settings(hard_iface->net_dev, &cmd);
+	ret = __ethtool_get_link_ksettings(hard_iface->net_dev, &link_settings);
 	rtnl_unlock();
 	if (ret == 0) {
 		/* link characteristics might change over time */
-		if (cmd.duplex == DUPLEX_FULL)
+		if (link_settings.base.duplex == DUPLEX_FULL)
 			hard_iface->bat_v.flags |= BATADV_FULL_DUPLEX;
 		else
 			hard_iface->bat_v.flags &= ~BATADV_FULL_DUPLEX;
 
-		throughput = ethtool_cmd_speed(&cmd);
-		if (throughput && throughput != SPEED_UNKNOWN)
+		throughput = link_settings.base.speed;
+		if (throughput && (throughput != SPEED_UNKNOWN))
 			return throughput * 10;
 	}
 
-- 
2.7.2


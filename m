Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 17 Apr 2015 18:34:16 +0200
Message-Id: <1429288461-26260-1-git-send-email-sven@narfation.org>
In-Reply-To: <13114664.Eg4ODy7KEo@bentobox>
References: <13114664.Eg4ODy7KEo@bentobox>
Subject: [B.A.T.M.A.N.] [PATCH-next 1/6] batman-adv: ignore
	netdev_set_master() calls on kernels older than 2.6.39
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

From: Marek Lindner <mareklindner@neomailbox.ch>

batman-adv calls netdev_master_upper_dev_link() which is replaced with with
netdev_set_master() for kernels older than 3.9 via compat.h.
Prior to 2.6.39 netdev_set_master() contained Linux bonding calls needed to
setup bonding devices. Calling this function from batman-adv leads to
unexpected behavior when current batman-adv versions are used on these
older kernels.

To fix the situation compat.h now ships its own implementation of
netdev_set_master() which does not change the net_dev->master state
on kernels older than 2.6.39.

Reported-by: Andreas Pape <APape@phoenixcontact.com>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/compat.h b/compat.h
index 835c6ea..45412b0 100644
--- a/compat.h
+++ b/compat.h
@@ -191,6 +191,15 @@ static inline int batadv_param_set_copystring(const char *val,
 #define kstrtoul strict_strtoul
 #define kstrtol  strict_strtol
 
+/* On older kernels net_dev->master is reserved for iface bonding. */
+static inline int batadv_netdev_set_master(struct net_device *slave,
+					   struct net_device *master)
+{
+	return 0;
+}
+
+#define netdev_set_master batadv_netdev_set_master
+
 /* Hack for removing ndo_add/del_slave at the end of net_device_ops.
  * This is somewhat ugly because it requires that ndo_validate_addr
  * is at the end of this struct in soft-interface.c.
-- 
2.1.4


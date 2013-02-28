Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Thu, 28 Feb 2013 12:08:47 +0100
Message-Id: <1362049727-16411-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: change compat code to remove
	sparse warning
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
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

The latest compat patch fixing rtnl ops compile errors from 2.6.32
("batman-adv: add compat support for the new netlink ops") fixes
the compilation, but leaves some sparse errors:
batman-adv/soft-interface.c:573:10: warning: Initializer entry defined twice
batman-adv/soft-interface.c:574:10: also defined here

This patch uses another approach by moving the initializers in a dummy
struct instead. This also removes the sparse errors.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 compat.h |   30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/compat.h b/compat.h
index 64244ac..69c3dc2 100644
--- a/compat.h
+++ b/compat.h
@@ -135,23 +135,19 @@ static inline int batadv_param_set_copystring(const char *val,
 #define kstrtoul strict_strtoul
 #define kstrtol  strict_strtol
 
-#define batadv_softif_slave_add(x, y) \
-batadv_softif_slave_add(struct net_device *dev, struct ifreq *rq, int cmd)\
-{\
-	return -EOPNOTSUPP;\
-}\
-static int __attribute__((unused)) __batadv_softif_slave_add(x, y)
-
-#define batadv_softif_slave_del(x, y) \
-__batadv_softif_slave_del(struct net_device *dev, struct net_device *slave_dev);\
-static int batadv_softif_slave_del(struct net_device *dev, struct ifreq *rq, int cmd)\
-{\
-	return -EOPNOTSUPP;\
-}\
-static int __attribute__((unused)) __batadv_softif_slave_del(x, y)
-
-#define ndo_add_slave ndo_do_ioctl
-#define ndo_del_slave ndo_do_ioctl
+/* Hack for removing ndo_add/del_slave at the end of net_device_ops.
+ * This is somewhat ugly because it requires that ndo_validate_addr
+ * is at the end of this struct in soft-interface.c.
+ */
+#define ndo_validate_addr \
+	ndo_validate_addr = eth_validate_addr, \
+}; \
+static const struct { \
+	void *ndo_validate_addr; \
+	void *ndo_add_slave; \
+	void *ndo_del_slave; \
+} __attribute__((unused)) __useless_ops1 = { \
+	.ndo_validate_addr
 
 #endif /* < KERNEL_VERSION(2, 6, 39) */
 
-- 
1.7.10.4


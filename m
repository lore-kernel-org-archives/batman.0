Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  5 Jun 2011 10:20:19 +0200
Message-Id: <1307262019-9147-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Rewrite debugfs kobj_to_*
	helpers as functions
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

CodingStyle "Chapter 12: Macros, Enums and RTL" highly recommends to use
functions instead of macros were possible. This ensures type safety and
prevents shadowing of other variables.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bat_sysfs.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/bat_sysfs.c b/bat_sysfs.c
index df8a283..63738ec 100644
--- a/bat_sysfs.c
+++ b/bat_sysfs.c
@@ -28,9 +28,17 @@
 #include "gateway_client.h"
 #include "vis.h"
 
-#define to_dev(obj)		container_of(obj, struct device, kobj)
-#define kobj_to_netdev(obj)	to_net_dev(to_dev(obj->parent))
-#define kobj_to_batpriv(obj)	netdev_priv(kobj_to_netdev(obj))
+static struct net_device *kobj_to_netdev(struct kobject *obj)
+{
+	struct device *dev = container_of(obj->parent, struct device, kobj);
+	return to_net_dev(dev);
+}
+
+static struct bat_priv *kobj_to_batpriv(struct kobject *obj)
+{
+	struct net_device *net_dev = kobj_to_netdev(obj);
+	return netdev_priv(net_dev);
+}
 
 /* Use this, if you have customized show and store functions */
 #define BAT_ATTR(_name, _mode, _show, _store)	\
-- 
1.7.5.3


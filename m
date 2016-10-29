Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 29 Oct 2016 14:07:49 +0200
Message-Id: <20161029120749.5847-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Add module alias for batadv
	netlink family
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

The batman-adv module has to be loaded to fulfill genl request by the
userspace. When it is not loaded then requests will fail. It is therefore
useful to get the module automatically loaded when such a request is made.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 6b5dae6..d46415e 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -23,6 +23,7 @@
 #include <linux/crc32c.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
+#include <linux/genetlink.h>
 #include <linux/if_ether.h>
 #include <linux/if_vlan.h>
 #include <linux/init.h>
@@ -44,6 +45,7 @@
 #include <linux/workqueue.h>
 #include <net/dsfield.h>
 #include <net/rtnetlink.h>
+#include <uapi/linux/batman_adv.h>
 
 #include "bat_algo.h"
 #include "bat_iv_ogm.h"
@@ -648,3 +650,4 @@ MODULE_DESCRIPTION(BATADV_DRIVER_DESC);
 MODULE_SUPPORTED_DEVICE(BATADV_DRIVER_DEVICE);
 MODULE_VERSION(BATADV_SOURCE_VERSION);
 MODULE_ALIAS_RTNL_LINK("batadv");
+MODULE_ALIAS_GENL_FAMILY(BATADV_NL_NAME);
-- 
2.10.1


Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 1/3] batman-adv: Fix includes for *_MAX constants
Date: Fri, 24 May 2019 21:19:56 +0200
Message-Id: <20190524191958.30928-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The commit 54d50897d544 ("linux/kernel.h: split *_MAX and *_MIN macros into
<linux/limits.h>") moved the U32_MAX/INT_MAX/ULONG_MAX from linux/kernel.h
to linux/limits.h. Adjust the includes accordingly.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/gateway_common.c | 1 +
 net/batman-adv/hard-interface.c | 1 +
 net/batman-adv/netlink.c        | 1 +
 net/batman-adv/sysfs.c          | 1 +
 net/batman-adv/tp_meter.c       | 1 +
 5 files changed, 5 insertions(+)

diff --git a/net/batman-adv/gateway_common.c b/net/batman-adv/gateway_common.c
index dac097f9..fc557505 100644
--- a/net/batman-adv/gateway_common.c
+++ b/net/batman-adv/gateway_common.c
@@ -11,6 +11,7 @@
 #include <linux/byteorder/generic.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
+#include <linux/limits.h>
 #include <linux/math64.h>
 #include <linux/netdevice.h>
 #include <linux/stddef.h>
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 79d1731b..89948764 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -16,6 +16,7 @@
 #include <linux/if_ether.h>
 #include <linux/kernel.h>
 #include <linux/kref.h>
+#include <linux/limits.h>
 #include <linux/list.h>
 #include <linux/netdevice.h>
 #include <linux/printk.h>
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index a67720fa..7253699c 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -21,6 +21,7 @@
 #include <linux/if_vlan.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/limits.h>
 #include <linux/list.h>
 #include <linux/netdevice.h>
 #include <linux/netlink.h>
diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index 80fc3253..1efcb970 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -18,6 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/kobject.h>
 #include <linux/kref.h>
+#include <linux/limits.h>
 #include <linux/netdevice.h>
 #include <linux/printk.h>
 #include <linux/rculist.h>
diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 82039214..dd6a9a40 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/kref.h>
 #include <linux/kthread.h>
+#include <linux/limits.h>
 #include <linux/list.h>
 #include <linux/netdevice.h>
 #include <linux/param.h>
-- 
2.20.1


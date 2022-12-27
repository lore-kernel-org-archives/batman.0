Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: batman-adv: Drop prandom.h includes
Date: Tue, 27 Dec 2022 09:03:00 +0100
Message-Id: <20221227080301.516810-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Sven Eckelmann <sven@narfation.org>

The commit a15d3f3c1c2a ("batman-adv: use get_random_u32_below() instead of
deprecated function") replaced the prandom.h function prandom_u32_max with
the random.h function get_random_u32_below. There is no need to still
include prandom.h.

Signed-off-by: Sven Eckelmann <sven@narfation.org>

diff --git a/compat-include/linux/prandom.h b/compat-include/linux/prandom.h
deleted file mode 100644
index dc227e61f95167a86432e862796db7905f7034c2..0000000000000000000000000000000000000000
--- a/compat-include/linux/prandom.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) B.A.T.M.A.N. contributors:
- *
- * Marek Lindner, Simon Wunderlich
- *
- * This file contains macros for maintaining compatibility with older versions
- * of the Linux kernel.
- */
-
-#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_PRANDOM_H_
-#define _NET_BATMAN_ADV_COMPAT_LINUX_PRANDOM_H_
-
-#include <linux/version.h>
-#if LINUX_VERSION_IS_GEQ(5, 8, 1) || \
-    (LINUX_VERSION_IS_GEQ(4, 9, 233) && LINUX_VERSION_IS_LESS(4, 10, 0)) || \
-    (LINUX_VERSION_IS_GEQ(4, 14, 193) && LINUX_VERSION_IS_LESS(4, 15, 0)) || \
-    (LINUX_VERSION_IS_GEQ(4, 19, 138) && LINUX_VERSION_IS_LESS(4, 20, 0)) || \
-    (LINUX_VERSION_IS_GEQ(5, 4, 57) && LINUX_VERSION_IS_LESS(5, 5, 0)) || \
-    (LINUX_VERSION_IS_GEQ(5, 7, 14) && LINUX_VERSION_IS_LESS(5, 8, 0))
-#include_next <linux/prandom.h>
-#else
-#include <linux/random.h>
-#endif
-
-#endif /* _NET_BATMAN_ADV_COMPAT_LINUX_PRANDOM_H_ */
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 114ee5da261f4410d207a76a357163aad6d1783f..828fb393ee94a31e8715b0b157b4c39b6337b19d 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -27,7 +27,6 @@
 #include <linux/netdevice.h>
 #include <linux/netlink.h>
 #include <linux/pkt_sched.h>
-#include <linux/prandom.h>
 #include <linux/printk.h>
 #include <linux/random.h>
 #include <linux/rculist.h>
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index f9a58fb5442efc051e6f1bad6814f269752b7de7..acff565849ae91f4c0cf54d7299ed76ecb2c6ced 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -21,7 +21,6 @@
 #include <linux/minmax.h>
 #include <linux/netdevice.h>
 #include <linux/nl80211.h>
-#include <linux/prandom.h>
 #include <linux/random.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index addfd8c4fe959e269b16e2f35b1299354ff4aea2..96e027364dddd30472fed8fe7e0a3aaa5cc8cda1 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -21,7 +21,6 @@
 #include <linux/minmax.h>
 #include <linux/mutex.h>
 #include <linux/netdevice.h>
-#include <linux/prandom.h>
 #include <linux/random.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index bf29fba4dde5940ad03b6ed925257cdd825f57e4..5e1f422b3a94b119746a6b3b5cf64182951e8eb3 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -25,7 +25,6 @@
 #include <linux/lockdep.h>
 #include <linux/net.h>
 #include <linux/netdevice.h>
-#include <linux/prandom.h>
 #include <linux/printk.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>

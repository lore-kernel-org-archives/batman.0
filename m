Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 26 Feb 2018 13:51:32 +0100
Message-Id: <20180226125132.30767-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Only use compat.h for
 kernel builds
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

The compat.h will be included by default via the -include gcc parameter.
This is done by appending the incude information to NOSTDINC_FLAGS in the
Makefile. But Debian decided [1] that this NOSTDINC_FLAGS must also be used
when not compiling kernel sources. This for example happens when the
gcc-version.sh script is executed. This results in error messages like

  In file included from <command-line>:0:0:
  /usr/src//batman-adv/build/../compat.h:25:52: fatal error: linux/version.h: No such file or directory
   #include <linux/version.h> /* LINUX_VERSION_CODE */
                                                      ^
  compilation terminated.
  In file included from <command-line>:0:0:
  /usr/src//batman-adv/build/../compat.h:25:52: fatal error: linux/version.h: No such file or directory
   #include <linux/version.h> /* LINUX_VERSION_CODE */
                                                      ^
  compilation terminated.
  /usr/src/linux-headers-4.14.0-0.bpo.3-common/scripts/gcc-version.sh: line 32: printf: #: invalid number
  /usr/src/linux-headers-4.14.0-0.bpo.3-common/scripts/gcc-version.sh: line 32: printf: #: invalid number
  /bin/sh: 1: [: 0001: unexpected operator

This can be avoided by disabling the compat.h whenever the preprocessor
define __KERNEL__ is not set.

[1] https://patchwork.kernel.org/patch/5238591/

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/compat.h b/compat.h
index c10ad589..759829f9 100644
--- a/compat.h
+++ b/compat.h
@@ -21,6 +21,8 @@
 #ifndef _NET_BATMAN_ADV_COMPAT_H_
 #define _NET_BATMAN_ADV_COMPAT_H_
 
+#ifdef __KERNEL__
+
 #include <linux/version.h>	/* LINUX_VERSION_CODE */
 #include <linux/kconfig.h>
 #include <generated/autoconf.h>
@@ -159,4 +161,6 @@ static int __batadv_interface_kill_vid(struct net_device *dev, __be16 proto,\
 
 #endif /* < KERNEL_VERSION(4, 15, 0) */
 
+#endif /* __KERNEL__ */
+
 #endif /* _NET_BATMAN_ADV_COMPAT_H_ */
-- 
2.11.0


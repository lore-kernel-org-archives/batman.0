Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri,  1 Jun 2018 17:38:45 +0200
Message-Id: <20180601153845.26561-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Drop support for Linux < 3.16
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

The Linux Kernel 3.2 reached its end of life [1] after over 6 years.
Instead it is recommended to use at least kernel 3.16 which is also already
over 3 years old. All older kernels (v3.2 - v3.15) should therefore be
dropped to reduce the support overhead.

[1] https://lkml.kernel.org/r/a3d2d2b2c3559217eb8315d25df0c5883f922066.camel@decadent.org.uk

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile                               |  42 ++-----
 README.external.rst                    |   2 +-
 compat-include/linux/etherdevice.h     |  55 ---------
 compat-include/linux/export.h          |  30 -----
 compat-include/linux/genetlink.h       |  34 ------
 compat-include/linux/if_ether.h        |  34 ------
 compat-include/linux/if_vlan.h         |  34 ------
 compat-include/linux/kernel.h          |  45 --------
 compat-include/linux/kref.h            |  47 --------
 compat-include/linux/list.h            |  21 ----
 compat-include/linux/net.h             |  40 -------
 compat-include/linux/netdev_features.h |  36 ------
 compat-include/linux/netdevice.h       |  32 +-----
 compat-include/linux/netlink.h         |  18 ---
 compat-include/linux/random.h          |  34 ------
 compat-include/linux/rculist.h         |  40 -------
 compat-include/linux/skbuff.h          |  32 ------
 compat-include/linux/slab.h            |  34 ------
 compat-include/linux/timer.h           |  11 --
 compat-include/net/genetlink.h         | 147 -------------------------
 compat-include/net/ipv6.h              |  38 -------
 compat-include/net/netlink.h           |  11 --
 compat-include/uapi/linux/eventpoll.h  |   4 -
 compat-include/uapi/linux/nl80211.h    |   4 -
 compat-patches/README                  |  25 -----
 compat-patches/replacements.sh         |  25 -----
 compat-sources/Makefile                |   6 +-
 compat.h                               |  98 -----------------
 28 files changed, 14 insertions(+), 965 deletions(-)
 delete mode 100644 compat-include/linux/etherdevice.h
 delete mode 100644 compat-include/linux/export.h
 delete mode 100644 compat-include/linux/genetlink.h
 delete mode 100644 compat-include/linux/if_ether.h
 delete mode 100644 compat-include/linux/if_vlan.h
 delete mode 100644 compat-include/linux/kernel.h
 delete mode 100644 compat-include/linux/kref.h
 delete mode 100644 compat-include/linux/net.h
 delete mode 100644 compat-include/linux/netdev_features.h
 delete mode 100644 compat-include/linux/random.h
 delete mode 100644 compat-include/linux/rculist.h
 delete mode 100644 compat-include/linux/slab.h
 delete mode 100644 compat-include/net/genetlink.h
 delete mode 100644 compat-include/net/ipv6.h
 delete mode 100644 compat-patches/README
 delete mode 100755 compat-patches/replacements.sh

diff --git a/Makefile b/Makefile
index ea995216..7c6fa1e4 100644
--- a/Makefile
+++ b/Makefile
@@ -33,7 +33,6 @@ export CONFIG_BATMAN_ADV_MCAST=y
 export CONFIG_BATMAN_ADV_BATMAN_V=y
 
 PWD:=$(shell pwd)
-BUILD_DIR=$(PWD)/build
 KERNELPATH ?= /lib/modules/$(shell uname -r)/build
 # sanity check: does KERNELPATH exist?
 ifeq ($(shell cd $(KERNELPATH) && pwd),)
@@ -42,30 +41,23 @@ endif
 
 export KERNELPATH
 RM ?= rm -f
-MKDIR := mkdir -p
-PATCH_FLAGS = --batch --fuzz=0 --forward --strip=1 --unified --version-control=never -g0 --remove-empty-files --no-backup-if-mismatch --reject-file=-
-PATCH := patch $(PATCH_FLAGS) -i
 CP := cp -fpR
 LN := ln -sf
 
-SOURCE = $(wildcard net/batman-adv/*.[ch]) net/batman-adv/Makefile
-SOURCE_BUILD = $(wildcard $(BUILD_DIR)/net/batman-adv/*.[ch]) $(BUILD_DIR)/net/batman-adv/Makefile
-SOURCE_STAMP = $(BUILD_DIR)/net/batman-adv/.compat-prepared
-
 REVISION= $(shell	if [ -d "$(PWD)/.git" ]; then \
 				echo $$(git --git-dir="$(PWD)/.git" describe --always --dirty --match "v*" |sed 's/^v//' 2> /dev/null || echo "[unknown]"); \
 			fi)
 NOSTDINC_FLAGS += \
-	-I$(PWD)/../compat-include/ \
-	-I$(PWD)/../include/ \
-	-include $(PWD)/../compat.h \
+	-I$(PWD)/compat-include/ \
+	-I$(PWD)/include/ \
+	-include $(PWD)/compat.h \
 	$(CFLAGS)
 
 ifneq ($(REVISION),)
 NOSTDINC_FLAGS += -DBATADV_SOURCE_VERSION=\"$(REVISION)\"
 endif
 
--include $(PWD)/../compat-sources/Makefile
+include $(PWD)/compat-sources/Makefile
 
 obj-y += net/batman-adv/
 
@@ -73,8 +65,8 @@ export batman-adv-y
 
 
 BUILD_FLAGS := \
-	M=$(BUILD_DIR) \
-	PWD=$(BUILD_DIR) \
+	M=$(PWD) \
+	PWD=$(PWD) \
 	REVISION=$(REVISION) \
 	CONFIG_BATMAN_ADV=m \
 	CONFIG_BATMAN_ADV_DEBUG=$(CONFIG_BATMAN_ADV_DEBUG) \
@@ -86,34 +78,18 @@ BUILD_FLAGS := \
 	CONFIG_BATMAN_ADV_BATMAN_V=$(CONFIG_BATMAN_ADV_BATMAN_V) \
 	INSTALL_MOD_DIR=updates/
 
-all: config $(SOURCE_STAMP)
+all: config
 	$(MAKE) -C $(KERNELPATH) $(BUILD_FLAGS)	modules
 
 clean:
 	$(RM) compat-autoconf.h*
-	$(RM) -r $(BUILD_DIR)
+	$(MAKE) -C $(KERNELPATH) $(BUILD_FLAGS) clean
 
-install: config $(SOURCE_STAMP)
+install: config
 	$(MAKE) -C $(KERNELPATH) $(BUILD_FLAGS) modules_install
 	depmod -a
 
 config:
 	$(PWD)/gen-compat-autoconf.sh $(PWD)/compat-autoconf.h
 
-$(SOURCE_STAMP): $(SOURCE) compat-patches/* compat-patches/replacements.sh
-	$(MKDIR) $(BUILD_DIR)/net/batman-adv/
-	@$(LN) ../Makefile $(BUILD_DIR)/Makefile
-	@$(RM) $(SOURCE_BUILD)
-	@$(CP) $(SOURCE) $(BUILD_DIR)/net/batman-adv/
-	@set -e; \
-	patches="$$(ls -1 compat-patches/|grep '.patch$$'|sort)"; \
-	for i in $${patches}; do \
-		echo '  COMPAT_PATCH '$${i};\
-		cd $(BUILD_DIR); \
-		$(PATCH) ../compat-patches/$${i}; \
-		cd - > /dev/null; \
-	done
-	compat-patches/replacements.sh
-	touch $(SOURCE_STAMP)
-
 .PHONY: all clean install config
diff --git a/README.external.rst b/README.external.rst
index a6f14a03..6c3e0c85 100644
--- a/README.external.rst
+++ b/README.external.rst
@@ -12,7 +12,7 @@ and as external module. The external  module   allows   to    get
 new    features without  upgrading  to  a  newer  kernel  version
 and to get batman-adv specific bugfixes  for  kernels  that   are
 not   supported   anymore.  It compiles  against  and should work
-with Linux 3.2 -  4.17.  Supporting   older   versions   is   not
+with Linux 3.16 -  4.17.  Supporting  older   versions   is   not
 planned,  but it's probably easy to backport it. If you work on a
 backport, feel free to contact us.  :-)
 
diff --git a/compat-include/linux/etherdevice.h b/compat-include/linux/etherdevice.h
deleted file mode 100644
index 96f560d1..00000000
--- a/compat-include/linux/etherdevice.h
+++ /dev/null
@@ -1,55 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
- *
- * Marek Lindner, Simon Wunderlich
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
- * This file contains macros for maintaining compatibility with older versions
- * of the Linux kernel.
- */
-
-#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_ETHERDEVICE_H_
-#define _NET_BATMAN_ADV_COMPAT_LINUX_ETHERDEVICE_H_
-
-#include <linux/version.h>
-#include_next <linux/etherdevice.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 4, 0)
-
-#define eth_hw_addr_random(dev)	batadv_eth_hw_addr_random(dev)
-
-static inline void batadv_eth_hw_addr_random(struct net_device *dev)
-{
-	random_ether_addr(dev->dev_addr);
-}
-
-#endif /* < KERNEL_VERSION(3, 4, 0) */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 7, 0)
-
-static inline void eth_zero_addr(u8 *addr)
-{
-	memset(addr, 0x00, ETH_ALEN);
-}
-
-#endif /* < KERNEL_VERSION(3, 7, 0) */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 14, 0)
-
-#define ether_addr_equal_unaligned(_a, _b) (memcmp(_a, _b, ETH_ALEN) == 0)
-#define ether_addr_copy(_a, _b) memcpy(_a, _b, ETH_ALEN)
-
-#endif /* < KERNEL_VERSION(3, 14, 0) */
-
-#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_ETHERDEVICE_H_ */
diff --git a/compat-include/linux/export.h b/compat-include/linux/export.h
deleted file mode 100644
index 5fb590fc..00000000
--- a/compat-include/linux/export.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
- *
- * Marek Lindner, Simon Wunderlich
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
- * This file contains macros for maintaining compatibility with older versions
- * of the Linux kernel.
- */
-
-#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_EXPORT_H_
-#define _NET_BATMAN_ADV_COMPAT_LINUX_EXPORT_H_
-
-#include <linux/version.h>
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 2, 0)
-#include_next <linux/export.h>
-#endif
-
-#endif /* _NET_BATMAN_ADV_COMPAT_LINUX_EXPORT_H_ */
diff --git a/compat-include/linux/genetlink.h b/compat-include/linux/genetlink.h
deleted file mode 100644
index ec778782..00000000
--- a/compat-include/linux/genetlink.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
- *
- * Marek Lindner, Simon Wunderlich
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
- * This file contains macros for maintaining compatibility with older versions
- * of the Linux kernel.
- */
-
-#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_GENETLINK_H_
-#define _NET_BATMAN_ADV_COMPAT_LINUX_GENETLINK_H_
-
-#include <linux/version.h>
-#include_next <linux/genetlink.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 5, 0)
-
-#define MODULE_ALIAS_GENL_FAMILY(family)
-
-#endif /* < KERNEL_VERSION(3, 5, 0) */
-
-#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_GENETLINK_H_ */
diff --git a/compat-include/linux/if_ether.h b/compat-include/linux/if_ether.h
deleted file mode 100644
index d2f683f9..00000000
--- a/compat-include/linux/if_ether.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
- *
- * Marek Lindner, Simon Wunderlich
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
- * This file contains macros for maintaining compatibility with older versions
- * of the Linux kernel.
- */
-
-#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_IF_ETHER_H_
-#define _NET_BATMAN_ADV_COMPAT_LINUX_IF_ETHER_H_
-
-#include <linux/version.h>
-#include_next <linux/if_ether.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 8, 0)
-
-#define ETH_P_BATMAN	0x4305
-
-#endif /* < KERNEL_VERSION(3, 8, 0) */
-
-#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_IF_ETHER_H_ */
diff --git a/compat-include/linux/if_vlan.h b/compat-include/linux/if_vlan.h
deleted file mode 100644
index 716040d8..00000000
--- a/compat-include/linux/if_vlan.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
- *
- * Marek Lindner, Simon Wunderlich
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
- * This file contains macros for maintaining compatibility with older versions
- * of the Linux kernel.
- */
-
-#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_IF_VLAN_H_
-#define _NET_BATMAN_ADV_COMPAT_LINUX_IF_VLAN_H_
-
-#include <linux/version.h>
-#include_next <linux/if_vlan.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 10, 0)
-
-#define vlan_insert_tag(skb, proto, vid) vlan_insert_tag(skb, vid)
-
-#endif /* < KERNEL_VERSION(3, 10, 0) */
-
-#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_IF_VLAN_H_ */
diff --git a/compat-include/linux/kernel.h b/compat-include/linux/kernel.h
deleted file mode 100644
index 96fd7f99..00000000
--- a/compat-include/linux/kernel.h
+++ /dev/null
@@ -1,45 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
- *
- * Marek Lindner, Simon Wunderlich
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
- * This file contains macros for maintaining compatibility with older versions
- * of the Linux kernel.
- */
-
-#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_KERNEL_H_
-#define _NET_BATMAN_ADV_COMPAT_LINUX_KERNEL_H_
-
-#include <linux/version.h>
-#include_next <linux/kernel.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 14, 0)
-
-#define U8_MAX		((u8)~0U)
-#define S8_MAX		((s8)(U8_MAX >> 1))
-#define S8_MIN		((s8)(-S8_MAX - 1))
-#define U16_MAX		((u16)~0U)
-#define S16_MAX		((s16)(U16_MAX >> 1))
-#define S16_MIN		((s16)(-S16_MAX - 1))
-#define U32_MAX		((u32)~0U)
-#define S32_MAX		((s32)(U32_MAX >> 1))
-#define S32_MIN		((s32)(-S32_MAX - 1))
-#define U64_MAX		((u64)~0ULL)
-#define S64_MAX		((s64)(U64_MAX >> 1))
-#define S64_MIN		((s64)(-S64_MAX - 1))
-
-#endif /* < KERNEL_VERSION(3, 14, 0) */
-
-#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_KERNEL_H_ */
diff --git a/compat-include/linux/kref.h b/compat-include/linux/kref.h
deleted file mode 100644
index 0516819b..00000000
--- a/compat-include/linux/kref.h
+++ /dev/null
@@ -1,47 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
- *
- * Marek Lindner, Simon Wunderlich
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
- * This file contains macros for maintaining compatibility with older versions
- * of the Linux kernel.
- */
-
-#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_KREF_H_
-#define _NET_BATMAN_ADV_COMPAT_LINUX_KREF_H_
-
-#include <linux/version.h>
-#include_next <linux/kref.h>
-
-#include <linux/atomic.h>
-#include <linux/kernel.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 8, 0)
-
-/* some stable versions like Linux 3.2.44 also introduced this function
- * and would therefore break the build because they trigger a redefinition
- * of this function. Instead rename this function to be in the batadv_*
- * namespace
- */
-#define kref_get_unless_zero(__kref) batadv_kref_get_unless_zero(__kref)
-
-static inline int __must_check batadv_kref_get_unless_zero(struct kref *kref)
-{
-	return atomic_add_unless(&kref->refcount, 1, 0);
-}
-
-#endif /* < KERNEL_VERSION(3, 8, 0) */
-
-#endif /* _NET_BATMAN_ADV_COMPAT_LINUX_KREF_H_ */
diff --git a/compat-include/linux/list.h b/compat-include/linux/list.h
index 224c600e..c542236e 100644
--- a/compat-include/linux/list.h
+++ b/compat-include/linux/list.h
@@ -25,27 +25,6 @@
 #include <linux/version.h>
 #include_next <linux/list.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 9, 0)
-
-#define hlist_entry_safe(ptr, type, member) \
-	({ typeof(ptr) ____ptr = (ptr); \
-	   ____ptr ? hlist_entry(____ptr, type, member) : NULL; \
-	})
-
-#undef hlist_for_each_entry
-#define hlist_for_each_entry(pos, head, member) \
-	for (pos = hlist_entry_safe((head)->first, typeof(*(pos)), member);\
-	pos; \
-	pos = hlist_entry_safe((pos)->member.next, typeof(*(pos)), member))
-
-#undef hlist_for_each_entry_safe
-#define hlist_for_each_entry_safe(pos, n, head, member) \
-	for (pos = hlist_entry_safe((head)->first, typeof(*pos), member);\
-	pos && ({ n = pos->member.next; 1; }); \
-	pos = hlist_entry_safe(n, typeof(*pos), member))
-
-#endif /* < KERNEL_VERSION(3, 9, 0) */
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 17, 0)
 
 #define hlist_add_behind(n, prev) hlist_add_after(prev, n)
diff --git a/compat-include/linux/net.h b/compat-include/linux/net.h
deleted file mode 100644
index fe24a1fb..00000000
--- a/compat-include/linux/net.h
+++ /dev/null
@@ -1,40 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
- *
- * Marek Lindner, Simon Wunderlich
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
- * This file contains macros for maintaining compatibility with older versions
- * of the Linux kernel.
- */
-
-#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_NET_H_
-#define _NET_BATMAN_ADV_COMPAT_LINUX_NET_H_
-
-#include <linux/version.h>
-#include_next <linux/net.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 5, 0)
-
-#ifndef net_ratelimited_function
-#define net_ratelimited_function(func, ...) \
-	do { \
-		if (net_ratelimit()) \
-			func(__VA_ARGS__); \
-	} while (0)
-#endif /* ifndef net_ratelimited_function */
-
-#endif /* < KERNEL_VERSION(3, 5, 0) */
-
-#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_NET_H_ */
diff --git a/compat-include/linux/netdev_features.h b/compat-include/linux/netdev_features.h
deleted file mode 100644
index 27b4a398..00000000
--- a/compat-include/linux/netdev_features.h
+++ /dev/null
@@ -1,36 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
- *
- * Marek Lindner, Simon Wunderlich
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
- * This file contains macros for maintaining compatibility with older versions
- * of the Linux kernel.
- */
-
-#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_NETDEV_FEATURES_H_
-#define _NET_BATMAN_ADV_COMPAT_LINUX_NETDEV_FEATURES_H_
-
-#include <linux/version.h>
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 3, 0)
-#include_next <linux/netdev_features.h>
-#endif /* >= KERNEL_VERSION(3, 3, 0) */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 10, 0)
-
-#define NETIF_F_HW_VLAN_CTAG_FILTER NETIF_F_HW_VLAN_FILTER
-
-#endif /* < KERNEL_VERSION(3, 10, 0) */
-
-#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_NETDEV_FEATURES_H_ */
diff --git a/compat-include/linux/netdevice.h b/compat-include/linux/netdevice.h
index 4e03f4f4..8f099cf4 100644
--- a/compat-include/linux/netdevice.h
+++ b/compat-include/linux/netdevice.h
@@ -25,31 +25,6 @@
 #include <linux/version.h>
 #include_next <linux/netdevice.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 3, 0)
-
-#include <linux/netdev_features.h>
-
-#endif /* < KERNEL_VERSION(3, 3, 0) */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 9, 0)
-
-#define netdev_upper_dev_unlink(slave, master) netdev_set_master(slave, NULL)
-#define netdev_master_upper_dev_get(dev) \
-({\
-	ASSERT_RTNL();\
-	dev->master;\
-})
-
-#endif /* < KERNEL_VERSION(3, 9, 0) */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 11, 0)
-
-#define NETDEV_CHANGEUPPER	0x0015
-
-#define netdev_notifier_info_to_dev(ptr) ptr
-
-#endif /* < KERNEL_VERSION(3, 11, 0) */
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 17, 0)
 
 /* alloc_netdev() was defined differently before 2.6.38 */
@@ -65,12 +40,7 @@
 
 #endif /* < KERNEL_VERSION(3, 19, 0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 9, 0)
-
-#define netdev_master_upper_dev_link(dev, upper_dev, upper_priv, upper_info, extack) \
-	netdev_set_master(dev, upper_dev)
-
-#elif LINUX_VERSION_CODE < KERNEL_VERSION(4, 5, 0)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 5, 0)
 
 #define netdev_master_upper_dev_link(dev, upper_dev, upper_priv, upper_info, extack) \
 	netdev_master_upper_dev_link(dev, upper_dev)
diff --git a/compat-include/linux/netlink.h b/compat-include/linux/netlink.h
index 3f77265b..eb42b2b6 100644
--- a/compat-include/linux/netlink.h
+++ b/compat-include/linux/netlink.h
@@ -25,24 +25,6 @@
 #include <linux/version.h>
 #include_next <linux/netlink.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 7, 0)
-
-#include <net/scm.h>
-
-struct batadv_netlink_skb_parms {
-	struct ucred		creds;		/* Skb credentials	*/
-	union {
-		__u32		portid;
-		__u32		pid;
-	};
-	__u32			dst_group;
-};
-
-#undef NETLINK_CB
-#define NETLINK_CB(skb) (*(struct batadv_netlink_skb_parms *)&((skb)->cb))
-
-#endif /* < KERNEL_VERSION(3, 7, 0) */
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4, 7, 0)
 
 #include_next <net/netlink.h>
diff --git a/compat-include/linux/random.h b/compat-include/linux/random.h
deleted file mode 100644
index 04d44ebc..00000000
--- a/compat-include/linux/random.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
- *
- * Marek Lindner, Simon Wunderlich
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
- * This file contains macros for maintaining compatibility with older versions
- * of the Linux kernel.
- */
-
-#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_RANDOM_H_
-#define _NET_BATMAN_ADV_COMPAT_LINUX_RANDOM_H_
-
-#include <linux/version.h>
-#include_next <linux/random.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 9, 0)
-
-#define prandom_u32() random32()
-
-#endif /* < KERNEL_VERSION(3, 9, 0) */
-
-#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_RANDOM_H_ */
diff --git a/compat-include/linux/rculist.h b/compat-include/linux/rculist.h
deleted file mode 100644
index a8878060..00000000
--- a/compat-include/linux/rculist.h
+++ /dev/null
@@ -1,40 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
- *
- * Marek Lindner, Simon Wunderlich
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
- * This file contains macros for maintaining compatibility with older versions
- * of the Linux kernel.
- */
-
-#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_RCULIST_H_
-#define _NET_BATMAN_ADV_COMPAT_LINUX_RCULIST_H_
-
-#include <linux/version.h>
-#include_next <linux/rculist.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 9, 0)
-
-#undef hlist_for_each_entry_rcu
-#define hlist_for_each_entry_rcu(pos, head, member) \
-	for (pos = hlist_entry_safe(rcu_dereference_raw(hlist_first_rcu(head)),\
-	typeof(*(pos)), member); \
-	pos; \
-	pos = hlist_entry_safe(rcu_dereference_raw(hlist_next_rcu(\
-	&(pos)->member)), typeof(*(pos)), member))
-
-#endif
-
-#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_RCULIST_H_ */
diff --git a/compat-include/linux/skbuff.h b/compat-include/linux/skbuff.h
index 371bb561..36e4d10d 100644
--- a/compat-include/linux/skbuff.h
+++ b/compat-include/linux/skbuff.h
@@ -25,38 +25,6 @@
 #include <linux/version.h>
 #include_next <linux/skbuff.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 8, 0)
-
-/* hack for not correctly set mac_len. This may happen for some special
- * configurations like batman-adv on VLANs.
- *
- * This is pretty dirty, but we only use skb_share_check() in main.c right
- * before mac_len is checked, and the recomputation shouldn't hurt too much.
- */
-#define skb_share_check(skb, b) \
-	({ \
-		struct sk_buff *_t_skb; \
-		_t_skb = skb_share_check(skb, b); \
-		if (_t_skb) \
-			skb_reset_mac_len(_t_skb); \
-		_t_skb; \
-	})
-
-#endif /* < KERNEL_VERSION(3, 8, 0) */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 11, 0)
-
-/* older kernels still need to call skb_abort_seq_read() */
-#define skb_seq_read(consumed, data, st) \
-	({ \
-		int __len = skb_seq_read(consumed, data, st); \
-		if (__len == 0) \
-			skb_abort_seq_read(st); \
-		__len; \
-	})
-
-#endif /* < KERNEL_VERSION(3, 11, 0) */
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 16, 0)
 
 #define pskb_copy_for_clone pskb_copy
diff --git a/compat-include/linux/slab.h b/compat-include/linux/slab.h
deleted file mode 100644
index e74f46ab..00000000
--- a/compat-include/linux/slab.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
- *
- * Marek Lindner, Simon Wunderlich
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
- * This file contains macros for maintaining compatibility with older versions
- * of the Linux kernel.
- */
-
-#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_SLAB_H_
-#define _NET_BATMAN_ADV_COMPAT_LINUX_SLAB_H_
-
-#include <linux/version.h>
-#include_next <linux/slab.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 4, 0)
-
-#define kmalloc_array(n, size, flags) kmalloc(n * size, flags)
-
-#endif /* < KERNEL_VERSION(3, 4, 0) */
-
-#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_SLAB_H_ */
diff --git a/compat-include/linux/timer.h b/compat-include/linux/timer.h
index 74b9b9b2..262c3861 100644
--- a/compat-include/linux/timer.h
+++ b/compat-include/linux/timer.h
@@ -25,17 +25,6 @@
 #include <linux/version.h>
 #include_next <linux/timer.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 7, 0)
-
-#define __setup_timer(_timer, _fn, _data, _flags) \
-	do { \
-		init_timer(_timer); \
-		(_timer)->function = (_fn); \
-		(_timer)->data = (_data); \
-	} while (0)
-
-#endif /* < KERNEL_VERSION(3, 7, 0) */
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4, 14, 0)
 
 #define TIMER_DATA_TYPE		unsigned long
diff --git a/compat-include/net/genetlink.h b/compat-include/net/genetlink.h
deleted file mode 100644
index f638d86d..00000000
--- a/compat-include/net/genetlink.h
+++ /dev/null
@@ -1,147 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
- *
- * Marek Lindner, Simon Wunderlich
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
- * This file contains macros for maintaining compatibility with older versions
- * of the Linux kernel.
- */
-
-#ifndef _NET_BATMAN_ADV_COMPAT_NET_GENETLINK_H_
-#define _NET_BATMAN_ADV_COMPAT_NET_GENETLINK_H_
-
-#include <linux/version.h>
-#include_next <net/genetlink.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 13, 0)
-
-#include <linux/export.h>
-
-struct batadv_genl_family {
-	/* data handled by the actual kernel */
-	struct genl_family family;
-
-	/* data which has to be copied to family by
-	 * batadv_genlmsg_multicast_netns
-	 */
-	unsigned int		id;
-	unsigned int		hdrsize;
-	char			name[GENL_NAMSIZ];
-	unsigned int		version;
-	unsigned int		maxattr;
-	bool			netnsok;
-	bool			parallel_ops;
-	int			(*pre_doit)(struct genl_ops *ops,
-					    struct sk_buff *skb,
-					    struct genl_info *info);
-	void			(*post_doit)(struct genl_ops *ops,
-					     struct sk_buff *skb,
-					     struct genl_info *info);
-	/* WARNING not supported
-	 * int			(*mcast_bind)(struct net *net, int group);
-	 * void			(*mcast_unbind)(struct net *net, int group);
-	 */
-	struct nlattr		**attrbuf;	/* private */
-	struct genl_ops		*ops;		/* private */
-	struct genl_multicast_group *mcgrps; /* private */
-	unsigned int		n_ops;		/* private */
-	unsigned int		n_mcgrps;	/* private */
-	/* unsigned int		mcgrp_offset;	private, WARNING unsupported */
-	struct list_head	family_list;	/* private */
-	struct module		*module;
-};
-
-#define genl_family batadv_genl_family
-
-#define genlmsg_multicast_netns batadv_genlmsg_multicast_netns
-
-static inline int
-batadv_genlmsg_multicast_netns(struct batadv_genl_family *family,
-			       struct net *net,
-			       struct sk_buff *skb,
-			       u32 portid, unsigned int group,
-			       gfp_t flags)
-{
-	group = family->mcgrps[group].id;
-	return nlmsg_multicast(
-		net->genl_sock,
-		skb, portid, group, flags);
-}
-
-#define genlmsg_put(_skb, _pid, _seq, _family, _flags, _cmd) \
-	genlmsg_put(_skb, _pid, _seq, &(_family)->family, _flags, _cmd)
-
-#define genl_unregister_family(_family) \
-	genl_unregister_family(&(_family)->family)
-
-static inline int batadv_genl_register_family(struct genl_family *family)
-{
-	unsigned int i;
-	int ret;
-
-	family->family.id = family->id;
-	family->family.hdrsize = family->hdrsize;
-	strncpy(family->family.name, family->name, sizeof(family->family.name));
-	family->family.version = family->version;
-	family->family.maxattr = family->maxattr;
-	family->family.netnsok = family->netnsok;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 10, 0)
-	family->family.parallel_ops = family->parallel_ops;
-#endif
-	family->family.pre_doit = family->pre_doit;
-	family->family.post_doit = family->post_doit;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 11, 0)
-	family->family.module = family->module;
-#endif
-
-	ret = genl_register_family(&family->family);
-	if (ret < 0)
-		return ret;
-
-	family->attrbuf = family->family.attrbuf;
-	family->id = family->family.id;
-
-	for (i = 0; i < family->n_ops; i++) {
-		ret = genl_register_ops(&family->family, &family->ops[i]);
-		if (ret < 0)
-			goto err;
-	}
-
-	for (i = 0; i < family->n_mcgrps; i++) {
-		ret = genl_register_mc_group(&family->family,
-					     &family->mcgrps[i]);
-		if (ret)
-			goto err;
-	}
-
-	return 0;
-
- err:
-	genl_unregister_family(family);
-	return ret;
-}
-
-#define genl_register_family(family) \
-	batadv_genl_register_family((family))
-
-#define __genl_const
-
-#else
-
-#define __genl_const const
-
-#endif /* < KERNEL_VERSION(3, 13, 0) */
-
-#endif /* _NET_BATMAN_ADV_COMPAT_NET_GENETLINK_H_ */
diff --git a/compat-include/net/ipv6.h b/compat-include/net/ipv6.h
deleted file mode 100644
index b27d0ce0..00000000
--- a/compat-include/net/ipv6.h
+++ /dev/null
@@ -1,38 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
- *
- * Marek Lindner, Simon Wunderlich
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
- * This file contains macros for maintaining compatibility with older versions
- * of the Linux kernel.
- */
-
-#ifndef _NET_BATMAN_ADV_COMPAT_NET_IPV6_H_
-#define _NET_BATMAN_ADV_COMPAT_NET_IPV6_H_
-
-#include <linux/version.h>
-#include_next <net/ipv6.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 3, 0)
-
-#define ipv6_skip_exthdr(skb, start, nexthdrp, frag_offp) \
-	({ \
-		(void)frag_offp; \
-		ipv6_skip_exthdr(skb, start, nexthdrp); \
-	})
-
-#endif /* < KERNEL_VERSION(3, 3, 0) */
-
-#endif /* _NET_BATMAN_ADV_COMPAT_NET_IPV6_H_ */
diff --git a/compat-include/net/netlink.h b/compat-include/net/netlink.h
index d43576e2..c395dafb 100644
--- a/compat-include/net/netlink.h
+++ b/compat-include/net/netlink.h
@@ -25,17 +25,6 @@
 #include <linux/version.h>
 #include_next <net/netlink.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 5, 0)
-
-static inline int nla_put_be32(struct sk_buff *skb, int attrtype, __be32 value)
-{
-	__be32 tmp = value;
-
-	return nla_put(skb, attrtype, sizeof(__be32), &tmp);
-}
-
-#endif /* < KERNEL_VERSION(3, 5, 0) */
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4, 1, 0)
 
 static inline int nla_put_in_addr(struct sk_buff *skb, int attrtype,
diff --git a/compat-include/uapi/linux/eventpoll.h b/compat-include/uapi/linux/eventpoll.h
index 331687ae..1828feb4 100644
--- a/compat-include/uapi/linux/eventpoll.h
+++ b/compat-include/uapi/linux/eventpoll.h
@@ -24,11 +24,7 @@
 
 #include <linux/version.h>
 #include <linux/types.h>
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 7, 0)
 #include_next <uapi/linux/eventpoll.h>
-#else
-#include <linux/eventpoll.h>
-#endif
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4, 12, 0)
 
diff --git a/compat-include/uapi/linux/nl80211.h b/compat-include/uapi/linux/nl80211.h
index 724ab2a6..3e743249 100644
--- a/compat-include/uapi/linux/nl80211.h
+++ b/compat-include/uapi/linux/nl80211.h
@@ -23,11 +23,7 @@
 #define _NET_BATMAN_ADV_COMPAT_UAPI_LINUX_NL80211_H_
 
 #include <linux/version.h>
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 7, 0)
 #include_next <uapi/linux/nl80211.h>
-#else
-#include <linux/nl80211.h>
-#endif
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4, 0, 0)
 
diff --git a/compat-patches/README b/compat-patches/README
deleted file mode 100644
index ceafb1da..00000000
--- a/compat-patches/README
+++ /dev/null
@@ -1,25 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-WARNING
-=======
-
-Please avoid using the compat-patches/ to implement support for old kernels.
-This should be the last resort.
-
- * it is nearly always possible to use compat-includes/ to do the same with a
-   lot less problems
-
- * maintaining these patches is *censored*
-
-GENERATING A PATCH
-==================
-
-If it not possible to avoid a patch then please make the patch as small as
-possible. Even refactor the code which has to be patched to reduce the
-size/number of the changes.
-
-Please use git-format-patches to generate them and order same inside via the
-XXXX- prefix of the patch name.
-
-    git format-patch --abbrev=7 -U3 --diff-algorithm=histogram --no-signature \
-	--format=format:'From: %an <%ae>%nDate: %aD%nSubject: [PATCH] %B' -1
diff --git a/compat-patches/replacements.sh b/compat-patches/replacements.sh
deleted file mode 100755
index 1f43c0da..00000000
--- a/compat-patches/replacements.sh
+++ /dev/null
@@ -1,25 +0,0 @@
-#! /bin/sh
-# SPDX-License-Identifier: GPL-2.0
-# Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
-#
-# Marek Lindner, Simon Wunderlich
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of version 2 of the GNU General Public
-# License as published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, see <http://www.gnu.org/licenses/>.
-
-set -e
-
-# for kernel < 3.13 to make netlink compat code work
-sed -i \
-	-e 's/^static const struct genl_multicast_group batadv_netlink_mcgrps/static __genl_const struct genl_multicast_group batadv_netlink_mcgrps/' \
-	-e 's/^static const struct genl_ops batadv_netlink_ops/static __genl_const struct genl_ops batadv_netlink_ops/' \
-	build/net/batman-adv/netlink.c
diff --git a/compat-sources/Makefile b/compat-sources/Makefile
index 9f3f5d4b..7aabaac6 100644
--- a/compat-sources/Makefile
+++ b/compat-sources/Makefile
@@ -15,6 +15,6 @@
 # You should have received a copy of the GNU General Public License
 # along with this program; if not, see <http://www.gnu.org/licenses/>.
 
-batman-adv-$(CONFIG_BATMAN_ADV_MCAST) += ../../../compat-sources/net/core/skbuff.o
-batman-adv-$(CONFIG_BATMAN_ADV_MCAST) += ../../../compat-sources/net/ipv4/igmp.o
-batman-adv-$(CONFIG_BATMAN_ADV_MCAST) += ../../../compat-sources/net/ipv6/mcast_snoop.o
+batman-adv-$(CONFIG_BATMAN_ADV_MCAST) += ../../compat-sources/net/core/skbuff.o
+batman-adv-$(CONFIG_BATMAN_ADV_MCAST) += ../../compat-sources/net/ipv4/igmp.o
+batman-adv-$(CONFIG_BATMAN_ADV_MCAST) += ../../compat-sources/net/ipv6/mcast_snoop.o
diff --git a/compat.h b/compat.h
index 34f6de9f..385b629c 100644
--- a/compat.h
+++ b/compat.h
@@ -35,104 +35,6 @@
 #error CONFIG_BATMAN_ADV_DEBUG=y requires CONFIG_BATMAN_ADV_DEBUGFS=y
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 9, 0)
-
-#include <linux/netdevice.h>
-
-#define netdev_master_upper_dev_get_rcu(dev) \
-	(dev->priv_flags & IFF_BRIDGE_PORT ? dev : NULL); \
-	break;
-
-#endif /* < KERNEL_VERSION(3, 9, 0) */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 3, 0)
-
-#define batadv_interface_add_vid(x, y, z) \
-__batadv_interface_add_vid(struct net_device *dev, __be16 proto,\
-                          unsigned short vid);\
-static void batadv_interface_add_vid(struct net_device *dev, unsigned short vid)\
-{\
-       __batadv_interface_add_vid(dev, htons(ETH_P_8021Q), vid);\
-}\
-static int __batadv_interface_add_vid(struct net_device *dev, __be16 proto,\
-                                     unsigned short vid)
-
-#define batadv_interface_kill_vid(x, y, z) \
-__batadv_interface_kill_vid(struct net_device *dev, __be16 proto,\
-                           unsigned short vid);\
-static void batadv_interface_kill_vid(struct net_device *dev,\
-                                     unsigned short vid)\
-{\
-       __batadv_interface_kill_vid(dev, htons(ETH_P_8021Q), vid);\
-}\
-static int __batadv_interface_kill_vid(struct net_device *dev, __be16 proto,\
-                                      unsigned short vid)
-
-#endif /* < KERNEL_VERSION(3, 3, 0) */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 7, 0)
-
-#define snd_portid snd_pid
-
-#endif /* < KERNEL_VERSION(3, 7, 0) */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 9, 0)
-
-#define batadv_interface_set_mac_addr(x, y) \
-__batadv_interface_set_mac_addr(struct net_device *dev, void *p);\
-static int batadv_interface_set_mac_addr(struct net_device *dev, void *p) \
-{\
-	int ret;\
-\
-	ret = __batadv_interface_set_mac_addr(dev, p);\
-	if (!ret) \
-		dev->addr_assign_type &= ~NET_ADDR_RANDOM;\
-	return ret;\
-}\
-static int __batadv_interface_set_mac_addr(x, y)
-
-#define batadv_interface_tx(x, y) \
-__batadv_interface_tx(struct sk_buff *skb, struct net_device *soft_iface); \
-static int batadv_interface_tx(struct sk_buff *skb, \
-			       struct net_device *soft_iface) \
-{ \
-	skb_reset_mac_header(skb); \
-	return __batadv_interface_tx(skb, soft_iface); \
-} \
-static int __batadv_interface_tx(struct sk_buff *skb, \
-				 struct net_device *soft_iface)
-
-#endif /* < KERNEL_VERSION(3, 9, 0) */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 10, 0)
-
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 3, 0)
-
-#define batadv_interface_add_vid(x, y, z) \
-__batadv_interface_add_vid(struct net_device *dev, __be16 proto,\
-			   unsigned short vid);\
-static int batadv_interface_add_vid(struct net_device *dev, unsigned short vid)\
-{\
-	return __batadv_interface_add_vid(dev, htons(ETH_P_8021Q), vid);\
-}\
-static int __batadv_interface_add_vid(struct net_device *dev, __be16 proto,\
-				      unsigned short vid)
-
-#define batadv_interface_kill_vid(x, y, z) \
-__batadv_interface_kill_vid(struct net_device *dev, __be16 proto,\
-			    unsigned short vid);\
-static int batadv_interface_kill_vid(struct net_device *dev,\
-				     unsigned short vid)\
-{\
-	return __batadv_interface_kill_vid(dev, htons(ETH_P_8021Q), vid);\
-}\
-static int __batadv_interface_kill_vid(struct net_device *dev, __be16 proto,\
-				       unsigned short vid)
-
-#endif /* >= KERNEL_VERSION(3, 3, 0) */
-
-#endif /* < KERNEL_VERSION(3, 10, 0) */
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4, 0, 0)
 
 /* wild hack for batadv_getlink_net only */
-- 
2.17.0


Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 22 Mar 2015 15:51:16 +0100
Message-Id: <1427035879-24616-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/4] batman-adv: Remove explicit compat.h
	include and split compat.h
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

The current approach for the compat layer is to include the compat.h file at
exactly the right time to provide additional functionality and to live patch
the batman-adv sources. This has the problem that the compat.h file becomes
harder to read over time. Also live patching and adding of missing
functionality partially conflict. This becomes obvious when the include order
in some files is different compared to the one the author of an compat.h entry
expected.

A different approach is to inject intermediate header files which add
additional features. This allows to reduce the size of compat.h and only leaves
the live patching part in it. The compat.h can then added automatically to each
compile run before anything else is included. compat.h has therefore the
control which headers must be included before the live patching of the
batman-adv source can begin.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile                               |   4 +
 compat-include/linux/atomic.h          |  29 +++
 compat-include/linux/bug.h             |  38 ++++
 compat-include/linux/compiler.h        |  40 ++++
 compat-include/linux/etherdevice.h     |  45 +++++
 compat-include/linux/export.h          |  29 +++
 compat-include/linux/if_ether.h        |  33 ++++
 compat-include/linux/if_vlan.h         |  44 +++++
 compat-include/linux/kconfig.h         |  42 ++++
 compat-include/linux/kernel.h          |  44 +++++
 compat-include/linux/list.h            |  54 ++++++
 compat-include/linux/moduleparam.h     |  72 +++++++
 compat-include/linux/net.h             |  39 ++++
 compat-include/linux/netdev_features.h |  35 ++++
 compat-include/linux/netdevice.h       | 114 +++++++++++
 compat-include/linux/percpu.h          |  48 +++++
 compat-include/linux/printk.h          |  39 ++++
 compat-include/linux/random.h          |  33 ++++
 compat-include/linux/rculist.h         |  49 +++++
 compat-include/linux/rcupdate.h        |  39 ++++
 compat-include/linux/seq_file.h        |  36 ++++
 compat-include/linux/skbuff.h          |  94 +++++++++
 compat-include/linux/slab.h            |  33 ++++
 compat.h                               | 344 ++-------------------------------
 main.h                                 |   2 +-
 25 files changed, 1054 insertions(+), 325 deletions(-)
 create mode 100644 compat-include/linux/atomic.h
 create mode 100644 compat-include/linux/bug.h
 create mode 100644 compat-include/linux/compiler.h
 create mode 100644 compat-include/linux/etherdevice.h
 create mode 100644 compat-include/linux/export.h
 create mode 100644 compat-include/linux/if_ether.h
 create mode 100644 compat-include/linux/if_vlan.h
 create mode 100644 compat-include/linux/kconfig.h
 create mode 100644 compat-include/linux/kernel.h
 create mode 100644 compat-include/linux/list.h
 create mode 100644 compat-include/linux/moduleparam.h
 create mode 100644 compat-include/linux/net.h
 create mode 100644 compat-include/linux/netdev_features.h
 create mode 100644 compat-include/linux/netdevice.h
 create mode 100644 compat-include/linux/percpu.h
 create mode 100644 compat-include/linux/printk.h
 create mode 100644 compat-include/linux/random.h
 create mode 100644 compat-include/linux/rculist.h
 create mode 100644 compat-include/linux/rcupdate.h
 create mode 100644 compat-include/linux/seq_file.h
 create mode 100644 compat-include/linux/skbuff.h
 create mode 100644 compat-include/linux/slab.h

diff --git a/Makefile b/Makefile
index 4f6c30a..fd7ae8d 100644
--- a/Makefile
+++ b/Makefile
@@ -41,6 +41,10 @@ RM ?= rm -f
 REVISION= $(shell	if [ -d "$(PWD)/.git" ]; then \
 				echo $$(git --git-dir="$(PWD)/.git" describe --always --dirty --match "v*" |sed 's/^v//' 2> /dev/null || echo "[unknown]"); \
 			fi)
+NOSTDINC_FLAGS := \
+	-I$(PWD)/compat-include/ \
+	-include $(PWD)/compat.h \
+	$(CFLAGS)
 
 CONFIG_BATMAN_ADV=m
 batman-adv-y += compat.o
diff --git a/compat-include/linux/atomic.h b/compat-include/linux/atomic.h
new file mode 100644
index 0000000..304af51
--- /dev/null
+++ b/compat-include/linux/atomic.h
@@ -0,0 +1,29 @@
+/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner, Simon Wunderlich
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
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_ATOMIC_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_ATOMIC_H_
+
+#include <linux/version.h>
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 37)
+#include_next <linux/atomic.h>
+#endif
+
+#endif /* _NET_BATMAN_ADV_COMPAT_LINUX_ATOMIC_H_ */
diff --git a/compat-include/linux/bug.h b/compat-include/linux/bug.h
new file mode 100644
index 0000000..66f79f8
--- /dev/null
+++ b/compat-include/linux/bug.h
@@ -0,0 +1,38 @@
+/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner, Simon Wunderlich
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
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_BUG_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_BUG_H_
+
+#include <linux/version.h>
+#include_next <linux/bug.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 0, 0)
+
+#undef BUILD_BUG_ON
+#ifdef __CHECKER__
+#define BUILD_BUG_ON(condition) (0)
+#else /* __CHECKER__ */
+#define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2 * !!(condition)]))
+#endif /* __CHECKER__ */
+
+#endif /* < KERNEL_VERSION(3, 0, 0) */
+
+#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_BUG_H_ */
diff --git a/compat-include/linux/compiler.h b/compat-include/linux/compiler.h
new file mode 100644
index 0000000..1717105
--- /dev/null
+++ b/compat-include/linux/compiler.h
@@ -0,0 +1,40 @@
+/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner, Simon Wunderlich
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
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_COMPILER_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_COMPILER_H_
+
+#include <linux/version.h>
+#include_next <linux/compiler.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 33)
+
+#define __always_unused			__attribute__((unused))
+#define __percpu
+
+#endif /* < KERNEL_VERSION(2, 6, 33) */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 36)
+
+#define __rcu
+
+#endif /* < KERNEL_VERSION(2, 6, 36) */
+
+#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_COMPILER_H_ */
diff --git a/compat-include/linux/etherdevice.h b/compat-include/linux/etherdevice.h
new file mode 100644
index 0000000..c20b43c
--- /dev/null
+++ b/compat-include/linux/etherdevice.h
@@ -0,0 +1,45 @@
+/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner, Simon Wunderlich
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
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_ETHERDEVICE_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_ETHERDEVICE_H_
+
+#include <linux/version.h>
+#include_next <linux/etherdevice.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 4, 0)
+
+#define eth_hw_addr_random(dev)	batadv_eth_hw_addr_random(dev)
+
+static inline void batadv_eth_hw_addr_random(struct net_device *dev)
+{
+	random_ether_addr(dev->dev_addr);
+}
+
+#endif /* < KERNEL_VERSION(3, 4, 0) */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 14, 0)
+
+#define ether_addr_equal_unaligned(_a, _b) (memcmp(_a, _b, ETH_ALEN) == 0)
+#define ether_addr_copy(_a, _b) memcpy(_a, _b, ETH_ALEN)
+
+#endif /* < KERNEL_VERSION(3, 14, 0) */
+
+#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_ETHERDEVICE_H_ */
diff --git a/compat-include/linux/export.h b/compat-include/linux/export.h
new file mode 100644
index 0000000..3b31a2d
--- /dev/null
+++ b/compat-include/linux/export.h
@@ -0,0 +1,29 @@
+/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner, Simon Wunderlich
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
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_EXPORT_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_EXPORT_H_
+
+#include <linux/version.h>
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 2, 0)
+#include_next <linux/export.h>
+#endif
+
+#endif /* _NET_BATMAN_ADV_COMPAT_LINUX_EXPORT_H_ */
diff --git a/compat-include/linux/if_ether.h b/compat-include/linux/if_ether.h
new file mode 100644
index 0000000..5ea164f
--- /dev/null
+++ b/compat-include/linux/if_ether.h
@@ -0,0 +1,33 @@
+/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner, Simon Wunderlich
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
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_IF_ETHER_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_IF_ETHER_H_
+
+#include <linux/version.h>
+#include_next <linux/if_ether.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 8, 0)
+
+#define ETH_P_BATMAN	0x4305
+
+#endif /* < KERNEL_VERSION(3, 8, 0) */
+
+#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_IF_ETHER_H_ */
diff --git a/compat-include/linux/if_vlan.h b/compat-include/linux/if_vlan.h
new file mode 100644
index 0000000..3b146b4
--- /dev/null
+++ b/compat-include/linux/if_vlan.h
@@ -0,0 +1,44 @@
+/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner, Simon Wunderlich
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
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_IF_VLAN_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_IF_VLAN_H_
+
+#include <linux/version.h>
+#include_next <linux/if_vlan.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 33)
+
+#define VLAN_PRIO_MASK          0xe000 /* Priority Code Point */
+#define VLAN_PRIO_SHIFT         13
+
+#endif /* < KERNEL_VERSION(2, 6, 33) */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 0, 0)
+
+#define vlan_insert_tag(skb, proto, vid) __vlan_put_tag(skb, vid)
+
+#elif LINUX_VERSION_CODE < KERNEL_VERSION(3, 10, 0)
+
+#define vlan_insert_tag(skb, proto, vid) vlan_insert_tag(skb, vid)
+
+#endif /* < KERNEL_VERSION(3, 0, 0) */
+
+#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_IF_VLAN_H_ */
diff --git a/compat-include/linux/kconfig.h b/compat-include/linux/kconfig.h
new file mode 100644
index 0000000..be8aa02
--- /dev/null
+++ b/compat-include/linux/kconfig.h
@@ -0,0 +1,42 @@
+/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner, Simon Wunderlich
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
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_KCONFIG_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_KCONFIG_H_
+
+#include <linux/version.h>
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 1, 0)
+#include_next <linux/kconfig.h>
+#endif
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 1, 0)
+
+#define __ARG_PLACEHOLDER_1 0,
+#define config_enabled(cfg) _config_enabled(cfg)
+#define _config_enabled(value) __config_enabled(__ARG_PLACEHOLDER_##value)
+#define __config_enabled(arg1_or_junk) ___config_enabled(arg1_or_junk 1, 0)
+#define ___config_enabled(__ignored, val, ...) val
+
+#define IS_ENABLED(option) \
+	(config_enabled(option) || config_enabled(option##_MODULE))
+
+#endif /* < KERNEL_VERSION(3, 1, 0) */
+
+#endif /* _NET_BATMAN_ADV_COMPAT_LINUX_KCONFIG_H_ */
diff --git a/compat-include/linux/kernel.h b/compat-include/linux/kernel.h
new file mode 100644
index 0000000..81b2862
--- /dev/null
+++ b/compat-include/linux/kernel.h
@@ -0,0 +1,44 @@
+/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner, Simon Wunderlich
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
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_KERNEL_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_KERNEL_H_
+
+#include <linux/version.h>
+#include_next <linux/kernel.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 39)
+
+#define kstrtou32(cp, base, v)\
+({\
+	unsigned long _v;\
+	int _r;\
+	_r = strict_strtoul(cp, base, &_v);\
+	*(v) = (uint32_t)_v;\
+	if ((unsigned long)*(v) != _v)\
+		_r = -ERANGE;\
+	_r;\
+})
+#define kstrtoul strict_strtoul
+#define kstrtol  strict_strtol
+
+#endif /* < KERNEL_VERSION(2, 6, 39) */
+
+#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_KERNEL_H_ */
diff --git a/compat-include/linux/list.h b/compat-include/linux/list.h
new file mode 100644
index 0000000..dcd604c
--- /dev/null
+++ b/compat-include/linux/list.h
@@ -0,0 +1,54 @@
+/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner, Simon Wunderlich
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
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_LIST_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_LIST_H_
+
+#include <linux/version.h>
+#include_next <linux/list.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 9, 0)
+
+#define hlist_entry_safe(ptr, type, member) \
+	({ typeof(ptr) ____ptr = (ptr); \
+	   ____ptr ? hlist_entry(____ptr, type, member) : NULL; \
+	})
+
+#undef hlist_for_each_entry
+#define hlist_for_each_entry(pos, head, member) \
+	for (pos = hlist_entry_safe((head)->first, typeof(*(pos)), member);\
+	pos; \
+	pos = hlist_entry_safe((pos)->member.next, typeof(*(pos)), member))
+
+#undef hlist_for_each_entry_safe
+#define hlist_for_each_entry_safe(pos, n, head, member) \
+	for (pos = hlist_entry_safe((head)->first, typeof(*pos), member);\
+	pos && ({ n = pos->member.next; 1; }); \
+	pos = hlist_entry_safe(n, typeof(*pos), member))
+
+#endif
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 17, 0)
+
+#define hlist_add_behind(n, prev) hlist_add_after(prev, n)
+
+#endif
+
+#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_LIST_H_ */
diff --git a/compat-include/linux/moduleparam.h b/compat-include/linux/moduleparam.h
new file mode 100644
index 0000000..fd8ac41
--- /dev/null
+++ b/compat-include/linux/moduleparam.h
@@ -0,0 +1,72 @@
+/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner, Simon Wunderlich
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
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_MODULEPARAM_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_MODULEPARAM_H_
+
+#include <linux/version.h>
+#include_next <linux/moduleparam.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 31)
+
+#define __compat__module_param_call(p1, p2, p3, p4, p5, p6, p7) \
+	__module_param_call(p1, p2, p3, p4, p5, p7)
+
+#else
+
+#define __compat__module_param_call(p1, p2, p3, p4, p5, p6, p7) \
+	__module_param_call(p1, p2, p3, p4, p5, p6, p7)
+
+#endif /* < KERNEL_VERSION(2, 6, 31) */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 36)
+
+struct kernel_param_ops {
+	/* Returns 0, or -errno.  arg is in kp->arg. */
+	int (*set)(const char *val, const struct kernel_param *kp);
+	/* Returns length written or -errno.  Buffer is 4k (ie. be short!) */
+	int (*get)(char *buffer, struct kernel_param *kp);
+	/* Optional function to free kp->arg when module unloaded. */
+	void (*free)(void *arg);
+};
+
+#define module_param_cb(name, ops, arg, perm)				\
+	static int __compat_set_param_##name(const char *val,		\
+					     struct kernel_param *kp)	\
+				{ return (ops)->set(val, kp); }		\
+	static int __compat_get_param_##name(char *buffer,		\
+					     struct kernel_param *kp)	\
+				{ return (ops)->get(buffer, kp); }	\
+	__compat__module_param_call(MODULE_PARAM_PREFIX, name,		\
+				    __compat_set_param_##name,		\
+				    __compat_get_param_##name, arg,	\
+				    __same_type((arg), bool *), perm)
+
+static inline int batadv_param_set_copystring(const char *val,
+					      const struct kernel_param *kp)
+{
+	return param_set_copystring(val, (struct kernel_param *)kp);
+}
+
+#define param_set_copystring batadv_param_set_copystring
+
+#endif /* < KERNEL_VERSION(2, 6, 36) */
+
+#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_MODULEPARAM_H_ */
diff --git a/compat-include/linux/net.h b/compat-include/linux/net.h
new file mode 100644
index 0000000..fcd7873
--- /dev/null
+++ b/compat-include/linux/net.h
@@ -0,0 +1,39 @@
+/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner, Simon Wunderlich
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
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_NET_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_NET_H_
+
+#include <linux/version.h>
+#include_next <linux/net.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 5, 0)
+
+#ifndef net_ratelimited_function
+#define net_ratelimited_function(func, ...) \
+	do { \
+		if (net_ratelimit()) \
+			func(__VA_ARGS__); \
+	} while (0)
+#endif /* ifndef net_ratelimited_function */
+
+#endif /* < KERNEL_VERSION(3, 5, 0) */
+
+#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_NET_H_ */
diff --git a/compat-include/linux/netdev_features.h b/compat-include/linux/netdev_features.h
new file mode 100644
index 0000000..36c9c2f
--- /dev/null
+++ b/compat-include/linux/netdev_features.h
@@ -0,0 +1,35 @@
+/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner, Simon Wunderlich
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
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_NETDEV_FEATURES_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_NETDEV_FEATURES_H_
+
+#include <linux/version.h>
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 3, 0)
+#include_next <linux/netdev_features.h>
+#endif /* >= KERNEL_VERSION(3, 3, 0) */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 10, 0)
+
+#define NETIF_F_HW_VLAN_CTAG_FILTER NETIF_F_HW_VLAN_FILTER
+
+#endif /* < KERNEL_VERSION(3, 10, 0) */
+
+#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_NETDEV_FEATURES_H_ */
diff --git a/compat-include/linux/netdevice.h b/compat-include/linux/netdevice.h
new file mode 100644
index 0000000..9a2f204
--- /dev/null
+++ b/compat-include/linux/netdevice.h
@@ -0,0 +1,114 @@
+/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner, Simon Wunderlich
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
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_NETDEVICE_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_NETDEVICE_H_
+
+#include <linux/version.h>
+#include_next <linux/netdevice.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 3, 0)
+
+#include <linux/netdev_features.h>
+
+#endif /* < KERNEL_VERSION(3, 3, 0) */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 33)
+
+#define unregister_netdevice_queue(dev, head) unregister_netdevice(dev)
+
+#endif /* < KERNEL_VERSION(2, 6, 33) */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 35)
+
+#include <linux/etherdevice.h>
+
+#undef  netdev_for_each_mc_addr
+#define netdev_for_each_mc_addr(mclist, dev) \
+	for (mclist = (struct batadv_dev_addr_list *)dev->mc_list; mclist; \
+	     mclist = (struct batadv_dev_addr_list *)mclist->next)
+
+/* Note, that this breaks the usage of the normal 'struct netdev_hw_addr'
+ * for kernels < 2.6.35 in batman-adv!
+ */
+#define netdev_hw_addr batadv_dev_addr_list
+struct batadv_dev_addr_list {
+	struct dev_addr_list *next;
+	u8  addr[MAX_ADDR_LEN];
+	u8  da_addrlen;
+	u8  da_synced;
+	int da_users;
+	int da_gusers;
+};
+
+#endif /* < KERNEL_VERSION(2, 6, 35) */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 36)
+
+#define NET_ADDR_RANDOM 0
+
+#endif /* < KERNEL_VERSION(2, 6, 36) */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 39)
+
+/* On older kernels net_dev->master is reserved for iface bonding. */
+static inline int batadv_netdev_set_master(struct net_device *slave,
+					   struct net_device *master)
+{
+	return 0;
+}
+
+#define netdev_set_master batadv_netdev_set_master
+
+#endif /* < KERNEL_VERSION(2, 6, 39) */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 9, 0)
+
+#define netdev_master_upper_dev_link netdev_set_master
+#define netdev_upper_dev_unlink(slave, master) netdev_set_master(slave, NULL)
+#define netdev_master_upper_dev_get(dev) \
+({\
+	ASSERT_RTNL();\
+	dev->master;\
+})
+
+#endif /* < KERNEL_VERSION(3, 9, 0) */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 11, 0)
+
+#define netdev_notifier_info_to_dev(ptr) ptr
+
+#endif /* < KERNEL_VERSION(3, 11, 0) */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 17, 0)
+
+/* alloc_netdev() was defined differently before 2.6.38 */
+#undef alloc_netdev
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 38)
+#define alloc_netdev(sizeof_priv, name, name_assign_type, setup) \
+	alloc_netdev_mq(sizeof_priv, name, setup, 1)
+#else
+#define alloc_netdev(sizeof_priv, name, name_assign_type, setup) \
+	alloc_netdev_mqs(sizeof_priv, name, setup, 1, 1)
+#endif /* nested < KERNEL_VERSION(2, 6, 38) */
+
+#endif /* < KERNEL_VERSION(3, 17, 0) */
+
+#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_NETDEVICE_H_ */
diff --git a/compat-include/linux/percpu.h b/compat-include/linux/percpu.h
new file mode 100644
index 0000000..82355e4
--- /dev/null
+++ b/compat-include/linux/percpu.h
@@ -0,0 +1,48 @@
+/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner, Simon Wunderlich
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
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_PERCPU_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_PERCPU_H_
+
+#include <linux/version.h>
+#include_next <linux/percpu.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 30)
+
+#undef __alloc_percpu
+#define __alloc_percpu(size, align) \
+	percpu_alloc_mask((size), GFP_KERNEL, cpu_possible_map)
+
+#endif /* < KERNEL_VERSION(2, 6, 30) */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 33)
+
+#define this_cpu_add(x, c)	batadv_this_cpu_add(&(x), c)
+
+static inline void batadv_this_cpu_add(uint64_t *count_ptr, size_t count)
+{
+	int cpu = get_cpu();
+	*per_cpu_ptr(count_ptr, cpu) += count;
+	put_cpu();
+}
+
+#endif /* < KERNEL_VERSION(2, 6, 33) */
+
+#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_PERCPU_H_ */
diff --git a/compat-include/linux/printk.h b/compat-include/linux/printk.h
new file mode 100644
index 0000000..c69c406
--- /dev/null
+++ b/compat-include/linux/printk.h
@@ -0,0 +1,39 @@
+/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner, Simon Wunderlich
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
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_PRINTK_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_PRINTK_H_
+
+#include <linux/version.h>
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 37)
+#include_next <linux/printk.h>
+#endif
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 35)
+
+#define pr_warn pr_warning
+
+#endif
+
+#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_PRINTK_H_ */
+
+#ifndef pr_fmt
+#define pr_fmt(fmt) fmt
+#endif
diff --git a/compat-include/linux/random.h b/compat-include/linux/random.h
new file mode 100644
index 0000000..ce12f1a
--- /dev/null
+++ b/compat-include/linux/random.h
@@ -0,0 +1,33 @@
+/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner, Simon Wunderlich
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
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_RANDOM_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_RANDOM_H_
+
+#include <linux/version.h>
+#include_next <linux/random.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 9, 0)
+
+#define prandom_u32() random32()
+
+#endif /* < KERNEL_VERSION(3, 9, 0) */
+
+#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_RANDOM_H_ */
diff --git a/compat-include/linux/rculist.h b/compat-include/linux/rculist.h
new file mode 100644
index 0000000..4736db1
--- /dev/null
+++ b/compat-include/linux/rculist.h
@@ -0,0 +1,49 @@
+/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner, Simon Wunderlich
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
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_RCULIST_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_RCULIST_H_
+
+#include <linux/version.h>
+#include_next <linux/rculist.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 37)
+
+#define hlist_first_rcu(head) \
+	(*((struct hlist_node __rcu **)(&(head)->first)))
+
+#define hlist_next_rcu(node) \
+	(*((struct hlist_node __rcu **)(&(node)->next)))
+
+#endif /* < KERNEL_VERSION(2, 6, 37) */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 9, 0)
+
+#undef hlist_for_each_entry_rcu
+#define hlist_for_each_entry_rcu(pos, head, member) \
+	for (pos = hlist_entry_safe(rcu_dereference_raw(hlist_first_rcu(head)),\
+	typeof(*(pos)), member); \
+	pos; \
+	pos = hlist_entry_safe(rcu_dereference_raw(hlist_next_rcu(\
+	&(pos)->member)), typeof(*(pos)), member))
+
+#endif
+
+#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_RCULIST_H_ */
diff --git a/compat-include/linux/rcupdate.h b/compat-include/linux/rcupdate.h
new file mode 100644
index 0000000..f3ed948
--- /dev/null
+++ b/compat-include/linux/rcupdate.h
@@ -0,0 +1,39 @@
+/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner, Simon Wunderlich
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
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_RCUPDATE_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_RCUPDATE_H_
+
+#include <linux/version.h>
+#include_next <linux/rcupdate.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 34)
+
+#define rcu_dereference_protected(p, c) (p)
+
+#define rcu_dereference_raw(p)	({ \
+				 typeof(p) _________p1 = ACCESS_ONCE(p); \
+				 smp_read_barrier_depends(); \
+				 (_________p1); \
+				 })
+
+#endif /* < KERNEL_VERSION(2, 6, 34) */
+
+#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_RCUPDATE_H_ */
diff --git a/compat-include/linux/seq_file.h b/compat-include/linux/seq_file.h
new file mode 100644
index 0000000..5eaaec8
--- /dev/null
+++ b/compat-include/linux/seq_file.h
@@ -0,0 +1,36 @@
+/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner, Simon Wunderlich
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
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_SEQ_FILE_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_SEQ_FILE_H_
+
+#include <linux/version.h>
+#include_next <linux/seq_file.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 19, 0)
+
+static inline bool seq_has_overflowed(struct seq_file *m)
+{
+	return m->count == m->size;
+}
+
+#endif /* < KERNEL_VERSION(3, 19, 0) */
+
+#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_SEQ_FILE_H_ */
diff --git a/compat-include/linux/skbuff.h b/compat-include/linux/skbuff.h
new file mode 100644
index 0000000..ed911ef
--- /dev/null
+++ b/compat-include/linux/skbuff.h
@@ -0,0 +1,94 @@
+/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner, Simon Wunderlich
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
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_SKBUFF_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_SKBUFF_H_
+
+#include <linux/version.h>
+#include_next <linux/skbuff.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 30)
+
+#define consume_skb(_skb) kfree_skb(_skb)
+
+#endif /* < KERNEL_VERSION(2, 6, 30) */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 33)
+
+static inline struct sk_buff *netdev_alloc_skb_ip_align(struct net_device *dev,
+							unsigned int length)
+{
+	struct sk_buff *skb = netdev_alloc_skb(dev, length + NET_IP_ALIGN);
+
+	if (NET_IP_ALIGN && skb)
+		skb_reserve(skb, NET_IP_ALIGN);
+	return skb;
+}
+
+#endif /* < KERNEL_VERSION(2, 6, 33) */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 0, 0)
+
+static inline void skb_reset_mac_len(struct sk_buff *skb)
+{
+	skb->mac_len = skb->network_header - skb->mac_header;
+}
+
+#endif /* < KERNEL_VERSION(3, 0, 0) */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 8, 0)
+
+/* hack for not correctly set mac_len. This may happen for some special
+ * configurations like batman-adv on VLANs.
+ *
+ * This is pretty dirty, but we only use skb_share_check() in main.c right
+ * before mac_len is checked, and the recomputation shouldn't hurt too much.
+ */
+#define skb_share_check(skb, b) \
+	({ \
+		struct sk_buff *_t_skb; \
+		_t_skb = skb_share_check(skb, b); \
+		if (_t_skb) \
+			skb_reset_mac_len(_t_skb); \
+		_t_skb; \
+	})
+
+#endif /* < KERNEL_VERSION(3, 8, 0) */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 11, 0)
+
+/* older kernels still need to call skb_abort_seq_read() */
+#define skb_seq_read(consumed, data, st) \
+	({ \
+		int __len = skb_seq_read(consumed, data, st); \
+		if (__len == 0) \
+			skb_abort_seq_read(st); \
+		__len; \
+	})
+
+#endif /* < KERNEL_VERSION(3, 11, 0) */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 16, 0)
+
+#define pskb_copy_for_clone pskb_copy
+
+#endif /* < KERNEL_VERSION(3, 16, 0) */
+
+#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_SKBUFF_H_ */
diff --git a/compat-include/linux/slab.h b/compat-include/linux/slab.h
new file mode 100644
index 0000000..569c5aa
--- /dev/null
+++ b/compat-include/linux/slab.h
@@ -0,0 +1,33 @@
+/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner, Simon Wunderlich
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
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_SLAB_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_SLAB_H_
+
+#include <linux/version.h>
+#include_next <linux/slab.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 4, 0)
+
+#define kmalloc_array(n, size, flags) kmalloc(n * size, flags)
+
+#endif /* < KERNEL_VERSION(3, 4, 0) */
+
+#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_SLAB_H_ */
diff --git a/compat.h b/compat.h
index 3b59e78..ed90e2e 100644
--- a/compat.h
+++ b/compat.h
@@ -22,30 +22,7 @@
 #define _NET_BATMAN_ADV_COMPAT_H_
 
 #include <linux/version.h>	/* LINUX_VERSION_CODE */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 30)
-
-#define consume_skb(_skb) kfree_skb(_skb)
-
-#undef __alloc_percpu
-#define __alloc_percpu(size, align) \
-	percpu_alloc_mask((size), GFP_KERNEL, cpu_possible_map)
-
-#endif /* < KERNEL_VERSION(2, 6, 30) */
-
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 31)
-
-#define __compat__module_param_call(p1, p2, p3, p4, p5, p6, p7) \
-	__module_param_call(p1, p2, p3, p4, p5, p7)
-
-#else
-
-#define __compat__module_param_call(p1, p2, p3, p4, p5, p6, p7) \
-	__module_param_call(p1, p2, p3, p4, p5, p6, p7)
-
-#endif /* < KERNEL_VERSION(2, 6, 31) */
-
+#include <linux/kconfig.h>
 
 #if (LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 33))
 #include <linux/autoconf.h>
@@ -56,154 +33,47 @@
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 33)
 
-#define __always_unused			__attribute__((unused))
-#define __percpu
-
 #define skb_iif iif
 
-#define this_cpu_add(x, c)	batadv_this_cpu_add(&(x), c)
-
-static inline void batadv_this_cpu_add(uint64_t *count_ptr, size_t count)
-{
-	int cpu = get_cpu();
-	*per_cpu_ptr(count_ptr, cpu) += count;
-	put_cpu();
-}
-
 #define batadv_softif_destroy_netlink(dev, head) batadv_softif_destroy_netlink(dev)
-#define unregister_netdevice_queue(dev, head) unregister_netdevice(dev)
-
-static inline struct sk_buff *netdev_alloc_skb_ip_align(struct net_device *dev,
-							unsigned int length)
-{
-	struct sk_buff *skb = netdev_alloc_skb(dev, length + NET_IP_ALIGN);
-
-	if (NET_IP_ALIGN && skb)
-		skb_reserve(skb, NET_IP_ALIGN);
-	return skb;
-}
-
-#define VLAN_PRIO_MASK          0xe000 /* Priority Code Point */
-#define VLAN_PRIO_SHIFT         13
 
 #endif /* < KERNEL_VERSION(2, 6, 33) */
 
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 34)
-
-#define rcu_dereference_protected(p, c) (p)
-
-#define rcu_dereference_raw(p)	({ \
-				 typeof(p) _________p1 = ACCESS_ONCE(p); \
-				 smp_read_barrier_depends(); \
-				 (_________p1); \
-				 })
-
-#endif /* < KERNEL_VERSION(2, 6, 34) */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 35)
-
-#define pr_warn pr_warning
-
-#undef  netdev_for_each_mc_addr
-#define netdev_for_each_mc_addr(mclist, dev) \
-	for (mclist = (struct batadv_dev_addr_list *)dev->mc_list; mclist; \
-	     mclist = (struct batadv_dev_addr_list *)mclist->next)
-
-/* Note, that this breaks the usage of the normal 'struct netdev_hw_addr'
- * for kernels < 2.6.35 in batman-adv!
- */
-#define netdev_hw_addr batadv_dev_addr_list
-struct batadv_dev_addr_list {
-	struct dev_addr_list *next;
-	u8  addr[MAX_ADDR_LEN];
-	u8  da_addrlen;
-	u8  da_synced;
-	int da_users;
-	int da_gusers;
-};
-
-#endif /* < KERNEL_VERSION(2, 6, 35) */
-
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 36)
 
-#define __rcu
-#define IFF_BRIDGE_PORT  0 || (hard_iface->net_dev->br_port ? 1 : 0)
-
-struct kernel_param_ops {
-	/* Returns 0, or -errno.  arg is in kp->arg. */
-	int (*set)(const char *val, const struct kernel_param *kp);
-	/* Returns length written or -errno.  Buffer is 4k (ie. be short!) */
-	int (*get)(char *buffer, struct kernel_param *kp);
-	/* Optional function to free kp->arg when module unloaded. */
-	void (*free)(void *arg);
-};
-
-#define module_param_cb(name, ops, arg, perm)				\
-	static int __compat_set_param_##name(const char *val,		\
-					     struct kernel_param *kp)	\
-				{ return (ops)->set(val, kp); }		\
-	static int __compat_get_param_##name(char *buffer,		\
-					     struct kernel_param *kp)	\
-				{ return (ops)->get(buffer, kp); }	\
-	__compat__module_param_call(MODULE_PARAM_PREFIX, name,		\
-				    __compat_set_param_##name,		\
-				    __compat_get_param_##name, arg,	\
-				    __same_type((arg), bool *), perm)
-
-static inline int batadv_param_set_copystring(const char *val,
-					      const struct kernel_param *kp)
-{
-	return param_set_copystring(val, (struct kernel_param *)kp);
-}
-#define param_set_copystring batadv_param_set_copystring
-
-/* hack for dev->addr_assign_type &= ~NET_ADDR_RANDOM; */
-#define addr_assign_type ifindex
-#define NET_ADDR_RANDOM 0
+#include <linux/netdevice.h>
 
 #define netdev_master_upper_dev_get_rcu(dev) \
 	(dev->br_port ? dev : NULL); \
 	break;
 
+#elif LINUX_VERSION_CODE < KERNEL_VERSION(3, 9, 0)
+
+#include <linux/netdevice.h>
+
+#define netdev_master_upper_dev_get_rcu(dev) \
+	(dev->priv_flags & IFF_BRIDGE_PORT ? dev : NULL); \
+	break;
+
 #endif /* < KERNEL_VERSION(2, 6, 36) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 37)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 36)
 
-#define hlist_first_rcu(head)	(*((struct hlist_node __rcu **)(&(head)->first)))
-#define hlist_next_rcu(node)	(*((struct hlist_node __rcu **)(&(node)->next)))
+#define IFF_BRIDGE_PORT  0 || (hard_iface->net_dev->br_port ? 1 : 0)
 
-#endif /* < KERNEL_VERSION(2, 6, 37) */
+/* hack for dev->addr_assign_type &= ~NET_ADDR_RANDOM; */
+#define addr_assign_type ifindex
+
+#endif /* < KERNEL_VERSION(2, 6, 36) */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 39)
 
-#define kstrtou32(cp, base, v)\
-({\
-	unsigned long _v;\
-	int _r;\
-	_r = strict_strtoul(cp, base, &_v);\
-	*(v) = (uint32_t)_v;\
-	if ((unsigned long)*(v) != _v)\
-		_r = -ERANGE;\
-	_r;\
-})
-#define kstrtoul strict_strtoul
-#define kstrtol  strict_strtol
-
-/* On older kernels net_dev->master is reserved for iface bonding. */
-static inline int batadv_netdev_set_master(struct net_device *slave,
-					   struct net_device *master)
-{
-	return 0;
-}
-
-#define netdev_set_master batadv_netdev_set_master
-
 /* Hack for removing ndo_add/del_slave at the end of net_device_ops.
  * This is somewhat ugly because it requires that ndo_validate_addr
  * is at the end of this struct in soft-interface.c.
  */
+#include <linux/netdevice.h>
+
 #define ndo_validate_addr \
 	ndo_validate_addr = eth_validate_addr, \
 }; \
@@ -223,7 +93,8 @@ static const struct { \
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 0, 0)
 
 #define kfree_rcu(ptr, rcu_head) call_rcu(&ptr->rcu_head, batadv_free_rcu_##ptr)
-#define vlan_insert_tag(skb, proto, vid) __vlan_put_tag(skb, vid)
+
+struct rcu_head;
 
 void batadv_free_rcu_orig_vlan(struct rcu_head *rcu);
 void batadv_free_rcu_softif_vlan(struct rcu_head *rcu);
@@ -235,32 +106,8 @@ void batadv_free_rcu_dat_entry(struct rcu_head *rcu);
 void batadv_free_rcu_nc_path(struct rcu_head *rcu);
 void batadv_free_rcu_tvlv_handler(struct rcu_head *rcu);
 
-static inline void skb_reset_mac_len(struct sk_buff *skb)
-{
-	skb->mac_len = skb->network_header - skb->mac_header;
-}
-
-#undef BUILD_BUG_ON
-#ifdef __CHECKER__
-#define BUILD_BUG_ON(condition) (0)
-#else /* __CHECKER__ */
-#define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(condition)]))
-#endif /* __CHECKER__ */
-
 #endif /* < KERNEL_VERSION(3, 0, 0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 1, 0)
-
-#define __ARG_PLACEHOLDER_1 0,
-#define config_enabled(cfg) _config_enabled(cfg)
-#define _config_enabled(value) __config_enabled(__ARG_PLACEHOLDER_##value)
-#define __config_enabled(arg1_or_junk) ___config_enabled(arg1_or_junk 1, 0)
-#define ___config_enabled(__ignored, val, ...) val
-
-#define IS_ENABLED(option) \
-       (config_enabled(option) || config_enabled(option##_MODULE))
-
-#endif /* < KERNEL_VERSION(3, 1, 0) */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 3, 0)
 
@@ -287,56 +134,8 @@ static int __batadv_interface_kill_vid(struct net_device *dev, __be16 proto,\
 
 #endif /* < KERNEL_VERSION(3, 3, 0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 4, 0)
-
-#define eth_hw_addr_random(dev)	batadv_eth_hw_addr_random(dev)
-
-static inline void batadv_eth_hw_addr_random(struct net_device *dev)
-{
-	random_ether_addr(dev->dev_addr);
-}
-
-#define kmalloc_array(n, size, flags) kmalloc(n * size, flags)
-
-#endif /* < KERNEL_VERSION(3, 4, 0) */
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
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 8, 0)
-
-#define ETH_P_BATMAN	0x4305
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
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 9, 0)
 
-#define prandom_u32() random32()
-
 #define batadv_interface_set_mac_addr(x, y) \
 __batadv_interface_set_mac_addr(struct net_device *dev, void *p);\
 static int batadv_interface_set_mac_addr(struct net_device *dev, void *p) \
@@ -361,61 +160,10 @@ static int batadv_interface_tx(struct sk_buff *skb, \
 static int __batadv_interface_tx(struct sk_buff *skb, \
 				 struct net_device *soft_iface)
 
-#define netdev_master_upper_dev_link netdev_set_master
-#define netdev_upper_dev_unlink(slave, master) netdev_set_master(slave, NULL)
-#define netdev_master_upper_dev_get(dev) \
-({\
-	ASSERT_RTNL();\
-	dev->master;\
-})
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
-#undef hlist_for_each_entry_rcu
-#define hlist_for_each_entry_rcu(pos, head, member) \
-	for (pos = hlist_entry_safe (rcu_dereference_raw(hlist_first_rcu(head)),\
-	typeof(*(pos)), member); \
-	pos; \
-	pos = hlist_entry_safe(rcu_dereference_raw(hlist_next_rcu(\
-	&(pos)->member)), typeof(*(pos)), member))
-
-#undef hlist_for_each_entry_safe
-#define hlist_for_each_entry_safe(pos, n, head, member) \
-	for (pos = hlist_entry_safe((head)->first, typeof(*pos), member);\
-	pos && ({ n = pos->member.next; 1; }); \
-	pos = hlist_entry_safe(n, typeof(*pos), member))
-
-#ifndef netdev_master_upper_dev_get_rcu
-#define netdev_master_upper_dev_get_rcu(dev) \
-	(dev->priv_flags & IFF_BRIDGE_PORT ? dev : NULL); \
-	break;
-
-#endif /* netdev_master_upper_dev_get_rcu */
-
 #endif /* < KERNEL_VERSION(3, 9, 0) */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 10, 0)
 
-#ifndef vlan_insert_tag
-
-/* include this header early to let the following define
- * not mess up the original function prototype.
- */
-#include <linux/if_vlan.h>
-#define vlan_insert_tag(skb, proto, vid) vlan_insert_tag(skb, vid)
-
-#endif /* vlan_insert_tag */
-
-#define NETIF_F_HW_VLAN_CTAG_FILTER NETIF_F_HW_VLAN_FILTER
-
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 3, 0)
 
 #define batadv_interface_add_vid(x, y, z) \
@@ -443,56 +191,4 @@ static int __batadv_interface_kill_vid(struct net_device *dev, __be16 proto,\
 
 #endif /* < KERNEL_VERSION(3, 10, 0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 11, 0)
-
-#define netdev_notifier_info_to_dev(ptr) ptr
-
-/* older kernels still need to call skb_abort_seq_read() */
-#define skb_seq_read(consumed, data, st) \
-	({ \
-		int __len = skb_seq_read(consumed, data, st); \
-		if (__len == 0) \
-			skb_abort_seq_read(st); \
-		__len; \
-	})
-#endif /* < KERNEL_VERSION(3, 11, 0) */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 14, 0)
-
-#define ether_addr_equal_unaligned(_a, _b) (memcmp(_a, _b, ETH_ALEN) == 0)
-#define ether_addr_copy(_a, _b) memcpy(_a, _b, ETH_ALEN)
-
-#endif /* < KERNEL_VERSION(3, 14, 0) */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 16, 0)
-
-#define pskb_copy_for_clone pskb_copy
-
-#endif /* < KERNEL_VERSION(3, 16, 0) */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 17, 0)
-
-#define hlist_add_behind(n, prev) hlist_add_after(prev, n)
-
-/* alloc_netdev() was defined differently before 2.6.38 */
-#undef alloc_netdev
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 38)
-#define alloc_netdev(sizeof_priv, name, name_assign_type, setup) \
-	alloc_netdev_mq(sizeof_priv, name, setup, 1)
-#else
-#define alloc_netdev(sizeof_priv, name, name_assign_type, setup) \
-	alloc_netdev_mqs(sizeof_priv, name, setup, 1, 1)
-#endif /* nested < KERNEL_VERSION(2, 6, 38) */
-
-#endif /* < KERNEL_VERSION(3, 17, 0) */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 19, 0)
-
-static inline bool seq_has_overflowed(struct seq_file *m)
-{
-	return m->count == m->size;
-}
-
-#endif /* < KERNEL_VERSION(3, 19, 0) */
-
 #endif /* _NET_BATMAN_ADV_COMPAT_H_ */
diff --git a/main.h b/main.h
index 569846b..1d5340c 100644
--- a/main.h
+++ b/main.h
@@ -182,7 +182,7 @@ enum batadv_uev_type {
 #include <linux/jiffies.h>
 #include <linux/seq_file.h>
 #include <linux/if_vlan.h>
-#include "compat.h"
+#include <linux/printk.h>
 
 #include "types.h"
 
-- 
2.1.4


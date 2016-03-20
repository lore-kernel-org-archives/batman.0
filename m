Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 20 Mar 2016 14:00:15 +0100
Message-Id: <1458478815-22693-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Drop support for Linux < 3.2
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

The Linux Kernel 2.6.32 reached its end of life [1] after over 6 years.
Instead it is recommended to use at least kernel 3.2 which is also already
over 3 years old. All older kernels (v2.6.29 - v3.1) should therefore be
dropped to reduce the support overhead.

[1] https://lkml.org/lkml/2016/3/12/78

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat-include/linux/atomic.h      | 29 ---------------
 compat-include/linux/average.h     |  2 --
 compat-include/linux/bug.h         | 51 ---------------------------
 compat-include/linux/compiler.h    | 40 ---------------------
 compat-include/linux/if_vlan.h     | 15 ++------
 compat-include/linux/kconfig.h     | 42 ----------------------
 compat-include/linux/kernel.h      | 29 ---------------
 compat-include/linux/lockdep.h     | 33 -----------------
 compat-include/linux/moduleparam.h | 72 --------------------------------------
 compat-include/linux/netdevice.h   | 57 ------------------------------
 compat-include/linux/percpu.h      | 48 -------------------------
 compat-include/linux/printk.h      | 39 ---------------------
 compat-include/linux/rculist.h     | 10 ------
 compat-include/linux/rcupdate.h    | 54 ----------------------------
 compat-include/linux/skbuff.h      | 29 ---------------
 compat.h                           | 57 ++----------------------------
 16 files changed, 5 insertions(+), 602 deletions(-)
 delete mode 100644 compat-include/linux/atomic.h
 delete mode 100644 compat-include/linux/bug.h
 delete mode 100644 compat-include/linux/compiler.h
 delete mode 100644 compat-include/linux/kconfig.h
 delete mode 100644 compat-include/linux/lockdep.h
 delete mode 100644 compat-include/linux/moduleparam.h
 delete mode 100644 compat-include/linux/percpu.h
 delete mode 100644 compat-include/linux/printk.h
 delete mode 100644 compat-include/linux/rcupdate.h

diff --git a/compat-include/linux/atomic.h b/compat-include/linux/atomic.h
deleted file mode 100644
index fe540f9..0000000
--- a/compat-include/linux/atomic.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
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
-#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_ATOMIC_H_
-#define _NET_BATMAN_ADV_COMPAT_LINUX_ATOMIC_H_
-
-#include <linux/version.h>
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 37)
-#include_next <linux/atomic.h>
-#endif
-
-#endif /* _NET_BATMAN_ADV_COMPAT_LINUX_ATOMIC_H_ */
diff --git a/compat-include/linux/average.h b/compat-include/linux/average.h
index 631df9b..3ce9bd7 100644
--- a/compat-include/linux/average.h
+++ b/compat-include/linux/average.h
@@ -22,9 +22,7 @@
 #define _NET_BATMAN_ADV_COMPAT_LINUX_AVERAGE_H
 
 #include <linux/version.h>
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 38)
 #include_next <linux/average.h>
-#endif
 
 #include <linux/bug.h>
 
diff --git a/compat-include/linux/bug.h b/compat-include/linux/bug.h
deleted file mode 100644
index 0c46158..0000000
--- a/compat-include/linux/bug.h
+++ /dev/null
@@ -1,51 +0,0 @@
-/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
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
-#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_BUG_H_
-#define _NET_BATMAN_ADV_COMPAT_LINUX_BUG_H_
-
-#include <linux/version.h>
-#include_next <linux/bug.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 33)
-
-#undef BUILD_BUG_ON_NOT_POWER_OF_2
-#ifdef __CHECKER__
-#define BUILD_BUG_ON_NOT_POWER_OF_2(n) (0)
-#else
-/* Force a compilation error if a constant expression is not a power of 2 */
-#define BUILD_BUG_ON_NOT_POWER_OF_2(n) \
-	BUILD_BUG_ON((n) == 0 || (((n) & ((n) - 1)) != 0))
-#endif
-
-#endif /* < KERNEL_VERSION(2, 6, 33) */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 0, 0)
-
-#undef BUILD_BUG_ON
-#ifdef __CHECKER__
-#define BUILD_BUG_ON(condition) (0)
-#else /* __CHECKER__ */
-#define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2 * !!(condition)]))
-#endif /* __CHECKER__ */
-
-#endif /* < KERNEL_VERSION(3, 0, 0) */
-
-#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_BUG_H_ */
diff --git a/compat-include/linux/compiler.h b/compat-include/linux/compiler.h
deleted file mode 100644
index 7477dcc..0000000
--- a/compat-include/linux/compiler.h
+++ /dev/null
@@ -1,40 +0,0 @@
-/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
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
-#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_COMPILER_H_
-#define _NET_BATMAN_ADV_COMPAT_LINUX_COMPILER_H_
-
-#include <linux/version.h>
-#include_next <linux/compiler.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 33)
-
-#define __always_unused			__attribute__((unused))
-#define __percpu
-
-#endif /* < KERNEL_VERSION(2, 6, 33) */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 36)
-
-#define __rcu
-
-#endif /* < KERNEL_VERSION(2, 6, 36) */
-
-#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_COMPILER_H_ */
diff --git a/compat-include/linux/if_vlan.h b/compat-include/linux/if_vlan.h
index 9423c70..4988597 100644
--- a/compat-include/linux/if_vlan.h
+++ b/compat-include/linux/if_vlan.h
@@ -24,21 +24,10 @@
 #include <linux/version.h>
 #include_next <linux/if_vlan.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 33)
-
-#define VLAN_PRIO_MASK          0xe000 /* Priority Code Point */
-#define VLAN_PRIO_SHIFT         13
-
-#endif /* < KERNEL_VERSION(2, 6, 33) */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 0, 0)
-
-#define vlan_insert_tag(skb, proto, vid) __vlan_put_tag(skb, vid)
-
-#elif LINUX_VERSION_CODE < KERNEL_VERSION(3, 10, 0)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 10, 0)
 
 #define vlan_insert_tag(skb, proto, vid) vlan_insert_tag(skb, vid)
 
-#endif /* < KERNEL_VERSION(3, 0, 0) */
+#endif /* < KERNEL_VERSION(3, 10, 0) */
 
 #endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_IF_VLAN_H_ */
diff --git a/compat-include/linux/kconfig.h b/compat-include/linux/kconfig.h
deleted file mode 100644
index d762f5a..0000000
--- a/compat-include/linux/kconfig.h
+++ /dev/null
@@ -1,42 +0,0 @@
-/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
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
-#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_KCONFIG_H_
-#define _NET_BATMAN_ADV_COMPAT_LINUX_KCONFIG_H_
-
-#include <linux/version.h>
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 1, 0)
-#include_next <linux/kconfig.h>
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 1, 0)
-
-#define __ARG_PLACEHOLDER_1 0,
-#define config_enabled(cfg) _config_enabled(cfg)
-#define _config_enabled(value) __config_enabled(__ARG_PLACEHOLDER_##value)
-#define __config_enabled(arg1_or_junk) ___config_enabled(arg1_or_junk 1, 0)
-#define ___config_enabled(__ignored, val, ...) val
-
-#define IS_ENABLED(option) \
-	(config_enabled(option) || config_enabled(option##_MODULE))
-
-#endif /* < KERNEL_VERSION(3, 1, 0) */
-
-#endif /* _NET_BATMAN_ADV_COMPAT_LINUX_KCONFIG_H_ */
diff --git a/compat-include/linux/kernel.h b/compat-include/linux/kernel.h
index 9e7fb10..763e383 100644
--- a/compat-include/linux/kernel.h
+++ b/compat-include/linux/kernel.h
@@ -24,35 +24,6 @@
 #include <linux/version.h>
 #include_next <linux/kernel.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 39)
-
-#define kstrtou32(cp, base, v)\
-({\
-	unsigned long _v;\
-	int _r;\
-	_r = strict_strtoul(cp, base, &_v);\
-	*(v) = (u32)_v;\
-	if ((unsigned long)*(v) != _v)\
-		_r = -ERANGE;\
-	_r;\
-})
-
-#define kstrtou64(cp, base, v)\
-({\
-	unsigned long long _v;\
-	int _r;\
-	_r = strict_strtoull(cp, base, &_v);\
-	*(v) = (uint64_t)_v;\
-	if ((unsigned long long)*(v) != _v)\
-		_r = -ERANGE;\
-	_r;\
-})
-
-#define kstrtoul strict_strtoul
-#define kstrtol  strict_strtol
-
-#endif /* < KERNEL_VERSION(2, 6, 39) */
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 14, 0)
 
 #define U8_MAX		((u8)~0U)
diff --git a/compat-include/linux/lockdep.h b/compat-include/linux/lockdep.h
deleted file mode 100644
index 0445083..0000000
--- a/compat-include/linux/lockdep.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
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
-#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_LOCKDEP_H_
-#define _NET_BATMAN_ADV_COMPAT_LINUX_LOCKDEP_H_
-
-#include <linux/version.h>
-#include_next <linux/lockdep.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 32)
-
-#define lockdep_assert_held(l)	do { (void)(l); } while (0)
-
-#endif /* < KERNEL_VERSION(2, 6, 32) */
-
-#endif /* _NET_BATMAN_ADV_COMPAT_LINUX_LOCKDEP_H_ */
diff --git a/compat-include/linux/moduleparam.h b/compat-include/linux/moduleparam.h
deleted file mode 100644
index b40abc6..0000000
--- a/compat-include/linux/moduleparam.h
+++ /dev/null
@@ -1,72 +0,0 @@
-/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
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
-#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_MODULEPARAM_H_
-#define _NET_BATMAN_ADV_COMPAT_LINUX_MODULEPARAM_H_
-
-#include <linux/version.h>
-#include_next <linux/moduleparam.h>
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
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 36)
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
-
-#define param_set_copystring batadv_param_set_copystring
-
-#endif /* < KERNEL_VERSION(2, 6, 36) */
-
-#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_MODULEPARAM_H_ */
diff --git a/compat-include/linux/netdevice.h b/compat-include/linux/netdevice.h
index 9ff91b5..f47f5c3 100644
--- a/compat-include/linux/netdevice.h
+++ b/compat-include/linux/netdevice.h
@@ -30,58 +30,6 @@
 
 #endif /* < KERNEL_VERSION(3, 3, 0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 33)
-
-#define unregister_netdevice_queue(dev, head) unregister_netdevice(dev)
-
-#endif /* < KERNEL_VERSION(2, 6, 33) */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 35)
-
-#include <linux/etherdevice.h>
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
-#define NETDEV_PRE_TYPE_CHANGE	0x000E
-#define NETDEV_POST_TYPE_CHANGE	0x000F
-
-#endif /* < KERNEL_VERSION(2, 6, 35) */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 36)
-
-#define NET_ADDR_RANDOM 0
-
-#endif /* < KERNEL_VERSION(2, 6, 36) */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 39)
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
-#endif /* < KERNEL_VERSION(2, 6, 39) */
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 9, 0)
 
 #define netdev_upper_dev_unlink(slave, master) netdev_set_master(slave, NULL)
@@ -103,13 +51,8 @@ static inline int batadv_netdev_set_master(struct net_device *slave,
 
 /* alloc_netdev() was defined differently before 2.6.38 */
 #undef alloc_netdev
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 38)
-#define alloc_netdev(sizeof_priv, name, name_assign_type, setup) \
-	alloc_netdev_mq(sizeof_priv, name, setup, 1)
-#else
 #define alloc_netdev(sizeof_priv, name, name_assign_type, setup) \
 	alloc_netdev_mqs(sizeof_priv, name, setup, 1, 1)
-#endif /* nested < KERNEL_VERSION(2, 6, 38) */
 
 #endif /* < KERNEL_VERSION(3, 17, 0) */
 
diff --git a/compat-include/linux/percpu.h b/compat-include/linux/percpu.h
deleted file mode 100644
index c37b423..0000000
--- a/compat-include/linux/percpu.h
+++ /dev/null
@@ -1,48 +0,0 @@
-/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
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
-#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_PERCPU_H_
-#define _NET_BATMAN_ADV_COMPAT_LINUX_PERCPU_H_
-
-#include <linux/version.h>
-#include_next <linux/percpu.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 30)
-
-#undef __alloc_percpu
-#define __alloc_percpu(size, align) \
-	percpu_alloc_mask((size), GFP_KERNEL, cpu_possible_map)
-
-#endif /* < KERNEL_VERSION(2, 6, 30) */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 33)
-
-#define this_cpu_add(x, c)	batadv_this_cpu_add(&(x), c)
-
-static inline void batadv_this_cpu_add(u64 *count_ptr, size_t count)
-{
-	int cpu = get_cpu();
-	*per_cpu_ptr(count_ptr, cpu) += count;
-	put_cpu();
-}
-
-#endif /* < KERNEL_VERSION(2, 6, 33) */
-
-#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_PERCPU_H_ */
diff --git a/compat-include/linux/printk.h b/compat-include/linux/printk.h
deleted file mode 100644
index ecf4289..0000000
--- a/compat-include/linux/printk.h
+++ /dev/null
@@ -1,39 +0,0 @@
-/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
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
-#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_PRINTK_H_
-#define _NET_BATMAN_ADV_COMPAT_LINUX_PRINTK_H_
-
-#include <linux/version.h>
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 37)
-#include_next <linux/printk.h>
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 35)
-
-#define pr_warn pr_warning
-
-#endif
-
-#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_PRINTK_H_ */
-
-#ifndef pr_fmt
-#define pr_fmt(fmt) fmt
-#endif
diff --git a/compat-include/linux/rculist.h b/compat-include/linux/rculist.h
index ca17506..d432bc6 100644
--- a/compat-include/linux/rculist.h
+++ b/compat-include/linux/rculist.h
@@ -24,16 +24,6 @@
 #include <linux/version.h>
 #include_next <linux/rculist.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 37)
-
-#define hlist_first_rcu(head) \
-	(*((struct hlist_node __rcu **)(&(head)->first)))
-
-#define hlist_next_rcu(node) \
-	(*((struct hlist_node __rcu **)(&(node)->next)))
-
-#endif /* < KERNEL_VERSION(2, 6, 37) */
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 9, 0)
 
 #undef hlist_for_each_entry_rcu
diff --git a/compat-include/linux/rcupdate.h b/compat-include/linux/rcupdate.h
deleted file mode 100644
index cddf775..0000000
--- a/compat-include/linux/rcupdate.h
+++ /dev/null
@@ -1,54 +0,0 @@
-/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
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
-#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_RCUPDATE_H_
-#define _NET_BATMAN_ADV_COMPAT_LINUX_RCUPDATE_H_
-
-#include <linux/version.h>
-#include_next <linux/rcupdate.h>
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
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 0, 0)
-
-#define kfree_rcu(ptr, rcuhead_name) \
-	do { \
-		void batadv_free_rcu_##ptr(struct rcu_head *rcu) \
-		{ \
-			void *container_ptr; \
-			container_ptr = container_of(rcu, typeof(*(ptr)), rcuhead_name); \
-			kfree(container_ptr); \
-		} \
-		call_rcu(&(ptr)->rcuhead_name, batadv_free_rcu_##ptr); \
-	} while (0)
-
-#endif /* < KERNEL_VERSION(3, 0, 0) */
-
-#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_RCUPDATE_H_ */
diff --git a/compat-include/linux/skbuff.h b/compat-include/linux/skbuff.h
index 96b018c..b2cb161 100644
--- a/compat-include/linux/skbuff.h
+++ b/compat-include/linux/skbuff.h
@@ -24,35 +24,6 @@
 #include <linux/version.h>
 #include_next <linux/skbuff.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 30)
-
-#define consume_skb(_skb) kfree_skb(_skb)
-
-#endif /* < KERNEL_VERSION(2, 6, 30) */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 33)
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
-#endif /* < KERNEL_VERSION(2, 6, 33) */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 0, 0)
-
-static inline void skb_reset_mac_len(struct sk_buff *skb)
-{
-	skb->mac_len = skb->network_header - skb->mac_header;
-}
-
-#endif /* < KERNEL_VERSION(3, 0, 0) */
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 8, 0)
 
 /* hack for not correctly set mac_len. This may happen for some special
diff --git a/compat.h b/compat.h
index 454fa4c..5a5f478 100644
--- a/compat.h
+++ b/compat.h
@@ -23,31 +23,11 @@
 
 #include <linux/version.h>	/* LINUX_VERSION_CODE */
 #include <linux/kconfig.h>
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 33))
-#include <linux/autoconf.h>
-#else
 #include <generated/autoconf.h>
-#endif
-#include "compat-autoconf.h"
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 33)
-
-#define skb_iif iif
-
-#define batadv_softif_destroy_netlink(dev, head) batadv_softif_destroy_netlink(dev)
-
-#endif /* < KERNEL_VERSION(2, 6, 33) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 36)
-
-#include <linux/netdevice.h>
-
-#define netdev_master_upper_dev_get_rcu(dev) \
-	(dev->br_port ? dev : NULL); \
-	break;
+#include "compat-autoconf.h"
 
-#elif LINUX_VERSION_CODE < KERNEL_VERSION(3, 9, 0)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 9, 0)
 
 #include <linux/netdevice.h>
 
@@ -55,38 +35,7 @@
 	(dev->priv_flags & IFF_BRIDGE_PORT ? dev : NULL); \
 	break;
 
-#endif /* < KERNEL_VERSION(2, 6, 36) */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 36)
-
-/* hack for dev->addr_assign_type &= ~NET_ADDR_RANDOM; */
-#define addr_assign_type ifindex
-
-#endif /* < KERNEL_VERSION(2, 6, 36) */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 39)
-
-/* Hack for removing ndo_add/del_slave at the end of net_device_ops.
- * This is somewhat ugly because it requires that ndo_validate_addr
- * is at the end of this struct in soft-interface.c.
- */
-#include <linux/netdevice.h>
-
-#define ndo_validate_addr \
-	ndo_validate_addr = eth_validate_addr, \
-}; \
-static const struct { \
-	void *ndo_validate_addr; \
-	void *ndo_add_slave; \
-	void *ndo_del_slave; \
-} __attribute__((unused)) __useless_ops1 = { \
-	.ndo_validate_addr
-
-#define ndo_del_slave          ndo_init
-#define ndo_init(x, y)         ndo_init - master->netdev_ops->ndo_init - EBUSY
-
-#endif /* < KERNEL_VERSION(2, 6, 39) */
-
+#endif /* < KERNEL_VERSION(3, 9, 0) */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 3, 0)
 
-- 
2.8.0.rc3


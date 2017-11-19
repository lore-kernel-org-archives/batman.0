Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 19 Nov 2017 15:05:14 +0100
Message-Id: <20171119140517.24329-7-sven@narfation.org>
In-Reply-To: <20171119140517.24329-1-sven@narfation.org>
References: <20171119140517.24329-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 6/9] batman-adv: Add license headers to
 compat files
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat-include/linux/if_bridge.h    | 23 +++++++++++++++++++++++
 compat-include/linux/igmp.h         | 23 +++++++++++++++++++++++
 compat-include/linux/nl80211.h      | 23 +++++++++++++++++++++++
 compat-include/net/addrconf.h       | 23 +++++++++++++++++++++++
 compat-include/net/cfg80211.h       | 23 +++++++++++++++++++++++
 compat-include/net/ip6_checksum.h   | 23 +++++++++++++++++++++++
 compat-include/net/ipv6.h           | 23 +++++++++++++++++++++++
 compat-include/uapi/linux/nl80211.h | 23 +++++++++++++++++++++++
 compat-patches/README               |  2 ++
 compat-patches/replacements.sh      | 18 ++++++++++++++++++
 compat-sources/Makefile             | 19 +++++++++++++++++++
 gen-compat-autoconf.sh              | 18 ++++++++++++++++++
 12 files changed, 241 insertions(+)

diff --git a/compat-include/linux/if_bridge.h b/compat-include/linux/if_bridge.h
index 9aae0186..72e7afb3 100644
--- a/compat-include/linux/if_bridge.h
+++ b/compat-include/linux/if_bridge.h
@@ -1,3 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
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
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ *
+ * This file contains macros for maintaining compatibility with older versions
+ * of the Linux kernel.
+ */
+
 #ifndef _NET_BATMAN_ADV_COMPAT_LINUX_IF_BRIDGE_H_
 #define _NET_BATMAN_ADV_COMPAT_LINUX_IF_BRIDGE_H_
 
diff --git a/compat-include/linux/igmp.h b/compat-include/linux/igmp.h
index f61ab79c..7ccf0939 100644
--- a/compat-include/linux/igmp.h
+++ b/compat-include/linux/igmp.h
@@ -1,3 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
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
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ *
+ * This file contains macros for maintaining compatibility with older versions
+ * of the Linux kernel.
+ */
+
 #ifndef _NET_BATMAN_ADV_COMPAT_LINUX_IGMP_H_
 #define _NET_BATMAN_ADV_COMPAT_LINUX_IGMP_H_
 
diff --git a/compat-include/linux/nl80211.h b/compat-include/linux/nl80211.h
index e6654df8..ae0b3726 100644
--- a/compat-include/linux/nl80211.h
+++ b/compat-include/linux/nl80211.h
@@ -1,3 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
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
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ *
+ * This file contains macros for maintaining compatibility with older versions
+ * of the Linux kernel.
+ */
+
 #ifndef _NET_BATMAN_ADV_COMPAT_LINUX_NL80211_H_
 #define _NET_BATMAN_ADV_COMPAT_LINUX_NL80211_H_
 
diff --git a/compat-include/net/addrconf.h b/compat-include/net/addrconf.h
index 69c45d06..9b185bbd 100644
--- a/compat-include/net/addrconf.h
+++ b/compat-include/net/addrconf.h
@@ -1,3 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
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
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ *
+ * This file contains macros for maintaining compatibility with older versions
+ * of the Linux kernel.
+ */
+
 #ifndef _NET_BATMAN_ADV_COMPAT_NET_ADDRCONF_H_
 #define _NET_BATMAN_ADV_COMPAT_NET_ADDRCONF_H_
 
diff --git a/compat-include/net/cfg80211.h b/compat-include/net/cfg80211.h
index 6e0eca3c..475635e2 100644
--- a/compat-include/net/cfg80211.h
+++ b/compat-include/net/cfg80211.h
@@ -1,3 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
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
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ *
+ * This file contains macros for maintaining compatibility with older versions
+ * of the Linux kernel.
+ */
+
 #ifndef _NET_BATMAN_ADV_COMPAT_NET_CFG80211_H_
 #define _NET_BATMAN_ADV_COMPAT_NET_CFG80211_H_
 
diff --git a/compat-include/net/ip6_checksum.h b/compat-include/net/ip6_checksum.h
index fda0c07d..09f191df 100644
--- a/compat-include/net/ip6_checksum.h
+++ b/compat-include/net/ip6_checksum.h
@@ -1,3 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
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
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ *
+ * This file contains macros for maintaining compatibility with older versions
+ * of the Linux kernel.
+ */
+
 #ifndef _NET_BATMAN_ADV_COMPAT_NET_IP6_CHECKSUM_H_
 #define _NET_BATMAN_ADV_COMPAT_NET_IP6_CHECKSUM_H_
 
diff --git a/compat-include/net/ipv6.h b/compat-include/net/ipv6.h
index 1e190d85..b4a1e18f 100644
--- a/compat-include/net/ipv6.h
+++ b/compat-include/net/ipv6.h
@@ -1,3 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
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
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ *
+ * This file contains macros for maintaining compatibility with older versions
+ * of the Linux kernel.
+ */
+
 #ifndef _NET_BATMAN_ADV_COMPAT_NET_IPV6_H_
 #define _NET_BATMAN_ADV_COMPAT_NET_IPV6_H_
 
diff --git a/compat-include/uapi/linux/nl80211.h b/compat-include/uapi/linux/nl80211.h
index 06f5625a..9b18178e 100644
--- a/compat-include/uapi/linux/nl80211.h
+++ b/compat-include/uapi/linux/nl80211.h
@@ -1,3 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
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
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ *
+ * This file contains macros for maintaining compatibility with older versions
+ * of the Linux kernel.
+ */
+
 #ifndef _NET_BATMAN_ADV_COMPAT_UAPI_LINUX_NL80211_H_
 #define _NET_BATMAN_ADV_COMPAT_UAPI_LINUX_NL80211_H_
 
diff --git a/compat-patches/README b/compat-patches/README
index 3bbddb3d..ceafb1da 100644
--- a/compat-patches/README
+++ b/compat-patches/README
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 WARNING
 =======
 
diff --git a/compat-patches/replacements.sh b/compat-patches/replacements.sh
index 7dcb953a..021261f5 100755
--- a/compat-patches/replacements.sh
+++ b/compat-patches/replacements.sh
@@ -1,4 +1,22 @@
 #! /bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
+#
+# Marek Lindner, Simon Wunderlich
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of version 2 of the GNU General Public
+# License as published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful, but
+# WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+# General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, see <http://www.gnu.org/licenses/>.
+#
+# License-Filename: LICENSES/preferred/GPL-2.0
 
 set -e
 
diff --git a/compat-sources/Makefile b/compat-sources/Makefile
index c8bae49a..5903df92 100644
--- a/compat-sources/Makefile
+++ b/compat-sources/Makefile
@@ -1,3 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
+#
+# Marek Lindner, Simon Wunderlich
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of version 2 of the GNU General Public
+# License as published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful, but
+# WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+# General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, see <http://www.gnu.org/licenses/>.
+#
+# License-Filename: LICENSES/preferred/GPL-2.0
+
 batman-adv-$(CONFIG_BATMAN_ADV_MCAST) += ../../../compat-sources/net/core/skbuff.o
 batman-adv-$(CONFIG_BATMAN_ADV_MCAST) += ../../../compat-sources/net/ipv4/igmp.o
 batman-adv-$(CONFIG_BATMAN_ADV_MCAST) += ../../../compat-sources/net/ipv6/mcast_snoop.o
diff --git a/gen-compat-autoconf.sh b/gen-compat-autoconf.sh
index cf36e558..e598655e 100755
--- a/gen-compat-autoconf.sh
+++ b/gen-compat-autoconf.sh
@@ -1,4 +1,22 @@
 #! /bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
+#
+# Marek Lindner, Simon Wunderlich
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of version 2 of the GNU General Public
+# License as published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful, but
+# WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+# General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, see <http://www.gnu.org/licenses/>.
+#
+# License-Filename: LICENSES/preferred/GPL-2.0
 
 set -e
 
-- 
2.11.0


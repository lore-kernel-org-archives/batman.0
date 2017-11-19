Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 19 Nov 2017 15:05:10 +0100
Message-Id: <20171119140517.24329-3-sven@narfation.org>
In-Reply-To: <20171119140517.24329-1-sven@narfation.org>
References: <20171119140517.24329-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/9] batman-adv: Add License-Filename to
 GPL-2.0 files
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

The FSFE REUSE practices [1] recommend to add a "License-Filename" tag to
files which don't contain the complete license text. The GPL-2.0 files
usually only have a small notice at the beginning of the file. The longer
license is usually stored in a separate file and therefore should be
referenced accordingly.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile                               | 1 +
 compat-include/linux/average.h         | 2 ++
 compat-include/linux/cache.h           | 2 ++
 compat-include/linux/etherdevice.h     | 2 ++
 compat-include/linux/ethtool.h         | 2 ++
 compat-include/linux/export.h          | 2 ++
 compat-include/linux/genetlink.h       | 2 ++
 compat-include/linux/if_ether.h        | 2 ++
 compat-include/linux/if_vlan.h         | 2 ++
 compat-include/linux/kernel.h          | 2 ++
 compat-include/linux/kref.h            | 2 ++
 compat-include/linux/list.h            | 2 ++
 compat-include/linux/net.h             | 2 ++
 compat-include/linux/netdev_features.h | 2 ++
 compat-include/linux/netdevice.h       | 2 ++
 compat-include/linux/netlink.h         | 2 ++
 compat-include/linux/random.h          | 2 ++
 compat-include/linux/rculist.h         | 2 ++
 compat-include/linux/seq_file.h        | 2 ++
 compat-include/linux/skbuff.h          | 2 ++
 compat-include/linux/slab.h            | 2 ++
 compat-include/net/genetlink.h         | 2 ++
 compat-sources/net/core/skbuff.c       | 2 ++
 compat-sources/net/ipv4/igmp.c         | 2 ++
 compat-sources/net/ipv6/mcast_snoop.c  | 2 ++
 compat.h                               | 2 ++
 net/batman-adv/Makefile                | 1 +
 net/batman-adv/bat_algo.c              | 2 ++
 net/batman-adv/bat_algo.h              | 2 ++
 net/batman-adv/bat_iv_ogm.c            | 2 ++
 net/batman-adv/bat_iv_ogm.h            | 2 ++
 net/batman-adv/bat_v.c                 | 2 ++
 net/batman-adv/bat_v.h                 | 2 ++
 net/batman-adv/bat_v_elp.c             | 2 ++
 net/batman-adv/bat_v_elp.h             | 2 ++
 net/batman-adv/bat_v_ogm.c             | 2 ++
 net/batman-adv/bat_v_ogm.h             | 2 ++
 net/batman-adv/bitarray.c              | 2 ++
 net/batman-adv/bitarray.h              | 2 ++
 net/batman-adv/bridge_loop_avoidance.c | 2 ++
 net/batman-adv/bridge_loop_avoidance.h | 2 ++
 net/batman-adv/debugfs.c               | 2 ++
 net/batman-adv/debugfs.h               | 2 ++
 net/batman-adv/distributed-arp-table.c | 2 ++
 net/batman-adv/distributed-arp-table.h | 2 ++
 net/batman-adv/fragmentation.c         | 2 ++
 net/batman-adv/fragmentation.h         | 2 ++
 net/batman-adv/gateway_client.c        | 2 ++
 net/batman-adv/gateway_client.h        | 2 ++
 net/batman-adv/gateway_common.c        | 2 ++
 net/batman-adv/gateway_common.h        | 2 ++
 net/batman-adv/hard-interface.c        | 2 ++
 net/batman-adv/hard-interface.h        | 2 ++
 net/batman-adv/hash.c                  | 2 ++
 net/batman-adv/hash.h                  | 2 ++
 net/batman-adv/icmp_socket.c           | 2 ++
 net/batman-adv/icmp_socket.h           | 2 ++
 net/batman-adv/log.c                   | 2 ++
 net/batman-adv/log.h                   | 2 ++
 net/batman-adv/main.c                  | 2 ++
 net/batman-adv/main.h                  | 2 ++
 net/batman-adv/multicast.c             | 2 ++
 net/batman-adv/multicast.h             | 2 ++
 net/batman-adv/netlink.c               | 2 ++
 net/batman-adv/netlink.h               | 2 ++
 net/batman-adv/network-coding.c        | 2 ++
 net/batman-adv/network-coding.h        | 2 ++
 net/batman-adv/originator.c            | 2 ++
 net/batman-adv/originator.h            | 2 ++
 net/batman-adv/packet.h                | 2 ++
 net/batman-adv/routing.c               | 2 ++
 net/batman-adv/routing.h               | 2 ++
 net/batman-adv/send.c                  | 2 ++
 net/batman-adv/send.h                  | 2 ++
 net/batman-adv/soft-interface.c        | 2 ++
 net/batman-adv/soft-interface.h        | 2 ++
 net/batman-adv/sysfs.c                 | 2 ++
 net/batman-adv/sysfs.h                 | 2 ++
 net/batman-adv/tp_meter.c              | 2 ++
 net/batman-adv/tp_meter.h              | 2 ++
 net/batman-adv/translation-table.c     | 2 ++
 net/batman-adv/translation-table.h     | 2 ++
 net/batman-adv/tvlv.c                  | 2 ++
 net/batman-adv/tvlv.h                  | 2 ++
 net/batman-adv/types.h                 | 2 ++
 85 files changed, 168 insertions(+)

diff --git a/Makefile b/Makefile
index 1eb6821d..e40f26a5 100644
--- a/Makefile
+++ b/Makefile
@@ -15,6 +15,7 @@
 # You should have received a copy of the GNU General Public License
 # along with this program; if not, see <http://www.gnu.org/licenses/>.
 #
+# License-Filename: LICENSES/preferred/GPL-2.0
 
 # read README.external for more information about the configuration
 # batman-adv DebugFS entries:
diff --git a/compat-include/linux/average.h b/compat-include/linux/average.h
index a1e3c254..b5a3d3d7 100644
--- a/compat-include/linux/average.h
+++ b/compat-include/linux/average.h
@@ -14,6 +14,8 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
  */
diff --git a/compat-include/linux/cache.h b/compat-include/linux/cache.h
index dc2d43cc..11ba7c6b 100644
--- a/compat-include/linux/cache.h
+++ b/compat-include/linux/cache.h
@@ -14,6 +14,8 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
  */
diff --git a/compat-include/linux/etherdevice.h b/compat-include/linux/etherdevice.h
index 45a079bd..58bab019 100644
--- a/compat-include/linux/etherdevice.h
+++ b/compat-include/linux/etherdevice.h
@@ -14,6 +14,8 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
  */
diff --git a/compat-include/linux/ethtool.h b/compat-include/linux/ethtool.h
index 05aee4df..b802e9ca 100644
--- a/compat-include/linux/ethtool.h
+++ b/compat-include/linux/ethtool.h
@@ -14,6 +14,8 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
  */
diff --git a/compat-include/linux/export.h b/compat-include/linux/export.h
index 59fa08f8..e786e1c8 100644
--- a/compat-include/linux/export.h
+++ b/compat-include/linux/export.h
@@ -14,6 +14,8 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
  */
diff --git a/compat-include/linux/genetlink.h b/compat-include/linux/genetlink.h
index 4d2eb8a1..90e8414f 100644
--- a/compat-include/linux/genetlink.h
+++ b/compat-include/linux/genetlink.h
@@ -14,6 +14,8 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
  */
diff --git a/compat-include/linux/if_ether.h b/compat-include/linux/if_ether.h
index a4064b64..3c2532c6 100644
--- a/compat-include/linux/if_ether.h
+++ b/compat-include/linux/if_ether.h
@@ -14,6 +14,8 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
  */
diff --git a/compat-include/linux/if_vlan.h b/compat-include/linux/if_vlan.h
index 255886c3..3114e67c 100644
--- a/compat-include/linux/if_vlan.h
+++ b/compat-include/linux/if_vlan.h
@@ -14,6 +14,8 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
  */
diff --git a/compat-include/linux/kernel.h b/compat-include/linux/kernel.h
index 4cbc51dc..c6cf8773 100644
--- a/compat-include/linux/kernel.h
+++ b/compat-include/linux/kernel.h
@@ -14,6 +14,8 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
  */
diff --git a/compat-include/linux/kref.h b/compat-include/linux/kref.h
index a30657ca..f92ae695 100644
--- a/compat-include/linux/kref.h
+++ b/compat-include/linux/kref.h
@@ -14,6 +14,8 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
  */
diff --git a/compat-include/linux/list.h b/compat-include/linux/list.h
index 1053a4d1..ea071bf8 100644
--- a/compat-include/linux/list.h
+++ b/compat-include/linux/list.h
@@ -14,6 +14,8 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
  */
diff --git a/compat-include/linux/net.h b/compat-include/linux/net.h
index 0747eda6..e5636601 100644
--- a/compat-include/linux/net.h
+++ b/compat-include/linux/net.h
@@ -14,6 +14,8 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
  */
diff --git a/compat-include/linux/netdev_features.h b/compat-include/linux/netdev_features.h
index aafba75b..ce85956f 100644
--- a/compat-include/linux/netdev_features.h
+++ b/compat-include/linux/netdev_features.h
@@ -14,6 +14,8 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
  */
diff --git a/compat-include/linux/netdevice.h b/compat-include/linux/netdevice.h
index c29d6d21..6bbf8d8b 100644
--- a/compat-include/linux/netdevice.h
+++ b/compat-include/linux/netdevice.h
@@ -14,6 +14,8 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
  */
diff --git a/compat-include/linux/netlink.h b/compat-include/linux/netlink.h
index 085078ca..cbc5577d 100644
--- a/compat-include/linux/netlink.h
+++ b/compat-include/linux/netlink.h
@@ -14,6 +14,8 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
  */
diff --git a/compat-include/linux/random.h b/compat-include/linux/random.h
index c5eae964..19d445e6 100644
--- a/compat-include/linux/random.h
+++ b/compat-include/linux/random.h
@@ -14,6 +14,8 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
  */
diff --git a/compat-include/linux/rculist.h b/compat-include/linux/rculist.h
index 47ac3c64..0f3eec38 100644
--- a/compat-include/linux/rculist.h
+++ b/compat-include/linux/rculist.h
@@ -14,6 +14,8 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
  */
diff --git a/compat-include/linux/seq_file.h b/compat-include/linux/seq_file.h
index 3e8dbb47..6a70f0b6 100644
--- a/compat-include/linux/seq_file.h
+++ b/compat-include/linux/seq_file.h
@@ -14,6 +14,8 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
  */
diff --git a/compat-include/linux/skbuff.h b/compat-include/linux/skbuff.h
index 03765c62..f60247bd 100644
--- a/compat-include/linux/skbuff.h
+++ b/compat-include/linux/skbuff.h
@@ -14,6 +14,8 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
  */
diff --git a/compat-include/linux/slab.h b/compat-include/linux/slab.h
index 3dc1b916..3afd0330 100644
--- a/compat-include/linux/slab.h
+++ b/compat-include/linux/slab.h
@@ -14,6 +14,8 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
  */
diff --git a/compat-include/net/genetlink.h b/compat-include/net/genetlink.h
index 100fa870..66bec7aa 100644
--- a/compat-include/net/genetlink.h
+++ b/compat-include/net/genetlink.h
@@ -14,6 +14,8 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
  */
diff --git a/compat-sources/net/core/skbuff.c b/compat-sources/net/core/skbuff.c
index 40c9e8b9..a130b0ee 100644
--- a/compat-sources/net/core/skbuff.c
+++ b/compat-sources/net/core/skbuff.c
@@ -30,6 +30,8 @@
  *	modify it under the terms of the GNU General Public License
  *	as published by the Free Software Foundation; either version
  *	2 of the License, or (at your option) any later version.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include <linux/in6.h>
diff --git a/compat-sources/net/ipv4/igmp.c b/compat-sources/net/ipv4/igmp.c
index 457a05ea..e8439a03 100644
--- a/compat-sources/net/ipv4/igmp.c
+++ b/compat-sources/net/ipv4/igmp.c
@@ -68,6 +68,8 @@
  *		Alexey Kuznetsov:	Accordance to igmp-v2-06 draft.
  *		David L Stevens:	IGMPv3 support, with help from
  *					Vinay Kulkarni
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include <linux/igmp.h>
diff --git a/compat-sources/net/ipv6/mcast_snoop.c b/compat-sources/net/ipv6/mcast_snoop.c
index 3f46ed30..fca0bbfa 100644
--- a/compat-sources/net/ipv6/mcast_snoop.c
+++ b/compat-sources/net/ipv6/mcast_snoop.c
@@ -13,6 +13,8 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ *
  *
  * Based on the MLD support added to br_multicast.c by YOSHIFUJI Hideaki.
  */
diff --git a/compat.h b/compat.h
index c10ad589..8acfc724 100644
--- a/compat.h
+++ b/compat.h
@@ -14,6 +14,8 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
  */
diff --git a/net/batman-adv/Makefile b/net/batman-adv/Makefile
index 915987bc..f70dbd8a 100644
--- a/net/batman-adv/Makefile
+++ b/net/batman-adv/Makefile
@@ -15,6 +15,7 @@
 # You should have received a copy of the GNU General Public License
 # along with this program; if not, see <http://www.gnu.org/licenses/>.
 #
+# License-Filename: LICENSES/preferred/GPL-2.0
 
 obj-$(CONFIG_BATMAN_ADV) += batman-adv.o
 batman-adv-y += bat_algo.o
diff --git a/net/batman-adv/bat_algo.c b/net/batman-adv/bat_algo.c
index 44fd073b..921700ab 100644
--- a/net/batman-adv/bat_algo.c
+++ b/net/batman-adv/bat_algo.c
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include "main.h"
diff --git a/net/batman-adv/bat_algo.h b/net/batman-adv/bat_algo.h
index 29f6312f..78836cf3 100644
--- a/net/batman-adv/bat_algo.h
+++ b/net/batman-adv/bat_algo.h
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _NET_BATMAN_ADV_BAT_ALGO_H_
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 1b659ab6..96bc5d46 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include "bat_iv_ogm.h"
diff --git a/net/batman-adv/bat_iv_ogm.h b/net/batman-adv/bat_iv_ogm.h
index ae2ab526..62e5ff65 100644
--- a/net/batman-adv/bat_iv_ogm.h
+++ b/net/batman-adv/bat_iv_ogm.h
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _BATMAN_ADV_BATADV_IV_OGM_H_
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 341ceab8..91c4b64f 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include "bat_v.h"
diff --git a/net/batman-adv/bat_v.h b/net/batman-adv/bat_v.h
index dd7c4b64..eb14b048 100644
--- a/net/batman-adv/bat_v.h
+++ b/net/batman-adv/bat_v.h
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _NET_BATMAN_ADV_BAT_V_H_
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 1de992c5..ab10da9a 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include "bat_v_elp.h"
diff --git a/net/batman-adv/bat_v_elp.h b/net/batman-adv/bat_v_elp.h
index 376ead28..6edab11e 100644
--- a/net/batman-adv/bat_v_elp.h
+++ b/net/batman-adv/bat_v_elp.h
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _NET_BATMAN_ADV_BAT_V_ELP_H_
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index c251445a..f63a6f82 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include "bat_v_ogm.h"
diff --git a/net/batman-adv/bat_v_ogm.h b/net/batman-adv/bat_v_ogm.h
index 2068770b..31e37733 100644
--- a/net/batman-adv/bat_v_ogm.h
+++ b/net/batman-adv/bat_v_ogm.h
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _BATMAN_ADV_BATADV_V_OGM_H_
diff --git a/net/batman-adv/bitarray.c b/net/batman-adv/bitarray.c
index 2b070c7e..260059b0 100644
--- a/net/batman-adv/bitarray.c
+++ b/net/batman-adv/bitarray.c
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include "bitarray.h"
diff --git a/net/batman-adv/bitarray.h b/net/batman-adv/bitarray.h
index cc262c9d..4a36989a 100644
--- a/net/batman-adv/bitarray.h
+++ b/net/batman-adv/bitarray.h
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _NET_BATMAN_ADV_BITARRAY_H_
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index cdd8e8e4..fd91fd67 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include "bridge_loop_avoidance.h"
diff --git a/net/batman-adv/bridge_loop_avoidance.h b/net/batman-adv/bridge_loop_avoidance.h
index 23477574..67e5d0cb 100644
--- a/net/batman-adv/bridge_loop_avoidance.h
+++ b/net/batman-adv/bridge_loop_avoidance.h
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _NET_BATMAN_ADV_BLA_H_
diff --git a/net/batman-adv/debugfs.c b/net/batman-adv/debugfs.c
index e32ad47c..563f2614 100644
--- a/net/batman-adv/debugfs.c
+++ b/net/batman-adv/debugfs.c
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include "debugfs.h"
diff --git a/net/batman-adv/debugfs.h b/net/batman-adv/debugfs.h
index 9c5d4a65..555f62a0 100644
--- a/net/batman-adv/debugfs.h
+++ b/net/batman-adv/debugfs.h
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _NET_BATMAN_ADV_DEBUGFS_H_
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 760c0de7..8590e7bf 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include "distributed-arp-table.h"
diff --git a/net/batman-adv/distributed-arp-table.h b/net/batman-adv/distributed-arp-table.h
index ec364a3c..1e5a8f76 100644
--- a/net/batman-adv/distributed-arp-table.h
+++ b/net/batman-adv/distributed-arp-table.h
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _NET_BATMAN_ADV_DISTRIBUTED_ARP_TABLE_H_
diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index a98cf110..72ba5689 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include "fragmentation.h"
diff --git a/net/batman-adv/fragmentation.h b/net/batman-adv/fragmentation.h
index 1a2d6c30..dd9b28f2 100644
--- a/net/batman-adv/fragmentation.h
+++ b/net/batman-adv/fragmentation.h
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _NET_BATMAN_ADV_FRAGMENTATION_H_
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 10d521f0..974cee04 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include "gateway_client.h"
diff --git a/net/batman-adv/gateway_client.h b/net/batman-adv/gateway_client.h
index 3baa3d46..5d3e4e5c 100644
--- a/net/batman-adv/gateway_client.h
+++ b/net/batman-adv/gateway_client.h
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _NET_BATMAN_ADV_GATEWAY_CLIENT_H_
diff --git a/net/batman-adv/gateway_common.c b/net/batman-adv/gateway_common.c
index 2c26039c..b08b8e48 100644
--- a/net/batman-adv/gateway_common.c
+++ b/net/batman-adv/gateway_common.c
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include "gateway_common.h"
diff --git a/net/batman-adv/gateway_common.h b/net/batman-adv/gateway_common.h
index 0a6a97d2..3f6d9c9c 100644
--- a/net/batman-adv/gateway_common.h
+++ b/net/batman-adv/gateway_common.h
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _NET_BATMAN_ADV_GATEWAY_COMMON_H_
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 4e3d5340..cd5e8e57 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include "hard-interface.h"
diff --git a/net/batman-adv/hard-interface.h b/net/batman-adv/hard-interface.h
index 9f9890ff..c56c4e60 100644
--- a/net/batman-adv/hard-interface.h
+++ b/net/batman-adv/hard-interface.h
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _NET_BATMAN_ADV_HARD_INTERFACE_H_
diff --git a/net/batman-adv/hash.c b/net/batman-adv/hash.c
index b5f7e139..d7833f7f 100644
--- a/net/batman-adv/hash.c
+++ b/net/batman-adv/hash.c
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include "hash.h"
diff --git a/net/batman-adv/hash.h b/net/batman-adv/hash.h
index 0c905e91..ffde3e61 100644
--- a/net/batman-adv/hash.h
+++ b/net/batman-adv/hash.h
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _NET_BATMAN_ADV_HASH_H_
diff --git a/net/batman-adv/icmp_socket.c b/net/batman-adv/icmp_socket.c
index bded3112..d46b7fd0 100644
--- a/net/batman-adv/icmp_socket.c
+++ b/net/batman-adv/icmp_socket.c
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include "icmp_socket.h"
diff --git a/net/batman-adv/icmp_socket.h b/net/batman-adv/icmp_socket.h
index f3fec40a..41531641 100644
--- a/net/batman-adv/icmp_socket.h
+++ b/net/batman-adv/icmp_socket.h
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _NET_BATMAN_ADV_ICMP_SOCKET_H_
diff --git a/net/batman-adv/log.c b/net/batman-adv/log.c
index 4ef4bde2..c2e541fd 100644
--- a/net/batman-adv/log.c
+++ b/net/batman-adv/log.c
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include "log.h"
diff --git a/net/batman-adv/log.h b/net/batman-adv/log.h
index 65ce97ef..7b251b45 100644
--- a/net/batman-adv/log.h
+++ b/net/batman-adv/log.h
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _NET_BATMAN_ADV_LOG_H_
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 4daed7ad..d6d0bbe6 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include "main.h"
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index edb2f239..bc518dca 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _NET_BATMAN_ADV_MAIN_H_
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index e553a877..bbd6013f 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include "multicast.h"
diff --git a/net/batman-adv/multicast.h b/net/batman-adv/multicast.h
index 2a78cdda..026dc285 100644
--- a/net/batman-adv/multicast.h
+++ b/net/batman-adv/multicast.h
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _NET_BATMAN_ADV_MULTICAST_H_
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index ab13b4d5..5d588b7b 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include "netlink.h"
diff --git a/net/batman-adv/netlink.h b/net/batman-adv/netlink.h
index f1cd8c5d..f6f33e02 100644
--- a/net/batman-adv/netlink.h
+++ b/net/batman-adv/netlink.h
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _NET_BATMAN_ADV_NETLINK_H_
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 3604d789..ba41be15 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include "network-coding.h"
diff --git a/net/batman-adv/network-coding.h b/net/batman-adv/network-coding.h
index c66efb81..b78dcbaa 100644
--- a/net/batman-adv/network-coding.h
+++ b/net/batman-adv/network-coding.h
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _NET_BATMAN_ADV_NETWORK_CODING_H_
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 2967b86c..889263ce 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include "originator.h"
diff --git a/net/batman-adv/originator.h b/net/batman-adv/originator.h
index d94220a6..9b0c6f5a 100644
--- a/net/batman-adv/originator.h
+++ b/net/batman-adv/originator.h
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _NET_BATMAN_ADV_ORIGINATOR_H_
diff --git a/net/batman-adv/packet.h b/net/batman-adv/packet.h
index 8e8a5db1..f1fd0311 100644
--- a/net/batman-adv/packet.h
+++ b/net/batman-adv/packet.h
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _NET_BATMAN_ADV_PACKET_H_
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 40d9bf3e..1d27e798 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include "routing.h"
diff --git a/net/batman-adv/routing.h b/net/batman-adv/routing.h
index 5ede16c3..0a24d83e 100644
--- a/net/batman-adv/routing.h
+++ b/net/batman-adv/routing.h
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _NET_BATMAN_ADV_ROUTING_H_
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 7895323f..cc235db8 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include "send.h"
diff --git a/net/batman-adv/send.h b/net/batman-adv/send.h
index a16b34f4..5e3c1428 100644
--- a/net/batman-adv/send.h
+++ b/net/batman-adv/send.h
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _NET_BATMAN_ADV_SEND_H_
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 9f673cdf..7384de4f 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include "soft-interface.h"
diff --git a/net/batman-adv/soft-interface.h b/net/batman-adv/soft-interface.h
index 639c3abb..85708f95 100644
--- a/net/batman-adv/soft-interface.h
+++ b/net/batman-adv/soft-interface.h
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _NET_BATMAN_ADV_SOFT_INTERFACE_H_
diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index aa187fd4..2e11d6d5 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include "sysfs.h"
diff --git a/net/batman-adv/sysfs.h b/net/batman-adv/sysfs.h
index e487412e..35a6f8fa 100644
--- a/net/batman-adv/sysfs.h
+++ b/net/batman-adv/sysfs.h
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _NET_BATMAN_ADV_SYSFS_H_
diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 4b90033f..b6c9ea0c 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include "tp_meter.h"
diff --git a/net/batman-adv/tp_meter.h b/net/batman-adv/tp_meter.h
index a8ada5c1..f4fc6f31 100644
--- a/net/batman-adv/tp_meter.h
+++ b/net/batman-adv/tp_meter.h
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _NET_BATMAN_ADV_TP_METER_H_
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 8a3ce79b..98d688a4 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include "translation-table.h"
diff --git a/net/batman-adv/translation-table.h b/net/batman-adv/translation-table.h
index 411d5861..2b4ffd9e 100644
--- a/net/batman-adv/translation-table.h
+++ b/net/batman-adv/translation-table.h
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _NET_BATMAN_ADV_TRANSLATION_TABLE_H_
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index 1d9e267c..a310341d 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include "main.h"
diff --git a/net/batman-adv/tvlv.h b/net/batman-adv/tvlv.h
index 4d01400a..314c77ec 100644
--- a/net/batman-adv/tvlv.h
+++ b/net/batman-adv/tvlv.h
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _NET_BATMAN_ADV_TVLV_H_
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index a6279586..e2d1d1f1 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _NET_BATMAN_ADV_TYPES_H_
-- 
2.11.0


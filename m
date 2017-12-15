Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 15 Dec 2017 12:43:03 +0100
Message-Id: <20171215114320.13645-4-sw@simonwunderlich.de>
In-Reply-To: <20171215114320.13645-1-sw@simonwunderlich.de>
References: <20171215114320.13645-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 03/20] batman-adv: Add License-Filename to
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

The FSFE REUSE practices [1] recommend to add a "License-Filename" tag to
files which don't contain the complete license text. The GPL-2.0 files
usually only have a small notice at the beginning of the file. The longer
license is usually stored in a separate file and therefore should be
referenced accordingly.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
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
 59 files changed, 117 insertions(+)

diff --git a/net/batman-adv/Makefile b/net/batman-adv/Makefile
index 915987bc6d29..f70dbd8a2935 100644
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
index 44fd073b7546..921700ab306d 100644
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
index 29f6312f9bf1..78836cf312d4 100644
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
index 1b659ab652fb..96bc5d46548f 100644
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
index ae2ab526bdb1..62e5ff655bad 100644
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
index 341ceab8338d..91c4b64f0c09 100644
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
index dd7c4b647e6b..eb14b0483d44 100644
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
index 1de992c58b35..ab10da9a8df0 100644
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
index 376ead280ab9..6edab11efd2a 100644
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
index c251445a42a0..f63a6f8204f8 100644
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
index 2068770b542d..31e37733c547 100644
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
index 2b070c7e31da..260059b03276 100644
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
index cc262c9d97e0..4a36989a4842 100644
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
index cdd8e8e4df0b..fd91fd673ec8 100644
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
index 234775748b8e..67e5d0cb74d1 100644
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
index e32ad47c6efd..563f2614a3f3 100644
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
index 9c5d4a65b98c..555f62a0efb7 100644
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
index 760c0de72582..8590e7bfa5d9 100644
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
index ec364a3c1c66..1e5a8f769bdf 100644
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
index a98cf1104a30..72ba568991ee 100644
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
index 1a2d6c308745..dd9b28f2ce60 100644
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
index 10d521f0b17f..974cee04bfdf 100644
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
index 3baa3d466e5e..5d3e4e5c14e9 100644
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
index 2c26039c23fc..b08b8e48992c 100644
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
index 0a6a97d201f2..3f6d9c9c1647 100644
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
index 4e3d5340ad96..cd5e8e572199 100644
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
index 9f9890ff7a22..c56c4e603229 100644
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
index b5f7e13918ac..d7833f7fbce4 100644
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
index 0c905e91c5e2..ffde3e613d35 100644
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
index bded31121d12..d46b7fd0b9bb 100644
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
index f3fec40aae86..415316419d98 100644
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
index 4ef4bde2cc2d..c2e541fdc7c2 100644
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
index 65ce97efa6b5..7b251b450533 100644
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
index 4daed7ad46f2..d6d0bbe66b54 100644
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
index bb8003cf2296..d8ee90fe549a 100644
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
index e553a8770a89..bbd6013fca64 100644
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
index 2a78cddab0e9..026dc28592d5 100644
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
index ab13b4d58733..5d588b7b0136 100644
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
index f1cd8c5da966..f6f33e02a165 100644
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
index 3604d7899e2c..ba41be15d0fc 100644
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
index c66efb81d2f4..b78dcbaaea86 100644
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
index 0a565d0422bb..de6d05cd1a7e 100644
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
index 40c7f039d5d7..eae221ee7de4 100644
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
index 8e8a5db197cb..f1fd03116f75 100644
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
index 40d9bf3e5bfe..1d27e798fb77 100644
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
index 5ede16c32f15..0a24d83e42e9 100644
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
index 7895323fd2a7..cc235db866a0 100644
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
index a16b34f473ef..5e3c142821f0 100644
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
index 9f673cdfecf8..7384de4fa8bf 100644
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
index 639c3abb214a..85708f957d00 100644
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
index aa187fd42475..2e11d6d5dd74 100644
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
index e487412e256b..35a6f8fae5df 100644
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
index 15cd2139381e..4095bf6d5e6c 100644
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
index a8ada5c123bd..f4fc6f312fc1 100644
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
index 8a3ce79b1307..98d688a4dcfa 100644
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
index 411d586191da..2b4ffd9ea981 100644
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
index 1d9e267caec9..a310341d9b8f 100644
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
index 4d01400ada30..314c77ec212e 100644
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
index a62795868794..e2d1d1f13ffb 100644
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


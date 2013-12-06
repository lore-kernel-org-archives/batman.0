Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Fri,  6 Dec 2013 18:56:52 +0100
Message-Id: <1386352612-2776-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv fix FSF address
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

Jeff Kirsher is patching most of the networking
modules to accommodate this new policy for what concern the
FSF address in the GPL license. However he is using a
slightly different version than what we did.

Since his changes have already been applied, fix our text
to match what he proposed.

Introduced by c2a8e168c0ae7d23803ff6a09d25a28dfaa57d58
("batman-adv: remove FSF address from GPL disclaimer")

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 Makefile                | 3 +++
 Makefile.kbuild         | 3 +++
 bat_algo.h              | 3 +++
 bat_iv_ogm.c            | 3 +++
 bitarray.c              | 3 +++
 bitarray.h              | 3 +++
 bridge_loop_avoidance.c | 3 +++
 bridge_loop_avoidance.h | 3 +++
 compat.c                | 2 ++
 compat.h                | 2 ++
 debugfs.c               | 3 +++
 debugfs.h               | 3 +++
 distributed-arp-table.c | 3 +++
 distributed-arp-table.h | 3 +++
 fragmentation.c         | 3 +++
 fragmentation.h         | 3 +++
 gateway_client.c        | 3 +++
 gateway_client.h        | 3 +++
 gateway_common.c        | 3 +++
 gateway_common.h        | 3 +++
 hard-interface.c        | 3 +++
 hard-interface.h        | 3 +++
 hash.c                  | 3 +++
 hash.h                  | 3 +++
 icmp_socket.c           | 3 +++
 icmp_socket.h           | 3 +++
 main.c                  | 3 +++
 main.h                  | 3 +++
 network-coding.c        | 3 +++
 network-coding.h        | 3 +++
 originator.c            | 3 +++
 originator.h            | 3 +++
 packet.h                | 3 +++
 routing.c               | 3 +++
 routing.h               | 3 +++
 send.c                  | 3 +++
 send.h                  | 3 +++
 soft-interface.c        | 3 +++
 soft-interface.h        | 3 +++
 sysfs.c                 | 3 +++
 sysfs.h                 | 3 +++
 translation-table.c     | 3 +++
 translation-table.h     | 3 +++
 types.h                 | 3 +++
 44 files changed, 130 insertions(+)

diff --git a/Makefile b/Makefile
index 66534b5..6edf514 100644
--- a/Makefile
+++ b/Makefile
@@ -12,6 +12,9 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 # General Public License for more details.
 #
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, see <http://www.gnu.org/licenses/>.
+#
 
 # read README.external for more information about the configuration
 # B.A.T.M.A.N. debugging:
diff --git a/Makefile.kbuild b/Makefile.kbuild
index 989bf10..e595415 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -12,6 +12,9 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 # General Public License for more details.
 #
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, see <http://www.gnu.org/licenses/>.
+#
 
 obj-$(CONFIG_BATMAN_ADV) += batman-adv.o
 batman-adv-y += bat_iv_ogm.o
diff --git a/bat_algo.h b/bat_algo.h
index 3690692..92435bf 100644
--- a/bat_algo.h
+++ b/bat_algo.h
@@ -10,6 +10,9 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_BAT_ALGO_H_
diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index b9aec98..3497712 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -10,6 +10,9 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "main.h"
diff --git a/bitarray.c b/bitarray.c
index 6eed735..89d3a5b 100644
--- a/bitarray.c
+++ b/bitarray.c
@@ -10,6 +10,9 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "main.h"
diff --git a/bitarray.h b/bitarray.h
index 6f7e4f6..685e0af 100644
--- a/bitarray.h
+++ b/bitarray.h
@@ -10,6 +10,9 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_BITARRAY_H_
diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 4382127..b164a07 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -10,6 +10,9 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "main.h"
diff --git a/bridge_loop_avoidance.h b/bridge_loop_avoidance.h
index c2e0c8c..377dae0 100644
--- a/bridge_loop_avoidance.h
+++ b/bridge_loop_avoidance.h
@@ -10,6 +10,9 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_BLA_H_
diff --git a/compat.c b/compat.c
index cebd800..4fca9e1 100644
--- a/compat.c
+++ b/compat.c
@@ -11,6 +11,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
  *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
diff --git a/compat.h b/compat.h
index 6daeff9..8545b0a 100644
--- a/compat.h
+++ b/compat.h
@@ -11,6 +11,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
  *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
diff --git a/debugfs.c b/debugfs.c
index fcdb51b..26cbf34 100644
--- a/debugfs.c
+++ b/debugfs.c
@@ -10,6 +10,9 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "main.h"
diff --git a/debugfs.h b/debugfs.h
index f6e16f3..981794f 100644
--- a/debugfs.h
+++ b/debugfs.h
@@ -10,6 +10,9 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_DEBUGFS_H_
diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index f329af4..990c054 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -10,6 +10,9 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <linux/if_ether.h>
diff --git a/distributed-arp-table.h b/distributed-arp-table.h
index 698e13f..afa13ca 100644
--- a/distributed-arp-table.h
+++ b/distributed-arp-table.h
@@ -10,6 +10,9 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_DISTRIBUTED_ARP_TABLE_H_
diff --git a/fragmentation.c b/fragmentation.c
index 0dd09d4..8c3c151 100644
--- a/fragmentation.c
+++ b/fragmentation.c
@@ -10,6 +10,9 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "main.h"
diff --git a/fragmentation.h b/fragmentation.h
index d9a97f3..0347f0c 100644
--- a/fragmentation.h
+++ b/fragmentation.h
@@ -10,6 +10,9 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_FRAGMENTATION_H_
diff --git a/gateway_client.c b/gateway_client.c
index 5c66081..9ece204 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -10,6 +10,9 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "main.h"
diff --git a/gateway_client.h b/gateway_client.h
index 8fab195..006befb 100644
--- a/gateway_client.h
+++ b/gateway_client.h
@@ -10,6 +10,9 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_GATEWAY_CLIENT_H_
diff --git a/gateway_common.c b/gateway_common.c
index 60ddd7c..f76816c 100644
--- a/gateway_common.c
+++ b/gateway_common.c
@@ -10,6 +10,9 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "main.h"
diff --git a/gateway_common.h b/gateway_common.h
index 49f5deb..c47b17a 100644
--- a/gateway_common.h
+++ b/gateway_common.h
@@ -10,6 +10,9 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_GATEWAY_COMMON_H_
diff --git a/hard-interface.c b/hard-interface.c
index 3873175..3f0e41a 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -10,6 +10,9 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "main.h"
diff --git a/hard-interface.h b/hard-interface.h
index f4a6022..ccd42c2 100644
--- a/hard-interface.h
+++ b/hard-interface.h
@@ -10,6 +10,9 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_HARD_INTERFACE_H_
diff --git a/hash.c b/hash.c
index 0470008..d9cfa03 100644
--- a/hash.c
+++ b/hash.c
@@ -10,6 +10,9 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "main.h"
diff --git a/hash.h b/hash.h
index 7030911..df5ece9 100644
--- a/hash.h
+++ b/hash.h
@@ -10,6 +10,9 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_HASH_H_
diff --git a/icmp_socket.c b/icmp_socket.c
index 7e48d9e..d3fcd9f 100644
--- a/icmp_socket.c
+++ b/icmp_socket.c
@@ -10,6 +10,9 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "main.h"
diff --git a/icmp_socket.h b/icmp_socket.h
index 10ba853..559e54a 100644
--- a/icmp_socket.h
+++ b/icmp_socket.h
@@ -10,6 +10,9 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_ICMP_SOCKET_H_
diff --git a/main.c b/main.c
index a7da5ea..3fc4a43 100644
--- a/main.c
+++ b/main.c
@@ -10,6 +10,9 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <linux/crc32c.h>
diff --git a/main.h b/main.h
index d154d4d..2f3ac06 100644
--- a/main.h
+++ b/main.h
@@ -10,6 +10,9 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_MAIN_H_
diff --git a/network-coding.c b/network-coding.c
index b2fde56..668c518 100644
--- a/network-coding.c
+++ b/network-coding.c
@@ -10,6 +10,9 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <linux/debugfs.h>
diff --git a/network-coding.h b/network-coding.h
index b16639f..136db6d 100644
--- a/network-coding.h
+++ b/network-coding.h
@@ -10,6 +10,9 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_NETWORK_CODING_H_
diff --git a/originator.c b/originator.c
index a001a3d..4af1c77 100644
--- a/originator.c
+++ b/originator.c
@@ -10,6 +10,9 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "main.h"
diff --git a/originator.h b/originator.h
index 39fa3b7..ad17c3c 100644
--- a/originator.h
+++ b/originator.h
@@ -10,6 +10,9 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_ORIGINATOR_H_
diff --git a/packet.h b/packet.h
index 5f402c9..9b6c45b 100644
--- a/packet.h
+++ b/packet.h
@@ -10,6 +10,9 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_PACKET_H_
diff --git a/routing.c b/routing.c
index 7aac5b3..773a452 100644
--- a/routing.c
+++ b/routing.c
@@ -10,6 +10,9 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "main.h"
diff --git a/routing.h b/routing.h
index 4143898..8fa23fc 100644
--- a/routing.h
+++ b/routing.h
@@ -10,6 +10,9 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_ROUTING_H_
diff --git a/send.c b/send.c
index 4b6208c..6a713c8 100644
--- a/send.c
+++ b/send.c
@@ -10,6 +10,9 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "main.h"
diff --git a/send.h b/send.h
index 960015d..0b17f8d 100644
--- a/send.h
+++ b/send.h
@@ -10,6 +10,9 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_SEND_H_
diff --git a/soft-interface.c b/soft-interface.c
index 450dd7c..a48e1e3 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -10,6 +10,9 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "main.h"
diff --git a/soft-interface.h b/soft-interface.h
index 1e5846f..4ab0167 100644
--- a/soft-interface.h
+++ b/soft-interface.h
@@ -10,6 +10,9 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_SOFT_INTERFACE_H_
diff --git a/sysfs.c b/sysfs.c
index 3347ffc..2f89a57 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -10,6 +10,9 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "main.h"
diff --git a/sysfs.h b/sysfs.h
index eb80ee0..ed80b72 100644
--- a/sysfs.h
+++ b/sysfs.h
@@ -10,6 +10,9 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_SYSFS_H_
diff --git a/translation-table.c b/translation-table.c
index 3b13c63..6fbb6a0 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -10,6 +10,9 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "main.h"
diff --git a/translation-table.h b/translation-table.h
index 3ab8a7b..daa8ab7 100644
--- a/translation-table.h
+++ b/translation-table.h
@@ -10,6 +10,9 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_TRANSLATION_TABLE_H_
diff --git a/types.h b/types.h
index 2627a3d..8a1fa16 100644
--- a/types.h
+++ b/types.h
@@ -10,6 +10,9 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_TYPES_H_
-- 
1.8.5.1


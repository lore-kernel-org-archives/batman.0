Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sun,  3 Nov 2013 20:40:48 +0100
Message-Id: <1383507648-1973-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: remove FSF address from GPL
	disclaimer
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

As suggested by checkpatch, remove all the references to the
FSF address since the kernel already has one reference in
its documentation.

In this way it is easier to update it in case of future
changes.

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 Makefile                | 5 -----
 Makefile.kbuild         | 5 -----
 bat_algo.h              | 5 -----
 bat_iv_ogm.c            | 5 -----
 bitarray.c              | 5 -----
 bitarray.h              | 5 -----
 bridge_loop_avoidance.c | 5 -----
 bridge_loop_avoidance.h | 5 -----
 compat.c                | 5 -----
 compat.h                | 5 -----
 debugfs.c               | 5 -----
 debugfs.h               | 5 -----
 distributed-arp-table.c | 5 -----
 distributed-arp-table.h | 5 -----
 fragmentation.c         | 5 -----
 fragmentation.h         | 5 -----
 gateway_client.c        | 5 -----
 gateway_client.h        | 5 -----
 gateway_common.c        | 5 -----
 gateway_common.h        | 5 -----
 hard-interface.c        | 5 -----
 hard-interface.h        | 5 -----
 hash.c                  | 5 -----
 hash.h                  | 5 -----
 icmp_socket.c           | 5 -----
 icmp_socket.h           | 5 -----
 main.c                  | 5 -----
 main.h                  | 5 -----
 network-coding.c        | 5 -----
 network-coding.h        | 5 -----
 originator.c            | 5 -----
 originator.h            | 5 -----
 packet.h                | 5 -----
 routing.c               | 5 -----
 routing.h               | 5 -----
 send.c                  | 5 -----
 send.h                  | 5 -----
 soft-interface.c        | 5 -----
 soft-interface.h        | 5 -----
 sysfs.c                 | 5 -----
 sysfs.h                 | 5 -----
 translation-table.c     | 5 -----
 translation-table.h     | 5 -----
 types.h                 | 5 -----
 44 files changed, 220 deletions(-)

diff --git a/Makefile b/Makefile
index 407cdc4..66534b5 100644
--- a/Makefile
+++ b/Makefile
@@ -12,11 +12,6 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 # General Public License for more details.
 #
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
-# 02110-1301, USA
-#
 
 # read README.external for more information about the configuration
 # B.A.T.M.A.N. debugging:
diff --git a/Makefile.kbuild b/Makefile.kbuild
index 4f4aabb..989bf10 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -12,11 +12,6 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 # General Public License for more details.
 #
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
-# 02110-1301, USA
-#
 
 obj-$(CONFIG_BATMAN_ADV) += batman-adv.o
 batman-adv-y += bat_iv_ogm.o
diff --git a/bat_algo.h b/bat_algo.h
index a4808c2..3690692 100644
--- a/bat_algo.h
+++ b/bat_algo.h
@@ -10,11 +10,6 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
  */
 
 #ifndef _NET_BATMAN_ADV_BAT_ALGO_H_
diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index a2b480a..409cb16 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -10,11 +10,6 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
  */
 
 #include "main.h"
diff --git a/bitarray.c b/bitarray.c
index 9739824..6eed735 100644
--- a/bitarray.c
+++ b/bitarray.c
@@ -10,11 +10,6 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
  */
 
 #include "main.h"
diff --git a/bitarray.h b/bitarray.h
index a81b932..6f7e4f6 100644
--- a/bitarray.h
+++ b/bitarray.h
@@ -10,11 +10,6 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
  */
 
 #ifndef _NET_BATMAN_ADV_BITARRAY_H_
diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 28eb5e6..4382127 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -10,11 +10,6 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
  */
 
 #include "main.h"
diff --git a/bridge_loop_avoidance.h b/bridge_loop_avoidance.h
index da173e7..c2e0c8c 100644
--- a/bridge_loop_avoidance.h
+++ b/bridge_loop_avoidance.h
@@ -10,11 +10,6 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
  */
 
 #ifndef _NET_BATMAN_ADV_BLA_H_
diff --git a/compat.c b/compat.c
index 68c2258..4000d17 100644
--- a/compat.c
+++ b/compat.c
@@ -11,11 +11,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
diff --git a/compat.h b/compat.h
index 04a2256..01984b8 100644
--- a/compat.h
+++ b/compat.h
@@ -11,11 +11,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
diff --git a/debugfs.c b/debugfs.c
index 049a7a2..367ea86 100644
--- a/debugfs.c
+++ b/debugfs.c
@@ -10,11 +10,6 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
  */
 
 #include "main.h"
diff --git a/debugfs.h b/debugfs.h
index f8c3849..169ab7b 100644
--- a/debugfs.h
+++ b/debugfs.h
@@ -10,11 +10,6 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
  */
 
 #ifndef _NET_BATMAN_ADV_DEBUGFS_H_
diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 6c8c393..209066f 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -10,11 +10,6 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
  */
 
 #include <linux/if_ether.h>
diff --git a/distributed-arp-table.h b/distributed-arp-table.h
index 79a078b..698e13f 100644
--- a/distributed-arp-table.h
+++ b/distributed-arp-table.h
@@ -10,11 +10,6 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
  */
 
 #ifndef _NET_BATMAN_ADV_DISTRIBUTED_ARP_TABLE_H_
diff --git a/fragmentation.c b/fragmentation.c
index 271d321..0dd09d4 100644
--- a/fragmentation.c
+++ b/fragmentation.c
@@ -10,11 +10,6 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
  */
 
 #include "main.h"
diff --git a/fragmentation.h b/fragmentation.h
index ca029e2..d9a97f3 100644
--- a/fragmentation.h
+++ b/fragmentation.h
@@ -10,11 +10,6 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
  */
 
 #ifndef _NET_BATMAN_ADV_FRAGMENTATION_H_
diff --git a/gateway_client.c b/gateway_client.c
index fcaebec..f9d285c 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -10,11 +10,6 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
  */
 
 #include "main.h"
diff --git a/gateway_client.h b/gateway_client.h
index d95c2d2..2f36569 100644
--- a/gateway_client.h
+++ b/gateway_client.h
@@ -10,11 +10,6 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
  */
 
 #ifndef _NET_BATMAN_ADV_GATEWAY_CLIENT_H_
diff --git a/gateway_common.c b/gateway_common.c
index 5795d9a..60ddd7c 100644
--- a/gateway_common.c
+++ b/gateway_common.c
@@ -10,11 +10,6 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
  */
 
 #include "main.h"
diff --git a/gateway_common.h b/gateway_common.h
index 56384a4..49f5deb 100644
--- a/gateway_common.h
+++ b/gateway_common.h
@@ -10,11 +10,6 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
  */
 
 #ifndef _NET_BATMAN_ADV_GATEWAY_COMMON_H_
diff --git a/hard-interface.c b/hard-interface.c
index 57c2a19..42db38e 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -10,11 +10,6 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
  */
 
 #include "main.h"
diff --git a/hard-interface.h b/hard-interface.h
index df4c8bd..9f23f16 100644
--- a/hard-interface.h
+++ b/hard-interface.h
@@ -10,11 +10,6 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
  */
 
 #ifndef _NET_BATMAN_ADV_HARD_INTERFACE_H_
diff --git a/hash.c b/hash.c
index 7198daf..0470008 100644
--- a/hash.c
+++ b/hash.c
@@ -10,11 +10,6 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
  */
 
 #include "main.h"
diff --git a/hash.h b/hash.h
index 1b4da72..7030911 100644
--- a/hash.h
+++ b/hash.h
@@ -10,11 +10,6 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
  */
 
 #ifndef _NET_BATMAN_ADV_HASH_H_
diff --git a/icmp_socket.c b/icmp_socket.c
index 29ae4ef..a7ab183 100644
--- a/icmp_socket.c
+++ b/icmp_socket.c
@@ -10,11 +10,6 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
  */
 
 #include "main.h"
diff --git a/icmp_socket.h b/icmp_socket.h
index 6665080..10ba853 100644
--- a/icmp_socket.h
+++ b/icmp_socket.h
@@ -10,11 +10,6 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
  */
 
 #ifndef _NET_BATMAN_ADV_ICMP_SOCKET_H_
diff --git a/main.c b/main.c
index c51a5e5..d51bc5f 100644
--- a/main.c
+++ b/main.c
@@ -10,11 +10,6 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
  */
 
 #include <linux/crc32c.h>
diff --git a/main.h b/main.h
index c5d6eb2..1ab279c 100644
--- a/main.h
+++ b/main.h
@@ -10,11 +10,6 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
  */
 
 #ifndef _NET_BATMAN_ADV_MAIN_H_
diff --git a/network-coding.c b/network-coding.c
index 351e199..24d0f31 100644
--- a/network-coding.c
+++ b/network-coding.c
@@ -10,11 +10,6 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
  */
 
 #include <linux/debugfs.h>
diff --git a/network-coding.h b/network-coding.h
index d4fd315..6b1a5d7 100644
--- a/network-coding.h
+++ b/network-coding.h
@@ -10,11 +10,6 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
  */
 
 #ifndef _NET_BATMAN_ADV_NETWORK_CODING_H_
diff --git a/originator.c b/originator.c
index 8ab1434..edfb921 100644
--- a/originator.c
+++ b/originator.c
@@ -10,11 +10,6 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
  */
 
 #include "main.h"
diff --git a/originator.h b/originator.h
index 6f77d80..ba0e130 100644
--- a/originator.h
+++ b/originator.h
@@ -10,11 +10,6 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
  */
 
 #ifndef _NET_BATMAN_ADV_ORIGINATOR_H_
diff --git a/packet.h b/packet.h
index 207459b..cbebac6 100644
--- a/packet.h
+++ b/packet.h
@@ -10,11 +10,6 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
  */
 
 #ifndef _NET_BATMAN_ADV_PACKET_H_
diff --git a/routing.c b/routing.c
index 59fff2e..6ea0422 100644
--- a/routing.c
+++ b/routing.c
@@ -10,11 +10,6 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
  */
 
 #include "main.h"
diff --git a/routing.h b/routing.h
index 19544dd..7aef0a6 100644
--- a/routing.h
+++ b/routing.h
@@ -10,11 +10,6 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
  */
 
 #ifndef _NET_BATMAN_ADV_ROUTING_H_
diff --git a/send.c b/send.c
index c83be5e..49074e0 100644
--- a/send.c
+++ b/send.c
@@ -10,11 +10,6 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
  */
 
 #include "main.h"
diff --git a/send.h b/send.h
index aa2e253..be64c32 100644
--- a/send.h
+++ b/send.h
@@ -10,11 +10,6 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
  */
 
 #ifndef _NET_BATMAN_ADV_SEND_H_
diff --git a/soft-interface.c b/soft-interface.c
index 36f0508..7e877d2 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -10,11 +10,6 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
  */
 
 #include "main.h"
diff --git a/soft-interface.h b/soft-interface.h
index 06fc91f..1e5846f 100644
--- a/soft-interface.h
+++ b/soft-interface.h
@@ -10,11 +10,6 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
  */
 
 #ifndef _NET_BATMAN_ADV_SOFT_INTERFACE_H_
diff --git a/sysfs.c b/sysfs.c
index c686313..59f11f7 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -10,11 +10,6 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
  */
 
 #include "main.h"
diff --git a/sysfs.h b/sysfs.h
index c7d725d..eb80ee0 100644
--- a/sysfs.h
+++ b/sysfs.h
@@ -10,11 +10,6 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
  */
 
 #ifndef _NET_BATMAN_ADV_SYSFS_H_
diff --git a/translation-table.c b/translation-table.c
index 4add57d..5957bad 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -10,11 +10,6 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
  */
 
 #include "main.h"
diff --git a/translation-table.h b/translation-table.h
index 026b1ff..270773e 100644
--- a/translation-table.h
+++ b/translation-table.h
@@ -10,11 +10,6 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
  */
 
 #ifndef _NET_BATMAN_ADV_TRANSLATION_TABLE_H_
diff --git a/types.h b/types.h
index 91dd369..42e941f 100644
--- a/types.h
+++ b/types.h
@@ -10,11 +10,6 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
  */
 
 #ifndef _NET_BATMAN_ADV_TYPES_H_
-- 
1.8.4.2


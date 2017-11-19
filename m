Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 19 Nov 2017 15:05:49 +0100
Message-Id: <20171119140553.24435-3-sven@narfation.org>
In-Reply-To: <20171119140553.24435-1-sven@narfation.org>
References: <20171119140553.24435-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/6] batctl: Add License-Filename to GPL-2.0
 files
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

[1] https://reuse.software/practices/

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile      | 1 +
 allocate.h    | 1 +
 bat-hosts.c   | 1 +
 bat-hosts.h   | 1 +
 bisect_iv.c   | 1 +
 bisect_iv.h   | 1 +
 debug.c       | 1 +
 debug.h       | 1 +
 debugfs.c     | 1 +
 debugfs.h     | 1 +
 functions.c   | 1 +
 functions.h   | 1 +
 genl.h        | 1 +
 hash.c        | 1 +
 hash.h        | 1 +
 icmp_helper.c | 1 +
 icmp_helper.h | 1 +
 interface.c   | 1 +
 interface.h   | 1 +
 ioctl.c       | 1 +
 ioctl.h       | 1 +
 main.c        | 1 +
 main.h        | 1 +
 netlink.c     | 1 +
 netlink.h     | 1 +
 packet.h      | 2 ++
 ping.c        | 1 +
 ping.h        | 1 +
 sys.c         | 1 +
 sys.h         | 1 +
 tcpdump.c     | 1 +
 tcpdump.h     | 1 +
 tp_meter.c    | 1 +
 tp_meter.h    | 1 +
 traceroute.c  | 1 +
 traceroute.h  | 1 +
 translate.c   | 1 +
 translate.h   | 1 +
 38 files changed, 39 insertions(+)

diff --git a/Makefile b/Makefile
index 6bebb7d..78bd200 100755
--- a/Makefile
+++ b/Makefile
@@ -17,6 +17,7 @@
 # Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
 # 02110-1301, USA
 #
+# License-Filename: LICENSES/preferred/GPL-2.0
 
 # changing the CONFIG_* line to 'y' enables the related feature
 # batctl advanced debugging tool bisect:
diff --git a/allocate.h b/allocate.h
index 99db2c1..2cd6996 100644
--- a/allocate.h
+++ b/allocate.h
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 
diff --git a/bat-hosts.c b/bat-hosts.c
index b530243..33e1dbd 100644
--- a/bat-hosts.c
+++ b/bat-hosts.c
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 
diff --git a/bat-hosts.h b/bat-hosts.h
index 8466554..474706c 100644
--- a/bat-hosts.h
+++ b/bat-hosts.h
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 
diff --git a/bisect_iv.c b/bisect_iv.c
index 28c7b05..c5616ad 100644
--- a/bisect_iv.c
+++ b/bisect_iv.c
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include <stdint.h>
diff --git a/bisect_iv.h b/bisect_iv.h
index f1fe4d8..558508f 100644
--- a/bisect_iv.h
+++ b/bisect_iv.h
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _BATCTL_BISECT_IV_H
diff --git a/debug.c b/debug.c
index 07a91c4..1fb9cd2 100644
--- a/debug.c
+++ b/debug.c
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 
diff --git a/debug.h b/debug.h
index c23af52..b185bde 100644
--- a/debug.h
+++ b/debug.h
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _BATCTL_DEBUG_H
diff --git a/debugfs.c b/debugfs.c
index fc39322..e90c3a8 100644
--- a/debugfs.c
+++ b/debugfs.c
@@ -16,6 +16,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include "debugfs.h"
diff --git a/debugfs.h b/debugfs.h
index b4dc6bb..5404a45 100644
--- a/debugfs.h
+++ b/debugfs.h
@@ -16,6 +16,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef __DEBUGFS_H__
diff --git a/functions.c b/functions.c
index 868e0ae..7d857e7 100644
--- a/functions.c
+++ b/functions.c
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 
diff --git a/functions.h b/functions.h
index 16b3a0e..24289b3 100644
--- a/functions.h
+++ b/functions.h
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _BATCTL_FUNCTIONS_H
diff --git a/genl.h b/genl.h
index 606a933..f8a5a25 100644
--- a/genl.h
+++ b/genl.h
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _BATCTL_GENL_H
diff --git a/hash.c b/hash.c
index f4a7af7..2df9d26 100644
--- a/hash.c
+++ b/hash.c
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 
diff --git a/hash.h b/hash.h
index 6b44eef..676e0ae 100644
--- a/hash.h
+++ b/hash.h
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 #ifndef _BATMAN_HASH_H
 #define _BATMAN_HASH_H
diff --git a/icmp_helper.c b/icmp_helper.c
index 0eea5c4..3eab78b 100644
--- a/icmp_helper.c
+++ b/icmp_helper.c
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include "icmp_helper.h"
diff --git a/icmp_helper.h b/icmp_helper.h
index be4cb7d..6f9c3ab 100644
--- a/icmp_helper.h
+++ b/icmp_helper.h
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _BATCTL_ICMP_HELPER_H
diff --git a/interface.c b/interface.c
index 5a57be6..5cc036b 100644
--- a/interface.c
+++ b/interface.c
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include "interface.h"
diff --git a/interface.h b/interface.h
index 9977515..5c5d1a1 100644
--- a/interface.h
+++ b/interface.h
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _BATCTL_INTERFACE_H
diff --git a/ioctl.c b/ioctl.c
index 5fc56b8..92635ad 100644
--- a/ioctl.c
+++ b/ioctl.c
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 
diff --git a/ioctl.h b/ioctl.h
index 9a89afb..8b270ad 100644
--- a/ioctl.h
+++ b/ioctl.h
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _BATCTL_IOCTL_H
diff --git a/main.c b/main.c
index 02d89c4..cea9257 100644
--- a/main.c
+++ b/main.c
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 
diff --git a/main.h b/main.h
index 3a5bdd6..b24b4d7 100644
--- a/main.h
+++ b/main.h
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _BATCTL_MAIN_H
diff --git a/netlink.c b/netlink.c
index 7fb1ee1..24541f8 100644
--- a/netlink.c
+++ b/netlink.c
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include "netlink.h"
diff --git a/netlink.h b/netlink.h
index 8355201..704ee1b 100644
--- a/netlink.h
+++ b/netlink.h
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _BATCTL_NETLINK_H
diff --git a/packet.h b/packet.h
index 8e8a5db..f1fd031 100644
--- a/packet.h
+++ b/packet.h
@@ -13,6 +13,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _NET_BATMAN_ADV_PACKET_H_
diff --git a/ping.c b/ping.c
index df6b0e2..8e7963d 100644
--- a/ping.c
+++ b/ping.c
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 
diff --git a/ping.h b/ping.h
index fbe5632..4141bef 100644
--- a/ping.h
+++ b/ping.h
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _BATCTL_PING_H
diff --git a/sys.c b/sys.c
index 65b438c..90b0d58 100644
--- a/sys.c
+++ b/sys.c
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 
diff --git a/sys.h b/sys.h
index 595f45d..9fd32d2 100644
--- a/sys.h
+++ b/sys.h
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _BATCTL_SYS_H
diff --git a/tcpdump.c b/tcpdump.c
index 4ede76b..e3041f2 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include <stdio.h>
diff --git a/tcpdump.h b/tcpdump.h
index 15d35b4..a625734 100644
--- a/tcpdump.h
+++ b/tcpdump.h
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _BATCTL_TCPDUMP_H
diff --git a/tp_meter.c b/tp_meter.c
index a623a68..6c97ae5 100644
--- a/tp_meter.c
+++ b/tp_meter.c
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include "main.h"
diff --git a/tp_meter.h b/tp_meter.h
index bf17ad1..b4100d8 100644
--- a/tp_meter.h
+++ b/tp_meter.h
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _BATCTL_TP_METER_H
diff --git a/traceroute.c b/traceroute.c
index 79d3800..db5304f 100644
--- a/traceroute.c
+++ b/traceroute.c
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 
diff --git a/traceroute.h b/traceroute.h
index 05e5d3f..d0b31a6 100644
--- a/traceroute.h
+++ b/traceroute.h
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _BATCTL_TRACEROUTE_H
diff --git a/translate.c b/translate.c
index 31da3a3..387049a 100644
--- a/translate.c
+++ b/translate.c
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include <stdio.h>
diff --git a/translate.h b/translate.h
index 7ecb7b7..fe10b8a 100644
--- a/translate.h
+++ b/translate.h
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _BATCTL_TRANSLATE_H
-- 
2.11.0


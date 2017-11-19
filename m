Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 19 Nov 2017 15:05:58 +0100
Message-Id: <20171119140602.24504-3-sven@narfation.org>
In-Reply-To: <20171119140602.24504-1-sven@narfation.org>
References: <20171119140602.24504-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/6] alfred: Add License-Filename to GPL-2.0
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile           | 1 +
 alfred.h           | 1 +
 batadv_query.c     | 1 +
 batadv_query.h     | 1 +
 batadv_querynl.c   | 1 +
 batadv_querynl.h   | 1 +
 client.c           | 1 +
 debugfs.c          | 1 +
 debugfs.h          | 1 +
 gpsd/Makefile      | 1 +
 gpsd/alfred-gpsd.c | 1 +
 gpsd/alfred-gpsd.h | 1 +
 hash.c             | 1 +
 hash.h             | 1 +
 list.h             | 1 +
 main.c             | 1 +
 netlink.c          | 1 +
 netlink.h          | 1 +
 netsock.c          | 1 +
 packet.h           | 1 +
 recv.c             | 1 +
 send.c             | 1 +
 server.c           | 1 +
 unix_sock.c        | 1 +
 util.c             | 1 +
 vis/Makefile       | 1 +
 vis/vis.c          | 1 +
 vis/vis.h          | 1 +
 28 files changed, 28 insertions(+)

diff --git a/Makefile b/Makefile
index 4c1c6b5..1662412 100755
--- a/Makefile
+++ b/Makefile
@@ -17,6 +17,7 @@
 # Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
 # 02110-1301, USA
 #
+# License-Filename: LICENSES/preferred/GPL-2.0
 
 # alfred build
 BINARY_NAME = alfred
diff --git a/alfred.h b/alfred.h
index f52e66b..df0bd9a 100644
--- a/alfred.h
+++ b/alfred.h
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef SOURCE_VERSION
diff --git a/batadv_query.c b/batadv_query.c
index 78b92cd..387950a 100644
--- a/batadv_query.c
+++ b/batadv_query.c
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include "alfred.h"
diff --git a/batadv_query.h b/batadv_query.h
index dc2b135..5633322 100644
--- a/batadv_query.h
+++ b/batadv_query.h
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 #ifndef _BATADV_QUERY_H
 #define _BATADV_QUERY_H
diff --git a/batadv_querynl.c b/batadv_querynl.c
index ca9ee2c..c197d24 100644
--- a/batadv_querynl.c
+++ b/batadv_querynl.c
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include "batadv_querynl.h"
diff --git a/batadv_querynl.h b/batadv_querynl.h
index 4b42ed5..90f6546 100644
--- a/batadv_querynl.h
+++ b/batadv_querynl.h
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _BATADV_QUERYNL_H
diff --git a/client.c b/client.c
index 4102046..27dbc4a 100644
--- a/client.c
+++ b/client.c
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include <ctype.h>
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
diff --git a/gpsd/Makefile b/gpsd/Makefile
index da4a553..dae2b48 100755
--- a/gpsd/Makefile
+++ b/gpsd/Makefile
@@ -17,6 +17,7 @@
 # Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
 # 02110-1301, USA
 #
+# License-Filename: LICENSES/preferred/GPL-2.0
 
 # alfred-gpsd build
 BINARY_NAME = alfred-gpsd
diff --git a/gpsd/alfred-gpsd.c b/gpsd/alfred-gpsd.c
index 01e61a0..7147136 100644
--- a/gpsd/alfred-gpsd.c
+++ b/gpsd/alfred-gpsd.c
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include "alfred-gpsd.h"
diff --git a/gpsd/alfred-gpsd.h b/gpsd/alfred-gpsd.h
index a4a8359..0a3a31f 100644
--- a/gpsd/alfred-gpsd.h
+++ b/gpsd/alfred-gpsd.h
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include <stdio.h>
diff --git a/hash.c b/hash.c
index 5a3cdef..ebdcb47 100644
--- a/hash.c
+++ b/hash.c
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include "hash.h"
diff --git a/hash.h b/hash.h
index f6604d0..3111b49 100644
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
diff --git a/list.h b/list.h
index 2ac2c87..5d4c25a 100644
--- a/list.h
+++ b/list.h
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _LINUX_LIST_H
diff --git a/main.c b/main.c
index cf1e460..be79fb9 100644
--- a/main.c
+++ b/main.c
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include <arpa/inet.h>
diff --git a/netlink.c b/netlink.c
index 7ef4308..7678f99 100644
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
index a4471a1..446948c 100644
--- a/netlink.h
+++ b/netlink.h
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _ALFRED_NETLINK_H
diff --git a/netsock.c b/netsock.c
index c00ea2e..ced8fbd 100644
--- a/netsock.c
+++ b/netsock.c
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include <sys/socket.h>
diff --git a/packet.h b/packet.h
index 425459f..a132326 100644
--- a/packet.h
+++ b/packet.h
@@ -15,6 +15,7 @@
  * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #ifndef _ALFRED_PACKET_H
diff --git a/recv.c b/recv.c
index ebc3041..0f8004e 100644
--- a/recv.c
+++ b/recv.c
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include <errno.h>
diff --git a/send.c b/send.c
index b566503..9c1e31b 100644
--- a/send.c
+++ b/send.c
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include <netinet/in.h>
diff --git a/server.c b/server.c
index 63a3b2a..199d38c 100644
--- a/server.c
+++ b/server.c
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include <errno.h>
diff --git a/unix_sock.c b/unix_sock.c
index 4a8c6e0..7f5e99c 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include <errno.h>
diff --git a/util.c b/util.c
index ed83895..87261a0 100644
--- a/util.c
+++ b/util.c
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include <netinet/ether.h>
diff --git a/vis/Makefile b/vis/Makefile
index b69672c..63500c9 100755
--- a/vis/Makefile
+++ b/vis/Makefile
@@ -17,6 +17,7 @@
 # Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
 # 02110-1301, USA
 #
+# License-Filename: LICENSES/preferred/GPL-2.0
 
 # batadv-vis build
 BINARY_NAME = batadv-vis
diff --git a/vis/vis.c b/vis/vis.c
index 98ff02f..148c581 100644
--- a/vis/vis.c
+++ b/vis/vis.c
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include "vis.h"
diff --git a/vis/vis.h b/vis/vis.h
index 4b12248..b99e745 100644
--- a/vis/vis.h
+++ b/vis/vis.h
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA
  *
+ * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
 #include <sys/socket.h>
-- 
2.11.0


Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@open-mesh.com>
Date: Mon,  9 Sep 2013 17:46:01 +0200
Message-Id: <1378741567-25152-1-git-send-email-sven@open-mesh.com>
Subject: [B.A.T.M.A.N.] [PATCH 1/7] alfred: Add missing includes and remove
	unused includes
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
Cc: Sven Eckelmann <sven@open-mesh.com>

Signed-off-by: Sven Eckelmann <sven@open-mesh.com>
---
 alfred.h       |  6 ++----
 batadv_query.c | 13 +++++++++----
 client.c       | 12 +++++-------
 debugfs.c      | 10 ++++------
 debugfs.h      |  3 ---
 hash.c         |  5 +++--
 main.c         | 11 ++++-------
 netsock.c      | 14 ++++++++------
 recv.c         | 21 ++++++++++++---------
 send.c         | 17 ++++++-----------
 server.c       | 10 ++++++----
 unix_sock.c    | 14 +++++++++-----
 util.c         |  6 ++++--
 vis/vis.c      | 15 +++++++++++++++
 vis/vis.h      | 20 +++-----------------
 15 files changed, 90 insertions(+), 87 deletions(-)

diff --git a/alfred.h b/alfred.h
index c82483c..a244c64 100644
--- a/alfred.h
+++ b/alfred.h
@@ -23,12 +23,10 @@
 #define SOURCE_VERSION			"2013.4.0"
 #endif
 
-#include <stdint.h>
-#include <linux/if_ether.h>
-#include <netinet/ether.h>
+#include <net/ethernet.h>
 #include <netinet/in.h>
+#include <stdint.h>
 #include <time.h>
-#include "hash.h"
 #include "list.h"
 #include "packet.h"
 
diff --git a/batadv_query.c b/batadv_query.c
index db1aed5..83083a1 100644
--- a/batadv_query.c
+++ b/batadv_query.c
@@ -20,11 +20,16 @@
  */
 
 #include "batadv_query.h"
-#include "debugfs.h"
-#include <stdio.h>
-#include <netinet/ether.h>
-#include <stdlib.h>
 #include <errno.h>
+#include <net/ethernet.h>
+#include <netinet/ether.h>
+#include <netinet/in.h>
+#include <stddef.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/types.h>
+#include "debugfs.h"
 
 #define DEBUG_BATIF_PATH_FMT "%s/batman_adv/%s"
 #define DEBUG_TRANSTABLE_GLOBAL "transtable_global"
diff --git a/client.c b/client.c
index a535f5a..3c1916c 100644
--- a/client.c
+++ b/client.c
@@ -19,17 +19,15 @@
  *
  */
 
+#include <ctype.h>
+#include <errno.h>
+#include <netinet/in.h>
+#include <stdint.h>
 #include <stdio.h>
-#include <stdlib.h>
-#include <getopt.h>
 #include <string.h>
 #include <unistd.h>
-#include <errno.h>
-#include <arpa/inet.h>
-#include <sys/select.h>
-#include <sys/time.h>
-#include <ctype.h>
 #include "alfred.h"
+#include "packet.h"
 
 int alfred_client_request_data(struct globals *globals)
 {
diff --git a/debugfs.c b/debugfs.c
index 5a0431f..e62978b 100644
--- a/debugfs.c
+++ b/debugfs.c
@@ -19,14 +19,12 @@
  */
 
 #include "debugfs.h"
-#include <stdio.h>
-#include <stdlib.h>
 #include <errno.h>
-#include <sys/vfs.h>
-#include <sys/types.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/mount.h>
 #include <sys/stat.h>
-#include <fcntl.h>
-#include <unistd.h>
+#include <sys/statfs.h>
 
 #ifndef DEBUGFS_MAGIC
 #define DEBUGFS_MAGIC          0x64626720
diff --git a/debugfs.h b/debugfs.h
index 4008c37..6307a9b 100644
--- a/debugfs.h
+++ b/debugfs.h
@@ -21,9 +21,6 @@
 #ifndef __DEBUGFS_H__
 #define __DEBUGFS_H__
 
-#include <sys/mount.h>
-#include <string.h>
-
 #ifndef MAX_PATH
 # define MAX_PATH 256
 #endif
diff --git a/hash.c b/hash.c
index 8d487eb..940a11f 100644
--- a/hash.c
+++ b/hash.c
@@ -20,8 +20,9 @@
  */
 
 
-#include <stdio.h>	/* NULL */
-#include <stdlib.h>	/* free() */
+#include "hash.h"
+#include <stdlib.h>
+#include <stdio.h>
 #include "alfred.h"
 
 /* clears the hash */
diff --git a/main.c b/main.c
index 86acfb7..4f39948 100644
--- a/main.c
+++ b/main.c
@@ -19,17 +19,14 @@
  *
  */
 
+#include <getopt.h>
+#include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <getopt.h>
 #include <string.h>
-#include <unistd.h>
-#include <errno.h>
-#include <arpa/inet.h>
-#include <sys/select.h>
-#include <sys/time.h>
-#include <signal.h>
 #include "alfred.h"
+#include "packet.h"
+
 
 static void alfred_usage(void)
 {
diff --git a/netsock.c b/netsock.c
index 381d9b0..39281af 100644
--- a/netsock.c
+++ b/netsock.c
@@ -19,17 +19,19 @@
  *
  */
 
+#include <sys/socket.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <net/if.h>
+#include <netinet/in.h>
 #include <stdio.h>
 #include <string.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <stdlib.h>
-#include <netinet/in.h>
 #include <sys/ioctl.h>
-#include <linux/if.h>
+#include <sys/socket.h>
+#include <unistd.h>
 #include "alfred.h"
 #include "batadv_query.h"
+#include "packet.h"
 
 const struct in6_addr in6addr_localmcast = {{{ 0xff, 0x02, 0x00, 0x00,
 					       0x00, 0x00, 0x00, 0x00,
diff --git a/recv.c b/recv.c
index 7541632..5ed4a62 100644
--- a/recv.c
+++ b/recv.c
@@ -19,19 +19,22 @@
  *
  */
 
-#include <stdio.h>
-#include <string.h>
-#include <unistd.h>
-#include <fcntl.h>
 #include <errno.h>
-#include <stdlib.h>
+#include <net/ethernet.h>
 #include <netinet/in.h>
-#include <sys/ioctl.h>
-#include <linux/if.h>
-#include <linux/if_packet.h>
-#include <arpa/inet.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/socket.h>
+#include <sys/time.h>
+#include <time.h>
+#include <unistd.h>
 #include "alfred.h"
 #include "batadv_query.h"
+#include "hash.h"
+#include "list.h"
+#include "packet.h"
 
 static int finish_alfred_push_data(struct globals *globals,
 				   struct ether_addr mac,
diff --git a/send.c b/send.c
index d6920f8..607afa1 100644
--- a/send.c
+++ b/send.c
@@ -19,19 +19,14 @@
  *
  */
 
-#include <stdio.h>
-#include <string.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <stdlib.h>
 #include <netinet/in.h>
-#include <sys/ioctl.h>
-#include <linux/if.h>
-#include <linux/if_packet.h>
-#include <linux/if_ether.h>
-#include <linux/filter.h>
+#include <stddef.h>
+#include <stdint.h>
+#include <string.h>
+#include <sys/socket.h>
 #include "alfred.h"
+#include "hash.h"
+#include "packet.h"
 
 int announce_master(struct globals *globals)
 {
diff --git a/server.c b/server.c
index 02eab42..0d8e6c8 100644
--- a/server.c
+++ b/server.c
@@ -19,17 +19,19 @@
  *
  */
 
+#include <errno.h>
+#include <net/ethernet.h>
+#include <stddef.h>
+#include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <getopt.h>
 #include <string.h>
-#include <unistd.h>
-#include <errno.h>
-#include <arpa/inet.h>
 #include <sys/select.h>
 #include <sys/time.h>
+#include <time.h>
 #include "alfred.h"
 #include "batadv_query.h"
+#include "hash.h"
 
 static int server_compare(void *d1, void *d2)
 {
diff --git a/unix_sock.c b/unix_sock.c
index c778a61..8bff2e1 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -19,17 +19,21 @@
  *
  */
 
+#include <errno.h>
+#include <net/ethernet.h>
+#include <netinet/in.h>
+#include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <errno.h>
-#include <unistd.h>
-#include <arpa/inet.h>
-#include <sys/time.h>
-#include <sys/types.h>
 #include <sys/socket.h>
+#include <sys/time.h>
 #include <sys/un.h>
+#include <time.h>
+#include <unistd.h>
 #include "alfred.h"
+#include "hash.h"
+#include "packet.h"
 
 int unix_sock_open_daemon(struct globals *globals, char *path)
 {
diff --git a/util.c b/util.c
index 5405c84..3c50964 100644
--- a/util.c
+++ b/util.c
@@ -19,10 +19,12 @@
  *
  */
 
-#include <sys/time.h>
-#include <time.h>
+#include <stddef.h>
 #include <stdint.h>
 #include <stdlib.h>
+#include <sys/time.h>
+#include <time.h>
+#include "alfred.h"
 
 int time_diff(struct timespec *tv1, struct timespec *tv2,
 	      struct timespec *tvdiff) {
diff --git a/vis/vis.c b/vis/vis.c
index 3d0c5f0..5247b31 100644
--- a/vis/vis.c
+++ b/vis/vis.c
@@ -20,6 +20,21 @@
  */
 
 #include "vis.h"
+#include <dirent.h>
+#include <errno.h>
+#include <getopt.h>
+#include <linux/if.h>
+#include <netinet/in.h>
+#include <signal.h>
+#include <stddef.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <unistd.h>
+#include "debugfs.h"
 
 char *read_file(char *fname)
 {
diff --git a/vis/vis.h b/vis/vis.h
index 3423066..d4a49d0 100644
--- a/vis/vis.h
+++ b/vis/vis.h
@@ -19,25 +19,11 @@
  *
  */
 
-#include <stdio.h>
-#include <stdint.h>
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-#include <errno.h>
-#include <getopt.h>
-#include <signal.h>
-#include <dirent.h>
-#include <sys/ioctl.h>
-#include <sys/types.h>
 #include <sys/socket.h>
-#include <sys/un.h>
-#include <linux/if.h>
-#include <netinet/ether.h>
-#include <netinet/in.h>
-#include "../packet.h"
+#include <linux/if_ether.h>
+#include <stdint.h>
 #include "../list.h"
-#include "debugfs.h"
+#include "../packet.h"
 
 
 #ifndef SOURCE_VERSION
-- 
1.8.4.rc3


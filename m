Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 22 Sep 2013 16:42:23 +0200
Message-Id: <1379860946-32669-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/4] batctl: Add missing includes and remove
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
Cc: Sven Eckelmann <sven@narfation.org>

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bat-hosts.c   |  5 +++--
 bat-hosts.h   |  2 +-
 bisect_iv.c   |  7 ++++---
 debug.c       |  5 -----
 debug.h       |  3 +++
 debugfs.c     | 10 ++++------
 debugfs.h     |  3 ---
 functions.c   |  2 ++
 functions.h   |  3 ++-
 ioctl.c       |  3 +--
 list-batman.h |  3 ---
 main.c        |  3 ---
 ping.c        |  5 +++++
 sys.c         |  1 -
 sys.h         |  2 ++
 tcpdump.c     |  6 +++++-
 tcpdump.h     |  5 ++++-
 traceroute.c  |  4 ++++
 translate.c   |  1 -
 19 files changed, 40 insertions(+), 33 deletions(-)

diff --git a/bat-hosts.c b/bat-hosts.c
index ee862da..9d36531 100644
--- a/bat-hosts.c
+++ b/bat-hosts.c
@@ -21,14 +21,15 @@
 
 
 
-#include <stdio.h>
 #include <stdint.h>
+#include <stdio.h>
 #include <limits.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <string.h>
+#include <stddef.h>
+#include <netinet/ether.h>
 
-#include "main.h"
 #include "bat-hosts.h"
 #include "hash.h"
 #include "functions.h"
diff --git a/bat-hosts.h b/bat-hosts.h
index 74a4ce5..96abfa9 100644
--- a/bat-hosts.h
+++ b/bat-hosts.h
@@ -24,7 +24,7 @@
 #ifndef _BATCTL_BAT_HOSTS_H
 #define _BATCTL_BAT_HOSTS_H
 
-#include <netinet/ether.h>
+#include <net/ethernet.h>
 
 #define HOST_NAME_MAX_LEN 50
 #define CONF_DIR_LEN 256
diff --git a/bisect_iv.c b/bisect_iv.c
index c0f9420..917ffec 100644
--- a/bisect_iv.c
+++ b/bisect_iv.c
@@ -19,14 +19,15 @@
  *
  */
 
+#include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <stdint.h>
-#include <unistd.h>
 #include <string.h>
 #include <errno.h>
+#include <unistd.h>
+#include <stddef.h>
+#include <netinet/ether.h>
 
-#include "main.h"
 #include "bisect_iv.h"
 #include "bat-hosts.h"
 #include "hash.h"
diff --git a/debug.c b/debug.c
index 2589dbc..6b7b648 100644
--- a/debug.c
+++ b/debug.c
@@ -23,12 +23,7 @@
 #include <unistd.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <string.h>
-#include <errno.h>
-#include <sys/types.h>
-#include <dirent.h>
 
-#include "main.h"
 #include "debug.h"
 #include "debugfs.h"
 #include "functions.h"
diff --git a/debug.h b/debug.h
index 8d9de08..563a7bb 100644
--- a/debug.h
+++ b/debug.h
@@ -22,6 +22,9 @@
 #ifndef _BATCTL_DEBUG_H
 #define _BATCTL_DEBUG_H
 
+#include <stddef.h>
+#include "main.h"
+
 #define DEBUG_BATIF_PATH_FMT "%s/batman_adv/%s"
 #define DEBUG_TRANSTABLE_GLOBAL "transtable_global"
 #define DEBUG_LOG "log"
diff --git a/debugfs.c b/debugfs.c
index bfedcfe..8033f8b 100644
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
index 3981b8b..e608902 100644
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
diff --git a/functions.c b/functions.c
index bd4da59..1a33d6d 100644
--- a/functions.c
+++ b/functions.c
@@ -33,6 +33,8 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <sys/time.h>
+#include <netinet/in.h>
+#include <stdint.h>
 
 #include "main.h"
 #include "functions.h"
diff --git a/functions.h b/functions.h
index 6720a1b..a96b7ee 100644
--- a/functions.h
+++ b/functions.h
@@ -22,7 +22,8 @@
 #ifndef _BATCTL_FUNCTIONS_H
 #define _BATCTL_FUNCTIONS_H
 
-#include <netinet/if_ether.h>
+#include <net/ethernet.h>
+#include <stddef.h>
 
 
 #define ETH_STR_LEN 17
diff --git a/ioctl.c b/ioctl.c
index 3d5b50d..cbb1aa5 100644
--- a/ioctl.c
+++ b/ioctl.c
@@ -26,15 +26,14 @@
 #include <string.h>
 #include <unistd.h>
 #include <sys/ioctl.h>
+#include <sys/types.h>
 #include <sys/socket.h>
 #include <linux/if.h>
 #include <linux/sockios.h>
 #include <linux/ethtool.h>
 #include <stdint.h>
 
-#include "main.h"
 #include "ioctl.h"
-#include "debugfs.h"
 
 /* code borrowed from ethtool */
 static int statistics_custom_get(int fd, struct ifreq *ifr)
diff --git a/list-batman.h b/list-batman.h
index 7de5943..aea0f95 100644
--- a/list-batman.h
+++ b/list-batman.h
@@ -19,9 +19,6 @@
  *
  */
 
-
-#include <stddef.h> /* offsetof() */
-
 #ifndef _LINUX_LIST_H
 #define _LINUX_LIST_H
 
diff --git a/main.c b/main.c
index 6b44359..84bb42a 100644
--- a/main.c
+++ b/main.c
@@ -21,9 +21,7 @@
 
 
 
-#include <sys/types.h>
 #include <stdio.h>
-#include <stdint.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <string.h>
@@ -38,7 +36,6 @@
 #include "bisect_iv.h"
 #include "ioctl.h"
 #include "functions.h"
-#include <err.h>
 
 char mesh_dfl_iface[] = "bat0";
 char module_ver_path[] = "/sys/module/batman_adv/version";
diff --git a/ping.c b/ping.c
index 4d76484..d505d02 100644
--- a/ping.c
+++ b/ping.c
@@ -30,6 +30,11 @@
 #include <fcntl.h>
 #include <string.h>
 #include <math.h>
+#include <stddef.h>
+#include <stdint.h>
+#include <sys/select.h>
+#include <sys/time.h>
+#include <linux/if_ether.h>
 
 #include "main.h"
 #include "ping.h"
diff --git a/sys.c b/sys.c
index 3e60c79..7539f76 100644
--- a/sys.c
+++ b/sys.c
@@ -25,7 +25,6 @@
 #include <stdlib.h>
 #include <string.h>
 #include <errno.h>
-#include <sys/types.h>
 #include <dirent.h>
 
 #include "main.h"
diff --git a/sys.h b/sys.h
index dfc167a..5d207a1 100644
--- a/sys.h
+++ b/sys.h
@@ -22,6 +22,8 @@
 #ifndef _BATCTL_SYS_H
 #define _BATCTL_SYS_H
 
+#include "main.h"
+
 #define SYS_BATIF_PATH_FMT "/sys/class/net/%s/mesh/"
 #define SYS_LOG_LEVEL "log_level"
 #define SYS_LOG "log"
diff --git a/tcpdump.c b/tcpdump.c
index 7e0987b..a220c3c 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -36,8 +36,12 @@
 #include <netinet/udp.h>
 #include <netinet/ip_icmp.h>
 #include <netinet/if_ether.h>
+#include <net/ethernet.h>
+#include <stddef.h>
+#include <stdint.h>
+#include <sys/select.h>
+#include <sys/socket.h>
 
-#include "main.h"
 #include "tcpdump.h"
 #include "packet.h"
 #include "bat-hosts.h"
diff --git a/tcpdump.h b/tcpdump.h
index 2845576..3c1a0e1 100644
--- a/tcpdump.h
+++ b/tcpdump.h
@@ -23,7 +23,10 @@
 #define _BATCTL_TCPDUMP_H
 
 #include <netpacket/packet.h>
-#include <net/ethernet.h>
+#include <linux/if_ether.h>
+#include <net/if_arp.h>
+#include <sys/types.h>
+#include "main.h"
 #include "list-batman.h"
 
 #ifndef ARPHRD_IEEE80211_PRISM
diff --git a/traceroute.c b/traceroute.c
index d62df5e..0cb0441 100644
--- a/traceroute.c
+++ b/traceroute.c
@@ -28,6 +28,10 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <string.h>
+#include <linux/if_ether.h>
+#include <stddef.h>
+#include <sys/select.h>
+#include <sys/time.h>
 
 #include "main.h"
 #include "traceroute.h"
diff --git a/translate.c b/translate.c
index 0b4fbc6..da6d593 100644
--- a/translate.c
+++ b/translate.c
@@ -19,7 +19,6 @@
  *
  */
 
-#include <netinet/in.h>
 #include <stdio.h>
 #include <stdlib.h>
 
-- 
1.8.4.rc3


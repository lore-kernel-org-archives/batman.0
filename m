Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 12 Sep 2013 22:58:41 +0200
Message-Id: <1379019524-23543-11-git-send-email-sven@narfation.org>
In-Reply-To: <1379019524-23543-1-git-send-email-sven@narfation.org>
References: <1379019524-23543-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 10/13] batmand: Add missing includes and
	remove unused includes
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
 allocate.c          |  1 -
 batman.c            |  7 ++++++-
 batman.h            | 17 ++++++++---------
 bitarray.c          |  3 ---
 bitarray.h          |  1 +
 hna.c               | 10 ++++++++++
 hna.h               |  2 ++
 linux/kernel.c      |  7 ++-----
 linux/route.c       |  8 ++++++++
 linux/tun.c         |  6 +++++-
 list-batman.h       |  2 --
 originator.c        | 10 +++++++++-
 originator.h        |  3 ++-
 os.h                |  7 ++++++-
 packet.h            |  2 ++
 posix/init.c        | 12 ++++++++++--
 posix/posix.c       | 14 ++++++++++++--
 posix/tunnel.c      | 16 +++++++++++-----
 posix/unix_socket.c | 11 ++++++++++-
 profile.c           |  9 ++++++---
 profile.h           |  3 +++
 ring_buffer.c       |  2 +-
 ring_buffer.h       |  3 ---
 schedule.c          |  9 +++++++++
 schedule.h          |  3 +++
 types.h             |  7 +++++++
 26 files changed, 133 insertions(+), 42 deletions(-)

diff --git a/allocate.c b/allocate.c
index beedafe..4196dab 100644
--- a/allocate.c
+++ b/allocate.c
@@ -23,7 +23,6 @@
 
 #include <stdio.h>
 #include <stdlib.h>
-#include <string.h>
 
 #include "os.h"
 #include "allocate.h"
diff --git a/batman.c b/batman.c
index a1e387c..39ef9be 100644
--- a/batman.c
+++ b/batman.c
@@ -25,7 +25,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <stdio.h>
-#include <errno.h>
+#include <netinet/in.h>
 
 #include "os.h"
 #include "batman.h"
@@ -33,6 +33,11 @@
 #include "schedule.h"
 #include "hna.h"
 #include "types.h"
+#include "profile.h"
+#include "allocate.h"
+#include "hash.h"
+#include "bitarray.h"
+#include "packet.h"
 
 
 uint8_t debug_level = 0;
diff --git a/batman.h b/batman.h
index 05c48c1..9a00d1b 100644
--- a/batman.h
+++ b/batman.h
@@ -25,20 +25,15 @@
 #define _BATMAND_BATMAN_H
 
 #include <sys/types.h>
-#include <netinet/in.h>
 #include <pthread.h>
-#include <sys/un.h>
 #include <stdint.h>
-#include <stdio.h>
+#include <sys/select.h>
+#include <sys/un.h>
+#include <netinet/in.h>
 
 #define TYPE_OF_WORD uintmax_t /* you should choose something big, if you don't want to waste cpu */
 
 #include "list-batman.h"
-#include "bitarray.h"
-#include "hash.h"
-#include "allocate.h"
-#include "profile.h"
-#include "ring_buffer.h"
 
 #ifndef SOURCE_VERSION
 #define SOURCE_VERSION "0.4"
@@ -192,7 +187,11 @@ extern uint8_t local_win_size;
 extern uint8_t num_words;
 extern uint8_t aggregation_enabled;
 
-#include "types.h" // can be removed as soon as these function have been cleaned up
+/* fwd declarations */
+struct batman_if;
+struct orig_node;
+struct neigh_node;
+
 int8_t batman(void);
 void usage(void);
 void verbose_usage(void);
diff --git a/bitarray.c b/bitarray.c
index 234f8a8..133f6e7 100644
--- a/bitarray.c
+++ b/bitarray.c
@@ -20,9 +20,6 @@
  */
 
 
-
-#include <stdio.h>              /* printf() */
-
 #include "bitarray.h"
 #include "os.h"
 
diff --git a/bitarray.h b/bitarray.h
index e0ca302..70449a0 100644
--- a/bitarray.h
+++ b/bitarray.h
@@ -22,6 +22,7 @@
 #ifndef _BATMAND_BITARRAY_H
 #define _BATMAND_BITARRAY_H
 
+#include <stdint.h>
 #include "batman.h"
 #define WORD_BIT_SIZE ( sizeof(TYPE_OF_WORD) * 8 )
 
diff --git a/hna.c b/hna.c
index b007ce5..f0d64e1 100644
--- a/hna.c
+++ b/hna.c
@@ -21,13 +21,23 @@
 
 
 
+#include "allocate.h"
 #include "hna.h"
 #include "os.h"
 #include "hash.h"
+#include "packet.h"
+#include "types.h"
 
 #include <errno.h>
+#include <stdio.h>
 #include <stdlib.h>
 #include <arpa/inet.h>
+#include <netinet/in.h>
+#include <pthread.h>
+#include <stddef.h>
+#include <string.h>
+#include <sys/socket.h>
+
 
 
 unsigned char *hna_buff_local = NULL;
diff --git a/hna.h b/hna.h
index 99f7664..e5a6833 100644
--- a/hna.h
+++ b/hna.h
@@ -22,6 +22,8 @@
 #ifndef _BATMAND_HNA_H
 #define _BATMAND_HNA_H
 
+#include <stdint.h>
+#include "list-batman.h"
 #include "batman.h"
 
 
diff --git a/linux/kernel.c b/linux/kernel.c
index 08c7e20..141981d 100644
--- a/linux/kernel.c
+++ b/linux/kernel.c
@@ -22,17 +22,14 @@
 
 
 #include <stdio.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <unistd.h>
+#include <stdint.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
 #include <inttypes.h>
 #include <net/if.h>
+#include <string.h>
 
 #include "../os.h"
-#include "../batman.h"
-
 
 #define IOCGETNWDEV 1
 
diff --git a/linux/route.c b/linux/route.c
index 12f7734..1945d22 100644
--- a/linux/route.c
+++ b/linux/route.c
@@ -29,6 +29,14 @@
 #include <linux/netlink.h>
 #include <linux/rtnetlink.h>
 #include <sys/socket.h>
+#include <netinet/in.h>
+#include <stddef.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/uio.h>
+#include "../allocate.h"
+#include "../bitarray.h"
 
 #include "../os.h"
 #include "../batman.h"
diff --git a/linux/tun.c b/linux/tun.c
index ac5e069..adeea56 100644
--- a/linux/tun.c
+++ b/linux/tun.c
@@ -26,16 +26,20 @@
 #include <errno.h>
 #include <sys/ioctl.h>
 #include <arpa/inet.h>    /* inet_ntop() */
-#include <netinet/ip.h>   /* iph */
+#include <netinet/in.h>
 #include <linux/if_tun.h> /* TUNSETPERSIST, ... */
 #include <linux/if.h>     /* ifr_if, ifr_tun */
 #include <sys/socket.h>
 #include <stdio.h>
 #include <stdlib.h>       /* system() */
 #include <sys/wait.h>     /* WEXITSTATUS */
+#include <stddef.h>
+#include <stdint.h>
+#include <string.h>
 
 #include "../os.h"
 #include "../batman.h"
+#include "../types.h"
 
 #define IPTABLES_ADD_MASQ "iptables -t nat -A POSTROUTING -o %s -j MASQUERADE"
 #define IPTABLES_DEL_MASQ "iptables -t nat -D POSTROUTING -o %s -j MASQUERADE"
diff --git a/list-batman.h b/list-batman.h
index cb97bf5..a0103f1 100644
--- a/list-batman.h
+++ b/list-batman.h
@@ -20,8 +20,6 @@
  */
 
 
-#include <stddef.h> /* offsetof() */
-
 #ifndef _LINUX_LIST_H
 #define _LINUX_LIST_H
 
diff --git a/originator.c b/originator.c
index 7de0e4d..f017741 100644
--- a/originator.c
+++ b/originator.c
@@ -22,12 +22,20 @@
 
 
 #include <string.h>
-#include <stdlib.h>
 #include <stdio.h>
+#include <netinet/in.h>
+#include <stddef.h>
+
+#include "list-batman.h"
+#include "packet.h"
 #include "os.h"
 #include "batman.h"
 #include "originator.h"
 #include "hna.h"
+#include "hash.h"
+#include "profile.h"
+#include "allocate.h"
+#include "ring_buffer.h"
 #include "types.h"
 
 struct neigh_node * create_neighbor(struct orig_node *orig_node, struct orig_node *orig_neigh_node, uint32_t neigh, struct batman_if *if_incoming) {
diff --git a/originator.h b/originator.h
index 5ce5162..0c92150 100644
--- a/originator.h
+++ b/originator.h
@@ -22,7 +22,8 @@
 #ifndef _BATMAND_ORIGINATOR_H
 #define _BATMAND_ORIGINATOR_H
 
-#include "batman.h"
+#include <stdint.h>
+
 #include "types.h"
 
 
diff --git a/os.h b/os.h
index 2272030..cab762c 100644
--- a/os.h
+++ b/os.h
@@ -22,7 +22,12 @@
 #ifndef _BATMAND_OS_H
 #define _BATMAND_OS_H
 
-#include "batman.h"
+#include <stddef.h>
+#include <stdint.h>
+#include <netinet/in.h>
+
+
+#include "types.h"
 
 #ifdef __GNUC_MINOR__
 #define NO_RETURN  __attribute__ ((__noreturn__))
diff --git a/packet.h b/packet.h
index 3a98ea5..cbecd22 100644
--- a/packet.h
+++ b/packet.h
@@ -22,6 +22,8 @@
 #ifndef _BATMAND_PACKET_H
 #define _BATMAND_PACKET_H
 
+#include <stdint.h>
+
 #define COMPAT_VERSION 5
 #define VIS_COMPAT_VERSION 23
 
diff --git a/posix/init.c b/posix/init.c
index 3bc54b0..cb710f2 100644
--- a/posix/init.c
+++ b/posix/init.c
@@ -21,13 +21,13 @@
 
 
 
+#include <stdint.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <stdio.h>
 #include <syslog.h>
 #include <errno.h>
 #include <signal.h>
-#include <paths.h>
 #include <string.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
@@ -35,12 +35,20 @@
 #include <arpa/inet.h>
 #include <fcntl.h>
 #include <getopt.h>
-#include <unistd.h>
+#include <netinet/in.h>
+#include <pthread.h>
+#include <sys/select.h>
+#include <sys/un.h>
 
 
 #include "../os.h"
 #include "../batman.h"
 #include "../hna.h"
+#include "../allocate.h"
+#include "../bitarray.h"
+#include "../list-batman.h"
+#include "../packet.h"
+#include "../types.h"
 
 int8_t stop;
 
diff --git a/posix/posix.c b/posix/posix.c
index 5cdf417..084b40c 100644
--- a/posix/posix.c
+++ b/posix/posix.c
@@ -31,13 +31,23 @@
 #include <syslog.h>
 #include <sys/socket.h>
 #include <sys/times.h>
-#include <sys/ioctl.h>
 #include <sys/wait.h>
-#include <net/if.h>
+#include <netinet/in.h>
+#include <pthread.h>
+#include <stdint.h>
+#include <sys/select.h>
+#include <sys/time.h>
+#include <time.h>
+
 
 #include "../os.h"
 #include "../batman.h"
 #include "../hna.h"
+#include "../allocate.h"
+#include "../hash.h"
+#include "../packet.h"
+#include "../types.h"
+#include "../list-batman.h"
 
 
 #define BAT_LOGO_PRINT(x,y,z) printf( "\x1B[%i;%iH%c", y + 1, x, z )                      /* write char 'z' into column 'x', row 'y' */
diff --git a/posix/tunnel.c b/posix/tunnel.c
index 3290eaa..08c56a2 100644
--- a/posix/tunnel.c
+++ b/posix/tunnel.c
@@ -23,21 +23,27 @@
 
 #include <errno.h>
 #include <unistd.h>
-#include <stdlib.h>
 #include <string.h>
-#include <arpa/inet.h>
-#include <sys/ioctl.h>
 #include <sys/socket.h>
-#include <netinet/in_systm.h>
 #include <netinet/ip.h>
 #include <netinet/udp.h>
-#include <netinet/tcp.h>
 #include <net/if.h>
 #include <fcntl.h>        /* open(), O_RDWR */
+#include <netinet/in.h>
+#include <stddef.h>
+#include <stdint.h>
+#include <sys/select.h>
+#include <sys/time.h>
+#include <sys/types.h>
 
 
 #include "../os.h"
 #include "../batman.h"
+#include "../allocate.h"
+#include "../hash.h"
+#include "../list-batman.h"
+#include "../packet.h"
+#include "../types.h"
 
 
 
diff --git a/posix/unix_socket.c b/posix/unix_socket.c
index 11c96b2..943a652 100644
--- a/posix/unix_socket.c
+++ b/posix/unix_socket.c
@@ -32,11 +32,20 @@
 #include <unistd.h>
 #include <sys/socket.h>
 #include <arpa/inet.h>
-
+#include <netinet/in.h>
+#include <pthread.h>
+#include <stdint.h>
+#include <sys/select.h>
+#include <sys/un.h>
+#include <sys/types.h>
 
 #include "../os.h"
 #include "../batman.h"
 #include "../hna.h"
+#include "../allocate.h"
+#include "../list-batman.h"
+#include "../packet.h"
+#include "../types.h"
 
 
 void debug_output(int8_t debug_prio, const char *format, ...) {
diff --git a/profile.c b/profile.c
index 11d8aa9..9692d7d 100644
--- a/profile.c
+++ b/profile.c
@@ -21,9 +21,12 @@
 
 
 
-#include "os.h"
-#include "batman.h"
 #include <inttypes.h>
+#include <stdint.h>
+#include <time.h>
+
+#include "profile.h"
+#include "os.h"
 
 
 
@@ -78,7 +81,7 @@ void prof_print(void) {
 #else
 
 
-void prof_init( int32_t index, char *name ) {
+void prof_init( int32_t index, const char *name ) {
 
 }
 
diff --git a/profile.h b/profile.h
index e50bf70..07cffc1 100644
--- a/profile.h
+++ b/profile.h
@@ -22,6 +22,9 @@
 #ifndef _BATMAND_PROFILE_H
 #define _BATMAND_PROFILE_H
 
+#include <stdint.h>
+#include <time.h>
+
 enum {
 
 	PROF_choose_gw,
diff --git a/ring_buffer.c b/ring_buffer.c
index 7a0c8c8..45bd175 100644
--- a/ring_buffer.c
+++ b/ring_buffer.c
@@ -20,7 +20,7 @@
  */
 
 
-
+#include "batman.h"
 #include "ring_buffer.h"
 
 
diff --git a/ring_buffer.h b/ring_buffer.h
index c1679d9..b291868 100644
--- a/ring_buffer.h
+++ b/ring_buffer.h
@@ -23,9 +23,6 @@
 #define _BATMAND_RING_BUFFER_H
 
 #include <stdint.h>
-#include "batman.h"
-
-
 
 void ring_buffer_set(uint8_t tq_recv[], uint8_t *tq_index, uint8_t value);
 uint8_t ring_buffer_avg(uint8_t tq_recv[]);
diff --git a/schedule.c b/schedule.c
index 83576c8..3e65d68 100644
--- a/schedule.c
+++ b/schedule.c
@@ -23,6 +23,15 @@
 
 #include <string.h>
 #include <stdlib.h>
+#include <netinet/in.h>
+
+#include "list-batman.h"
+#include "packet.h"
+#include "types.h"
+#include "allocate.h"
+#include "hash.h"
+#include "profile.h"
+#include "bitarray.h"
 #include "os.h"
 #include "batman.h"
 #include "schedule.h"
diff --git a/schedule.h b/schedule.h
index 8bd54cd..30165e3 100644
--- a/schedule.h
+++ b/schedule.h
@@ -22,6 +22,9 @@
 #ifndef _BATMAND_SCHEDULE_H
 #define _BATMAND_SCHEDULE_H
 
+#include <stdint.h>
+#include "types.h"
+
 void schedule_own_packet( struct batman_if *batman_if );
 void schedule_forward_packet(struct orig_node *orig_node, struct bat_packet *in, uint32_t neigh, uint8_t directlink, int16_t hna_buff_len, struct batman_if *if_outgoing, uint32_t curr_time);
 void send_outstanding_packets(uint32_t curr_time);
diff --git a/types.h b/types.h
index 6ae336e..3716b1f 100644
--- a/types.h
+++ b/types.h
@@ -22,7 +22,14 @@
 #ifndef _BATMAND_TYPES_H
 #define _BATMAND_TYPES_H
 
+#include <stdint.h>
+#include <pthread.h>
+#include <sys/un.h>
+#include <netinet/in.h>
+
+#include "list-batman.h"
 #include "packet.h"
+#include "batman.h"
 
 struct orig_node {                /* structure for orig_list maintaining nodes of mesh */
 	uint32_t orig;
-- 
1.8.4.rc3


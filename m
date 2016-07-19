Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 19 Jul 2016 22:44:09 +0200
Message-Id: <1468961051-6447-2-git-send-email-sven@narfation.org>
In-Reply-To: <3501586.3dVhjbZHzy@sven-edge>
References: <3501586.3dVhjbZHzy@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH 2/4] batctl: Use monotonic time source for
	icmp timing
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

gettimeofday is not monotonic. It would give wrong results in some
situation like leap seconds, when switching between daylight saving time
and non-DST, NTP changes the time or when the administrator of the system
changes it manually. The function is also obsolete since POSIX.1-2008.

clock_gettime is recommended to get a monotonic timesource and as general
replacement of gettimeofday.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile    |  2 +-
 functions.c | 17 +++++++++--------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index e980587..57d9a4e 100755
--- a/Makefile
+++ b/Makefile
@@ -46,7 +46,7 @@ MANPAGE = man/batctl.8
 # batctl flags and options
 CFLAGS += -Wall -W -std=gnu99 -fno-strict-aliasing -MD -MP
 CPPFLAGS += -D_GNU_SOURCE
-LDLIBS += -lm
+LDLIBS += -lm -lrt
 
 # disable verbose output
 ifneq ($(findstring $(MAKEFLAGS),s),s)
diff --git a/functions.c b/functions.c
index f9feca4..bc4f9f8 100644
--- a/functions.c
+++ b/functions.c
@@ -48,6 +48,7 @@
 #include <netlink/handlers.h>
 #include <netlink/msg.h>
 #include <netlink/attr.h>
+#include <time.h>
 
 #include "main.h"
 #include "functions.h"
@@ -59,7 +60,7 @@
 
 #define PATH_BUFF_LEN 200
 
-static struct timeval start_time;
+static struct timespec start_time;
 static char *host_name;
 char *line_ptr = NULL;
 
@@ -80,23 +81,23 @@ const char *fs_compile_out_param[] = {
 
 void start_timer(void)
 {
-	gettimeofday(&start_time, NULL);
+	clock_gettime(CLOCK_MONOTONIC, &start_time);
 }
 
 double end_timer(void)
 {
-	struct timeval end_time, diff;
+	struct timespec end_time, diff;
 
-	gettimeofday(&end_time, NULL);
+	clock_gettime(CLOCK_MONOTONIC, &end_time);
 	diff.tv_sec = end_time.tv_sec - start_time.tv_sec;
-	diff.tv_usec = end_time.tv_usec - start_time.tv_usec;
+	diff.tv_nsec = end_time.tv_nsec - start_time.tv_nsec;
 
-	if (diff.tv_usec < 0) {
+	if (diff.tv_nsec < 0) {
 		diff.tv_sec--;
-		diff.tv_usec += 1000000;
+		diff.tv_nsec += 1000000000;
 	}
 
-	return (((double)diff.tv_sec * 1000) + ((double)diff.tv_usec / 1000));
+	return (((double)diff.tv_sec * 1000) + ((double)diff.tv_nsec / 1000000));
 }
 
 char *ether_ntoa_long(const struct ether_addr *addr)
-- 
2.8.1


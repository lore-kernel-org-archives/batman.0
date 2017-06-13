Return-Path: <philipp.psurek@gmail.com>
From: Philipp Psurek <philipp.psurek@gmail.com>
Date: Tue, 13 Jun 2017 10:25:59 +0200
Message-Id: <20170613082600.24910-2-philipp.psurek@gmail.com>
In-Reply-To: <20170613082600.24910-1-philipp.psurek@gmail.com>
References: <1496077749.5980.2.camel@gmail.com>
 <20170613082600.24910-1-philipp.psurek@gmail.com>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batctl: change PATH_BUFF_LEN to maximal
 possible value
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

The output of

snprintf(path_buff, PATH_BUFF_LEN, SYS_ROUTING_ALGO_FMT, iface_dir->d_name)

in sys.c can be between 34 and 289 bytes and should not write into a
destination of size 200.

Signed-off-by: Philipp Psurek <philipp.psurek@gmail.com>
---
 functions.c | 2 +-
 functions.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/functions.c b/functions.c
index 2239440..8337ee8 100644
--- a/functions.c
+++ b/functions.c
@@ -59,7 +59,7 @@
 #include "debugfs.h"
 #include "netlink.h"
 
-#define PATH_BUFF_LEN 200
+#define PATH_BUFF_LEN 289
 
 static struct timespec start_time;
 static char *host_name;
diff --git a/functions.h b/functions.h
index eca1406..c0a02a8 100644
--- a/functions.h
+++ b/functions.h
@@ -31,7 +31,7 @@
 #define ETH_STR_LEN 17
 #define BATMAN_ADV_TAG "batman-adv:"
 
-#define PATH_BUFF_LEN 200
+#define PATH_BUFF_LEN 289
 
 /* return time delta from start to end in milliseconds */
 void start_timer(void);
-- 
2.13.0


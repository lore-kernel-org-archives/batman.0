Return-Path: <philipp.psurek@gmail.com>
Message-ID: <1496461256.22954.9.camel@gmail.com>
From: Philipp Psurek <philipp.psurek@gmail.com>
In-Reply-To: <2479408.89UKcKX64H@prime>
References: <1496077749.5980.2.camel@gmail.com> <2479408.89UKcKX64H@prime>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 03 Jun 2017 05:40:56 +0200
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: change PATH_BUFF_LEN to maximal
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
To: Simon Wunderlich <sw@simonwunderlich.de>, b.a.t.m.a.n@lists.open-mesh.org

'snprintf' output in sys.c can be between 34 and 289 bytes and should
not write into a destination of size 200

snprintf(path_buff, PATH_BUFF_LEN, SYS_ROUTING_ALGO_FMT, iface_dir->d_name);






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

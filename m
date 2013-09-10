Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 10 Sep 2013 23:11:57 +0200
Message-Id: <1378847522-13776-7-git-send-email-sven@narfation.org>
In-Reply-To: <1378847522-13776-1-git-send-email-sven@narfation.org>
References: <1378847522-13776-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 06/11] batctl: Remove legacy types u64 and
	caddr_t
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

The definition of u64 was not obtained from the correct source to always use 64
bit. Instead uint64_t can be used.

Also caddr_t is obsolete BSDism and void* should be used instead.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 ioctl.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/ioctl.c b/ioctl.c
index 26bb482..3d5b50d 100644
--- a/ioctl.c
+++ b/ioctl.c
@@ -30,13 +30,12 @@
 #include <linux/if.h>
 #include <linux/sockios.h>
 #include <linux/ethtool.h>
+#include <stdint.h>
 
 #include "main.h"
 #include "ioctl.h"
 #include "debugfs.h"
 
-typedef unsigned long long u64;
-
 /* code borrowed from ethtool */
 static int statistics_custom_get(int fd, struct ifreq *ifr)
 {
@@ -47,7 +46,7 @@ static int statistics_custom_get(int fd, struct ifreq *ifr)
 	int err, ret = EXIT_FAILURE;
 
 	drvinfo.cmd = ETHTOOL_GDRVINFO;
-	ifr->ifr_data = (caddr_t)&drvinfo;
+	ifr->ifr_data = (void *)&drvinfo;
 	err = ioctl(fd, SIOCETHTOOL, ifr);
 	if (err < 0) {
 		fprintf(stderr, "Error - can't open driver information: %s\n", strerror(errno));
@@ -59,7 +58,7 @@ static int statistics_custom_get(int fd, struct ifreq *ifr)
 		goto success;
 
 	sz_str = n_stats * ETH_GSTRING_LEN;
-	sz_stats = n_stats * sizeof(u64);
+	sz_stats = n_stats * sizeof(uint64_t);
 
 	strings = calloc(1, sz_str + sizeof(struct ethtool_gstrings));
 	stats = calloc(1, sz_stats + sizeof(struct ethtool_stats));
@@ -71,7 +70,7 @@ static int statistics_custom_get(int fd, struct ifreq *ifr)
 	strings->cmd = ETHTOOL_GSTRINGS;
 	strings->string_set = ETH_SS_STATS;
 	strings->len = n_stats;
-	ifr->ifr_data = (caddr_t)strings;
+	ifr->ifr_data = (void *)strings;
 	err = ioctl(fd, SIOCETHTOOL, ifr);
 	if (err < 0) {
 		fprintf(stderr, "Error - can't get stats strings information: %s\n", strerror(errno));
@@ -80,7 +79,7 @@ static int statistics_custom_get(int fd, struct ifreq *ifr)
 
 	stats->cmd = ETHTOOL_GSTATS;
 	stats->n_stats = n_stats;
-	ifr->ifr_data = (caddr_t) stats;
+	ifr->ifr_data = (void *) stats;
 	err = ioctl(fd, SIOCETHTOOL, ifr);
 	if (err < 0) {
 		fprintf(stderr, "Error - can't get stats information: %s\n", strerror(errno));
-- 
1.8.4.rc3


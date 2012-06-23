Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 23 Jun 2012 11:49:50 +0200
Message-Id: <1340444990-5171-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1340444873-5063-1-git-send-email-lindner_marek@yahoo.de>
References: <1340444873-5063-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: purge redundant statistic code
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 ioctl.c |   51 ---------------------------------------------------
 1 files changed, 0 insertions(+), 51 deletions(-)

diff --git a/ioctl.c b/ioctl.c
index 92ffdb3..5056d2f 100644
--- a/ioctl.c
+++ b/ioctl.c
@@ -37,53 +37,6 @@
 
 typedef unsigned long long u64;
 
-const char proc_net_dev_path[] = "/proc/net/dev";
-
-static int statistics_common_get(char *mesh_iface)
-{
-	FILE *fp;
-	char iface[IFNAMSIZ + 1], *line_ptr = NULL;;
-	unsigned long long rx_bytes, rx_packets, tx_bytes, tx_packets;
-	unsigned long tx_errors;
-	size_t len = 0;
-	int res, ret = EXIT_FAILURE;
-
-	rx_bytes = rx_packets = tx_bytes = tx_packets = tx_errors = 0;
-
-	fp = fopen(proc_net_dev_path, "r");
-	if (!fp) {
-		printf("Error - can't open '%s' for read: %s\n",
-		       proc_net_dev_path, strerror(errno));
-		goto out;
-	}
-
-	while (getline(&line_ptr, &len, fp) != -1) {
-		res = sscanf(line_ptr, " %" STR(IFNAMSIZ) "[^: \t]: %llu %llu %*d %*d %*d %*d %*d %*d %llu %llu %lu\n",
-			     iface, &rx_bytes, &rx_packets, &tx_bytes, &tx_packets, &tx_errors);
-
-		if (res != 6)
-			continue;
-
-		if (strcmp(iface, mesh_iface) != 0)
-			continue;
-
-		printf("\t%.*s: %llu\n", ETH_GSTRING_LEN, "tx", tx_packets);
-		printf("\t%.*s: %llu\n", ETH_GSTRING_LEN, "tx_bytes", tx_bytes);
-		printf("\t%.*s: %lu\n", ETH_GSTRING_LEN, "tx_errors", tx_errors);
-		printf("\t%.*s: %llu\n", ETH_GSTRING_LEN, "rx", rx_packets);
-		printf("\t%.*s: %llu\n", ETH_GSTRING_LEN, "rx_bytes", rx_bytes);
-		ret = EXIT_SUCCESS;
-		goto out;
-	}
-
-	printf("Error - interface '%s' not found\n", mesh_iface);
-
-out:
-	fclose(fp);
-	free(line_ptr);
-	return ret;
-}
-
 /* code borrowed from ethtool */
 static int statistics_custom_get(int fd, struct ifreq *ifr)
 {
@@ -162,10 +115,6 @@ int ioctl_statistics_get(char *mesh_iface)
 		goto out;
 	}
 
-	ret = statistics_common_get(mesh_iface);
-	if (ret != EXIT_SUCCESS)
-		goto out;
-
 	ret = statistics_custom_get(fd, &ifr);
 
 out:
-- 
1.7.9.1


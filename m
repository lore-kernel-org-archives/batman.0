Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 2/2] alfred: Drop deprecated sysfs support
Date: Sat, 31 Oct 2020 18:39:12 +0100
Message-Id: <20201031173912.108591-2-sven@narfation.org>
In-Reply-To: <20201031173912.108591-1-sven@narfation.org>
References: <20201031173912.108591-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Sven Eckelmann <sven@narfation.org>

The sysfs support is disabled by default in batman-adv since a while and
will be removed in 2021. The generic netlink interface should be used
instead.

The alfred support for it should be removed with the same release as the
removal in batman-adv.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 vis/vis.c | 50 ++++----------------------------------------------
 vis/vis.h |  3 ---
 2 files changed, 4 insertions(+), 49 deletions(-)

diff --git a/vis/vis.c b/vis/vis.c
index b62359c..1bb82ab 100644
--- a/vis/vis.c
+++ b/vis/vis.c
@@ -36,39 +36,6 @@ struct vis_netlink_opts {
 	struct nlquery_opts query_opts;
 };
 
-static char *read_file(char *fname)
-{
-	FILE *fp;
-	char *buf = NULL, *buf_tmp;
-	size_t size, ret;
-
-	fp = fopen(fname, "r");
-
-	if (!fp)
-		return NULL;
-
-	size = 0;
-	while (!feof(fp)) {
-
-		buf_tmp = realloc(buf, size + 4097);
-		if (!buf_tmp) {
-			free(buf);
-			fclose(fp);
-			return NULL;
-		}
-
-		buf = buf_tmp;
-		ret = fread(buf + size, 1, 4096, fp);
-		size += ret;
-	}
-	fclose(fp);
-
-	if (buf)
-		buf[size] = 0;
-
-	return buf;
-}
-
 static char *mac_to_str(uint8_t *mac)
 {
 	static char macstr[20];
@@ -443,26 +410,17 @@ err_free_sock:
 	return ret_status;
 }
 
-static bool interface_active(unsigned int meshif, unsigned int hardif,
-			     const char *ifname)
+static bool interface_active(unsigned int meshif, unsigned int hardif)
 {
 	char iface_status[IFACE_STATUS_LEN];
-	char path_buff[PATH_BUFF_LEN];
 	char *file_content = NULL;
 	char *content_newline;
 	bool active = false;
 	char *status;
 
 	status = get_iface_status_netlink(meshif, hardif, iface_status);
-	if (!status) {
-		snprintf(path_buff, sizeof(path_buff), SYS_IFACE_STATUS_FMT,
-			 ifname);
-		file_content = read_file(path_buff);
-		if (!file_content)
-			return false;
-
-		status = file_content;
-	}
+	if (!status)
+		return false;
 
 	content_newline = strstr(status, "\n");
 	if (content_newline)
@@ -518,7 +476,7 @@ static int register_interfaces_rtnl_parse(struct nl_msg *msg, void *arg)
 	if (master != register_arg->ifindex)
 		goto err;
 
-	if (!interface_active(master, ifm->ifi_index, ifname))
+	if (!interface_active(master, ifm->ifi_index))
 		goto err;
 
 	get_if_index_byname(register_arg->globals, ifname);
diff --git a/vis/vis.h b/vis/vis.h
index bed6615..6f5b839 100644
--- a/vis/vis.h
+++ b/vis/vis.h
@@ -23,9 +23,6 @@
 #define	VIS_PACKETVERSION			1
 #define UPDATE_INTERVAL				10
 
-#define SYS_IFACE_PATH				"/sys/class/net"
-#define SYS_IFACE_STATUS_FMT			SYS_IFACE_PATH"/%s/batman_adv/iface_status"
-
 
 enum opmode {
 	OPMODE_SERVER,
-- 
2.28.0


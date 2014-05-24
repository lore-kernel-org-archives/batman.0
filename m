Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 24 May 2014 14:16:40 +0200
Message-Id: <1400933804-9661-2-git-send-email-sven@narfation.org>
In-Reply-To: <1400933804-9661-1-git-send-email-sven@narfation.org>
References: <1400933804-9661-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/6] batctl: Force null termination of string
	after strncpy
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

strncpy doesn't terminate the string with a '\0' character when the length
of the destination memory location was shorter than the source string.
Accessing it again with string related functions isn't safe after such a
semi-failed copy and the caller has to handle it. The easiest way is to
always set the last character in the destination buffer to '\0' after the
strncpy was called.

Also the length provided as argument of strncpy should not be the length of
the source buffer but the maximum number of bytes in the destination buffer.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bat-hosts.c | 6 ++++--
 bisect_iv.c | 2 ++
 debugfs.c   | 1 +
 functions.c | 8 ++++----
 tcpdump.c   | 2 ++
 5 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/bat-hosts.c b/bat-hosts.c
index 30ff848..1d62bb8 100644
--- a/bat-hosts.c
+++ b/bat-hosts.c
@@ -108,7 +108,8 @@ static void parse_hosts_file(struct hashtable_t **hash, const char path[], int r
 			if (read_opt & USE_BAT_HOSTS)
 				fprintf(stderr, "Warning - mac already known (changing name from '%s' to '%s'): %s\n",
 					bat_host->name, name, mac_str);
-			strncpy(bat_host->name, name, HOST_NAME_MAX_LEN - 1);
+			strncpy(bat_host->name, name, HOST_NAME_MAX_LEN);
+			bat_host->name[HOST_NAME_MAX_LEN - 1] = '\0';
 			continue;
 		}
 
@@ -132,7 +133,8 @@ static void parse_hosts_file(struct hashtable_t **hash, const char path[], int r
 		}
 
 		memcpy(&bat_host->mac_addr, mac_addr, sizeof(struct ether_addr));
-		strncpy(bat_host->name, name, HOST_NAME_MAX_LEN - 1);
+		strncpy(bat_host->name, name, HOST_NAME_MAX_LEN);
+		bat_host->name[HOST_NAME_MAX_LEN - 1] = '\0';
 
 		hash_add(*hash, bat_host);
 
diff --git a/bisect_iv.c b/bisect_iv.c
index 0c25664..e9e7326 100644
--- a/bisect_iv.c
+++ b/bisect_iv.c
@@ -91,6 +91,7 @@ static struct bat_node *node_get(char *name)
 	}
 
 	strncpy(bat_node->name, name, NAME_LEN);
+	bat_node->name[NAME_LEN] = '\0';
 	INIT_LIST_HEAD_FIRST(bat_node->orig_event_list);
 	INIT_LIST_HEAD_FIRST(bat_node->rt_table_list);
 	memset(bat_node->loop_magic, 0, sizeof(bat_node->loop_magic));
@@ -1438,6 +1439,7 @@ static int get_orig_addr(char *orig_name, char *orig_addr)
 
 copy_name:
 	strncpy(orig_addr, orig_name_tmp, NAME_LEN);
+	orig_addr[NAME_LEN - 1] = '\0';
 	return 1;
 
 err:
diff --git a/debugfs.c b/debugfs.c
index 8033f8b..8dd78b1 100644
--- a/debugfs.c
+++ b/debugfs.c
@@ -149,6 +149,7 @@ char *debugfs_mount(const char *mountpoint)
 
 	/* save the mountpoint */
 	strncpy(debugfs_mountpoint, mountpoint, sizeof(debugfs_mountpoint));
+	debugfs_mountpoint[sizeof(debugfs_mountpoint) - 1] = '\0';
 	debugfs_found = 1;
 
 	return debugfs_mountpoint;
diff --git a/functions.c b/functions.c
index 0f96cb8..84f0d14 100644
--- a/functions.c
+++ b/functions.c
@@ -199,8 +199,8 @@ int read_file(const char *dir, const char *fname, int read_opt,
 	if (read_opt & USE_BAT_HOSTS)
 		bat_hosts_init(read_opt);
 
-	strncpy(full_path, dir, strlen(dir));
-	full_path[strlen(dir)] = '\0';
+	strncpy(full_path, dir, sizeof(full_path));
+	full_path[sizeof(full_path) - 1] = '\0';
 	strncat(full_path, fname, sizeof(full_path) - strlen(full_path) - 1);
 
 open:
@@ -339,8 +339,8 @@ int write_file(const char *dir, const char *fname, const char *arg1,
 	char full_path[500];
 	ssize_t write_len;
 
-	strncpy(full_path, dir, strlen(dir));
-	full_path[strlen(dir)] = '\0';
+	strncpy(full_path, dir, sizeof(full_path));
+	full_path[sizeof(full_path) - 1] = '\0';
 	strncat(full_path, fname, sizeof(full_path) - strlen(full_path) - 1);
 
 	fd = open(full_path, O_WRONLY);
diff --git a/tcpdump.c b/tcpdump.c
index 10b18f2..e84617e 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -865,6 +865,7 @@ int tcpdump(int argc, char **argv)
 
 		memset(&req, 0, sizeof (struct ifreq));
 		strncpy(req.ifr_name, dump_if->dev, IFNAMSIZ);
+		req.ifr_name[sizeof(req.ifr_name) - 1] = '\0';
 
 		res = ioctl(dump_if->raw_sock, SIOCGIFHWADDR, &req);
 		if (res < 0) {
@@ -887,6 +888,7 @@ int tcpdump(int argc, char **argv)
 
 		memset(&req, 0, sizeof (struct ifreq));
 		strncpy(req.ifr_name, dump_if->dev, IFNAMSIZ);
+		req.ifr_name[sizeof(req.ifr_name) - 1] = '\0';
 
 		res = ioctl(dump_if->raw_sock, SIOCGIFINDEX, &req);
 
-- 
2.0.0.rc2


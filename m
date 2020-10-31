Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 2/3] batctl: Drop deprecated debugfs support
Date: Sat, 31 Oct 2020 19:40:49 +0100
Message-Id: <20201031184051.118630-2-sven@narfation.org>
In-Reply-To: <20201031184051.118630-1-sven@narfation.org>
References: <20201031184051.118630-1-sven@narfation.org>
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

The debugfs support is disabled by default in batman-adv since a while and
will be removed in 2021. The generic netlink interface should be used
instead.

The batctl support for it should be removed with the same release as the
removal in batman-adv.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile          |   2 -
 README.rst        |  10 ++--
 backbonetable.c   |   2 -
 claimtable.c      |   2 -
 dat_cache.c       |   2 -
 debug.c           |  27 +--------
 debug.h           |  11 ----
 debugfs.c         | 140 ----------------------------------------------
 debugfs.h         |  25 ---------
 functions.c       | 130 +++---------------------------------------
 functions.h       |   3 +-
 gateways.c        |   2 -
 gw_mode.c         |   6 +-
 icmp_helper.c     |   1 -
 interface.c       |   3 +-
 loglevel.c        |   2 +-
 main.c            |   2 +-
 man/batctl.8      |   7 +--
 mcast_flags.c     |   2 -
 nc_nodes.c        |  18 ------
 neighbors.c       |   2 -
 originators.c     |   2 -
 routing_algo.c    |  20 +------
 sys.c             |   2 +-
 throughputmeter.c |   1 -
 transglobal.c     |   2 -
 translocal.c      |   2 -
 27 files changed, 25 insertions(+), 403 deletions(-)
 delete mode 100644 debugfs.c
 delete mode 100644 debugfs.h
 delete mode 100644 nc_nodes.c

diff --git a/Makefile b/Makefile
index 780c2c0..71fdf88 100755
--- a/Makefile
+++ b/Makefile
@@ -13,7 +13,6 @@ export CONFIG_BATCTL_BISECT=n
 BINARY_NAME = batctl
 
 obj-y += bat-hosts.o
-obj-y += debugfs.o
 obj-y += debug.o
 obj-y += functions.o
 obj-y += genl.o
@@ -58,7 +57,6 @@ $(eval $(call add_command,mcast_flags,y))
 $(eval $(call add_command,multicast_fanout,y))
 $(eval $(call add_command,multicast_forceflood,y))
 $(eval $(call add_command,multicast_mode,y))
-$(eval $(call add_command,nc_nodes,y))
 $(eval $(call add_command,neighbors,y))
 $(eval $(call add_command,network_coding,y))
 $(eval $(call add_command,orig_interval,y))
diff --git a/README.rst b/README.rst
index 4830347..9c55ad5 100644
--- a/README.rst
+++ b/README.rst
@@ -18,11 +18,11 @@ settings.
 How does it work ?
 ==================
 
-batctl uses the debugfs/batman_adv/bat0/socket device provided by the B.A.T.M.A.N.
-advanced kernel module to inject custom icmp packets into the data flow. That's why
-ping and traceroute work almost like their IP based counterparts. Tcpdump was
-designed because B.A.T.M.A.N. advanced encapsulates all traffic within batman
-packets, so that the normal tcpdump would not recognize the packets.
+batctl uses the raw packet sockets to inject custom icmp packets into the data
+flow. That's why ping and traceroute work almost like their IP based
+counterparts. Tcpdump was designed because B.A.T.M.A.N. advanced encapsulates
+all traffic within batman packets, so that the normal tcpdump would not
+recognize the packets.
 
 
 The bat-hosts file
diff --git a/backbonetable.c b/backbonetable.c
index 4774edf..84667c4 100644
--- a/backbonetable.c
+++ b/backbonetable.c
@@ -102,8 +102,6 @@ static int netlink_print_bla_backbone(struct state *state, char *orig_iface,
 }
 
 static struct debug_table_data batctl_debug_table_backbonetable = {
-	.debugfs_name = DEBUG_BACKBONETABLE,
-	.header_lines = 2,
 	.netlink_fn = netlink_print_bla_backbone,
 };
 
diff --git a/claimtable.c b/claimtable.c
index c4664d4..c41d9c3 100644
--- a/claimtable.c
+++ b/claimtable.c
@@ -107,8 +107,6 @@ static int netlink_print_bla_claim(struct state *state, char *orig_iface,
 }
 
 static struct debug_table_data batctl_debug_table_claimtable = {
-	.debugfs_name = DEBUG_CLAIMTABLE,
-	.header_lines = 2,
 	.netlink_fn = netlink_print_bla_claim,
 };
 
diff --git a/dat_cache.c b/dat_cache.c
index a2fee2a..1549c3d 100644
--- a/dat_cache.c
+++ b/dat_cache.c
@@ -123,8 +123,6 @@ static int netlink_print_dat_cache(struct state *state, char *orig_iface,
 }
 
 static struct debug_table_data batctl_debug_table_dat_cache = {
-	.debugfs_name = DEBUG_DAT_CACHE,
-	.header_lines = 2,
 	.netlink_fn = netlink_print_dat_cache,
 };
 
diff --git a/debug.c b/debug.c
index 66ddc3b..55520cb 100644
--- a/debug.c
+++ b/debug.c
@@ -13,7 +13,6 @@
 #include <errno.h>
 
 #include "debug.h"
-#include "debugfs.h"
 #include "functions.h"
 #include "netlink.h"
 #include "sys.h"
@@ -47,8 +46,6 @@ int handle_debug_table(struct state *state, int argc, char **argv)
 {
 	struct debug_table_data *debug_table = state->cmd->arg;
 	int optchar, read_opt = USE_BAT_HOSTS;
-	char full_path[MAX_PATH+1];
-	char *debugfs_mnt;
 	char *orig_iface = NULL;
 	float orig_timeout = 0.0f;
 	float watch_interval = 1;
@@ -147,25 +144,7 @@ int handle_debug_table(struct state *state, int argc, char **argv)
 		return EXIT_FAILURE;
 	}
 
-	debugfs_mnt = debugfs_mount(NULL);
-	if (!debugfs_mnt) {
-		fprintf(stderr, "Error - can't mount or find debugfs\n");
-		return EXIT_FAILURE;
-	}
-
-	if (debug_table->netlink_fn) {
-		err = debug_table->netlink_fn(state , orig_iface, read_opt,
-					      orig_timeout, watch_interval);
-		if (err != -EOPNOTSUPP)
-			return err;
-	}
-
-	if (orig_iface)
-		debugfs_make_path(DEBUG_BATIF_PATH_FMT "/", orig_iface, full_path, sizeof(full_path));
-	else
-		debugfs_make_path(DEBUG_BATIF_PATH_FMT "/", state->mesh_iface, full_path, sizeof(full_path));
-
-	return read_file(full_path, debug_table->debugfs_name,
-			 read_opt, orig_timeout, watch_interval,
-			 debug_table->header_lines);
+	err = debug_table->netlink_fn(state , orig_iface, read_opt,
+				      orig_timeout, watch_interval);
+	return err;
 }
diff --git a/debug.h b/debug.h
index 9d0bb92..f849d19 100644
--- a/debug.h
+++ b/debug.h
@@ -12,18 +12,7 @@
 #include <stddef.h>
 #include "main.h"
 
-#define DEBUG_BATIF_PATH_FMT "%s/batman_adv/%s"
-#define DEBUG_TRANSTABLE_GLOBAL "transtable_global"
-#define DEBUG_BACKBONETABLE "bla_backbone_table"
-#define DEBUG_CLAIMTABLE "bla_claim_table"
-#define DEBUG_DAT_CACHE "dat_cache"
-#define DEBUG_NC_NODES "nc_nodes"
-#define DEBUG_MCAST_FLAGS "mcast_flags"
-#define DEBUG_ROUTING_ALGOS "routing_algos"
-
 struct debug_table_data {
-	const char *debugfs_name;
-	size_t header_lines;
 	int (*netlink_fn)(struct state *state, char *hard_iface, int read_opt,
 			 float orig_timeout, float watch_interval);
 	unsigned int option_unicast_only:1;
diff --git a/debugfs.c b/debugfs.c
deleted file mode 100644
index 5a71d65..0000000
--- a/debugfs.c
+++ /dev/null
@@ -1,140 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009 Clark Williams <williams@redhat.com>
- * Copyright (C) 2009 Xiao Guangrong <xiaoguangrong@cn.fujitsu.com>
- *
- * License-Filename: LICENSES/preferred/GPL-2.0
- */
-
-#include "debugfs.h"
-#include <errno.h>
-#include <stdio.h>
-#include <string.h>
-#include <sys/mount.h>
-#include <sys/stat.h>
-#include <sys/statfs.h>
-
-#ifndef DEBUGFS_MAGIC
-#define DEBUGFS_MAGIC          0x64626720
-#endif
-
-static int debugfs_premounted;
-static char debugfs_mountpoint[MAX_PATH+1];
-
-static const char *debugfs_find_mountpoint(void);
-static int debugfs_valid_mountpoint(const char *debugfs);
-
-static const char *debugfs_known_mountpoints[] = {
-	"/sys/kernel/debug/",
-	"/debug/",
-	NULL,
-};
-
-/* construct a full path to a debugfs element */
-int debugfs_make_path(const char *fmt, const char *mesh_iface, char *buffer,
-		      int size)
-{
-	if (strlen(debugfs_mountpoint) == 0) {
-		buffer[0] = '\0';
-		return -1;
-	}
-
-	return snprintf(buffer, size, fmt, debugfs_mountpoint, mesh_iface);
-}
-
-static int debugfs_found;
-
-/* find the path to the mounted debugfs */
-static const char *debugfs_find_mountpoint(void)
-{
-	const char **ptr;
-	char type[100];
-	FILE *fp;
-
-	if (debugfs_found)
-		return (const char *)debugfs_mountpoint;
-
-	ptr = debugfs_known_mountpoints;
-	while (*ptr) {
-		if (debugfs_valid_mountpoint(*ptr) == 0) {
-			debugfs_found = 1;
-			strncpy(debugfs_mountpoint, *ptr,
-				sizeof(debugfs_mountpoint));
-			debugfs_mountpoint[sizeof(debugfs_mountpoint) - 1] = 0;
-			return debugfs_mountpoint;
-		}
-		ptr++;
-	}
-
-	/* give up and parse /proc/mounts */
-	fp = fopen("/proc/mounts", "r");
-	if (fp == NULL) {
-		perror("Error - can't open /proc/mounts for read");
-		return NULL;
-	}
-
-	while (fscanf(fp, "%*s %"
-		      STR(MAX_PATH)
-		      "s %99s %*s %*d %*d\n",
-		      debugfs_mountpoint, type) == 2) {
-		if (strcmp(type, "debugfs") == 0)
-			break;
-	}
-	fclose(fp);
-
-	if (strcmp(type, "debugfs") != 0)
-		return NULL;
-
-	debugfs_found = 1;
-
-	return debugfs_mountpoint;
-}
-
-/* verify that a mountpoint is actually a debugfs instance */
-
-static int debugfs_valid_mountpoint(const char *debugfs)
-{
-	struct statfs st_fs;
-
-	if (statfs(debugfs, &st_fs) < 0)
-		return -ENOENT;
-	else if (st_fs.f_type != (long) DEBUGFS_MAGIC)
-		return -ENOENT;
-
-	return 0;
-}
-
-
-int debugfs_valid_entry(const char *path)
-{
-	struct stat st;
-
-	if (stat(path, &st))
-		return -errno;
-
-	return 0;
-}
-
-/* mount the debugfs somewhere if it's not mounted */
-
-char *debugfs_mount(const char *mountpoint)
-{
-	/* see if it's already mounted */
-	if (debugfs_find_mountpoint()) {
-		debugfs_premounted = 1;
-		return debugfs_mountpoint;
-	}
-
-	/* if not mounted and no argument */
-	if (mountpoint == NULL)
-		mountpoint = "/sys/kernel/debug";
-
-	if (mount(NULL, mountpoint, "debugfs", 0, NULL) < 0)
-		return NULL;
-
-	/* save the mountpoint */
-	strncpy(debugfs_mountpoint, mountpoint, sizeof(debugfs_mountpoint));
-	debugfs_mountpoint[sizeof(debugfs_mountpoint) - 1] = '\0';
-	debugfs_found = 1;
-
-	return debugfs_mountpoint;
-}
diff --git a/debugfs.h b/debugfs.h
deleted file mode 100644
index 61384f9..0000000
--- a/debugfs.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2009 Clark Williams <williams@redhat.com>
- * Copyright (C) 2009 Xiao Guangrong <xiaoguangrong@cn.fujitsu.com>
- *
- * License-Filename: LICENSES/preferred/GPL-2.0
- */
-
-#ifndef __DEBUGFS_H__
-#define __DEBUGFS_H__
-
-#ifndef MAX_PATH
-# define MAX_PATH 256
-#endif
-
-#ifndef STR
-# define _STR(x) #x
-# define STR(x) _STR(x)
-#endif
-
-extern int debugfs_valid_entry(const char *path);
-extern char *debugfs_mount(const char *mountpoint);
-extern int debugfs_make_path(const char *fmt, const char *mesh_iface,
-			     char *buffer, int size);
-
-#endif /* __DEBUGFS_H__ */
diff --git a/functions.c b/functions.c
index 3223472..651fb1d 100644
--- a/functions.c
+++ b/functions.c
@@ -43,7 +43,6 @@
 #include "bat-hosts.h"
 #include "sys.h"
 #include "debug.h"
-#include "debugfs.h"
 #include "netlink.h"
 
 #define PATH_BUFF_LEN 400
@@ -140,14 +139,6 @@ static void file_open_problem_dbg(const char *dir, const char *full_path)
 	fprintf(stderr, "Consult the README if you wish to learn more about compiling options into batman-adv.\n");
 }
 
-static int str_is_mcast_addr(char *addr)
-{
-	struct ether_addr *mac_addr = ether_aton(addr);
-
-	return !mac_addr ? 0 :
-		mac_addr->ether_addr_octet[0] & 0x01;
-}
-
 static bool ether_addr_valid(const uint8_t *addr)
 {
 	/* no multicast address */
@@ -171,67 +162,28 @@ static void print_inv_bool(char *line)
 		printf("%s", line);
 }
 
-int read_file(const char *dir, const char *fname, int read_opt,
-	      float orig_timeout, float watch_interval, size_t header_lines)
+int read_file(const char *dir, const char *fname, int read_opt)
 {
-	struct ether_addr *mac_addr;
-	struct bat_host *bat_host;
 	int res = EXIT_FAILURE;
-	float last_seen;
-	char full_path[500], *buff_ptr, *space_ptr, extra_char;
+	char full_path[500];
 	size_t len = 0;
 	FILE *fp = NULL;
-	size_t line;
-
-	if (read_opt & USE_BAT_HOSTS)
-		bat_hosts_init(read_opt);
 
 	snprintf(full_path, sizeof(full_path), "%s%s", dir, fname);
 
-open:
-	line = 0;
 	fp = fopen(full_path, "r");
-
 	if (!fp) {
 		if (!(read_opt & SILENCE_ERRORS))
 			file_open_problem_dbg(dir, full_path);
 
-		goto out;
+		return res;
 	}
 
-	if (read_opt & CLR_CONT_READ)
-		/* clear screen, set cursor back to 0,0 */
-		printf("\033[2J\033[0;0f");
-
-read:
 	while (getline(&line_ptr, &len, fp) != -1) {
-		if (line++ < header_lines && read_opt & SKIP_HEADER)
-			continue;
-
 		/* the buffer will be handled elsewhere */
 		if (read_opt & USE_READ_BUFF)
 			break;
 
-		/* skip timed out originators */
-		if (read_opt & NO_OLD_ORIGS)
-			if (sscanf(line_ptr, "%*s %f", &last_seen)
-			    && (last_seen > orig_timeout))
-				continue;
-
-		/* translation table: skip multicast */
-		if (line > header_lines &&
-		    read_opt & UNICAST_ONLY &&
-		    strlen(line_ptr) > strlen(" * xx:xx:xx:") &&
-		    str_is_mcast_addr(line_ptr+3))
-			continue;
-
-		/* translation table: skip unicast */
-		if (line > header_lines &&
-		    read_opt & MULTICAST_ONLY &&
-		    strlen(line_ptr) > strlen(" * xx:xx:xx:") &&
-		    !str_is_mcast_addr(line_ptr+3))
-			continue;
-
 		if (!(read_opt & USE_BAT_HOSTS)) {
 			if (read_opt & INVERSE_BOOL)
 				print_inv_bool(line_ptr);
@@ -241,81 +193,13 @@ int read_file(const char *dir, const char *fname, int read_opt,
 			continue;
 		}
 
-		/* replace mac addresses with bat host names */
-		buff_ptr = line_ptr;
-
-		while ((space_ptr = strchr(buff_ptr, ' ')) != NULL) {
-
-			*space_ptr = '\0';
-			extra_char = '\0';
-
-			if (strlen(buff_ptr) == ETH_STR_LEN + 1) {
-				extra_char = buff_ptr[ETH_STR_LEN];
-				switch (extra_char) {
-				case ',':
-				case ')':
-					buff_ptr[ETH_STR_LEN] = '\0';
-					break;
-				default:
-					extra_char = '\0';
-					break;
-				}
-			}
-
-			if (strlen(buff_ptr) != ETH_STR_LEN)
-				goto print_plain_buff;
-
-			mac_addr = ether_aton(buff_ptr);
-
-			if (!mac_addr)
-				goto print_plain_buff;
-
-			bat_host = bat_hosts_find_by_mac((char *)mac_addr);
-
-			if (!bat_host)
-				goto print_plain_buff;
-
-			/* keep table format */
-			printf("%17s", bat_host->name);
-
-			goto written;
-
-print_plain_buff:
-			printf("%s", buff_ptr);
-
-written:
-			if (extra_char != '\0')
-				printf("%c", extra_char);
-
-			printf(" ");
-			buff_ptr = space_ptr + 1;
-		}
-
-		printf("%s", buff_ptr);
-	}
-
-	if (read_opt & CONT_READ) {
-		usleep(1000000 * watch_interval);
-		goto read;
-	}
-
-	if (read_opt & CLR_CONT_READ) {
-		if (fp)
-			fclose(fp);
-		usleep(1000000 * watch_interval);
-		goto open;
+		printf("%s", line_ptr);
 	}
 
 	if (line_ptr)
 		res = EXIT_SUCCESS;
 
-out:
-	if (fp)
-		fclose(fp);
-
-	if (read_opt & USE_BAT_HOSTS)
-		bat_hosts_free();
-
+	fclose(fp);
 	return res;
 }
 
@@ -391,7 +275,7 @@ int get_algoname(const char *mesh_iface, char *algoname, size_t algoname_len)
 	}
 
 	snprintf(path_buff, PATH_BUFF_LEN, SYS_ROUTING_ALGO_FMT, mesh_iface);
-	ret = read_file("", path_buff, USE_READ_BUFF | SILENCE_ERRORS, 0, 0, 0);
+	ret = read_file("", path_buff, USE_READ_BUFF | SILENCE_ERRORS);
 	if (ret != EXIT_SUCCESS) {
 		ret = -ENOENT;
 		goto free_path_buf;
@@ -1129,7 +1013,7 @@ static int check_mesh_iface_ownership_sysfs(struct state *state,
 
 	/* check if this device actually belongs to the mesh interface */
 	snprintf(path_buff, sizeof(path_buff), SYS_MESH_IFACE_FMT, hard_iface);
-	res = read_file("", path_buff, USE_READ_BUFF | SILENCE_ERRORS, 0, 0, 0);
+	res = read_file("", path_buff, USE_READ_BUFF | SILENCE_ERRORS);
 	if (res != EXIT_SUCCESS) {
 		fprintf(stderr, "Error - the directory '%s' could not be read: %s\n",
 			path_buff, strerror(errno));
diff --git a/functions.h b/functions.h
index b2180e8..f63c438 100644
--- a/functions.h
+++ b/functions.h
@@ -43,8 +43,7 @@ char *ether_ntoa_long(const struct ether_addr *addr);
 char *get_name_by_macaddr(struct ether_addr *mac_addr, int read_opt);
 char *get_name_by_macstr(char *mac_str, int read_opt);
 int file_exists(const char *fpath);
-int read_file(const char *dir, const char *path, int read_opt,
-	      float orig_timeout, float watch_interval, size_t header_lines);
+int read_file(const char *dir, const char *path, int read_opt);
 int write_file(const char *dir, const char *fname, const char *arg1,
 	       const char *arg2);
 struct ether_addr *translate_mac(const char *mesh_iface,
diff --git a/gateways.c b/gateways.c
index 2db4b17..31979a2 100644
--- a/gateways.c
+++ b/gateways.c
@@ -145,8 +145,6 @@ static int netlink_print_gateways(struct state *state, char *orig_iface,
 }
 
 static struct debug_table_data batctl_debug_table_gateways = {
-	.debugfs_name = "gateways",
-	.header_lines = 1,
 	.netlink_fn = netlink_print_gateways,
 };
 
diff --git a/gw_mode.c b/gw_mode.c
index beaa83f..72b5fbf 100644
--- a/gw_mode.c
+++ b/gw_mode.c
@@ -266,7 +266,7 @@ static int gw_read_setting(struct state *state, const char *path_buff)
 		return EXIT_SUCCESS;
 
 	/* fallback to sysfs */
-	res = read_file(path_buff, SYS_GW_MODE, USE_READ_BUFF, 0, 0, 0);
+	res = read_file(path_buff, SYS_GW_MODE, USE_READ_BUFF);
 	if (res != EXIT_SUCCESS)
 		goto out;
 
@@ -285,10 +285,10 @@ static int gw_read_setting(struct state *state, const char *path_buff)
 
 	switch (gw_mode) {
 	case BATADV_GW_MODE_CLIENT:
-		res = read_file(path_buff, SYS_GW_SEL, USE_READ_BUFF, 0, 0, 0);
+		res = read_file(path_buff, SYS_GW_SEL, USE_READ_BUFF);
 		break;
 	case BATADV_GW_MODE_SERVER:
-		res = read_file(path_buff, SYS_GW_BW, USE_READ_BUFF, 0, 0, 0);
+		res = read_file(path_buff, SYS_GW_BW, USE_READ_BUFF);
 		break;
 	default:
 		printf("off\n");
diff --git a/icmp_helper.c b/icmp_helper.c
index 0ce2d17..a167e2a 100644
--- a/icmp_helper.c
+++ b/icmp_helper.c
@@ -28,7 +28,6 @@
 
 #include "batadv_packet.h"
 #include "debug.h"
-#include "debugfs.h"
 #include "functions.h"
 #include "list.h"
 #include "netlink.h"
diff --git a/interface.c b/interface.c
index d0d9435..34381de 100644
--- a/interface.c
+++ b/interface.c
@@ -168,8 +168,7 @@ static int print_interfaces_rtnl_parse(struct nl_msg *msg, void *arg)
 	if (!status) {
 		snprintf(path_buff, sizeof(path_buff), SYS_IFACE_STATUS_FMT,
 			 ifname);
-		ret = read_file("", path_buff, USE_READ_BUFF | SILENCE_ERRORS,
-				0, 0, 0);
+		ret = read_file("", path_buff, USE_READ_BUFF | SILENCE_ERRORS);
 		if (ret != EXIT_SUCCESS)
 			status = "<error reading status>\n";
 		else
diff --git a/loglevel.c b/loglevel.c
index 69f1855..1e4b690 100644
--- a/loglevel.c
+++ b/loglevel.c
@@ -96,7 +96,7 @@ static int log_level_read_setting(struct state *state, const char *path_buff)
 	if (res >= 0)
 		return EXIT_SUCCESS;
 
-	res = read_file(path_buff, SYS_LOG_LEVEL, USE_READ_BUFF, 0, 0, 0);
+	res = read_file(path_buff, SYS_LOG_LEVEL, USE_READ_BUFF);
 	if (res != EXIT_SUCCESS)
 		return res;
 
diff --git a/main.c b/main.c
index f6337d6..6ea589a 100644
--- a/main.c
+++ b/main.c
@@ -123,7 +123,7 @@ static void version(void)
 
 	printf("batctl %s [batman-adv: ", SOURCE_VERSION);
 
-	ret = read_file("", module_ver_path, USE_READ_BUFF | SILENCE_ERRORS, 0, 0, 0);
+	ret = read_file("", module_ver_path, USE_READ_BUFF | SILENCE_ERRORS);
 	if ((line_ptr) && (line_ptr[strlen(line_ptr) - 1] == '\n'))
 		line_ptr[strlen(line_ptr) - 1] = '\0';
 
diff --git a/man/batctl.8 b/man/batctl.8
index 1737e17..012741c 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -241,9 +241,7 @@ Example 3: 16 or 0x0F
 .I \fBdebug tables:
 .IP
 The batman-adv kernel module comes with a variety of debug tables containing various information about the state of the mesh
-seen by each individual node. These tables are exported via debugfs and easily accessible via batctl. You will need debugfs
-support compiled into your kernel and preferably have mounted the debugfs to a well-known mountpoint. If debugfs is not
-mounted batctl will attempt to do this step for you.
+seen by each individual node.
 
 All of the debug tables support the following options:
 .RS 10
@@ -290,9 +288,6 @@ List of debug tables:
 \- dat_cache|dc (compile time option)
 .RE
 .RS 10
-\- nc_nodes|nn (compile time option)
-.RE
-.RS 10
 \- mcast_flags|mf (compile time option)
 .RE
 .RE
diff --git a/mcast_flags.c b/mcast_flags.c
index 363b6e8..63a2c50 100644
--- a/mcast_flags.c
+++ b/mcast_flags.c
@@ -154,8 +154,6 @@ static int netlink_print_mcast_flags(struct state *state, char *orig_iface,
 }
 
 static struct debug_table_data batctl_debug_table_mcast_flags = {
-	.debugfs_name = DEBUG_MCAST_FLAGS,
-	.header_lines = 6,
 	.netlink_fn = netlink_print_mcast_flags,
 };
 
diff --git a/nc_nodes.c b/nc_nodes.c
deleted file mode 100644
index be4e804..0000000
--- a/nc_nodes.c
+++ /dev/null
@@ -1,18 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
- *
- * Marek Lindner <mareklindner@neomailbox.ch>
- *
- * License-Filename: LICENSES/preferred/GPL-2.0
- */
-
-#include "debug.h"
-#include "main.h"
-
-static struct debug_table_data batctl_debug_table_nc_nodes = {
-	.debugfs_name = DEBUG_NC_NODES,
-	.header_lines = 0,
-};
-
-COMMAND_NAMED(DEBUGTABLE, nc_nodes, "nn", handle_debug_table,
-	      COMMAND_FLAG_MESH_IFACE, &batctl_debug_table_nc_nodes, "");
diff --git a/neighbors.c b/neighbors.c
index dc6913a..afc65de 100644
--- a/neighbors.c
+++ b/neighbors.c
@@ -118,8 +118,6 @@ static int netlink_print_neighbors(struct state *state, char *orig_iface,
 }
 
 static struct debug_table_data batctl_debug_table_neighbors = {
-	.debugfs_name = "neighbors",
-	.header_lines = 2,
 	.netlink_fn = netlink_print_neighbors,
 };
 
diff --git a/originators.c b/originators.c
index f9bf21d..793743a 100644
--- a/originators.c
+++ b/originators.c
@@ -196,8 +196,6 @@ static int netlink_print_originators(struct state *state, char *orig_iface,
 }
 
 static struct debug_table_data batctl_debug_table_originators = {
-	.debugfs_name = "originators",
-	.header_lines = 2,
 	.netlink_fn = netlink_print_originators,
 	.option_timeout_interval = 1,
 	.option_orig_iface = 1,
diff --git a/routing_algo.c b/routing_algo.c
index 5fa360b..0f2e1bb 100644
--- a/routing_algo.c
+++ b/routing_algo.c
@@ -19,7 +19,6 @@
 #include "batadv_packet.h"
 #include "batman_adv.h"
 #include "debug.h"
-#include "debugfs.h"
 #include "functions.h"
 #include "main.h"
 #include "netlink.h"
@@ -133,28 +132,11 @@ static int netlink_print_routing_algos(void)
 	return last_err;
 }
 
-static int debug_print_routing_algos(void)
-{
-	char full_path[MAX_PATH+1];
-	char *debugfs_mnt;
-
-	debugfs_mnt = debugfs_mount(NULL);
-	if (!debugfs_mnt) {
-		fprintf(stderr, "Error - can't mount or find debugfs\n");
-		return -1;
-	}
-
-	debugfs_make_path(DEBUG_BATIF_PATH_FMT, "", full_path, sizeof(full_path));
-	return read_file(full_path, DEBUG_ROUTING_ALGOS, 0, 0, 0, 0);
-}
-
 static int print_routing_algos(void)
 {
 	int err;
 
 	err = netlink_print_routing_algos();
-	if (err == -EOPNOTSUPP)
-		err = debug_print_routing_algos();
 	return err;
 }
 
@@ -303,7 +285,7 @@ static int routing_algo(struct state *state __maybe_unused, int argc, char **arg
 
 	print_ra_interfaces();
 
-	res = read_file("", SYS_SELECTED_RA_PATH, USE_READ_BUFF, 0, 0, 0);
+	res = read_file("", SYS_SELECTED_RA_PATH, USE_READ_BUFF);
 	if (res != EXIT_SUCCESS)
 		return EXIT_FAILURE;
 
diff --git a/sys.c b/sys.c
index c76ad15..7668a72 100644
--- a/sys.c
+++ b/sys.c
@@ -208,7 +208,7 @@ static int sys_read_setting(struct state *state, const char *path_buff,
 		if (state->cmd->flags & COMMAND_FLAG_INVERSE)
 			read_opt |= INVERSE_BOOL;
 
-		res = read_file(path_buff, sysfs_name, read_opt, 0, 0, 0);
+		res = read_file(path_buff, sysfs_name, read_opt);
 	}
 
 	return res;
diff --git a/throughputmeter.c b/throughputmeter.c
index 0ec5c31..4a233d5 100644
--- a/throughputmeter.c
+++ b/throughputmeter.c
@@ -32,7 +32,6 @@
 #include "functions.h"
 #include "genl.h"
 #include "netlink.h"
-#include "debugfs.h"
 
 static struct ether_addr *dst_mac;
 static char *tp_mesh_iface;
diff --git a/transglobal.c b/transglobal.c
index 3b23792..5aede41 100644
--- a/transglobal.c
+++ b/transglobal.c
@@ -136,8 +136,6 @@ static int netlink_print_transglobal(struct state *state, char *orig_iface,
 }
 
 static struct debug_table_data batctl_debug_table_transglobal = {
-	.debugfs_name = "transtable_global",
-	.header_lines = 2,
 	.netlink_fn = netlink_print_transglobal,
 	.option_unicast_only = 1,
 	.option_multicast_only = 1,
diff --git a/translocal.c b/translocal.c
index 59c00c2..45e884c 100644
--- a/translocal.c
+++ b/translocal.c
@@ -132,8 +132,6 @@ static int netlink_print_translocal(struct state *state, char *orig_iface,
 }
 
 static struct debug_table_data batctl_debug_table_translocal = {
-	.debugfs_name = "transtable_local",
-	.header_lines = 2,
 	.netlink_fn = netlink_print_translocal,
 	.option_unicast_only = 1,
 	.option_multicast_only = 1,
-- 
2.28.0


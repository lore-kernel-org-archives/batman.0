Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 1/2] alfred: Drop deprecated debugfs support
Date: Sat, 31 Oct 2020 18:39:11 +0100
Message-Id: <20201031173912.108591-1-sven@narfation.org>
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

The alfred support for it should be removed with the same release as the
removal in batman-adv.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile       |   1 -
 README.rst     |   7 +-
 batadv_query.c | 204 +------------------------------------------------
 debugfs.c      | 140 ---------------------------------
 debugfs.h      |  25 ------
 main.c         |   4 -
 vis/Makefile   |   1 -
 vis/debugfs.c  |   1 -
 vis/debugfs.h  |   1 -
 vis/vis.c      | 167 +---------------------------------------
 vis/vis.h      |   1 -
 11 files changed, 5 insertions(+), 547 deletions(-)
 delete mode 100644 debugfs.c
 delete mode 100644 debugfs.h
 delete mode 120000 vis/debugfs.c
 delete mode 120000 vis/debugfs.h

diff --git a/Makefile b/Makefile
index 2bfe18c..6268cb9 100755
--- a/Makefile
+++ b/Makefile
@@ -11,7 +11,6 @@ BINARY_NAME = alfred
 OBJ += batadv_query.o
 OBJ += batadv_querynl.o
 OBJ += client.o
-OBJ += debugfs.o
 OBJ += hash.o
 OBJ += main.o
 OBJ += netlink.o
diff --git a/README.rst b/README.rst
index bf5fb05..2bc2119 100644
--- a/README.rst
+++ b/README.rst
@@ -290,7 +290,7 @@ Operations requiring special capabilities:
 
 * bind to device
 * creating the unix socket
-* accessing the debugfs filesystem
+* accessing the netlink interface
 
 The first operation can still be executed when the admin grants the special
 capability CAP_NET_RAW+CAP_NET_ADMIN to anyone executing the alfred binary.
@@ -300,11 +300,6 @@ directory which can be accessed by the user::
   $ sudo setcap cap_net_admin,cap_net_raw+ep alfred
   $ ./alfred -u alfred.sock -i eth0
 
-The user running alfred must still be in a group which is allowed to access
-/sys/kernel/debugfs to correctly choose best neighbors for communication.
-It is possible (but not recommended) to disable the neighbor
-selection/prioritization using the parameter '-b none'.
-
 
 License
 =======
diff --git a/batadv_query.c b/batadv_query.c
index f758b42..66d3452 100644
--- a/batadv_query.c
+++ b/batadv_query.c
@@ -22,11 +22,6 @@
 #include <sys/types.h>
 
 #include "batadv_querynl.h"
-#include "debugfs.h"
-
-#define DEBUG_BATIF_PATH_FMT "%s/batman_adv/%s"
-#define DEBUG_TRANSTABLE_GLOBAL "transtable_global"
-#define DEBUG_ORIGINATORS "originators"
 
 static int enable_net_admin_capability(int enable)
 {
@@ -135,36 +130,6 @@ int ipv4_to_mac(struct interface *interface,
 	return 0;
 }
 
-static int batadv_interface_check_debugfs(const char *mesh_iface)
-{
-	char full_path[MAX_PATH + 1];
-	FILE *f;
-
-	debugfs_make_path(DEBUG_BATIF_PATH_FMT "/" DEBUG_TRANSTABLE_GLOBAL,
-			  mesh_iface, full_path, sizeof(full_path));
-	f = fopen(full_path, "r");
-	if (!f) {
-		fprintf(stderr,
-			"Could not find %s for interface %s. Make sure it is a valid batman-adv soft-interface\n",
-			DEBUG_TRANSTABLE_GLOBAL, mesh_iface);
-		return -1;
-	}
-	fclose(f);
-
-	debugfs_make_path(DEBUG_BATIF_PATH_FMT "/" DEBUG_ORIGINATORS,
-			  mesh_iface, full_path, sizeof(full_path));
-	f = fopen(full_path, "r");
-	if (!f) {
-		fprintf(stderr,
-			"Could not find %s for interface %s. Make sure it is a valid batman-adv soft-interface\n",
-			DEBUG_ORIGINATORS, mesh_iface);
-		return -1;
-	}
-	fclose(f);
-
-	return 0;
-}
-
 int batadv_interface_check(const char *mesh_iface)
 {
 	int ret;
@@ -173,86 +138,9 @@ int batadv_interface_check(const char *mesh_iface)
 	ret = batadv_interface_check_netlink(mesh_iface);
 	enable_net_admin_capability(0);
 
-	if (ret == -EOPNOTSUPP)
-		ret = batadv_interface_check_debugfs(mesh_iface);
-
 	return ret;
 }
 
-static int translate_mac_debugfs(const char *mesh_iface,
-				 struct hashtable_t *tg_hash)
-{
-	enum {
-		tg_start,
-		tg_mac,
-		tg_via,
-		tg_originator,
-	} pos;
-	char full_path[MAX_PATH+1];
-	struct ether_addr *mac_tmp;
-	struct ether_addr mac;
-	FILE *f = NULL;
-	size_t len = 0;
-	char *line = NULL;
-	char *input, *saveptr, *token;
-	int line_invalid;
-
-	debugfs_make_path(DEBUG_BATIF_PATH_FMT "/" DEBUG_TRANSTABLE_GLOBAL,
-			  mesh_iface, full_path, sizeof(full_path));
-
-	f = fopen(full_path, "r");
-	if (!f)
-		return -EOPNOTSUPP;
-
-	while (getline(&line, &len, f) != -1) {
-		line_invalid = 0;
-		pos = tg_start;
-		input = line;
-
-		while ((token = strtok_r(input, " \t", &saveptr))) {
-			input = NULL;
-
-			switch (pos) {
-			case tg_start:
-				if (strcmp(token, "*") != 0)
-					line_invalid = 1;
-				else
-					pos = tg_mac;
-				break;
-			case tg_mac:
-				mac_tmp = ether_aton(token);
-				if (!mac_tmp) {
-					line_invalid = 1;
-				} else {
-					memcpy(&mac, mac_tmp, sizeof(mac));
-					pos = tg_via;
-				}
-				break;
-			case tg_via:
-				if (strcmp(token, "via") == 0)
-					pos = tg_originator;
-				break;
-			case tg_originator:
-				mac_tmp = ether_aton(token);
-				if (!mac_tmp)
-					line_invalid = 1;
-				else
-					tg_hash_add(tg_hash, &mac, mac_tmp);
-				break;
-			}
-
-			if (line_invalid)
-				break;
-		}
-	}
-
-	if (f)
-		fclose(f);
-	free(line);
-
-	return 0;
-}
-
 static int tg_compare(void *d1, void *d2)
 {
 	struct tg_entry *s1 = d1, *s2 = d2;
@@ -285,19 +173,15 @@ static int tg_choose(void *d1, int size)
 struct hashtable_t *tg_hash_new(const char *mesh_iface)
 {
 	struct hashtable_t *tg_hash;
-	int ret;
 
 	tg_hash = hash_new(64, tg_compare, tg_choose);
 	if (!tg_hash)
 		return NULL;
 
 	enable_net_admin_capability(1);
-	ret = translate_mac_netlink(mesh_iface, tg_hash);
+	translate_mac_netlink(mesh_iface, tg_hash);
 	enable_net_admin_capability(0);
 
-	if (ret == -EOPNOTSUPP)
-		translate_mac_debugfs(mesh_iface, tg_hash);
-
 	return tg_hash;
 }
 
@@ -341,86 +225,6 @@ struct ether_addr *translate_mac(struct hashtable_t *tg_hash,
 	return &found->originator;
 }
 
-static int get_tq_debugfs(const char *mesh_iface, struct hashtable_t *orig_hash)
-{
-	enum {
-		orig_mac,
-		orig_lastseen,
-		orig_tqstart,
-		orig_tqvalue,
-	} pos;
-	char full_path[MAX_PATH + 1];
-	struct ether_addr *mac_tmp;
-	FILE *f = NULL;
-	size_t len = 0;
-	char *line = NULL;
-	char *input, *saveptr, *token;
-	int line_invalid;
-	uint8_t tq;
-
-	debugfs_make_path(DEBUG_BATIF_PATH_FMT "/" DEBUG_ORIGINATORS,
-			  mesh_iface, full_path, sizeof(full_path));
-
-	f = fopen(full_path, "r");
-	if (!f)
-		return -EOPNOTSUPP;
-
-	while (getline(&line, &len, f) != -1) {
-		line_invalid = 0;
-		pos = orig_mac;
-		input = line;
-
-		while ((token = strtok_r(input, " \t", &saveptr))) {
-			input = NULL;
-
-			switch (pos) {
-			case orig_mac:
-				mac_tmp = ether_aton(token);
-				if (!mac_tmp)
-					line_invalid = 1;
-				else
-					pos = orig_lastseen;
-				break;
-			case orig_lastseen:
-				pos = orig_tqstart;
-				break;
-			case orig_tqstart:
-				if (strlen(token) == 0) {
-					line_invalid = 1;
-					break;
-				} else if (token[0] != '(') {
-					line_invalid = 1;
-					break;
-				} else if (strlen(token) == 1) {
-					pos = orig_tqvalue;
-					break;
-				}
-
-				token++;
-				/* fall through */
-			case orig_tqvalue:
-				if (token[strlen(token) - 1] != ')') {
-					line_invalid = 1;
-				} else {
-					token[strlen(token) - 1] = '\0';
-					tq = strtol(token, NULL, 10);
-					orig_hash_add(orig_hash, mac_tmp, tq);
-				}
-				break;
-			}
-
-			if (line_invalid)
-				break;
-		}
-	}
-
-	if (f)
-		fclose(f);
-	free(line);
-
-	return 0;
-}
-
 static int orig_compare(void *d1, void *d2)
 {
 	struct orig_entry *s1 = d1, *s2 = d2;
@@ -453,19 +257,15 @@ static int orig_choose(void *d1, int size)
 struct hashtable_t *orig_hash_new(const char *mesh_iface)
 {
 	struct hashtable_t *orig_hash;
-	int ret;
 
 	orig_hash = hash_new(64, orig_compare, orig_choose);
 	if (!orig_hash)
 		return NULL;
 
 	enable_net_admin_capability(1);
-	ret = get_tq_netlink(mesh_iface, orig_hash);
+	get_tq_netlink(mesh_iface, orig_hash);
 	enable_net_admin_capability(0);
 
-	if (ret == -EOPNOTSUPP)
-		get_tq_debugfs(mesh_iface, orig_hash);
-
 	return orig_hash;
 }
 
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
diff --git a/main.c b/main.c
index b498d1e..5ae8187 100644
--- a/main.c
+++ b/main.c
@@ -18,7 +18,6 @@
 #include <unistd.h>
 #endif
 #include "alfred.h"
-#include "debugfs.h"
 #include "packet.h"
 #include "list.h"
 
@@ -167,9 +166,6 @@ static struct globals *alfred_init(int argc, char *argv[])
 		{NULL,			0,			NULL,	0},
 	};
 
-	/* We need full capabilities to mount debugfs, so do that now */
-	debugfs_mount(NULL);
-
 	ret = reduce_capabilities();
 	if (ret < 0)
 		return NULL;
diff --git a/vis/Makefile b/vis/Makefile
index cfd0921..50c8efb 100755
--- a/vis/Makefile
+++ b/vis/Makefile
@@ -8,7 +8,6 @@
 
 # batadv-vis build
 BINARY_NAME = batadv-vis
-OBJ += debugfs.o
 OBJ += netlink.o
 OBJ += vis.o
 MANPAGE = man/batadv-vis.8
diff --git a/vis/debugfs.c b/vis/debugfs.c
deleted file mode 120000
index 45fb24d..0000000
--- a/vis/debugfs.c
+++ /dev/null
@@ -1 +0,0 @@
-../debugfs.c
\ No newline at end of file
diff --git a/vis/debugfs.h b/vis/debugfs.h
deleted file mode 120000
index 094e733..0000000
--- a/vis/debugfs.h
+++ /dev/null
@@ -1 +0,0 @@
-../debugfs.h
\ No newline at end of file
diff --git a/vis/vis.c b/vis/vis.c
index 17e067e..b62359c 100644
--- a/vis/vis.c
+++ b/vis/vis.c
@@ -26,7 +26,6 @@
 
 #include "batman_adv.h"
 #include "netlink.h"
-#include "debugfs.h"
 
 #define IFACE_STATUS_LEN 256
 
@@ -78,25 +77,6 @@ static char *mac_to_str(uint8_t *mac)
 	return macstr;
 }
 
-static uint8_t *str_to_mac(char *str)
-{
-	static uint8_t mac[ETH_ALEN];
-	int ret;
-
-	if (!str)
-		return NULL;
-
-	ret = sscanf(str,
-		"%02hhX:%02hhX:%02hhX:%02hhX:%02hhX:%02hhX",
-		&mac[0], &mac[1], &mac[2],
-		&mac[3], &mac[4], &mac[5]);
-	
-	if (ret != 6)
-		return NULL;
-	
-	return mac;
-}
-
 static int get_if_mac(char *ifname, uint8_t *mac)
 {
 	struct ifreq ifr;
@@ -274,7 +254,7 @@ static int parse_transtable_local_netlink_cb(struct nl_msg *msg, void *arg)
 	return NL_OK;
 }
 
-static int parse_transtable_local_netlink(struct globals *globals)
+static int parse_transtable_local(struct globals *globals)
 {
 	struct vis_netlink_opts opts = {
 		.globals = globals,
@@ -294,69 +274,6 @@ static int parse_transtable_local_netlink(struct globals *globals)
 	return 0;
 }
 
-static int parse_transtable_local_debugfs(struct globals *globals)
-{
-	char *fbuf;
-	char *lptr, *tptr;
-	char *temp1, *temp2;
-	int lnum, tnum;
-	uint8_t *mac;
-	struct vis_list_entry *v_entry;
-	char path[1024];
-
-	debugfs_make_path(DEBUG_BATIF_PATH_FMT "/" "transtable_local", globals->interface, path, sizeof(path));
-	path[sizeof(path) - 1] = 0;
-
-	fbuf = read_file(path);
-	if (!fbuf)
-		return -1;
-
-	for (lptr = fbuf, lnum = 0; ; lptr = NULL, lnum++) {
-		lptr = strtok_r(lptr, "\n", &temp1);
-		if (!lptr)
-			break;
-
-		if (lnum < 1)
-			continue;
-
-		for (tptr = lptr, tnum = 0;; tptr = NULL, tnum++) {
-			tptr = strtok_r(tptr, "\t ", &temp2);
-			if (!tptr)
-				break;
-			if (tnum == 1) {
-				v_entry = malloc(sizeof(*v_entry));
-				if (!v_entry)
-					continue;
-
-				mac = str_to_mac(tptr);
-				if (!mac) {
-					free(v_entry);
-					continue;
-				}
-
-				memcpy(v_entry->v.mac, mac, ETH_ALEN);
-				v_entry->v.ifindex = 255;
-				v_entry->v.qual = 0;
-				list_add_tail(&v_entry->list, &globals->entry_list);
-			}
-		}
-	}
-	free(fbuf);
-
-	return 0;
-}
-
-static int parse_transtable_local(struct globals *globals)
-{
-	int ret;
-
-	ret = parse_transtable_local_netlink(globals);
-	if (ret != -EOPNOTSUPP)
-		return ret;
-
-	return parse_transtable_local_debugfs(globals);
-}
-
 static void clear_lists(struct globals *globals)
 {
 	struct vis_list_entry *v_entry, *v_entry_safe;
@@ -693,7 +610,7 @@ static int parse_orig_list_netlink_cb(struct nl_msg *msg, void *arg)
 	return NL_OK;
 }
 
-static int parse_orig_list_netlink(struct globals *globals)
+static int parse_orig_list(struct globals *globals)
 {
 	struct vis_netlink_opts opts = {
 		.globals = globals,
@@ -712,84 +629,6 @@ static int parse_orig_list_netlink(struct globals *globals)
 	return 0;
 }
 
-static int parse_orig_list_debugfs(struct globals *globals)
-{
-	char *fbuf;
-	char *lptr, *tptr;
-	char *temp1, *temp2;
-	char *dest, *tq, *neigh, *iface;
-	int lnum, tnum, ifindex, tq_val;
-	uint8_t *mac;
-	char path[1024];
-	struct vis_list_entry *v_entry;
-
-	debugfs_make_path(DEBUG_BATIF_PATH_FMT "/" "originators", globals->interface, path, sizeof(path));
-	fbuf = read_file(path);
-	if (!fbuf)
-		return -1;
-
-	for (lptr = fbuf, lnum = 0; ; lptr = NULL, lnum++) {
-		lptr = strtok_r(lptr, "\n", &temp1);
-		if (!lptr)
-			break;
-		if (lnum < 2)
-			continue;
-
-		for (tptr = lptr, tnum = 0;; tptr = NULL, tnum++) {
-			tptr = strtok_r(tptr, "\t []()", &temp2);
-			if (!tptr)
-				break;
-			switch (tnum) {
-			case 0: dest = tptr; break;
-			case 2: tq = tptr; break;
-			case 3: neigh = tptr; break;
-			case 4: iface = tptr; break;
-			default: break;
-			}
-		}
-		if (tnum > 4) {
-			if (strcmp(dest, neigh) == 0) {
-				tq_val = strtol(tq, NULL, 10);
-				if (tq_val < 1 || tq_val > 255)
-					continue;
-
-				mac = str_to_mac(dest);
-				if (!mac)
-					continue;
-
-				ifindex = get_if_index_byname(globals, iface);
-				if (ifindex < 0)
-					continue;
-
-				v_entry = malloc(sizeof(*v_entry));
-				if (!v_entry)
-					continue;
-
-				memcpy(v_entry->v.mac, mac, ETH_ALEN);
-				v_entry->v.ifindex = ifindex;
-				v_entry->v.qual = tq_val;
-				list_add_tail(&v_entry->list, &globals->entry_list);
-				
-			}
-		}
-
-	}
-	free(fbuf);
-
-	return 0;
-}
-
-static int parse_orig_list(struct globals *globals)
-{
-	int ret;
-
-	ret = parse_orig_list_netlink(globals);
-	if (ret != -EOPNOTSUPP)
-		return ret;
-
-	return parse_orig_list_debugfs(globals);
-}
-
 static int vis_publish_data(struct globals *globals)
 {
 	int len, ret;
@@ -1296,8 +1135,6 @@ static struct globals *vis_init(int argc, char *argv[])
 
 static int vis_server(struct globals *globals)
 {
-	debugfs_mount(NULL);
-
 	globals->push = (struct alfred_push_data_v0 *) globals->buf;
 	globals->vis_data = (struct vis_v1 *) (globals->buf + sizeof(*globals->push) + sizeof(struct alfred_data));
 
diff --git a/vis/vis.h b/vis/vis.h
index 43d2974..bed6615 100644
--- a/vis/vis.h
+++ b/vis/vis.h
@@ -24,7 +24,6 @@
 #define UPDATE_INTERVAL				10
 
 #define SYS_IFACE_PATH				"/sys/class/net"
-#define DEBUG_BATIF_PATH_FMT			"%s/batman_adv/%s"
 #define SYS_IFACE_STATUS_FMT			SYS_IFACE_PATH"/%s/batman_adv/iface_status"
 
 
-- 
2.28.0


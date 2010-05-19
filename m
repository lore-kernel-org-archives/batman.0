Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 19 May 2010 21:43:51 +0200
Message-Id: <1274298233-21487-2-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <201005192141.32752.sven.eckelmann@gmx.de>
References: <201005192141.32752.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/4] batctl: Use socket in debugfs instead of
	batman-adv device
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

The batman-adv device which was only usable for a single batX net device
was replaced with a file in debugfs which can be used the same way as
/dev/batman-adv before.

It seems that the debugfs has no 100% common mount path in current
distributions and maybe isn't mounted at all. So before we try to access
a batman file in debugfs, we have to search for the mountpoint in
/proc/mounts and maybe mount it manually in /sys/kernel/debug.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
Please apply on top of batctl-0.2.x branch.

 Makefile     |    4 +-
 debugfs.c    |  269 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 debugfs.h    |   46 ++++++++++
 main.h       |    2 +-
 ping.c       |   21 ++++-
 traceroute.c |   21 ++++-
 6 files changed, 350 insertions(+), 13 deletions(-)
 create mode 100644 debugfs.c
 create mode 100644 debugfs.h

diff --git a/Makefile b/Makefile
index 8a3021c..ff877ea 100644
--- a/Makefile
+++ b/Makefile
@@ -39,8 +39,8 @@ SRC_FILES = "\(\.c\)\|\(\.h\)\|\(Makefile\)\|\(INSTALL\)\|\(LIESMICH\)\|\(README
 EXTRA_MODULES_C := bisect.c
 EXTRA_MODULES_H := bisect.h
 
-SRC_C = main.c bat-hosts.c functions.c sys.c ping.c traceroute.c tcpdump.c list-batman.c hash.c vis.c $(EXTRA_MODULES_C)
-SRC_H = main.h bat-hosts.h functions.h sys.h ping.h traceroute.h tcpdump.h list-batman.h hash.h allocate.h vis.h $(EXTRA_MODULES_H)
+SRC_C = main.c bat-hosts.c functions.c sys.c ping.c traceroute.c tcpdump.c list-batman.c hash.c vis.c debugfs.c $(EXTRA_MODULES_C)
+SRC_H = main.h bat-hosts.h functions.h sys.h ping.h traceroute.h tcpdump.h list-batman.h hash.h allocate.h vis.h debugfs.h $(EXTRA_MODULES_H)
 SRC_O = $(SRC_C:.c=.o)
 
 PACKAGE_NAME = batctl
diff --git a/debugfs.c b/debugfs.c
new file mode 100644
index 0000000..cfe1254
--- /dev/null
+++ b/debugfs.c
@@ -0,0 +1,269 @@
+/*
+ * Copyright (C) 2009 Clark Williams <williams@redhat.com>
+ * Copyright (C) 2009 Xiao Guangrong <xiaoguangrong@cn.fujitsu.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA
+ *
+ */
+
+#include "debugfs.h"
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <linux/magic.h>
+#include <sys/vfs.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+
+#ifndef DEBUGFS_MAGIC
+#define DEBUGFS_MAGIC          0x64626720
+#endif
+
+static int debugfs_premounted;
+static char debugfs_mountpoint[MAX_PATH+1];
+
+static const char *debugfs_known_mountpoints[] = {
+	"/sys/kernel/debug/",
+	"/debug/",
+	0,
+};
+
+/* use this to force a umount */
+void debugfs_force_cleanup(void)
+{
+	debugfs_find_mountpoint();
+	debugfs_premounted = 0;
+	debugfs_umount();
+}
+
+/* construct a full path to a debugfs element */
+int debugfs_make_path(const char *element, char *buffer, int size)
+{
+	int len;
+
+	if (strlen(debugfs_mountpoint) == 0) {
+		buffer[0] = '\0';
+		return -1;
+	}
+
+	len = strlen(debugfs_mountpoint) + strlen(element) + 1;
+	if (len >= size)
+		return len+1;
+
+	snprintf(buffer, size-1, "%s/%s", debugfs_mountpoint, element);
+	return 0;
+}
+
+static int debugfs_found;
+
+/* find the path to the mounted debugfs */
+const char *debugfs_find_mountpoint(void)
+{
+	const char **ptr;
+	char type[100];
+	FILE *fp;
+
+	if (debugfs_found)
+		return (const char *) debugfs_mountpoint;
+
+	ptr = debugfs_known_mountpoints;
+	while (*ptr) {
+		if (debugfs_valid_mountpoint(*ptr) == 0) {
+			debugfs_found = 1;
+			strcpy(debugfs_mountpoint, *ptr);
+			return debugfs_mountpoint;
+		}
+		ptr++;
+	}
+
+	/* give up and parse /proc/mounts */
+	fp = fopen("/proc/mounts", "r");
+	if (fp == NULL) {
+		printf("Error - can't open /proc/mounts for read: %s\n",
+		       strerror(errno));
+		return NULL;
+	}
+
+	while (fscanf(fp, "%*s %"
+		      STR(MAX_PATH)
+		      "s %99s %*s %*d %*d\n",
+		      debugfs_mountpoint, type) == 2) {
+		if (strcmp(type, "debugfs") == 0)
+			break;
+	}
+	fclose(fp);
+
+	if (strcmp(type, "debugfs") != 0)
+		return NULL;
+
+	debugfs_found = 1;
+
+	return debugfs_mountpoint;
+}
+
+/* verify that a mountpoint is actually a debugfs instance */
+
+int debugfs_valid_mountpoint(const char *debugfs)
+{
+	struct statfs st_fs;
+
+	if (statfs(debugfs, &st_fs) < 0)
+		return -ENOENT;
+	else if (st_fs.f_type != (long) DEBUGFS_MAGIC)
+		return -ENOENT;
+
+	return 0;
+}
+
+
+int debugfs_valid_entry(const char *path)
+{
+	struct stat st;
+
+	if (stat(path, &st))
+		return -errno;
+
+	return 0;
+}
+
+/* mount the debugfs somewhere if it's not mounted */
+
+char *debugfs_mount(const char *mountpoint)
+{
+	/* see if it's already mounted */
+	if (debugfs_find_mountpoint()) {
+		debugfs_premounted = 1;
+		return debugfs_mountpoint;
+	}
+
+	/* if not mounted and no argument */
+	if (mountpoint == NULL)
+		mountpoint = "/sys/kernel/debug";
+
+	if (mount(NULL, mountpoint, "debugfs", 0, NULL) < 0)
+		return NULL;
+
+	/* save the mountpoint */
+	strncpy(debugfs_mountpoint, mountpoint, sizeof(debugfs_mountpoint));
+	debugfs_found = 1;
+
+	return debugfs_mountpoint;
+}
+
+/* umount the debugfs */
+
+int debugfs_umount(void)
+{
+	char umountcmd[128];
+	int ret;
+
+	/* if it was already mounted, leave it */
+	if (debugfs_premounted)
+		return 0;
+
+	/* make sure it's a valid mount point */
+	ret = debugfs_valid_mountpoint(debugfs_mountpoint);
+	if (ret)
+		return ret;
+
+	snprintf(umountcmd, sizeof(umountcmd),
+		 "/bin/umount %s", debugfs_mountpoint);
+	return system(umountcmd);
+}
+
+int debugfs_write(const char *entry, const char *value)
+{
+	char path[MAX_PATH+1];
+	int ret, count;
+	int fd;
+
+	/* construct the path */
+	snprintf(path, sizeof(path), "%s/%s", debugfs_mountpoint, entry);
+
+	/* verify that it exists */
+	ret = debugfs_valid_entry(path);
+	if (ret)
+		return ret;
+
+	/* get how many chars we're going to write */
+	count = strlen(value);
+
+	/* open the debugfs entry */
+	fd = open(path, O_RDWR);
+	if (fd < 0)
+		return -errno;
+
+	while (count > 0) {
+		/* write it */
+		ret = write(fd, value, count);
+		if (ret <= 0) {
+			if (ret == EAGAIN)
+				continue;
+			close(fd);
+			return -errno;
+		}
+		count -= ret;
+	}
+
+	/* close it */
+	close(fd);
+
+	/* return success */
+	return 0;
+}
+
+/*
+ * read a debugfs entry
+ * returns the number of chars read or a negative errno
+ */
+int debugfs_read(const char *entry, char *buffer, size_t size)
+{
+	char path[MAX_PATH+1];
+	int ret;
+	int fd;
+
+	/* construct the path */
+	snprintf(path, sizeof(path), "%s/%s", debugfs_mountpoint, entry);
+
+	/* verify that it exists */
+	ret = debugfs_valid_entry(path);
+	if (ret)
+		return ret;
+
+	/* open the debugfs entry */
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return -errno;
+
+	do {
+		/* read it */
+		ret = read(fd, buffer, size);
+		if (ret == 0) {
+			close(fd);
+			return EOF;
+		}
+	} while (ret < 0 && errno == EAGAIN);
+
+	/* close it */
+	close(fd);
+
+	/* make *sure* there's a null character at the end */
+	buffer[ret] = '\0';
+
+	/* return the number of chars read */
+	return ret;
+}
diff --git a/debugfs.h b/debugfs.h
new file mode 100644
index 0000000..45f6339
--- /dev/null
+++ b/debugfs.h
@@ -0,0 +1,46 @@
+/*
+ * Copyright (C) 2009 Clark Williams <williams@redhat.com>
+ * Copyright (C) 2009 Xiao Guangrong <xiaoguangrong@cn.fujitsu.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA
+ *
+ */
+
+#ifndef __DEBUGFS_H__
+#define __DEBUGFS_H__
+
+#include <sys/mount.h>
+#include <string.h>
+
+#ifndef MAX_PATH
+# define MAX_PATH 256
+#endif
+
+#ifndef STR
+# define _STR(x) #x
+# define STR(x) _STR(x)
+#endif
+
+extern const char *debugfs_find_mountpoint(void);
+extern int debugfs_valid_mountpoint(const char *debugfs);
+extern int debugfs_valid_entry(const char *path);
+extern char *debugfs_mount(const char *mountpoint);
+extern int debugfs_umount(void);
+extern int debugfs_write(const char *entry, const char *value);
+extern int debugfs_read(const char *entry, char *buffer, size_t size);
+extern void debugfs_force_cleanup(void);
+extern int debugfs_make_path(const char *element, char *buffer, int size);
+
+#endif /* __DEBUGFS_H__ */
diff --git a/main.h b/main.h
index 14aecc5..9f0b52d 100644
--- a/main.h
+++ b/main.h
@@ -23,4 +23,4 @@
 
 #define SOURCE_VERSION "0.2.2-beta"  /*put exactly one distinct word inside the string like "0.3-pre-alpha" or "0.3-rc1" or "0.3" */
 
-#define BAT_DEVICE "/dev/batman-adv"
+#define SOCKET_PATH "batman_adv/bat0/socket"
diff --git a/ping.c b/ping.c
index e423f9b..df1ad0c 100644
--- a/ping.c
+++ b/ping.c
@@ -35,6 +35,7 @@
 #include "functions.h"
 #include "packet.h"
 #include "bat-hosts.h"
+#include "debugfs.h"
 
 
 char is_aborted = 0;
@@ -76,6 +77,8 @@ int ping(int argc, char **argv)
 	char *dst_string, *mac_string;
 	double time_delta;
 	float min = 0.0, max = 0.0, avg = 0.0;
+	char *debugfs_mnt;
+	char icmp_socket[MAX_PATH+1];
 
 	while ((optchar = getopt(argc, argv, "hc:i:t:")) != -1) {
 		switch (optchar) {
@@ -132,11 +135,19 @@ int ping(int argc, char **argv)
 	signal(SIGINT, sig_handler);
 	signal(SIGTERM, sig_handler);
 
-	ping_fd = open(BAT_DEVICE, O_RDWR);
+	debugfs_mnt = debugfs_mount(NULL);
+	if (!debugfs_mnt) {
+		printf("Error - can't mount or find debugfs\n");
+		goto out;
+	}
+
+	debugfs_make_path(SOCKET_PATH, icmp_socket, sizeof(icmp_socket));
+
+	ping_fd = open(icmp_socket, O_RDWR);
 
 	if (ping_fd < 0) {
-		printf("Error - can't open a connection to the batman adv kernel module via the device '%s': %s\n",
-				BAT_DEVICE, strerror(errno));
+		printf("Error - can't open a connection to the batman adv kernel module via the socket '%s': %s\n",
+				icmp_socket, strerror(errno));
 		printf("Check whether the module is loaded and active.\n");
 		goto out;
 	}
@@ -161,7 +172,7 @@ int ping(int argc, char **argv)
 		icmp_packet_out.seqno = htons(++seq_counter);
 
 		if (write(ping_fd, (char *)&icmp_packet_out, sizeof(icmp_packet_out)) < 0) {
-			printf("Error - can't write to batman adv kernel file '%s': %s\n", BAT_DEVICE, strerror(errno));
+			printf("Error - can't write to batman adv kernel file '%s': %s\n", icmp_socket, strerror(errno));
 			goto sleep;
 		}
 
@@ -191,7 +202,7 @@ int ping(int argc, char **argv)
 		read_len = read(ping_fd, (char *)&icmp_packet_in, sizeof(icmp_packet_in));
 
 		if (read_len < 0) {
-			printf("Error - can't read from batman adv kernel file '%s': %s\n", BAT_DEVICE, strerror(errno));
+			printf("Error - can't read from batman adv kernel file '%s': %s\n", icmp_socket, strerror(errno));
 			goto sleep;
 		}
 
diff --git a/traceroute.c b/traceroute.c
index 4115e6b..f5b63f9 100644
--- a/traceroute.c
+++ b/traceroute.c
@@ -34,6 +34,7 @@
 #include "functions.h"
 #include "packet.h"
 #include "bat-hosts.h"
+#include "debugfs.h"
 
 
 #define TTL_MAX 50
@@ -59,6 +60,8 @@ int traceroute(int argc, char **argv)
 	int ret = EXIT_FAILURE, res, trace_fd = 0, i;
 	int found_args = 1, optchar, seq_counter = 0, read_opt = USE_BAT_HOSTS;
 	double time_delta;
+	char *debugfs_mnt;
+	char icmp_socket[MAX_PATH+1];
 
 	while ((optchar = getopt(argc, argv, "hn")) != -1) {
 		switch (optchar) {
@@ -99,11 +102,19 @@ int traceroute(int argc, char **argv)
 
 	mac_string = ether_ntoa_long(dst_mac);
 
-	trace_fd = open(BAT_DEVICE, O_RDWR);
+	debugfs_mnt = debugfs_mount(NULL);
+	if (!debugfs_mnt) {
+		printf("Error - can't mount or find debugfs\n");
+		goto out;
+	}
+
+	debugfs_make_path(SOCKET_PATH, icmp_socket, sizeof(icmp_socket));
+
+	trace_fd = open(icmp_socket, O_RDWR);
 
 	if (trace_fd < 0) {
-		printf("Error - can't open a connection to the batman adv kernel module via the device '%s': %s\n",
-				BAT_DEVICE, strerror(errno));
+		printf("Error - can't open a connection to the batman adv kernel module via the socket '%s': %s\n",
+				icmp_socket, strerror(errno));
 		printf("Check whether the module is loaded and active.\n");
 		goto out;
 	}
@@ -123,7 +134,7 @@ int traceroute(int argc, char **argv)
 			icmp_packet_out.seqno = htons(++seq_counter);
 
 			if (write(trace_fd, (char *)&icmp_packet_out, sizeof(icmp_packet_out)) < 0) {
-				printf("Error - can't write to batman adv kernel file '%s': %s\n", BAT_DEVICE, strerror(errno));
+				printf("Error - can't write to batman adv kernel file '%s': %s\n", icmp_socket, strerror(errno));
 				continue;
 			}
 
@@ -149,7 +160,7 @@ int traceroute(int argc, char **argv)
 			read_len = read(trace_fd, (char *)&icmp_packet_in, sizeof(icmp_packet_in));
 
 			if (read_len < 0) {
-				printf("Error - can't read from batman adv kernel file '%s': %s\n", BAT_DEVICE, strerror(errno));
+				printf("Error - can't read from batman adv kernel file '%s': %s\n", icmp_socket, strerror(errno));
 				continue;
 			}
 
-- 
1.7.1


Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Thu,  1 Jul 2010 00:29:22 +0200
Message-Id: <1277936963-29179-2-git-send-email-linus.luessing@web.de>
In-Reply-To: <1277920995-25503-1-git-send-email-linus.luessing@web.de>
References: <1277920995-25503-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH] batctl: Add timeout filtering option for
	originators
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

This commit introduces the -t switch for originator table output. It
makes use of the new last-seen field in batman-adv, the user can specify
a timeout interval in seconds (with 3 digits precision before and after
a possible dot) if he/she considers a node as dead after this time.
(of course this is just influencing the displaying and not actually
declearing a node as dead for routing decisions)

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 batctl/debug.c     |   23 ++++++++++++++++++++---
 batctl/functions.c |    9 ++++++++-
 batctl/functions.d |   40 ++++++++++++++++++++++++++++++++++++++++
 batctl/functions.h |    3 ++-
 batctl/sys.c       |    8 ++++----
 5 files changed, 74 insertions(+), 9 deletions(-)
 create mode 100644 batctl/functions.d

diff --git a/batctl/debug.c b/batctl/debug.c
index c57355a..cd97b8d 100644
--- a/batctl/debug.c
+++ b/batctl/debug.c
@@ -40,6 +40,7 @@ void originators_usage(void)
 	printf(" \t -h print this help\n");
 	printf(" \t -n don't replace mac addresses with bat-host names\n");
 	printf(" \t -w watch mode - refresh the originator table continuously\n");
+	printf(" \t -t timeout interval - don't print originators not seen for xxx.xxx seconds \n");
 }
 
 void trans_local_usage(void)
@@ -74,8 +75,9 @@ int handle_debug_table(int argc, char **argv, char *file_path, void table_usage(
 	int optchar, read_opt = USE_BAT_HOSTS;
 	char full_path[MAX_PATH+1];
 	char *debugfs_mnt;
+	float orig_timeout;
 
-	while ((optchar = getopt(argc, argv, "hnw")) != -1) {
+	while ((optchar = getopt(argc, argv, "hnwt:")) != -1) {
 		switch (optchar) {
 		case 'h':
 			table_usage();
@@ -86,6 +88,21 @@ int handle_debug_table(int argc, char **argv, char *file_path, void table_usage(
 		case 'w':
 			read_opt |= CLR_CONT_READ;
 			break;
+		case 't':
+			if (table_usage != originators_usage) {
+				table_usage();
+				return EXIT_FAILURE;
+			}
+
+			read_opt |= NO_OLD_ORIGS;
+			if (!sscanf(optarg, "%f", &orig_timeout)) {
+				printf("Error - provided argument of -t is not a number\n");
+				return EXIT_FAILURE;
+			}
+			break;
+		case '?':
+			if (optopt == 't' && table_usage == originators_usage)
+				return EXIT_FAILURE;
 		default:
 			table_usage();
 			return EXIT_FAILURE;
@@ -99,7 +116,7 @@ int handle_debug_table(int argc, char **argv, char *file_path, void table_usage(
 	}
 
 	debugfs_make_path(DEBUG_BATIF_PATH "/", full_path, sizeof(full_path));
-	return read_file(full_path, file_path, read_opt);
+	return read_file(full_path, file_path, read_opt, orig_timeout);
 }
 
 static void log_usage(void)
@@ -137,7 +154,7 @@ int log_print(int argc, char **argv)
 	}
 
 	debugfs_make_path(DEBUG_BATIF_PATH "/", full_path, sizeof(full_path));
-	res = read_file(full_path, DEBUG_LOG, read_opt);
+	res = read_file(full_path, DEBUG_LOG, read_opt, 0);
 
 	if ((res != EXIT_SUCCESS) && (errno == ENOENT))
 		printf("To read the debug log you need to compile the module with debugging enabled (see the README)\n");
diff --git a/batctl/functions.c b/batctl/functions.c
index 9b697b3..0aeb99a 100644
--- a/batctl/functions.c
+++ b/batctl/functions.c
@@ -117,11 +117,12 @@ static int check_sys_dir(char *dir)
 	return EXIT_FAILURE;
 }
 
-int read_file(char *dir, char *fname, int read_opt)
+int read_file(char *dir, char *fname, int read_opt, float orig_timeout)
 {
 	struct ether_addr *mac_addr;
 	struct bat_host *bat_host;
 	int res = EXIT_FAILURE;
+	float last_seen;
 	char full_path[500], *buff_ptr, *space_ptr, extra_char;
 	size_t len = 0;
 	ssize_t read;
@@ -157,6 +158,12 @@ read:
 		if (read_opt & USE_READ_BUFF)
 			break;
 
+		/* skip timed out originators */
+		if (read_opt & NO_OLD_ORIGS)
+			if (sscanf(line_ptr, "%*s %f", &last_seen)
+			    && (last_seen > orig_timeout))
+				continue;
+
 		if (!(read_opt & USE_BAT_HOSTS)) {
 			printf("%s", line_ptr);
 			continue;
diff --git a/batctl/functions.d b/batctl/functions.d
new file mode 100644
index 0000000..9a28b76
--- /dev/null
+++ b/batctl/functions.d
@@ -0,0 +1,40 @@
+functions.o: functions.c /usr/include/netinet/ether.h \
+  /usr/include/features.h /usr/include/sys/cdefs.h \
+  /usr/include/bits/wordsize.h /usr/include/gnu/stubs.h \
+  /usr/include/gnu/stubs-32.h /usr/include/netinet/if_ether.h \
+  /usr/include/sys/types.h /usr/include/bits/types.h \
+  /usr/include/bits/typesizes.h /usr/include/time.h \
+  /usr/lib/gcc/i486-linux-gnu/4.3.2/include/stddef.h \
+  /usr/include/endian.h /usr/include/bits/endian.h \
+  /usr/include/sys/select.h /usr/include/bits/select.h \
+  /usr/include/bits/sigset.h /usr/include/bits/time.h \
+  /usr/include/sys/sysmacros.h /usr/include/bits/pthreadtypes.h \
+  /usr/include/linux/if_ether.h /usr/include/linux/types.h \
+  /usr/include/linux/posix_types.h /usr/include/linux/stddef.h \
+  /usr/lib/gcc/i486-linux-gnu/4.3.2/include-fixed/asm/posix_types.h \
+  /usr/include/asm/posix_types.h /usr/include/asm/posix_types_32.h \
+  /usr/include/asm/types.h /usr/include/asm-generic/int-ll64.h \
+  /usr/include/net/ethernet.h /usr/include/net/if_arp.h \
+  /usr/include/sys/socket.h /usr/include/sys/uio.h \
+  /usr/include/bits/uio.h /usr/include/bits/socket.h \
+  /usr/lib/gcc/i486-linux-gnu/4.3.2/include-fixed/limits.h \
+  /usr/lib/gcc/i486-linux-gnu/4.3.2/include-fixed/syslimits.h \
+  /usr/include/limits.h /usr/include/bits/posix1_lim.h \
+  /usr/include/bits/local_lim.h /usr/include/linux/limits.h \
+  /usr/include/bits/posix2_lim.h /usr/include/bits/xopen_lim.h \
+  /usr/include/bits/stdio_lim.h /usr/include/bits/sockaddr.h \
+  /usr/include/asm/socket.h /usr/include/asm/sockios.h \
+  /usr/include/sys/stat.h /usr/include/bits/stat.h /usr/include/unistd.h \
+  /usr/include/bits/posix_opt.h /usr/include/bits/environments.h \
+  /usr/include/bits/confname.h /usr/include/getopt.h \
+  /usr/include/stdlib.h /usr/include/bits/waitflags.h \
+  /usr/include/bits/waitstatus.h /usr/include/xlocale.h \
+  /usr/include/alloca.h /usr/include/stdio.h /usr/include/libio.h \
+  /usr/include/_G_config.h /usr/include/wchar.h \
+  /usr/lib/gcc/i486-linux-gnu/4.3.2/include/stdarg.h \
+  /usr/include/bits/sys_errlist.h /usr/include/string.h \
+  /usr/include/errno.h /usr/include/bits/errno.h \
+  /usr/include/linux/errno.h /usr/include/asm/errno.h \
+  /usr/include/asm-generic/errno.h /usr/include/asm-generic/errno-base.h \
+  /usr/include/fcntl.h /usr/include/bits/fcntl.h /usr/include/sys/time.h \
+  main.h functions.h bat-hosts.h
diff --git a/batctl/functions.h b/batctl/functions.h
index 885df34..3fb8f35 100644
--- a/batctl/functions.h
+++ b/batctl/functions.h
@@ -33,7 +33,7 @@ double end_timer(void);
 char *ether_ntoa_long(const struct ether_addr *addr);
 char *get_name_by_macaddr(struct ether_addr *mac_addr, int read_opt);
 char *get_name_by_macstr(char *mac_str, int read_opt);
-int read_file(char *dir, char *path, int read_opt);
+int read_file(char *dir, char *path, int read_opt, float orig_timeout);
 int write_file(char *dir, char *fname, char *arg1, char *arg2);
 
 extern char *line_ptr;
@@ -46,4 +46,5 @@ enum {
 	LOG_MODE = 0x08,
 	USE_READ_BUFF = 0x10,
 	SILENCE_ERRORS = 0x20,
+	NO_OLD_ORIGS = 0x40,
 };
diff --git a/batctl/sys.c b/batctl/sys.c
index 321dfc9..7135841 100644
--- a/batctl/sys.c
+++ b/batctl/sys.c
@@ -79,7 +79,7 @@ static int print_interfaces(void)
 
 	while ((iface_dir = readdir(iface_base_dir)) != NULL) {
 		snprintf(path_buff, PATH_BUFF_LEN, SYS_MESH_IFACE_FMT, iface_dir->d_name);
-		res = read_file("", path_buff, SINGLE_READ | USE_READ_BUFF | SILENCE_ERRORS);
+		res = read_file("", path_buff, SINGLE_READ | USE_READ_BUFF | SILENCE_ERRORS, 0);
 		if (res != EXIT_SUCCESS)
 			continue;
 
@@ -93,7 +93,7 @@ static int print_interfaces(void)
 		line_ptr = NULL;
 
 		snprintf(path_buff, PATH_BUFF_LEN, SYS_IFACE_STATUS_FMT, iface_dir->d_name);
-		res = read_file("", path_buff, SINGLE_READ | USE_READ_BUFF | SILENCE_ERRORS);
+		res = read_file("", path_buff, SINGLE_READ | USE_READ_BUFF | SILENCE_ERRORS, 0);
 		if (res != EXIT_SUCCESS) {
 			printf("<error reading status>\n");
 			continue;
@@ -196,7 +196,7 @@ int handle_loglevel(int argc, char **argv)
 		goto out;
 	}
 
-	res = read_file(SYS_BATIF_PATH, SYS_LOG_LEVEL, SINGLE_READ | USE_READ_BUFF);
+	res = read_file(SYS_BATIF_PATH, SYS_LOG_LEVEL, SINGLE_READ | USE_READ_BUFF, 0);
 
 	if (res != EXIT_SUCCESS)
 		goto out;
@@ -271,7 +271,7 @@ int handle_sys_setting(int argc, char **argv,
 	}
 
 	if (argc == 1)
-		return read_file(SYS_BATIF_PATH, file_path, SINGLE_READ);
+		return read_file(SYS_BATIF_PATH, file_path, SINGLE_READ, 0);
 
 	if (!sysfs_param)
 		goto write_file;
-- 
1.5.6.5


Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Tue, 11 Mar 2014 21:04:33 +0100
Message-Id: <1394568273-1117-2-git-send-email-linus.luessing@web.de>
In-Reply-To: <1394568273-1117-1-git-send-email-linus.luessing@web.de>
References: <1394568273-1117-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv3 2/2] batctl: add unicast/multicast address
	filter option for TT output
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

This patch adds the new "-u" and "-m" options for the local and global
translation table output to only display announced unicast or multicast
mac addresses to enhance readability.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
v3: unchanged

 debug.c      |   32 +++++++++++++++++++++++++++++++-
 functions.c  |   22 ++++++++++++++++++++++
 functions.h  |    2 ++
 man/batctl.8 |    2 ++
 4 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/debug.c b/debug.c
index 6836857..acf452b 100644
--- a/debug.c
+++ b/debug.c
@@ -91,6 +91,10 @@ static void debug_table_usage(int debug_table)
 
 	if (debug_table == BATCTL_TABLE_ORIGINATORS)
 		fprintf(stderr, " \t -t timeout interval - don't print originators not seen for x.y seconds \n");
+	if (debug_table == BATCTL_TABLE_TRANSLOCAL ||
+	    debug_table == BATCTL_TABLE_TRANSGLOBAL) {
+		fprintf(stderr, " \t -u|-m print unicast or multicast mac addresses only\n");
+	}
 }
 
 int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv)
@@ -102,7 +106,7 @@ int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv)
 	float watch_interval = 1;
 	opterr = 0;
 
-	while ((optchar = getopt(argc, argv, "hnw:t:H")) != -1) {
+	while ((optchar = getopt(argc, argv, "hnw:t:Hum")) != -1) {
 		switch (optchar) {
 		case 'h':
 			debug_table_usage(debug_table);
@@ -138,6 +142,26 @@ int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv)
 		case 'H':
 			read_opt |= SKIP_HEADER;
 			break;
+		case 'u':
+			if (debug_table != BATCTL_TABLE_TRANSLOCAL &&
+			    debug_table != BATCTL_TABLE_TRANSGLOBAL) {
+				fprintf(stderr, "Error - unrecognised option '-%c'\n", optchar);
+				debug_table_usage(debug_table);
+				return EXIT_FAILURE;
+			}
+
+			read_opt |= UNICAST_ONLY;
+			break;
+		case 'm':
+			if (debug_table != BATCTL_TABLE_TRANSLOCAL &&
+			    debug_table != BATCTL_TABLE_TRANSGLOBAL) {
+				fprintf(stderr, "Error - unrecognised option '-%c'\n", optchar);
+				debug_table_usage(debug_table);
+				return EXIT_FAILURE;
+			}
+
+			read_opt |= MULTICAST_ONLY;
+			break;
 		case '?':
 			if (optopt == 't')
 				fprintf(stderr, "Error - option '-t' needs a number as argument\n");
@@ -156,6 +180,12 @@ int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv)
 		}
 	}
 
+	if (read_opt & UNICAST_ONLY && read_opt & MULTICAST_ONLY) {
+		fprintf(stderr, "Error - '-u' and '-m' are exclusive options\n");
+		debug_table_usage(debug_table);
+		return EXIT_FAILURE;
+	}
+
 	debugfs_mnt = debugfs_mount(NULL);
 	if (!debugfs_mnt) {
 		fprintf(stderr, "Error - can't mount or find debugfs\n");
diff --git a/functions.c b/functions.c
index 36804bd..117dcff 100644
--- a/functions.c
+++ b/functions.c
@@ -175,6 +175,14 @@ static void file_open_problem_dbg(const char *dir, const char *fname,
 	}
 }
 
+static int str_is_mcast_addr(char *addr)
+{
+	struct ether_addr *mac_addr = ether_aton(addr);
+
+	return !mac_addr ? 0 :
+		mac_addr->ether_addr_octet[0] & 0x01;
+}
+
 int read_file(const char *dir, const char *fname, int read_opt,
 	      float orig_timeout, float watch_interval, size_t header_lines)
 {
@@ -224,6 +232,20 @@ read:
 			    && (last_seen > orig_timeout))
 				continue;
 
+		/* translation table: skip multicast */
+		if (line > header_lines &&
+		    read_opt & UNICAST_ONLY &&
+		    strlen(line_ptr) > strlen(" * xx:xx:xx:") &&
+		    str_is_mcast_addr(line_ptr+3))
+			continue;
+
+		/* translation table: skip unicast */
+		if (line > header_lines &&
+		    read_opt & MULTICAST_ONLY &&
+		    strlen(line_ptr) > strlen(" * xx:xx:xx:") &&
+		    !str_is_mcast_addr(line_ptr+3))
+			continue;
+
 		if (!(read_opt & USE_BAT_HOSTS)) {
 			printf("%s", line_ptr);
 			continue;
diff --git a/functions.h b/functions.h
index 14ba525..43c3d9c 100644
--- a/functions.h
+++ b/functions.h
@@ -57,6 +57,8 @@ enum {
 	NO_OLD_ORIGS = 0x40,
 	COMPAT_FILTER = 0x80,
 	SKIP_HEADER = 0x100,
+	UNICAST_ONLY = 0x200,
+	MULTICAST_ONLY = 0x400,
 };
 
 #endif
diff --git a/man/batctl.8 b/man/batctl.8
index f92bf3a..79d7887 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -198,6 +198,8 @@ All of the debug tables support the following options:
 The originator table also supports the "\-t" filter option to remove all originators from the output that have not been seen
 for the specified amount of seconds (with optional decimal places).
 
+The local and global translation tables also support the "\-u" and "\-m" option to only display unicast or multicast translation table announcements respectively.
+
 List of debug tables:
 .RS 10
 \- originators|o
-- 
1.7.10.4


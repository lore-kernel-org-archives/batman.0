Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Mon, 24 Feb 2014 05:11:44 +0100
Message-Id: <1393215104-28184-3-git-send-email-linus.luessing@web.de>
In-Reply-To: <1393215104-28184-1-git-send-email-linus.luessing@web.de>
References: <1393215104-28184-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 3/3] batctl: add unicast/multicast address
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
 debug.c      |   27 ++++++++++++++++++++++++++-
 functions.c  |   16 ++++++++++++++++
 functions.h  |    2 ++
 man/batctl.8 |    2 ++
 4 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/debug.c b/debug.c
index 6836857..b8f9a07 100644
--- a/debug.c
+++ b/debug.c
@@ -91,6 +91,11 @@ static void debug_table_usage(int debug_table)
 
 	if (debug_table == BATCTL_TABLE_ORIGINATORS)
 		fprintf(stderr, " \t -t timeout interval - don't print originators not seen for x.y seconds \n");
+	if (debug_table == BATCTL_TABLE_TRANSLOCAL ||
+	    debug_table == BATCTL_TABLE_TRANSGLOBAL) {
+		fprintf(stderr, " \t -u print unicast mac addresses only\n");
+		fprintf(stderr, " \t -m print multicast mac addresses only\n");
+	}
 }
 
 int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv)
@@ -102,7 +107,7 @@ int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv)
 	float watch_interval = 1;
 	opterr = 0;
 
-	while ((optchar = getopt(argc, argv, "hnw:t:H")) != -1) {
+	while ((optchar = getopt(argc, argv, "hnw:t:Hum")) != -1) {
 		switch (optchar) {
 		case 'h':
 			debug_table_usage(debug_table);
@@ -138,6 +143,26 @@ int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv)
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
diff --git a/functions.c b/functions.c
index 36804bd..41eabb2 100644
--- a/functions.c
+++ b/functions.c
@@ -224,6 +224,22 @@ read:
 			    && (last_seen > orig_timeout))
 				continue;
 
+		/* translation table: skip multicast */
+		if (line > header_lines &&
+		    read_opt & UNICAST_ONLY &&
+		    strlen(line_ptr) > strlen(" * xx:xx:xx:") &&
+		    (!strncmp(line_ptr+3, "33:33:", strlen("33:33:")) ||
+		     !strncmp(line_ptr+3, "01:00:5e:", strlen("01:00:5e:"))))
+			continue;
+
+		/* translation table: skip unicast */
+		if (line > header_lines &&
+		    read_opt & MULTICAST_ONLY &&
+		    strlen(line_ptr) > strlen(" * xx:xx:xx:") &&
+		    strncmp(line_ptr+3, "33:33:", strlen("33:33:")) &&
+		    strncmp(line_ptr+3, "01:00:5e:", strlen("01:00:5e:")))
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
index a8e8868..6b43d5e 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -178,6 +178,8 @@ All of the debug tables support the following options:
 The originator table also supports the "\-t" filter option to remove all originators from the output that have not been seen
 for the specified amount of seconds (with optional decimal places).
 
+The local and global translation tables also support the "\-u" and "\-m" option to only display unicast or multicast translation table announcements respectively.
+
 List of debug tables:
 .RS 10
 \- originators|o
-- 
1.7.10.4


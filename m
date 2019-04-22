Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 22 Apr 2019 10:12:14 +0200
Message-Id: <20190422081214.8481-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batctl: Drop log subcommand
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

The correct way to get a log of the activities of batman-adv is to use the
standard kernel tracing infrastructure:

  $ trace-cmd stream -e batadv:batadv_dbg

The batman-adv specific log file will be removed in the future when the
debugfs is dropped. And even for kernels without tracing support, most of
the functionality (except mac address to bat_hosts translation) can be
replaced by a simple:

  $ cat /sys/kernel/debug/batman_adv/bat0/log

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile     |  1 -
 README.rst   | 22 --------------------
 debug.h      |  1 -
 functions.c  |  7 ++-----
 functions.h  |  1 -
 log.c        | 59 ----------------------------------------------------
 man/batctl.8 |  4 ----
 7 files changed, 2 insertions(+), 93 deletions(-)
 delete mode 100644 log.c

diff --git a/Makefile b/Makefile
index df8b7b9..b7bd545 100755
--- a/Makefile
+++ b/Makefile
@@ -52,7 +52,6 @@ $(eval $(call add_command,gw_mode,y))
 $(eval $(call add_command,hop_penalty,y))
 $(eval $(call add_command,interface,y))
 $(eval $(call add_command,isolation_mark,y))
-$(eval $(call add_command,log,y))
 $(eval $(call add_command,loglevel,y))
 $(eval $(call add_command,mcast_flags,y))
 $(eval $(call add_command,multicast_fanout,y))
diff --git a/README.rst b/README.rst
index 03ea5e5..bc54412 100644
--- a/README.rst
+++ b/README.rst
@@ -386,28 +386,6 @@ Example::
   1000
 
 
-batctl log
-==========
-
-read the log produced by the kernel module
-
-Usage::
-
-  batctl log|l
-
-Example::
-
-  $ batctl log
-  [       400] Received BATMAN packet via NB: fe:fe:00:00:02:01 IF: eth0 [fe:fe:00:00:01:01] (from OG: fe:fe:00:00:01:01 via prev OG: fe:fe:00:00:01:01 seqno 670, tq 245, TTL 49, V 8, IDF 1)
-  [       400] Drop packet: originator packet from myself (via neighbour)
-  [       400] Received BATMAN packet via NB: fe:fe:00:00:02:01 IF: eth0 [fe:fe:00:00:01:01] (from OG: fe:fe:00:00:02:01 via prev OG: fe:fe:00:00:02:01 seqno 545, tq 255, TTL 50, V 8, IDF 0)
-  [       400] updating last_seqno: old 544, new 545
-  [       400] bidirectional: orig = fe:fe:00:00:02:01 neigh = fe:fe:00:00:02:01 => own_bcast = 64, real recv = 64, local tq: 255, asym_penalty: 255, total tq: 255
-  [       400] update_originator(): Searching and updating originator entry of received packet
-  [       400] Updating existing last-hop neighbour of originator
-  [...]
-
-
 batctl loglevel
 ===============
 
diff --git a/debug.h b/debug.h
index 3294361..bae33e5 100644
--- a/debug.h
+++ b/debug.h
@@ -19,7 +19,6 @@
 #define DEBUG_DAT_CACHE "dat_cache"
 #define DEBUG_NC_NODES "nc_nodes"
 #define DEBUG_MCAST_FLAGS "mcast_flags"
-#define DEBUG_LOG "log"
 #define DEBUG_ROUTING_ALGOS "routing_algos"
 
 struct debug_table_data {
diff --git a/functions.c b/functions.c
index bb7f517..636ff8d 100644
--- a/functions.c
+++ b/functions.c
@@ -275,11 +275,8 @@ int read_file(const char *dir, const char *fname, int read_opt,
 			if (!bat_host)
 				goto print_plain_buff;
 
-			if (read_opt & LOG_MODE)
-				printf("%s", bat_host->name);
-			else
-				/* keep table format */
-				printf("%17s", bat_host->name);
+			/* keep table format */
+			printf("%17s", bat_host->name);
 
 			goto written;
 
diff --git a/functions.h b/functions.h
index 02f7823..d4a5568 100644
--- a/functions.h
+++ b/functions.h
@@ -69,7 +69,6 @@ enum {
 	CONT_READ = 0x01,
 	CLR_CONT_READ = 0x02,
 	USE_BAT_HOSTS = 0x04,
-	LOG_MODE = 0x08,
 	USE_READ_BUFF = 0x10,
 	SILENCE_ERRORS = 0x20,
 	NO_OLD_ORIGS = 0x40,
diff --git a/log.c b/log.c
deleted file mode 100644
index e950bad..0000000
--- a/log.c
+++ /dev/null
@@ -1,59 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
- *
- * Marek Lindner <mareklindner@neomailbox.ch>
- *
- * License-Filename: LICENSES/preferred/GPL-2.0
- */
-
-#include <getopt.h>
-#include <stdio.h>
-#include <stdlib.h>
-
-#include "debug.h"
-#include "debugfs.h"
-#include "functions.h"
-
-static void log_usage(void)
-{
-	fprintf(stderr, "Usage: batctl [options] log [parameters]\n");
-	fprintf(stderr, "parameters:\n");
-	fprintf(stderr, " \t -h print this help\n");
-	fprintf(stderr, " \t -n don't replace mac addresses with bat-host names\n");
-}
-
-static int log_print(struct state *state, int argc, char **argv)
-{
-	int optchar, res, read_opt = USE_BAT_HOSTS | LOG_MODE;
-	char full_path[MAX_PATH+1];
-	char *debugfs_mnt;
-
-	while ((optchar = getopt(argc, argv, "hn")) != -1) {
-		switch (optchar) {
-		case 'h':
-			log_usage();
-			return EXIT_SUCCESS;
-		case 'n':
-			read_opt &= ~USE_BAT_HOSTS;
-			break;
-		default:
-			log_usage();
-			return EXIT_FAILURE;
-		}
-	}
-
-	check_root_or_die("batctl log");
-
-	debugfs_mnt = debugfs_mount(NULL);
-	if (!debugfs_mnt) {
-		fprintf(stderr, "Error - can't mount or find debugfs\n");
-		return EXIT_FAILURE;
-	}
-
-	debugfs_make_path(DEBUG_BATIF_PATH_FMT "/", state->mesh_iface, full_path, sizeof(full_path));
-	res = read_file(full_path, DEBUG_LOG, read_opt, 0, 0, 0);
-	return res;
-}
-
-COMMAND_NAMED(SUBCOMMAND, log, "l", log_print, COMMAND_FLAG_MESH_IFACE, NULL,
-	      "                  \tread the log produced by the kernel module");
diff --git a/man/batctl.8 b/man/batctl.8
index 8d7332a..0b43031 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -127,10 +127,6 @@ Level 'all' enables all messages. The messages are sent to the batman-adv debug
 Make sure to have debugging output enabled when compiling the module otherwise the output as well as the loglevel options
 won't be available.
 .br
-.IP "\fBlog\fP|\fBl\fP [\fB\-n\fP]\fP"
-batctl will read the batman-adv debug log which has to be compiled into the kernel module. If "\-n" is given batctl will not
-replace the MAC addresses with bat\-host names in the output.
-.br
 .IP "\fBgw_mode|gw\fP [\fBoff\fP|\fBclient\fP|\fBserver\fP] [\fBsel_class|bandwidth\fP]\fP"
 If no parameter is given the current gateway mode is displayed otherwise the parameter is used to set the gateway mode. The
 second (optional) argument specifies the selection class (if 'client' was the first argument) or the gateway bandwidth (if 'server'
-- 
2.20.1


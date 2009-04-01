From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu,  2 Apr 2009 00:20:16 +0200
Message-Id: <1238624416-2972-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1238581902-21257-2-git-send-email-sven.eckelmann@gmx.de>
References: <1238581902-21257-2-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCHv2 2/2] Sanitise batmand process by
	reexecuting it
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

uclibc >=0.9.29 doesn't support threads after the call of fork in
linuxthreads mode without calling exec* first. We can now try to call
the binary again with execv to sanitise the current process and tell him
that he should not try to get into the daemon mode so we don't recursive
call batmand again.
This can fail when no linux procfs is mounted on /proc or /proc/self/exe
is a dangling symlink. In this case we continue without any changes.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman/posix/init.c |   97 ++++++++++++++++++++++++++++++++------------------
 1 files changed, 62 insertions(+), 35 deletions(-)

diff --git a/batman/posix/init.c b/batman/posix/init.c
index bd10438..648ebd7 100644
--- a/batman/posix/init.c
+++ b/batman/posix/init.c
@@ -46,7 +46,28 @@ int8_t stop;
 
 
 
-static int my_daemon(void) {
+static void reexecute(int argc, char *argv[])
+{
+	char ** new_argv = NULL;
+	char* no_detach_flag = "-D";
+	int i;
+
+	new_argv = debugMalloc( sizeof(char *const) * (argc + 2), 5005 );
+	for (i = 0; i < argc; i++ ) {
+		new_argv[i] = argv[i];
+	}
+	new_argv[argc] = no_detach_flag;
+	new_argv[argc + 1] = NULL;
+
+
+	execv("/proc/self/exe", new_argv);
+
+	/* execv can fail due to different reasons
+	   so we must be able to continue here */
+	debugFree(new_argv, 5005);
+}
+
+static int my_daemon(int argc, char *argv[]) {
 
 	int fd;
 
@@ -83,6 +104,9 @@ static int my_daemon(void) {
 
 	}
 
+	/* Try to restart batmand in daemon mode to be sure that it is sanitised */
+	reexecute(argc, argv);
+
 	return 0;
 
 }
@@ -228,7 +252,7 @@ void apply_init_args( int argc, char *argv[] ) {
 	struct hna_node *hna_node;
 	struct debug_level_info *debug_level_info;
 	struct list_head *list_pos, *list_pos_tmp;
-	uint8_t found_args = 1, batch_mode = 0, info_output = 0, was_hna = 0;
+	uint8_t found_args = 1, batch_mode = 0, info_output = 0, was_hna = 0, i;
 	int8_t res, no_detach = 0;
 
 	int32_t optchar, option_index, recv_buff_len, bytes_written, download_speed = 0, upload_speed = 0;
@@ -572,14 +596,44 @@ void apply_init_args( int argc, char *argv[] ) {
 		if ( flush_routes_rules(1) < 0 )
 			exit(EXIT_FAILURE);
 
+
+		for (i = found_args; i < argc; i++) {
+			if (argv[i][0] == '-') {
+				fprintf(stderr, "%s: invalid option -- %s\n", argv[0], argv[i]);
+				usage();
+				exit(EXIT_FAILURE);
+			}
+		}
+
+		/* daemonize */
+		if (debug_level == 0) {
+
+			if (no_detach == 0 && my_daemon(argc, argv) < 0) {
+
+				printf("Error - can't fork to background: %s\n", strerror(errno));
+				restore_defaults();
+				exit(EXIT_FAILURE);
+
+			}
+
+			openlog("batmand", LOG_PID, LOG_DAEMON);
+
+		} else {
+
+			printf("B.A.T.M.A.N. %s%s (compatibility version %i)\n", SOURCE_VERSION, (strlen(REVISION_VERSION) > 3 ? REVISION_VERSION : ""), COMPAT_VERSION);
+
+			debug_clients.clients_num[ debug_level - 1 ]++;
+			debug_level_info = debugMalloc( sizeof(struct debug_level_info), 205 );
+			INIT_LIST_HEAD( &debug_level_info->list );
+			debug_level_info->fd = 2;
+			list_add( &debug_level_info->list, (struct list_head_first *)debug_clients.fd_list[debug_level - 1] );
+
+		}
+
+		log_facility_active = 1;
+
 		while (argc > found_args) {
 
-			if (argv[found_args][0] == '-') {
-				fprintf(stderr, "%s: invalid option -- %s\n", argv[0], argv[found_args]);
-				usage();
-				exit(EXIT_FAILURE);
-			}
-
 			batman_if = debugMalloc( sizeof(struct batman_if), 206 );
 			memset( batman_if, 0, sizeof(struct batman_if) );
 			INIT_LIST_HEAD( &batman_if->list );
@@ -649,33 +703,6 @@ void apply_init_args( int argc, char *argv[] ) {
 
 		}
 
-		/* daemonize */
-		if (debug_level == 0) {
-
-			if (no_detach == 0 && my_daemon() < 0) {
-
-				printf("Error - can't fork to background: %s\n", strerror(errno));
-				restore_defaults();
-				exit(EXIT_FAILURE);
-
-			}
-
-			openlog("batmand", LOG_PID, LOG_DAEMON);
-
-		} else {
-
-			printf("B.A.T.M.A.N. %s%s (compatibility version %i)\n", SOURCE_VERSION, (strlen(REVISION_VERSION) > 3 ? REVISION_VERSION : ""), COMPAT_VERSION);
-
-			debug_clients.clients_num[ debug_level - 1 ]++;
-			debug_level_info = debugMalloc( sizeof(struct debug_level_info), 205 );
-			INIT_LIST_HEAD( &debug_level_info->list );
-			debug_level_info->fd = 2;
-			list_add( &debug_level_info->list, (struct list_head_first *)debug_clients.fd_list[debug_level - 1] );
-
-		}
-
-		log_facility_active = 1;
-
 		pthread_create( &unix_if.listen_thread_id, NULL, &unix_listen, NULL );
 
 		/* add rule for hna networks */
-- 
1.6.2.1


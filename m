From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu, 26 Mar 2009 13:59:26 +0100
Message-Id: <1238072366-8109-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <200903251044.05666.lindner_marek@yahoo.de>
References: <200903251044.05666.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] Don't detach batmand to background by default
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

The current behaviour of batmand is to detach to background by default
when no debug mode is activated. This is problematic on different libc
implementations which don't support to use pthreads after the usage of
fork without calling exec* first. They will allow batmand to fork to the
background, but freeze the batmand main thread after calling
pthread_create.
This patch changes this behaviour to "not fork to the background unless
said otherwise". The user can now use the option -B to explicit say
that he knows what he is doing and that his system supports this
combinations of fork+pthreads_create. All other systems can use
 batmand tap1 > /dev/null 2>&1 &
or
 start-stop-daemon --start --background --exec /usr/sbin/batmand -- wlan0
to do the same.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman/batman.c      |    2 ++
 batman/man/batmand.8 |    3 +++
 batman/posix/init.c  |   11 ++++++++---
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/batman/batman.c b/batman/batman.c
index fe9f66e..c8f9c88 100644
--- a/batman/batman.c
+++ b/batman/batman.c
@@ -136,6 +136,7 @@ void usage(void)
 	fprintf( stderr, "       -a add announced network(s)\n" );
 	fprintf( stderr, "       -A delete announced network(s)\n" );
 	fprintf( stderr, "       -b run connection in batch mode\n" );
+	fprintf( stderr, "       -B run daemon in the background\n" );
 	fprintf( stderr, "       -c connect via unix socket\n" );
 	fprintf( stderr, "       -d debug level\n" );
 	fprintf( stderr, "       -g gateway class\n" );
@@ -161,6 +162,7 @@ void verbose_usage(void)
 	fprintf( stderr, "       -A delete announced network(s)\n" );
 	fprintf( stderr, "          network/netmask is expected\n" );
 	fprintf( stderr, "       -b run connection in batch mode\n" );
+	fprintf( stderr, "       -B detach and run as daemon in the background\n" );
 	fprintf( stderr, "       -c connect to running batmand via unix socket\n" );
 	fprintf( stderr, "       -d debug level\n" );
 	fprintf( stderr, "          default:         0 -> debug disabled\n" );
diff --git a/batman/man/batmand.8 b/batman/man/batmand.8
index dced39b..fc897dc 100644
--- a/batman/man/batmand.8
+++ b/batman/man/batmand.8
@@ -40,6 +40,9 @@ Delete networks to the daemons list of available connections to another network(
 .B \-b run debug connection in batch mode
 The debug information are updated after a period of time by default, so if you use "-b" it will execute once and then stop. This option is useful for script integration of the debug output and is only available in client mode together with "-d 1" or "-d 2".
 .TP
+.B \-B run daemon in the background
+When this option is specified, batmand will detach and become a daemon. This is only possible if your libc supports the usage of threads in combination with fork.
+.TP
 .B \-c connect via unix socket
 Use this option to switch to client mode. Deploy it without any arguments to get the current configuration even if changed at runtime.
 .TP
diff --git a/batman/posix/init.c b/batman/posix/init.c
index 4848a4b..d87f8ce 100644
--- a/batman/posix/init.c
+++ b/batman/posix/init.c
@@ -229,7 +229,7 @@ void apply_init_args( int argc, char *argv[] ) {
 	struct debug_level_info *debug_level_info;
 	struct list_head *list_pos, *list_pos_tmp;
 	uint8_t found_args = 1, batch_mode = 0, info_output = 0, was_hna = 0;
-	int8_t res;
+	int8_t res, detach = 0;
 
 	int32_t optchar, option_index, recv_buff_len, bytes_written, download_speed = 0, upload_speed = 0;
 	char str1[16], str2[16], *slash_ptr, *unix_buff, *buff_ptr, *cr_ptr;
@@ -253,7 +253,7 @@ void apply_init_args( int argc, char *argv[] ) {
 	if ( strstr( SOURCE_VERSION, "-" ) != NULL )
 		printf( "WARNING: You are using the unstable batman branch. If you are interested in *using* batman get the latest stable release !\n" );
 
-	while ( ( optchar = getopt_long( argc, argv, "a:A:bcd:hHio:g:p:r:s:vV", long_options, &option_index ) ) != -1 ) {
+	while ( ( optchar = getopt_long( argc, argv, "a:A:bBcd:hHio:g:p:r:s:vV", long_options, &option_index ) ) != -1 ) {
 
 		switch ( optchar ) {
 
@@ -278,6 +278,11 @@ void apply_init_args( int argc, char *argv[] ) {
 				found_args++;
 				break;
 
+			case 'B':
+				detach++;
+				found_args++;
+				break;
+
 			case 'c':
 				unix_client++;
 				found_args++;
@@ -647,7 +652,7 @@ void apply_init_args( int argc, char *argv[] ) {
 		/* daemonize */
 		if (debug_level == 0) {
 
-			if (my_daemon() < 0) {
+			if (detach && my_daemon() < 0) {
 
 				printf("Error - can't fork to background: %s\n", strerror(errno));
 				restore_defaults();
-- 
1.6.2.1


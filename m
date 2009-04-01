From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed,  1 Apr 2009 12:31:41 +0200
Message-Id: <1238581902-21257-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <200904011229.01236.sven.eckelmann@gmx.de>
References: <200904011229.01236.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] Add parameter to disable fork to
	background
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
This patch adds a parameter to change the behaviour to not fork to the
background. It can be used to fork to the background from the outside
and workaround the fork+thread issue by setting this parameter.
Example usage is to call batmand using
 batmand -D tap1 > /dev/null 2>&1 &
or
 start-stop-daemon --start --background --exec /usr/sbin/batmand -- -D wlan0

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman/batman.c      |    2 ++
 batman/man/batmand.8 |    3 +++
 batman/posix/init.c  |   11 ++++++++---
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/batman/batman.c b/batman/batman.c
index 73214ac..d05833e 100644
--- a/batman/batman.c
+++ b/batman/batman.c
@@ -138,6 +138,7 @@ void usage(void)
 	fprintf( stderr, "       -b run connection in batch mode\n" );
 	fprintf( stderr, "       -c connect via unix socket\n" );
 	fprintf( stderr, "       -d debug level\n" );
+	fprintf( stderr, "       -B don't run daemon in the background\n" );
 	fprintf( stderr, "       -g gateway class\n" );
 	fprintf( stderr, "       -h this help\n" );
 	fprintf( stderr, "       -H verbose help\n" );
@@ -168,6 +169,7 @@ void verbose_usage(void)
 	fprintf( stderr, "                           2 -> list gateways\n" );
 	fprintf( stderr, "                           3 -> observe batman\n" );
 	fprintf( stderr, "                           4 -> observe batman (very verbose)\n\n" );
+	fprintf( stderr, "       -D not detach and doesn't run as daemon in the background\n" );
 
 	if ( debug_level_max == 5  )
 		fprintf( stderr, "                           5 -> memory debug / cpu usage\n\n" );
diff --git a/batman/man/batmand.8 b/batman/man/batmand.8
index 263b4c3..07f6300 100644
--- a/batman/man/batmand.8
+++ b/batman/man/batmand.8
@@ -61,6 +61,9 @@ allowed values: 1 -> list neighbors
 Note that debug level 5 can be disabled at compile time.
 .RE
 .TP
+.B \-D don't run daemon in the background
+When this option is specified, batmand will not detach and does not become a daemon.
+.TP
 .B \-g gateway class
 The gateway class is used to tell other nodes in the network your available internet bandwidth. Just enter any number (optionally followed by "kbit" or "mbit") and the daemon will guess your appropriate gateway class. Use "/" to seperate the down- and upload rates. You can omit the upload rate and batmand will assume an upload of download / 5.
 .RS 17
diff --git a/batman/posix/init.c b/batman/posix/init.c
index b0ef71d..bd10438 100644
--- a/batman/posix/init.c
+++ b/batman/posix/init.c
@@ -229,7 +229,7 @@ void apply_init_args( int argc, char *argv[] ) {
 	struct debug_level_info *debug_level_info;
 	struct list_head *list_pos, *list_pos_tmp;
 	uint8_t found_args = 1, batch_mode = 0, info_output = 0, was_hna = 0;
-	int8_t res;
+	int8_t res, no_detach = 0;
 
 	int32_t optchar, option_index, recv_buff_len, bytes_written, download_speed = 0, upload_speed = 0;
 	char str1[16], str2[16], *slash_ptr, *unix_buff, *buff_ptr, *cr_ptr;
@@ -253,7 +253,7 @@ void apply_init_args( int argc, char *argv[] ) {
 	if ( strstr( SOURCE_VERSION, "-" ) != NULL )
 		printf( "WARNING: You are using the unstable batman branch. If you are interested in *using* batman get the latest stable release !\n" );
 
-	while ( ( optchar = getopt_long( argc, argv, "a:A:bcd:hHio:g:p:r:s:vV", long_options, &option_index ) ) != -1 ) {
+	while ( ( optchar = getopt_long( argc, argv, "a:A:bcd:DhHio:g:p:r:s:vV", long_options, &option_index ) ) != -1 ) {
 
 		switch ( optchar ) {
 
@@ -306,6 +306,11 @@ void apply_init_args( int argc, char *argv[] ) {
 				found_args += ((*((char*)( optarg - 1)) == optchar) ? 1 : 2);
 				break;
 
+			case 'D':
+				no_detach++;
+				found_args++;
+				break;
+
 			case 'g':
 
 				if ( ( slash_ptr = strchr( optarg, '/' ) ) != NULL )
@@ -647,7 +652,7 @@ void apply_init_args( int argc, char *argv[] ) {
 		/* daemonize */
 		if (debug_level == 0) {
 
-			if (my_daemon() < 0) {
+			if (no_detach == 0 && my_daemon() < 0) {
 
 				printf("Error - can't fork to background: %s\n", strerror(errno));
 				restore_defaults();
-- 
1.6.2.1


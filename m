Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 12 Sep 2013 22:58:39 +0200
Message-Id: <1379019524-23543-9-git-send-email-sven@narfation.org>
In-Reply-To: <1379019524-23543-1-git-send-email-sven@narfation.org>
References: <1379019524-23543-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 08/13] batmand: Clear screen using ANSI
	escape codes
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
Cc: Sven Eckelmann <sven@narfation.org>

It is not necessary to call an external binary to clear the screen of a default
unix terminal emulator. The external call using system("clear") may be used by
an attacker to get untrusted code called with an higher privilege because
batmand has to be run using uid 0.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 posix/init.c        | 3 ++-
 posix/posix.c       | 3 ++-
 posix/unix_socket.c | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/posix/init.c b/posix/init.c
index 9cefe73..308e476 100644
--- a/posix/init.c
+++ b/posix/init.c
@@ -719,7 +719,8 @@ more_hna:
 				} else if ( strncmp( buff_ptr, "BOD", 3 ) == 0 ) {
 
 					if ( !batch_mode )
-						system( "clear" );
+						/* clear screen, set cursor back to 0,0 */
+						printf("\033[2J\033[0;0f");
 
 				} else {
 
diff --git a/posix/posix.c b/posix/posix.c
index 81cd2e1..5cdf417 100644
--- a/posix/posix.c
+++ b/posix/posix.c
@@ -181,7 +181,8 @@ static void bat_wait( int32_t T, int32_t t ) {
 
 void print_animation( void ) {
 
-	system( "clear" );
+	/* clear screen, set cursor back to 0,0 */
+	printf("\033[2J\033[0;0f");
 	BAT_LOGO_END( 0, 50 );
 
 	sym_print( 0, 3, "." );
diff --git a/posix/unix_socket.c b/posix/unix_socket.c
index fc9983b..11c96b2 100644
--- a/posix/unix_socket.c
+++ b/posix/unix_socket.c
@@ -100,7 +100,8 @@ void debug_output(int8_t debug_prio, const char *format, ...) {
 			dprintf(debug_level_info->fd, "[%10u] ", get_time_msec());
 
 		if (((debug_level == 1) || (debug_level == 2)) && (debug_level_info->fd == 1) && (strncmp(format, "BOD", 3) == 0))
-			system("clear");
+			/* clear screen, set cursor back to 0,0 */
+			printf("\033[2J\033[0;0f");
 
 		if (((debug_level != 1) && (debug_level != 2)) || (debug_level_info->fd != 1) || (strncmp(format, "EOD", 3) != 0))
 			vdprintf(debug_level_info->fd, format, args);
-- 
1.8.4.rc3


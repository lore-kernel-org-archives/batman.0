Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 12 Sep 2013 22:58:40 +0200
Message-Id: <1379019524-23543-10-git-send-email-sven@narfation.org>
In-Reply-To: <1379019524-23543-1-git-send-email-sven@narfation.org>
References: <1379019524-23543-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 09/13] batmand: Use POSIX daemon function
	instead of self-written one
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 posix/init.c | 45 ++-------------------------------------------
 1 file changed, 2 insertions(+), 43 deletions(-)

diff --git a/posix/init.c b/posix/init.c
index 308e476..3bc54b0 100644
--- a/posix/init.c
+++ b/posix/init.c
@@ -35,6 +35,7 @@
 #include <arpa/inet.h>
 #include <fcntl.h>
 #include <getopt.h>
+#include <unistd.h>
 
 
 #include "../os.h"
@@ -44,48 +45,6 @@
 int8_t stop;
 
 
-
-static int my_daemon(void) {
-
-	int fd;
-
-	switch( fork() ) {
-
-		case -1:
-			return -1;
-
-		case 0:
-			break;
-
-		default:
-			exit(EXIT_SUCCESS);
-
-	}
-
-	if ( setsid() == -1 )
-		return(-1);
-
-	/* Make certain we are not a session leader, or else we might reacquire a controlling terminal */
-	if ( fork() )
-		exit(EXIT_SUCCESS);
-
-	chdir( "/" );
-
-	if ( ( fd = open(_PATH_DEVNULL, O_RDWR, 0) ) != -1 ) {
-
-		dup2(fd, STDIN_FILENO);
-		dup2(fd, STDOUT_FILENO);
-		dup2(fd, STDERR_FILENO);
-
-		if ( fd > 2 )
-			close(fd);
-
-	}
-
-	return 0;
-
-}
-
 static void create_routing_pipe(void)
 {
 	int fd[2], pipe_opts;
@@ -534,7 +493,7 @@ void apply_init_args( int argc, char *argv[] ) {
 		/* daemonize */
 		if (debug_level == 0) {
 
-			if (my_daemon() < 0) {
+			if (daemon(0, 0) < 0) {
 
 				printf("Error - can't fork to background: %s\n", strerror(errno));
 				restore_defaults();
-- 
1.8.4.rc3


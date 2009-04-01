From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed,  1 Apr 2009 12:31:42 +0200
Message-Id: <1238581902-21257-2-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <200904011229.01236.sven.eckelmann@gmx.de>
References: <200904011229.01236.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] Sanitise batmand process by reexecuting
	it
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
 batman/posix/init.c |   28 ++++++++++++++++++++++++++--
 1 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/batman/posix/init.c b/batman/posix/init.c
index bd10438..5dbfe17 100644
--- a/batman/posix/init.c
+++ b/batman/posix/init.c
@@ -46,7 +46,28 @@ int8_t stop;
 
 
 
-static int my_daemon(void) {
+static void re_execute(int argc, char *argv[])
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
+	   so we must be able to continue anyway */
+	debugFree(new_argv, 5005);
+}
+
+static int my_daemon(int argc, char *argv[]) {
 
 	int fd;
 
@@ -83,6 +104,9 @@ static int my_daemon(void) {
 
 	}
 
+	/* Try to restart batmand in daemon mode to be sure that it is sanitised */
+	re_execute(argc, argv);
+
 	return 0;
 
 }
@@ -652,7 +676,7 @@ void apply_init_args( int argc, char *argv[] ) {
 		/* daemonize */
 		if (debug_level == 0) {
 
-			if (no_detach == 0 && my_daemon() < 0) {
+			if (no_detach == 0 && my_daemon(argc, argv) < 0) {
 
 				printf("Error - can't fork to background: %s\n", strerror(errno));
 				restore_defaults();
-- 
1.6.2.1


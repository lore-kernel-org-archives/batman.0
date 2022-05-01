Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 1/2] alfred: Stabilize synchronization period using timerfd
Date: Sun,  1 May 2022 14:28:29 +0200
Message-Id: <20220501122830.22344-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Sven Eckelmann <sven@narfation.org>

The current way of scheduling the synchronization related events tends to
cause drift from a perfect periodic timer. This happens because it doesn't
calculate the next event based on a fixed start time + period * the number
of past synchronization periods. Instead, the next event was scheduled
based on the time before the last select() - ignoring that non-zero time
was spend processing events.

For a 10 second period, this usually looks somthing like:

  [24.043904208] announce primary ...
  [34.044216187] announce primary ...
  [44.053485658] announce primary ...
  [54.063562062] announce primary ...
  [64.073517069] announce primary ...

To avoid this drift, just use timerfd as rather stable periodic timer event
sources. It also has the benefit of making it easier to use multiple
periodic timers with different periods.

Only some small jitter can be seen with this external timer implementation:

  [12.673756426] announce primary ...
  [22.673779811] announce primary ...
  [32.673778362] announce primary ...
  [42.673775216] announce primary ...

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 alfred.h |  2 ++
 server.c | 89 +++++++++++++++++++++++++++++++++++---------------------
 2 files changed, 58 insertions(+), 33 deletions(-)

diff --git a/alfred.h b/alfred.h
index 2d98a30..2679515 100644
--- a/alfred.h
+++ b/alfred.h
@@ -124,6 +124,8 @@ struct globals {
 	uint8_t ipv4mode:1;
 	uint8_t force:1;
 
+	int check_timerfd;
+
 	int unix_sock;
 	const char *unix_path;
 
diff --git a/server.c b/server.c
index bfc37bc..b5ec7b2 100644
--- a/server.c
+++ b/server.c
@@ -20,6 +20,7 @@
 #include <sys/socket.h>
 #include <sys/ioctl.h>
 #include <sys/time.h>
+#include <sys/timerfd.h>
 #include <sys/types.h>
 #include <unistd.h>
 #include <time.h>
@@ -366,17 +367,44 @@ static void execute_update_command(struct globals *globals)
 	free(command);
 }
 
+static int create_sync_period_timer(struct globals *globals)
+{
+	struct itimerspec sync_timer;
+	int ret;
+
+	globals->check_timerfd = timerfd_create(CLOCK_MONOTONIC, TFD_CLOEXEC);
+	if (globals->check_timerfd < 0) {
+		perror("Failed to create periodic timer");
+		return -1;
+	}
+
+	sync_timer.it_value = globals->sync_period;
+	sync_timer.it_interval = globals->sync_period;
+
+	ret = timerfd_settime(globals->check_timerfd, 0, &sync_timer, NULL);
+	if (ret < 0) {
+		perror("Failed to arm synchronization timer");
+		return -1;
+	}
+
+	return 0;
+}
+
 int alfred_server(struct globals *globals)
 {
 	int maxsock, ret, recvs;
-	struct timespec last_check, now, tv;
+	struct timespec now;
 	fd_set fds, errfds;
 	size_t num_interfaces;
+	uint64_t timer_exp;
 	int num_socks;
 
 	if (create_hashes(globals))
 		return -1;
 
+	if (create_sync_period_timer(globals))
+		return -1;
+
 	if (unix_sock_open_daemon(globals))
 		return -1;
 
@@ -414,25 +442,10 @@ int alfred_server(struct globals *globals)
 		return -1;
 	}
 
-	clock_gettime(CLOCK_MONOTONIC, &last_check);
-	globals->if_check = last_check;
+	clock_gettime(CLOCK_MONOTONIC, &now);
+	globals->if_check = now;
 
 	while (1) {
-		clock_gettime(CLOCK_MONOTONIC, &now);
-
-		/* subtract the synchronization period from the current time
-		 * NOTE: this is an atypical usage of time_diff as it ignores the return
-		 * value and store the result back into now, essentially performing the
-		 * operation:
-		 * now -= globals->sync_period;
-		 */
-		time_diff(&now, &globals->sync_period, &now);
-
-		if (!time_diff(&last_check, &now, &tv)) {
-			tv.tv_sec = 0;
-			tv.tv_nsec = 0;
-		}
-
 		netsock_reopen(globals);
 
 		FD_ZERO(&fds);
@@ -440,10 +453,14 @@ int alfred_server(struct globals *globals)
 		FD_SET(globals->unix_sock, &fds);
 		maxsock = globals->unix_sock;
 
+		FD_SET(globals->check_timerfd, &fds);
+		if (maxsock < globals->check_timerfd)
+			maxsock = globals->check_timerfd;
+
 		maxsock = netsock_prepare_select(globals, &fds, maxsock);
 		maxsock = netsock_prepare_select(globals, &errfds, maxsock);
 
-		ret = pselect(maxsock + 1, &fds, NULL, &errfds, &tv, NULL);
+		ret = pselect(maxsock + 1, &fds, NULL, &errfds, NULL, NULL);
 
 		if (ret == -1) {
 			perror("main loop select failed ...");
@@ -459,21 +476,27 @@ int alfred_server(struct globals *globals)
 					continue;
 			}
 		}
-		clock_gettime(CLOCK_MONOTONIC, &last_check);
-
-		if (globals->opmode == OPMODE_PRIMARY) {
-			/* we are a primary */
-			printf("[%ld.%09ld] announce primary ...\n", last_check.tv_sec, last_check.tv_nsec);
-			announce_primary(globals);
-			sync_data(globals);
-		} else {
-			/* send local data to server */
-			update_server_info(globals);
-			push_local_data(globals);
+
+		if (FD_ISSET(globals->check_timerfd, &fds)) {
+			read(globals->check_timerfd, &timer_exp,
+			     sizeof(timer_exp));
+			clock_gettime(CLOCK_MONOTONIC, &now);
+
+			if (globals->opmode == OPMODE_PRIMARY) {
+				/* we are a primary */
+				printf("[%ld.%09ld] announce primary ...\n",
+				       now.tv_sec, now.tv_nsec);
+				announce_primary(globals);
+				sync_data(globals);
+			} else {
+				/* send local data to server */
+				update_server_info(globals);
+				push_local_data(globals);
+			}
+			purge_data(globals);
+			check_if_sockets(globals);
+			execute_update_command(globals);
 		}
-		purge_data(globals);
-		check_if_sockets(globals);
-		execute_update_command(globals);
 	}
 
 	netsock_close_all(globals);
-- 
2.30.2


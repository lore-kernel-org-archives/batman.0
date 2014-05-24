Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 24 May 2014 14:16:39 +0200
Message-Id: <1400933804-9661-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/6] batctl: Don't try to close negative file
	descriptors
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

Valid file descriptors are defined as being >= 0. Error codes returned by
the socket functions are defined as being < 0. This isn't checked correctly
through out the code and instead 0 is used as "not valid" file descriptor.

This can lead to functions like close being called with an error code as
argument.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 functions.c  | 4 ++--
 ping.c       | 4 ++--
 tcpdump.c    | 3 ++-
 traceroute.c | 4 ++--
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/functions.c b/functions.c
index b9ccaff..0f96cb8 100644
--- a/functions.c
+++ b/functions.c
@@ -335,7 +335,7 @@ out:
 int write_file(const char *dir, const char *fname, const char *arg1,
 	       const char *arg2)
 {
-	int fd = 0, res = EXIT_FAILURE;
+	int fd = -1, res = EXIT_FAILURE;
 	char full_path[500];
 	ssize_t write_len;
 
@@ -363,7 +363,7 @@ int write_file(const char *dir, const char *fname, const char *arg1,
 	res = EXIT_SUCCESS;
 
 out:
-	if (fd)
+	if (fd >= 0)
 		close(fd);
 	return res;
 }
diff --git a/ping.c b/ping.c
index c52ad13..6642188 100644
--- a/ping.c
+++ b/ping.c
@@ -79,7 +79,7 @@ int ping(char *mesh_iface, int argc, char **argv)
 	struct bat_host *bat_host, *rr_host;
 	ssize_t read_len;
 	fd_set read_socket;
-	int ret = EXIT_FAILURE, ping_fd = 0, res, optchar, found_args = 1;
+	int ret = EXIT_FAILURE, ping_fd = -1, res, optchar, found_args = 1;
 	int loop_count = -1, loop_interval = 0, timeout = 1, rr = 0, i;
 	unsigned int seq_counter = 0, packets_out = 0, packets_in = 0, packets_loss;
 	char *dst_string, *mac_string, *rr_string;
@@ -353,7 +353,7 @@ sleep:
 
 out:
 	bat_hosts_free();
-	if (ping_fd)
+	if (ping_fd >= 0)
 		close(ping_fd);
 	return ret;
 }
diff --git a/tcpdump.c b/tcpdump.c
index 94e2a84..10b18f2 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -846,6 +846,7 @@ int tcpdump(int argc, char **argv)
 
 		dump_if = malloc(sizeof(struct dump_if));
 		memset(dump_if, 0, sizeof(struct dump_if));
+		dump_if->raw_sock = -1;
 		INIT_LIST_HEAD(&dump_if->list);
 
 		dump_if->dev = argv[found_args];
@@ -971,7 +972,7 @@ int tcpdump(int argc, char **argv)
 
 out:
 	list_for_each_entry_safe(dump_if, dump_if_tmp, &dump_if_list, list) {
-		if (dump_if->raw_sock)
+		if (dump_if->raw_sock >= 0)
 			close(dump_if->raw_sock);
 
 		list_del((struct list_head *)&dump_if_list, &dump_if->list, &dump_if_list);
diff --git a/traceroute.c b/traceroute.c
index ce78c5d..22b90f2 100644
--- a/traceroute.c
+++ b/traceroute.c
@@ -63,7 +63,7 @@ int traceroute(char *mesh_iface, int argc, char **argv)
 	fd_set read_socket;
 	ssize_t read_len;
 	char *dst_string, *mac_string, *return_mac, dst_reached = 0;
-	int ret = EXIT_FAILURE, res, trace_fd = 0, i;
+	int ret = EXIT_FAILURE, res, trace_fd = -1, i;
 	int found_args = 1, optchar, seq_counter = 0, read_opt = USE_BAT_HOSTS;
 	double time_delta[NUM_PACKETS];
 	char *debugfs_mnt;
@@ -241,7 +241,7 @@ read_packet:
 
 out:
 	bat_hosts_free();
-	if (trace_fd)
+	if (trace_fd >= 0)
 		close(trace_fd);
 	return ret;
 }
-- 
2.0.0.rc2


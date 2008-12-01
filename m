From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon,  1 Dec 2008 19:56:59 +0100
Message-Id: <1228157822-29406-5-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1228157822-29406-1-git-send-email-sven.eckelmann@gmx.de>
References: <1228157822-29406-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] Respect (un)signess of parameter in printf
	format strings
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman/batman.h            |    2 +-
 batman/linux/route.c       |    2 +-
 batman/posix/init.c        |    2 +-
 batman/posix/unix_socket.c |    4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/batman/batman.h b/batman/batman.h
index c69f83a..bac3a82 100644
--- a/batman/batman.h
+++ b/batman/batman.h
@@ -77,7 +77,7 @@
 
 #define JITTER 100
 #define TTL 50                /* Time To Live of broadcast messages */
-#define PURGE_TIMEOUT 200000  /* purge originators after time in ms if no valid packet comes in -> TODO: check influence on TQ_LOCAL_WINDOW_SIZE */
+#define PURGE_TIMEOUT 200000u  /* purge originators after time in ms if no valid packet comes in -> TODO: check influence on TQ_LOCAL_WINDOW_SIZE */
 #define TQ_LOCAL_WINDOW_SIZE 64     /* sliding packet range of received originator messages in squence numbers (should be a multiple of our word size) */
 #define TQ_GLOBAL_WINDOW_SIZE 10
 #define TQ_LOCAL_BIDRECT_SEND_MINIMUM 1
diff --git a/batman/linux/route.c b/batman/linux/route.c
index e77fb63..ec5185a 100644
--- a/batman/linux/route.c
+++ b/batman/linux/route.c
@@ -270,7 +270,7 @@ void add_del_rule(uint32_t network, uint8_t netmask, int8_t rt_table, uint32_t p
 	inet_ntop(AF_INET, &network, str1, sizeof (str1));
 
 	if (policy_routing_script != NULL) {
-		dprintf(policy_routing_pipe, "RULE %s %s %s %i %s %s %i %s %i\n", (rule_action == RULE_DEL ? "del" : "add"), rule_type_to_string[rule_type], str1, netmask, "unused", "unused", prio, iif, rt_table);
+		dprintf(policy_routing_pipe, "RULE %s %s %s %i %s %s %u %s %i\n", (rule_action == RULE_DEL ? "del" : "add"), rule_type_to_string[rule_type], str1, netmask, "unused", "unused", prio, iif, rt_table);
 		return;
 	}
 
diff --git a/batman/posix/init.c b/batman/posix/init.c
index 79d5a3b..42a8cce 100644
--- a/batman/posix/init.c
+++ b/batman/posix/init.c
@@ -774,7 +774,7 @@ more_hna:
 		} else if (purge_timeout_opt) {
 
 			batch_mode = 1;
-			snprintf(unix_buff, 20, "q:%i", purge_timeout);
+			snprintf(unix_buff, 20, "q:%u", purge_timeout);
 
 		} else if ( info_output ) {
 
diff --git a/batman/posix/unix_socket.c b/batman/posix/unix_socket.c
index 3dda74e..d522f79 100644
--- a/batman/posix/unix_socket.c
+++ b/batman/posix/unix_socket.c
@@ -135,7 +135,7 @@ void internal_output(uint32_t sock)
 	dprintf(sock, "unix_socket_path=%s\n", UNIX_PATH);
 	dprintf(sock, "own_ogm_jitter=%i\n", JITTER);
 	dprintf(sock, "default_ttl=%i\n", TTL);
-	dprintf(sock, "originator_timeout=%i (default: %i)\n", purge_timeout, PURGE_TIMEOUT);
+	dprintf(sock, "originator_timeout=%u (default: %u)\n", purge_timeout, PURGE_TIMEOUT);
 	dprintf(sock, "tq_local_window_size=%i\n", TQ_LOCAL_WINDOW_SIZE);
 	dprintf(sock, "tq_global_window_size=%i\n", TQ_GLOBAL_WINDOW_SIZE);
 	dprintf(sock, "tq_local_bidirect_send_minimum=%i\n", TQ_LOCAL_BIDRECT_SEND_MINIMUM);
@@ -491,7 +491,7 @@ void *unix_listen( void * BATMANUNUSED(arg) ) {
 									dprintf(unix_client->sock, " --aggregation");
 
 								if (purge_timeout != PURGE_TIMEOUT)
-									dprintf(unix_client->sock, " --purge-timeout %i", purge_timeout);
+									dprintf(unix_client->sock, " --purge-timeout %u", purge_timeout);
 
 								list_for_each(debug_pos, &if_list) {
 
-- 
1.6.0.4


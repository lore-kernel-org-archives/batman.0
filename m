Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 12 Sep 2013 22:58:38 +0200
Message-Id: <1379019524-23543-8-git-send-email-sven@narfation.org>
In-Reply-To: <1379019524-23543-1-git-send-email-sven@narfation.org>
References: <1379019524-23543-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 07/13] batmand: Fix printf format strings
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

The types for the format string did not always match the type of the parameter.
This can lead to wrong output or crashes. There is also no '' format string but
a thousand format string. But this thousand '  is not ISO C and doesn't work
with all libc implementations. And the thousand ' is not supported for strings.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 allocate.c          |  2 +-
 originator.c        | 12 ++++++------
 os.h                |  2 +-
 posix/unix_socket.c |  2 +-
 profile.c           |  3 ++-
 5 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/allocate.c b/allocate.c
index 57a4894..beedafe 100644
--- a/allocate.c
+++ b/allocate.c
@@ -210,7 +210,7 @@ void checkIntegrity(void)
 	for ( memoryWalker = memoryList; memoryWalker != NULL; memoryWalker = memoryWalker->next ) {
 
 		if ( memoryWalker->counter != 0 )
-			debug_output( 5, "   tag: %''4i, num malloc: %4i, bytes per malloc: %''4i, total: %6i\n", memoryWalker->tag, memoryWalker->counter, memoryWalker->length, memoryWalker->counter * memoryWalker->length );
+			debug_output( 5, "   tag: %4i, num malloc: %4i, bytes per malloc: %4i, total: %6i\n", memoryWalker->tag, memoryWalker->counter, memoryWalker->length, memoryWalker->counter * memoryWalker->length );
 
 	}
 	pthread_mutex_unlock(&memory_mutex);
diff --git a/originator.c b/originator.c
index f58bbcf..7de0e4d 100644
--- a/originator.c
+++ b/originator.c
@@ -423,7 +423,7 @@ void debug_orig(void) {
 		uptime_sec = (uint64_t)(get_time_msec64() / 1000);
 
 		debug_output(2, "BOD\n");
-		debug_output(2, "%''12s     (%s/%i) %''15s [%10s], gw_class ... [B.A.T.M.A.N. %s, MainIF/IP: %s/%s, UT: %id%2ih%2im] \n", "Gateway", "#", TQ_MAX_VALUE, "Nexthop", "outgoingIF", SOURCE_VERSION, ((struct batman_if *)if_list.next)->dev, orig_str, (uint32_t)(uptime_sec/86400), (uint32_t)((uptime_sec%86400)/3600), (uint32_t)((uptime_sec%3600)/60));
+		debug_output(2, "%12s     (%s/%i) %15s [%10s], gw_class ... [B.A.T.M.A.N. %s, MainIF/IP: %s/%s, UT: %id%2ih%2im] \n", "Gateway", "#", TQ_MAX_VALUE, "Nexthop", "outgoingIF", SOURCE_VERSION, ((struct batman_if *)if_list.next)->dev, orig_str, (uint32_t)(uptime_sec/86400), (uint32_t)((uptime_sec%86400)/3600), (uint32_t)((uptime_sec%3600)/60));
 
 		if ( list_empty( &gw_list ) ) {
 
@@ -446,7 +446,7 @@ void debug_orig(void) {
 
 				get_gw_speeds( gw_node->orig_node->gwflags, &download_speed, &upload_speed );
 
-				debug_output(2, "%s %-15s (%3i) %''15s [%10s], gw_class %3i - %i%s/%i%s, gateway failures: %i \n", ( curr_gateway == gw_node ? "=>" : "  " ), str, gw_node->orig_node->router->tq_avg, str2, gw_node->orig_node->router->if_incoming->dev, gw_node->orig_node->gwflags, (download_speed > 2048 ? download_speed / 1024 : download_speed), (download_speed > 2048 ? "MBit" : "KBit"), (upload_speed > 2048 ? upload_speed / 1024 : upload_speed), (upload_speed > 2048 ? "MBit" : "KBit"), gw_node->gw_failure);
+				debug_output(2, "%s %-15s (%3i) %15s [%10s], gw_class %3i - %i%s/%i%s, gateway failures: %i \n", ( curr_gateway == gw_node ? "=>" : "  " ), str, gw_node->orig_node->router->tq_avg, str2, gw_node->orig_node->router->if_incoming->dev, gw_node->orig_node->gwflags, (download_speed > 2048 ? download_speed / 1024 : download_speed), (download_speed > 2048 ? "MBit" : "KBit"), (upload_speed > 2048 ? upload_speed / 1024 : upload_speed), (upload_speed > 2048 ? "MBit" : "KBit"), gw_node->gw_failure);
 
 				batman_count++;
 
@@ -467,7 +467,7 @@ void debug_orig(void) {
 		uptime_sec = (uint64_t)(get_time_msec64() / 1000);
 
 		debug_output(1, "BOD \n");
-		debug_output(1, "  %-11s (%s/%i) %''15s [%10s]: %''20s ... [B.A.T.M.A.N. %s, MainIF/IP: %s/%s, UT: %id%2ih%2im] \n", "Originator", "#", TQ_MAX_VALUE, "Nexthop", "outgoingIF", "Potential nexthops", SOURCE_VERSION, ((struct batman_if *)if_list.next)->dev, orig_str, (uint32_t)(uptime_sec/86400), (uint32_t)((uptime_sec%86400)/3600), (uint32_t)((uptime_sec%3600)/60));
+		debug_output(1, "  %-11s (%s/%i) %15s [%10s]: %20s ... [B.A.T.M.A.N. %s, MainIF/IP: %s/%s, UT: %id%2ih%2im] \n", "Originator", "#", TQ_MAX_VALUE, "Nexthop", "outgoingIF", "Potential nexthops", SOURCE_VERSION, ((struct batman_if *)if_list.next)->dev, orig_str, (uint32_t)(uptime_sec/86400), (uint32_t)((uptime_sec%86400)/3600), (uint32_t)((uptime_sec%3600)/60));
 
 		if ( debug_clients.clients_num[3] > 0 ) {
 
@@ -481,7 +481,7 @@ void debug_orig(void) {
 			}
 
 			debug_output( 4, "Originator list \n" );
-			debug_output( 4, "  %-11s (%s/%i) %''15s [%10s]: %''20s\n", "Originator", "#", TQ_MAX_VALUE, "Nexthop", "outgoingIF", "Potential nexthops" );
+			debug_output( 4, "  %-11s (%s/%i) %15s [%10s]: %20s\n", "Originator", "#", TQ_MAX_VALUE, "Nexthop", "outgoingIF", "Potential nexthops" );
 
 		}
 
@@ -497,8 +497,8 @@ void debug_orig(void) {
 			addr_to_string( orig_node->orig, str, sizeof (str) );
 			addr_to_string( orig_node->router->addr, str2, sizeof (str2) );
 
-			debug_output( 1, "%-15s (%3i) %''15s [%10s]:", str, orig_node->router->tq_avg, str2, orig_node->router->if_incoming->dev );
-			debug_output( 4, "%''15s (%3i) %''15s [%10s], last_valid: %u: \n", str, orig_node->router->tq_avg, str2, orig_node->router->if_incoming->dev, orig_node->last_valid );
+			debug_output( 1, "%-15s (%3i) %15s [%10s]:", str, orig_node->router->tq_avg, str2, orig_node->router->if_incoming->dev );
+			debug_output( 4, "%15s (%3i) %15s [%10s], last_valid: %u: \n", str, orig_node->router->tq_avg, str2, orig_node->router->if_incoming->dev, orig_node->last_valid );
 
 			debug_out_size = 0;
 
diff --git a/os.h b/os.h
index 2f2b2df..2272030 100644
--- a/os.h
+++ b/os.h
@@ -96,7 +96,7 @@ void *client_to_gw_tun( void *arg );
 /* unix_sokcet.c */
 void *unix_listen( void *arg );
 void internal_output(uint32_t sock);
-void debug_output( int8_t debug_prio, const char *format, ... );
+void debug_output( int8_t debug_prio, const char *format, ... ) __attribute__ ((format (printf, 2, 3)));
 
 
 #endif
diff --git a/posix/unix_socket.c b/posix/unix_socket.c
index 11c5d3e..fc9983b 100644
--- a/posix/unix_socket.c
+++ b/posix/unix_socket.c
@@ -347,7 +347,7 @@ void *unix_listen(void * BATMANUNUSED(arg)) {
 							} else if ( buff[0] == 'q' ) {
 
 								if ( status > 2 ) {
-									debug_output(3, "Unix socket: changing purge timeout from: %i to: %i\n", purge_timeout, strtol(buff + 2, NULL, 10));
+									debug_output(3, "Unix socket: changing purge timeout from: %i to: %li\n", purge_timeout, strtol(buff + 2, NULL, 10));
 									purge_timeout = strtol(buff + 2, NULL, 10);
 								}
 
diff --git a/profile.c b/profile.c
index c76ae8d..11d8aa9 100644
--- a/profile.c
+++ b/profile.c
@@ -23,6 +23,7 @@
 
 #include "os.h"
 #include "batman.h"
+#include <inttypes.h>
 
 
 
@@ -67,7 +68,7 @@ void prof_print(void) {
 
 	for ( index = 0; index < PROF_COUNT; index++ ) {
 
-		debug_output( 5, "   %''30s: cpu time = %10.3f, calls = %''10i, avg time per call = %4.10f \n", prof_container[index].name, (float)prof_container[index].total_time/CLOCKS_PER_SEC, prof_container[index].calls, ( prof_container[index].calls == 0 ? 0.0 : ( ( (float)prof_container[index].total_time/CLOCKS_PER_SEC ) / (float)prof_container[index].calls ) ) );
+		debug_output( 5, "   %30s: cpu time = %10.3f, calls = %10"PRId64", avg time per call = %4.10f \n", prof_container[index].name, (float)prof_container[index].total_time/CLOCKS_PER_SEC, prof_container[index].calls, ( prof_container[index].calls == 0 ? 0.0 : ( ( (float)prof_container[index].total_time/CLOCKS_PER_SEC ) / (float)prof_container[index].calls ) ) );
 
 	}
 
-- 
1.8.4.rc3


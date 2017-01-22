Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 22 Jan 2017 13:07:47 +0100
Message-Id: <20170122120749.27932-2-sven@narfation.org>
In-Reply-To: <2527763.cX7mnL5d4j@sven-edge>
References: <2527763.cX7mnL5d4j@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH 2/4] batctl: tcpdump: Free resources on
	SIG(TERM|INT)
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

The cleanup code for dump interfaces and bathosts is only called on errors
during the initialization of the dump interfaces. But it should also be
used when the program exits normally.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 tcpdump.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tcpdump.c b/tcpdump.c
index 586a2ca..92171a3 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -39,6 +39,7 @@
 #include <netinet/icmp6.h>
 #include <netinet/if_ether.h>
 #include <net/ethernet.h>
+#include <signal.h>
 #include <stddef.h>
 #include <stdint.h>
 #include <sys/select.h>
@@ -1189,6 +1190,20 @@ free_dumpif:
 	return NULL;
 }
 
+static volatile sig_atomic_t is_aborted = 0;
+
+static void sig_handler(int sig)
+{
+	switch (sig) {
+	case SIGINT:
+	case SIGTERM:
+		is_aborted = 1;
+		break;
+	default:
+		break;
+	}
+}
+
 int tcpdump(int argc, char **argv)
 {
 	struct timeval tv;
@@ -1242,6 +1257,9 @@ int tcpdump(int argc, char **argv)
 
 	bat_hosts_init(read_opt);
 
+	signal(SIGINT, sig_handler);
+	signal(SIGTERM, sig_handler);
+
 	/* init interfaces list */
 	INIT_LIST_HEAD(&dump_if_list);
 	FD_ZERO(&wait_sockets);
@@ -1259,7 +1277,7 @@ int tcpdump(int argc, char **argv)
 		found_args++;
 	}
 
-	while (1) {
+	while (!is_aborted) {
 
 		memcpy(&tmp_wait_sockets, &wait_sockets, sizeof(fd_set));
 
-- 
2.11.0


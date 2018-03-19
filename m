Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 19 Mar 2018 18:50:05 +0100
Message-Id: <20180319175005.24430-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: Add tp debug log messages switch
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

The switch to enable/disable throughput meter debug messages in `batctl
log` is supported since batman-adv 2016.3 but was never adopted in batctl.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 README.rst   | 1 +
 man/batctl.8 | 7 ++++---
 sys.c        | 7 ++++++-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/README.rst b/README.rst
index 256e153..4c0f544 100644
--- a/README.rst
+++ b/README.rst
@@ -428,6 +428,7 @@ Example::
   [ ] messages related to arp snooping and distributed arp table (dat)
   [ ] messages related to network coding (nc)
   [ ] messages related to multicast (mcast)
+  [ ] messages related to throughput meter (tp)
 
 
 batctl nc_nodes
diff --git a/man/batctl.8 b/man/batctl.8
index 7cf66ca..d5fc530 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -107,9 +107,10 @@ level. Level 'none' disables all verbose logging. Level 'batman' enables message
 Level 'routes' enables messages related to routes being added / changed / deleted. Level 'tt' enables messages related to
 translation table operations. Level 'bla' enables messages related to the bridge loop avoidance. Level 'dat' enables
 messages related to ARP snooping and the Distributed Arp Table. Level 'nc' enables messages related to network coding.
-Level 'mcast' enables messages related to multicast optimizations. Level 'all' enables all messages. The messages
-are sent to the batman-adv debug log. Use \fBbatctl log\fP to retrieve it. Make sure to have debugging output enabled
-when compiling the module otherwise the output as well as the loglevel options won't be available.
+Level 'mcast' enables messages related to multicast optimizations. Level 'tp' enables messages related to throughput meter.
+Level 'all' enables all messages. The messages are sent to the batman-adv debug log. Use \fBbatctl log\fP to retrieve it.
+Make sure to have debugging output enabled when compiling the module otherwise the output as well as the loglevel options
+won't be available.
 .br
 .IP "\fBlog\fP|\fBl\fP [\fB\-n\fP]\fP"
 batctl will read the batman-adv debug log which has to be compiled into the kernel module. If "\-n" is given batctl will not
diff --git a/sys.c b/sys.c
index 068aa31..e0c2073 100644
--- a/sys.c
+++ b/sys.c
@@ -132,6 +132,7 @@ static void log_level_usage(void)
 	fprintf(stderr, " \t dat     Messages related to arp snooping and distributed arp table\n");
 	fprintf(stderr, " \t nc      Messages related to network coding\n");
 	fprintf(stderr, " \t mcast   Messages related to multicast\n");
+	fprintf(stderr, " \t tp      Messages related to throughput meter\n");
 }
 
 int handle_loglevel(char *mesh_iface, int argc, char **argv)
@@ -169,7 +170,7 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv)
 				log_level = 0;
 				break;
 			} else if (strcmp(argv[i], "all") == 0) {
-				log_level = 127;
+				log_level = 255;
 				break;
 			} else if (strcmp(argv[i], "batman") == 0)
 				log_level |= BIT(0);
@@ -185,6 +186,8 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv)
 				log_level |= BIT(5);
 			else if (strcmp(argv[i], "mcast") == 0)
 				log_level |= BIT(6);
+			else if (strcmp(argv[i], "tp") == 0)
+				log_level |= BIT(7);
 			else {
 				log_level_usage();
 				goto out;
@@ -220,6 +223,8 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv)
 	       "messages related to network coding", "nc");
 	printf("[%c] %s (%s)\n", (log_level & BIT(6)) ? 'x' : ' ',
 	       "messages related to multicast", "mcast");
+	printf("[%c] %s (%s)\n", (log_level & BIT(7)) ? 'x' : ' ',
+	       "messages related to throughput meter", "tp");
 
 out:
 	free(path_buff);
-- 
2.16.2


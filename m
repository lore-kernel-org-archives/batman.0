Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat,  6 Oct 2012 21:58:23 +0200
Message-Id: <1349553504-4377-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1349553504-4377-1-git-send-email-ordex@autistici.org>
References: <1349553504-4377-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv4 2/3] batctl: add support for the DAT log
	level
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

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 README       | 1 +
 man/batctl.8 | 7 ++++---
 sys.c        | 7 ++++++-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/README b/README
index 8ee2c9f..b3127a0 100644
--- a/README
+++ b/README
@@ -342,6 +342,7 @@ $  batctl loglevel
 [ ] messages related to route added / changed / deleted (routes)
 [ ] messages related to translation table operations (tt)
 [ ] messages related to bridge loop avoidance (bla)
+[ ] messages related to arp snooping and distributetd arp table (dat)
 
 batctl aggregation
 ==================
diff --git a/man/batctl.8 b/man/batctl.8
index 310b43f..250e461 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -85,9 +85,10 @@ disable fragmentation.
 If no parameter is given the current log level settings are displayed otherwise the parameter(s) is/are used to set the log
 level. Level 'none' disables all verbose logging. Level 'batman' enables messages related to routing / flooding / broadcasting.
 Level 'routes' enables messages related to routes being added / changed / deleted. Level 'tt' enables messages related to
-translation table operations. Level 'bla' enables messages related to the bridge loop avoidance. Level 'all' enables all
-messages. The messages are sent to the batman-adv debug log. Use \fBbatctl log\fP to retrieve it. Make sure to have debugging
-output enabled when compiling the module otherwise the output as well as the loglevel options won't be available.
+translation table operations. Level 'bla' enables messages related to the bridge loop avoidance. Level 'dat' enables
+messages related to ARP snooping and the Distributed Arp Table. Level 'all' enables all messages. The messages are sent
+to the batman-adv debug log. Use \fBbatctl log\fP to retrieve it. Make sure to have debugging output enabled when compiling
+the module otherwise the output as well as the loglevel options won't be available.
 .br
 .IP "\fBlog\fP|\fBl\fP [\fB\-n\fP]\fP"
 batctl will read the batman-adv debug log which has to be compiled into the kernel module. If "\-n" is given batctl will not
diff --git a/sys.c b/sys.c
index 6f94483..815ff88 100644
--- a/sys.c
+++ b/sys.c
@@ -258,6 +258,7 @@ static void log_level_usage(void)
 	printf(" \t routes  Messages related to route added / changed / deleted\n");
 	printf(" \t tt      Messages related to translation table operations\n");
 	printf(" \t bla     Messages related to bridge loop avoidance\n");
+	printf(" \t dat     Messages related to arp snooping and distributed arp table\n");
 }
 
 int handle_loglevel(char *mesh_iface, int argc, char **argv)
@@ -288,7 +289,7 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv)
 				log_level = 0;
 				break;
 			} else if (strcmp(argv[i], "all") == 0) {
-				log_level = 15;
+				log_level = 31;
 				break;
 			} else if (strcmp(argv[i], "batman") == 0)
 				log_level |= BIT(0);
@@ -298,6 +299,8 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv)
 				log_level |= BIT(2);
 			else if (strcmp(argv[i], "bla") == 0)
 				log_level |= BIT(3);
+			else if (strcmp(argv[i], "dat") == 0)
+				log_level |= BIT(4);
 			else {
 				log_level_usage();
 				goto out;
@@ -327,6 +330,8 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv)
 	       "messages related to translation table operations", "tt");
 	printf("[%c] %s (%s)\n", (log_level & BIT(3)) ? 'x' : ' ',
 	       "messages related to bridge loop avoidance", "bla");
+	printf("[%c] %s (%s)\n", (log_level & BIT(4)) ? 'x' : ' ',
+	       "messages related to arp snooping and distributed arp table", "dat");
 
 out:
 	free(path_buff);
-- 
1.7.12


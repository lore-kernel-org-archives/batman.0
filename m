Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 11 Jun 2012 16:30:02 +0200
Message-Id: <1339425002-12682-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: Revert "add support for DBG_DAT log
	level"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
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

Distributed ARP table support was removed from the batman-adv module.
Therefore, the support of the debug level should be removed from batctl until
the support was readded.

This reverts commit c8c043b9953cec095b7705e99443b37f6361c9a1.

Reported-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
This one is for next

 README       |    1 -
 man/batctl.8 |    2 +-
 sys.c        |    7 +------
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/README b/README
index 44e1ac7..b06aacf 100644
--- a/README
+++ b/README
@@ -344,7 +344,6 @@ $  batctl loglevel
 [ ] messages related to route added / changed / deleted (routes)
 [ ] messages related to translation table operations (tt)
 [ ] messages related to bridge loop avoidance (bla)
-[ ] messages related to the distributed arp table (dat)
 
 batctl aggregation
 ==================
diff --git a/man/batctl.8 b/man/batctl.8
index 8c38d74..714f50a 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -65,7 +65,7 @@ Once started batctl will display the list of announced originators in the networ
 If no parameter is given the current originator interval setting is displayed otherwise the parameter is used to set the originator interval. The interval is in units of milliseconds.
 .br
 .IP "\fBloglevel\fP|\fBll\fP      [\fBlevel\fP[ \fBlevel\fP[ \fBlevel\fP]] \fB...\fP]"
-If no parameter is given the current log level settings are displayed otherwise the parameter(s) is/are used to set the log level. Level 'none' disables all verbose logging. Level 'batman' enables messages related to routing / flooding / broadcasting. Level 'routes' enables messages related to routes being added / changed / deleted. Level 'tt' enables messages related to translation table operations. Level 'bla' enables messages related to the bridge loop avoidance. Level 'dat' enables messages related to the distributed arp table (DHT messages, ARP snooping and other debug logs). Level 'all' enables all messages. The messages are sent to the batman-adv debug log. Use \fBbatctl log\fP to see them. Make sure to have debugging output enabled when compiling the module otherwise the output as well as the loglevel options won't be available.
+If no parameter is given the current log level settings are displayed otherwise the parameter(s) is/are used to set the log level. Level 'none' disables all verbose logging. Level 'batman' enables messages related to routing / flooding / broadcasting. Level 'routes' enables messages related to routes being added / changed / deleted. Level 'tt' enables messages related to translation table operations. Level 'bla' enables messages related to the bridge loop avoidance. Level 'all' enables all messages. The messages are sent to the batman-adv debug log. Use \fBbatctl log\fP to see them. Make sure to have debugging output enabled when compiling the module otherwise the output as well as the loglevel options won't be available.
 .br
 .IP "\fBlog\fP|\fBl\fP            [\fB\-n\fP]\fP"
 batctl will read the batman-adv debug log which has to be compiled into the kernel module. If "\-n" is given batctl will not replace the MAC addresses with bat\-host names in the output.
diff --git a/sys.c b/sys.c
index d3bf7fa..0b4cac3 100644
--- a/sys.c
+++ b/sys.c
@@ -184,7 +184,6 @@ static void log_level_usage(void)
 	printf(" \t routes  Messages related to route added / changed / deleted\n");
 	printf(" \t tt      Messages related to translation table operations\n");
 	printf(" \t bla     Messages related to bridge loop avoidance\n");
-	printf(" \t dat     Messages related to the distributed arp table\n");
 }
 
 int handle_loglevel(char *mesh_iface, int argc, char **argv)
@@ -215,7 +214,7 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv)
 				log_level = 0;
 				break;
 			} else if (strcmp(argv[i], "all") == 0) {
-				log_level = 31;
+				log_level = 15;
 				break;
 			} else if (strcmp(argv[i], "batman") == 0)
 				log_level |= (1 << 0);
@@ -225,8 +224,6 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv)
 				log_level |= (1 << 2);
 			else if (strcmp(argv[i], "bla") == 0)
 				log_level |= (1 << 3);
-			else if (strcmp(argv[i], "dat") == 0)
-				log_level |= (1 << 4);
 			else {
 				log_level_usage();
 				goto out;
@@ -256,8 +253,6 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv)
 	       "messages related to translation table operations", "tt");
 	printf("[%c] %s (%s)\n", (log_level & 8) ? 'x' : ' ',
 	       "messages related to bridge loop avoidance", "bla");
-	printf("[%c] %s (%s)\n", (log_level & 16) ? 'x' : ' ',
-	       "messages related to the distributed arp table", "dat");
 
 out:
 	free(path_buff);
-- 
1.7.10


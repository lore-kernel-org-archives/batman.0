Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 27 Feb 2012 13:28:24 +0100
Message-Id: <1330345704-17911-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: add support for DBG_DAT log level
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

This patch add the related options in order to support the DBG_DAT log level.
README and mas are updated accordingly.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

This patch is based on:
[PATCH] batctl: fix 'all' loglevel


 README       |    1 +
 man/batctl.8 |    2 +-
 sys.c        |    7 ++++++-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/README b/README
index 64ee152..0fe192f 100644
--- a/README
+++ b/README
@@ -301,6 +301,7 @@ $  batctl loglevel
 [ ] messages related to route added / changed / deleted (routes)
 [ ] messages related to translation table operations (tt)
 [ ] messages related to bridge loop avoidance (bla)
+[ ] messages related to the distributed arp table (dat)
 
 batctl aggregation
 ==================
diff --git a/man/batctl.8 b/man/batctl.8
index 5cc37cb..036412b 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -65,7 +65,7 @@ Once started batctl will display the list of announced gateways in the network.
 If no parameter is given the current originator interval setting is displayed otherwise the parameter is used to set the originator interval. The interval is in units of milliseconds.
 .br
 .IP "\fBloglevel\fP|\fBll\fP      [\fBlevel\fP[ \fBlevel\fP[ \fBlevel\fP]] \fB...\fP]"
-If no parameter is given the current log level settings are displayed otherwise the parameter(s) is/are used to set the log level. Level 'none' disables all verbose logging. Level 'batman' enables messages related to routing / flooding / broadcasting. Level 'routes' enables messages related to routes being added / changed / deleted. Level 'tt' enables messages related to translation table operations. Level 'bla' enables messages related to the bridge loop avoidance. Level 'all' enables all messages. The messages are sent to the batman-adv debug log. Use \fBbatctl log\fP to see them. Make sure to have debugging output enabled when compiling the module otherwise the output as well as the loglevel options won't be available.
+If no parameter is given the current log level settings are displayed otherwise the parameter(s) is/are used to set the log level. Level 'none' disables all verbose logging. Level 'batman' enables messages related to routing / flooding / broadcasting. Level 'routes' enables messages related to routes being added / changed / deleted. Level 'tt' enables messages related to translation table operations. Level 'bla' enables messages related to the bridge loop avoidance. Level 'dat' enables messages related to the distributed arp table (DHT messages, ARP snooping and other debug logs). Level 'all' enables all messages. The messages are sent to the batman-adv debug log. Use \fBbatctl log\fP to see them. Make sure to have debugging output enabled when compiling the module otherwise the output as well as the loglevel options won't be available.
 .br
 .IP "\fBlog\fP|\fBl\fP            [\fB\-n\fP]\fP"
 batctl will read the batman-adv debug log which has to be compiled into the kernel module. If "\-n" is given batctl will not replace the MAC addresses with bat\-host names in the output.
diff --git a/sys.c b/sys.c
index 0b4cac3..e0dcb07 100644
--- a/sys.c
+++ b/sys.c
@@ -184,6 +184,7 @@ static void log_level_usage(void)
 	printf(" \t routes  Messages related to route added / changed / deleted\n");
 	printf(" \t tt      Messages related to translation table operations\n");
 	printf(" \t bla     Messages related to bridge loop avoidance\n");
+	printf(" \t dat     Messages related to the distributed arp table\n");
 }
 
 int handle_loglevel(char *mesh_iface, int argc, char **argv)
@@ -214,7 +215,7 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv)
 				log_level = 0;
 				break;
 			} else if (strcmp(argv[i], "all") == 0) {
-				log_level = 15;
+				log_level = 31;
 				break;
 			} else if (strcmp(argv[i], "batman") == 0)
 				log_level |= (1 << 0);
@@ -224,6 +225,8 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv)
 				log_level |= (1 << 2);
 			else if (strcmp(argv[i], "bla") == 0)
 				log_level |= (1 << 3);
+			else if (strcmp(argv[i], "dat") == 0)
+				log_level |= (1 << 4);
 			else {
 				log_level_usage();
 				goto out;
@@ -253,6 +256,8 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv)
 	       "messages related to translation table operations", "tt");
 	printf("[%c] %s (%s)\n", (log_level & 8) ? 'x' : ' ',
 	       "messages related to bridge loop avoidance", "bla");
+	printf("[%c] %s (%s)\n", (log_level & 16) ? 'x' : ' ',
+	       "messages related to the distributed arp table", "arp");
 
 out:
 	free(path_buff);
-- 
1.7.3.4


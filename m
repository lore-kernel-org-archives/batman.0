Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Wed,  6 Mar 2013 13:18:00 +0100
Message-Id: <1362572280-17945-3-git-send-email-martin@hundeboll.net>
In-Reply-To: <1362572280-17945-1-git-send-email-martin@hundeboll.net>
References: <1362572280-17945-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 3/3] batctl: Add support for the NC log level
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
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
---
 README       | 1 +
 man/batctl.8 | 7 ++++---
 sys.c        | 7 ++++++-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/README b/README
index f19a081..fd421e1 100644
--- a/README
+++ b/README
@@ -362,6 +362,7 @@ $  batctl loglevel
 [ ] messages related to translation table operations (tt)
 [ ] messages related to bridge loop avoidance (bla)
 [ ] messages related to arp snooping and distributed arp table (dat)
+[ ] messages related to network coding (nc)
 
 batctl nc_nodes
 ===============
diff --git a/man/batctl.8 b/man/batctl.8
index 6f8d210..38060d6 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -96,9 +96,10 @@ If no parameter is given the current log level settings are displayed otherwise
 level. Level 'none' disables all verbose logging. Level 'batman' enables messages related to routing / flooding / broadcasting.
 Level 'routes' enables messages related to routes being added / changed / deleted. Level 'tt' enables messages related to
 translation table operations. Level 'bla' enables messages related to the bridge loop avoidance. Level 'dat' enables
-messages related to ARP snooping and the Distributed Arp Table. Level 'all' enables all messages. The messages are sent
-to the batman-adv debug log. Use \fBbatctl log\fP to retrieve it. Make sure to have debugging output enabled when compiling
-the module otherwise the output as well as the loglevel options won't be available.
+messages related to ARP snooping and the Distributed Arp Table. Level 'nc' enables messages related to network coding.
+Level 'all' enables all messages. The messages are sent to the batman-adv debug log. Use \fBbatctl log\fP to retrieve it.
+Make sure to have debugging output enabled when compiling the module otherwise the output as well as the loglevel options
+won't be available.
 .br
 .IP "\fBlog\fP|\fBl\fP [\fB\-n\fP]\fP"
 batctl will read the batman-adv debug log which has to be compiled into the kernel module. If "\-n" is given batctl will not
diff --git a/sys.c b/sys.c
index 74a6c65..3258105 100644
--- a/sys.c
+++ b/sys.c
@@ -275,6 +275,7 @@ static void log_level_usage(void)
 	fprintf(stderr, " \t tt      Messages related to translation table operations\n");
 	fprintf(stderr, " \t bla     Messages related to bridge loop avoidance\n");
 	fprintf(stderr, " \t dat     Messages related to arp snooping and distributed arp table\n");
+	fprintf(stderr, " \t nc      Messages related to network coding\n");
 }
 
 int handle_loglevel(char *mesh_iface, int argc, char **argv)
@@ -306,7 +307,7 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv)
 				log_level = 0;
 				break;
 			} else if (strcmp(argv[i], "all") == 0) {
-				log_level = 31;
+				log_level = 63;
 				break;
 			} else if (strcmp(argv[i], "batman") == 0)
 				log_level |= BIT(0);
@@ -318,6 +319,8 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv)
 				log_level |= BIT(3);
 			else if (strcmp(argv[i], "dat") == 0)
 				log_level |= BIT(4);
+			else if (strcmp(argv[i], "nc") == 0)
+				log_level |= BIT(5);
 			else {
 				log_level_usage();
 				goto out;
@@ -350,6 +353,8 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv)
 	       "messages related to bridge loop avoidance", "bla");
 	printf("[%c] %s (%s)\n", (log_level & BIT(4)) ? 'x' : ' ',
 	       "messages related to arp snooping and distributed arp table", "dat");
+	printf("[%c] %s (%s)\n", (log_level & BIT(5)) ? 'x' : ' ',
+	       "messages related to network coding", "nc");
 
 out:
 	free(path_buff);
-- 
1.8.1.5


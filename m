Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Fri, 13 May 2016 18:35:40 +0200
Message-Id: <1463157342-13195-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv5 1/2] batctl: adding multicast debug level
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

From: Linus Lüssing <linus.luessing@web.de>

This patch adds the multicast debug level to check for own
multicast flag changes for instance.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---

Changes in v5:
* none

Changes in v4:
* rebase to current master (no conflicts)

Changes in v3:
* none

Changes in v2:
* added a sentence about 'mcast' log level to manpage

 README       |    1 +
 man/batctl.8 |    6 +++---
 sys.c        |    5 +++++
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/README b/README
index f87c551..b5de8a6 100644
--- a/README
+++ b/README
@@ -390,6 +390,7 @@ $  batctl loglevel
 [ ] messages related to bridge loop avoidance (bla)
 [ ] messages related to arp snooping and distributed arp table (dat)
 [ ] messages related to network coding (nc)
+[ ] messages related to multicast (mcast)
 
 batctl nc_nodes
 ===============
diff --git a/man/batctl.8 b/man/batctl.8
index e804a08..f8955d0 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -98,9 +98,9 @@ level. Level 'none' disables all verbose logging. Level 'batman' enables message
 Level 'routes' enables messages related to routes being added / changed / deleted. Level 'tt' enables messages related to
 translation table operations. Level 'bla' enables messages related to the bridge loop avoidance. Level 'dat' enables
 messages related to ARP snooping and the Distributed Arp Table. Level 'nc' enables messages related to network coding.
-Level 'all' enables all messages. The messages are sent to the batman-adv debug log. Use \fBbatctl log\fP to retrieve it.
-Make sure to have debugging output enabled when compiling the module otherwise the output as well as the loglevel options
-won't be available.
+Level 'mcast' enables messages related to multicast optimizations. Level 'all' enables all messages. The messages
+are sent to the batman-adv debug log. Use \fBbatctl log\fP to retrieve it. Make sure to have debugging output enabled
+when compiling the module otherwise the output as well as the loglevel options won't be available.
 .br
 .IP "\fBlog\fP|\fBl\fP [\fB\-n\fP]\fP"
 batctl will read the batman-adv debug log which has to be compiled into the kernel module. If "\-n" is given batctl will not
diff --git a/sys.c b/sys.c
index afa8533..ca837f6 100644
--- a/sys.c
+++ b/sys.c
@@ -277,6 +277,7 @@ static void log_level_usage(void)
 	fprintf(stderr, " \t bla     Messages related to bridge loop avoidance\n");
 	fprintf(stderr, " \t dat     Messages related to arp snooping and distributed arp table\n");
 	fprintf(stderr, " \t nc      Messages related to network coding\n");
+	fprintf(stderr, " \t mcast   Messages related to multicast\n");
 }
 
 int handle_loglevel(char *mesh_iface, int argc, char **argv)
@@ -321,6 +322,8 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv)
 				log_level |= BIT(4);
 			else if (strcmp(argv[i], "nc") == 0)
 				log_level |= BIT(5);
+			else if (strcmp(argv[i], "mcast") == 0)
+				log_level |= BIT(6);
 			else {
 				log_level_usage();
 				goto out;
@@ -354,6 +357,8 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv)
 	       "messages related to arp snooping and distributed arp table", "dat");
 	printf("[%c] %s (%s)\n", (log_level & BIT(5)) ? 'x' : ' ',
 	       "messages related to network coding", "nc");
+	printf("[%c] %s (%s)\n", (log_level & BIT(6)) ? 'x' : ' ',
+	       "messages related to multicast", "mcast");
 
 out:
 	free(path_buff);
-- 
1.7.10.4


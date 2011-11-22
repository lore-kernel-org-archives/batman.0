Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 22 Nov 2011 21:47:54 +0100
Message-Id: <1321994874-10225-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1321982931-32465-1-git-send-email-ordex@autistici.org>
References: <1321982931-32465-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2] batctl: added loglevel support for DBG_ARP
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

From: Antonio Quartull <ordex@autistici.org>

With the introduction of DAT (Distributed ARP Table) a new log level has been
added. This log level is i ncharge of collecting messages related to DAT, ARP
parsing and snooping. README has been updated accordingly

Signed-off-by: Antonio Quartull <ordex@autistici.org>
---
 README       |    1 +
 man/batctl.8 |    2 +-
 sys.c        |    5 +++++
 3 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/README b/README
index 7119951..4bbfcb5 100644
--- a/README
+++ b/README
@@ -300,6 +300,7 @@ $  batctl loglevel
 [ ] messages related to routing / flooding / broadcasting (batman)
 [ ] messages related to route added / changed / deleted (routes)
 [ ] messages related to translation table operations (tt)
+[ ] messages related to DAT, ARP parsing and snooping (arp)
 
 batctl aggregation
 ==================
diff --git a/man/batctl.8 b/man/batctl.8
index 0cf0a7b..3f3ebc2 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -65,7 +65,7 @@ Once started batctl will display the list of announced gateways in the network.
 If no parameter is given the current originator interval setting is displayed otherwise the parameter is used to set the originator interval. The interval is in units of milliseconds.
 .br
 .IP "\fBloglevel\fP|\fBll\fP      [\fBlevel\fP[ \fBlevel\fP[ \fBlevel\fP]] \fB...\fP]"
-If no parameter is given the current log level settings are displayed otherwise the parameter(s) is/are used to set the log level. Level 'none' disables all verbose logging. Level 'batman' enables messages related to routing / flooding / broadcasting. Level 'routes' enables messages related to routes being added / changed / deleted. Level 'tt' enables messages related to translation table operations. Level 'all' enables all messages. The messages are sent to the batman-adv debug log. Use \fBbatctl log\fP to see them. Make sure to have debugging output enabled when compiling the module otherwise the output as well as the loglevel options won't be available.
+If no parameter is given the current log level settings are displayed otherwise the parameter(s) is/are used to set the log level. Level 'none' disables all verbose logging. Level 'batman' enables messages related to routing / flooding / broadcasting. Level 'routes' enables messages related to routes being added / changed / deleted. Level 'tt' enables messages related to translation table operations. Level 'arp' enables messages related to DAT, ARP parsing and snooping. Level 'all' enables all messages. The messages are sent to the batman-adv debug log. Use \fBbatctl log\fP to see them. Make sure to have debugging output enabled when compiling the module otherwise the output as well as the loglevel options won't be available.
 .br
 .IP "\fBlog\fP|\fBl\fP            [\fB\-n\fP]\fP"
 batctl will read the batman-adv debug log which has to be compiled into the kernel module. If "\-n" is given batctl will not replace the MAC addresses with bat\-host names in the output.
diff --git a/sys.c b/sys.c
index e510bee..044f772 100644
--- a/sys.c
+++ b/sys.c
@@ -183,6 +183,7 @@ static void log_level_usage(void)
 	printf(" \t batman  Messages related to routing / flooding / broadcasting\n");
 	printf(" \t routes  Messages related to route added / changed / deleted\n");
 	printf(" \t tt      Messages related to translation table operations\n");
+	printf(" \t arp     Messages related to DAT, ARP parsing and snooping\n");
 }
 
 int handle_loglevel(char *mesh_iface, int argc, char **argv)
@@ -221,6 +222,8 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv)
 				log_level |= (1 << 1);
 			else if (strcmp(argv[i], "tt") == 0)
 				log_level |= (1 << 2);
+			else if (strcmp(argv[i], "arp") == 0)
+				log_level |= (1 << 3);
 			else
 				log_level_usage();
 		}
@@ -246,6 +249,8 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv)
 	       "messages related to route added / changed / deleted", "routes");
 	printf("[%c] %s (%s)\n", (log_level & 4) ? 'x' : ' ',
 	       "messages related to translation table operations", "tt");
+	printf("[%c] %s (%s)\n", (log_level & 8) ? 'x' : ' ',
+	       "messages related to DAT, ARP parsing and snooping", "arp");
 
 out:
 	if (errno == ENOENT)
-- 
1.7.3.4


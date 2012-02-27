Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 27 Feb 2012 13:17:39 +0100
Message-Id: <1330345059-11383-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: update README and man with bla
	loglevel information
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

Both the README and the man page have to report the new loglevel information in
the corresponding section

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 README       |    1 +
 man/batctl.8 |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/README b/README
index da0ac68..64ee152 100644
--- a/README
+++ b/README
@@ -300,6 +300,7 @@ $  batctl loglevel
 [ ] messages related to routing / flooding / broadcasting (batman)
 [ ] messages related to route added / changed / deleted (routes)
 [ ] messages related to translation table operations (tt)
+[ ] messages related to bridge loop avoidance (bla)
 
 batctl aggregation
 ==================
diff --git a/man/batctl.8 b/man/batctl.8
index f45a070..5cc37cb 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -65,7 +65,7 @@ Once started batctl will display the list of announced gateways in the network.
 If no parameter is given the current originator interval setting is displayed otherwise the parameter is used to set the originator interval. The interval is in units of milliseconds.
 .br
 .IP "\fBloglevel\fP|\fBll\fP      [\fBlevel\fP[ \fBlevel\fP[ \fBlevel\fP]] \fB...\fP]"
-If no parameter is given the current log level settings are displayed otherwise the parameter(s) is/are used to set the log level. Level 'none' disables all verbose logging. Level 'batman' enables messages related to routing / flooding / broadcasting. Level 'routes' enables messages related to routes being added / changed / deleted. Level 'tt' enables messages related to translation table operations. Level 'all' enables all messages. The messages are sent to the batman-adv debug log. Use \fBbatctl log\fP to see them. Make sure to have debugging output enabled when compiling the module otherwise the output as well as the loglevel options won't be available.
+If no parameter is given the current log level settings are displayed otherwise the parameter(s) is/are used to set the log level. Level 'none' disables all verbose logging. Level 'batman' enables messages related to routing / flooding / broadcasting. Level 'routes' enables messages related to routes being added / changed / deleted. Level 'tt' enables messages related to translation table operations. Level 'bla' enables messages related to the bridge loop avoidance. Level 'all' enables all messages. The messages are sent to the batman-adv debug log. Use \fBbatctl log\fP to see them. Make sure to have debugging output enabled when compiling the module otherwise the output as well as the loglevel options won't be available.
 .br
 .IP "\fBlog\fP|\fBl\fP            [\fB\-n\fP]\fP"
 batctl will read the batman-adv debug log which has to be compiled into the kernel module. If "\-n" is given batctl will not replace the MAC addresses with bat\-host names in the output.
-- 
1.7.3.4


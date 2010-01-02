Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat,  2 Jan 2010 18:51:44 +0100
Message-Id: <1262454706-6137-2-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1262454706-6137-1-git-send-email-sven.eckelmann@gmx.de>
References: <1262454706-6137-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/3] batctl: Correct typographical errors
	detected by lintian
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.net

Debian's Lintian detected different smaller typographical errors in the source
code and manpages of batctl.

 * preceeding -> preceding
 * simliar -> similar

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batctl/bisect.c     |    4 ++--
 batctl/man/batctl.8 |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/batctl/bisect.c b/batctl/bisect.c
index e3d7463..1939613 100644
--- a/batctl/bisect.c
+++ b/batctl/bisect.c
@@ -197,7 +197,7 @@ static int routing_table_new(char *orig, char *next_hop, char *old_next_hop, cha
 	int i, j;
 
 	if (!curr_bat_node) {
-		fprintf(stderr, "Routing table change without preceeding OGM - skipping");
+		fprintf(stderr, "Routing table change without preceding OGM - skipping");
 		goto err;
 	}
 
@@ -225,7 +225,7 @@ static int routing_table_new(char *orig, char *next_hop, char *old_next_hop, cha
 		goto err;
 
 	if (list_empty(&orig_event->event_list)) {
-		fprintf(stderr, "Routing table change without any preceeding OGM of that originator - skipping");
+		fprintf(stderr, "Routing table change without any preceding OGM of that originator - skipping");
 		goto err;
 	}
 
diff --git a/batctl/man/batctl.8 b/batctl/man/batctl.8
index 1aa68df..311fca3 100644
--- a/batctl/man/batctl.8
+++ b/batctl/man/batctl.8
@@ -96,7 +96,7 @@ Analyzes the logfiles to build a small internal database of all sent sequence nu
 .SH FILES
 .TP
 .I "\fBbat-hosts\fP"
-This file is simliar to the /etc/hosts file. You can write one mac address and one host name per line. batctl will search for bat-hosts in /etc, your home directory and the current directory. The found data is used to match mac address to your provided host name or replace mac addresses in debug output and logs. Host names are much easier to remember than mac addresses.
+This file is similar to the /etc/hosts file. You can write one mac address and one host name per line. batctl will search for bat-hosts in /etc, your home directory and the current directory. The found data is used to match mac address to your provided host name or replace mac addresses in debug output and logs. Host names are much easier to remember than mac addresses.
 .SH AUTHOR
 batctl was written by Andreas Langer <a.langer@q-dsl.de> and Marek Lindner <lindner_marek@yahoo.de>.
 .PP
-- 
1.6.5.7


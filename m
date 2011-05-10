Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 10 May 2011 19:17:59 +0200
Message-Id: <1305047879-15897-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: added loglevel support for DBG_TT
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
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

DBG_TT log level has been added to batman-adv to collect all the
messages related to Translation Table operations. This patch makes batctl
able to select such level.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
Patch "batman-adv: improved client announcement mechanism" introduces a new log
"channel" called DBG_TT. This patch makes batctl able to correctly handle it


sys.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/sys.c b/sys.c
index f8fa1f2..dbf5383 100644
--- a/sys.c
+++ b/sys.c
@@ -182,6 +182,7 @@ static void log_level_usage(void)
 int handle_loglevel(char *mesh_iface, int argc, char **argv)
 {
 	int optchar, res;
+	int log_level;
 	char *path_buff;
 
 	while ((optchar = getopt(argc, argv, "h")) != -1) {
@@ -208,14 +209,16 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv)
 	if (res != EXIT_SUCCESS)
 		goto out;
 
-	printf("[%c] %s (%d)\n", (line_ptr[0] == '0') ? 'x' : ' ',
+	log_level = strtol(line_ptr, (char **) NULL, 10);
+
+	printf("[%c] %s (%d)\n", (!log_level) ? 'x' : ' ',
 	       "all debug output disabled", 0);
-	printf("[%c] %s (%d)\n", (line_ptr[0] == '1') ? 'x' : ' ',
+	printf("[%c] %s (%d)\n", (log_level & 1) ? 'x' : ' ',
 	       "messages related to routing / flooding / broadcasting", 1);
-	printf("[%c] %s (%d)\n", (line_ptr[0] == '2') ? 'x' : ' ',
-	       "messages related to route or tt entry added / changed / deleted", 2);
-	printf("[%c] %s (%d)\n", (line_ptr[0] == '3') ? 'x' : ' ',
-	       "all debug messages", 3);
+	printf("[%c] %s (%d)\n", (log_level & 2) ? 'x' : ' ',
+	       "messages related to route added / changed / deleted", 2);
+	printf("[%c] %s (%d)\n", (log_level & 4) ? 'x' : ' ',
+	       "messages related to translation table operations", 4);
 
 out:
 	if (errno == ENOENT)
-- 
1.7.3.4


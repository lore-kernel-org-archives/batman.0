Return-Path: <ordex@autistici.org>
From: Antonio Quartull <ordex@autistici.org>
Date: Sun, 13 Nov 2011 12:50:26 +0100
Message-Id: <1321185026-11095-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: correct batctl ll output
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

Since batctl has moved to a human-readable loglevel name, either 'batctl ll'
output should be coherent to this change. This patch correct it by substituting
the old numbers with the human-readable strings

Signed-off-by: Antonio Quartull <ordex@autistici.org>
---
 sys.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/sys.c b/sys.c
index bddaaa3..e510bee 100644
--- a/sys.c
+++ b/sys.c
@@ -237,14 +237,15 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv)
 
 	log_level = strtol(line_ptr, (char **) NULL, 10);
 
-	printf("[%c] %s (%d)\n", (!log_level) ? 'x' : ' ',
-	       "all debug output disabled", 0);
-	printf("[%c] %s (%d)\n", (log_level & 1) ? 'x' : ' ',
-	       "messages related to routing / flooding / broadcasting", 1);
-	printf("[%c] %s (%d)\n", (log_level & 2) ? 'x' : ' ',
-	       "messages related to route added / changed / deleted", 2);
-	printf("[%c] %s (%d)\n", (log_level & 4) ? 'x' : ' ',
-	       "messages related to translation table operations", 4);
+	printf("[%c] %s (%s)\n", (!log_level) ? 'x' : ' ',
+	       "all debug output disabled", "none");
+	printf("[%c] %s (%s)\n", (log_level & 1) ? 'x' : ' ',
+	       "messages related to routing / flooding / broadcasting",
+	       "batman");
+	printf("[%c] %s (%s)\n", (log_level & 2) ? 'x' : ' ',
+	       "messages related to route added / changed / deleted", "routes");
+	printf("[%c] %s (%s)\n", (log_level & 4) ? 'x' : ' ',
+	       "messages related to translation table operations", "tt");
 
 out:
 	if (errno == ENOENT)
-- 
1.7.3.4


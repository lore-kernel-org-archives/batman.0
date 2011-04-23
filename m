Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 23 Apr 2011 16:34:00 +0200
Message-Id: <1303569240-31956-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: Fix JSON object output
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

Each line is a single JSON object and has to start with '{' and no
spaces are allowed before it. Each pair has to be identified with a
string in double quotes.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 vis.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/vis.c b/vis.c
index eb77872..adb12d0 100644
--- a/vis.c
+++ b/vis.c
@@ -126,33 +126,33 @@ static void json_print_tq(char *orig, char *from, const long tq)
 	int int_part = TQ_MAX_VALUE / tq;
 	int frac_part = (1000 * TQ_MAX_VALUE / tq) - (int_part * 1000);
 
-	printf("\t{ router : \"%s\", ",
+	printf("{ \"router\" : \"%s\", ",
 	       get_name_by_macstr(orig, (with_names ? USE_BAT_HOSTS : 0)));
-	printf("neighbor : \"%s\", label : \"%d.%03d\" }\n",
+	printf("\"neighbor\" : \"%s\", \"label\" : \"%d.%03d\" }\n",
 	       get_name_by_macstr(from, (with_names ? USE_BAT_HOSTS : 0)),
 	       int_part, frac_part);
 }
 
 static void json_print_HNA(char *orig, char *from)
 {
-	printf("\t{ router : \"%s\", ",
+	printf("{ \"router\" : \"%s\", ",
 	       get_name_by_macstr(orig, (with_names ? USE_BAT_HOSTS : 0)));
-	printf("gateway : \"%s\", label : \"HNA\" }\n",
+	printf("\"gateway\" : \"%s\", \"label\" : \"HNA\" }\n",
 	       get_name_by_macstr(from, (with_names ? USE_BAT_HOSTS : 0)));
 }
 
 static void json_print_1st(char *orig)
 {
-	printf("\t{ primary : \"%s\" }\n",
+	printf("{ \"primary\" : \"%s\" }\n",
 	       get_name_by_macstr(orig, (with_names ? USE_BAT_HOSTS : 0)));
 }
 
 static void json_print_2nd(char *orig, char *from)
 {
-	printf("\t{ secondary : \"%s\", ",
+	printf("{ \"secondary\" : \"%s\", ",
 	       get_name_by_macstr(from, (with_names ? USE_BAT_HOSTS : 0)));
 
-	printf("of : \"%s\" }\n",
+	printf("\"of\" : \"%s\" }\n",
 	       get_name_by_macstr(orig, (with_names ? USE_BAT_HOSTS : 0)));
 }
 
-- 
1.7.4.4


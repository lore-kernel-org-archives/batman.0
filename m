Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 30 Oct 2010 17:00:58 +0200
Message-Id: <1288450858-14753-6-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1288450858-14753-1-git-send-email-sven.eckelmann@gmx.de>
References: <1288450858-14753-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 6/6] batctl: Convert strtok to reentrant safe
	strtok_r
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

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batctl/bisect.c |   10 +++++-----
 batctl/vis.c    |   12 ++++++------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/batctl/bisect.c b/batctl/bisect.c
index 2fa15f0..b7d8969 100644
--- a/batctl/bisect.c
+++ b/batctl/bisect.c
@@ -466,7 +466,7 @@ err:
 static int parse_log_file(char *file_path)
 {
 	FILE *fd;
-	char line_buff[MAX_LINE], *start_ptr, *tok_ptr;
+	char line_buff[MAX_LINE], *start_ptr, *start_ptr_safe, *tok_ptr;
 	char *neigh, *iface_addr, *orig, *prev_sender, rt_flag;
 	int line_count = 0, tq, ttl, seqno, i, res, max;
 
@@ -483,12 +483,12 @@ static int parse_log_file(char *file_path)
 		line_count++;
 
 		if (strstr(start_ptr, "Received BATMAN packet via NB")) {
-			tok_ptr = strtok(start_ptr, " ");
+			strtok_r(start_ptr, " ", &start_ptr_safe);
 			neigh = iface_addr = orig = prev_sender = NULL;
 			seqno = tq = ttl = -1;
 
 			for (i = 0; i < 21; i++) {
-				tok_ptr = strtok(NULL, " ");
+				tok_ptr = strtok_r(NULL, " ", &start_ptr_safe);
 				if (!tok_ptr)
 					break;
 
@@ -547,11 +547,11 @@ static int parse_log_file(char *file_path)
 				max = 3;
 			}
 
-			tok_ptr = strtok(start_ptr, " ");
+			strtok_r(start_ptr, " ", &start_ptr_safe);
 			orig = neigh = prev_sender = NULL;
 
 			for (i = 0; i < max; i++) {
-				tok_ptr = strtok(NULL, " ");
+				tok_ptr = strtok_r(NULL, " ", &start_ptr_safe);
 				if (!tok_ptr)
 					break;
 
diff --git a/batctl/vis.c b/batctl/vis.c
index 4bc5954..7fba1ab 100644
--- a/batctl/vis.c
+++ b/batctl/vis.c
@@ -186,7 +186,7 @@ static int format(char *mesh_iface, const struct funcs *funcs)
 	char *line = NULL;
 	char *orig, *from;
 	char *duplet;
-	char *line_save_ptr;
+	char *line_save_ptr, *component_save_ptr;
 	char *duplet_save_ptr;
 	char *endptr;
 	char *value;
@@ -207,12 +207,12 @@ static int format(char *mesh_iface, const struct funcs *funcs)
 
 		duplet_save_ptr = line_save_ptr;
 		while ((duplet = strtok_r(NULL, ",", &duplet_save_ptr)) != NULL) {
-			flag = strtok(duplet, " ");
+			flag = strtok_r(duplet, " ", &component_save_ptr);
 			if (!flag)
 				continue;
 			if (!strcmp(flag, "TQ")) {
-				from = strtok(NULL, " ");
-				value = strtok(NULL, " ");
+				from = strtok_r(NULL, " ", &component_save_ptr);
+				value = strtok_r(NULL, " ", &component_save_ptr);
 				tq = strtoul(value, &endptr, 0);
 				funcs->print_tq(orig, from, tq);
 				continue;
@@ -221,13 +221,13 @@ static int format(char *mesh_iface, const struct funcs *funcs)
 				/* We have an HNA record */
 				if (!with_HNA)
 					continue;
-				from = strtok(NULL, " ");
+				from = strtok_r(NULL, " ", &component_save_ptr);
 				funcs->print_HNA(orig, from);
 				continue;
 			}
 			if (!strcmp(flag, "SEC") && with_2nd) {
 				/* We found a secondary interface MAC address. */
-				from = strtok(NULL, " ");
+				from = strtok_r(NULL, " ", &component_save_ptr);
 				funcs->print_2nd(orig, from);
 			}
 			if (!strcmp(flag, "PRIMARY") && with_2nd) {
-- 
1.7.2.3


Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 24 May 2014 13:44:06 +0200
Message-Id: <1400931855-7961-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 01/10] batadv-vis: Avoid memory leak after
	failed realloc
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
Cc: Sven Eckelmann <sven@narfation.org>

realloc doesn't free the original buffer when the reallocation failed. An abort
of read_file without free'ing the buffer would leak it.

Signed-off-by: Sven Eckelmann <sven@narfation.org>

---
 vis/vis.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/vis/vis.c b/vis/vis.c
index 7a8e780..b51fede 100644
--- a/vis/vis.c
+++ b/vis/vis.c
@@ -40,7 +40,7 @@
 static char *read_file(char *fname)
 {
 	FILE *fp;
-	char *buf = NULL;
+	char *buf = NULL, *buf_tmp;
 	size_t size, ret;
 
 	fp = fopen(fname, "r");
@@ -51,10 +51,13 @@ static char *read_file(char *fname)
 	size = 0;
 	while (!feof(fp)) {
 
-		buf = realloc(buf, size + 4097);
-		if (!buf)
+		buf_tmp = realloc(buf, size + 4097);
+		if (!buf_tmp) {
+			free(buf);
 			return NULL;
+		}
 
+		buf = buf_tmp;
 		ret = fread(buf + size, 1, 4096, fp);
 		size += ret;
 	}
-- 
2.0.0.rc2


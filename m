Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 27 May 2014 17:04:15 +0200
Message-Id: <1401203055-22240-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batadv-vis: Avoid file handler leak after
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

The read_file function opens the file and thus has to close the filehandler
after an realloc error. This was forgotten in the fix
0ad384e11ed039d4c3025a7eaf19fe6bcfd41acf ("batadv-vis: Avoid memory leak after
failed realloc").

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 vis/vis.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/vis/vis.c b/vis/vis.c
index f429942..55c2dad 100644
--- a/vis/vis.c
+++ b/vis/vis.c
@@ -56,6 +56,7 @@ static char *read_file(char *fname)
 		buf_tmp = realloc(buf, size + 4097);
 		if (!buf_tmp) {
 			free(buf);
+			fclose(fp);
 			return NULL;
 		}
 
-- 
2.0.0.rc4


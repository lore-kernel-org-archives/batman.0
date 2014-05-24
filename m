Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 24 May 2014 13:44:10 +0200
Message-Id: <1400931855-7961-5-git-send-email-sven@narfation.org>
In-Reply-To: <1400931855-7961-1-git-send-email-sven@narfation.org>
References: <1400931855-7961-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 05/10] batadv-vis: Avoid invalid access in
	orig_list
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

The orig list parsing tries to gather information from 4 columns for each line.
The second part of the parsing routine should only be started when all
columns could be found. Otherwise parts of the variables are uninitialized.
Dereferencing iface in such a situation can cause a segfault.

Signed-off-by: Sven Eckelmann <sven@narfation.org>

---
 vis/vis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/vis/vis.c b/vis/vis.c
index 31f60d7..2928d65 100644
--- a/vis/vis.c
+++ b/vis/vis.c
@@ -350,7 +350,7 @@ static int parse_orig_list(struct globals *globals)
 			default: break;
 			}
 		}
-		if (tnum >= 4) {
+		if (tnum > 4) {
 			if (strcmp(dest, neigh) == 0) {
 				tq_val = strtol(tq, NULL, 10);
 				if (tq_val < 1 || tq_val > 255)
-- 
2.0.0.rc2


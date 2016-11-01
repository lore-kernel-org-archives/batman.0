Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue,  1 Nov 2016 13:17:25 +0100
Message-Id: <20161101121725.31181-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] alfred: vis: Add missing return for
	vis_server
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 vis/vis.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/vis/vis.c b/vis/vis.c
index 51d7f5c..22e052b 100644
--- a/vis/vis.c
+++ b/vis/vis.c
@@ -1139,6 +1139,8 @@ static int vis_server(struct globals *globals)
 		vis_update_data(globals);
 		sleep(UPDATE_INTERVAL);
 	}
+
+	return 0;
 }
 
 int main(int argc, char *argv[])
-- 
2.10.1


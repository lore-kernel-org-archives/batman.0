Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 22 Sep 2016 23:46:07 +0200
Message-Id: <20160922214607.22123-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] alfred: vis: Fix netlink function fallback
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

The netlink functions return -EOPNOTSUPP when the kernel doesn't support
the netlink command. The caller can then fall back to debugfs. So check for
-EOPNOTSUPP and not EOPNOTSUPP.

Fixes: bca55a86fecd ("alfred: vis: Add support for netlink")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 vis/vis.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/vis/vis.c b/vis/vis.c
index b865508..677f8aa 100644
--- a/vis/vis.c
+++ b/vis/vis.c
@@ -361,7 +361,7 @@ static int parse_transtable_local(struct globals *globals)
 	int ret;
 
 	ret = parse_transtable_local_netlink(globals);
-	if (ret != EOPNOTSUPP)
+	if (ret != -EOPNOTSUPP)
 		return ret;
 
 	return parse_transtable_local_debugfs(globals);
@@ -602,7 +602,7 @@ static int parse_orig_list(struct globals *globals)
 	int ret;
 
 	ret = parse_orig_list_netlink(globals);
-	if (ret != EOPNOTSUPP)
+	if (ret != -EOPNOTSUPP)
 		return ret;
 
 	return parse_orig_list_debugfs(globals);
-- 
2.9.3


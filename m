Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  6 Dec 2015 16:16:35 +0100
Message-Id: <1449414995-21885-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batmand: Switch to HTTPS version of links
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
Cc: elektra <onelektra@gmx.net>
---
 README | 2 +-
 vis.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/README b/README
index 1ddceed..b25dd77 100644
--- a/README
+++ b/README
@@ -61,6 +61,6 @@ is part of the s3d tools [2] - debian packages are available) to the vis
 servers dot draw output (on port 2004).  If you have impressive screenshots
 don't hesitate to let us know.  :-)
 
-[1] http://downloads.open-mesh.net/batman/misc/wbm2009/08-vis_zoomed.png
+[1] https://downloads.open-mesh.org/batman/misc/wbm2009/08-vis_zoomed.png
 [2] http://s3d.sourceforge.net/
 
diff --git a/vis.c b/vis.c
index d92fbe8..774d24e 100644
--- a/vis.c
+++ b/vis.c
@@ -127,7 +127,7 @@ int32_t orig_comp(void *data1, void *data2)
 }
 
 /* hashfunction to choose an entry in a hash table of given size */
-/* hash algorithm from http://en.wikipedia.org/wiki/Hash_table */
+/* hash algorithm from https://en.wikipedia.org/wiki/Hash_table */
 int32_t orig_choose(void *data, int32_t size) {
 	unsigned char *key= data;
 	uint32_t hash = 0;
-- 
2.6.2


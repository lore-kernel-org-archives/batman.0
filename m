Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue,  1 Nov 2016 13:19:37 +0100
Message-Id: <20161101121937.31890-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v2] alfred: vis: Don't fail when debugfs
	cannot be mounted
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

The vis server is supposed to use netlink when available. This allows to
work on systems without debugfs and under network namespaces. Thus it is
now not strictly required anymore to have debugfs available.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 vis/vis.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/vis/vis.c b/vis/vis.c
index f4d13c7..51d7f5c 100644
--- a/vis/vis.c
+++ b/vis/vis.c
@@ -1120,13 +1120,7 @@ static struct globals *vis_init(int argc, char *argv[])
 
 static int vis_server(struct globals *globals)
 {
-	char *debugfs_mnt;
-
-	debugfs_mnt = debugfs_mount(NULL);
-	if (!debugfs_mnt) {
-		fprintf(stderr, "Error - can't mount or find debugfs\n");
-		return EXIT_FAILURE;
-	}
+	debugfs_mount(NULL);
 
 	globals->push = (struct alfred_push_data_v0 *) globals->buf;
 	globals->vis_data = (struct vis_v1 *) (globals->buf + sizeof(*globals->push) + sizeof(struct alfred_data));
-- 
2.10.1


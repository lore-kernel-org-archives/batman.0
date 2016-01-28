Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Thu, 28 Jan 2016 04:53:13 +0100
Message-Id: <1453953196-29943-1-git-send-email-andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 1/3] alfred: vis: Use debugfs_make_path helper
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <a@unstable.cc>
Cc: b.a.t.m.a.n@lists.open-mesh.org

By using the helper, knowledge of network namespaces can be kept to
within the helper.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 vis/vis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/vis/vis.c b/vis/vis.c
index c1f8dad..d1640b6 100644
--- a/vis/vis.c
+++ b/vis/vis.c
@@ -325,7 +325,7 @@ static int parse_orig_list(struct globals *globals)
 	char path[1024];
 	struct vis_list_entry *v_entry;
 
-	snprintf(path, sizeof(path), "/sys/kernel/debug/batman_adv/%s/originators", globals->interface);
+	debugfs_make_path(DEBUG_BATIF_PATH_FMT "/" "originators", globals->interface, path, sizeof(path));
 	fbuf = read_file(path);
 	if (!fbuf)
 		return -1;
-- 
2.7.0.rc3


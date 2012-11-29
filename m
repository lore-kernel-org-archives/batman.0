Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 29 Nov 2012 01:03:31 +0100
Message-Id: <1354147411-13493-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: remove useless NULL check
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

debugfs_remove_recursive() checks whether its argument is not null
on its own, therefore it is possible to remove the external check.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 debugfs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/debugfs.c b/debugfs.c
index 6f58ddd..9df070c 100644
--- a/debugfs.c
+++ b/debugfs.c
@@ -397,10 +397,8 @@ err:
 
 void batadv_debugfs_destroy(void)
 {
-	if (batadv_debugfs) {
-		debugfs_remove_recursive(batadv_debugfs);
-		batadv_debugfs = NULL;
-	}
+	debugfs_remove_recursive(batadv_debugfs);
+	batadv_debugfs = NULL;
 }
 
 int batadv_debugfs_add_meshif(struct net_device *dev)
-- 
1.8.0


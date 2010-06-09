Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu, 10 Jun 2010 00:39:16 +0200
Message-Id: <1276123156-12293-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Ignore debugfs on kernels
	without debugfs support
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

All code for debugfs is ignored when the creation of the batman-adv root
directory in debugfs fails. It must also be ignored when the
debugfs_create_dir tells us that debugfs is not implemented to prevent a
crash during the unload of the module.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 Must be applied in both maint and trunk.

 batman-adv-kernelland/bat_debugfs.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/batman-adv-kernelland/bat_debugfs.c b/batman-adv-kernelland/bat_debugfs.c
index cf2545a..b8081e3 100644
--- a/batman-adv-kernelland/bat_debugfs.c
+++ b/batman-adv-kernelland/bat_debugfs.c
@@ -101,6 +101,8 @@ static struct bat_debuginfo *mesh_debuginfos[] = {
 void debugfs_init(void)
 {
 	bat_debugfs = debugfs_create_dir(DEBUGFS_BAT_SUBDIR, NULL);
+	if (bat_debugfs == ERR_PTR(-ENODEV))
+		bat_debugfs = NULL;
 }
 
 void debugfs_destroy(void)
-- 
1.7.1


Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 22 May 2010 13:58:20 +0200
Message-Id: <1274529500-16341-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Only fail in debugfs when kernel
	has debugfs support
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

Linux allows to call debugfs related functions even when it is not
compiled in. The return codes will always be failure return codes and we
would fail to load the batman-adv module even when debugfs isn't a hard
dependency.

We can simply return a success error code when the debugfs stub returned
a error code and the kernel was compiled without debugfs support.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv-kernelland/bat_debugfs.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/batman-adv-kernelland/bat_debugfs.c b/batman-adv-kernelland/bat_debugfs.c
index 9113601..bc1591f 100644
--- a/batman-adv-kernelland/bat_debugfs.c
+++ b/batman-adv-kernelland/bat_debugfs.c
@@ -141,7 +141,11 @@ rem_attr:
 	debugfs_remove_recursive(bat_priv->debug_dir);
 	bat_priv->debug_dir = NULL;
 out:
+#ifdef CONFIG_DEBUG_FS
 	return -ENOMEM;
+#else
+	return 0;
+#endif /* CONFIG_DEBUG_FS */
 }
 
 void debugfs_del_meshif(struct net_device *dev)
-- 
1.7.1


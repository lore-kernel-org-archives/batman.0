Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Mon,  7 Nov 2011 13:57:48 +0100
Message-Id: <1320670668-26961-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: use unregister_netdevice() when
	softif_create fails
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
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

When entering softif_create(), the rtnl lock has already been acquired
by store_mesh_iface().
(store_mesh_iface() -> hardif_enable_interface() -> softif_create)

In case of an error, we should therefore call unregister_netdevice()
instead of unregister_netdev().

unregister_netdev() tries to acquire the rtnl lock itself and deadlocks
in this situation. unregister_netdevice() assumes that the rtnl lock
is already been held.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 soft-interface.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/soft-interface.c b/soft-interface.c
index 45297c8..987c75a 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -874,7 +874,7 @@ unreg_debugfs:
 unreg_sysfs:
 	sysfs_del_meshif(soft_iface);
 unreg_soft_iface:
-	unregister_netdev(soft_iface);
+	unregister_netdevice(soft_iface);
 	return NULL;
 
 free_soft_iface:
-- 
1.7.7.1


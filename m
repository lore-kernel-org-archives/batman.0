Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 19 May 2010 16:02:02 +0200
Message-Id: <1274277722-25571-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Don't call free_netdev twice
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

Free_netdev is registered as destructor in interface_setup for every
soft_device. This destructor is automatically called from
unregister_netdev and we must not call it again for the freed
net_device.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv-kernelland/main.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/batman-adv-kernelland/main.c b/batman-adv-kernelland/main.c
index 51856a7..c9132c0 100644
--- a/batman-adv-kernelland/main.c
+++ b/batman-adv-kernelland/main.c
@@ -130,6 +130,9 @@ unreg_sysfs:
 	sysfs_del_meshif(soft_device);
 unreg_soft_device:
 	unregister_netdev(soft_device);
+	soft_device = NULL;
+	return -ENOMEM;
+
 free_soft_device:
 	free_netdev(soft_device);
 	soft_device = NULL;
-- 
1.7.1


Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 19 May 2010 21:10:52 +0200
Message-Id: <1274296252-17783-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1274269428-13203-1-git-send-email-sven.eckelmann@gmx.de>
References: <1274269428-13203-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH-maint] batman-adv: Call unregister_netdev on
	failures to get rtnl lock
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

We must call unregister_netdev when we couldn't initialise the
batman-adv module and the soft_device was registered. There are two
version of the function which we can use:
 * unregister_netdevice - removes device
 * unregister_netdev - takes rtnl semaphore and remove device

We don't hold the semaphore in a error case. So we must use
unregister_netdev.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
This patch is created for maint and should be applied using `git am`.
Following patches should be applied before:
 * batman-adv: Move device for icmp injection to debugfs
 * batman-adv: Move tables from sysfs to debugfs

 main.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/main.c b/main.c
index 770625f..6e6d925 100644
--- a/main.c
+++ b/main.c
@@ -137,7 +137,7 @@ int init_module(void)
 unreg_sysfs:
 	sysfs_del_meshif(soft_device);
 unreg_soft_device:
-	unregister_netdevice(soft_device);
+	unregister_netdev(soft_device);
 free_soft_device:
 	free_netdev(soft_device);
 	soft_device = NULL;
-- 
1.7.1


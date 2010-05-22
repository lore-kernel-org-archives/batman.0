Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 22 May 2010 16:17:06 +0200
Message-Id: <1274537833-2512-3-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <201005221616.46785.sven.eckelmann@gmx.de>
References: <201005221616.46785.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 03/10] Staging: batman-adv: Call
	unregister_netdev on failures to get rtnl lock
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
To: gregkh@suse.de
Cc: b.a.t.m.a.n@lists.open-mesh.net

We must call unregister_netdev when we couldn't initialise the
batman-adv module and the soft_device was registered. There are two
version of the function which we can use:
 * unregister_netdevice - removes device
 * unregister_netdev - takes rtnl semaphore and remove device

We don't hold the semaphore in an error situation. So we must use
unregister_netdev.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/main.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/batman-adv/main.c b/drivers/staging/batman-adv/main.c
index 9d13979..50a66b4 100644
--- a/drivers/staging/batman-adv/main.c
+++ b/drivers/staging/batman-adv/main.c
@@ -127,7 +127,7 @@ int init_module(void)
 	return 0;
 
 unreg_soft_device:
-	unregister_netdevice(soft_device);
+	unregister_netdev(soft_device);
 free_soft_device:
 	free_netdev(soft_device);
 	soft_device = NULL;
-- 
1.7.1


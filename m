Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 22 May 2010 17:48:46 +0200
Message-Id: <1274543327-2258-3-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <201005221748.17663.sven.eckelmann@gmx.de>
References: <201005221748.17663.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/4] Staging: batman-adv: Don't call
	free_netdev twice
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

Free_netdev is registered as destructor in interface_setup for every
soft_device. This destructor is automatically called from
unregister_netdev and we must not call it again for the freed
net_device.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/main.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/batman-adv/main.c b/drivers/staging/batman-adv/main.c
index 50a66b4..74c70d5 100644
--- a/drivers/staging/batman-adv/main.c
+++ b/drivers/staging/batman-adv/main.c
@@ -128,6 +128,9 @@ int init_module(void)
 
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


Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 19 May 2010 21:11:42 +0200
Message-Id: <1274296302-17845-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1274277722-25571-1-git-send-email-sven.eckelmann@gmx.de>
References: <1274277722-25571-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH-maint] batman-adv: Don't call free_netdev
	twice
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
unregister_netdev and we must not call it again for the free'd
net_device.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
This patch is created for maint and should be applied using `git am`.
Following patches should be applied before:
 * batman-adv: Move device for icmp injection to debugfs
 * batman-adv: Move tables from sysfs to debugfs
 * batman-adv: Call unregister_netdev on failures to get rtnl lock

 main.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/main.c b/main.c
index 6e6d925..6c6df6b 100644
--- a/main.c
+++ b/main.c
@@ -138,6 +138,9 @@ unreg_sysfs:
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


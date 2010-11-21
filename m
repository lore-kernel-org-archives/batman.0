Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 22 Nov 2010 00:56:06 +0100
Message-Id: <1290383767-32602-29-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
References: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 28/29] Staging: batman-adv: Use kernel
	version min macro
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
To: greg@kroah.com
Cc: b.a.t.m.a.n@lists.open-mesh.org

The kernel headers already provide different versions of a min/max macro
which should be used by all modules according to
Documentation/CodingStyle.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/hard-interface.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/batman-adv/hard-interface.c b/drivers/staging/batman-adv/hard-interface.c
index ff0ac98..4f95777 100644
--- a/drivers/staging/batman-adv/hard-interface.c
+++ b/drivers/staging/batman-adv/hard-interface.c
@@ -31,8 +31,6 @@
 
 #include <linux/if_arp.h>
 
-#define MIN(x, y) ((x) < (y) ? (x) : (y))
-
 /* protect update critical side of if_list - but not the content */
 static DEFINE_SPINLOCK(if_list_lock);
 
@@ -220,8 +218,8 @@ int hardif_min_mtu(struct net_device *soft_iface)
 		if (batman_if->soft_iface != soft_iface)
 			continue;
 
-		min_mtu = MIN(batman_if->net_dev->mtu - BAT_HEADER_LEN,
-			      min_mtu);
+		min_mtu = min_t(int, batman_if->net_dev->mtu - BAT_HEADER_LEN,
+				min_mtu);
 	}
 	rcu_read_unlock();
 out:
-- 
1.7.2.3


Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 11/11] batman-adv: Drop reduntant batadv interface check
Date: Tue,  8 Jun 2021 17:27:00 +0200
Message-Id: <20210608152700.30315-12-sw@simonwunderlich.de>
In-Reply-To: <20210608152700.30315-1-sw@simonwunderlich.de>
References: <20210608152700.30315-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: kuba@kernel.org, davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

If batadv_hardif_enable_interface is called then its called from its
callback ndo_add_slave. It is therefore not necessary to check if it is a
batadv interface.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/hard-interface.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 44b0aa30c30a..55d97e18aa4a 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -9,7 +9,6 @@
 
 #include <linux/atomic.h>
 #include <linux/byteorder/generic.h>
-#include <linux/errno.h>
 #include <linux/gfp.h>
 #include <linux/if.h>
 #include <linux/if_arp.h>
@@ -698,14 +697,6 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	kref_get(&hard_iface->refcount);
 
 	dev_hold(soft_iface);
-
-	if (!batadv_softif_is_valid(soft_iface)) {
-		pr_err("Can't create batman mesh interface %s: already exists as regular interface\n",
-		       soft_iface->name);
-		ret = -EINVAL;
-		goto err_dev;
-	}
-
 	hard_iface->soft_iface = soft_iface;
 	bat_priv = netdev_priv(hard_iface->soft_iface);
 
-- 
2.20.1


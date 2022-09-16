Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 3/4] batman-adv: Drop initialization of flexible
 ethtool_link_ksettings
Date: Fri, 16 Sep 2022 18:14:53 +0200
Message-Id: <20220916161454.1413154-4-sw@simonwunderlich.de>
In-Reply-To: <20220916161454.1413154-1-sw@simonwunderlich.de>
References: <20220916161454.1413154-1-sw@simonwunderlich.de>
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

The commit 94dfc73e7cf4 ("treewide: uapi: Replace zero-length arrays with
flexible-array members") changed various structures from using 0-length
arrays to flexible arrays

  net/batman-adv/bat_v_elp.c: note: in included file:
  ./include/linux/ethtool.h:148:38: warning: nested flexible array
  net/batman-adv/bat_v_elp.c:128:9: warning: using sizeof on a flexible structure

In theory, this could be worked around by using {} as initializer for the
variable on the stack. But this variable doesn't has to be initialized at
all by the caller of __ethtool_get_link_ksettings - everything will be
initialized by the callee when no error occurs.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_v_elp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index b6db999abf75..f1741fbfb617 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -125,7 +125,6 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 	/* if not a wifi interface, check if this device provides data via
 	 * ethtool (e.g. an Ethernet adapter)
 	 */
-	memset(&link_settings, 0, sizeof(link_settings));
 	rtnl_lock();
 	ret = __ethtool_get_link_ksettings(hard_iface->net_dev, &link_settings);
 	rtnl_unlock();
-- 
2.30.2


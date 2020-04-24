Return-Path: <yuehaibing@huawei.com>
From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] batman-adv: remove unsued inline function batadv_arp_change_timeout
Date: Fri, 24 Apr 2020 21:14:37 +0800
Message-ID: <20200424131437.48124-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc, sven@narfation.org, davem@davemloft.net, kuba@kernel.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>

There's no callers in-tree.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/batman-adv/distributed-arp-table.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.h b/net/batman-adv/distributed-arp-table.h
index 2bff2f4a325c..4e031661682a 100644
--- a/net/batman-adv/distributed-arp-table.h
+++ b/net/batman-adv/distributed-arp-table.h
@@ -163,11 +163,6 @@ static inline void batadv_dat_init_own_addr(struct batadv_priv *bat_priv,
 {
 }
 
-static inline void batadv_arp_change_timeout(struct net_device *soft_iface,
-					     const char *name)
-{
-}
-
 static inline int batadv_dat_init(struct batadv_priv *bat_priv)
 {
 	return 0;
-- 
2.17.1



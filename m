Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  7 Oct 2017 08:54:09 +0200
Message-Id: <20171007065409.22412-2-sven@narfation.org>
In-Reply-To: <20171007065409.22412-1-sven@narfation.org>
References: <20171007065409.22412-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [RFC 2/2] batman-adv: Add extack to upper device
 linking
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

From: David Ahern <dsahern@gmail.com>

Add extack arg to netdev_upper_dev_link and netdev_master_upper_dev_link

Signed-off-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
This change is already part of net-next (queued up for 4.15) we must
therefore apply it after the compat code was added.

 net/batman-adv/hard-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index d4aa99c0..4e3d5340 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -738,7 +738,7 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	bat_priv = netdev_priv(hard_iface->soft_iface);
 
 	ret = netdev_master_upper_dev_link(hard_iface->net_dev,
-					   soft_iface, NULL, NULL);
+					   soft_iface, NULL, NULL, NULL);
 	if (ret)
 		goto err_dev;
 
-- 
2.11.0


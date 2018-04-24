Return-Path: <luc.vanoostenryck@gmail.com>
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date: Tue, 24 Apr 2018 15:18:46 +0200
Message-Id: <20180424131847.5469-1-luc.vanoostenryck@gmail.com>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix batadv_interface_tx()'s
 return type
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>, "David S. Miller" <davem@davemloft.net>, b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, but the implementation in this
driver returns an 'int'.

Fix this by returning 'netdev_tx_t' in this driver too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 net/batman-adv/soft-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index edeffcb9f..e6c800b06 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -188,7 +188,7 @@ static void batadv_interface_set_rx_mode(struct net_device *dev)
 {
 }
 
-static int batadv_interface_tx(struct sk_buff *skb,
+static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 			       struct net_device *soft_iface)
 {
 	struct ethhdr *ethhdr;
-- 
2.17.0


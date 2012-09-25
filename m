Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 25 Sep 2012 17:57:16 +0200
Message-Id: <1348588637-18441-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1348588637-18441-1-git-send-email-ordex@autistici.org>
References: <1348588637-18441-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH net 1/2] batman-adv: Fix change mac address
	of soft iface.
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Def <def@laposte.net>

Into function interface_set_mac_addr, the function tt_local_add was
invoked before updating dev->dev_addr. The new MAC address was not
tagged as NoPurge.

Signed-off-by: Def <def@laposte.net>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/soft-interface.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 109ea2a..21c5357 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -100,18 +100,21 @@ static int batadv_interface_set_mac_addr(struct net_device *dev, void *p)
 {
 	struct batadv_priv *bat_priv = netdev_priv(dev);
 	struct sockaddr *addr = p;
+	uint8_t old_addr[ETH_ALEN];
 
 	if (!is_valid_ether_addr(addr->sa_data))
 		return -EADDRNOTAVAIL;
 
+	memcpy(old_addr, dev->dev_addr, ETH_ALEN);
+	memcpy(dev->dev_addr, addr->sa_data, ETH_ALEN);
+
 	/* only modify transtable if it has been initialized before */
 	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_ACTIVE) {
-		batadv_tt_local_remove(bat_priv, dev->dev_addr,
+		batadv_tt_local_remove(bat_priv, old_addr,
 				       "mac address changed", false);
 		batadv_tt_local_add(dev, addr->sa_data, BATADV_NULL_IFINDEX);
 	}
 
-	memcpy(dev->dev_addr, addr->sa_data, ETH_ALEN);
 	dev->addr_assign_type &= ~NET_ADDR_RANDOM;
 	return 0;
 }
-- 
1.7.12


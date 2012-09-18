Return-Path: <defdef128@gmail.com>
MIME-Version: 1.0
Sender: defdef128@gmail.com
Date: Tue, 18 Sep 2012 16:41:58 +0200
Message-ID: <CANMkaozByUVfK9h_UAY08UDCZd6xJWg7NqPpCTWJfsyaBnEJEA@mail.gmail.com>
From: Def <def@laposte.net>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix change mac address of soft
	iface.
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
To: b.a.t.m.a.n@lists.open-mesh.org

 Into function interface_set_mac_addr, the function tt_local_add
 was invoked before updating dev->dev_addr. The new MAC
 addresse was not tagged as NoPurge.

---
 soft-interface.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/soft-interface.c b/soft-interface.c
index cf26e41..1345b86
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -100,18 +100,21 @@ static int batadv_interface_set_mac_addr(struct
net_device *dev, void *p)
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
-
-	memcpy(dev->dev_addr, addr->sa_data, ETH_ALEN);
+	
 	dev->addr_assign_type &= ~NET_ADDR_RANDOM;
 	return 0;
 }
-- 
1.7.10.4

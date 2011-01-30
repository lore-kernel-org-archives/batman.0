Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@saxnet.de>
Date: Sun, 30 Jan 2011 05:39:24 +0100
Message-Id: <1296362366-3852-17-git-send-email-linus.luessing@saxnet.de>
In-Reply-To: <1296362366-3852-1-git-send-email-linus.luessing@saxnet.de>
References: <1296362366-3852-1-git-send-email-linus.luessing@saxnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 16/18] batman-adv: Still flood multicast
	packets we are not a receiver of
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
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@saxnet.de>

We may only optimize the multicast packet flow, if an mcast_mode has been
activated and if we are a multicast receiver of the same group. Otherwise
flood the multicast packet without optimizations.

This allows us to still flood multicast packets of protocols where it is
not easily possible for a multicast sender to be a multicast receiver of
the same group instead of dropping them (for instance IPv6 NDP).

This commit therefore also makes IPv6 usable again, if the
proact_tracking multicast mode has been activated.

Signed-off-by: Linus Lüssing <linus.luessing@saxnet.de>
---
 soft-interface.c |   28 ++++++++++++++++++++++++++--
 1 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/batman-adv/soft-interface.c b/batman-adv/soft-interface.c
index 3e16522..c4b2f6f 100644
--- a/batman-adv/soft-interface.c
+++ b/batman-adv/soft-interface.c
@@ -340,6 +340,31 @@ static int interface_change_mtu(struct net_device *dev, int new_mtu)
 	return 0;
 }
 
+static int mcast_may_optimize(uint8_t *dest, struct net_device *soft_iface)
+{
+	struct netdev_hw_addr *mc_entry;
+	struct bat_priv *bat_priv = netdev_priv(soft_iface);
+	int mcast_mode = atomic_read(&bat_priv->mcast_mode);
+
+	if (mcast_mode != MCAST_MODE_PROACT_TRACKING)
+		return 0;
+
+	/* Still allow flooding of multicast packets of protocols where it is
+	 * not easily possible for a multicast sender to be a multicast
+	 * receiver of the same group (for instance IPv6 NDP) */
+	netif_addr_lock_bh(soft_iface);
+	netdev_for_each_mc_addr(mc_entry, soft_iface) {
+		if (memcmp(dest, mc_entry->addr, ETH_ALEN))
+			continue;
+
+		netif_addr_unlock_bh(soft_iface);
+		return 1;
+	}
+	netif_addr_unlock_bh(soft_iface);
+
+	return 0;
+}
+
 int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 {
 	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
@@ -392,8 +417,7 @@ int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 
 		if (is_broadcast_ether_addr(ethhdr->h_dest))
 			bcast_dst = true;
-		else if (atomic_read(&bat_priv->mcast_mode) ==
-			 MCAST_MODE_PROACT_TRACKING)
+		else if (mcast_may_optimize(ethhdr->h_dest, soft_iface))
 			mcast_dst = true;
 		else
 			bcast_dst = true;
-- 
1.7.2.3


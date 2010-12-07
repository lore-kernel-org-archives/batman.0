Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@saxnet.de>
Date: Tue,  7 Dec 2010 23:32:28 +0100
Message-Id: <1291761150-29818-18-git-send-email-linus.luessing@saxnet.de>
In-Reply-To: <20101207221351.GA19474@Sellars>
References: <20101207221351.GA19474@Sellars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 18/20] batman-adv: Still flood multicast
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
 multicast.c      |   25 +++++++++++++++++++++++++
 multicast.h      |    1 +
 soft-interface.c |    2 +-
 3 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/multicast.c b/multicast.c
index 042d392..1f84f7c 100644
--- a/multicast.c
+++ b/multicast.c
@@ -107,6 +107,31 @@ void mcast_tracker_reset(struct bat_priv *bat_priv)
 	start_mcast_tracker(bat_priv);
 }
 
+inline int mcast_may_optimize(uint8_t *dest, struct net_device *soft_iface) {
+	MC_LIST *mc_entry;
+	unsigned long flags;
+	struct bat_priv *bat_priv = netdev_priv(soft_iface);
+	int mcast_mode = atomic_read(&bat_priv->mcast_mode);
+
+	if (mcast_mode != MCAST_MODE_PROACT_TRACKING)
+		return 0;
+
+	/* Still allow flooding of multicast packets of protocols where it is
+	 * not easily possible for a multicast sender to be a multicast
+	 * receiver of the same group (for instance IPv6 NDP) */
+	MC_LIST_LOCK(soft_iface, flags);
+	netdev_for_each_mc_addr(mc_entry, soft_iface) {
+		if (memcmp(dest, mc_entry->MC_LIST_ADDR, ETH_ALEN))
+			continue;
+
+		MC_LIST_UNLOCK(soft_iface, flags);
+		return 1;
+	}
+	MC_LIST_UNLOCK(soft_iface, flags);
+
+	return 0;
+}
+
 static inline int get_remaining_timeout(
 				struct mcast_forw_nexthop_entry *nexthop_entry,
 				struct bat_priv *bat_priv)
diff --git a/multicast.h b/multicast.h
index 6dcf537..630a0ae 100644
--- a/multicast.h
+++ b/multicast.h
@@ -27,6 +27,7 @@ int mcast_tracker_interval_set(struct net_device *net_dev, char *buff,
 int mcast_tracker_timeout_set(struct net_device *net_dev, char *buff,
 			       size_t count);
 void mcast_tracker_reset(struct bat_priv *bat_priv);
+int mcast_may_optimize(uint8_t *dest, struct net_device *soft_iface);
 void route_mcast_tracker_packet(
 			struct mcast_tracker_packet *tracker_packet,
 			int tracker_packet_len, struct bat_priv *bat_priv);
diff --git a/soft-interface.c b/soft-interface.c
index 2a5a728..444028d 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -391,7 +391,7 @@ int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 
 		if (is_broadcast_ether_addr(ethhdr->h_dest))
 			bcast_dst = true;
-		else if (atomic_read(&bat_priv->mcast_mode) == MCAST_MODE_PROACT_TRACKING)
+		else if (mcast_may_optimize(ethhdr->h_dest, soft_iface))
 			mcast_dst = true;
 		else
 			bcast_dst = true;
-- 
1.7.1


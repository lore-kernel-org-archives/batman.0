Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 17 Feb 2012 22:18:46 +0100
Message-Id: <1329513526-18980-1-git-send-email-sven@narfation.org>
In-Reply-To: <1329493411-25750-7-git-send-email-danny.kukawka@bisect.de>
References: <1329493411-25750-7-git-send-email-danny.kukawka@bisect.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: use eth_hw_addr_random() instead
	of random_ether_addr()
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

From: Danny Kukawka <danny.kukawka@bisect.de>

Use eth_hw_addr_random() instead of calling random_ether_addr()
to set addr_assign_type correctly to NET_ADDR_RANDOM.

Remove dev_addr in interface_setup(), it's not needed anymore.

Reset the state to NET_ADDR_PERM as soon as the MAC get
changed via .ndo_set_mac_address.

v2: use bitops, adapt to eth_hw_addr_random()

Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>
[sven@narfation.org: Backported it to linux 2.6.29]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Important: This patch was already applied by David S. Miller in net-next.git
and will be part of linux 3.3. So we have to apply this one in next. This patch
should also never be sent to David (he already has it).

The merge of next into master will be a little bit messy. Just delete the
definition of dev_hw_addr_random in compat.h and use eth_hw_addr_random in
soft-interface.c

 compat.h         |   14 ++++++++++++++
 soft-interface.c |    5 ++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/compat.h b/compat.h
index 7f86b41..95b8706 100644
--- a/compat.h
+++ b/compat.h
@@ -104,6 +104,10 @@ static inline int __param_set_copystring(const char *val,
 }
 #define param_set_copystring __param_set_copystring
 
+/* hack for dev->addr_assign_type &= ~NET_ADDR_RANDOM; */
+#define addr_assign_type ifindex
+#define NET_ADDR_RANDOM 0
+
 #endif /* < KERNEL_VERSION(2, 6, 36) */
 
 
@@ -126,4 +130,14 @@ void free_rcu_tt_local_entry(struct rcu_head *rcu);
 
 #endif /* < KERNEL_VERSION(3, 0, 0) */
 
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 3, 0)
+
+static inline void eth_hw_addr_random(struct net_device *dev)
+{
+	random_ether_addr(dev->dev_addr);
+}
+
+#endif /* < KERNEL_VERSION(3, 0, 0) */
+
 #endif /* _NET_BATMAN_ADV_COMPAT_H_ */
diff --git a/soft-interface.c b/soft-interface.c
index 2ffdc74..37fbcb5 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -541,6 +541,7 @@ static int interface_set_mac_addr(struct net_device *dev, void *p)
 	}
 
 	memcpy(dev->dev_addr, addr->sa_data, ETH_ALEN);
+	dev->addr_assign_type &= ~NET_ADDR_RANDOM;
 	return 0;
 }
 
@@ -783,7 +784,6 @@ static const struct net_device_ops bat_netdev_ops = {
 static void interface_setup(struct net_device *dev)
 {
 	struct bat_priv *priv = netdev_priv(dev);
-	char dev_addr[ETH_ALEN];
 
 	ether_setup(dev);
 
@@ -800,8 +800,7 @@ static void interface_setup(struct net_device *dev)
 	dev->hard_header_len = BAT_HEADER_LEN;
 
 	/* generate random address */
-	random_ether_addr(dev_addr);
-	memcpy(dev->dev_addr, dev_addr, ETH_ALEN);
+	eth_hw_addr_random(dev);
 
 	SET_ETHTOOL_OPS(dev, &bat_ethtool_ops);
 
-- 
1.7.2.5


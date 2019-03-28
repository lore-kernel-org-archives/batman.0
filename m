Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 28 Mar 2019 16:31:27 +0100
Message-Id: <20190328153127.19931-6-sw@simonwunderlich.de>
In-Reply-To: <20190328153127.19931-1-sw@simonwunderlich.de>
References: <20190328153127.19931-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 5/5] batman-adv: Fix genl notification for
 throughput_override
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

The throughput_override sysfs file is not below the meshif but below a
hardif. The kobj has therefore not a pointer which can be used to find the
batadv_priv data. The pointer stored in the hardif object must be used
instead to find the correct meshif private data.

Fixes: 7e6f461efe25 ("batman-adv: Trigger genl notification on sysfs config change")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/sysfs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index 0b4b3fb778a6..208655cf6717 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -1116,9 +1116,9 @@ static ssize_t batadv_store_throughput_override(struct kobject *kobj,
 						struct attribute *attr,
 						char *buff, size_t count)
 {
-	struct batadv_priv *bat_priv = batadv_kobj_to_batpriv(kobj);
 	struct net_device *net_dev = batadv_kobj_to_netdev(kobj);
 	struct batadv_hard_iface *hard_iface;
+	struct batadv_priv *bat_priv;
 	u32 tp_override;
 	u32 old_tp_override;
 	bool ret;
@@ -1147,7 +1147,10 @@ static ssize_t batadv_store_throughput_override(struct kobject *kobj,
 
 	atomic_set(&hard_iface->bat_v.throughput_override, tp_override);
 
-	batadv_netlink_notify_hardif(bat_priv, hard_iface);
+	if (hard_iface->soft_iface) {
+		bat_priv = netdev_priv(hard_iface->soft_iface);
+		batadv_netlink_notify_hardif(bat_priv, hard_iface);
+	}
 
 out:
 	batadv_hardif_put(hard_iface);
-- 
2.11.0


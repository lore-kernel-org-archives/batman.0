Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  3 Mar 2019 19:25:26 +0100
Message-Id: <20190303182526.925-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix genl notification for
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
To: b.a.t.m.a.n@lists.open-mesh.org

The throughput_override sysfs file is not below the meshif but below a
hardif. The kobj has therefore not a pointer which can be used to find the
batadv_priv data. The pointer stored in the hardif object must be used
instead to find the correct meshif private data.

Fixes: 68e981a3a261 ("batman-adv: Trigger genl notification on sysfs config change")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/sysfs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index 0b4b3fb7..208655cf 100644
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
2.20.1


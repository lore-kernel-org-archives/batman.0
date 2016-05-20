Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 20 May 2016 20:49:40 +0200
Message-Id: <1463770180-4030-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix returned error in
	batadv_netlink_tp_meter_cancel
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

From: Simon Wunderlich <sw@simonwunderlich.de>

The BATADV_CMD_TP_METER_CANCEL netlink cmd can for example fail when no
valid soft_iface can be found. This error should not only detected but
also be reported back to the caller.

Fixes: 98d7a766b645 ("batman-adv: throughput meter implementation")
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 56e63ce..c25bbb8 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -350,7 +350,7 @@ batadv_netlink_tp_meter_cancel(struct sk_buff *skb, struct genl_info *info)
 	struct batadv_priv *bat_priv;
 	int ifindex;
 	u8 *dst;
-	int ret;
+	int ret = 0;
 
 	if (!info->attrs[BATADV_ATTR_MESH_IFINDEX])
 		return -EINVAL;
@@ -377,7 +377,7 @@ out:
 	if (soft_iface)
 		dev_put(soft_iface);
 
-	return 0;
+	return ret;
 }
 
 static struct genl_ops batadv_netlink_ops[] = {
-- 
2.8.1


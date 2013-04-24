Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed, 24 Apr 2013 17:42:56 +0200
Message-Id: <1366818176-21765-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCH-maint] net: vlan: add protocol argument to
	packet tagging functions
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

From: Patrick McHardy <kaber@trash.net>

Add a protocol argument to the VLAN packet tagging functions. In case of HW
tagging, we need that protocol available in the ndo_start_xmit functions,
so it is stored in a new field in the skb. The new field fits into a hole
(on 64 bit) and doesn't increase the sks's size.

Signed-off-by: Patrick McHardy <kaber@trash.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
[siwu@hrz.tu-chemnitz.de: added compat code]
Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 bridge_loop_avoidance.c |    2 +-
 compat.h                |   16 +++++++++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 6a4f728..379061c 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -341,7 +341,7 @@ static void batadv_bla_send_claim(struct batadv_priv *bat_priv, uint8_t *mac,
 	}
 
 	if (vid != -1)
-		skb = vlan_insert_tag(skb, vid);
+		skb = vlan_insert_tag(skb, htons(ETH_P_8021Q), vid);
 
 	skb_reset_mac_header(skb);
 	skb->protocol = eth_type_trans(skb, soft_iface);
diff --git a/compat.h b/compat.h
index 0663df5..c1dadac 100644
--- a/compat.h
+++ b/compat.h
@@ -170,7 +170,7 @@ static const struct { \
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 0, 0)
 
 #define kfree_rcu(ptr, rcu_head) call_rcu(&ptr->rcu_head, batadv_free_rcu_##ptr)
-#define vlan_insert_tag(skb, vid) __vlan_put_tag(skb, vid)
+#define vlan_insert_tag(skb, proto, vid) __vlan_put_tag(skb, vid)
 
 void batadv_free_rcu_gw_node(struct rcu_head *rcu);
 void batadv_free_rcu_neigh_node(struct rcu_head *rcu);
@@ -278,4 +278,18 @@ static int __batadv_interface_set_mac_addr(x, y)
 
 #endif /* < KERNEL_VERSION(3, 9, 0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 10, 0)
+
+#ifndef vlan_insert_tag
+
+/* include this header early to let the following define
+ * not mess up the original function prototype.
+ */
+#include <linux/if_vlan.h>
+#define vlan_insert_tag(skb, proto, vid) vlan_insert_tag(skb, vid)
+
+#endif /* vlan_insert_tag */
+
+#endif /* < KERNEL_VERSION(3, 10, 0) */
+
 #endif /* _NET_BATMAN_ADV_COMPAT_H_ */
-- 
1.7.10.4


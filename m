Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  7 Oct 2017 14:18:52 +0200
Message-Id: <20171007121853.6278-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: Add extack to ndo_add_slave
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

From: David Ahern <dsahern@gmail.com>

Pass extack to do_set_master and down to ndo_add_slave

Signed-off-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[sven@narfation.org: Add compat code]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat.h                        | 7 +++++++
 net/batman-adv/soft-interface.c | 3 ++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/compat.h b/compat.h
index e43c4136..c10ad589 100644
--- a/compat.h
+++ b/compat.h
@@ -152,4 +152,11 @@ static int __batadv_interface_kill_vid(struct net_device *dev, __be16 proto,\
 
 #endif /* < KERNEL_VERSION(4, 6, 0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 15, 0)
+
+#define batadv_softif_slave_add(__dev, __slave_dev, __extack) \
+	batadv_softif_slave_add(__dev, __slave_dev)
+
+#endif /* < KERNEL_VERSION(4, 15, 0) */
+
 #endif /* _NET_BATMAN_ADV_COMPAT_H_ */
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 3af4b0b2..543d2c3e 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -867,7 +867,8 @@ static int batadv_softif_init_late(struct net_device *dev)
  * Return: 0 if successful or error otherwise.
  */
 static int batadv_softif_slave_add(struct net_device *dev,
-				   struct net_device *slave_dev)
+				   struct net_device *slave_dev,
+				   struct netlink_ext_ack *extack)
 {
 	struct batadv_hard_iface *hard_iface;
 	struct net *net = dev_net(dev);
-- 
2.11.0


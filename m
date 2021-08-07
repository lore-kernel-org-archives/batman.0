Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 1/2] batman-adv: compat: add the case if dev is NULL
Date: Sat,  7 Aug 2021 07:19:41 +0200
Message-Id: <20210807051942.38538-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org

From: Yajun Deng <yajun.deng@linux.dev>

Add the case if dev is NULL in dev_{put, hold}, so the caller doesn't
need to care whether dev is NULL or not.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
Signed-off-by: David S. Miller <davem@davemloft.net>
[sven@narfation.org: Convert to compat code]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat-include/linux/netdevice.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/compat-include/linux/netdevice.h b/compat-include/linux/netd=
evice.h
index 8f01b48f..9a62afcc 100644
--- a/compat-include/linux/netdevice.h
+++ b/compat-include/linux/netdevice.h
@@ -67,4 +67,27 @@ static inline int batadv_netif_rx_any_context(struct s=
k_buff *skb)
=20
 #endif /* LINUX_VERSION_IS_LESS(5, 10, 0) */
=20
+
+#if LINUX_VERSION_IS_LESS(5, 15, 0)
+
+static inline void batadv_dev_put(struct net_device *dev)
+{
+	if (!dev)
+		return;
+
+	dev_put(dev);
+}
+#define dev_put batadv_dev_put
+
+static inline void batadv_dev_hold(struct net_device *dev)
+{
+	if (!dev)
+		return;
+
+	dev_hold(dev);
+}
+#define dev_hold batadv_dev_hold
+
+#endif /* LINUX_VERSION_IS_LESS(5, 15, 0) */
+
 #endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_NETDEVICE_H_ */
--=20
2.30.2

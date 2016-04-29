Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Sat, 30 Apr 2016 00:59:15 +0200
Message-Id: <1461970765-24615-3-git-send-email-andrew@lunn.ch>
In-Reply-To: <1461970765-24615-1-git-send-email-andrew@lunn.ch>
References: <1461970765-24615-1-git-send-email-andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH v2 02/12] batman-adv: compat.h: Add
	workaround for get_link_net()
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 compat.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/compat.h b/compat.h
index 5a5f478..f746163 100644
--- a/compat.h
+++ b/compat.h
@@ -137,9 +137,15 @@ static int __batadv_interface_kill_vid(struct net_device *dev, __be16 proto,\
 #warning cfg80211 based throughput metric is only supported with Linux 3.15+
 
 #endif
-
 #endif /* < KERNEL_VERSION(3, 15, 0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 0, 0)
+
+/* WARNING for batadv_getlink_net */
+#define get_link_net get_xstats_size || 1 || netdev->rtnl_link_ops->get_xstats_size
+
+#endif /* < KERNEL_VERSION(4, 0, 0) */
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4, 3, 0)
 
 #define IFF_NO_QUEUE	0; dev->tx_queue_len = 0
-- 
2.8.0.rc3


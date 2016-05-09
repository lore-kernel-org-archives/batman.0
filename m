Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Mon,  9 May 2016 20:07:09 +0200
Message-Id: <1462817239-18104-3-git-send-email-andrew@lunn.ch>
In-Reply-To: <1462817239-18104-1-git-send-email-andrew@lunn.ch>
References: <1462817239-18104-1-git-send-email-andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCHv4 02/12] batman-adv: compat.h: Add workaround
	for get_link_net()
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
v2: Fix accidental newline deletion
---
 compat.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/compat.h b/compat.h
index 5a5f478..813e637 100644
--- a/compat.h
+++ b/compat.h
@@ -140,6 +140,13 @@ static int __batadv_interface_kill_vid(struct net_device *dev, __be16 proto,\
 
 #endif /* < KERNEL_VERSION(3, 15, 0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 0, 0)
+
+/* WARNING for batadv_getlink_net */
+#define get_link_net get_xstats_size || 0 || netdev->rtnl_link_ops->get_xstats_size
+
+#endif /* < KERNEL_VERSION(4, 0, 0) */
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4, 3, 0)
 
 #define IFF_NO_QUEUE	0; dev->tx_queue_len = 0
-- 
2.8.0.rc3


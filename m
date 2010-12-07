Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@saxnet.de>
Date: Tue,  7 Dec 2010 23:32:13 +0100
Message-Id: <1291761150-29818-3-git-send-email-linus.luessing@saxnet.de>
In-Reply-To: <20101207221351.GA19474@Sellars>
References: <20101207221351.GA19474@Sellars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 03/20] batman-adv: compat macros/defines for
	local multicast group fetching
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

The data structures and locking mechanisms for fetching multicast mac
addresses from a net_device have changed a little between kernel
versions 2.6.21 to 2.6.35.

Therefore this commit backports two macros (netdev_mc_count(),
netdev_for_each_mc_addr()) for older kernel versions and abstracts the
way of locking and accessing the variables with own customized macros.

Signed-off-by: Linus Lüssing <linus.luessing@saxnet.de>
---
 compat.h |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/compat.h b/compat.h
index b01455f..bbb1dad 100644
--- a/compat.h
+++ b/compat.h
@@ -264,4 +264,53 @@ int bat_seq_printf(struct seq_file *m, const char *f, ...);
 
 #endif /* < KERNEL_VERSION(2, 6, 29) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 34)
+
+#define netdev_mc_count(dev) ((dev)->mc_count)
+#define netdev_for_each_mc_addr(mclist, dev) \
+	for (mclist = dev->mc_list; mclist; mclist = mclist->next)
+
+#endif /* < KERNEL_VERSION(2, 6, 34) */
+
+
+/*
+ * net_device - multicast list handling
+ * 	structures
+ */
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 35)
+
+#define MC_LIST struct dev_addr_list
+#define MC_LIST_ADDR da_addr
+
+#endif /* < KERNEL_VERSION(2, 6, 35) */
+
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2, 6, 34)
+
+#define MC_LIST struct netdev_hw_addr_list_mc
+#define MC_LIST_ADDR addr
+
+#endif /* > KERNEL_VERSION(2, 6, 34) */
+
+/*
+ * net_device - multicast list handling
+ * 	locking
+ */
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 27)
+
+#define MC_LIST_LOCK(soft_iface, flags) \
+		spin_lock_irqsave(&soft_iface->_xmit_lock, flags)
+#define MC_LIST_UNLOCK(soft_iface, flags) \
+		spin_unlock_irqrestore(&soft_iface->_xmit_lock, flags)
+
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 27) */
+
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2, 6, 26)
+
+#define MC_LIST_LOCK(soft_iface, flags) \
+		spin_lock_irqsave(&soft_iface->addr_list_lock, flags)
+#define MC_LIST_UNLOCK(soft_iface, flags) \
+		spin_unlock_irqrestore(&soft_iface->addr_list_lock, flags)
+
+#endif /* > KERNEL_VERSION(2, 6, 26) */
+
 #endif /* _NET_BATMAN_ADV_COMPAT_H_ */
-- 
1.7.1


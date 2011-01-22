Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@saxnet.de>
Date: Sat, 22 Jan 2011 02:21:26 +0100
Message-Id: <1295659302-7171-4-git-send-email-linus.luessing@saxnet.de>
In-Reply-To: <1295659302-7171-1-git-send-email-linus.luessing@saxnet.de>
References: <1295659302-7171-1-git-send-email-linus.luessing@saxnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 03/19] batman-adv: compat macros/defines for
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
 compat.h |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/batman-adv/compat.h b/batman-adv/compat.h
index 6074969..ffeec34 100644
--- a/batman-adv/compat.h
+++ b/batman-adv/compat.h
@@ -270,4 +270,44 @@ int bat_seq_printf(struct seq_file *m, const char *f, ...);
 
 #endif /* < KERNEL_VERSION(2, 6, 33) */
 
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
+ *	structures
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
+ *	locking
+ */
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 27)
+
+#define netif_addr_lock_bh(soft_iface) \
+		netif_tx_lock_bh(soft_iface)
+#define netif_addr_unlock_bh(soft_iface) \
+		netif_tx_unlock_bh(soft_iface)
+
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 27) */
+
 #endif /* _NET_BATMAN_ADV_COMPAT_H_ */
-- 
1.7.2.3


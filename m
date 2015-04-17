Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 17 Apr 2015 18:34:19 +0200
Message-Id: <1429288461-26260-4-git-send-email-sven@narfation.org>
In-Reply-To: <1429288461-26260-1-git-send-email-sven@narfation.org>
References: <13114664.Eg4ODy7KEo@bentobox>
 <1429288461-26260-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH-next 4/6] dev: introduce dev_get_iflink()
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

From: Nicolas Dichtel <nicolas.dichtel@6wind.com>

The goal of this patch is to prepare the removal of the iflink field. It
introduces a new ndo function, which will be implemented by virtual interfaces.

There is no functional change into this patch. All readers of iflink field
now call dev_get_iflink().

Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[sven@narfation.org: added compat code]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
This has to be moved to linux/netdevice.h for
https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2015-April/012960.html

 compat.h         | 6 ++++++
 hard-interface.c | 5 +++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/compat.h b/compat.h
index 45412b0..0332296 100644
--- a/compat.h
+++ b/compat.h
@@ -482,4 +482,10 @@ static inline bool seq_has_overflowed(struct seq_file *m)
 
 #endif /* < KERNEL_VERSION(3, 19, 0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 1, 0)
+
+#define dev_get_iflink(_net_dev) ((_net_dev)->iflink)
+
+#endif /* < KERNEL_VERSION(3, 19, 0) */
+
 #endif /* _NET_BATMAN_ADV_COMPAT_H_ */
diff --git a/hard-interface.c b/hard-interface.c
index fbda6b5..baf1f98 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -83,11 +83,12 @@ static bool batadv_is_on_batman_iface(const struct net_device *net_dev)
 		return true;
 
 	/* no more parents..stop recursion */
-	if (net_dev->iflink == 0 || net_dev->iflink == net_dev->ifindex)
+	if (dev_get_iflink(net_dev) == 0 ||
+	    dev_get_iflink(net_dev) == net_dev->ifindex)
 		return false;
 
 	/* recurse over the parent device */
-	parent_dev = __dev_get_by_index(&init_net, net_dev->iflink);
+	parent_dev = __dev_get_by_index(&init_net, dev_get_iflink(net_dev));
 	/* if we got a NULL parent_dev there is something broken.. */
 	if (WARN(!parent_dev, "Cannot find parent device"))
 		return false;
-- 
2.1.4


Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 20 Feb 2013 15:57:31 +0100
Message-Id: <1361372251-27623-1-git-send-email-ordex@autistici.org>
In-Reply-To: <20130220144025.GP3523@ritirata.org>
References: <20130220144025.GP3523@ritirata.org>
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: add compat support for the new
	netlink ops
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

This patches enable the new rtnl ops to compile on kernels starting from 2.6.32

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

v2:
 - do not handle ioctl. just return EOPNOTSUPP

 compat.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/compat.h b/compat.h
index 425b3d9..23ced4a 100644
--- a/compat.h
+++ b/compat.h
@@ -71,6 +71,9 @@ static inline void batadv_this_cpu_add(uint64_t *count_ptr, size_t count)
 	put_cpu();
 }
 
+#define batadv_softif_destroy_netlink(dev, head) batadv_softif_destroy_netlink(dev)
+#define unregister_netdevice_queue(dev, head) unregister_netdevice(dev)
+
 #endif /* < KERNEL_VERSION(2, 6, 33) */
 
 
@@ -132,6 +135,24 @@ static inline int batadv_param_set_copystring(const char *val,
 #define kstrtoul strict_strtoul
 #define kstrtol  strict_strtol
 
+#define batadv_softif_slave_add(x, y) \
+batadv_softif_slave_add(struct net_device *dev, struct ifreq *rq, int cmd)\
+{\
+	return -EOPNOTSUPP;\
+}\
+static int __attribute__((unused)) __batadv_softif_slave_add(x, y)
+
+#define batadv_softif_slave_del(x, y) \
+__batadv_softif_slave_del(struct net_device *dev, struct net_device *slave_dev);\
+static int batadv_softif_slave_del(struct net_device *dev, struct ifreq *rq, int cmd)\
+{\
+	return -EOPNOTSUPP;\
+}\
+static int __attribute__((unused)) __batadv_softif_slave_del(x, y)
+
+#define ndo_add_slave ndo_do_ioctl
+#define ndo_del_slave ndo_do_ioctl
+
 #endif /* < KERNEL_VERSION(2, 6, 39) */
 
 
-- 
1.8.1.2


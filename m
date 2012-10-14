Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 14 Oct 2012 14:46:57 +0200
Message-Id: <1350218817-18871-1-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <10556116.CPovbmhTyy@sven-laptop.home.narfation.org>
References: <10556116.CPovbmhTyy@sven-laptop.home.narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: dirty hack to recompute mac_len
	in the rx path
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
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

It is possible that the mac_len is not properly exported because of
strange device configuration (this behaviour has been observed when
using batman-adv on top of a vlan interface). Therefore it is needed to
explicitly recompute it at the very beginning of the rx path.

This is done by appending the recompute function to the skb_share_mac()
function, hence the "dirty hack" in the subject. We expect this problem to
be fixed in linux 3.8 and above.

Reported-by: Antonio Quartulli <ordex@autistici.org>
Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---

this is a rewrite of Antonios patch
"batman-adv: recompute mac_len at the beginning of the rx path". It is
intended to fix the issue for out-of-kernel releases, without hurting
the in-kernel code too much. Obviously, this patch won't go upstream
into the kernel.

This version includes Svens "more sane" version, and also has implements
skb_reset_mac_len() for kernels prior to 3.0.
---
 compat.h |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/compat.h b/compat.h
index 14969e0..47223f5 100644
--- a/compat.h
+++ b/compat.h
@@ -137,6 +137,11 @@ void batadv_free_rcu_neigh_node(struct rcu_head *rcu);
 void batadv_free_rcu_tt_local_entry(struct rcu_head *rcu);
 void batadv_free_rcu_backbone_gw(struct rcu_head *rcu);
 
+static inline void skb_reset_mac_len(struct sk_buff *skb)
+{
+	skb->mac_len = skb->network_header - skb->mac_header;
+}
+
 #endif /* < KERNEL_VERSION(3, 0, 0) */
 
 
@@ -159,4 +164,23 @@ static inline void eth_hw_addr_random(struct net_device *dev)
 
 #endif /* < KERNEL_VERSION(3, 5, 0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 8, 0)
+
+/* hack for not correctly set mac_len. This may happen for some special
+ * configurations like batman-adv on VLANs.
+ *
+ * This is pretty dirty, but we only use skb_share_check() in main.c right
+ * before mac_len is checked, and the recomputation shouldn't hurt too much.
+ */
+#define skb_share_check(skb, b) \
+	({ \
+		struct sk_buff *_t_skb; \
+		_t_skb = skb_share_check(skb, b); \
+		if (_t_skb) \
+			skb_reset_mac_len(_t_skb); \
+		_t_skb; \
+	})
+
+#endif /* < KERNEL_VERSION(3, 8, 0) */
+
 #endif /* _NET_BATMAN_ADV_COMPAT_H_ */
-- 
1.7.10


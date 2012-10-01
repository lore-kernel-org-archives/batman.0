Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Mon,  1 Oct 2012 22:53:28 +0200
Message-Id: <1349124808-15995-1-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1347712461-9031-1-git-send-email-ordex@autistici.org>
References: <1347712461-9031-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [RFC] batman-adv: dirty hack to recompute mac_len in
	the rx path
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
---
 compat.h |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/compat.h b/compat.h
index 14969e0..dca9685 100644
--- a/compat.h
+++ b/compat.h
@@ -159,4 +159,19 @@ static inline void eth_hw_addr_random(struct net_device *dev)
 
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
+	skb_share_check(skb, b); \
+	if (skb) \
+		skb_reset_mac_len(skb)
+
+#endif /* < KERNEL_VERSION(3, 8, 0) */
+
 #endif /* _NET_BATMAN_ADV_COMPAT_H_ */
-- 
1.7.10


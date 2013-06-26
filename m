Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed, 26 Jun 2013 11:37:51 +0200
Message-Id: <1372239472-13217-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: compat-code for
	skb_abort_seq_read()
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

Since skb_abort_seq_read() has been removed in the patch "net: Unmap
fragment page once iterator is done" in linux, but is still needed for
older kernel, add compat code to call it after the iteration is done.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 compat.h |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/compat.h b/compat.h
index ddc1b29..e9b531f 100644
--- a/compat.h
+++ b/compat.h
@@ -326,6 +326,14 @@ static int __batadv_interface_set_mac_addr(x, y)
 
 #define netdev_notifier_info_to_dev(ptr) ptr
 
+/* older kernels still need to call skb_abort_seq_read() */
+#define skb_seq_read(consumed, data, st) \
+	({ \
+		int len = skb_seq_read(consumed, data, st); \
+		if (len == 0) \
+			skb_abort_seq_read(st); \
+		len; \
+	})
 #endif /* < KERNEL_VERSION(3, 11, 0) */
 
 #endif /* _NET_BATMAN_ADV_COMPAT_H_ */
-- 
1.7.10.4


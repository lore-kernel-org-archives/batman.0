Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Tue, 24 Apr 2012 10:28:31 +0200
Message-Id: <1335256111-21770-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: make __alloc_percpu 2.6.29
	compatible
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
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>

In 2.6.29, __alloc_percpu doesn't take a align argument, so ignore this.

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
---
 compat.h |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/compat.h b/compat.h
index 1cf5210..98b2b4c 100644
--- a/compat.h
+++ b/compat.h
@@ -148,4 +148,13 @@ static inline void eth_hw_addr_random(struct net_device *dev)
 
 #endif /* < KERNEL_VERSION(3, 4, 0) */
 
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 30)
+
+#undef __alloc_percpu
+#define __alloc_percpu(size, align) \
+	percpu_alloc_mask((size), GFP_KERNEL, cpu_possible_map)
+
+#endif /* < KERNEL_VERSION(2, 6, 30) */
+
 #endif /* _NET_BATMAN_ADV_COMPAT_H_ */
-- 
1.7.10


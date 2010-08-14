Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 14 Aug 2010 23:08:00 +0200
Message-Id: <1281820085-13507-4-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1281820085-13507-1-git-send-email-sven.eckelmann@gmx.de>
References: <1281820085-13507-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 4/9] batman-adv: Provide old dev_get_by_name
	for kernel prior 2.6.24
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

Since v2.6.23-173-g881d966 we must provide the net namespace to use for
dev_get_by_name. Older kernels didn't provide that functionality and we
must ignore that argument.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv/compat.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/batman-adv/compat.h b/batman-adv/compat.h
index 5bf1532..617d23c 100644
--- a/batman-adv/compat.h
+++ b/batman-adv/compat.h
@@ -90,6 +90,8 @@ static inline int skb_cow_head(struct sk_buff *skb, unsigned int headroom)
 #define pr_warning(fmt, ...) \
        printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
 
+#define dev_get_by_name(x, y) dev_get_by_name(y)
+
 #endif /* < KERNEL_VERSION(2, 6, 24) */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 25)
-- 
1.7.1


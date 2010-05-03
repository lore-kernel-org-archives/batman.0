Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon,  3 May 2010 08:28:37 +0800
Message-Id: <1272846518-2589-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <201005030828.08856.lindner_marek@yahoo.de>
References: <201005030828.08856.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: adding MAC_FMT compatibility
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
To: b.a.t.m.a.n@lists.open-mesh.net
Cc: Marek Lindner <lindner_marek@yahoo.de>

Kernel older than 2.6.24 do not have the MAC_FMT definition,
therefore we need to add it to our compat layer.

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 batman-adv-kernelland/compat.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/batman-adv-kernelland/compat.h b/batman-adv-kernelland/compat.h
index 2e3aded..4eaa128 100644
--- a/batman-adv-kernelland/compat.h
+++ b/batman-adv-kernelland/compat.h
@@ -62,6 +62,12 @@ static inline int skb_clone_writable(struct sk_buff *skb, unsigned int len)
 
 #endif /* < KERNEL_VERSION(2, 6, 23) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 24)
+
+#define MAC_FMT "%02x:%02x:%02x:%02x:%02x:%02x"
+
+#endif /* < KERNEL_VERSION(2, 6, 24) */
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 25)
 
 #define strict_strtoul(cp, base, res) \
-- 
1.7.0


Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun,  6 Jun 2010 01:16:55 +0200
Message-Id: <1275779815-23681-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH-trunk] batman-adv: Remove unused code from
	compat.h
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

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv-kernelland/compat.h |   14 --------------
 1 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/batman-adv-kernelland/compat.h b/batman-adv-kernelland/compat.h
index 614d116..af0e9d8 100644
--- a/batman-adv-kernelland/compat.h
+++ b/batman-adv-kernelland/compat.h
@@ -43,9 +43,6 @@
 #define skb_mac_header(_skb) \
     ((_skb)->mac.raw)
 
-#define skb_network_header(_skb) \
-    ((_skb)->nh.raw)
-
 #define skb_mac_header(_skb) \
     ((_skb)->mac.raw)
 
@@ -53,17 +50,6 @@
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 23)
 
-#define transtable_local_read(kobj, attr, buff, off, count) \
-	transtable_local_read(kobj, buff, off, count)
-#define transtable_global_read(kobj, attr, buff, off, count) \
-	transtable_global_read(kobj, buff, off, count)
-#define originators_read(kobj, attr, buff, off, count) \
-	originators_read(kobj, buff, off, count)
-#define gateways_read(kobj, attr, buff, off, count) \
-	gateways_read(kobj, buff, off, count)
-#define vis_data_read(kobj, attr, buff, off, count) \
-	vis_data_read(kobj, buff, off, count)
-
 static inline int skb_clone_writable(struct sk_buff *skb, unsigned int len)
 {
 	/* skb->hdr_len not available, just "not writable" to enforce a copy */
-- 
1.7.1


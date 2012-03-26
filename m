Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 26 Mar 2012 16:22:45 +0200
Message-Id: <1332771765-10351-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: use shorter pr_warn instead of
	pr_warning
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat.h         |    7 +++++++
 hard-interface.c |    4 ++--
 send.c           |    2 +-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/compat.h b/compat.h
index 95b8706..f2cf35b 100644
--- a/compat.h
+++ b/compat.h
@@ -57,6 +57,13 @@
 
 #endif /* < KERNEL_VERSION(2, 6, 34) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 35)
+
+#define pr_warn pr_warning
+
+#endif /* < KERNEL_VERSION(2, 6, 35) */
+
+
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 31)
 
diff --git a/hard-interface.c b/hard-interface.c
index 3778977..7db9636 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -175,9 +175,9 @@ static void check_known_mac_addr(const struct net_device *net_dev)
 				 net_dev->dev_addr))
 			continue;
 
-		pr_warning("The newly added mac address (%pM) already exists on: %s\n",
+		pr_warn("The newly added mac address (%pM) already exists on: %s\n",
 			   net_dev->dev_addr, hard_iface->net_dev->name);
-		pr_warning("It is strongly recommended to keep mac addresses unique to avoid problems!\n");
+		pr_warn("It is strongly recommended to keep mac addresses unique to avoid problems!\n");
 	}
 	rcu_read_unlock();
 }
diff --git a/send.c b/send.c
index af7a674..8ec33b0 100644
--- a/send.c
+++ b/send.c
@@ -45,7 +45,7 @@ int send_skb_packet(struct sk_buff *skb, struct hard_iface *hard_iface,
 		goto send_skb_err;
 
 	if (!(hard_iface->net_dev->flags & IFF_UP)) {
-		pr_warning("Interface %s is not up - can't send packet via that interface!\n",
+		pr_warn("Interface %s is not up - can't send packet via that interface!\n",
 			   hard_iface->net_dev->name);
 		goto send_skb_err;
 	}
-- 
1.7.9.1


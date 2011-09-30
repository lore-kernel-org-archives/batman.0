Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 30 Sep 2011 13:32:01 +0200
Message-Id: <1317382322-6922-2-git-send-email-sven@narfation.org>
In-Reply-To: <1317382322-6922-1-git-send-email-sven@narfation.org>
References: <1317382322-6922-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Replace obsolete
	strict_strto<foo> with kstrto<foo>
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

strict_strto<foo> is obsolete since v3.1-rc8-8466-g14acc55 and should be
replaced with kstrto<foo>.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Can somebody please make a test for some kernels? I don't have the stuff
(and time) right now.

 bat_sysfs.c      |    4 ++--
 compat.h         |    7 +++++++
 gateway_common.c |    4 ++--
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/bat_sysfs.c b/bat_sysfs.c
index b8a7414..c25492f 100644
--- a/bat_sysfs.c
+++ b/bat_sysfs.c
@@ -174,7 +174,7 @@ static int store_uint_attr(const char *buff, size_t count,
 	unsigned long uint_val;
 	int ret;
 
-	ret = strict_strtoul(buff, 10, &uint_val);
+	ret = kstrtoul(buff, 10, &uint_val);
 	if (ret) {
 		bat_info(net_dev,
 			 "%s: Invalid parameter received: %s\n",
@@ -239,7 +239,7 @@ static ssize_t store_vis_mode(struct kobject *kobj, struct attribute *attr,
 	unsigned long val;
 	int ret, vis_mode_tmp = -1;
 
-	ret = strict_strtoul(buff, 10, &val);
+	ret = kstrtoul(buff, 10, &val);
 
 	if (((count == 2) && (!ret) && (val == VIS_TYPE_CLIENT_UPDATE)) ||
 	    (strncmp(buff, "client", 6) == 0) ||
diff --git a/compat.h b/compat.h
index 43654e8..64fbac7 100644
--- a/compat.h
+++ b/compat.h
@@ -55,6 +55,13 @@
 
 #endif /* < KERNEL_VERSION(2, 6, 36) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 39)
+
+#define kstrtoul strict_strtoul
+#define kstrtol  strict_strtol
+
+#endif /* < KERNEL_VERSION(2, 6, 39) */
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 0, 0)
 
 #define kfree_rcu(ptr, rcu_head) call_rcu(&ptr->rcu_head, free_rcu_##ptr)
diff --git a/gateway_common.c b/gateway_common.c
index 18661af..c4ac7b0 100644
--- a/gateway_common.c
+++ b/gateway_common.c
@@ -97,7 +97,7 @@ static bool parse_gw_bandwidth(struct net_device *net_dev, char *buff,
 			*tmp_ptr = '\0';
 	}
 
-	ret = strict_strtol(buff, 10, &ldown);
+	ret = kstrtol(buff, 10, &ldown);
 	if (ret) {
 		bat_err(net_dev,
 			"Download speed of gateway mode invalid: %s\n",
@@ -122,7 +122,7 @@ static bool parse_gw_bandwidth(struct net_device *net_dev, char *buff,
 				*tmp_ptr = '\0';
 		}
 
-		ret = strict_strtol(slash_ptr + 1, 10, &lup);
+		ret = kstrtol(slash_ptr + 1, 10, &lup);
 		if (ret) {
 			bat_err(net_dev,
 				"Upload speed of gateway mode invalid: "
-- 
1.7.6.3


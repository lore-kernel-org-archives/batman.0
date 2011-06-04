Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  4 Jun 2011 14:00:49 +0200
Message-Id: <1307188849-20156-1-git-send-email-sven@narfation.org>
In-Reply-To: <201106041359.15552.sven@narfation.org>
References: <201106041359.15552.sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 2/2] batman-adv: Fix signedness problem in
	parse_gw_bandwidth
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

strict_strtoul as used in parse_gw_bandwidth is defined for unsigned
long and strict_strtol should be used instead for long.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Added compat.h helper function

 compat.h         |   10 ++++++++++
 gateway_common.c |    4 ++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/compat.h b/compat.h
index 0f0e66e..66a8adc 100644
--- a/compat.h
+++ b/compat.h
@@ -104,6 +104,16 @@ static inline int skb_cow_head(struct sk_buff *skb, unsigned int headroom)
 	ret; \
 })
 
+#define strict_strtol(cp, base, res) \
+	({ \
+	int ret = 0; \
+	char *endp; \
+	*res = simple_strtol(cp, &endp, base); \
+	if (cp == endp) \
+		ret = -EINVAL; \
+	ret; \
+})
+
 #define to_battr(a) container_of(a, struct bat_attribute, attr)
 
 ssize_t bat_wrapper_show(struct kobject *kobj, struct attribute *attr,
diff --git a/gateway_common.c b/gateway_common.c
index ed3bd36..e74307b 100644
--- a/gateway_common.c
+++ b/gateway_common.c
@@ -97,7 +97,7 @@ static bool parse_gw_bandwidth(struct net_device *net_dev, char *buff,
 			*tmp_ptr = '\0';
 	}
 
-	ret = strict_strtoul(buff, 10, &ldown);
+	ret = strict_strtol(buff, 10, &ldown);
 	if (ret) {
 		bat_err(net_dev,
 			"Download speed of gateway mode invalid: %s\n",
@@ -122,7 +122,7 @@ static bool parse_gw_bandwidth(struct net_device *net_dev, char *buff,
 				*tmp_ptr = '\0';
 		}
 
-		ret = strict_strtoul(slash_ptr + 1, 10, &lup);
+		ret = strict_strtol(slash_ptr + 1, 10, &lup);
 		if (ret) {
 			bat_err(net_dev,
 				"Upload speed of gateway mode invalid: "
-- 
1.7.5.3


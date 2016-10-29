Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 29 Oct 2016 10:03:27 +0200
Message-Id: <20161029080328.26584-2-sven@narfation.org>
In-Reply-To: <20161029080328.26584-1-sven@narfation.org>
References: <20161029080328.26584-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: genetlink: statically
	initialize families
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

From: Johannes Berg <johannes.berg@intel.com>

Instead of providing macros/inline functions to initialize
the families, make all users initialize them statically and
get rid of the macros.

This reduces the kernel code size by about 1.6k on x86-64
(with allyesconfig).

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[sven@narfation.org: adjust compat code]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Patch already in net-next

 compat-include/net/genetlink.h | 21 ++-------------------
 net/batman-adv/netlink.c       | 25 +++++++++++++++----------
 2 files changed, 17 insertions(+), 29 deletions(-)

diff --git a/compat-include/net/genetlink.h b/compat-include/net/genetlink.h
index 6a287e6..b057e6c 100644
--- a/compat-include/net/genetlink.h
+++ b/compat-include/net/genetlink.h
@@ -96,11 +96,6 @@ batadv_genlmsg_multicast_netns(struct batadv_genl_family *family,
 #define genl_unregister_family(_family) \
 	genl_unregister_family(&(_family)->family)
 
-#define genl_register_family_with_ops_groups(family, ops, grps) \
-	batadv_genl_register_family_with_ops_grps((family), \
-						  (ops), ARRAY_SIZE(ops), \
-						  (grps), ARRAY_SIZE(grps))
-
 static inline int batadv_genl_register_family(struct genl_family *family)
 {
 	unsigned int i;
@@ -148,20 +143,8 @@ static inline int batadv_genl_register_family(struct genl_family *family)
 	return ret;
 }
 
-static inline int
-batadv_genl_register_family_with_ops_grps(struct genl_family *family,
-					  struct genl_ops *ops, size_t n_ops,
-					  struct genl_multicast_group *mcgrps,
-					  size_t n_mcgrps)
-{
-	family->ops = ops;
-	family->n_ops = n_ops;
-	family->mcgrps = mcgrps;
-	family->n_mcgrps = n_mcgrps;
-	family->module = THIS_MODULE;
-
-	return batadv_genl_register_family(family);
-}
+#define genl_register_family(family) \
+	batadv_genl_register_family((family))
 
 #define __genl_const
 
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index a951e02..5dfc5c4 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -48,13 +48,7 @@
 #include "tp_meter.h"
 #include "translation-table.h"
 
-struct genl_family batadv_netlink_family = {
-	.hdrsize = 0,
-	.name = BATADV_NL_NAME,
-	.version = 1,
-	.maxattr = BATADV_ATTR_MAX,
-	.netnsok = true,
-};
+struct genl_family batadv_netlink_family;
 
 /* multicast groups */
 enum batadv_netlink_multicast_groups {
@@ -609,6 +603,19 @@ static const struct genl_ops batadv_netlink_ops[] = {
 
 };
 
+struct genl_family batadv_netlink_family = {
+	.hdrsize = 0,
+	.name = BATADV_NL_NAME,
+	.version = 1,
+	.maxattr = BATADV_ATTR_MAX,
+	.netnsok = true,
+	.module = THIS_MODULE,
+	.ops = batadv_netlink_ops,
+	.n_ops = ARRAY_SIZE(batadv_netlink_ops),
+	.mcgrps = batadv_netlink_mcgrps,
+	.n_mcgrps = ARRAY_SIZE(batadv_netlink_mcgrps),
+};
+
 /**
  * batadv_netlink_register - register batadv genl netlink family
  */
@@ -616,9 +623,7 @@ void __init batadv_netlink_register(void)
 {
 	int ret;
 
-	ret = genl_register_family_with_ops_groups(&batadv_netlink_family,
-						   batadv_netlink_ops,
-						   batadv_netlink_mcgrps);
+	ret = genl_register_family(&batadv_netlink_family);
 	if (ret)
 		pr_warn("unable to register netlink family");
 }
-- 
2.10.1


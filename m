Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Tue, 18 Oct 2016 23:21:25 +0200
Message-Id: <20161018212125.32010-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: compat: Substitute compat code
	for netlink constification
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

Substitutes the compat-patches approach for the netlink const changes to
the prefered way of using compat-includes.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 compat-include/net/genetlink.h | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/compat-include/net/genetlink.h b/compat-include/net/genetlink.h
index 72a8991..b195b47 100644
--- a/compat-include/net/genetlink.h
+++ b/compat-include/net/genetlink.h
@@ -28,6 +28,15 @@
 
 #include <linux/export.h>
 
+/* multicast groups */
+enum __batadv_netlink_multicast_groups {
+	__BATADV_NL_MCGRP_TPMETER,
+};
+
+static struct genl_multicast_group __batadv_netlink_mcgrps[] = {
+	[__BATADV_NL_MCGRP_TPMETER] = { .name = BATADV_NL_MCAST_GROUP_TPMETER },
+};
+
 struct batadv_genl_family {
 	/* data handled by the actual kernel */
 	struct genl_family family;
@@ -140,12 +149,14 @@ static inline int batadv_genl_register_family(struct genl_family *family)
 static inline int
 batadv_genl_register_family_with_ops_grps(struct genl_family *family,
 					  struct genl_ops *ops, size_t n_ops,
-					  struct genl_multicast_group *mcgrps,
+					  const struct genl_multicast_group *mcgrps,
 					  size_t n_mcgrps)
 {
+	BUILD_BUG_ON(ARRAY_SIZE(__batadv_netlink_mcgrps) != n_mcgrps);
+
 	family->ops = ops;
 	family->n_ops = n_ops;
-	family->mcgrps = mcgrps;
+	family->mcgrps = __batadv_netlink_mcgrps;
 	family->n_mcgrps = n_mcgrps;
 	family->module = THIS_MODULE;
 
-- 
2.1.4


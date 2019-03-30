Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 30 Mar 2019 08:38:15 +0100
Message-Id: <20190330073815.11464-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: genetlink: make policy common to
 family
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

Since maxattr is common, the policy can't really differ sanely,
so make it common as well.

The only user that did in fact manage to make a non-common policy
is taskstats, which has to be really careful about it (since it's
still using a common maxattr!). This is no longer supported, but
we can fake it using pre_doit.

This reduces the size of e.g. nl80211.o (which has lots of commands):

   text	   data	    bss	    dec	    hex	filename
 398745	  14323	   2240	 415308	  6564c	net/wireless/nl80211.o (before)
 397913	  14331	   2240	 414484	  65314	net/wireless/nl80211.o (after)
--------------------------------
   -832      +8       0    -824

Which is obviously just 8 bytes for each command, and an added 8
bytes for the new policy pointer. I'm not sure why the ops list is
counted as .text though.

Most of the code transformations were done using the following spatch:
    @ops@
    identifier OPS;
    expression POLICY;
    @@
    struct genl_ops OPS[] = {
    ...,
     {
    -	.policy = POLICY,
     },
    ...
    };

    @@
    identifier ops.OPS;
    expression ops.POLICY;
    identifier fam;
    expression M;
    @@
    struct genl_family fam = {
            .ops = OPS,
            .maxattr = M,
    +       .policy = POLICY,
            ...
    };

This also gets rid of devlink_nl_cmd_region_read_dumpit() accessing
the cb->data as ops, which we want to change in a later genl patch.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[sven@narfation.org: Added compat code]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Patch (without compat code) is already in net-next:
https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/commit/?id=3b0f31f2b8c9fb348e4530b88f6b64f9621f83d6

 compat-include/linux/cache.h   |  6 +--
 compat-include/net/genetlink.h | 88 ++++++++++++++++++++++++++++++++++
 net/batman-adv/netlink.c       | 19 +-------
 3 files changed, 90 insertions(+), 23 deletions(-)

diff --git a/compat-include/linux/cache.h b/compat-include/linux/cache.h
index efe440d1..9ddda312 100644
--- a/compat-include/linux/cache.h
+++ b/compat-include/linux/cache.h
@@ -13,12 +13,8 @@
 #include <linux/version.h>
 #include_next <linux/cache.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 10, 0)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 6, 0)
 
-/* hack for netlink.c which marked the family ops as ro */
-#ifdef __ro_after_init
-#undef __ro_after_init
-#endif
 #define __ro_after_init
 
 #endif /* < KERNEL_VERSION(4, 6, 0) */
diff --git a/compat-include/net/genetlink.h b/compat-include/net/genetlink.h
index 58fc24d7..7d17a705 100644
--- a/compat-include/net/genetlink.h
+++ b/compat-include/net/genetlink.h
@@ -30,4 +30,92 @@ void batadv_genl_dump_check_consistent(struct netlink_callback *cb,
 
 #endif /* < KERNEL_VERSION(4, 15, 0) */
 
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(5, 2, 0)
+
+struct batadv_genl_family {
+	/* data handled by the actual kernel */
+	struct genl_family family;
+
+	/* data which has to be copied to family by
+	 * batadv_genl_register_family
+	 */
+	unsigned int hdrsize;
+	char name[GENL_NAMSIZ];
+	unsigned int version;
+	unsigned int maxattr;
+	const struct nla_policy *policy;
+	bool netnsok;
+        int  (*pre_doit)(const struct genl_ops *ops, struct sk_buff *skb,
+			 struct genl_info *info);
+        void (*post_doit)(const struct genl_ops *ops, struct sk_buff *skb,
+			  struct genl_info *info);
+	const struct genl_ops *ops;
+	const struct genl_multicast_group *mcgrps;
+	unsigned int n_ops;
+	unsigned int n_mcgrps;
+	struct module *module;
+
+	/* allocated by batadv_genl_register_family and free'd by
+	 * batadv_genl_unregister_family. Used to modify the usually read-only
+	 * ops
+	 */
+	struct genl_ops *copy_ops;
+};
+
+#define genl_family batadv_genl_family
+
+static inline int batadv_genl_register_family(struct batadv_genl_family *family)
+{
+	struct genl_ops *ops;
+	unsigned int i;
+
+	family->family.hdrsize = family->hdrsize;
+	strncpy(family->family.name, family->name, sizeof(family->family.name));
+	family->family.version = family->version;
+	family->family.maxattr = family->maxattr;
+	family->family.netnsok = family->netnsok;
+	family->family.pre_doit = family->pre_doit;
+	family->family.post_doit = family->post_doit;
+	family->family.mcgrps = family->mcgrps;
+	family->family.n_ops = family->n_ops;
+	family->family.n_mcgrps = family->n_mcgrps;
+	family->family.module = family->module;
+
+	ops = kmemdup(family->ops, sizeof(*ops) * family->n_ops, GFP_KERNEL);
+	if (!ops)
+		return -ENOMEM;
+
+	for (i = 0; i < family->family.n_ops; i++)
+		ops[i].policy = family->policy;
+
+	family->family.ops = ops;
+	family->copy_ops = ops;
+
+	return genl_register_family(&family->family);
+}
+
+#define genl_register_family(family) \
+	batadv_genl_register_family((family))
+
+static inline void
+batadv_genl_unregister_family(struct batadv_genl_family *family)
+{
+
+	genl_unregister_family(&family->family);
+	kfree(family->copy_ops);
+}
+
+#define genl_unregister_family(family) \
+	batadv_genl_unregister_family((family))
+
+#define genlmsg_put(_skb, _pid, _seq, _family, _flags, _cmd) \
+	genlmsg_put(_skb, _pid, _seq, &(_family)->family, _flags, _cmd)
+
+#define genlmsg_multicast_netns(_family, _net, _skb, _portid, _group, _flags) \
+	genlmsg_multicast_netns(&(_family)->family, _net, _skb, _portid, \
+				_group, _flags)
+
+#endif /* < KERNEL_VERSION(5, 2, 0) */
+
 #endif /* _NET_BATMAN_ADV_COMPAT_NET_GENETLINK_H_ */
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index daf56933..e7907308 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -1344,34 +1344,29 @@ static const struct genl_ops batadv_netlink_ops[] = {
 	{
 		.cmd = BATADV_CMD_GET_MESH,
 		/* can be retrieved by unprivileged users */
-		.policy = batadv_netlink_policy,
 		.doit = batadv_netlink_get_mesh,
 		.internal_flags = BATADV_FLAG_NEED_MESH,
 	},
 	{
 		.cmd = BATADV_CMD_TP_METER,
 		.flags = GENL_ADMIN_PERM,
-		.policy = batadv_netlink_policy,
 		.doit = batadv_netlink_tp_meter_start,
 		.internal_flags = BATADV_FLAG_NEED_MESH,
 	},
 	{
 		.cmd = BATADV_CMD_TP_METER_CANCEL,
 		.flags = GENL_ADMIN_PERM,
-		.policy = batadv_netlink_policy,
 		.doit = batadv_netlink_tp_meter_cancel,
 		.internal_flags = BATADV_FLAG_NEED_MESH,
 	},
 	{
 		.cmd = BATADV_CMD_GET_ROUTING_ALGOS,
 		.flags = GENL_ADMIN_PERM,
-		.policy = batadv_netlink_policy,
 		.dumpit = batadv_algo_dump,
 	},
 	{
 		.cmd = BATADV_CMD_GET_HARDIF,
 		/* can be retrieved by unprivileged users */
-		.policy = batadv_netlink_policy,
 		.dumpit = batadv_netlink_dump_hardif,
 		.doit = batadv_netlink_get_hardif,
 		.internal_flags = BATADV_FLAG_NEED_MESH |
@@ -1380,68 +1375,57 @@ static const struct genl_ops batadv_netlink_ops[] = {
 	{
 		.cmd = BATADV_CMD_GET_TRANSTABLE_LOCAL,
 		.flags = GENL_ADMIN_PERM,
-		.policy = batadv_netlink_policy,
 		.dumpit = batadv_tt_local_dump,
 	},
 	{
 		.cmd = BATADV_CMD_GET_TRANSTABLE_GLOBAL,
 		.flags = GENL_ADMIN_PERM,
-		.policy = batadv_netlink_policy,
 		.dumpit = batadv_tt_global_dump,
 	},
 	{
 		.cmd = BATADV_CMD_GET_ORIGINATORS,
 		.flags = GENL_ADMIN_PERM,
-		.policy = batadv_netlink_policy,
 		.dumpit = batadv_orig_dump,
 	},
 	{
 		.cmd = BATADV_CMD_GET_NEIGHBORS,
 		.flags = GENL_ADMIN_PERM,
-		.policy = batadv_netlink_policy,
 		.dumpit = batadv_hardif_neigh_dump,
 	},
 	{
 		.cmd = BATADV_CMD_GET_GATEWAYS,
 		.flags = GENL_ADMIN_PERM,
-		.policy = batadv_netlink_policy,
 		.dumpit = batadv_gw_dump,
 	},
 	{
 		.cmd = BATADV_CMD_GET_BLA_CLAIM,
 		.flags = GENL_ADMIN_PERM,
-		.policy = batadv_netlink_policy,
 		.dumpit = batadv_bla_claim_dump,
 	},
 	{
 		.cmd = BATADV_CMD_GET_BLA_BACKBONE,
 		.flags = GENL_ADMIN_PERM,
-		.policy = batadv_netlink_policy,
 		.dumpit = batadv_bla_backbone_dump,
 	},
 	{
 		.cmd = BATADV_CMD_GET_DAT_CACHE,
 		.flags = GENL_ADMIN_PERM,
-		.policy = batadv_netlink_policy,
 		.dumpit = batadv_dat_cache_dump,
 	},
 	{
 		.cmd = BATADV_CMD_GET_MCAST_FLAGS,
 		.flags = GENL_ADMIN_PERM,
-		.policy = batadv_netlink_policy,
 		.dumpit = batadv_mcast_flags_dump,
 	},
 	{
 		.cmd = BATADV_CMD_SET_MESH,
 		.flags = GENL_ADMIN_PERM,
-		.policy = batadv_netlink_policy,
 		.doit = batadv_netlink_set_mesh,
 		.internal_flags = BATADV_FLAG_NEED_MESH,
 	},
 	{
 		.cmd = BATADV_CMD_SET_HARDIF,
 		.flags = GENL_ADMIN_PERM,
-		.policy = batadv_netlink_policy,
 		.doit = batadv_netlink_set_hardif,
 		.internal_flags = BATADV_FLAG_NEED_MESH |
 				  BATADV_FLAG_NEED_HARDIF,
@@ -1449,7 +1433,6 @@ static const struct genl_ops batadv_netlink_ops[] = {
 	{
 		.cmd = BATADV_CMD_GET_VLAN,
 		/* can be retrieved by unprivileged users */
-		.policy = batadv_netlink_policy,
 		.doit = batadv_netlink_get_vlan,
 		.internal_flags = BATADV_FLAG_NEED_MESH |
 				  BATADV_FLAG_NEED_VLAN,
@@ -1457,7 +1440,6 @@ static const struct genl_ops batadv_netlink_ops[] = {
 	{
 		.cmd = BATADV_CMD_SET_VLAN,
 		.flags = GENL_ADMIN_PERM,
-		.policy = batadv_netlink_policy,
 		.doit = batadv_netlink_set_vlan,
 		.internal_flags = BATADV_FLAG_NEED_MESH |
 				  BATADV_FLAG_NEED_VLAN,
@@ -1469,6 +1451,7 @@ struct genl_family batadv_netlink_family __ro_after_init = {
 	.name = BATADV_NL_NAME,
 	.version = 1,
 	.maxattr = BATADV_ATTR_MAX,
+	.policy = batadv_netlink_policy,
 	.netnsok = true,
 	.pre_doit = batadv_pre_doit,
 	.post_doit = batadv_post_doit,
-- 
2.20.1


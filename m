Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 28 Apr 2019 07:59:15 +0200
Message-Id: <20190428055915.31585-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC] batman-adv: genetlink: optionally validate
 strictly/dumps
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

Add options to strictly validate messages and dump messages,
sometimes perhaps validating dump messages non-strictly may
be required, so add an option for that as well.

Since none of this can really be applied to existing commands,
set the options everwhere using the following spatch:

    @@
    identifier ops;
    expression X;
    @@
    struct genl_ops ops[] = {
    ...,
     {
            .cmd = X,
    +       .validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
            ...
     },
    ...
    };

For new commands one should just not copy the .validate 'opt-out'
flags and thus get strict validation.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
This patch was already applied upstream as 
ef6243acb4782df587a4d7d6c310fa5b5d82684b but compat code is missing for it.

 net/batman-adv/netlink.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index e7907308..a67720fa 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -1343,29 +1343,34 @@ static void batadv_post_doit(const struct genl_ops *ops, struct sk_buff *skb,
 static const struct genl_ops batadv_netlink_ops[] = {
 	{
 		.cmd = BATADV_CMD_GET_MESH,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		/* can be retrieved by unprivileged users */
 		.doit = batadv_netlink_get_mesh,
 		.internal_flags = BATADV_FLAG_NEED_MESH,
 	},
 	{
 		.cmd = BATADV_CMD_TP_METER,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.flags = GENL_ADMIN_PERM,
 		.doit = batadv_netlink_tp_meter_start,
 		.internal_flags = BATADV_FLAG_NEED_MESH,
 	},
 	{
 		.cmd = BATADV_CMD_TP_METER_CANCEL,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.flags = GENL_ADMIN_PERM,
 		.doit = batadv_netlink_tp_meter_cancel,
 		.internal_flags = BATADV_FLAG_NEED_MESH,
 	},
 	{
 		.cmd = BATADV_CMD_GET_ROUTING_ALGOS,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.flags = GENL_ADMIN_PERM,
 		.dumpit = batadv_algo_dump,
 	},
 	{
 		.cmd = BATADV_CMD_GET_HARDIF,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		/* can be retrieved by unprivileged users */
 		.dumpit = batadv_netlink_dump_hardif,
 		.doit = batadv_netlink_get_hardif,
@@ -1374,57 +1379,68 @@ static const struct genl_ops batadv_netlink_ops[] = {
 	},
 	{
 		.cmd = BATADV_CMD_GET_TRANSTABLE_LOCAL,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.flags = GENL_ADMIN_PERM,
 		.dumpit = batadv_tt_local_dump,
 	},
 	{
 		.cmd = BATADV_CMD_GET_TRANSTABLE_GLOBAL,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.flags = GENL_ADMIN_PERM,
 		.dumpit = batadv_tt_global_dump,
 	},
 	{
 		.cmd = BATADV_CMD_GET_ORIGINATORS,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.flags = GENL_ADMIN_PERM,
 		.dumpit = batadv_orig_dump,
 	},
 	{
 		.cmd = BATADV_CMD_GET_NEIGHBORS,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.flags = GENL_ADMIN_PERM,
 		.dumpit = batadv_hardif_neigh_dump,
 	},
 	{
 		.cmd = BATADV_CMD_GET_GATEWAYS,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.flags = GENL_ADMIN_PERM,
 		.dumpit = batadv_gw_dump,
 	},
 	{
 		.cmd = BATADV_CMD_GET_BLA_CLAIM,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.flags = GENL_ADMIN_PERM,
 		.dumpit = batadv_bla_claim_dump,
 	},
 	{
 		.cmd = BATADV_CMD_GET_BLA_BACKBONE,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.flags = GENL_ADMIN_PERM,
 		.dumpit = batadv_bla_backbone_dump,
 	},
 	{
 		.cmd = BATADV_CMD_GET_DAT_CACHE,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.flags = GENL_ADMIN_PERM,
 		.dumpit = batadv_dat_cache_dump,
 	},
 	{
 		.cmd = BATADV_CMD_GET_MCAST_FLAGS,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.flags = GENL_ADMIN_PERM,
 		.dumpit = batadv_mcast_flags_dump,
 	},
 	{
 		.cmd = BATADV_CMD_SET_MESH,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.flags = GENL_ADMIN_PERM,
 		.doit = batadv_netlink_set_mesh,
 		.internal_flags = BATADV_FLAG_NEED_MESH,
 	},
 	{
 		.cmd = BATADV_CMD_SET_HARDIF,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.flags = GENL_ADMIN_PERM,
 		.doit = batadv_netlink_set_hardif,
 		.internal_flags = BATADV_FLAG_NEED_MESH |
@@ -1432,6 +1448,7 @@ static const struct genl_ops batadv_netlink_ops[] = {
 	},
 	{
 		.cmd = BATADV_CMD_GET_VLAN,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		/* can be retrieved by unprivileged users */
 		.doit = batadv_netlink_get_vlan,
 		.internal_flags = BATADV_FLAG_NEED_MESH |
@@ -1439,6 +1456,7 @@ static const struct genl_ops batadv_netlink_ops[] = {
 	},
 	{
 		.cmd = BATADV_CMD_SET_VLAN,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.flags = GENL_ADMIN_PERM,
 		.doit = batadv_netlink_set_vlan,
 		.internal_flags = BATADV_FLAG_NEED_MESH |
-- 
2.20.1


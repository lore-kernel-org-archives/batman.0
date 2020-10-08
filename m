Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH] batman-adv: genetlink: move to smaller ops wherever possible
Date: Thu,  8 Oct 2020 20:16:12 +0200
Message-Id: <20201008181612.9663-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org

From: Jakub Kicinski <kuba@kernel.org>

Bulk of the genetlink users can use smaller ops, move them.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
[sven@narfation.org: Add compat code]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat-include/net/genetlink.h | 38 +++++++++++++++++++++-------------
 net/batman-adv/netlink.c       |  6 +++---
 2 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/compat-include/net/genetlink.h b/compat-include/net/genetlin=
k.h
index d1f80cd8..f16355fe 100644
--- a/compat-include/net/genetlink.h
+++ b/compat-include/net/genetlink.h
@@ -31,15 +31,17 @@ void batadv_genl_dump_check_consistent(struct netlink=
_callback *cb,
 #endif /* LINUX_VERSION_IS_LESS(4, 15, 0) */
=20
=20
-#if LINUX_VERSION_IS_LESS(5, 2, 0)
+#if LINUX_VERSION_IS_LESS(5, 10, 0)
=20
+#if LINUX_VERSION_IS_LESS(5, 2, 0)
 enum genl_validate_flags {
 	GENL_DONT_VALIDATE_STRICT		=3D BIT(0),
 	GENL_DONT_VALIDATE_DUMP			=3D BIT(1),
 	GENL_DONT_VALIDATE_DUMP_STRICT		=3D BIT(2),
 };
+#endif /* LINUX_VERSION_IS_LESS(5, 2, 0) */
=20
-struct batadv_genl_ops {
+struct batadv_genl_small_ops {
 	int		       (*doit)(struct sk_buff *skb,
 				       struct genl_info *info);
 	int		       (*dumpit)(struct sk_buff *skb,
@@ -68,9 +70,9 @@ struct batadv_genl_family {
 			 struct genl_info *info);
         void (*post_doit)(const struct genl_ops *ops, struct sk_buff *sk=
b,
 			  struct genl_info *info);
-	const struct batadv_genl_ops *ops;
+	const struct batadv_genl_small_ops *small_ops;
 	const struct genl_multicast_group *mcgrps;
-	unsigned int n_ops;
+	unsigned int n_small_ops;
 	unsigned int n_mcgrps;
 	struct module *module;
=20
@@ -94,24 +96,32 @@ static inline int batadv_genl_register_family(struct =
batadv_genl_family *family)
 	family->family.pre_doit =3D family->pre_doit;
 	family->family.post_doit =3D family->post_doit;
 	family->family.mcgrps =3D family->mcgrps;
-	family->family.n_ops =3D family->n_ops;
+	family->family.n_ops =3D family->n_small_ops;
 	family->family.n_mcgrps =3D family->n_mcgrps;
 	family->family.module =3D family->module;
=20
-	ops =3D kzalloc(sizeof(*ops) * family->n_ops, GFP_KERNEL);
+	ops =3D kzalloc(sizeof(*ops) * family->n_small_ops, GFP_KERNEL);
 	if (!ops)
 		return -ENOMEM;
=20
 	for (i =3D 0; i < family->family.n_ops; i++) {
-		ops[i].doit =3D family->ops[i].doit;
-		ops[i].dumpit =3D family->ops[i].dumpit;
-		ops[i].done =3D family->ops[i].done;
-		ops[i].cmd =3D family->ops[i].cmd;
-		ops[i].internal_flags =3D family->ops[i].internal_flags;
-		ops[i].flags =3D family->ops[i].flags;
+		ops[i].doit =3D family->small_ops[i].doit;
+		ops[i].dumpit =3D family->small_ops[i].dumpit;
+		ops[i].done =3D family->small_ops[i].done;
+		ops[i].cmd =3D family->small_ops[i].cmd;
+		ops[i].internal_flags =3D family->small_ops[i].internal_flags;
+		ops[i].flags =3D family->small_ops[i].flags;
+#if LINUX_VERSION_IS_GEQ(5, 2, 0)
+		ops[i].validate =3D family->small_ops[i].validate;
+#else
 		ops[i].policy =3D family->policy;
+#endif
 	}
=20
+#if LINUX_VERSION_IS_GEQ(5, 2, 0)
+	family->family.policy =3D family->policy;
+#endif
+
 	family->family.ops =3D ops;
 	family->copy_ops =3D ops;
=20
@@ -126,7 +136,7 @@ typedef struct genl_ops batadv_genl_ops_old;
 #define batadv_post_doit(__x, __y, __z) \
 	batadv_post_doit(const batadv_genl_ops_old *ops, __y, __z)
=20
-#define genl_ops batadv_genl_ops
+#define genl_small_ops batadv_genl_small_ops
 #define genl_family batadv_genl_family
=20
 #define genl_register_family(family) \
@@ -150,6 +160,6 @@ batadv_genl_unregister_family(struct batadv_genl_fami=
ly *family)
 	genlmsg_multicast_netns(&(_family)->family, _net, _skb, _portid, \
 				_group, _flags)
=20
-#endif /* LINUX_VERSION_IS_LESS(5, 2, 0) */
+#endif /* LINUX_VERSION_IS_LESS(5, 10, 0) */
=20
 #endif /* _NET_BATMAN_ADV_COMPAT_NET_GENETLINK_H_ */
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index dc193618..c7a55647 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -1350,7 +1350,7 @@ static void batadv_post_doit(const struct genl_ops =
*ops, struct sk_buff *skb,
 	}
 }
=20
-static const struct genl_ops batadv_netlink_ops[] =3D {
+static const struct genl_small_ops batadv_netlink_ops[] =3D {
 	{
 		.cmd =3D BATADV_CMD_GET_MESH,
 		.validate =3D GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
@@ -1484,8 +1484,8 @@ struct genl_family batadv_netlink_family __ro_after=
_init =3D {
 	.pre_doit =3D batadv_pre_doit,
 	.post_doit =3D batadv_post_doit,
 	.module =3D THIS_MODULE,
-	.ops =3D batadv_netlink_ops,
-	.n_ops =3D ARRAY_SIZE(batadv_netlink_ops),
+	.small_ops =3D batadv_netlink_ops,
+	.n_small_ops =3D ARRAY_SIZE(batadv_netlink_ops),
 	.mcgrps =3D batadv_netlink_mcgrps,
 	.n_mcgrps =3D ARRAY_SIZE(batadv_netlink_mcgrps),
 };
--=20
2.28.0

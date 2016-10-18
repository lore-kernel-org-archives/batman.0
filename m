Return-Path: <linus.luessing@c0d3.blue>
Date: Wed, 19 Oct 2016 01:22:39 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20161018232239.GI6366@otheros>
References: <20161018212125.32010-1-linus.luessing@c0d3.blue>
 <1555062.TzeBilqSPn@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1555062.TzeBilqSPn@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: compat: Substitute compat
 code for netlink constification
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Tue, Oct 18, 2016 at 11:28:23PM +0200, Sven Eckelmann wrote:
> Doesn't seem to scale. Especially when we think about batadv_netlink_ops
> which should also be const. It is currently not const because of the
> Linux <= 3.13 workaround.

Hm, okay, batadv_netlink_ops is a little more tricky/larger, yes.
What about a memcpy'ing approach with BUILD_BUG_ON()'s as
safe-guards like this:


diff --git a/compat-include/net/genetlink.h b/compat-include/net/genetlink.h
index 72a8991..f16bf35 100644
--- a/compat-include/net/genetlink.h
+++ b/compat-include/net/genetlink.h
@@ -28,6 +28,9 @@
 
 #include <linux/export.h>
 
+static struct genl_ops __batadv_netlink_ops[12];
+static struct genl_multicast_group __batadv_netlink_mcgrps[1];
+
 struct batadv_genl_family {
 	/* data handled by the actual kernel */
 	struct genl_family family;
@@ -137,15 +140,23 @@ static inline int batadv_genl_register_family(struct genl_family *family)
 	return ret;
 }
 
-static inline int
+static inline int __init
 batadv_genl_register_family_with_ops_grps(struct genl_family *family,
-					  struct genl_ops *ops, size_t n_ops,
-					  struct genl_multicast_group *mcgrps,
+					  const struct genl_ops *ops, size_t n_ops,
+					  const struct genl_multicast_group *mcgrps,
 					  size_t n_mcgrps)
 {
-	family->ops = ops;
+	BUILD_BUG_ON(ARRAY_SIZE(__batadv_netlink_ops) != n_ops);
+	BUILD_BUG_ON(ARRAY_SIZE(__batadv_netlink_mcgrps) != n_mcgrps);
+	BUILD_BUG_ON(sizeof(__batadv_netlink_ops) != sizeof(*ops) * n_ops);
+	BUILD_BUG_ON(sizeof(__batadv_netlink_mcgrps) != sizeof(*mcgrps) * n_mcgrps);
+
+	memcpy(__batadv_netlink_ops, ops, sizeof(__batadv_netlink_ops));
+	memcpy(__batadv_netlink_mcgrps, mcgrps, sizeof(__batadv_netlink_mcgrps));
+
+	family->ops = __batadv_netlink_ops;
 	family->n_ops = n_ops;
-	family->mcgrps = mcgrps;
+	family->mcgrps = __batadv_netlink_mcgrps;
 	family->n_mcgrps = n_mcgrps;
 	family->module = THIS_MODULE;
 
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 64cb6ac..aee20a3 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -534,7 +534,7 @@ batadv_netlink_dump_hardifs(struct sk_buff *msg, struct netlink_callback *cb)
 	return msg->len;
 }
 
-static struct genl_ops batadv_netlink_ops[] = {
+static const struct genl_ops batadv_netlink_ops[] = {
 	{
 		.cmd = BATADV_CMD_GET_MESH_INFO,
 		.flags = GENL_ADMIN_PERM,

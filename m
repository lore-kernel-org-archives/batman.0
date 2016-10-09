Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  9 Oct 2016 08:57:31 +0200
Message-Id: <20161009065738.8279-4-sven@narfation.org>
In-Reply-To: <1647833.jYley1tZnH@sven-edge>
References: <1647833.jYley1tZnH@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH v2 04/11] batman-adv: Mark batadv_netlink_ops
	as const
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

The genl_ops don't need to be written by anyone and thus can be moved in a
ro memory range.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
 - new patch
---
 compat-patches/replacements.sh | 1 +
 net/batman-adv/netlink.c       | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/compat-patches/replacements.sh b/compat-patches/replacements.sh
index 4439a0d..fc4de84 100755
--- a/compat-patches/replacements.sh
+++ b/compat-patches/replacements.sh
@@ -5,4 +5,5 @@ set -e
 # for kernel < 3.13 to make netlink compat code work
 sed -i \
 	-e 's/^static const struct genl_multicast_group batadv_netlink_mcgrps/static struct genl_multicast_group batadv_netlink_mcgrps/' \
+	-e 's/^static const struct genl_ops batadv_netlink_ops/static struct genl_ops batadv_netlink_ops/' \
 	build/net/batman-adv/netlink.c
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
-- 
2.9.3


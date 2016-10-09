Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  9 Oct 2016 08:57:30 +0200
Message-Id: <20161009065738.8279-3-sven@narfation.org>
In-Reply-To: <1647833.jYley1tZnH@sven-edge>
References: <1647833.jYley1tZnH@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH next v2 03/11] batman-adv: make netlink
	attributes const
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

From: stephen hemminger <stephen@networkplumber.org>

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
[sven@narfation.org: Add compat-patch script]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
 - remove second replacement line which basically does nothing
   (thanks Linus)
---
 compat-patches/replacements.sh | 5 +++++
 net/batman-adv/netlink.c       | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/compat-patches/replacements.sh b/compat-patches/replacements.sh
index c7875c0..4439a0d 100755
--- a/compat-patches/replacements.sh
+++ b/compat-patches/replacements.sh
@@ -1,3 +1,8 @@
 #! /bin/sh
 
 set -e
+
+# for kernel < 3.13 to make netlink compat code work
+sed -i \
+	-e 's/^static const struct genl_multicast_group batadv_netlink_mcgrps/static struct genl_multicast_group batadv_netlink_mcgrps/' \
+	build/net/batman-adv/netlink.c
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 18831e7..64cb6ac 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -62,11 +62,11 @@ enum batadv_netlink_multicast_groups {
 	BATADV_NL_MCGRP_TPMETER,
 };
 
-static struct genl_multicast_group batadv_netlink_mcgrps[] = {
+static const struct genl_multicast_group batadv_netlink_mcgrps[] = {
 	[BATADV_NL_MCGRP_TPMETER] = { .name = BATADV_NL_MCAST_GROUP_TPMETER },
 };
 
-static struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
+static const struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_VERSION]		= { .type = NLA_STRING },
 	[BATADV_ATTR_ALGO_NAME]		= { .type = NLA_STRING },
 	[BATADV_ATTR_MESH_IFINDEX]	= { .type = NLA_U32 },
-- 
2.9.3


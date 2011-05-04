Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed,  4 May 2011 10:25:32 +0200
Message-Id: <1304497532-16946-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: cosmetic: Use ethtool
	ethtool_cmd_speed API
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

From: David Decotigny <decot@google.com>

This updates the network drivers so that they don't access the
ethtool_cmd::speed field directly, but use ethtool_cmd_speed()
instead.

For most of the drivers, these changes are purely cosmetic and don't
fix any problem, such as for those 1GbE/10GbE drivers that indirectly
call their own ethtool get_settings()/mii_ethtool_gset(). The changes
are meant to enforce code consistency and provide robustness with
future larger throughputs, at the expense of a few CPU cycles for each
ethtool operation.

All drivers compiled with make allyesconfig ion x86_64 have been
updated.

Tested: make allyesconfig on x86_64 + e1000e/bnx2x work
Signed-off-by: David Decotigny <decot@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[sven@narfation.org: compat function added]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
This patch is now part of net-next-2.6 and will be in linux 2.6.40

 compat.h         |    3 +++
 soft-interface.c |    2 +-
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/compat.h b/compat.h
index 0c5ad82..c3fd2cd 100644
--- a/compat.h
+++ b/compat.h
@@ -183,6 +183,9 @@ static inline char *pack_hex_byte(char *buf, u8 byte)
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 27)
 
+#define ethtool_cmd_speed_set(_ep, _speed) \
+	do { (_ep)->speed = (_speed); } while (0)
+
 #ifndef dereference_function_descriptor
 #define dereference_function_descriptor(p) (p)
 #endif
diff --git a/soft-interface.c b/soft-interface.c
index 1772e2b..9e5fcd1 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -723,7 +723,7 @@ static int bat_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
 {
 	cmd->supported = 0;
 	cmd->advertising = 0;
-	cmd->speed = SPEED_10;
+	ethtool_cmd_speed_set(cmd, SPEED_10);
 	cmd->duplex = DUPLEX_FULL;
 	cmd->port = PORT_TP;
 	cmd->phy_address = 0;
-- 
1.7.4.4


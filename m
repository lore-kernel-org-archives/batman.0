Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu,  9 Jun 2016 16:54:38 +0200
Message-Id: <1465484086-7974-7-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1465484086-7974-1-git-send-email-sw@simonwunderlich.de>
References: <1465484086-7974-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH v9 06/14] batman-adv: Provide TTVN in the
	mesh_info netlink msg
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

From: Sven Eckelmann <sven@narfation.org>

The TTVN is the main information for the debugging of translation table
problems. It is therefore necessary when comparing the global translation
tables.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/netlink.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 14360ec..0c0d20b 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -18,6 +18,7 @@
 #include "netlink.h"
 #include "main.h"
 
+#include <linux/atomic.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/genetlink.h>
@@ -121,7 +122,9 @@ batadv_netlink_mesh_info_put(struct sk_buff *msg, struct net_device *soft_iface)
 	    nla_put_u32(msg, BATADV_ATTR_MESH_IFINDEX, soft_iface->ifindex) ||
 	    nla_put_string(msg, BATADV_ATTR_MESH_IFNAME, soft_iface->name) ||
 	    nla_put(msg, BATADV_ATTR_MESH_ADDRESS, ETH_ALEN,
-		    soft_iface->dev_addr))
+		    soft_iface->dev_addr) ||
+	    nla_put_u8(msg, BATADV_ATTR_TT_TTVN,
+		       (u8)atomic_read(&bat_priv->tt.vn)))
 		goto out;
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
-- 
2.8.1


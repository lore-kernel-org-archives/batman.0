Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 23 May 2016 17:59:43 +0200
Message-Id: <1464019185-8381-13-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1464019185-8381-1-git-send-email-sw@simonwunderlich.de>
References: <1464019185-8381-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH v8 12/14] batman-adv: Provide bla group in
	the mesh_info netlink msg
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

The bridge loop avoidange is the main information for the debugging of of
bridge loop detection problems. It is therefore necessary when comparing
the bla claim tables.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/netlink.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 93a4c5d..e079974 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -19,6 +19,7 @@
 #include "main.h"
 
 #include <linux/atomic.h>
+#include <linux/byteorder/generic.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/genetlink.h>
@@ -42,6 +43,7 @@
 #include "gateway_client.h"
 #include "hard-interface.h"
 #include "originator.h"
+#include "packet.h"
 #include "soft-interface.h"
 #include "tp_meter.h"
 #include "translation-table.h"
@@ -141,6 +143,12 @@ batadv_netlink_mesh_info_put(struct sk_buff *msg, struct net_device *soft_iface)
 		       (u8)atomic_read(&bat_priv->tt.vn)))
 		goto out;
 
+#ifdef CONFIG_BATMAN_ADV_BLA
+	if (nla_put_u16(msg, BATADV_ATTR_BLA_CRC,
+			ntohs(bat_priv->bla.claim_dest.group)))
+		goto out;
+#endif
+
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 	if (primary_if && primary_if->if_status == BATADV_IF_ACTIVE) {
 		hard_iface = primary_if->net_dev;
-- 
2.8.1


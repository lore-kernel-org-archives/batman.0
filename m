Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Fri, 28 Aug 2015 11:12:32 +0200
Message-Id: <1440753156-7808-7-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1440753156-7808-1-git-send-email-antonio@meshcoding.com>
References: <1440753156-7808-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 06/10] batman-adv: fix gateway client style
	issues
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@meshcoding.com>

From: Simon Wunderlich <sw@simonwunderlich.de>

commit 0511575c4d03 ("batman-adv: remove obsolete deleted attribute for
gateway node") incorrectly added an empy line and forgot to remove an
include.

Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/gateway_client.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 634c7e3..e6c8382 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -27,7 +27,6 @@
 #include <linux/in.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
-#include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/netdevice.h>
@@ -565,7 +564,6 @@ void batadv_gw_node_free(struct batadv_priv *bat_priv)
 	spin_lock_bh(&bat_priv->gw.list_lock);
 	hlist_for_each_entry_safe(gw_node, node_tmp,
 				  &bat_priv->gw.list, list) {
-
 		hlist_del_init_rcu(&gw_node->list);
 		batadv_gw_node_free_ref(gw_node);
 	}
-- 
2.5.0


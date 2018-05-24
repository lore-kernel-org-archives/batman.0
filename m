Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 24 May 2018 13:53:22 +0200
Message-Id: <20180524115325.15355-2-sw@simonwunderlich.de>
In-Reply-To: <20180524115325.15355-1-sw@simonwunderlich.de>
References: <20180524115325.15355-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/4] batman-adv: don't pass a NULL hard_iface
 to batadv_hardif_put
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Colin Ian King <colin.king@canonical.com>, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Colin Ian King <colin.king@canonical.com>

In the case where hard_iface is NULL, the error path may pass a null
pointer to batadv_hardif_put causing a null pointer dereference error.
Avoid this by only calling the function if  hard_iface not null.

Detected by CoverityScan, CID#1466456 ("Explicit null dereferenced")

Fixes: 53dd9a68ba68 ("batman-adv: add multicast flags netlink support")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/multicast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index a11d3d89f012..a35f597e8c8b 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -1536,7 +1536,7 @@ batadv_mcast_netlink_get_primary(struct netlink_callback *cb,
 
 	if (!ret && primary_if)
 		*primary_if = hard_iface;
-	else
+	else if (hard_iface)
 		batadv_hardif_put(hard_iface);
 
 	return ret;
-- 
2.11.0


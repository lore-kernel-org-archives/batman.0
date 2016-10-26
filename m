Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 26 Oct 2016 17:55:13 +0200
Message-Id: <20161026155515.18075-2-sw@simonwunderlich.de>
In-Reply-To: <20161026155515.18075-1-sw@simonwunderlich.de>
References: <20161026155515.18075-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: Modify neigh_list only with
	rcu-list functions
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven.eckelmann@open-mesh.com>

From: Sven Eckelmann <sven.eckelmann@open-mesh.com>

The batadv_hard_iface::neigh_list is accessed via rcu based primitives.
Thus all operations done on it have to fulfill the requirements by RCU. So
using non-RCU mechanisms like hlist_add_head is not allowed because it
misses the barriers required to protect concurrent readers when accessing
the data behind the pointer.

Fixes: cef63419f7db ("batman-adv: add list of unique single hop neighbors per hard-interface")
Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Acked-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/originator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 5f3bfc4..7c8d160 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -544,7 +544,7 @@ batadv_hardif_neigh_create(struct batadv_hard_iface *hard_iface,
 	if (bat_priv->algo_ops->neigh.hardif_init)
 		bat_priv->algo_ops->neigh.hardif_init(hardif_neigh);
 
-	hlist_add_head(&hardif_neigh->list, &hard_iface->neigh_list);
+	hlist_add_head_rcu(&hardif_neigh->list, &hard_iface->neigh_list);
 
 out:
 	spin_unlock_bh(&hard_iface->neigh_list_lock);
-- 
2.10.1


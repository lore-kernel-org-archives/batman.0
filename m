Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 14 Nov 2012 21:16:20 +0100
Message-Id: <1352924189-18843-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1352924189-18843-1-git-send-email-ordex@autistici.org>
References: <1352924189-18843-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 02/11] batman-adv: fix wrong spinlock inline
	comment
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 8ce16c1..e8a1b18 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -303,7 +303,7 @@ struct batadv_priv {
 	struct hlist_head forw_bcast_list;
 	struct batadv_hashtable *orig_hash;
 	spinlock_t forw_bat_list_lock; /* protects forw_bat_list */
-	spinlock_t forw_bcast_list_lock; /* protects  */
+	spinlock_t forw_bcast_list_lock; /* protects forw_bcast_list */
 	struct delayed_work orig_work;
 	struct batadv_hard_iface __rcu *primary_if;  /* rcu protected pointer */
 	struct batadv_algo_ops *bat_algo_ops;
-- 
1.8.0


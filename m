Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun,  2 Sep 2012 19:00:38 +0200
Message-Id: <1346605238-26672-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix wrong spinlock inline comment
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
To: b.a.t.m.a.n@lists.open-mesh.org

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/types.h b/types.h
index dc126e7..e0c7ac2 100644
--- a/types.h
+++ b/types.h
@@ -263,7 +263,7 @@ struct batadv_priv {
 	struct hlist_head forw_bcast_list;
 	struct batadv_hashtable *orig_hash;
 	spinlock_t forw_bat_list_lock; /* protects forw_bat_list */
-	spinlock_t forw_bcast_list_lock; /* protects  */
+	spinlock_t forw_bcast_list_lock; /* protects forw_bcast_list */
 	struct delayed_work orig_work;
 	struct batadv_hard_iface __rcu *primary_if;  /* rcu protected pointer */
 	struct batadv_algo_ops *bat_algo_ops;
-- 
1.7.12


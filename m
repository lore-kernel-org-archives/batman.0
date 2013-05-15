Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 15 May 2013 09:34:48 +0200
Message-Id: <1368603288-1931-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: add declaration in compat code
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
Cc: Antonio Quartulli <ordex@autistici.org>

Add missing declaration in compat.h.

Introduced by 1bd816198771e2cbd44948a12aaca3ac33993d9d
"batman-adv: don't use call_rcu if not needed"

Reported-by: Daily build check <postmaster@open-mesh.org>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 compat.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/compat.h b/compat.h
index 8bd4f62..6c8559d 100644
--- a/compat.h
+++ b/compat.h
@@ -182,6 +182,7 @@ static const struct { \
 #define kfree_rcu(ptr, rcu_head) call_rcu(&ptr->rcu_head, batadv_free_rcu_##ptr)
 #define vlan_insert_tag(skb, proto, vid) __vlan_put_tag(skb, vid)
 
+void batadv_free_rcu_tt_global_entry(struct rcu_head *rcu);
 void batadv_free_rcu_gw_node(struct rcu_head *rcu);
 void batadv_free_rcu_neigh_node(struct rcu_head *rcu);
 void batadv_free_rcu_tt_local_entry(struct rcu_head *rcu);
-- 
1.8.1.5


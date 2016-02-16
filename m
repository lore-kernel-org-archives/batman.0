Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Tue, 16 Feb 2016 23:01:27 +0800
Message-Id: <1455634888-29400-3-git-send-email-a@unstable.cc>
In-Reply-To: <1455634888-29400-1-git-send-email-a@unstable.cc>
References: <1455634888-29400-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: Only put orig_node_vlan list
	reference when removed
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>, Marek Lindner <mareklindner@neomailbox.ch>

From: Sven Eckelmann <sven@narfation.org>

The batadv_orig_node_vlan reference counter in batadv_tt_global_size_mod
can only be reduced when the list entry was actually removed. Otherwise the
reference counter may reach zero when batadv_tt_global_size_mod is called
from two different contexts for the same orig_node_vlan but only one
context is actually removing the entry from the list.

The release function for this orig_node_vlan is not called inside the
vlan_list_lock spinlock protected region because the function
batadv_tt_global_size_mod still holds a orig_node_vlan reference for the
object pointer on the stack. Thus the actual release function (when
required) will be called only at the end of the function.

Fixes: 7ea7b4a14275 ("batman-adv: make the TT CRC logic VLAN specific")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/translation-table.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index cdfc85fa2743..0e80fd1461ab 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -303,9 +303,11 @@ static void batadv_tt_global_size_mod(struct batadv_orig_node *orig_node,
 
 	if (atomic_add_return(v, &vlan->tt.num_entries) == 0) {
 		spin_lock_bh(&orig_node->vlan_list_lock);
-		hlist_del_init_rcu(&vlan->list);
+		if (!hlist_unhashed(&vlan->list)) {
+			hlist_del_init_rcu(&vlan->list);
+			batadv_orig_node_vlan_free_ref(vlan);
+		}
 		spin_unlock_bh(&orig_node->vlan_list_lock);
-		batadv_orig_node_vlan_free_ref(vlan);
 	}
 
 	batadv_orig_node_vlan_free_ref(vlan);
-- 
2.7.1


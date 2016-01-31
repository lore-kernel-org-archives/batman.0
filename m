Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 31 Jan 2016 13:28:00 +0100
Message-Id: <1454243280-15126-2-git-send-email-sven@narfation.org>
In-Reply-To: <1454243280-15126-1-git-send-email-sven@narfation.org>
References: <1454243280-15126-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH-maint 2/2] batman-adv: Only put
	orig_node_vlan list reference when removed
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

Fixes: 21a57f6e7a3b ("batman-adv: make the TT CRC logic VLAN specific")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 9fcf6bf..7301a92 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -311,9 +311,11 @@ static void batadv_tt_global_size_mod(struct batadv_orig_node *orig_node,
 
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
2.7.0


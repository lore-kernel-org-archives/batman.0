Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH] batman-adv: Avoid RCU list-traversal in spinlock
Date: Sun, 16 Feb 2020 19:00:25 +0100
Message-Id: <20200216180025.14271-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: frextrite@gmail.com, joel@joelfernandes.org, Sven Eckelmann <sven@narfation.org>, Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

The new CONFIG_PROVE_RCU_LIST requires a condition statement in
(h)list_for_each_entry_rcu when the code might be executed in a non RCU
non-reader section with the writer lock. Otherwise lockdep might cause a
false positive warning like

  =============================
  WARNING: suspicious RCU usage
  -----------------------------
  translation-table.c:940 RCU-list traversed in non-reader section!!

batman-adv is (mostly) following the examples from the RCU documenation and
is using the normal list-traversal primitives instead of the RCU
list-traversal primitives when the writer (spin)lock is held.

The remaining users of RCU list-traversal primitives with writer spinlock
have to be converted to the same style as the rest of the code.

Reported-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 85293283..2d52356a 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -862,7 +862,7 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
 	u8 *tt_change_ptr;
 
 	spin_lock_bh(&orig_node->vlan_list_lock);
-	hlist_for_each_entry_rcu(vlan, &orig_node->vlan_list, list) {
+	hlist_for_each_entry(vlan, &orig_node->vlan_list, list) {
 		num_vlan++;
 		num_entries += atomic_read(&vlan->tt.num_entries);
 	}
@@ -888,7 +888,7 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
 	(*tt_data)->num_vlan = htons(num_vlan);
 
 	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(*tt_data + 1);
-	hlist_for_each_entry_rcu(vlan, &orig_node->vlan_list, list) {
+	hlist_for_each_entry(vlan, &orig_node->vlan_list, list) {
 		tt_vlan->vid = htons(vlan->vid);
 		tt_vlan->crc = htonl(vlan->tt.crc);
 
@@ -937,7 +937,7 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 	int change_offset;
 
 	spin_lock_bh(&bat_priv->softif_vlan_list_lock);
-	hlist_for_each_entry_rcu(vlan, &bat_priv->softif_vlan_list, list) {
+	hlist_for_each_entry(vlan, &bat_priv->softif_vlan_list, list) {
 		vlan_entries = atomic_read(&vlan->tt.num_entries);
 		if (vlan_entries < 1)
 			continue;
-- 
2.20.1


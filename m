Return-Path: <madhuparnabhowmik10@gmail.com>
From: madhuparnabhowmik10@gmail.com
Subject: [PATCH] net: batman-adv: Use built-in RCU list checking
Date: Sun, 16 Feb 2020 20:17:18 +0530
Message-Id: <20200216144718.2841-1-madhuparnabhowmik10@gmail.com>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc, sven@narfation.org, davem@davemloft.net
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, joel@joelfernandes.org, frextrite@gmail.com, linux-kernel-mentees@lists.linuxfoundation.org, Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

hlist_for_each_entry_rcu() has built-in RCU and lock checking.

Pass cond argument to hlist_for_each_entry_rcu() to silence
false lockdep warnings when CONFIG_PROVE_RCU_LIST is enabled
by default.

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
---
 net/batman-adv/translation-table.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 8a482c5ec67b..0e3c31cbe0e8 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -862,7 +862,8 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
 	u8 *tt_change_ptr;
 
 	spin_lock_bh(&orig_node->vlan_list_lock);
-	hlist_for_each_entry_rcu(vlan, &orig_node->vlan_list, list) {
+	hlist_for_each_entry_rcu(vlan, &orig_node->vlan_list, list,
+				lockdep_is_held(&orig_node->vlan_list_lock)) {
 		num_vlan++;
 		num_entries += atomic_read(&vlan->tt.num_entries);
 	}
@@ -888,7 +889,8 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
 	(*tt_data)->num_vlan = htons(num_vlan);
 
 	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(*tt_data + 1);
-	hlist_for_each_entry_rcu(vlan, &orig_node->vlan_list, list) {
+	hlist_for_each_entry_rcu(vlan, &orig_node->vlan_list, list,
+				lockdep_is_held(&orig_node->vlan_list_lock)) {
 		tt_vlan->vid = htons(vlan->vid);
 		tt_vlan->crc = htonl(vlan->tt.crc);
 
@@ -937,7 +939,8 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 	int change_offset;
 
 	spin_lock_bh(&bat_priv->softif_vlan_list_lock);
-	hlist_for_each_entry_rcu(vlan, &bat_priv->softif_vlan_list, list) {
+	hlist_for_each_entry_rcu(vlan, &bat_priv->softif_vlan_list, list,
+				lockdep_is_held(&bat_priv->softif_vlan_list_lock)) {
 		vlan_entries = atomic_read(&vlan->tt.num_entries);
 		if (vlan_entries < 1)
 			continue;
@@ -967,7 +970,8 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 	(*tt_data)->num_vlan = htons(num_vlan);
 
 	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(*tt_data + 1);
-	hlist_for_each_entry_rcu(vlan, &bat_priv->softif_vlan_list, list) {
+	hlist_for_each_entry_rcu(vlan, &bat_priv->softif_vlan_list, list,
+				lockdep_is_held(&bat_priv->softif_vlan_list_lock)) {
 		vlan_entries = atomic_read(&vlan->tt.num_entries);
 		if (vlan_entries < 1)
 			continue;
-- 
2.17.1


Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 18 Jun 2015 11:04:29 +0800
Message-Id: <1434596669-9597-1-git-send-email-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [PATCHv2 maint] batman-adv: fix kernel crash due to
	missing NULL checks
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

batadv_softif_vlan_get() may return NULL which has to be verified
by the caller.

Reported-by: Ryan Thompson <ryan@eero.com>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
v2: add WARN() in batadv_tt_local_add()

 soft-interface.c    |  3 +++
 translation-table.c | 20 ++++++++++++++++----
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/soft-interface.c b/soft-interface.c
index da89336..7841a4b 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -455,6 +455,9 @@ out:
  */
 void batadv_softif_vlan_free_ref(struct batadv_softif_vlan *vlan)
 {
+	if (!vlan)
+		return;
+
 	if (atomic_dec_and_test(&vlan->refcount)) {
 		spin_lock_bh(&vlan->bat_priv->softif_vlan_list_lock);
 		hlist_del_rcu(&vlan->list);
diff --git a/translation-table.c b/translation-table.c
index e95a424..ae82f69 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -575,6 +575,11 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 
 	/* increase the refcounter of the related vlan */
 	vlan = batadv_softif_vlan_get(bat_priv, vid);
+	if (!vlan) {
+		WARN(1, "adding TT local entry %pM to non-existent VLAN %d",
+		     addr, BATADV_PRINT_VID(vid));
+		goto out;
+	}
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Creating new local tt entry: %pM (vid: %d, ttvn: %d)\n",
@@ -1047,6 +1052,9 @@ uint16_t batadv_tt_local_remove(struct batadv_priv *bat_priv,
 
 	/* decrease the reference held for this vlan */
 	vlan = batadv_softif_vlan_get(bat_priv, vid);
+	if (!vlan)
+		goto out;
+
 	batadv_softif_vlan_free_ref(vlan);
 	batadv_softif_vlan_free_ref(vlan);
 
@@ -1147,8 +1155,10 @@ static void batadv_tt_local_table_free(struct batadv_priv *bat_priv)
 			/* decrease the reference held for this vlan */
 			vlan = batadv_softif_vlan_get(bat_priv,
 						      tt_common_entry->vid);
-			batadv_softif_vlan_free_ref(vlan);
-			batadv_softif_vlan_free_ref(vlan);
+			if (vlan) {
+				batadv_softif_vlan_free_ref(vlan);
+				batadv_softif_vlan_free_ref(vlan);
+			}
 
 			batadv_tt_local_entry_free_ref(tt_local);
 		}
@@ -3188,8 +3198,10 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 
 			/* decrease the reference held for this vlan */
 			vlan = batadv_softif_vlan_get(bat_priv, tt_common->vid);
-			batadv_softif_vlan_free_ref(vlan);
-			batadv_softif_vlan_free_ref(vlan);
+			if (vlan) {
+				batadv_softif_vlan_free_ref(vlan);
+				batadv_softif_vlan_free_ref(vlan);
+			}
 
 			batadv_tt_local_entry_free_ref(tt_local);
 		}
-- 
2.1.4


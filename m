Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Wed,  5 Aug 2015 14:51:45 +0200
Message-Id: <1438779107-12665-3-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1438779107-12665-1-git-send-email-antonio@meshcoding.com>
References: <1438779107-12665-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 2/4] batman-adv: fix kernel crash due to
	missing NULL checks
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@meshcoding.com>

From: Marek Lindner <mareklindner@neomailbox.ch>

batadv_softif_vlan_get() may return NULL which has to be verified
by the caller.

Fixes: 35df3b298fc8 ("batman-adv: fix TT VLAN inconsistency on VLAN re-add")
Reported-by: Ryan Thompson <ryan@eero.com>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/soft-interface.c    |  3 +++
 net/batman-adv/translation-table.c | 18 ++++++++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index c002961..a2fc843 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -479,6 +479,9 @@ out:
  */
 void batadv_softif_vlan_free_ref(struct batadv_softif_vlan *vlan)
 {
+	if (!vlan)
+		return;
+
 	if (atomic_dec_and_test(&vlan->refcount)) {
 		spin_lock_bh(&vlan->bat_priv->softif_vlan_list_lock);
 		hlist_del_rcu(&vlan->list);
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index b482495..38b83c5 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -594,6 +594,9 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 
 	/* increase the refcounter of the related vlan */
 	vlan = batadv_softif_vlan_get(bat_priv, vid);
+	if (WARN(!vlan, "adding TT local entry %pM to non-existent VLAN %d",
+		 addr, BATADV_PRINT_VID(vid)))
+		goto out;
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Creating new local tt entry: %pM (vid: %d, ttvn: %d)\n",
@@ -1066,6 +1069,9 @@ uint16_t batadv_tt_local_remove(struct batadv_priv *bat_priv,
 
 	/* decrease the reference held for this vlan */
 	vlan = batadv_softif_vlan_get(bat_priv, vid);
+	if (!vlan)
+		goto out;
+
 	batadv_softif_vlan_free_ref(vlan);
 	batadv_softif_vlan_free_ref(vlan);
 
@@ -1166,8 +1172,10 @@ static void batadv_tt_local_table_free(struct batadv_priv *bat_priv)
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
@@ -3207,8 +3215,10 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 
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
2.5.0


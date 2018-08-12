Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 12 Aug 2018 21:04:43 +0200
Message-Id: <20180812190445.28013-4-sven@narfation.org>
In-Reply-To: <20180812190445.28013-1-sven@narfation.org>
References: <20180812190445.28013-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 3/5] batman-adv: Prevent duplicated
 softif_vlan entry
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

The function batadv_softif_vlan_get is responsible for adding new
softif_vlan to the softif_vlan_list. It first checks whether the entry
already is in the list or not. If it is, then the creation of a new entry
is aborted.

But the lock for the list is only held when the list is really modified.
This could lead to duplicated entries because another context could create
an entry with the same key between the check and the list manipulation.

The check and the manipulation of the list must therefore be in the same
locked code section.

Fixes: 952cebb57518 ("batman-adv: add per VLAN interface attribute framework")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/soft-interface.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 1485263a..426a98bf 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -572,17 +572,21 @@ struct batadv_softif_vlan *batadv_softif_vlan_get(struct batadv_priv *bat_priv,
 int batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
 {
 	struct batadv_softif_vlan *vlan;
-	int err;
+
+	spin_lock_bh(&bat_priv->softif_vlan_list_lock);
 
 	vlan = batadv_softif_vlan_get(bat_priv, vid);
 	if (vlan) {
 		batadv_softif_vlan_put(vlan);
+		spin_unlock_bh(&bat_priv->softif_vlan_list_lock);
 		return -EEXIST;
 	}
 
 	vlan = kzalloc(sizeof(*vlan), GFP_ATOMIC);
-	if (!vlan)
+	if (!vlan) {
+		spin_unlock_bh(&bat_priv->softif_vlan_list_lock);
 		return -ENOMEM;
+	}
 
 	vlan->bat_priv = bat_priv;
 	vlan->vid = vid;
@@ -590,17 +594,16 @@ int batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
 
 	atomic_set(&vlan->ap_isolation, 0);
 
-	err = batadv_sysfs_add_vlan(bat_priv->soft_iface, vlan);
-	if (err) {
-		kfree(vlan);
-		return err;
-	}
-
-	spin_lock_bh(&bat_priv->softif_vlan_list_lock);
 	kref_get(&vlan->refcount);
 	hlist_add_head_rcu(&vlan->list, &bat_priv->softif_vlan_list);
 	spin_unlock_bh(&bat_priv->softif_vlan_list_lock);
 
+	/* adding sysfs can fail but it is now to late to handle it.
+	 * it can also not be in the spinlock section due to the sleeping
+	 * behavior of the sysfs functions and the fs_reclaim lock
+	 */
+	batadv_sysfs_add_vlan(bat_priv->soft_iface, vlan);
+
 	/* add a new TT local entry. This one will be marked with the NOPURGE
 	 * flag
 	 */
-- 
2.18.0


Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Mon, 24 Mar 2014 01:54:25 +0100
Message-Id: <1395622465-1197-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCHv2 maint] batman-adv: change the MAC of each
	VLAN upon ndo_set_mac_address
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

The MAC address of the soft-interface is used to initialise
the "non-purge" TT entry of each existing VLAN. Therefore
when the user invokes ndo_set_mac_address() all the
"non-purge" TT entries have to be updated, not only the one
belonging to the non-tagged network.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---

Changes from v1:
- declare vlan variable

 soft-interface.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/soft-interface.c b/soft-interface.c
index f82c267..cbe9e33 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -105,6 +105,7 @@ static struct net_device_stats *batadv_interface_stats(struct net_device *dev)
 static int batadv_interface_set_mac_addr(struct net_device *dev, void *p)
 {
 	struct batadv_priv *bat_priv = netdev_priv(dev);
+	struct batadv_softif_vlan *vlan;
 	struct sockaddr *addr = p;
 	uint8_t old_addr[ETH_ALEN];
 
@@ -115,12 +116,22 @@ static int batadv_interface_set_mac_addr(struct net_device *dev, void *p)
 	memcpy(dev->dev_addr, addr->sa_data, ETH_ALEN);
 
 	/* only modify transtable if it has been initialized before */
-	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_ACTIVE) {
-		batadv_tt_local_remove(bat_priv, old_addr, BATADV_NO_FLAGS,
+	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
+		return 0;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(vlan, &bat_priv->softif_vlan_list, list) {
+		if (!atomic_inc_not_zero(&vlan->refcount))
+			continue;
+
+		batadv_tt_local_remove(bat_priv, old_addr, vlan->vid,
 				       "mac address changed", false);
-		batadv_tt_local_add(dev, addr->sa_data, BATADV_NO_FLAGS,
+		batadv_tt_local_add(dev, addr->sa_data, vlan->vid,
 				    BATADV_NULL_IFINDEX, BATADV_NO_MARK);
+
+		batadv_softif_vlan_free_ref(vlan);
 	}
+	rcu_read_unlock();
 
 	return 0;
 }
-- 
1.8.3.2


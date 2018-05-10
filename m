Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 10 May 2018 23:27:52 +0800
Message-Id: <20180510152752.2557-1-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [RFC maint] batman-adv: fix adding VLANs with
 partial state
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

Whenever a new VLAN is created on top of batman virtual interfaces
the batman-adv kernel module creates internal structures to track
the status of said VLAN. Amongst other things, the MAC address of
the VLAN interface itself has to be stored.

Without this change a VLAN and its infrastructure could be created
while the interface MAC address is not stored without triggering
any error, thus creating issues in other parts of the code.

Prevent the VLAN from being created if the MAC address can not
be stored.

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 net/batman-adv/soft-interface.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index edeffcb9..f7c3a313 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -572,6 +572,7 @@ struct batadv_softif_vlan *batadv_softif_vlan_get(struct batadv_priv *bat_priv,
 int batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
 {
 	struct batadv_softif_vlan *vlan;
+	bool client_added;
 	int err;
 
 	vlan = batadv_softif_vlan_get(bat_priv, vid);
@@ -604,13 +605,18 @@ int batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
 	/* add a new TT local entry. This one will be marked with the NOPURGE
 	 * flag
 	 */
-	batadv_tt_local_add(bat_priv->soft_iface,
-			    bat_priv->soft_iface->dev_addr, vid,
-			    BATADV_NULL_IFINDEX, BATADV_NO_MARK);
+	client_added = batadv_tt_local_add(bat_priv->soft_iface,
+					   bat_priv->soft_iface->dev_addr, vid,
+					   BATADV_NULL_IFINDEX, BATADV_NO_MARK);
 
 	/* don't return reference to new softif_vlan */
 	batadv_softif_vlan_put(vlan);
 
+	if (!client_added) {
+		batadv_softif_destroy_vlan(bat_priv, vlan);
+		return -ENOENT;
+	}
+
 	return 0;
 }
 
@@ -648,6 +654,7 @@ static int batadv_interface_add_vid(struct net_device *dev, __be16 proto,
 {
 	struct batadv_priv *bat_priv = netdev_priv(dev);
 	struct batadv_softif_vlan *vlan;
+	bool client_added;
 	int ret;
 
 	/* only 802.1Q vlans are supported.
@@ -683,9 +690,14 @@ static int batadv_interface_add_vid(struct net_device *dev, __be16 proto,
 	 * flag. This must be added again, even if the vlan object already
 	 * exists, because the entry was deleted by kill_vid()
 	 */
-	batadv_tt_local_add(bat_priv->soft_iface,
-			    bat_priv->soft_iface->dev_addr, vid,
-			    BATADV_NULL_IFINDEX, BATADV_NO_MARK);
+	client_added = batadv_tt_local_add(bat_priv->soft_iface,
+					   bat_priv->soft_iface->dev_addr, vid,
+					   BATADV_NULL_IFINDEX, BATADV_NO_MARK);
+
+	if (!client_added) {
+		batadv_softif_destroy_vlan(bat_priv, vlan);
+		return -ENOENT;
+	}
 
 	return 0;
 }
-- 
2.17.0


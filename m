Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue,  4 Jun 2013 12:11:46 +0200
Message-Id: <1370340711-1399-9-git-send-email-ordex@autistici.org>
In-Reply-To: <1370340711-1399-1-git-send-email-ordex@autistici.org>
References: <1370340711-1399-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv4 08/13] batman-adv: treat bat0 like yet
	another VLAN
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

To make the code simpler and easier to extend, treat the
normal LAN (bat0) like any other VLAN having vid 0
(untagged).

This change makes things simpler since bat0 is not a
particular case anymore but it is treated like any other
VLAN.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 main.c           |  8 +-------
 soft-interface.c | 61 +++++++++++++++++++++++++++++++++++++++-----------------
 2 files changed, 44 insertions(+), 25 deletions(-)

diff --git a/main.c b/main.c
index 7525d96..455661b 100644
--- a/main.c
+++ b/main.c
@@ -129,9 +129,6 @@ int batadv_mesh_init(struct net_device *soft_iface)
 	if (ret < 0)
 		goto err;
 
-	batadv_tt_local_add(soft_iface, soft_iface->dev_addr,
-			    BATADV_NULL_IFINDEX, BATADV_NO_FLAGS);
-
 	ret = batadv_bla_init(bat_priv);
 	if (ret < 0)
 		goto err;
@@ -1140,12 +1137,9 @@ struct batadv_softif_vlan *batadv_softif_vlan_get(struct batadv_priv *bat_priv,
 {
 	struct batadv_softif_vlan *vlan, *vlan_tmp = NULL;
 
-	if (!(vid & BATADV_VLAN_HAS_TAG))
-		return NULL;
-
 	rcu_read_lock();
 	list_for_each_entry_rcu(vlan, &bat_priv->softif_vlan_list, list) {
-		if (vlan->vid != (vid & VLAN_VID_MASK))
+		if (vlan->vid != vid)
 			continue;
 
 		if (!atomic_inc_not_zero(&vlan->refcount))
diff --git a/soft-interface.c b/soft-interface.c
index 414b4b1..0280dfc 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -373,28 +373,18 @@ out:
 }
 
 /**
- * batadv_interface_add_vid - ndo_add_vid API implementation
- * @dev: the netdev of the mesh interface
- * @vid: identifier of the new VLAN
- *
- * Set up all the internal structures for handling the new VLAN on top of the
- * mesh interface
+ * batadv_create_vlan - allocate the needed resources for a new vlan
+ * @bat_priv: the bat priv with all the soft interface information
+ * @vid: the VLAN identifier
  *
- * Return 0 on success or a negative error code in case of failure
+ * Return 0 on success, a negative error otherwise.
  */
-static int batadv_interface_add_vid(struct net_device *dev, __be16 proto,
-				    unsigned short vid)
+static int batadv_softif_create_vlan(struct batadv_priv *bat_priv,
+				     unsigned short vid)
 {
-	struct batadv_priv *bat_priv = netdev_priv(dev);
 	struct batadv_softif_vlan *vlan;
 
-	/* only 802.1Q vlans are supported. batman-adv does not know how to
-	 * handle other types
-	 */
-	if (proto != htons(ETH_P_8021Q))
-		return -EINVAL;
-
-	vlan = kmalloc(sizeof(*vlan), GFP_ATOMIC);
+	vlan = kzalloc(sizeof(*vlan), GFP_ATOMIC);
 	if (!vlan)
 		return -ENOMEM;
 
@@ -404,7 +394,8 @@ static int batadv_interface_add_vid(struct net_device *dev, __be16 proto,
 	/* add a new TT local entry. This one will be marked with the NOPURGE
 	 * flag
 	 */
-	batadv_tt_local_add(dev, dev->dev_addr, vid | BATADV_VLAN_HAS_TAG,
+	batadv_tt_local_add(bat_priv->soft_iface,
+			    bat_priv->soft_iface->dev_addr, vid,
 			    BATADV_NULL_IFINDEX);
 
 	spin_lock_bh(&bat_priv->softif_vlan_list_lock);
@@ -415,6 +406,32 @@ static int batadv_interface_add_vid(struct net_device *dev, __be16 proto,
 }
 
 /**
+ * batadv_interface_add_vid - ndo_add_vid API implementation
+ * @dev: the netdev of the mesh interface
+ * @vid: identifier of the new VLAN
+ *
+ * Set up all the internal structures for handling the new VLAN on top of the
+ * mesh interface
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+static int batadv_interface_add_vid(struct net_device *dev, __be16 proto,
+				    unsigned short vid)
+{
+	struct batadv_priv *bat_priv = netdev_priv(dev);
+
+	/* only 802.1Q vlans are supported.
+	 * batman-adv does not know how to handle other types
+	 */
+	if (proto != htons(ETH_P_8021Q))
+		return -EINVAL;
+
+	vid |= BATADV_VLAN_HAS_TAG;
+
+	return batadv_softif_create_vlan(bat_priv, vid);
+}
+
+/**
  * batadv_interface_kill_vid - ndo_kill_vid API implementation
  * @dev: the netdev of the mesh interface
  * @vid: identifier of the deleted VLAN
@@ -741,8 +758,16 @@ struct net_device *batadv_softif_create(const char *name)
 	if (ret < 0)
 		goto free_mesh;
 
+	bat_priv = netdev_priv(soft_iface);
+	/* add the "untagged" LAN */
+	ret = batadv_softif_create_vlan(bat_priv, BATADV_NO_FLAGS);
+	if (ret < 0)
+		goto free_sysfs;
+
 	return soft_iface;
 
+free_sysfs:
+	batadv_sysfs_del_meshif(soft_iface);
 free_mesh:
 	batadv_mesh_free(soft_iface);
 free_dev:
-- 
1.8.1.5


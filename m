Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 26 Jun 2016 11:16:13 +0200
Message-Id: <1466932573-23105-5-git-send-email-sven@narfation.org>
In-Reply-To: <10049349.EHEiaYmtBd@sven-edge>
References: <10049349.EHEiaYmtBd@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH net 5/5] batman-adv: Clean up untagged vlan
	when destroying via rtnl-link
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>

The untagged vlan object is only destroyed when the interface is removed
via the legacy sysfs interface. But it also has to be destroyed when the
standard rtnl-link interface is used.

Fixes: 5d2c05b21337 ("batman-adv: add per VLAN interface attribute framework")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Acked-by: Antonio Quartulli <a@unstable.cc>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 net/batman-adv/soft-interface.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 343d2c9..287a387 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -1033,7 +1033,9 @@ void batadv_softif_destroy_sysfs(struct net_device *soft_iface)
 static void batadv_softif_destroy_netlink(struct net_device *soft_iface,
 					  struct list_head *head)
 {
+	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
 	struct batadv_hard_iface *hard_iface;
+	struct batadv_softif_vlan *vlan;
 
 	list_for_each_entry(hard_iface, &batadv_hardif_list, list) {
 		if (hard_iface->soft_iface == soft_iface)
@@ -1041,6 +1043,13 @@ static void batadv_softif_destroy_netlink(struct net_device *soft_iface,
 							BATADV_IF_CLEANUP_KEEP);
 	}
 
+	/* destroy the "untagged" VLAN */
+	vlan = batadv_softif_vlan_get(bat_priv, BATADV_NO_FLAGS);
+	if (vlan) {
+		batadv_softif_destroy_vlan(bat_priv, vlan);
+		batadv_softif_vlan_put(vlan);
+	}
+
 	batadv_sysfs_del_meshif(soft_iface);
 	unregister_netdevice_queue(soft_iface, head);
 }
-- 
2.8.1


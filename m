Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 22 Aug 2016 15:56:14 +0200
Message-Id: <20160822135620.15337-15-sw@simonwunderlich.de>
In-Reply-To: <20160822135620.15337-1-sw@simonwunderlich.de>
References: <20160822135620.15337-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 14/20] batman-adv: Place kref_get for
	softif_vlan near use
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>

From: Sven Eckelmann <sven@narfation.org>

It is hard to understand why the refcnt is increased when it isn't done
near the actual place the new reference is used. So using kref_get right
before the place which requires the reference and in the same function
helps to avoid accidental problems caused by incorrect reference counting.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/soft-interface.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index e508bf5..49e16b6 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -594,6 +594,7 @@ int batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
 	}
 
 	spin_lock_bh(&bat_priv->softif_vlan_list_lock);
+	kref_get(&vlan->refcount);
 	hlist_add_head_rcu(&vlan->list, &bat_priv->softif_vlan_list);
 	spin_unlock_bh(&bat_priv->softif_vlan_list_lock);
 
@@ -604,6 +605,9 @@ int batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
 			    bat_priv->soft_iface->dev_addr, vid,
 			    BATADV_NULL_IFINDEX, BATADV_NO_MARK);
 
+	/* don't return reference to new softif_vlan */
+	batadv_softif_vlan_put(vlan);
+
 	return 0;
 }
 
-- 
2.9.3


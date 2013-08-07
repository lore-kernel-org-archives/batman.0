Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu,  8 Aug 2013 01:07:28 +0200
Message-Id: <1375916848-1874-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix memory leak in
	batadv_softif_create_vlan()
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

Introduced by e4ff5c153dab054a6cd1c4132f87bc5e77127456
("batman-adv: add sysfs framework for VLAN")

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 soft-interface.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/soft-interface.c b/soft-interface.c
index 7cd23f5..f813bd5 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -466,8 +466,10 @@ int batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
 	atomic_set(&vlan->ap_isolation, 0);
 
 	err = batadv_sysfs_add_vlan(bat_priv->soft_iface, vlan);
-	if (err)
+	if (err) {
+		kfree(vlan);
 		return err;
+	}
 
 	spin_lock_bh(&bat_priv->softif_vlan_list_lock);
 	hlist_add_head_rcu(&vlan->list, &bat_priv->softif_vlan_list);
-- 
1.8.1.5


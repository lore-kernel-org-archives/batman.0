Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sat, 19 Oct 2013 15:23:42 +0200
Message-Id: <1382189022-3987-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH next] batman-adv: fix arguments order when
	calling tt_local_add
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

Introduced by c018ad3de61a1dc4194879a53e5559e094aa7b1a
("batman-adv: add the VLAN ID attribute to the TT entry")

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 soft-interface.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/soft-interface.c b/soft-interface.c
index a1f00e8..36f0508 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -120,8 +120,8 @@ static int batadv_interface_set_mac_addr(struct net_device *dev, void *p)
 	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_ACTIVE) {
 		batadv_tt_local_remove(bat_priv, old_addr, BATADV_NO_FLAGS,
 				       "mac address changed", false);
-		batadv_tt_local_add(dev, addr->sa_data, BATADV_NULL_IFINDEX,
-				    BATADV_NO_FLAGS);
+		batadv_tt_local_add(dev, addr->sa_data, BATADV_NO_FLAGS,
+				    BATADV_NULL_IFINDEX);
 	}
 
 	return 0;
-- 
1.8.4


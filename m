Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Thu, 15 May 2014 11:08:06 +0200
Message-Id: <1400144887-24455-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH maint 1/2] batman-adv: fix alignment
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

Introduced by 9729d2085c0fa4398eb1ee518b0097866dfdcd77
("batman-adv: fix TT VLAN inconsistency on VLAN re-add")

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 soft-interface.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/soft-interface.c b/soft-interface.c
index 5a9dc2f..82804e7 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -594,8 +594,8 @@ static int batadv_interface_add_vid(struct net_device *dev, __be16 proto,
 	 * exists, because the entry was deleted by kill_vid()
 	 */
 	batadv_tt_local_add(bat_priv->soft_iface,
-			     bat_priv->soft_iface->dev_addr, vid,
-			     BATADV_NULL_IFINDEX, BATADV_NO_MARK);
+			    bat_priv->soft_iface->dev_addr, vid,
+			    BATADV_NULL_IFINDEX, BATADV_NO_MARK);
 
 	return 0;
 }
-- 
1.8.5.5


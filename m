Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Thu, 15 May 2014 11:08:07 +0200
Message-Id: <1400144887-24455-2-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1400144887-24455-1-git-send-email-antonio@meshcoding.com>
References: <1400144887-24455-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH maint 2/2] batman-adv: fix var name to keep
	compatibility with old kernels
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

The first argument of kfree_rcu() is used in compat.h to forge
a function name used by old kernels. Keep it as it was before
to avoid breaking this compat mechanism.

Introduced by 9729d2085c0fa4398eb1ee518b0097866dfdcd77
("batman-adv: fix TT VLAN inconsistency on VLAN re-add")

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 soft-interface.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/soft-interface.c b/soft-interface.c
index 82804e7..a4e6e5e 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -437,14 +437,14 @@ out:
  *  possibly free it
  * @softif_vlan: the vlan object to release
  */
-void batadv_softif_vlan_free_ref(struct batadv_softif_vlan *vlan)
+void batadv_softif_vlan_free_ref(struct batadv_softif_vlan *softif_vlan)
 {
-	if (atomic_dec_and_test(&vlan->refcount)) {
-		spin_lock_bh(&vlan->bat_priv->softif_vlan_list_lock);
-		hlist_del_rcu(&vlan->list);
-		spin_unlock_bh(&vlan->bat_priv->softif_vlan_list_lock);
+	if (atomic_dec_and_test(&softif_vlan->refcount)) {
+		spin_lock_bh(&softif_vlan->bat_priv->softif_vlan_list_lock);
+		hlist_del_rcu(&softif_vlan->list);
+		spin_unlock_bh(&softif_vlan->bat_priv->softif_vlan_list_lock);
 
-		kfree_rcu(vlan, rcu);
+		kfree_rcu(softif_vlan, rcu);
 	}
 }
 
-- 
1.8.5.5


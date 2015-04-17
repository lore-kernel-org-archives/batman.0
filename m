Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 17 Apr 2015 19:18:08 +0200
Message-Id: <1429291088-27181-1-git-send-email-sven@narfation.org>
In-Reply-To: <1429288461-26260-5-git-send-email-sven@narfation.org>
References: <1429288461-26260-5-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH-nextv2 5/6] batman-adv: Revert "fix var name
	to keep compatibility with old kernels"
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

The original patch b53915310227cc9b029ba0fa5aae44e50a461f80 should not be
submitted to net-next. It can be better implemented using compat code.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
This compat code must be removed again when applying
https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2015-April/012963.html

v2:
 swap Revert and batman-adv: prefix

 compat.c         |  9 +++++++++
 compat.h         |  1 +
 soft-interface.c | 12 ++++++------
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/compat.c b/compat.c
index 3dbf9d2..516d06c 100644
--- a/compat.c
+++ b/compat.c
@@ -42,6 +42,15 @@ void batadv_free_rcu_softif_vlan(struct rcu_head *rcu)
 	kfree(vlan);
 }
 
+void batadv_free_rcu_vlan(struct rcu_head *rcu)
+{
+	struct batadv_softif_vlan *vlan;
+
+	vlan = container_of(rcu, struct batadv_softif_vlan, rcu);
+
+	kfree(vlan);
+}
+
 void batadv_free_rcu_tt_global_entry(struct rcu_head *rcu)
 {
 	struct batadv_tt_global_entry *global;
diff --git a/compat.h b/compat.h
index 0332296..e55c1d6 100644
--- a/compat.h
+++ b/compat.h
@@ -234,6 +234,7 @@ void batadv_free_rcu_backbone_gw(struct rcu_head *rcu);
 void batadv_free_rcu_dat_entry(struct rcu_head *rcu);
 void batadv_free_rcu_nc_path(struct rcu_head *rcu);
 void batadv_free_rcu_tvlv_handler(struct rcu_head *rcu);
+void batadv_free_rcu_vlan(struct rcu_head *rcu);
 
 static inline void skb_reset_mac_len(struct sk_buff *skb)
 {
diff --git a/soft-interface.c b/soft-interface.c
index 8748987..70edc41 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -453,14 +453,14 @@ out:
  *  possibly free it
  * @softif_vlan: the vlan object to release
  */
-void batadv_softif_vlan_free_ref(struct batadv_softif_vlan *softif_vlan)
+void batadv_softif_vlan_free_ref(struct batadv_softif_vlan *vlan)
 {
-	if (atomic_dec_and_test(&softif_vlan->refcount)) {
-		spin_lock_bh(&softif_vlan->bat_priv->softif_vlan_list_lock);
-		hlist_del_rcu(&softif_vlan->list);
-		spin_unlock_bh(&softif_vlan->bat_priv->softif_vlan_list_lock);
+	if (atomic_dec_and_test(&vlan->refcount)) {
+		spin_lock_bh(&vlan->bat_priv->softif_vlan_list_lock);
+		hlist_del_rcu(&vlan->list);
+		spin_unlock_bh(&vlan->bat_priv->softif_vlan_list_lock);
 
-		kfree_rcu(softif_vlan, rcu);
+		kfree_rcu(vlan, rcu);
 	}
 }
 
-- 
2.1.4


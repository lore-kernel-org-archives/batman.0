Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 17 Jan 2016 11:01:15 +0100
Message-Id: <1453024887-7215-7-git-send-email-sven@narfation.org>
In-Reply-To: <1453024887-7215-1-git-send-email-sven@narfation.org>
References: <1453024887-7215-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v7 07/19] batman-adv: Rename
	batadv_backbone_gw *_free_ref function to *_put
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

The batman-adv source code is the only place in the kernel which uses the
*_free_ref naming scheme for the *_put functions. Changing it to *_put
makes it more consistent and makes it easier to understand the connection
to the *_get functions.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v7:
 - removed patches which are now applied in the branch master
 - split *_get -> *_put rename patches into smaller patches only renaming single
   functions
v6:
 - removed patches which are now applied in the branch next
 - rebased remaining patches on the patch
   "batman-adv: Avoid recursive call_rcu for batadv_nc_node" which was
   modified by Marek while he applied the patches (this unfortunately made
   some of the remaining patches slightly harder to apply)
v5:
 - add hack which allows to compile against stable kernel like 3.2.44 which
   also added the kref_get_unless_zero function
v4:
 - fix function names in commit messages
 - fix double whitespace in batadv_tt_orig_list_entry_release kerneldoc
 - add extra patch for batadv_claim_free_ref kerneldoc fix
 - change the phrase "free it" in all *_free_ref/*_put functions to "release it"
v3:
 - update copyright year
v2:
 - split patchset into fixes and kref migration to make it easier when the
   decision is made where each patch will be applied

 net/batman-adv/bridge_loop_avoidance.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index b7167cf..ce2d070 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -159,12 +159,11 @@ static void batadv_backbone_gw_release(struct kref *ref)
 }
 
 /**
- * batadv_backbone_gw_free_ref - decrement the backbone gw refcounter and
- *  possibly release it
+ * batadv_backbone_gw_put - decrement the backbone gw refcounter and possibly
+ *  release it
  * @backbone_gw: backbone gateway to be free'd
  */
-static void
-batadv_backbone_gw_free_ref(struct batadv_bla_backbone_gw *backbone_gw)
+static void batadv_backbone_gw_put(struct batadv_bla_backbone_gw *backbone_gw)
 {
 	kref_put(&backbone_gw->refcount, batadv_backbone_gw_release);
 }
@@ -180,7 +179,7 @@ static void batadv_claim_release(struct kref *ref)
 
 	claim = container_of(ref, struct batadv_bla_claim, refcount);
 
-	batadv_backbone_gw_free_ref(claim->backbone_gw);
+	batadv_backbone_gw_put(claim->backbone_gw);
 	kfree_rcu(claim, rcu);
 }
 
@@ -524,7 +523,7 @@ batadv_bla_update_own_backbone_gw(struct batadv_priv *bat_priv,
 		return;
 
 	backbone_gw->lasttime = jiffies;
-	batadv_backbone_gw_free_ref(backbone_gw);
+	batadv_backbone_gw_put(backbone_gw);
 }
 
 /**
@@ -573,7 +572,7 @@ static void batadv_bla_answer_request(struct batadv_priv *bat_priv,
 
 	/* finally, send an announcement frame */
 	batadv_bla_send_announce(bat_priv, backbone_gw);
-	batadv_backbone_gw_free_ref(backbone_gw);
+	batadv_backbone_gw_put(backbone_gw);
 }
 
 /**
@@ -682,7 +681,7 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 		spin_lock_bh(&claim->backbone_gw->crc_lock);
 		claim->backbone_gw->crc ^= crc16(0, claim->addr, ETH_ALEN);
 		spin_unlock_bh(&claim->backbone_gw->crc_lock);
-		batadv_backbone_gw_free_ref(claim->backbone_gw);
+		batadv_backbone_gw_put(claim->backbone_gw);
 	}
 	/* set (new) backbone gw */
 	kref_get(&backbone_gw->refcount);
@@ -783,7 +782,7 @@ static int batadv_handle_announce(struct batadv_priv *bat_priv, u8 *an_addr,
 		}
 	}
 
-	batadv_backbone_gw_free_ref(backbone_gw);
+	batadv_backbone_gw_put(backbone_gw);
 	return 1;
 }
 
@@ -854,7 +853,7 @@ static int batadv_handle_unclaim(struct batadv_priv *bat_priv,
 		   claim_addr, BATADV_PRINT_VID(vid), backbone_gw->orig);
 
 	batadv_bla_del_claim(bat_priv, claim_addr, vid);
-	batadv_backbone_gw_free_ref(backbone_gw);
+	batadv_backbone_gw_put(backbone_gw);
 	return 1;
 }
 
@@ -891,7 +890,7 @@ static int batadv_handle_claim(struct batadv_priv *bat_priv,
 
 	/* TODO: we could call something like tt_local_del() here. */
 
-	batadv_backbone_gw_free_ref(backbone_gw);
+	batadv_backbone_gw_put(backbone_gw);
 	return 1;
 }
 
@@ -1154,7 +1153,7 @@ purge_now:
 			batadv_bla_del_backbone_claims(backbone_gw);
 
 			hlist_del_rcu(&backbone_gw->hash_entry);
-			batadv_backbone_gw_free_ref(backbone_gw);
+			batadv_backbone_gw_put(backbone_gw);
 		}
 		spin_unlock_bh(list_lock);
 	}
@@ -1571,7 +1570,7 @@ int batadv_bla_is_backbone_gw(struct sk_buff *skb,
 	if (!backbone_gw)
 		return 0;
 
-	batadv_backbone_gw_free_ref(backbone_gw);
+	batadv_backbone_gw_put(backbone_gw);
 	return 1;
 }
 
-- 
2.7.0.rc3


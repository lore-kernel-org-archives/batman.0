Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 17 Jan 2016 11:01:17 +0100
Message-Id: <1453024887-7215-9-git-send-email-sven@narfation.org>
In-Reply-To: <1453024887-7215-1-git-send-email-sven@narfation.org>
References: <1453024887-7215-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v7 09/19] batman-adv: Rename batadv_dat_entry
	*_free_ref function to *_put
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

 net/batman-adv/distributed-arp-table.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 919f344..4c9b69d 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -77,11 +77,11 @@ static void batadv_dat_entry_release(struct kref *ref)
 }
 
 /**
- * batadv_dat_entry_free_ref - decrement the dat_entry refcounter and possibly
+ * batadv_dat_entry_put - decrement the dat_entry refcounter and possibly
  *  release it
  * @dat_entry: dat_entry to be free'd
  */
-static void batadv_dat_entry_free_ref(struct batadv_dat_entry *dat_entry)
+static void batadv_dat_entry_put(struct batadv_dat_entry *dat_entry)
 {
 	kref_put(&dat_entry->refcount, batadv_dat_entry_release);
 }
@@ -135,7 +135,7 @@ static void __batadv_dat_purge(struct batadv_priv *bat_priv,
 				continue;
 
 			hlist_del_rcu(&dat_entry->hash_entry);
-			batadv_dat_entry_free_ref(dat_entry);
+			batadv_dat_entry_put(dat_entry);
 		}
 		spin_unlock_bh(list_lock);
 	}
@@ -349,7 +349,7 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 
 	if (unlikely(hash_added != 0)) {
 		/* remove the reference for the hash */
-		batadv_dat_entry_free_ref(dat_entry);
+		batadv_dat_entry_put(dat_entry);
 		goto out;
 	}
 
@@ -358,7 +358,7 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 
 out:
 	if (dat_entry)
-		batadv_dat_entry_free_ref(dat_entry);
+		batadv_dat_entry_put(dat_entry);
 }
 
 #ifdef CONFIG_BATMAN_ADV_DEBUG
@@ -1029,7 +1029,7 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 	}
 out:
 	if (dat_entry)
-		batadv_dat_entry_free_ref(dat_entry);
+		batadv_dat_entry_put(dat_entry);
 	return ret;
 }
 
@@ -1109,7 +1109,7 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 	}
 out:
 	if (dat_entry)
-		batadv_dat_entry_free_ref(dat_entry);
+		batadv_dat_entry_put(dat_entry);
 	if (ret)
 		kfree_skb(skb);
 	return ret;
@@ -1262,6 +1262,6 @@ bool batadv_dat_drop_broadcast_packet(struct batadv_priv *bat_priv,
 
 out:
 	if (dat_entry)
-		batadv_dat_entry_free_ref(dat_entry);
+		batadv_dat_entry_put(dat_entry);
 	return ret;
 }
-- 
2.7.0.rc3


Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 16 Jan 2016 10:29:51 +0100
Message-Id: <1452936598-28619-13-git-send-email-sven@narfation.org>
In-Reply-To: <1452936598-28619-1-git-send-email-sven@narfation.org>
References: <1452936598-28619-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v6 13/20] batman-adv: Convert
	batadv_neigh_ifinfo to kref
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

batman-adv uses a self-written reference implementation which is just based
on atomic_t. This is less obvious when reading the code than kref and
therefore increases the change that the reference counting will be missed.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v6:
 - removed patches which are now applied in the branch next
 - rebased remaining patches on the patch
   "batman-adv: Avoid recursive call_rcu for batadv_nc_node" which was
   modified by Marek while he applied the patches (this unfortunately made
   some of the remaining patches "hard" to apply)
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

 net/batman-adv/originator.c | 17 ++++++++++-------
 net/batman-adv/types.h      |  2 +-
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 7710595..1c50abe 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -172,11 +172,14 @@ err:
 /**
  * batadv_neigh_ifinfo_release - release neigh_ifinfo from lists and queue for
  *  free after rcu grace period
- * @neigh_ifinfo: the neigh_ifinfo object to release
+ * @ref: kref pointer of the neigh_ifinfo
  */
-static void
-batadv_neigh_ifinfo_release(struct batadv_neigh_ifinfo *neigh_ifinfo)
+static void batadv_neigh_ifinfo_release(struct kref *ref)
 {
+	struct batadv_neigh_ifinfo *neigh_ifinfo;
+
+	neigh_ifinfo = container_of(ref, struct batadv_neigh_ifinfo, refcount);
+
 	if (neigh_ifinfo->if_outgoing != BATADV_IF_DEFAULT)
 		batadv_hardif_free_ref(neigh_ifinfo->if_outgoing);
 
@@ -190,8 +193,7 @@ batadv_neigh_ifinfo_release(struct batadv_neigh_ifinfo *neigh_ifinfo)
  */
 void batadv_neigh_ifinfo_free_ref(struct batadv_neigh_ifinfo *neigh_ifinfo)
 {
-	if (atomic_dec_and_test(&neigh_ifinfo->refcount))
-		batadv_neigh_ifinfo_release(neigh_ifinfo);
+	kref_put(&neigh_ifinfo->refcount, batadv_neigh_ifinfo_release);
 }
 
 /**
@@ -405,7 +407,7 @@ batadv_neigh_ifinfo_get(struct batadv_neigh_node *neigh,
 		if (tmp_neigh_ifinfo->if_outgoing != if_outgoing)
 			continue;
 
-		if (!atomic_inc_not_zero(&tmp_neigh_ifinfo->refcount))
+		if (!kref_get_unless_zero(&tmp_neigh_ifinfo->refcount))
 			continue;
 
 		neigh_ifinfo = tmp_neigh_ifinfo;
@@ -450,7 +452,8 @@ batadv_neigh_ifinfo_new(struct batadv_neigh_node *neigh,
 	}
 
 	INIT_HLIST_NODE(&neigh_ifinfo->list);
-	atomic_set(&neigh_ifinfo->refcount, 2);
+	kref_init(&neigh_ifinfo->refcount);
+	kref_get(&neigh_ifinfo->refcount);
 	neigh_ifinfo->if_outgoing = if_outgoing;
 
 	hlist_add_head_rcu(&neigh_ifinfo->list, &neigh->ifinfo_list);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 17f97ff..81d9f8d 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -420,7 +420,7 @@ struct batadv_neigh_ifinfo {
 	struct batadv_hard_iface *if_outgoing;
 	struct batadv_neigh_ifinfo_bat_iv bat_iv;
 	u8 last_ttl;
-	atomic_t refcount;
+	struct kref refcount;
 	struct rcu_head rcu;
 };
 
-- 
2.7.0.rc3


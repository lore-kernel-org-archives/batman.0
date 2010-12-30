Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Thu, 30 Dec 2010 03:09:17 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20101230020917.GA4707@pandem0nium>
References: <201012130118.14949.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <201012130118.14949.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: protect bonding with rcu locks
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

bonding / alternating candidates need to be secured by rcu locks
as well. This patch therefore converts the bonding list
=66rom a plain pointer list to a rcu securable lists and references
the bonding candidates.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 originator.c |   17 +++++++-
 routing.c    |  140 +++++++++++++++++++++++++++++++++---------------------=
----
 types.h      |    4 +-
 unicast.c    |    9 +---
 4 files changed, 100 insertions(+), 70 deletions(-)

diff --git a/batman-adv/originator.c b/batman-adv/originator.c
index 899ab0b..3e18488 100644
--- a/batman-adv/originator.c
+++ b/batman-adv/originator.c
@@ -88,6 +88,7 @@ struct neigh_node *create_neighbor(struct orig_node *orig=
_node,
 		return NULL;
=20
 	INIT_HLIST_NODE(&neigh_node->list);
+	INIT_LIST_HEAD(&neigh_node->bonding_list);
=20
 	memcpy(neigh_node->addr, neigh, ETH_ALEN);
 	neigh_node->orig_node =3D orig_neigh_node;
@@ -103,13 +104,20 @@ struct neigh_node *create_neighbor(struct orig_node *=
orig_node,
 void orig_node_free_ref(struct kref *refcount)
 {
 	struct hlist_node *node, *node_tmp;
-	struct neigh_node *neigh_node;
+	struct neigh_node *neigh_node, *tmp_neigh_node;
 	struct orig_node *orig_node;
=20
 	orig_node =3D container_of(refcount, struct orig_node, refcount);
=20
 	spin_lock_bh(&orig_node->neigh_list_lock);
=20
+	/* for all bonding members ... */
+	list_for_each_entry_safe(neigh_node, tmp_neigh_node,
+				 &orig_node->bond.selected, bonding_list) {
+		list_del_rcu(&neigh_node->bonding_list);
+		call_rcu(&neigh_node->rcu, neigh_node_free_rcu);
+	}
+
 	/* for all neighbors towards this originator ... */
 	hlist_for_each_entry_safe(neigh_node, node, node_tmp,
 				  &orig_node->neigh_list, list) {
@@ -202,6 +210,7 @@ struct orig_node *get_orig_node(struct bat_priv *bat_pr=
iv, uint8_t *addr)
 		return NULL;
=20
 	INIT_HLIST_HEAD(&orig_node->neigh_list);
+	INIT_LIST_HEAD(&orig_node->bond.selected);
 	spin_lock_init(&orig_node->ogm_cnt_lock);
 	spin_lock_init(&orig_node->neigh_list_lock);
 	kref_init(&orig_node->refcount);
@@ -285,6 +294,12 @@ static bool purge_orig_neighbors(struct bat_priv *bat_=
priv,
 			neigh_purged =3D true;
=20
 			hlist_del_rcu(&neigh_node->list);
+
+			if (!list_empty(&neigh_node->bonding_list)) {
+				orig_node->bond.candidates--;
+				list_del_rcu(&neigh_node->bonding_list);
+				call_rcu(&neigh_node->rcu, neigh_node_free_rcu);
+			}
 			call_rcu(&neigh_node->rcu, neigh_node_free_rcu);
 		} else {
 			if ((!*best_neigh_node) ||
diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index 557e7d7..ad8d237 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -517,7 +517,6 @@ void update_bonding_candidates(struct bat_priv *bat_pri=
v,
 	int best_tq;
 	struct hlist_node *node, *node2;
 	struct neigh_node *tmp_neigh_node, *tmp_neigh_node2;
-	struct neigh_node *first_candidate, *last_candidate;
=20
 	/* update the candidates for this originator */
 	if (!orig_node->router) {
@@ -525,6 +524,7 @@ void update_bonding_candidates(struct bat_priv *bat_pri=
v,
 		return;
 	}
=20
+	spin_lock_bh(&orig_node->neigh_list_lock);
 	best_tq =3D orig_node->router->tq_avg;
=20
 	/* update bond.candidates */
@@ -535,19 +535,14 @@ void update_bonding_candidates(struct bat_priv *bat_p=
riv,
 	 * as "bonding partner" */
=20
 	/* first, zero the list */
-	rcu_read_lock();
-	hlist_for_each_entry_rcu(tmp_neigh_node, node,
-				 &orig_node->neigh_list, list) {
-		tmp_neigh_node->next_bond_candidate =3D NULL;
+	list_for_each_entry_safe(tmp_neigh_node, tmp_neigh_node2,
+				 &orig_node->bond.selected, bonding_list) {
+		list_del_rcu(&tmp_neigh_node->bonding_list);
+		kref_put(&tmp_neigh_node->refcount, neigh_node_free_ref);
 	}
-	rcu_read_unlock();
=20
-	first_candidate =3D NULL;
-	last_candidate =3D NULL;
-
-	rcu_read_lock();
 	hlist_for_each_entry_rcu(tmp_neigh_node, node,
-				 &orig_node->neigh_list, list) {
+		&orig_node->neigh_list, list) {
=20
 		/* only consider if it has the same primary address ...  */
 		if (memcmp(orig_node->orig,
@@ -572,7 +567,7 @@ void update_bonding_candidates(struct bat_priv *bat_pri=
v,
=20
 			/* we only care if the other candidate is even
 			 * considered as candidate. */
-			if (!tmp_neigh_node2->next_bond_candidate)
+			if (!list_empty(&tmp_neigh_node2->bonding_list))
 				continue;
=20
=20
@@ -589,24 +584,16 @@ void update_bonding_candidates(struct bat_priv *bat_p=
riv,
 		if (interference_candidate)
 			continue;
=20
-		if (!first_candidate) {
-			first_candidate =3D tmp_neigh_node;
-			tmp_neigh_node->next_bond_candidate =3D first_candidate;
-		} else
-			tmp_neigh_node->next_bond_candidate =3D last_candidate;
-
-		last_candidate =3D tmp_neigh_node;
+		list_add_rcu(&tmp_neigh_node->bonding_list,
+				&orig_node->bond.selected);
+		kref_get(&tmp_neigh_node->refcount);
=20
 		candidates++;
 	}
-	rcu_read_unlock();
-
-	if (candidates > 0) {
-		first_candidate->next_bond_candidate =3D last_candidate;
-		orig_node->bond.selected =3D first_candidate;
-	}
-
 	orig_node->bond.candidates =3D candidates;
+
+	spin_unlock_bh(&orig_node->neigh_list_lock);
+
 }
=20
 void receive_bat_packet(struct ethhdr *ethhdr,
@@ -1110,16 +1097,18 @@ out:
 }
=20
 /* find a suitable router for this originator, and use
- * bonding if possible. */
+ * bonding if possible. increases the found neighbors
+ * refcount.*/
 struct neigh_node *find_router(struct bat_priv *bat_priv,
 			       struct orig_node *orig_node,
 			       struct batman_if *recv_if)
 {
 	struct orig_node *primary_orig_node;
 	struct orig_node *router_orig;
-	struct neigh_node *router, *first_candidate, *best_router;
+	struct neigh_node *router, *first_candidate, *tmp_neigh_node;
 	static uint8_t zero_mac[ETH_ALEN] =3D {0, 0, 0, 0, 0, 0};
 	int bonding_enabled;
+	int best_router_tq;
=20
 	if (!orig_node)
 		return NULL;
@@ -1132,15 +1121,23 @@ struct neigh_node *find_router(struct bat_priv *bat=
_priv,
=20
 	bonding_enabled =3D atomic_read(&bat_priv->bonding);
=20
-	if ((!recv_if) && (!bonding_enabled))
-		return orig_node->router;
-
+	rcu_read_lock();
+	/* select default router to output */
+	router =3D orig_node->router;
 	router_orig =3D orig_node->router->orig_node;
+	if (!router_orig) {
+		rcu_read_unlock();
+		return NULL;
+	}
+
+
+	if ((!recv_if) && (!bonding_enabled))
+		goto return_router;
=20
 	/* if we have something in the primary_addr, we can search
 	 * for a potential bonding candidate. */
 	if (memcmp(router_orig->primary_addr, zero_mac, ETH_ALEN) =3D=3D 0)
-		return orig_node->router;
+		goto return_router;
=20
 	/* find the orig_node which has the primary interface. might
 	 * even be the same as our router_orig in many cases */
@@ -1149,60 +1146,83 @@ struct neigh_node *find_router(struct bat_priv *bat=
_priv,
 				router_orig->orig, ETH_ALEN) =3D=3D 0) {
 		primary_orig_node =3D router_orig;
 	} else {
-		rcu_read_lock();
 		primary_orig_node =3D hash_find(bat_priv->orig_hash, compare_orig,
 					       choose_orig,
 					       router_orig->primary_addr);
-		rcu_read_unlock();
-
 		if (!primary_orig_node)
-			return orig_node->router;
+			goto return_router;
 	}
-
 	/* with less than 2 candidates, we can't do any
 	 * bonding and prefer the original router. */
=20
 	if (primary_orig_node->bond.candidates < 2)
-		return orig_node->router;
+		goto return_router;
=20
=20
 	/* all nodes between should choose a candidate which
 	 * is is not on the interface where the packet came
 	 * in. */
-	first_candidate =3D primary_orig_node->bond.selected;
-	router =3D first_candidate;
+
+	first_candidate =3D NULL;
+	router =3D NULL;
=20
 	if (bonding_enabled) {
 		/* in the bonding case, send the packets in a round
 		 * robin fashion over the remaining interfaces. */
-		do {
+
+		list_for_each_entry_rcu(tmp_neigh_node,
+			&primary_orig_node->bond.selected, bonding_list) {
+			if (!first_candidate)
+				first_candidate =3D tmp_neigh_node;
 			/* recv_if =3D=3D NULL on the first node. */
-			if (router->if_incoming !=3D recv_if)
+			if (tmp_neigh_node->if_incoming !=3D recv_if) {
+				router =3D tmp_neigh_node;
 				break;
+			}
+		}
=20
-			router =3D router->next_bond_candidate;
-		} while (router !=3D first_candidate);
+		/* use the first candidate if nothing was found. */
+		if (!router)
+			router =3D first_candidate;
=20
-		primary_orig_node->bond.selected =3D router->next_bond_candidate;
+		/* selected should point to the next element
+		 * after the current router */
+		spin_lock_bh(&primary_orig_node->neigh_list_lock);
+		/* this is a list_move(), which unfortunately
+		 * does not exist as rcu version */
+		list_del_rcu(&primary_orig_node->bond.selected);
+		list_add_rcu(&primary_orig_node->bond.selected,
+				&router->bonding_list);
+		spin_unlock_bh(&primary_orig_node->neigh_list_lock);
=20
 	} else {
 		/* if bonding is disabled, use the best of the
 		 * remaining candidates which are not using
 		 * this interface. */
-		best_router =3D first_candidate;
+		best_router_tq =3D 0;
+		list_for_each_entry_rcu(tmp_neigh_node,
+			&primary_orig_node->bond.selected, bonding_list) {
+			if (!first_candidate)
+				first_candidate =3D tmp_neigh_node;
=20
-		do {
 			/* recv_if =3D=3D NULL on the first node. */
-			if ((router->if_incoming !=3D recv_if) &&
-				(router->tq_avg > best_router->tq_avg))
-					best_router =3D router;
+			if (tmp_neigh_node->if_incoming !=3D recv_if)
+				/* if we don't have a router yet
+				 * or this one is better, choose it. */
+				if ((!router) ||
+				(tmp_neigh_node->tq_avg > router->tq_avg)) {
+					router =3D tmp_neigh_node;
+					best_router_tq =3D 0;
+				}
+		}
=20
-			router =3D router->next_bond_candidate;
-		} while (router !=3D first_candidate);
-
-		router =3D best_router;
+		/* use the first candidate if nothing was found. */
+		if (!router)
+			router =3D first_candidate;
 	}
-
+return_router:
+	kref_get(&router->refcount);
+	rcu_read_unlock();
 	return router;
 }
=20
@@ -1210,7 +1230,7 @@ static int check_unicast_packet(struct sk_buff *skb, =
int hdr_size)
 {
 	struct ethhdr *ethhdr;
=20
-	/* drop packet if it has not necessary minimum size */
+/* drop packet if it has not necessary minimum size */
 	if (unlikely(!pskb_may_pull(skb, hdr_size)))
 		return -1;
=20
@@ -1262,13 +1282,13 @@ int route_unicast_packet(struct sk_buff *skb, struc=
t batman_if *recv_if,
 		goto unlock;
=20
 	kref_get(&orig_node->refcount);
+	rcu_read_unlock();
+
+	/* find_router() increases neigh_nodes refcount if found. */
 	neigh_node =3D find_router(bat_priv, orig_node, recv_if);
=20
 	if (!neigh_node)
-		goto unlock;
-
-	kref_get(&neigh_node->refcount);
-	rcu_read_unlock();
+		goto out;
=20
 	/* create a copy of the skb, if needed, to modify it. */
 	if (skb_cow(skb, sizeof(struct ethhdr)) < 0)
diff --git a/batman-adv/types.h b/batman-adv/types.h
index 52b6b08..8264050 100644
--- a/batman-adv/types.h
+++ b/batman-adv/types.h
@@ -92,7 +92,7 @@ struct orig_node {
 	spinlock_t ogm_cnt_lock; /* protects ogm counter */
 	struct {
 		uint8_t candidates;
-		struct neigh_node *selected;
+		struct list_head selected;
 	} bond;
 };
=20
@@ -116,7 +116,7 @@ struct neigh_node {
 	uint8_t tq_index;
 	uint8_t tq_avg;
 	uint8_t last_ttl;
-	struct neigh_node *next_bond_candidate;
+	struct list_head bonding_list;
 	unsigned long last_valid;
 	unsigned long real_bits[NUM_WORDS];
 	struct kref refcount;
diff --git a/batman-adv/unicast.c b/batman-adv/unicast.c
index 67bed2d..cfe08dd 100644
--- a/batman-adv/unicast.c
+++ b/batman-adv/unicast.c
@@ -314,14 +314,11 @@ trans_search:
 	orig_node =3D transtable_search(bat_priv, ethhdr->h_dest);
=20
 find_router:
-	rcu_read_lock();
+	/* find_router() increases neigh_nodes refcount if found. */
 	neigh_node =3D find_router(bat_priv, orig_node, NULL);
=20
 	if (!neigh_node)
-		goto unlock;
-
-	kref_get(&neigh_node->refcount);
-	rcu_read_unlock();
+		goto out;
=20
 	if (neigh_node->if_incoming->if_status !=3D IF_ACTIVE)
 		goto out;
@@ -353,8 +350,6 @@ find_router:
 	ret =3D 0;
 	goto out;
=20
-unlock:
-	rcu_read_unlock();
 out:
 	if (neigh_node)
 		kref_put(&neigh_node->refcount, neigh_node_free_ref);
--=20
1.7.2.3

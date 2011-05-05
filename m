Return-Path: <daniele.furlan@gmail.com>
MIME-Version: 1.0
Date: Thu, 5 May 2011 13:49:15 +0200
Message-ID: <BANLkTikFQsW0d8gYXLkTKcUkKMcD4juC9g@mail.gmail.com>
From: Daniele Furlan <daniele.furlan@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] [PATCH v2] batman-adv: remove duplicate code from
 function is_bidirectional_neigh()
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

Is there an error in the previous version.
I'm sorry, this version instead works for me.

Signed-off-by: Daniele Furlan <daniele.furlan@gmail.com>
---
 routing.c |   75 ++++++++++++++++++++----------------------------------------
 1 files changed, 25 insertions(+), 50 deletions(-)

diff --git a/routing.c b/routing.c
index 49f5715..c5dec8c 100644
--- a/routing.c
+++ b/routing.c
@@ -169,65 +169,40 @@ static int is_bidirectional_neigh(struct
orig_node *orig_node,
       uint8_t orig_eq_count, neigh_rq_count, tq_own;
       int tq_asym_penalty, ret = 0;

-       if (orig_node == orig_neigh_node) {
-               rcu_read_lock();
-               hlist_for_each_entry_rcu(tmp_neigh_node, node,
-                                        &orig_node->neigh_list, list) {
+       /* find corresponding one hop neighbor */
+       rcu_read_lock();
+       hlist_for_each_entry_rcu(tmp_neigh_node, node,
+                                &orig_neigh_node->neigh_list, list) {

-                       if (!compare_eth(tmp_neigh_node->addr,
-                                        orig_neigh_node->orig))
-                               continue;
+               if (!compare_eth(tmp_neigh_node->addr,
+                                orig_neigh_node->orig))
+                       continue;

-                       if (tmp_neigh_node->if_incoming != if_incoming)
-                               continue;
+               if (tmp_neigh_node->if_incoming != if_incoming)
+                       continue;

-                       if (!atomic_inc_not_zero(&tmp_neigh_node->refcount))
-                               continue;
+               if (!atomic_inc_not_zero(&tmp_neigh_node->refcount))
+                       continue;

-                       neigh_node = tmp_neigh_node;
-               }
-               rcu_read_unlock();
+               neigh_node = tmp_neigh_node;
+       }
+       rcu_read_unlock();

-               if (!neigh_node)
-                       neigh_node = create_neighbor(orig_node,
-                                                    orig_neigh_node,
-                                                    orig_neigh_node->orig,
-                                                    if_incoming);
-               if (!neigh_node)
-                       goto out;
+       if (!neigh_node)
+               neigh_node = create_neighbor(orig_neigh_node,
+                                            orig_neigh_node,
+                                            orig_neigh_node->orig,
+                                            if_incoming);
+       if (!neigh_node)
+               goto out;

+       /* if orig_node is direct neighbour update neigh_node last_valid */
+       if (orig_node == orig_neigh_node)
               neigh_node->last_valid = jiffies;
-       } else {
-               /* find packet count of corresponding one hop neighbor */
-               rcu_read_lock();
-               hlist_for_each_entry_rcu(tmp_neigh_node, node,
-                                        &orig_neigh_node->neigh_list, list) {
-
-                       if (!compare_eth(tmp_neigh_node->addr,
-                                        orig_neigh_node->orig))
-                               continue;
-
-                       if (tmp_neigh_node->if_incoming != if_incoming)
-                               continue;
-
-                       if (!atomic_inc_not_zero(&tmp_neigh_node->refcount))
-                               continue;
-
-                       neigh_node = tmp_neigh_node;
-               }
-               rcu_read_unlock();
-
-               if (!neigh_node)
-                       neigh_node = create_neighbor(orig_neigh_node,
-                                                    orig_neigh_node,
-                                                    orig_neigh_node->orig,
-                                                    if_incoming);
-               if (!neigh_node)
-                       goto out;
-       }

       orig_node->last_valid = jiffies;

+       /* find packet count of corresponding one hop neighbor */
       spin_lock_bh(&orig_node->ogm_cnt_lock);
       orig_eq_count = orig_neigh_node->bcast_own_sum[if_incoming->if_num];
       neigh_rq_count = neigh_node->real_packet_count;
--
1.7.1

Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 20 Dec 2011 19:33:14 +0800
Message-Id: <1324380794-2971-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: convert time_after instances to
	has_timed_out
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <lindner_marek@yahoo.de>

To increase readability the has_timed_out() functions has been introduced.
This patch converts existing time_after() calls to use this wrapper
function (if applicable).

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 originator.c     |   11 ++++-------
 routing.c        |    3 +--
 soft-interface.c |    4 ++--
 vis.c            |    3 +--
 4 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/originator.c b/originator.c
index 847ff7e..1161f27 100644
--- a/originator.c
+++ b/originator.c
@@ -282,8 +282,7 @@ static bool purge_orig_neighbors(struct bat_priv *bat_priv,
 	hlist_for_each_entry_safe(neigh_node, node, node_tmp,
 				  &orig_node->neigh_list, list) {
 
-		if ((time_after(jiffies,
-			neigh_node->last_valid + PURGE_TIMEOUT * HZ)) ||
+		if ((has_timed_out(neigh_node->last_valid, PURGE_TIMEOUT)) ||
 		    (neigh_node->if_incoming->if_status == IF_INACTIVE) ||
 		    (neigh_node->if_incoming->if_status == IF_NOT_IN_USE) ||
 		    (neigh_node->if_incoming->if_status == IF_TO_BE_REMOVED)) {
@@ -327,9 +326,7 @@ static bool purge_orig_node(struct bat_priv *bat_priv,
 {
 	struct neigh_node *best_neigh_node;
 
-	if (time_after(jiffies,
-		orig_node->last_valid + 2 * PURGE_TIMEOUT * HZ)) {
-
+	if (has_timed_out(orig_node->last_valid, 2 * PURGE_TIMEOUT)) {
 		bat_dbg(DBG_BATMAN, bat_priv,
 			"Originator timeout: originator %pM, last_valid %lu\n",
 			orig_node->orig, (orig_node->last_valid / HZ));
@@ -372,8 +369,8 @@ static void _purge_orig(struct bat_priv *bat_priv)
 				continue;
 			}
 
-			if (time_after(jiffies, orig_node->last_frag_packet +
-						msecs_to_jiffies(FRAG_TIMEOUT)))
+			if (has_timed_out(orig_node->last_frag_packet,
+					  FRAG_TIMEOUT))
 				frag_list_free(&orig_node->frag_list);
 		}
 		spin_unlock_bh(list_lock);
diff --git a/routing.c b/routing.c
index 5bc41c8..87b95a2 100644
--- a/routing.c
+++ b/routing.c
@@ -232,8 +232,7 @@ int window_protected(struct bat_priv *bat_priv, int32_t seq_num_diff,
 {
 	if ((seq_num_diff <= -TQ_LOCAL_WINDOW_SIZE)
 		|| (seq_num_diff >= EXPECTED_SEQNO_RANGE)) {
-		if (time_after(jiffies, *last_reset +
-			msecs_to_jiffies(RESET_PROTECTION_MS))) {
+		if (has_timed_out(*last_reset, RESET_PROTECTION_MS)) {
 
 			*last_reset = jiffies;
 			bat_dbg(DBG_BATMAN, bat_priv,
diff --git a/soft-interface.c b/soft-interface.c
index bd8c7cf..51788db 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -396,8 +396,8 @@ void softif_neigh_purge(struct bat_priv *bat_priv)
 		hlist_for_each_entry_safe(softif_neigh, node_tmp, node_tmp2,
 					  &softif_neigh_vid->softif_neigh_list,
 					  list) {
-			if ((!time_after(jiffies, softif_neigh->last_seen +
-				msecs_to_jiffies(SOFTIF_NEIGH_TIMEOUT))) &&
+			if ((!has_timed_out(softif_neigh->last_seen,
+					   SOFTIF_NEIGH_TIMEOUT)) &&
 			    (atomic_read(&bat_priv->mesh_state) == MESH_ACTIVE))
 				continue;
 
diff --git a/vis.c b/vis.c
index ac7e661..4f4b2a0 100644
--- a/vis.c
+++ b/vis.c
@@ -714,8 +714,7 @@ static void purge_vis_packets(struct bat_priv *bat_priv)
 			if (info == bat_priv->my_vis_info)
 				continue;
 
-			if (time_after(jiffies,
-				       info->first_seen + VIS_TIMEOUT * HZ)) {
+			if (has_timed_out(info->first_seen, VIS_TIMEOUT)) {
 				hlist_del(node);
 				send_list_del(info);
 				kref_put(&info->refcount, free_info);
-- 
1.7.5.4


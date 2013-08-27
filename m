Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 27 Aug 2013 22:57:47 +0200
Message-Id: <1377637071-2498-6-git-send-email-ordex@autistici.org>
In-Reply-To: <1377637071-2498-1-git-send-email-ordex@autistici.org>
References: <1377637071-2498-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv4 5/9] batman-adv: add
	bat_neigh_is_equiv_or_better API function
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

Each routing protocol has its own metric semantic and
therefore is the protocol itself the only component able to
compare two metrics to check their "similarity".

This new API allows each routing protocol to implement its
own logic and make the external code protocol agnostic.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 bat_iv_ogm.c | 18 ++++++++++++++++++
 main.c       |  3 ++-
 main.h       |  6 ++++++
 types.h      |  4 ++++
 4 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 4559977..a2091af 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -1485,6 +1485,23 @@ static int batadv_iv_ogm_neigh_cmp(struct batadv_neigh_node *neigh1,
 	return tq1 - tq2;
 }
 
+/**
+ * batadv_iv_ogm_neigh_is_eob - check if neigh2 is equally good or better than
+ *  neigh2 from the metric prospective
+ * @neigh1: the first neighbor object of the comparison
+ * @neigh2: the second neighbor object of the comparison
+ *
+ * Returns true if the metric via neigh2 is equally good or better than the
+ * metric via neigh1, false otherwise.
+ */
+static bool batadv_iv_ogm_neigh_is_eob(struct batadv_neigh_node *neigh1,
+				       struct batadv_neigh_node *neigh2)
+{
+	int diff = batadv_iv_ogm_neigh_cmp(neigh1, neigh2);
+
+	return (diff < BATADV_TQ_SIMILARITY_THRESHOLD);
+}
+
 static struct batadv_algo_ops batadv_batman_iv __read_mostly = {
 	.name = "BATMAN_IV",
 	.bat_iface_enable = batadv_iv_ogm_iface_enable,
@@ -1494,6 +1511,7 @@ static struct batadv_algo_ops batadv_batman_iv __read_mostly = {
 	.bat_ogm_schedule = batadv_iv_ogm_schedule,
 	.bat_ogm_emit = batadv_iv_ogm_emit,
 	.bat_neigh_cmp = batadv_iv_ogm_neigh_cmp,
+	.bat_neigh_is_equiv_or_better = batadv_iv_ogm_neigh_is_eob,
 	.bat_orig_print = batadv_iv_ogm_orig_print,
 };
 
diff --git a/main.c b/main.c
index 6e21b7d..5c5e64b 100644
--- a/main.c
+++ b/main.c
@@ -503,7 +503,8 @@ int batadv_algo_register(struct batadv_algo_ops *bat_algo_ops)
 	    !bat_algo_ops->bat_primary_iface_set ||
 	    !bat_algo_ops->bat_ogm_schedule ||
 	    !bat_algo_ops->bat_ogm_emit ||
-	    !bat_algo_ops->bat_neigh_cmp) {
+	    !bat_algo_ops->bat_neigh_cmp ||
+	    !bat_algo_ops->bat_neigh_is_equiv_or_better) {
 		pr_info("Routing algo '%s' does not implement required ops\n",
 			bat_algo_ops->name);
 		ret = -EINVAL;
diff --git a/main.h b/main.h
index e860f1e..ebdfad8 100644
--- a/main.h
+++ b/main.h
@@ -86,6 +86,12 @@
 /* numbers of originator to contact for any PUT/GET DHT operation */
 #define BATADV_DAT_CANDIDATES_NUM 3
 
+/**
+ * BATADV_TQ_SIMILARITY_THRESHOLD - TQ points that a secondary metric can differ
+ *  at most from the primary one in order to be still considered acceptable
+ */
+#define BATADV_TQ_SIMILARITY_THRESHOLD 50
+
 /* how much worse secondary interfaces may be to be considered as bonding
  * candidates
  */
diff --git a/types.h b/types.h
index 1e9e46f..0896a1b 100644
--- a/types.h
+++ b/types.h
@@ -992,6 +992,8 @@ struct batadv_forw_packet {
  * @bat_ogm_schedule: prepare a new outgoing OGM for the send queue
  * @bat_ogm_emit: send scheduled OGM
  * @bat_neigh_cmp: compare the metrics of two neighbors
+ * @bat_neigh_is_equiv_or_better: check if neigh1 is equally good or
+ *  better than neigh2 from the metric prospective
  * @bat_orig_print: print the originator table (optional)
  */
 struct batadv_algo_ops {
@@ -1005,6 +1007,8 @@ struct batadv_algo_ops {
 	void (*bat_ogm_emit)(struct batadv_forw_packet *forw_packet);
 	int (*bat_neigh_cmp)(struct batadv_neigh_node *neigh1,
 			     struct batadv_neigh_node *neigh2);
+	bool (*bat_neigh_is_equiv_or_better)(struct batadv_neigh_node *neigh1,
+					     struct batadv_neigh_node *neigh2);
 	/* orig_node handling API */
 	void (*bat_orig_print)(struct batadv_priv *priv, struct seq_file *seq);
 };
-- 
1.8.1.5


Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 31 Aug 2013 20:51:32 +0200
Message-Id: <1377975097-1664-5-git-send-email-ordex@autistici.org>
In-Reply-To: <1377975097-1664-1-git-send-email-ordex@autistici.org>
References: <1377975097-1664-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv6 4/9] batman-adv: add bat_neigh_cmp API
	function
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

This new API allows to compare the two neighbours based on
the metric avoiding the user to deal with any routing
algorithm specific detail

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 bat_iv_ogm.c | 20 ++++++++++++++++++++
 main.c       |  3 ++-
 types.h      |  3 +++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 145c852..0da04a6 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -1470,6 +1470,25 @@ next:
 		seq_puts(seq, "No batman nodes in range ...\n");
 }
 
+/**
+ * batadv_iv_ogm_neigh_cmp - compare the metric of two neighbors
+ * @neigh1: the first neighbor object of the comparison
+ * @neigh2: the second neighbor object of the comparison
+ *
+ * Returns a value less, equal to or greater than 0 if the metric via neigh1 is
+ * lower, the same as or higher than the metric via neigh2
+ */
+static int batadv_iv_ogm_neigh_cmp(struct batadv_neigh_node *neigh1,
+				   struct batadv_neigh_node *neigh2)
+{
+	uint8_t tq1, tq2;
+
+	tq1 = neigh1->bat_iv.tq_avg;
+	tq2 = neigh2->bat_iv.tq_avg;
+
+	return tq1 - tq2;
+}
+
 static struct batadv_algo_ops batadv_batman_iv __read_mostly = {
 	.name = "BATMAN_IV",
 	.bat_iface_enable = batadv_iv_ogm_iface_enable,
@@ -1478,6 +1497,7 @@ static struct batadv_algo_ops batadv_batman_iv __read_mostly = {
 	.bat_primary_iface_set = batadv_iv_ogm_primary_iface_set,
 	.bat_ogm_schedule = batadv_iv_ogm_schedule,
 	.bat_ogm_emit = batadv_iv_ogm_emit,
+	.bat_neigh_cmp = batadv_iv_ogm_neigh_cmp,
 	.bat_orig_print = batadv_iv_ogm_orig_print,
 };
 
diff --git a/main.c b/main.c
index 72b5fce..6e21b7d 100644
--- a/main.c
+++ b/main.c
@@ -502,7 +502,8 @@ int batadv_algo_register(struct batadv_algo_ops *bat_algo_ops)
 	    !bat_algo_ops->bat_iface_update_mac ||
 	    !bat_algo_ops->bat_primary_iface_set ||
 	    !bat_algo_ops->bat_ogm_schedule ||
-	    !bat_algo_ops->bat_ogm_emit) {
+	    !bat_algo_ops->bat_ogm_emit ||
+	    !bat_algo_ops->bat_neigh_cmp) {
 		pr_info("Routing algo '%s' does not implement required ops\n",
 			bat_algo_ops->name);
 		ret = -EINVAL;
diff --git a/types.h b/types.h
index 4c17e80..1e9e46f 100644
--- a/types.h
+++ b/types.h
@@ -991,6 +991,7 @@ struct batadv_forw_packet {
  * @bat_primary_iface_set: called when primary interface is selected / changed
  * @bat_ogm_schedule: prepare a new outgoing OGM for the send queue
  * @bat_ogm_emit: send scheduled OGM
+ * @bat_neigh_cmp: compare the metrics of two neighbors
  * @bat_orig_print: print the originator table (optional)
  */
 struct batadv_algo_ops {
@@ -1002,6 +1003,8 @@ struct batadv_algo_ops {
 	void (*bat_primary_iface_set)(struct batadv_hard_iface *hard_iface);
 	void (*bat_ogm_schedule)(struct batadv_hard_iface *hard_iface);
 	void (*bat_ogm_emit)(struct batadv_forw_packet *forw_packet);
+	int (*bat_neigh_cmp)(struct batadv_neigh_node *neigh1,
+			     struct batadv_neigh_node *neigh2);
 	/* orig_node handling API */
 	void (*bat_orig_print)(struct batadv_priv *priv, struct seq_file *seq);
 };
-- 
1.8.1.5


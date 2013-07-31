Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 31 Jul 2013 22:47:43 +0200
Message-Id: <1375303667-3018-7-git-send-email-ordex@autistici.org>
In-Reply-To: <1375303667-3018-1-git-send-email-ordex@autistici.org>
References: <1375303667-3018-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [RFCv2 06/10] batman-adv: add bat_metric_compare API
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

Add an API function to allow the routing protocol to
implement its own metric sorting logic.

In this way each routing protocol can play with its metric
semantic without exposing any detail to the rest of the
code.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 bat_iv_ogm.c | 14 ++++++++++++++
 main.c       |  3 ++-
 types.h      |  3 +++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 2e03fdb..a05dd3a 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -1470,6 +1470,19 @@ static bool batadv_iv_ogm_metric_is_eob(uint32_t metric, uint32_t new_metric)
 	return (metric - new_metric < BATADV_TQ_SIMILARITY_THRESHOLD);
 }
 
+/**
+ * batadv_iv_ogm_metric_compare - implement the bat_metric_compare API
+ * @metric1: the first metric to compare
+ * @metric2: the second metric to compare
+ *
+ * Return a value smaller, equal or greater than zero if metric1 is respectively
+ * smaller, equal or greater than metric2
+ */
+static int batadv_iv_ogm_metric_compare(uint32_t metric1, uint32_t metric2)
+{
+	return metric1 - metric2;
+}
+
 static struct batadv_algo_ops batadv_batman_iv __read_mostly = {
 	.name = "BATMAN_IV",
 	.bat_iface_enable = batadv_iv_ogm_iface_enable,
@@ -1480,6 +1493,7 @@ static struct batadv_algo_ops batadv_batman_iv __read_mostly = {
 	.bat_ogm_emit = batadv_iv_ogm_emit,
 	.bat_metric_get = batadv_iv_ogm_metric_get,
 	.bat_metric_is_equiv_or_better = batadv_iv_ogm_metric_is_eob,
+	.bat_metric_compare = batadv_iv_ogm_metric_compare,
 	.bat_orig_print = batadv_iv_ogm_orig_print,
 };
 
diff --git a/main.c b/main.c
index d263a42..8bc353b 100644
--- a/main.c
+++ b/main.c
@@ -447,7 +447,8 @@ int batadv_algo_register(struct batadv_algo_ops *bat_algo_ops)
 	    !bat_algo_ops->bat_ogm_schedule ||
 	    !bat_algo_ops->bat_ogm_emit ||
 	    !bat_algo_ops->bat_metric_get ||
-	    !bat_algo_ops->bat_metric_is_equiv_or_better) {
+	    !bat_algo_ops->bat_metric_is_equiv_or_better ||
+	    !bat_algo_ops->bat_metric_compare) {
 		pr_info("Routing algo '%s' does not implement required ops\n",
 			bat_algo_ops->name);
 		ret = -EINVAL;
diff --git a/types.h b/types.h
index 8885dc0..516d30d 100644
--- a/types.h
+++ b/types.h
@@ -993,6 +993,8 @@ struct batadv_forw_packet {
  * @bat_ogm_emit: send scheduled OGM
  * @bat_metric_is_equiv_or_better: check if new_metric is good enough to be
  *  comparable with metric
+ *  with metric
+ * @bat_metric_compare: compare two metric values
  * @bat_orig_print: print the originator table
  */
 struct batadv_algo_ops {
@@ -1007,6 +1009,7 @@ struct batadv_algo_ops {
 	uint32_t (*bat_metric_get)(struct batadv_neigh_node *neigh_node);
 	bool (*bat_metric_is_equiv_or_better)(uint32_t metric,
 					      uint32_t new_metric);
+	int (*bat_metric_compare)(uint32_t metric, uint32_t new_metric);
 	/* orig_node handling API */
 	void (*bat_orig_print)(struct batadv_priv *priv, struct seq_file *seq);
 };
-- 
1.8.1.5


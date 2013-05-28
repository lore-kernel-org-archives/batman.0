Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 29 May 2013 00:20:46 +0200
Message-Id: <1369779649-2537-8-git-send-email-ordex@autistici.org>
In-Reply-To: <1369779649-2537-1-git-send-email-ordex@autistici.org>
References: <1369779649-2537-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [RFC 06/10] batman-adv: add bat_metric_compare API
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
 types.h      |  2 ++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 18c9ae8..97aa2fe 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -1447,6 +1447,19 @@ static bool batadv_iv_ogm_metric_is_similar(uint32_t metric,
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
@@ -1457,6 +1470,7 @@ static struct batadv_algo_ops batadv_batman_iv __read_mostly = {
 	.bat_ogm_emit = batadv_iv_ogm_emit,
 	.bat_metric_get = batadv_iv_ogm_metric_get,
 	.bat_metric_is_similar = batadv_iv_ogm_metric_is_similar,
+	.bat_metric_compare = batadv_iv_ogm_metric_compare,
 	.bat_orig_print = batadv_iv_ogm_orig_print,
 };
 
diff --git a/main.c b/main.c
index d81f6d6..a5de41e 100644
--- a/main.c
+++ b/main.c
@@ -446,7 +446,8 @@ int batadv_algo_register(struct batadv_algo_ops *bat_algo_ops)
 	    !bat_algo_ops->bat_ogm_schedule ||
 	    !bat_algo_ops->bat_ogm_emit ||
 	    !bat_algo_ops->bat_metric_get ||
-	    !bat_algo_ops->bat_metric_is_similar) {
+	    !bat_algo_ops->bat_metric_is_similar ||
+	    !bat_algo_ops->bat_metric_compare) {
 		pr_info("Routing algo '%s' does not implement required ops\n",
 			bat_algo_ops->name);
 		ret = -EINVAL;
diff --git a/types.h b/types.h
index a2492a4..e2b2aaa 100644
--- a/types.h
+++ b/types.h
@@ -984,6 +984,7 @@ struct batadv_forw_packet {
  * @bat_ogm_emit: send scheduled OGM
  * @bat_metric_is_similar: check if new_metric is good enough to be comparable
  *  with metric
+ * @bat_metric_compare: compare two metric values
  * @bat_orig_print: print the originator table
  */
 struct batadv_algo_ops {
@@ -997,6 +998,7 @@ struct batadv_algo_ops {
 	void (*bat_ogm_emit)(struct batadv_forw_packet *forw_packet);
 	uint32_t (*bat_metric_get)(struct batadv_neigh_node *neigh_node);
 	bool (*bat_metric_is_similar)(uint32_t metric, uint32_t new_metric);
+	int (*bat_metric_compare)(uint32_t metric, uint32_t new_metric);
 	/* orig_node handling API */
 	void (*bat_orig_print)(struct batadv_priv *priv, struct seq_file *seq);
 };
-- 
1.8.1.5


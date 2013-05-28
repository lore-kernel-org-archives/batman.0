Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 29 May 2013 00:20:45 +0200
Message-Id: <1369779649-2537-7-git-send-email-ordex@autistici.org>
In-Reply-To: <1369779649-2537-1-git-send-email-ordex@autistici.org>
References: <1369779649-2537-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [RFC 05/10] batman-adv: add bat_metric_is_similar
	API function
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
compare two metrics to check similarity similarity.

This new API allows each routing protocol to implement its
own logic and make the external code protocol agnostic.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 bat_iv_ogm.c | 7 +++++++
 main.c       | 3 ++-
 main.h       | 6 ++++++
 types.h      | 3 +++
 4 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index abf4cd3..18c9ae8 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -1441,6 +1441,12 @@ static uint32_t batadv_iv_ogm_metric_get(struct batadv_neigh_node *neigh_node)
 	return neigh_node->bat_iv.tq_avg;
 }
 
+static bool batadv_iv_ogm_metric_is_similar(uint32_t metric,
+					    uint32_t new_metric)
+{
+	return (metric - new_metric < BATADV_TQ_SIMILARITY_THRESHOLD);
+}
+
 static struct batadv_algo_ops batadv_batman_iv __read_mostly = {
 	.name = "BATMAN_IV",
 	.bat_iface_enable = batadv_iv_ogm_iface_enable,
@@ -1450,6 +1456,7 @@ static struct batadv_algo_ops batadv_batman_iv __read_mostly = {
 	.bat_ogm_schedule = batadv_iv_ogm_schedule,
 	.bat_ogm_emit = batadv_iv_ogm_emit,
 	.bat_metric_get = batadv_iv_ogm_metric_get,
+	.bat_metric_is_similar = batadv_iv_ogm_metric_is_similar,
 	.bat_orig_print = batadv_iv_ogm_orig_print,
 };
 
diff --git a/main.c b/main.c
index e87105b..d81f6d6 100644
--- a/main.c
+++ b/main.c
@@ -445,7 +445,8 @@ int batadv_algo_register(struct batadv_algo_ops *bat_algo_ops)
 	    !bat_algo_ops->bat_primary_iface_set ||
 	    !bat_algo_ops->bat_ogm_schedule ||
 	    !bat_algo_ops->bat_ogm_emit ||
-	    !bat_algo_ops->bat_metric_get) {
+	    !bat_algo_ops->bat_metric_get ||
+	    !bat_algo_ops->bat_metric_is_similar) {
 		pr_info("Routing algo '%s' does not implement required ops\n",
 			bat_algo_ops->name);
 		ret = -EINVAL;
diff --git a/main.h b/main.h
index fe9a952..1d3611f 100644
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
index 815d52d..a2492a4 100644
--- a/types.h
+++ b/types.h
@@ -982,6 +982,8 @@ struct batadv_forw_packet {
  * @bat_primary_iface_set: called when primary interface is selected / changed
  * @bat_ogm_schedule: prepare a new outgoing OGM for the send queue
  * @bat_ogm_emit: send scheduled OGM
+ * @bat_metric_is_similar: check if new_metric is good enough to be comparable
+ *  with metric
  * @bat_orig_print: print the originator table
  */
 struct batadv_algo_ops {
@@ -994,6 +996,7 @@ struct batadv_algo_ops {
 	void (*bat_ogm_schedule)(struct batadv_hard_iface *hard_iface);
 	void (*bat_ogm_emit)(struct batadv_forw_packet *forw_packet);
 	uint32_t (*bat_metric_get)(struct batadv_neigh_node *neigh_node);
+	bool (*bat_metric_is_similar)(uint32_t metric, uint32_t new_metric);
 	/* orig_node handling API */
 	void (*bat_orig_print)(struct batadv_priv *priv, struct seq_file *seq);
 };
-- 
1.8.1.5


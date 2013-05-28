Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 29 May 2013 00:20:44 +0200
Message-Id: <1369779649-2537-6-git-send-email-ordex@autistici.org>
In-Reply-To: <1369779649-2537-1-git-send-email-ordex@autistici.org>
References: <1369779649-2537-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [RFC 04/10] batman-adv: add bat_metric_get API
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

Each routing algorithm may store its metric value in a
different place, therefore a new API function is needed in
order to ask the algorithm to return the metric of a given
originator

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 bat_iv_ogm.c | 9 +++++++++
 main.c       | 3 ++-
 types.h      | 1 +
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 87005f7..abf4cd3 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -1433,6 +1433,14 @@ next:
 		seq_puts(seq, "No batman nodes in range ...\n");
 }
 
+static uint32_t batadv_iv_ogm_metric_get(struct batadv_neigh_node *neigh_node)
+{
+	if (!neigh_node)
+		return 0;
+
+	return neigh_node->bat_iv.tq_avg;
+}
+
 static struct batadv_algo_ops batadv_batman_iv __read_mostly = {
 	.name = "BATMAN_IV",
 	.bat_iface_enable = batadv_iv_ogm_iface_enable,
@@ -1441,6 +1449,7 @@ static struct batadv_algo_ops batadv_batman_iv __read_mostly = {
 	.bat_primary_iface_set = batadv_iv_ogm_primary_iface_set,
 	.bat_ogm_schedule = batadv_iv_ogm_schedule,
 	.bat_ogm_emit = batadv_iv_ogm_emit,
+	.bat_metric_get = batadv_iv_ogm_metric_get,
 	.bat_orig_print = batadv_iv_ogm_orig_print,
 };
 
diff --git a/main.c b/main.c
index e99c66b..e87105b 100644
--- a/main.c
+++ b/main.c
@@ -444,7 +444,8 @@ int batadv_algo_register(struct batadv_algo_ops *bat_algo_ops)
 	    !bat_algo_ops->bat_iface_update_mac ||
 	    !bat_algo_ops->bat_primary_iface_set ||
 	    !bat_algo_ops->bat_ogm_schedule ||
-	    !bat_algo_ops->bat_ogm_emit) {
+	    !bat_algo_ops->bat_ogm_emit ||
+	    !bat_algo_ops->bat_metric_get) {
 		pr_info("Routing algo '%s' does not implement required ops\n",
 			bat_algo_ops->name);
 		ret = -EINVAL;
diff --git a/types.h b/types.h
index d75c77a..815d52d 100644
--- a/types.h
+++ b/types.h
@@ -993,6 +993,7 @@ struct batadv_algo_ops {
 	void (*bat_primary_iface_set)(struct batadv_hard_iface *hard_iface);
 	void (*bat_ogm_schedule)(struct batadv_hard_iface *hard_iface);
 	void (*bat_ogm_emit)(struct batadv_forw_packet *forw_packet);
+	uint32_t (*bat_metric_get)(struct batadv_neigh_node *neigh_node);
 	/* orig_node handling API */
 	void (*bat_orig_print)(struct batadv_priv *priv, struct seq_file *seq);
 };
-- 
1.8.1.5


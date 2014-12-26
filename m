Return-Path: <mpa@pengutronix.de>
From: Markus Pargmann <mpa@pengutronix.de>
Date: Fri, 26 Dec 2014 12:41:20 +0100
Message-Id: <1419594103-10928-4-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
References: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
Subject: [B.A.T.M.A.N.] [PATCH v2 03/26] batman-adv: iv_ogm,
	Reduce code duplication
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
To: Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <antonio@meshcoding.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>

The difference between tq1 and tq2 are calculated the same way in two
separate functions.

This patch moves the common code to a seperate function
'batadv_iv_ogm_neigh_diff' which handles everything necessary. The other
two functions can then handle errors and use the difference directly.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 bat_iv_ogm.c | 80 +++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 41 insertions(+), 39 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 2d064a71613f..1458ecfa66b8 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -1858,36 +1858,27 @@ next:
 		seq_puts(seq, "No batman nodes in range ...\n");
 }
 
-/**
- * batadv_iv_ogm_neigh_cmp - compare the metrics of two neighbors
- * @neigh1: the first neighbor object of the comparison
- * @if_outgoing1: outgoing interface for the first neighbor
- * @neigh2: the second neighbor object of the comparison
- * @if_outgoing2: outgoing interface for the second neighbor
- *
- * Returns a value less, equal to or greater than 0 if the metric via neigh1 is
- * lower, the same as or higher than the metric via neigh2
- */
-static int batadv_iv_ogm_neigh_cmp(struct batadv_neigh_node *neigh1,
-				   struct batadv_hard_iface *if_outgoing1,
-				   struct batadv_neigh_node *neigh2,
-				   struct batadv_hard_iface *if_outgoing2)
+static int batadv_iv_ogm_neigh_diff(struct batadv_neigh_node *neigh1,
+				    struct batadv_hard_iface *if_outgoing1,
+				    struct batadv_neigh_node *neigh2,
+				    struct batadv_hard_iface *if_outgoing2,
+				    int *diff)
 {
 	struct batadv_neigh_ifinfo *neigh1_ifinfo, *neigh2_ifinfo;
 	uint8_t tq1, tq2;
-	int diff;
+	int ret;
 
 	neigh1_ifinfo = batadv_neigh_ifinfo_get(neigh1, if_outgoing1);
 	neigh2_ifinfo = batadv_neigh_ifinfo_get(neigh2, if_outgoing2);
 
 	if (!neigh1_ifinfo || !neigh2_ifinfo) {
-		diff = 0;
+		ret = -EINVAL;
 		goto out;
 	}
 
 	tq1 = neigh1_ifinfo->bat_iv.tq_avg;
 	tq2 = neigh2_ifinfo->bat_iv.tq_avg;
-	diff = tq1 - tq2;
+	*diff = (int)tq1 - (int)tq2;
 
 out:
 	if (neigh1_ifinfo)
@@ -1895,6 +1886,32 @@ out:
 	if (neigh2_ifinfo)
 		batadv_neigh_ifinfo_free_ref(neigh2_ifinfo);
 
+	return ret;
+}
+
+/**
+ * batadv_iv_ogm_neigh_cmp - compare the metrics of two neighbors
+ * @neigh1: the first neighbor object of the comparison
+ * @if_outgoing1: outgoing interface for the first neighbor
+ * @neigh2: the second neighbor object of the comparison
+ * @if_outgoing2: outgoing interface for the second neighbor
+ *
+ * Returns a value less, equal to or greater than 0 if the metric via neigh1 is
+ * lower, the same as or higher than the metric via neigh2
+ */
+static int batadv_iv_ogm_neigh_cmp(struct batadv_neigh_node *neigh1,
+				   struct batadv_hard_iface *if_outgoing1,
+				   struct batadv_neigh_node *neigh2,
+				   struct batadv_hard_iface *if_outgoing2)
+{
+	int ret;
+	int diff;
+
+	ret = batadv_iv_ogm_neigh_diff(neigh1, if_outgoing1, neigh2,
+				       if_outgoing2, &diff);
+	if (ret)
+		return 0;
+
 	return diff;
 }
 
@@ -1915,30 +1932,15 @@ batadv_iv_ogm_neigh_is_eob(struct batadv_neigh_node *neigh1,
 			   struct batadv_neigh_node *neigh2,
 			   struct batadv_hard_iface *if_outgoing2)
 {
-	struct batadv_neigh_ifinfo *neigh1_ifinfo, *neigh2_ifinfo;
-	uint8_t tq1, tq2;
-	bool ret;
-
-	neigh1_ifinfo = batadv_neigh_ifinfo_get(neigh1, if_outgoing1);
-	neigh2_ifinfo = batadv_neigh_ifinfo_get(neigh2, if_outgoing2);
-
-	/* we can't say that the metric is better */
-	if (!neigh1_ifinfo || !neigh2_ifinfo) {
-		ret = false;
-		goto out;
-	}
-
-	tq1 = neigh1_ifinfo->bat_iv.tq_avg;
-	tq2 = neigh2_ifinfo->bat_iv.tq_avg;
-	ret = (tq1 - tq2) > -BATADV_TQ_SIMILARITY_THRESHOLD;
+	int ret;
+	int diff;
 
-out:
-	if (neigh1_ifinfo)
-		batadv_neigh_ifinfo_free_ref(neigh1_ifinfo);
-	if (neigh2_ifinfo)
-		batadv_neigh_ifinfo_free_ref(neigh2_ifinfo);
+	ret = batadv_iv_ogm_neigh_diff(neigh1, if_outgoing1, neigh2,
+				       if_outgoing2, &diff);
+	if (ret)
+		return false;
 
-	return ret;
+	return diff > -BATADV_TQ_SIMILARITY_THRESHOLD;
 }
 
 static struct batadv_algo_ops batadv_batman_iv __read_mostly = {
-- 
2.1.3


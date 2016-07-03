Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  3 Jul 2016 11:07:14 +0200
Message-Id: <1467536834-16185-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v3] batman-adv: iv_ogm,
	Reduce code duplication
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

From: Markus Pargmann <mpa@pengutronix.de>

The difference between tq1 and tq2 are calculated the same way in two
separate functions.

This patch moves the common code to a seperate function
'batadv_iv_ogm_neigh_diff' which handles everything necessary. The other
two functions can then handle errors and use the difference directly.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
[sven@narfation.org: rebased on current version, initialize return variable
in batadv_iv_ogm_neigh_diff, add kerneldoc, convert to bool return type]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v3:
 - rebased on current version
 - initialize return variable in batadv_iv_ogm_neigh_diff
 - add kerneldoc for batadv_iv_ogm_neigh_diff
 - convert batadv_iv_ogm_neigh_diff to bool return type
---
 net/batman-adv/bat_iv_ogm.c | 77 +++++++++++++++++++++++++++------------------
 1 file changed, 47 insertions(+), 30 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 6af4462..2904ff5 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -2018,35 +2018,40 @@ static void batadv_iv_neigh_print(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_iv_ogm_neigh_cmp - compare the metrics of two neighbors
+ * batadv_iv_ogm_neigh_diff - calculate tq difference of two neighbors
  * @neigh1: the first neighbor object of the comparison
  * @if_outgoing1: outgoing interface for the first neighbor
  * @neigh2: the second neighbor object of the comparison
  * @if_outgoing2: outgoing interface for the second neighbor
+ * @diff: pointer to integer receiving the calculated difference
  *
- * Return: a value less, equal to or greater than 0 if the metric via neigh1 is
- * lower, the same as or higher than the metric via neigh2
+ * The content of *@diff is only valid when this function returns true.
+ * It is less, equal to or greater than 0 if the metric via neigh1 is lower,
+ * the same as or higher than the metric via neigh2
+ *
+ * Return: true when the difference could be calculated, false otherwise
  */
-static int batadv_iv_ogm_neigh_cmp(struct batadv_neigh_node *neigh1,
-				   struct batadv_hard_iface *if_outgoing1,
-				   struct batadv_neigh_node *neigh2,
-				   struct batadv_hard_iface *if_outgoing2)
+static bool batadv_iv_ogm_neigh_diff(struct batadv_neigh_node *neigh1,
+				     struct batadv_hard_iface *if_outgoing1,
+				     struct batadv_neigh_node *neigh2,
+				     struct batadv_hard_iface *if_outgoing2,
+				     int *diff)
 {
 	struct batadv_neigh_ifinfo *neigh1_ifinfo, *neigh2_ifinfo;
 	u8 tq1, tq2;
-	int diff;
+	bool ret = true;
 
 	neigh1_ifinfo = batadv_neigh_ifinfo_get(neigh1, if_outgoing1);
 	neigh2_ifinfo = batadv_neigh_ifinfo_get(neigh2, if_outgoing2);
 
 	if (!neigh1_ifinfo || !neigh2_ifinfo) {
-		diff = 0;
+		ret = false;
 		goto out;
 	}
 
 	tq1 = neigh1_ifinfo->bat_iv.tq_avg;
 	tq2 = neigh2_ifinfo->bat_iv.tq_avg;
-	diff = tq1 - tq2;
+	*diff = (int)tq1 - (int)tq2;
 
 out:
 	if (neigh1_ifinfo)
@@ -2054,6 +2059,32 @@ out:
 	if (neigh2_ifinfo)
 		batadv_neigh_ifinfo_put(neigh2_ifinfo);
 
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
+ * Return: a value less, equal to or greater than 0 if the metric via neigh1 is
+ * lower, the same as or higher than the metric via neigh2
+ */
+static int batadv_iv_ogm_neigh_cmp(struct batadv_neigh_node *neigh1,
+				   struct batadv_hard_iface *if_outgoing1,
+				   struct batadv_neigh_node *neigh2,
+				   struct batadv_hard_iface *if_outgoing2)
+{
+	bool ret;
+	int diff;
+
+	ret = batadv_iv_ogm_neigh_diff(neigh1, if_outgoing1, neigh2,
+				       if_outgoing2, &diff);
+	if (!ret)
+		return 0;
+
 	return diff;
 }
 
@@ -2074,29 +2105,15 @@ batadv_iv_ogm_neigh_is_sob(struct batadv_neigh_node *neigh1,
 			   struct batadv_neigh_node *neigh2,
 			   struct batadv_hard_iface *if_outgoing2)
 {
-	struct batadv_neigh_ifinfo *neigh1_ifinfo, *neigh2_ifinfo;
-	u8 tq1, tq2;
 	bool ret;
+	int diff;
 
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
-
-out:
-	if (neigh1_ifinfo)
-		batadv_neigh_ifinfo_put(neigh1_ifinfo);
-	if (neigh2_ifinfo)
-		batadv_neigh_ifinfo_put(neigh2_ifinfo);
+	ret = batadv_iv_ogm_neigh_diff(neigh1, if_outgoing1, neigh2,
+				       if_outgoing2, &diff);
+	if (!ret)
+		return false;
 
+	ret = diff > -BATADV_TQ_SIMILARITY_THRESHOLD;
 	return ret;
 }
 
-- 
2.8.1


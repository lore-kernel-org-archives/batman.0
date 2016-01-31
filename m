Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon,  1 Feb 2016 00:21:18 +0800
Message-Id: <1454257280-19649-1-git-send-email-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [PATCH next 1/3] batman-adv: add missing kernel doc
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

Fixes: 5c324517 ("ELP - compute the metric based on the estimated throughput")

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 net/batman-adv/bat_v_elp.c | 3 ++-
 net/batman-adv/main.h      | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index f257897..46c6a00 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -67,7 +67,8 @@ static void batadv_v_elp_start_timer(struct batadv_hard_iface *hard_iface)
  * batadv_v_elp_get_throughput - get the throughput towards a neighbour
  * @neigh: the neighbour for which the throughput has to be obtained
  *
- * Return: the throughput towards the given neighbour.
+ * Return: The throughput towards the given neighbour in multiples of 100kpbs
+ *         (a value of '10' equals to 1Mbps).
  */
 static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 {
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 7b05f68..db45336 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -62,7 +62,7 @@
 #define BATADV_TQ_TOTAL_BIDRECT_LIMIT 1
 
 /* B.A.T.M.A.N. V */
-#define BATADV_THROUGHPUT_DEFAULT_VALUE 10
+#define BATADV_THROUGHPUT_DEFAULT_VALUE 10 /* 1 Mbps */
 #define BATADV_ELP_PROBES_PER_NODE 2
 #define BATADV_ELP_MIN_PROBE_SIZE 200 /* bytes */
 #define BATADV_ELP_PROBE_MAX_TX_DIFF 100 /* milliseconds */
-- 
2.7.0


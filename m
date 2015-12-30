Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 30 Dec 2015 20:40:12 +0800
Message-Id: <1451479214-28034-11-git-send-email-mareklindner@neomailbox.ch>
In-Reply-To: <2457136.iz2mu7y0Mc@voltaire>
References: <2457136.iz2mu7y0Mc@voltaire>
Subject: [B.A.T.M.A.N.] [PATCH 11/13] batman-adv: B.A.T.M.A.N. V - implement
	neighbor comparison API calls
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

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 net/batman-adv/bat_v.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index e669863..1ca7e65 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -19,12 +19,15 @@
 #include "main.h"
 
 #include <linux/atomic.h>
+#include <linux/bug.h>
 #include <linux/cache.h>
 #include <linux/init.h>
+#include <linux/types.h>
 #include <linux/workqueue.h>
 
 #include "bat_v_elp.h"
 #include "bat_v_ogm.h"
+#include "originator.h"
 #include "packet.h"
 
 static int batadv_v_iface_enable(struct batadv_hard_iface *hard_iface)
@@ -78,6 +81,39 @@ static void batadv_v_ogm_emit(struct batadv_forw_packet *forw_packet)
 {
 }
 
+static int batadv_v_neigh_cmp(struct batadv_neigh_node *neigh1,
+			      struct batadv_hard_iface *if_outgoing1,
+			      struct batadv_neigh_node *neigh2,
+			      struct batadv_hard_iface *if_outgoing2)
+{
+	struct batadv_neigh_ifinfo *ifinfo1, *ifinfo2;
+
+	ifinfo1 = batadv_neigh_ifinfo_get(neigh1, if_outgoing1);
+	ifinfo2 = batadv_neigh_ifinfo_get(neigh2, if_outgoing2);
+
+	if (WARN_ON(!ifinfo1 || !ifinfo2))
+		return 0;
+
+	return ifinfo1->bat_v.throughput - ifinfo2->bat_v.throughput;
+}
+
+static bool batadv_v_neigh_is_sob(struct batadv_neigh_node *neigh1,
+				  struct batadv_hard_iface *if_outgoing1,
+				  struct batadv_neigh_node *neigh2,
+				  struct batadv_hard_iface *if_outgoing2)
+{
+	struct batadv_neigh_ifinfo *ifinfo1, *ifinfo2;
+	u32 threshold;
+
+	ifinfo1 = batadv_neigh_ifinfo_get(neigh1, if_outgoing1);
+	ifinfo2 = batadv_neigh_ifinfo_get(neigh2, if_outgoing2);
+
+	threshold = ifinfo1->bat_v.throughput / 4;
+	threshold = ifinfo1->bat_v.throughput - threshold;
+
+	return ifinfo2->bat_v.throughput > threshold;
+}
+
 static struct batadv_algo_ops batadv_batman_v __read_mostly = {
 	.name = "BATMAN_V",
 	.bat_iface_enable = batadv_v_iface_enable,
@@ -87,6 +123,8 @@ static struct batadv_algo_ops batadv_batman_v __read_mostly = {
 	.bat_hardif_neigh_init = batadv_v_hardif_neigh_init,
 	.bat_ogm_emit = batadv_v_ogm_emit,
 	.bat_ogm_schedule = batadv_v_ogm_schedule,
+	.bat_neigh_cmp = batadv_v_neigh_cmp,
+	.bat_neigh_is_similar_or_better = batadv_v_neigh_is_sob,
 };
 
 /**
-- 
2.6.4


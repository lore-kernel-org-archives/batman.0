Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 11 Feb 2014 13:48:21 +0100
Message-Id: <1392122903-805-22-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [RFC 21/23] batman-adv: B.A.T.M.A.N. V - implement
	neigh_is_equiv_or_better API
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

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 bat_v.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/bat_v.c b/bat_v.c
index 3e4575d..70ff9e9 100644
--- a/bat_v.c
+++ b/bat_v.c
@@ -21,6 +21,7 @@
 #include "bat_algo.h"
 #include "bat_v_elp.h"
 #include "bat_v_ogm.h"
+#include "originator.h"
 
 static int batadv_v_iface_enable(struct batadv_hard_iface *hard_iface)
 {
@@ -63,6 +64,23 @@ static void batadv_v_ogm_emit(struct batadv_forw_packet *forw_packet)
 {
 }
 
+static bool batadv_v_neigh_is_eob(struct batadv_neigh_node *neigh1,
+				  struct batadv_hard_iface *if_outgoing1,
+				  struct batadv_neigh_node *neigh2,
+				  struct batadv_hard_iface *if_outgoing2)
+{
+	struct batadv_neigh_ifinfo *ifinfo1, *ifinfo2;
+	uint32_t threshold;
+
+	ifinfo1 = batadv_neigh_ifinfo_get(neigh1, if_outgoing1);
+	ifinfo2 = batadv_neigh_ifinfo_get(neigh2, if_outgoing2);
+
+	threshold = ifinfo1->bat_v.metric << 8 >> 10;
+	threshold = ifinfo1->bat_v.metric - threshold;
+
+	return ifinfo2->bat_v.metric > threshold;
+}
+
 static void batadv_v_neigh_free(struct batadv_neigh_node *neigh)
 {
 	batadv_elp_neigh_node_free_ref(neigh->bat_v.elp_neigh);
@@ -77,6 +95,7 @@ static struct batadv_algo_ops batadv_batman_v __read_mostly = {
 	.bat_primary_iface_set = batadv_v_primary_iface_set,
 	.bat_ogm_emit = batadv_v_ogm_emit,
 	.bat_ogm_schedule = batadv_v_ogm_schedule,
+	.bat_neigh_is_equiv_or_better = batadv_v_neigh_is_eob,
 	.bat_neigh_free = batadv_v_neigh_free,
 };
 
-- 
1.8.5.3


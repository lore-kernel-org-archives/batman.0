Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 11 Feb 2014 13:48:22 +0100
Message-Id: <1392122903-805-23-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [RFC 22/23] batman-adv: B.A.T.M.A.N. V - implement
	bat_neigh_cmp API
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 bat_v.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/bat_v.c b/bat_v.c
index 70ff9e9..d05d548 100644
--- a/bat_v.c
+++ b/bat_v.c
@@ -64,6 +64,23 @@ static void batadv_v_ogm_emit(struct batadv_forw_packet *forw_packet)
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
+	return ifinfo1->bat_v.metric - ifinfo2->bat_v.metric;
+
+}
+
 static bool batadv_v_neigh_is_eob(struct batadv_neigh_node *neigh1,
 				  struct batadv_hard_iface *if_outgoing1,
 				  struct batadv_neigh_node *neigh2,
@@ -95,6 +112,7 @@ static struct batadv_algo_ops batadv_batman_v __read_mostly = {
 	.bat_primary_iface_set = batadv_v_primary_iface_set,
 	.bat_ogm_emit = batadv_v_ogm_emit,
 	.bat_ogm_schedule = batadv_v_ogm_schedule,
+	.bat_neigh_cmp = batadv_v_neigh_cmp,
 	.bat_neigh_is_equiv_or_better = batadv_v_neigh_is_eob,
 	.bat_neigh_free = batadv_v_neigh_free,
 };
-- 
1.8.5.3


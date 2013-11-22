Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 22 Nov 2013 13:02:06 +0100
Message-Id: <1385121727-12847-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: fix neigh_node multiif
	regression in network coding
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
Cc: Simon Wunderlich <simon@open-mesh.com>

From: Simon Wunderlich <simon@open-mesh.com>

A previous commit for the multi interface optimization did not
change the member access for neigh_node to their respective new ifinfo
structures for the network coding implementation.

This was introduced by change 9bb33b8d88e318c4879d37d06ad28e3e018b9036
("batman-adv: split tq information in neigh_node struct")

Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
---
 network-coding.c |   24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/network-coding.c b/network-coding.c
index 0b35e9e..8678448 100644
--- a/network-coding.c
+++ b/network-coding.c
@@ -1005,6 +1005,8 @@ static bool batadv_nc_code_packets(struct batadv_priv *bat_priv,
 	struct batadv_coded_packet *coded_packet;
 	struct batadv_neigh_node *neigh_tmp, *router_neigh;
 	struct batadv_neigh_node *router_coding = NULL;
+	struct batadv_neigh_ifinfo *router_neigh_ifinfo = NULL;
+	struct batadv_neigh_ifinfo *router_coding_ifinfo = NULL;
 	uint8_t *first_source, *first_dest, *second_source, *second_dest;
 	__be32 packet_id1, packet_id2;
 	size_t count;
@@ -1022,16 +1024,26 @@ static bool batadv_nc_code_packets(struct batadv_priv *bat_priv,
 	if (!router_neigh)
 		goto out;
 
+	router_neigh_ifinfo = batadv_neigh_ifinfo_get(router_neigh,
+						      BATADV_IF_DEFAULT);
+	if (!router_neigh_ifinfo)
+		goto out;
+
 	neigh_tmp = nc_packet->neigh_node;
 	router_coding = batadv_orig_router_get(neigh_tmp->orig_node,
 					       BATADV_IF_DEFAULT);
 	if (!router_coding)
 		goto out;
 
-	tq_tmp = batadv_nc_random_weight_tq(router_neigh->bat_iv.tq_avg);
-	tq_weighted_neigh = tq_tmp;
-	tq_tmp = batadv_nc_random_weight_tq(router_coding->bat_iv.tq_avg);
-	tq_weighted_coding = tq_tmp;
+	router_coding_ifinfo = batadv_neigh_ifinfo_get(router_coding,
+						       BATADV_IF_DEFAULT);
+	if (!router_coding_ifinfo)
+		goto out;
+
+	tq_tmp = router_neigh_ifinfo->bat_iv.tq_avg;
+	tq_weighted_neigh = batadv_nc_random_weight_tq(tq_tmp);
+	tq_tmp = router_coding_ifinfo->bat_iv.tq_avg;
+	tq_weighted_coding = batadv_nc_random_weight_tq(tq_tmp);
 
 	/* Select one destination for the MAC-header dst-field based on
 	 * weighted TQ-values.
@@ -1155,6 +1167,10 @@ out:
 		batadv_neigh_node_free_ref(router_neigh);
 	if (router_coding)
 		batadv_neigh_node_free_ref(router_coding);
+	if (router_neigh_ifinfo)
+		batadv_neigh_ifinfo_free_ref(router_neigh_ifinfo);
+	if (router_coding_ifinfo)
+		batadv_neigh_ifinfo_free_ref(router_coding_ifinfo);
 	return res;
 }
 
-- 
1.7.10.4


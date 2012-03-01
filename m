Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu,  1 Mar 2012 15:35:16 +0800
Message-Id: <1330587321-12177-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/6] batman-adv: introduce
	is_single_hop_neigh variable to increase readability
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 bat_iv_ogm.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index d9195b3..aba0204 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -483,7 +483,8 @@ static void bat_iv_ogm_queue_add(struct bat_priv *bat_priv,
 static void bat_iv_ogm_forward(struct orig_node *orig_node,
 			       const struct ethhdr *ethhdr,
 			       struct batman_ogm_packet *batman_ogm_packet,
-			       int directlink, struct hard_iface *if_incoming)
+			       bool is_single_hop_neigh,
+			       struct hard_iface *if_incoming)
 {
 	struct bat_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct neigh_node *router;
@@ -537,7 +538,7 @@ static void bat_iv_ogm_forward(struct orig_node *orig_node,
 
 	/* switch of primaries first hop flag when forwarding */
 	batman_ogm_packet->flags &= ~PRIMARIES_FIRST_HOP;
-	if (directlink)
+	if (is_single_hop_neigh)
 		batman_ogm_packet->flags |= DIRECTLINK;
 	else
 		batman_ogm_packet->flags &= ~DIRECTLINK;
@@ -926,7 +927,8 @@ static void bat_iv_ogm_process(const struct ethhdr *ethhdr,
 	struct neigh_node *orig_neigh_router = NULL;
 	int has_directlink_flag;
 	int is_my_addr = 0, is_my_orig = 0, is_my_oldorig = 0;
-	int is_broadcast = 0, is_bidirectional, is_single_hop_neigh;
+	int is_broadcast = 0, is_bidirectional;
+	bool is_single_hop_neigh = false;
 	int is_duplicate;
 	uint32_t if_incoming_seqno;
 
@@ -950,8 +952,8 @@ static void bat_iv_ogm_process(const struct ethhdr *ethhdr,
 
 	has_directlink_flag = (batman_ogm_packet->flags & DIRECTLINK ? 1 : 0);
 
-	is_single_hop_neigh = (compare_eth(ethhdr->h_source,
-					   batman_ogm_packet->orig) ? 1 : 0);
+	if (compare_eth(ethhdr->h_source, batman_ogm_packet->orig))
+		is_single_hop_neigh = true;
 
 	bat_dbg(DBG_BATMAN, bat_priv,
 		"Received BATMAN packet via NB: %pM, IF: %s [%pM] "
@@ -1125,7 +1127,7 @@ static void bat_iv_ogm_process(const struct ethhdr *ethhdr,
 
 		/* mark direct link on incoming interface */
 		bat_iv_ogm_forward(orig_node, ethhdr, batman_ogm_packet,
-				   1, if_incoming);
+				   is_single_hop_neigh, if_incoming);
 
 		bat_dbg(DBG_BATMAN, bat_priv, "Forwarding packet: "
 			"rebroadcast neighbor packet with direct link flag\n");
@@ -1148,7 +1150,7 @@ static void bat_iv_ogm_process(const struct ethhdr *ethhdr,
 	bat_dbg(DBG_BATMAN, bat_priv,
 		"Forwarding packet: rebroadcast originator packet\n");
 	bat_iv_ogm_forward(orig_node, ethhdr, batman_ogm_packet,
-			   0, if_incoming);
+			   is_single_hop_neigh, if_incoming);
 
 out_neigh:
 	if ((orig_neigh_node) && (!is_single_hop_neigh))
-- 
1.7.9


Return-Path: <andrew.lunn@ascom.ch>
Date: Tue, 14 Jul 2009 11:21:52 +0200
From: Andrew Lunn <andrew.lunn@ascom.ch>
Message-ID: <20090714092152.GJ19071@ma.tech.ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [batman-adv]: Fix some typo's and spelling errors
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.net

Fix a few typo's and spelling errors i noticed while reading through
the code. No functional changes.

Signed-off-by: Andrew Lunn <andrew.lunn@ascom.ch>
Index: batman-adv-kernelland/send.c
===================================================================
--- batman-adv-kernelland/send.c	(revision 1341)
+++ batman-adv-kernelland/send.c	(working copy)
@@ -143,7 +143,7 @@
 				batman_packet->tq = (batman_packet->tq * (TQ_MAX_VALUE - (2 * TQ_HOP_PENALTY))) / (TQ_MAX_VALUE);
 
 			debug_log(LOG_TYPE_BATMAN,
-					"%s %spacket (originator %s, seqno %d, TQ %d, TTL %d, IDF %s) on interface %s [%s]\n",
+					"%s %s packet (originator %s, seqno %d, TQ %d, TTL %d, IDF %s) on interface %s [%s]\n",
 					(packet_num > 0 ? "Forwarding" : (forw_packet->own ? "Sending own" : "Forwarding")),
 					(packet_num > 0 ? "aggregated " : ""), orig_str, ntohs(batman_packet->seqno),
 					batman_packet->tq, batman_packet->ttl,
Index: batman-adv-kernelland/hard-interface.c
===================================================================
--- batman-adv-kernelland/hard-interface.c	(revision 1341)
+++ batman-adv-kernelland/hard-interface.c	(working copy)
@@ -314,7 +314,7 @@
 		return;
 
 	/**
-	 * wait for readers of the the interfaces, so update won't be a problem.
+	 * wait for readers of the interfaces, so update won't be a problem.
 	 * this function is not time critical and can wait a bit ....
 	 */
 	synchronize_rcu();
Index: batman-adv-kernelland/README
===================================================================
--- batman-adv-kernelland/README	(revision 1341)
+++ batman-adv-kernelland/README	(working copy)
@@ -57,7 +57,7 @@
 
 # cat /proc/net/batman-adv/vis
 
-This output can be processeed with graphviz-tools like dot.
+This output can be processed with graphviz-tools like dot.
 The labels are similar/compatible to the ETX metric, 1.0 means perfect
 connection (100%), 2.0 means 50%, 3.0 means 33% and so on.
 
Index: batman-adv-kernelland/aggregation.c
===================================================================
--- batman-adv-kernelland/aggregation.c	(revision 1341)
+++ batman-adv-kernelland/aggregation.c	(working copy)
@@ -59,7 +59,7 @@
 				batman_packet = (struct batman_packet *)forw_packet_pos->packet_buff;
 
 				/**
-				 * check aggregation compability
+				 * check aggregation compatibility
 				 * -> direct link packets are broadcasted on their interface only
 				 * -> aggregate packet if the current packet is a "global" packet
 				 *    as well as the base packet
Index: batman-adv-kernelland/routing.c
===================================================================
--- batman-adv-kernelland/routing.c	(revision 1341)
+++ batman-adv-kernelland/routing.c	(working copy)
@@ -76,7 +76,7 @@
 		kfree(neigh_node);
 	}
 
-	hna_global_del_orig(orig_node, "originator timeouted");
+	hna_global_del_orig(orig_node, "originator timed out");
 
 	kfree(orig_node->bcast_own);
 	kfree(orig_node->bcast_own_sum);
@@ -158,7 +158,7 @@
 		if ((orig_node->router != NULL) && (neigh_node == NULL)) {
 
 			debug_log(LOG_TYPE_ROUTES, "Deleting route towards: %s\n", orig_str);
-			hna_global_del_orig(orig_node, "originator timeouted");
+			hna_global_del_orig(orig_node, "originator timed out");
 
 		/* route added */
 		} else if ((orig_node->router == NULL) && (neigh_node != NULL)) {
@@ -247,7 +247,7 @@
 	/*
 	 * 1 - ((1-x) ** 3), normalized to TQ_MAX_VALUE
 	 * this does affect the nearly-symmetric links only a little,
-	 * but punishes asymetric links more.
+	 * but punishes asymmetric links more.
 	 * this will give a value between 0 and TQ_MAX_VALUE
 	 */
 	orig_neigh_node->tq_asym_penalty = TQ_MAX_VALUE - (TQ_MAX_VALUE *
@@ -258,7 +258,7 @@
 
 	batman_packet->tq = ((batman_packet->tq * orig_neigh_node->tq_own * orig_neigh_node->tq_asym_penalty) / (TQ_MAX_VALUE *  TQ_MAX_VALUE));
 
-	debug_log(LOG_TYPE_BATMAN, "bidirectional: orig = %-15s neigh = %-15s => own_bcast = %2i, real recv = %2i, local tq: %3i, asym_penality: %3i, total tq: %3i \n",
+	debug_log(LOG_TYPE_BATMAN, "bidirectional: orig = %-15s neigh = %-15s => own_bcast = %2i, real recv = %2i, local tq: %3i, asym_penalty: %3i, total tq: %3i \n",
 		  orig_str, neigh_str, total_count, neigh_node->real_packet_count, orig_neigh_node->tq_own, orig_neigh_node->tq_asym_penalty, batman_packet->tq);
 
 	/* if link has the minimum required transmission quality consider it bidirectional */
@@ -451,9 +451,9 @@
 	if (orig_neigh_node == NULL)
 		return;
 
-	/* drop packet if sender is not a direct neighbor and if we no route towards it */
+	/* drop packet if sender is not a direct neighbor and if we don't route towards it */
 	if (!is_single_hop_neigh && (orig_neigh_node->router == NULL)) {
-		debug_log(LOG_TYPE_BATMAN, "Drop packet: OGM via unkown neighbor! \n");
+		debug_log(LOG_TYPE_BATMAN, "Drop packet: OGM via unknown neighbor! \n");
 		return;
 	}
 
@@ -662,7 +662,7 @@
 					if (!is_my_mac(ethhdr->h_dest))
 						continue;
 
-					/* drop packet if it has not neccessary minimum size */
+					/* drop packet if it has not necessary minimum size */
 					if (result < sizeof(struct ethhdr) + sizeof(struct icmp_packet))
 						continue;
 
@@ -761,7 +761,7 @@
 					if (!is_my_mac(ethhdr->h_dest))
 						continue;
 
-					/* drop packet if it has not neccessary minimum size */
+					/* drop packet if it has not necessary minimum size */
 					if (result < sizeof(struct ethhdr) + sizeof(struct unicast_packet))
 						continue;
 
@@ -809,7 +809,7 @@
 					if (is_bcast(ethhdr->h_source))
 						continue;
 
-					/* drop packet if it has not neccessary minimum size */
+					/* drop packet if it has not necessary minimum size */
 					if (result < sizeof(struct ethhdr) + sizeof(struct bcast_packet))
 						continue;
 
Index: batman-adv-kernelland/main.h
===================================================================
--- batman-adv-kernelland/main.h	(revision 1341)
+++ batman-adv-kernelland/main.h	(working copy)
@@ -34,7 +34,7 @@
 #define PURGE_TIMEOUT 200000  /* purge originators after time in ms if no valid packet comes in -> TODO: check influence on TQ_LOCAL_WINDOW_SIZE */
 #define LOCAL_HNA_TIMEOUT 3600000
 
-#define TQ_LOCAL_WINDOW_SIZE 64     /* sliding packet range of received originator messages in squence numbers (should be a multiple of our word size) */
+#define TQ_LOCAL_WINDOW_SIZE 64     /* sliding packet range of received originator messages in sequence numbers (should be a multiple of our word size) */
 #define TQ_GLOBAL_WINDOW_SIZE 10
 #define TQ_LOCAL_BIDRECT_SEND_MINIMUM 1
 #define TQ_LOCAL_BIDRECT_RECV_MINIMUM 1

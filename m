Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 3 Aug 2009 18:21:12 +0800
References: <20090722105639.GH32143@ma.tech.ascom.ch>
	<200907280020.06026.lindner_marek@yahoo.de>
	<OF82FBEF87.4CF60579-ONC1257603.002FC1DB-C1257603.004FD789@CHASCOM.INT>
In-Reply-To: <OF82FBEF87.4CF60579-ONC1257603.002FC1DB-C1257603.004FD789@CHASCOM.INT>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_iordKY7x5WtE2e+"
Message-Id: <200908031821.22497.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman goes looping...
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

--Boundary-00=_iordKY7x5WtE2e+
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 30 July 2009 22:32:04 Yang Su wrote:
> 1.  Similar to what Marek proposed. But push it to the extreme: switch to a
> neighbor only when it has the best tq AND it has the newest seqno.  This
> fix along seems to already solve the looping problem in the test cases. It
> reduces the rerouting time from more than 1 minutes to less than 15
> seconds.  Marek: I also tried the patch you sent. It didn't help in this
> setup.

Changing the route based on the (fastest) sequence number has some drawbacks 
which we experienced before (BATMAN III). It tends to discriminate longer but 
better routes and favors short paths. In some asymetric link (worst case) 
scenarios it would route against all odds, simply because receiving a fast 
packet (newest seqno) does not mean we can send the same way back. If possible 
I'd like to avoid this strict seqno check.

I attached another patch which will conduct a route switch only if the TQ of 
the sending neighbor is better than our current best route (no negative 
switching anymore). I tested the patch here and it works so far but my 
environment is less controlled than yours. Could you perform the same test on 
your setup ?

If you intend to experiment with other ideas watch out for the sequence number 
as it will overflow. A simple "greater than" check might lead to strange 
results. Also, updates_routes() checks for changed HNA messages even if the 
next hop does not change.


> 2. Relaxed echo cancellation. This is based on  the following observation:
> the TQ value that a node puts into OGM is completely decoupled with "from
> which neighbor this OGM is received".   As a result, the TQ value contained
> in the echoed OGM represent the real TQ value at the neighbor which echoed
> this OGM. The current echo cancellation implementation just drops all the
> echoed OGM. This may prevent the node from updating the information towards
> the neighbor that echos the OGM. In the extreme case, the information
> towards that neighbor may becomes completely stale (similar to what happens
> in case 2).  The change I  made:  Always check the TQ contained in the
> echoed OGMs. When it is worse than the avg TQ towards that neighbor, we use
> this TQ reading to update the avg TQ towards that neighbor. This change
> didn't show any effect during the chain tests. However, I still include
> this change in the patch to bring up the discussion.

Right, every node will emit his currently best TQ value but I did not 
understand how we can use that. If we send him a better TQ he will send back 
that number. If we send a bad TQ he will send his good number. Furthermore, 
each hop will apply some asymetric / hop / wifi penalty that we pull into our 
routing database ?

Regards,
Marek


--Boundary-00=_iordKY7x5WtE2e+
Content-Type: text/x-patch;
  charset="UTF-8";
  name="switch-route-with-better-tq.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="switch-route-with-better-tq.patch"

 batman-adv-kernelland/routing.c |   44 ++++++++++++++++----------------------
 1 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/batman-adv-kernelland/routing.c b/batman-adv-kernelland/routing.c
index b576f8c..204f6a3 100644
--- a/batman-adv-kernelland/routing.c
+++ b/batman-adv-kernelland/routing.c
@@ -270,31 +270,22 @@ static int isBidirectionalNeigh(struct orig_node *orig_node, struct orig_node *o
 
 static void update_orig(struct orig_node *orig_node, struct ethhdr *ethhdr, struct batman_packet *batman_packet, struct batman_if *if_incoming, unsigned char *hna_buff, int hna_buff_len, char is_duplicate)
 {
-	struct neigh_node *neigh_node = NULL, *tmp_neigh_node = NULL, *best_neigh_node = NULL;
-	unsigned char max_tq = 0, max_bcast_own = 0;
+	struct neigh_node *neigh_node = NULL, *tmp_neigh_node = NULL;
 	int tmp_hna_buff_len;
 
 	debug_log(LOG_TYPE_BATMAN, "update_originator(): Searching and updating originator entry of received packet \n");
 
 	list_for_each_entry(tmp_neigh_node, &orig_node->neigh_list, list) {
-
 		if (compare_orig(tmp_neigh_node->addr, ethhdr->h_source) && (tmp_neigh_node->if_incoming == if_incoming)) {
 			neigh_node = tmp_neigh_node;
-		} else {
-
-			if (!is_duplicate) {
-				ring_buffer_set(tmp_neigh_node->tq_recv, &tmp_neigh_node->tq_index, 0);
-				tmp_neigh_node->tq_avg = ring_buffer_avg(tmp_neigh_node->tq_recv);
-			}
+			continue;
+		}
 
-			/* if we got have a better tq value via this neighbour or same tq value if it is currently our best neighbour (to avoid route flipping) */
-			if ((tmp_neigh_node->tq_avg > max_tq) || ((tmp_neigh_node->tq_avg == max_tq) && (tmp_neigh_node->orig_node->bcast_own_sum[if_incoming->if_num] > max_bcast_own)) || ((orig_node->router == tmp_neigh_node) && (tmp_neigh_node->tq_avg == max_tq))) {
+		if (is_duplicate)
+			continue;
 
-				max_tq = tmp_neigh_node->tq_avg;
-				max_bcast_own = tmp_neigh_node->orig_node->bcast_own_sum[if_incoming->if_num];
-				best_neigh_node = tmp_neigh_node;
-			}
-		}
+		ring_buffer_set(tmp_neigh_node->tq_recv, &tmp_neigh_node->tq_index, 0);
+		tmp_neigh_node->tq_avg = ring_buffer_avg(tmp_neigh_node->tq_recv);
 	}
 
 	if (neigh_node == NULL)
@@ -313,17 +304,20 @@ static void update_orig(struct orig_node *orig_node, struct ethhdr *ethhdr, stru
 		neigh_node->last_ttl = batman_packet->ttl;
 	}
 
-	if ((neigh_node->tq_avg > max_tq) || ((neigh_node->tq_avg == max_tq) && (neigh_node->orig_node->bcast_own_sum[if_incoming->if_num] > max_bcast_own)) || ((orig_node->router == neigh_node) && (neigh_node->tq_avg == max_tq))) {
-
-		max_tq = neigh_node->tq_avg;
-		max_bcast_own = neigh_node->orig_node->bcast_own_sum[if_incoming->if_num];
-		best_neigh_node = neigh_node;
-
-	}
-
 	tmp_hna_buff_len = (hna_buff_len > batman_packet->num_hna * ETH_ALEN ? batman_packet->num_hna * ETH_ALEN : hna_buff_len);
 
-	update_routes(orig_node, best_neigh_node, hna_buff, tmp_hna_buff_len);
+	/**
+	 * if we got have a better tq value via this neighbour or
+	 * same tq value but the link is more symetric change the next hop
+	 * router
+	 */
+	if ((orig_node->router != neigh_node) && ((!orig_node->router) ||
+	    (neigh_node->tq_avg > orig_node->router->tq_avg) ||
+	    ((neigh_node->tq_avg == orig_node->router->tq_avg) &&
+	     (neigh_node->orig_node->bcast_own_sum[if_incoming->if_num] > orig_node->router->orig_node->bcast_own_sum[if_incoming->if_num]))))
+		update_routes(orig_node, neigh_node, hna_buff, tmp_hna_buff_len);
+	else
+		update_routes(orig_node, orig_node->router, hna_buff, tmp_hna_buff_len);
 }
 
 static char count_real_packets(struct ethhdr *ethhdr, struct batman_packet *batman_packet, struct batman_if *if_incoming)

--Boundary-00=_iordKY7x5WtE2e+--

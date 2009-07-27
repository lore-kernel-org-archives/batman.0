Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 28 Jul 2009 00:20:05 +0800
References: <20090722105639.GH32143@ma.tech.ascom.ch>
In-Reply-To: <20090722105639.GH32143@ma.tech.ascom.ch>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_2OdbKKKCpiQN9mh"
Message-Id: <200907280020.06026.lindner_marek@yahoo.de>
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
To: b.a.t.m.a.n@lists.open-mesh.net

--Boundary-00=_2OdbKKKCpiQN9mh
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Hi,

> Looking at the logs of uml1, uml1 is always routing to uml9 via uml2.
> The problem here i think is to do with the asymetric links algorithms.
> When sending out an OGM, the node uses the TQ for its best link to the
> originator, not the link the OGM came in on. If the OGM from uml1
> origionally from UML3 reported the TQ via that route, the TQ would
> very likely be lower. uml2 would then not of choosen to swap to
> uml1. However, uml1 reports its best route, which is via uml2. uml2
> does not know this, decides to use uml1, and we have a loop.
>
> Does this all hang together correctly? I'm i interpreting this all
> right...
>
> How would you suggest fix this?

I would tend to say it is a bug in the routing selection code. UML2 switches 
the route because it compare thes "negative" TQ message of seqno N with a TQ 
of seqno N - x. I suggest the following fix:

If we receive a TQ value via a neighbor that is smaller than the previous TQ 
that we received via that neighbor we don't change the route to a neighbor 
which did not send us the same or newer seqno.

That way your scenario should not happen because uml2 would not switch. On the 
other hand if uml1 really has a better route uml2 would switch as soon as the 
packet with a new seqno via uml1 arrives. What do you think ?

I attached a patch that should do exactly that. As I'm travelling right now 
I'm not able to test it before next week. If you find the time to do so, please 
let me know about your findings. This patch is not as strict as it could be. It 
might be necessary to rework it as soon as the concept has been proven.

Thanks again for this thorough analysis. Let us know if you find more.  :-)

Regards,
Marek



--Boundary-00=_2OdbKKKCpiQN9mh
Content-Type: text/x-patch;
  charset="UTF-8";
  name="premature-route-change.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="premature-route-change.patch"

 batman-adv-kernelland/routing.c |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/batman-adv-kernelland/routing.c b/batman-adv-kernelland/routing.c
index b576f8c..cb9f0ea 100644
--- a/batman-adv-kernelland/routing.c
+++ b/batman-adv-kernelland/routing.c
@@ -271,7 +271,7 @@ static int isBidirectionalNeigh(struct orig_node *orig_node, struct orig_node *o
 static void update_orig(struct orig_node *orig_node, struct ethhdr *ethhdr, struct batman_packet *batman_packet, struct batman_if *if_incoming, unsigned char *hna_buff, int hna_buff_len, char is_duplicate)
 {
 	struct neigh_node *neigh_node = NULL, *tmp_neigh_node = NULL, *best_neigh_node = NULL;
-	unsigned char max_tq = 0, max_bcast_own = 0;
+	unsigned char max_tq = 0, max_bcast_own = 0, tq_avg_old;
 	int tmp_hna_buff_len;
 
 	debug_log(LOG_TYPE_BATMAN, "update_originator(): Searching and updating originator entry of received packet \n");
@@ -306,6 +306,7 @@ static void update_orig(struct orig_node *orig_node, struct ethhdr *ethhdr, stru
 	neigh_node->last_valid = jiffies;
 
 	ring_buffer_set(neigh_node->tq_recv, &neigh_node->tq_index, batman_packet->tq);
+	tq_avg_old = neigh_node->tq_avg;
 	neigh_node->tq_avg = ring_buffer_avg(neigh_node->tq_recv);
 
 	if (!is_duplicate) {
@@ -323,6 +324,22 @@ static void update_orig(struct orig_node *orig_node, struct ethhdr *ethhdr, stru
 
 	tmp_hna_buff_len = (hna_buff_len > batman_packet->num_hna * ETH_ALEN ? batman_packet->num_hna * ETH_ALEN : hna_buff_len);
 
+	/**
+	 * if the neighbor that sent us this packet is our current best next
+	 * hop but delivers a TQ that is worse than the previous one we have
+	 * have to make sure that the alternative route already knows about the
+	 * changed TQ otherwise we risk a (temporary) loop
+	 * in case our alternative route does not know about his change we
+	 * stick with our current route
+	 */
+	if ((orig_node->router == neigh_node) &&
+	    (neigh_node != best_neigh_node) &&
+	    (tq_avg_old > neigh_node->tq_avg) &&
+	    (!get_bit_status(best_neigh_node->real_bits,
+	                     orig_node->last_real_seqno,
+	                     batman_packet->seqno)))
+		best_neigh_node = neigh_node;
+
 	update_routes(orig_node, best_neigh_node, hna_buff, tmp_hna_buff_len);
 }
 

--Boundary-00=_2OdbKKKCpiQN9mh--

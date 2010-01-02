Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Sat,  2 Jan 2010 11:30:40 +0100
Message-Id: <1262428252-26439-5-git-send-email-andrew@lunn.ch>
In-Reply-To: <1262428252-26439-4-git-send-email-andrew@lunn.ch>
References: <1262428252-26439-1-git-send-email-andrew@lunn.ch>
	<1262428252-26439-2-git-send-email-andrew@lunn.ch>
	<1262428252-26439-3-git-send-email-andrew@lunn.ch>
	<1262428252-26439-4-git-send-email-andrew@lunn.ch>
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 05/17] Staging: batman-adv: consistent
	spelling of "neighbors"
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
To: gregkh@suse.de
Cc: b.a.t.m.a.n@lists.open-mesh.net, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

From: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

we have written "neighbors", "neighbours" and bad spelled versions of this
word, this patch should make it consistent.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/staging/batman-adv/originator.c |   12 ++++++------
 drivers/staging/batman-adv/packet.h     |    2 +-
 drivers/staging/batman-adv/proc.c       |    2 +-
 drivers/staging/batman-adv/routing.c    |   10 +++++-----
 drivers/staging/batman-adv/types.h      |    2 +-
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/batman-adv/originator.c b/drivers/staging/batman-adv/originator.c
index 9ac8da3..f2b295b 100644
--- a/drivers/staging/batman-adv/originator.c
+++ b/drivers/staging/batman-adv/originator.c
@@ -74,7 +74,7 @@ create_neighbor(struct orig_node *orig_node, struct orig_node *orig_neigh_node,
 {
 	struct neigh_node *neigh_node;
 
-	bat_dbg(DBG_BATMAN, "Creating new last-hop neighbour of originator\n");
+	bat_dbg(DBG_BATMAN, "Creating new last-hop neighbor of originator\n");
 
 	neigh_node = kmalloc(sizeof(struct neigh_node), GFP_ATOMIC);
 	memset(neigh_node, 0, sizeof(struct neigh_node));
@@ -94,7 +94,7 @@ void free_orig_node(void *data)
 	struct neigh_node *neigh_node;
 	struct orig_node *orig_node = (struct orig_node *)data;
 
-	/* for all neighbours towards this originator ... */
+	/* for all neighbors towards this originator ... */
 	list_for_each_safe(list_pos, list_pos_tmp, &orig_node->neigh_list) {
 		neigh_node = list_entry(list_pos, struct neigh_node, list);
 
@@ -159,7 +159,7 @@ struct orig_node *get_orig_node(uint8_t *addr)
 	return orig_node;
 }
 
-static bool purge_orig_neigbours(struct orig_node *orig_node,
+static bool purge_orig_neighbors(struct orig_node *orig_node,
 				 struct neigh_node **best_neigh_node)
 {
 	struct list_head *list_pos, *list_pos_tmp;
@@ -170,7 +170,7 @@ static bool purge_orig_neigbours(struct orig_node *orig_node,
 	*best_neigh_node = NULL;
 
 
-	/* for all neighbours towards this originator ... */
+	/* for all neighbors towards this originator ... */
 	list_for_each_safe(list_pos, list_pos_tmp, &orig_node->neigh_list) {
 		neigh_node = list_entry(list_pos, struct neigh_node, list);
 
@@ -180,7 +180,7 @@ static bool purge_orig_neigbours(struct orig_node *orig_node,
 
 			addr_to_string(neigh_str, neigh_node->addr);
 			addr_to_string(orig_str, orig_node->orig);
-			bat_dbg(DBG_BATMAN, "Neighbour timeout: originator %s, neighbour: %s, last_valid %lu\n", orig_str, neigh_str, (neigh_node->last_valid / HZ));
+			bat_dbg(DBG_BATMAN, "neighbor timeout: originator %s, neighbor: %s, last_valid %lu\n", orig_str, neigh_str, (neigh_node->last_valid / HZ));
 
 			neigh_purged = true;
 			list_del(list_pos);
@@ -211,7 +211,7 @@ static bool purge_orig_node(struct orig_node *orig_node)
 			orig_str, (orig_node->last_valid / HZ));
 		return true;
 	} else {
-		if (purge_orig_neigbours(orig_node, &best_neigh_node))
+		if (purge_orig_neighbors(orig_node, &best_neigh_node))
 			update_routes(orig_node, best_neigh_node,
 				      orig_node->hna_buff,
 				      orig_node->hna_buff_len);
diff --git a/drivers/staging/batman-adv/packet.h b/drivers/staging/batman-adv/packet.h
index 5627ca3..ad006ce 100644
--- a/drivers/staging/batman-adv/packet.h
+++ b/drivers/staging/batman-adv/packet.h
@@ -90,7 +90,7 @@ struct vis_packet {
 	uint8_t  entries;	 /* number of entries behind this struct */
 	uint8_t  ttl;		 /* TTL */
 	uint8_t  vis_orig[6];	 /* originator that informs about its
-				  * neighbours */
+				  * neighbors */
 	uint8_t  target_orig[6]; /* who should receive this packet */
 	uint8_t  sender_orig[6]; /* who sent or rebroadcasted this packet */
 } __attribute__((packed));
diff --git a/drivers/staging/batman-adv/proc.c b/drivers/staging/batman-adv/proc.c
index f693a0e..22471ee 100644
--- a/drivers/staging/batman-adv/proc.c
+++ b/drivers/staging/batman-adv/proc.c
@@ -404,7 +404,7 @@ static void proc_vis_read_entry(struct seq_file *seq,
 				   from, to, int_part, frac_part);
 		} else {
 			seq_printf(seq,
-				   "%s\t{ router : \"%s\", neighbour : \"%s\", label : %d.%d }",
+				   "%s\t{ router : \"%s\", neighbor : \"%s\", label : %d.%d }",
 				   (first_line ? "" : ",\n"), from, to, int_part, frac_part);
 		}
 	}
diff --git a/drivers/staging/batman-adv/routing.c b/drivers/staging/batman-adv/routing.c
index 89d7faa..adde460 100644
--- a/drivers/staging/batman-adv/routing.c
+++ b/drivers/staging/batman-adv/routing.c
@@ -266,7 +266,7 @@ static void update_orig(struct orig_node *orig_node, struct ethhdr *ethhdr,
 					     ethhdr->h_source, if_incoming);
 	else
 		bat_dbg(DBG_BATMAN,
-			"Updating existing last-hop neighbour of originator\n");
+			"Updating existing last-hop neighbor of originator\n");
 
 	orig_node->flags = batman_packet->flags;
 	neigh_node->last_valid = jiffies;
@@ -444,7 +444,7 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 
 		orig_neigh_node = get_orig_node(ethhdr->h_source);
 
-		/* neighbour has to indicate direct link and it has to
+		/* neighbor has to indicate direct link and it has to
 		 * come via the corresponding interface */
 		/* if received seqno equals last send seqno save new
 		 * seqno for bidirectional check */
@@ -459,7 +459,7 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 				bit_packet_count(word);
 		}
 
-		bat_dbg(DBG_BATMAN, "Drop packet: originator packet from myself (via neighbour) \n");
+		bat_dbg(DBG_BATMAN, "Drop packet: originator packet from myself (via neighbor) \n");
 		return;
 	}
 
@@ -520,14 +520,14 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 		update_orig(orig_node, ethhdr, batman_packet,
 			    if_incoming, hna_buff, hna_buff_len, is_duplicate);
 
-	/* is single hop (direct) neighbour */
+	/* is single hop (direct) neighbor */
 	if (is_single_hop_neigh) {
 
 		/* mark direct link on incoming interface */
 		schedule_forward_packet(orig_node, ethhdr, batman_packet,
 					1, hna_buff_len, if_incoming);
 
-		bat_dbg(DBG_BATMAN, "Forwarding packet: rebroadcast neighbour packet with direct link flag\n");
+		bat_dbg(DBG_BATMAN, "Forwarding packet: rebroadcast neighbor packet with direct link flag\n");
 		return;
 	}
 
diff --git a/drivers/staging/batman-adv/types.h b/drivers/staging/batman-adv/types.h
index 3a0ef0c..9739358 100644
--- a/drivers/staging/batman-adv/types.h
+++ b/drivers/staging/batman-adv/types.h
@@ -75,7 +75,7 @@ struct neigh_node {
 	uint8_t tq_index;
 	uint8_t tq_avg;
 	uint8_t last_ttl;
-	unsigned long last_valid;            /* when last packet via this neighbour was received */
+	unsigned long last_valid;            /* when last packet via this neighbor was received */
 	TYPE_OF_WORD real_bits[NUM_WORDS];
 	struct orig_node *orig_node;
 	struct batman_if *if_incoming;
-- 
1.6.5.7


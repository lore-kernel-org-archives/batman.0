Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 27 Apr 2011 23:35:04 +0200
Message-Id: <1303940106-1457-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1303940106-1457-1-git-send-email-ordex@autistici.org>
References: <1303940106-1457-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/4] batman-adv: improved client announcement
	mechanism
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
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

The old HNA mechanism has been totally rewritten from scratch.
The new mechanism consists in announcing local translation-table changes
only, reducing the protocol overhead.

For details, please visit:
http://www.open-mesh.org/wiki/batman-adv/Hna-improvements

Moreover:
- COMPAT_VERSION has been increased to 14
- batman-adv now depends on module "crc16" for tt crc computation

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 aggregation.c       |   23 +-
 aggregation.h       |    6 +-
 hard-interface.c    |   13 +-
 main.c              |   13 +-
 main.h              |   10 +-
 originator.c        |    8 +-
 packet.h            |   34 ++-
 routing.c           |  237 +++++++++--
 routing.h           |   10 +-
 send.c              |   90 +++-
 send.h              |    2 +-
 soft-interface.c    |   11 +-
 translation-table.c | 1151 ++++++++++++++++++++++++++++++++++++++++++---------
 translation-table.h |   39 ++-
 types.h             |   38 ++-
 unicast.c           |    3 +
 16 files changed, 1374 insertions(+), 314 deletions(-)

diff --git a/aggregation.c b/aggregation.c
index 9b94590..de59b5f 100644
--- a/aggregation.c
+++ b/aggregation.c
@@ -20,16 +20,11 @@
  */
 
 #include "main.h"
+#include "translation-table.h"
 #include "aggregation.h"
 #include "send.h"
 #include "routing.h"
 
-/* calculate the size of the tt information for a given packet */
-static int tt_len(struct batman_packet *batman_packet)
-{
-	return batman_packet->num_tt * ETH_ALEN;
-}
-
 /* return true if new_packet can be aggregated with forw_packet */
 static bool can_aggregate_with(struct batman_packet *new_batman_packet,
 			       int packet_len,
@@ -255,18 +250,20 @@ void receive_aggr_bat_packet(struct ethhdr *ethhdr, unsigned char *packet_buff,
 	batman_packet = (struct batman_packet *)packet_buff;
 
 	do {
-		/* network to host order for our 32bit seqno, and the
-		   orig_interval. */
+		/* network to host order for our 32bit seqno and the
+		   orig_interval */
 		batman_packet->seqno = ntohl(batman_packet->seqno);
+		batman_packet->tt_crc = ntohs(batman_packet->tt_crc);
 
 		tt_buff = packet_buff + buff_pos + BAT_PACKET_LEN;
-		receive_bat_packet(ethhdr, batman_packet,
-				   tt_buff, tt_len(batman_packet),
-				   if_incoming);
 
-		buff_pos += BAT_PACKET_LEN + tt_len(batman_packet);
+		receive_bat_packet(ethhdr, batman_packet, tt_buff, if_incoming);
+
+		buff_pos += BAT_PACKET_LEN +
+			tt_len(batman_packet->tt_num_changes);
+
 		batman_packet = (struct batman_packet *)
 			(packet_buff + buff_pos);
 	} while (aggregated_packet(buff_pos, packet_len,
-				   batman_packet->num_tt));
+				   batman_packet->tt_num_changes));
 }
diff --git a/aggregation.h b/aggregation.h
index 7e6d72f..c631a4c 100644
--- a/aggregation.h
+++ b/aggregation.h
@@ -25,9 +25,11 @@
 #include "main.h"
 
 /* is there another aggregated packet here? */
-static inline int aggregated_packet(int buff_pos, int packet_len, int num_tt)
+static inline int aggregated_packet(int buff_pos, int packet_len,
+				    int tt_num_changes)
 {
-	int next_buff_pos = buff_pos + BAT_PACKET_LEN + (num_tt * ETH_ALEN);
+	int next_buff_pos = buff_pos + BAT_PACKET_LEN + (tt_num_changes *
+						sizeof(struct tt_change));
 
 	return (next_buff_pos <= packet_len) &&
 		(next_buff_pos <= MAX_AGGREGATION_BYTES);
diff --git a/hard-interface.c b/hard-interface.c
index 9e4ac7d..2a7c533 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -156,12 +156,6 @@ static void primary_if_select(struct bat_priv *bat_priv,
 
 	primary_if_update_addr(bat_priv);
 
-	/***
-	 * hacky trick to make sure that we send the TT information via
-	 * our new primary interface
-	 */
-	atomic_set(&bat_priv->tt_local_changed, 1);
-
 out:
 	spin_unlock_bh(&hardif_list_lock);
 }
@@ -345,7 +339,8 @@ int hardif_enable_interface(struct hard_iface *hard_iface, char *iface_name)
 	batman_packet->flags = 0;
 	batman_packet->ttl = 2;
 	batman_packet->tq = TQ_MAX_VALUE;
-	batman_packet->num_tt = 0;
+	batman_packet->tt_num_changes = 0;
+	batman_packet->tt_ver_num = 0;
 
 	hard_iface->if_num = bat_priv->num_ifaces;
 	bat_priv->num_ifaces++;
@@ -674,6 +669,10 @@ static int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	case BAT_VIS:
 		ret = recv_vis_packet(skb, hard_iface);
 		break;
+		/* Translation table query (request or response) */
+	case BAT_TT_QUERY:
+		ret = recv_tt_query(skb, hard_iface);
+		break;
 	default:
 		ret = NET_RX_DROP;
 	}
diff --git a/main.c b/main.c
index 2970908..a84679a 100644
--- a/main.c
+++ b/main.c
@@ -83,6 +83,9 @@ int mesh_init(struct net_device *soft_iface)
 	spin_lock_init(&bat_priv->forw_bcast_list_lock);
 	spin_lock_init(&bat_priv->tt_lhash_lock);
 	spin_lock_init(&bat_priv->tt_ghash_lock);
+	spin_lock_init(&bat_priv->tt_changes_list_lock);
+	spin_lock_init(&bat_priv->tt_req_list_lock);
+	spin_lock_init(&bat_priv->tt_buff_lock);
 	spin_lock_init(&bat_priv->gw_list_lock);
 	spin_lock_init(&bat_priv->vis_hash_lock);
 	spin_lock_init(&bat_priv->vis_list_lock);
@@ -92,14 +95,13 @@ int mesh_init(struct net_device *soft_iface)
 	INIT_HLIST_HEAD(&bat_priv->forw_bcast_list);
 	INIT_HLIST_HEAD(&bat_priv->gw_list);
 	INIT_HLIST_HEAD(&bat_priv->softif_neigh_list);
+	INIT_LIST_HEAD(&bat_priv->tt_changes_list);
+	INIT_LIST_HEAD(&bat_priv->tt_req_list);
 
 	if (originator_init(bat_priv) < 1)
 		goto err;
 
-	if (tt_local_init(bat_priv) < 1)
-		goto err;
-
-	if (tt_global_init(bat_priv) < 1)
+	if (tt_init(bat_priv) < 1)
 		goto err;
 
 	tt_local_add(soft_iface, soft_iface->dev_addr);
@@ -133,8 +135,7 @@ void mesh_free(struct net_device *soft_iface)
 	gw_node_purge(bat_priv);
 	originator_free(bat_priv);
 
-	tt_local_free(bat_priv);
-	tt_global_free(bat_priv);
+	tt_free(bat_priv);
 
 	softif_neigh_purge(bat_priv);
 
diff --git a/main.h b/main.h
index 50eb819..cc1c277 100644
--- a/main.h
+++ b/main.h
@@ -39,8 +39,8 @@
 #define PURGE_TIMEOUT 200	/* purge originators after time in seconds if no
 				   * valid packet comes in -> TODO: check
 				   * influence on TQ_LOCAL_WINDOW_SIZE */
-#define TT_LOCAL_TIMEOUT 3600 /* in seconds */
-
+#define TT_LOCAL_TIMEOUT 3600	/* in seconds */
+#define TT_REQUEST_TIMEOUT 3	/* seconds we have to keep pending tt_req */
 #define TQ_LOCAL_WINDOW_SIZE 64	  /* sliding packet range of received originator
 				   * messages in squence numbers (should be a
 				   * multiple of our word size) */
@@ -49,6 +49,12 @@
 #define TQ_LOCAL_BIDRECT_RECV_MINIMUM 1
 #define TQ_TOTAL_BIDRECT_LIMIT 1
 
+#define TT_OGM_APPEND_MAX 3 /* number of OGMs sent with the last tt diff */
+
+/* Transtable operations */
+#define TT_ADD 0
+#define TT_DEL 1
+
 #define NUM_WORDS (TQ_LOCAL_WINDOW_SIZE / WORD_BIT_SIZE)
 
 #define LOG_BUF_LEN 8192	  /* has to be a power of 2 */
diff --git a/originator.c b/originator.c
index 0314875..be7257b 100644
--- a/originator.c
+++ b/originator.c
@@ -147,6 +147,7 @@ static void orig_node_free_rcu(struct rcu_head *rcu)
 	tt_global_del_orig(orig_node->bat_priv, orig_node,
 			    "originator timed out");
 
+	kfree(orig_node->tt_buff);
 	kfree(orig_node->bcast_own);
 	kfree(orig_node->bcast_own_sum);
 	kfree(orig_node);
@@ -215,6 +216,7 @@ struct orig_node *get_orig_node(struct bat_priv *bat_priv, uint8_t *addr)
 	spin_lock_init(&orig_node->ogm_cnt_lock);
 	spin_lock_init(&orig_node->bcast_seqno_lock);
 	spin_lock_init(&orig_node->neigh_list_lock);
+	spin_lock_init(&orig_node->tt_buff_lock);
 
 	/* extra reference for return */
 	atomic_set(&orig_node->refcount, 2);
@@ -223,6 +225,8 @@ struct orig_node *get_orig_node(struct bat_priv *bat_priv, uint8_t *addr)
 	memcpy(orig_node->orig, addr, ETH_ALEN);
 	orig_node->router = NULL;
 	orig_node->tt_buff = NULL;
+	orig_node->tt_buff_len = 0;
+	atomic_set(&orig_node->tt_size, 0);
 	orig_node->bcast_seqno_reset = jiffies - 1
 					- msecs_to_jiffies(RESET_PROTECTION_MS);
 	orig_node->batman_seqno_reset = jiffies - 1
@@ -332,9 +336,7 @@ static bool purge_orig_node(struct bat_priv *bat_priv,
 		if (purge_orig_neighbors(bat_priv, orig_node,
 							&best_neigh_node)) {
 			update_routes(bat_priv, orig_node,
-				      best_neigh_node,
-				      orig_node->tt_buff,
-				      orig_node->tt_buff_len);
+				      best_neigh_node);
 		}
 	}
 
diff --git a/packet.h b/packet.h
index c225c3a..34a2775 100644
--- a/packet.h
+++ b/packet.h
@@ -30,9 +30,10 @@
 #define BAT_BCAST        0x04
 #define BAT_VIS          0x05
 #define BAT_UNICAST_FRAG 0x06
+#define BAT_TT_QUERY	 0x07
 
 /* this file is included by batctl which needs these defines */
-#define COMPAT_VERSION 12
+#define COMPAT_VERSION 14
 #define DIRECTLINK 0x40
 #define VIS_SERVER 0x20
 #define PRIMARIES_FIRST_HOP 0x10
@@ -52,6 +53,11 @@
 #define UNI_FRAG_HEAD 0x01
 #define UNI_FRAG_LARGETAIL 0x02
 
+/* TT flags */
+#define TT_RESPONSE	0x00
+#define TT_REQUEST	0x01
+#define TT_FULL_TABLE	0x02
+
 struct batman_packet {
 	uint8_t  packet_type;
 	uint8_t  version;  /* batman version field */
@@ -61,7 +67,9 @@ struct batman_packet {
 	uint8_t  orig[6];
 	uint8_t  prev_sender[6];
 	uint8_t  ttl;
-	uint8_t  num_tt;
+	uint8_t  tt_ver_num;
+	uint16_t tt_crc;
+	uint8_t  tt_num_changes;
 	uint8_t  gw_flags;  /* flags related to gateway class */
 	uint8_t  align;
 } __packed;
@@ -101,6 +109,7 @@ struct unicast_packet {
 	uint8_t  version;  /* batman version field */
 	uint8_t  dest[6];
 	uint8_t  ttl;
+	uint8_t  ttvn; /* destination ttvn */
 } __packed;
 
 struct unicast_frag_packet {
@@ -134,4 +143,25 @@ struct vis_packet {
 	uint8_t  sender_orig[6]; /* who sent or rebroadcasted this packet */
 } __packed;
 
+struct tt_query_packet {
+	uint8_t  packet_type;
+	uint8_t  version;  /* batman version field */
+	uint8_t  dst[6];
+	uint8_t  ttl;
+	uint8_t  flags;		/* bit0: 0: -> tt_request
+				 *	 1: -> tt_response
+				 * bit1: request the full table
+				 */
+	uint8_t  src[6];
+	uint8_t  ttvn;		/* if tt_request: ttvn that triggered the
+				 *		  request
+				 * if tt_response: new ttvn for the src
+				 * orig_node
+				 */
+	uint16_t tt_data;	/* if tt_request: crc associated with the
+				 *		   ttvn
+				 * if tt_response: table_size
+				 */
+} __packed;
+
 #endif /* _NET_BATMAN_ADV_PACKET_H_ */
diff --git a/routing.c b/routing.c
index 91b3709..838394b 100644
--- a/routing.c
+++ b/routing.c
@@ -64,28 +64,68 @@ void slide_own_bcast_window(struct hard_iface *hard_iface)
 	}
 }
 
-static void update_TT(struct bat_priv *bat_priv, struct orig_node *orig_node,
-		       unsigned char *tt_buff, int tt_buff_len)
+static void update_transtable(struct bat_priv *bat_priv,
+			      struct orig_node *orig_node,
+			      unsigned char *tt_buff, uint8_t tt_num_changes,
+			      uint8_t ttvn, uint16_t tt_crc)
 {
-	if ((tt_buff_len != orig_node->tt_buff_len) ||
-	    ((tt_buff_len > 0) &&
-	     (orig_node->tt_buff_len > 0) &&
-	     (memcmp(orig_node->tt_buff, tt_buff, tt_buff_len) != 0))) {
-
-		if (orig_node->tt_buff_len > 0)
-			tt_global_del_orig(bat_priv, orig_node,
-					    "originator changed tt");
-
-		if ((tt_buff_len > 0) && (tt_buff))
-			tt_global_add_orig(bat_priv, orig_node,
-					    tt_buff, tt_buff_len);
+	struct tt_change *tt_change;
+	int count;
+	uint8_t orig_ttvn = (uint8_t)atomic_read(&orig_node->last_tt_ver_num);
+
+	/* the ttvn increased by one -> we can apply the attached changes */
+	if (ttvn - orig_ttvn == 1) {
+		/* if it does not contain the changes send a tt request */
+		if (!tt_num_changes)
+			goto request_table;
+
+		for (count = 0; count < tt_num_changes; count++) {
+			tt_change = (struct tt_change *) tt_buff + count;
+			/* Check for the change op */
+			if (tt_change->op == TT_DEL)
+				tt_global_del(bat_priv, orig_node,
+					      tt_change->addr,
+					      "tt remotely removed");
+			else
+				if (!tt_global_add(bat_priv, orig_node,
+							tt_change->addr,
+							ttvn))
+					/* In case of problem while storing a
+					 * global_entry, we stop the updating
+					 * procedure without committing the
+					 * ttvn change. This will avoid to send
+					 * corrupted data on tt_request
+					 */
+					return;
+		}
+		/* Let's save the buffer (if any) */
+		tt_save_orig_buffer(bat_priv, orig_node,
+				    tt_buff, tt_num_changes);
+
+		atomic_set(&orig_node->last_tt_ver_num, ttvn);
+
+		/* Even if we received the crc into the OGM, we prefer
+		 * to recompute it to spot any possible inconsistency
+		 * in the global table */
+		orig_node->tt_crc = tt_global_crc(bat_priv, orig_node);
+	} else {
+		/* if we missed more than one change or our tables are not
+		 * in sync anymore -> request fresh tt data */
+		if (ttvn != orig_ttvn || orig_node->tt_crc != tt_crc) {
+request_table:
+			bat_dbg(DBG_ROUTES, bat_priv, "TT changes missing "
+				"for %pM. Need to retrieve last OGM buffer\n",
+				orig_node->orig);
+			send_tt_request(bat_priv, orig_node, ttvn, tt_crc,
+					true);
+			return;
+		}
 	}
 }
 
 static void update_route(struct bat_priv *bat_priv,
 			 struct orig_node *orig_node,
-			 struct neigh_node *neigh_node,
-			 unsigned char *tt_buff, int tt_buff_len)
+			 struct neigh_node *neigh_node)
 {
 	struct neigh_node *curr_router;
 
@@ -93,7 +133,6 @@ static void update_route(struct bat_priv *bat_priv,
 
 	/* route deleted */
 	if ((curr_router) && (!neigh_node)) {
-
 		bat_dbg(DBG_ROUTES, bat_priv, "Deleting route towards: %pM\n",
 			orig_node->orig);
 		tt_global_del_orig(bat_priv, orig_node,
@@ -105,9 +144,6 @@ static void update_route(struct bat_priv *bat_priv,
 		bat_dbg(DBG_ROUTES, bat_priv,
 			"Adding route towards: %pM (via %pM)\n",
 			orig_node->orig, neigh_node->addr);
-		tt_global_add_orig(bat_priv, orig_node,
-				    tt_buff, tt_buff_len);
-
 	/* route changed */
 	} else {
 		bat_dbg(DBG_ROUTES, bat_priv,
@@ -135,8 +171,7 @@ static void update_route(struct bat_priv *bat_priv,
 
 
 void update_routes(struct bat_priv *bat_priv, struct orig_node *orig_node,
-		   struct neigh_node *neigh_node, unsigned char *tt_buff,
-		   int tt_buff_len)
+		   struct neigh_node *neigh_node)
 {
 	struct neigh_node *router = NULL;
 
@@ -146,11 +181,7 @@ void update_routes(struct bat_priv *bat_priv, struct orig_node *orig_node,
 	router = orig_node_get_router(orig_node);
 
 	if (router != neigh_node)
-		update_route(bat_priv, orig_node, neigh_node,
-			     tt_buff, tt_buff_len);
-	/* may be just TT changed */
-	else
-		update_TT(bat_priv, orig_node, tt_buff, tt_buff_len);
+		update_route(bat_priv, orig_node, neigh_node);
 
 out:
 	if (router)
@@ -387,14 +418,12 @@ static void update_orig(struct bat_priv *bat_priv,
 			struct ethhdr *ethhdr,
 			struct batman_packet *batman_packet,
 			struct hard_iface *if_incoming,
-			unsigned char *tt_buff, int tt_buff_len,
-			char is_duplicate)
+			unsigned char *tt_buff, char is_duplicate)
 {
 	struct neigh_node *neigh_node = NULL, *tmp_neigh_node = NULL;
 	struct neigh_node *router = NULL;
 	struct orig_node *orig_node_tmp;
 	struct hlist_node *node;
-	int tmp_tt_buff_len;
 	uint8_t bcast_own_sum_orig, bcast_own_sum_neigh;
 
 	bat_dbg(DBG_BATMAN, bat_priv, "update_originator(): "
@@ -459,9 +488,6 @@ static void update_orig(struct bat_priv *bat_priv,
 
 	bonding_candidate_add(orig_node, neigh_node);
 
-	tmp_tt_buff_len = (tt_buff_len > batman_packet->num_tt * ETH_ALEN ?
-			    batman_packet->num_tt * ETH_ALEN : tt_buff_len);
-
 	/* if this neighbor already is our next hop there is nothing
 	 * to change */
 	router = orig_node_get_router(orig_node);
@@ -491,15 +517,19 @@ static void update_orig(struct bat_priv *bat_priv,
 			goto update_tt;
 	}
 
-	update_routes(bat_priv, orig_node, neigh_node,
-		      tt_buff, tmp_tt_buff_len);
-	goto update_gw;
+	update_routes(bat_priv, orig_node, neigh_node);
 
 update_tt:
-	update_routes(bat_priv, orig_node, router,
-		      tt_buff, tmp_tt_buff_len);
+	/* I have to check for transtable changes only if the OGM has been
+	 * sent through a primary interface */
+	if (((batman_packet->orig != ethhdr->h_source) &&
+				(batman_packet->ttl > 2)) ||
+				(batman_packet->flags & PRIMARIES_FIRST_HOP))
+		update_transtable(bat_priv, orig_node, tt_buff,
+				  batman_packet->tt_num_changes,
+				  batman_packet->tt_ver_num,
+				  batman_packet->tt_crc);
 
-update_gw:
 	if (orig_node->gw_flags != batman_packet->gw_flags)
 		gw_node_update(bat_priv, orig_node, batman_packet->gw_flags);
 
@@ -621,7 +651,7 @@ out:
 
 void receive_bat_packet(struct ethhdr *ethhdr,
 			struct batman_packet *batman_packet,
-			unsigned char *tt_buff, int tt_buff_len,
+			unsigned char *tt_buff,
 			struct hard_iface *if_incoming)
 {
 	struct bat_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
@@ -660,12 +690,14 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 
 	bat_dbg(DBG_BATMAN, bat_priv,
 		"Received BATMAN packet via NB: %pM, IF: %s [%pM] "
-		"(from OG: %pM, via prev OG: %pM, seqno %d, tq %d, "
-		"TTL %d, V %d, IDF %d)\n",
+		"(from OG: %pM, via prev OG: %pM, seqno %d, ttvn %u, "
+		"crc %u, changes %u, td %d, TTL %d, V %d, IDF %d)\n",
 		ethhdr->h_source, if_incoming->net_dev->name,
 		if_incoming->net_dev->dev_addr, batman_packet->orig,
 		batman_packet->prev_sender, batman_packet->seqno,
-		batman_packet->tq, batman_packet->ttl, batman_packet->version,
+		batman_packet->tt_ver_num, batman_packet->tt_crc,
+		batman_packet->tt_num_changes, batman_packet->tq,
+		batman_packet->ttl, batman_packet->version,
 		has_directlink_flag);
 
 	rcu_read_lock();
@@ -818,14 +850,14 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	     ((orig_node->last_real_seqno == batman_packet->seqno) &&
 	      (orig_node->last_ttl - 3 <= batman_packet->ttl))))
 		update_orig(bat_priv, orig_node, ethhdr, batman_packet,
-			    if_incoming, tt_buff, tt_buff_len, is_duplicate);
+			    if_incoming, tt_buff, is_duplicate);
 
 	/* is single hop (direct) neighbor */
 	if (is_single_hop_neigh) {
 
 		/* mark direct link on incoming interface */
 		schedule_forward_packet(orig_node, ethhdr, batman_packet,
-					1, tt_buff_len, if_incoming);
+					1, if_incoming);
 
 		bat_dbg(DBG_BATMAN, bat_priv, "Forwarding packet: "
 			"rebroadcast neighbor packet with direct link flag\n");
@@ -848,7 +880,7 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	bat_dbg(DBG_BATMAN, bat_priv,
 		"Forwarding packet: rebroadcast originator packet\n");
 	schedule_forward_packet(orig_node, ethhdr, batman_packet,
-				0, tt_buff_len, if_incoming);
+				0, if_incoming);
 
 out_neigh:
 	if ((orig_neigh_node) && (!is_single_hop_neigh))
@@ -1195,6 +1227,69 @@ static struct neigh_node *find_ifalter_router(struct orig_node *primary_orig,
 	return router;
 }
 
+int recv_tt_query(struct sk_buff *skb, struct hard_iface *recv_if)
+{
+	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
+	struct tt_query_packet *tt_query;
+	struct ethhdr *ethhdr;
+	int ret = NET_RX_DROP;
+
+	/* drop packet if it has not necessary minimum size */
+	if (unlikely(!pskb_may_pull(skb, sizeof(struct tt_query_packet))))
+		goto out;
+
+	/* I could need to modify it */
+	if (skb_cow(skb, sizeof(struct tt_query_packet)) < 0)
+		goto out;
+
+	ethhdr = (struct ethhdr *)skb_mac_header(skb);
+
+	/* packet with unicast indication but broadcast recipient */
+	if (is_broadcast_ether_addr(ethhdr->h_dest))
+		goto out;
+
+	/* packet with broadcast sender address */
+	if (is_broadcast_ether_addr(ethhdr->h_source))
+		goto out;
+
+	tt_query = (struct tt_query_packet *)skb->data;
+
+	tt_query->tt_data = ntohs(tt_query->tt_data);
+
+	if (tt_query->flags & TT_REQUEST) {
+		/* Try to reply to this tt_request */
+		ret = send_tt_response(bat_priv, tt_query);
+		if (ret != NET_RX_SUCCESS) {
+			bat_dbg(DBG_ROUTES, bat_priv,
+				"Routing TT_REQUEST to %pM [%c]\n",
+				tt_query->dst,
+				(tt_query->flags & TT_FULL_TABLE ? 'F' : '.'));
+			tt_query->tt_data = htons(tt_query->tt_data);
+			return route_unicast_packet(skb, recv_if);
+		}
+		goto out;
+	}
+	/* We need to linearize the packet to access the TT data */
+	if (skb_linearize(skb) < 0)
+		goto out;
+
+	if (is_my_mac(tt_query->dst))
+		handle_tt_response(bat_priv, tt_query);
+	else {
+		bat_dbg(DBG_ROUTES, bat_priv,
+			"Routing TT_RESPONSE to %pM [%c]\n",
+			tt_query->dst,
+			(tt_query->flags & TT_FULL_TABLE ? 'F' : '.'));
+		tt_query->tt_data = htons(tt_query->tt_data);
+		return route_unicast_packet(skb, recv_if);
+	}
+	ret = NET_RX_SUCCESS;
+
+out:
+	kfree_skb(skb);
+	return ret;
+}
+
 /* find a suitable router for this originator, and use
  * bonding if possible. increases the found neighbors
  * refcount.*/
@@ -1376,14 +1471,64 @@ out:
 
 int recv_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 {
+	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	struct unicast_packet *unicast_packet;
 	int hdr_size = sizeof(struct unicast_packet);
+	struct orig_node *orig_node;
+	struct ethhdr *ethhdr;
+	uint8_t curr_ttvn;
+	int16_t diff;
 
 	if (check_unicast_packet(skb, hdr_size) < 0)
 		return NET_RX_DROP;
 
 	unicast_packet = (struct unicast_packet *)skb->data;
 
+	if (is_my_mac(unicast_packet->dest))
+		curr_ttvn = (uint8_t)atomic_read(&bat_priv->tt_ver_num);
+	else {
+		orig_node = orig_hash_find(bat_priv, unicast_packet->dest);
+
+		if (!orig_node)
+			return NET_RX_DROP;
+
+		curr_ttvn = (uint8_t)atomic_read(&orig_node->last_tt_ver_num);
+		orig_node_free_ref(orig_node);
+	}
+
+	diff = unicast_packet->ttvn - curr_ttvn;
+	/* Check whether I have to reroute the packet */
+	if (unicast_packet->packet_type == BAT_UNICAST &&
+	    (diff < 0 && diff > -0xff/2)) {
+		/* Linearize the skb before accessing it */
+		if (skb_linearize(skb) < 0)
+			return NET_RX_DROP;
+
+		ethhdr = (struct ethhdr *)(skb->data +
+			sizeof(struct unicast_packet));
+
+		orig_node = transtable_search(bat_priv, ethhdr->h_dest);
+
+		if (!orig_node) {
+			if (!is_my_client(bat_priv, ethhdr->h_dest))
+				return NET_RX_DROP;
+			memcpy(unicast_packet->dest,
+			       bat_priv->primary_if->net_dev->dev_addr,
+			       ETH_ALEN);
+		} else {
+			memcpy(unicast_packet->dest, orig_node->orig,
+			       ETH_ALEN);
+			curr_ttvn = (uint8_t)
+				atomic_read(&orig_node->last_tt_ver_num);
+			orig_node_free_ref(orig_node);
+		}
+
+		unicast_packet->ttvn = curr_ttvn;
+
+		bat_dbg(DBG_ROUTES, bat_priv, "HVN mismatch! "
+			"Rerouting unicast packet (for %pM) to %pM\n",
+			ethhdr->h_dest, unicast_packet->dest);
+	}
 	/* packet for me */
 	if (is_my_mac(unicast_packet->dest)) {
 		interface_rx(recv_if->soft_iface, skb, recv_if, hdr_size);
diff --git a/routing.h b/routing.h
index 870f298..6f6a5f8 100644
--- a/routing.h
+++ b/routing.h
@@ -24,12 +24,11 @@
 
 void slide_own_bcast_window(struct hard_iface *hard_iface);
 void receive_bat_packet(struct ethhdr *ethhdr,
-				struct batman_packet *batman_packet,
-				unsigned char *tt_buff, int tt_buff_len,
-				struct hard_iface *if_incoming);
+			struct batman_packet *batman_packet,
+			unsigned char *tt_buff,
+			struct hard_iface *if_incoming);
 void update_routes(struct bat_priv *bat_priv, struct orig_node *orig_node,
-		   struct neigh_node *neigh_node, unsigned char *tt_buff,
-		   int tt_buff_len);
+		   struct neigh_node *neigh_node);
 int route_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if);
 int recv_icmp_packet(struct sk_buff *skb, struct hard_iface *recv_if);
 int recv_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if);
@@ -37,6 +36,7 @@ int recv_ucast_frag_packet(struct sk_buff *skb, struct hard_iface *recv_if);
 int recv_bcast_packet(struct sk_buff *skb, struct hard_iface *recv_if);
 int recv_vis_packet(struct sk_buff *skb, struct hard_iface *recv_if);
 int recv_bat_packet(struct sk_buff *skb, struct hard_iface *recv_if);
+int recv_tt_query(struct sk_buff *skb, struct hard_iface *recv_if);
 struct neigh_node *find_router(struct bat_priv *bat_priv,
 			       struct orig_node *orig_node,
 			       struct hard_iface *recv_if);
diff --git a/send.c b/send.c
index f30d0c6..f85913e 100644
--- a/send.c
+++ b/send.c
@@ -121,7 +121,7 @@ static void send_packet_to_if(struct forw_packet *forw_packet,
 	/* adjust all flags and log packets */
 	while (aggregated_packet(buff_pos,
 				 forw_packet->packet_len,
-				 batman_packet->num_tt)) {
+				 batman_packet->tt_num_changes)) {
 
 		/* we might have aggregated direct link packets with an
 		 * ordinary base packet */
@@ -136,17 +136,18 @@ static void send_packet_to_if(struct forw_packet *forw_packet,
 							    "Forwarding"));
 		bat_dbg(DBG_BATMAN, bat_priv,
 			"%s %spacket (originator %pM, seqno %d, TQ %d, TTL %d,"
-			" IDF %s) on interface %s [%pM]\n",
+			" IDF %s, hvn %d) on interface %s [%pM]\n",
 			fwd_str, (packet_num > 0 ? "aggregated " : ""),
 			batman_packet->orig, ntohl(batman_packet->seqno),
 			batman_packet->tq, batman_packet->ttl,
 			(batman_packet->flags & DIRECTLINK ?
 			 "on" : "off"),
+			batman_packet->tt_ver_num,
 			hard_iface->net_dev->name,
-			hard_iface->net_dev->dev_addr);
+				hard_iface->net_dev->dev_addr);
 
 		buff_pos += sizeof(struct batman_packet) +
-			(batman_packet->num_tt * ETH_ALEN);
+			tt_len(batman_packet->tt_num_changes);
 		packet_num++;
 		batman_packet = (struct batman_packet *)
 			(forw_packet->skb->data + buff_pos);
@@ -214,26 +215,17 @@ static void send_packet(struct forw_packet *forw_packet)
 	rcu_read_unlock();
 }
 
-static void rebuild_batman_packet(struct bat_priv *bat_priv,
-				  struct hard_iface *hard_iface)
+static void realloc_packet_buffer(struct hard_iface *hard_iface,
+				int new_len)
 {
-	int new_len;
 	unsigned char *new_buff;
-	struct batman_packet *batman_packet;
 
-	new_len = sizeof(struct batman_packet) +
-			(bat_priv->num_local_tt * ETH_ALEN);
 	new_buff = kmalloc(new_len, GFP_ATOMIC);
 
 	/* keep old buffer if kmalloc should fail */
 	if (new_buff) {
 		memcpy(new_buff, hard_iface->packet_buff,
 		       sizeof(struct batman_packet));
-		batman_packet = (struct batman_packet *)new_buff;
-
-		batman_packet->num_tt = tt_local_fill_buffer(bat_priv,
-				new_buff + sizeof(struct batman_packet),
-				new_len - sizeof(struct batman_packet));
 
 		kfree(hard_iface->packet_buff);
 		hard_iface->packet_buff = new_buff;
@@ -241,6 +233,45 @@ static void rebuild_batman_packet(struct bat_priv *bat_priv,
 	}
 }
 
+static void prepare_packet_buffer(struct bat_priv *bat_priv,
+				  struct hard_iface *hard_iface)
+{
+	int new_len;
+	struct batman_packet *batman_packet;
+
+	new_len = BAT_PACKET_LEN +
+		  tt_len((uint8_t)atomic_read(&bat_priv->tt_local_changes));
+
+	/* if we have too many changes for one packet don't send any
+	 * and wait for the tt table request which will be fragmented */
+	if (new_len > bat_priv->primary_if->soft_iface->mtu)
+		new_len = BAT_PACKET_LEN;
+
+	realloc_packet_buffer(hard_iface, new_len);
+	batman_packet = (struct batman_packet *)hard_iface->packet_buff;
+
+	atomic_set(&bat_priv->tt_crc, tt_local_crc(bat_priv));
+
+	/* reset the sending counter */
+	atomic_set(&bat_priv->tt_ogm_append_cnt, TT_OGM_APPEND_MAX);
+
+	batman_packet->tt_num_changes = tt_changes_fill_buffer(bat_priv,
+				hard_iface->packet_buff + BAT_PACKET_LEN,
+				hard_iface->packet_len - BAT_PACKET_LEN);
+
+}
+
+static void reset_packet_buffer(struct bat_priv *bat_priv,
+	struct hard_iface *hard_iface)
+{
+	struct batman_packet *batman_packet;
+
+	realloc_packet_buffer(hard_iface, BAT_PACKET_LEN);
+
+	batman_packet = (struct batman_packet *)hard_iface->packet_buff;
+	batman_packet->tt_num_changes = 0;
+}
+
 void schedule_own_packet(struct hard_iface *hard_iface)
 {
 	struct bat_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
@@ -266,14 +297,22 @@ void schedule_own_packet(struct hard_iface *hard_iface)
 	if (hard_iface->if_status == IF_TO_BE_ACTIVATED)
 		hard_iface->if_status = IF_ACTIVE;
 
-	/* if local tt has changed and interface is a primary interface */
-	if ((atomic_read(&bat_priv->tt_local_changed)) &&
-	    (hard_iface == primary_if))
-		rebuild_batman_packet(bat_priv, hard_iface);
+	if (hard_iface == primary_if) {
+		/* if at least one change happened */
+		if (atomic_read(&bat_priv->tt_local_changes) > 0) {
+			prepare_packet_buffer(bat_priv, hard_iface);
+			/* Increment the TTVN only once per OGM interval */
+			atomic_inc(&bat_priv->tt_ver_num);
+		}
+
+		/* if the changes have been sent enough times */
+		if (!atomic_dec_not_zero(&bat_priv->tt_ogm_append_cnt))
+			reset_packet_buffer(bat_priv, hard_iface);
+	}
 
 	/**
 	 * NOTE: packet_buff might just have been re-allocated in
-	 * rebuild_batman_packet()
+	 * prepare_packet_buffer() or in reset_packet_buffer()
 	 */
 	batman_packet = (struct batman_packet *)hard_iface->packet_buff;
 
@@ -281,6 +320,9 @@ void schedule_own_packet(struct hard_iface *hard_iface)
 	batman_packet->seqno =
 		htonl((uint32_t)atomic_read(&hard_iface->seqno));
 
+	batman_packet->tt_ver_num = atomic_read(&bat_priv->tt_ver_num);
+	batman_packet->tt_crc = htons((uint16_t)atomic_read(&bat_priv->tt_crc));
+
 	if (vis_server == VIS_TYPE_SERVER_SYNC)
 		batman_packet->flags |= VIS_SERVER;
 	else
@@ -309,13 +351,14 @@ void schedule_own_packet(struct hard_iface *hard_iface)
 void schedule_forward_packet(struct orig_node *orig_node,
 			     struct ethhdr *ethhdr,
 			     struct batman_packet *batman_packet,
-			     uint8_t directlink, int tt_buff_len,
+			     uint8_t directlink,
 			     struct hard_iface *if_incoming)
 {
 	struct bat_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct neigh_node *router;
 	unsigned char in_tq, in_ttl, tq_avg = 0;
 	unsigned long send_time;
+	uint8_t tt_num_changes;
 
 	if (batman_packet->ttl <= 1) {
 		bat_dbg(DBG_BATMAN, bat_priv, "ttl exceeded\n");
@@ -326,6 +369,7 @@ void schedule_forward_packet(struct orig_node *orig_node,
 
 	in_tq = batman_packet->tq;
 	in_ttl = batman_packet->ttl;
+	tt_num_changes = batman_packet->tt_num_changes;
 
 	batman_packet->ttl--;
 	memcpy(batman_packet->prev_sender, ethhdr->h_source, ETH_ALEN);
@@ -358,6 +402,7 @@ void schedule_forward_packet(struct orig_node *orig_node,
 		batman_packet->ttl);
 
 	batman_packet->seqno = htonl(batman_packet->seqno);
+	batman_packet->tt_crc = htons(batman_packet->tt_crc);
 
 	/* switch of primaries first hop flag when forwarding */
 	batman_packet->flags &= ~PRIMARIES_FIRST_HOP;
@@ -369,7 +414,8 @@ void schedule_forward_packet(struct orig_node *orig_node,
 	send_time = forward_send_time();
 	add_bat_packet_to_list(bat_priv,
 			       (unsigned char *)batman_packet,
-			       sizeof(struct batman_packet) + tt_buff_len,
+			       sizeof(struct batman_packet) +
+			       tt_len(tt_num_changes),
 			       if_incoming, 0, send_time);
 }
 
diff --git a/send.h b/send.h
index 247172d..842f4d1 100644
--- a/send.h
+++ b/send.h
@@ -29,7 +29,7 @@ void schedule_own_packet(struct hard_iface *hard_iface);
 void schedule_forward_packet(struct orig_node *orig_node,
 			     struct ethhdr *ethhdr,
 			     struct batman_packet *batman_packet,
-			     uint8_t directlink, int tt_buff_len,
+			     uint8_t directlink,
 			     struct hard_iface *if_outgoing);
 int add_bcast_packet_to_list(struct bat_priv *bat_priv, struct sk_buff *skb);
 void send_outstanding_bat_packet(struct work_struct *work);
diff --git a/soft-interface.c b/soft-interface.c
index 89a940a..fedb1ed 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -366,7 +366,7 @@ static int interface_set_mac_addr(struct net_device *dev, void *p)
 	/* only modify tt-table if it has been initialised before */
 	if (atomic_read(&bat_priv->mesh_state) == MESH_ACTIVE) {
 		tt_local_remove(bat_priv, dev->dev_addr,
-				 "mac address changed");
+				"mac address changed");
 		tt_local_add(dev, addr->sa_data);
 	}
 
@@ -424,7 +424,7 @@ int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 	if ((curr_softif_neigh) && (curr_softif_neigh->vid == vid))
 		goto dropped;
 
-	/* TODO: check this for locks */
+	/* Register the client MAC in the transtable */
 	tt_local_add(soft_iface, ethhdr->h_source);
 
 	if (is_multicast_ether_addr(ethhdr->h_dest)) {
@@ -663,7 +663,12 @@ struct net_device *softif_create(char *name)
 
 	atomic_set(&bat_priv->mesh_state, MESH_INACTIVE);
 	atomic_set(&bat_priv->bcast_seqno, 1);
-	atomic_set(&bat_priv->tt_local_changed, 0);
+	atomic_set(&bat_priv->tt_ver_num, 0);
+	atomic_set(&bat_priv->tt_local_changes, 0);
+	atomic_set(&bat_priv->tt_ogm_append_cnt, 0);
+
+	bat_priv->tt_buff = NULL;
+	bat_priv->tt_buff_len = 0;
 
 	bat_priv->primary_if = NULL;
 	bat_priv->num_ifaces = 0;
diff --git a/translation-table.c b/translation-table.c
index 25e6939..d55eeb5 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -23,13 +23,17 @@
 #include "translation-table.h"
 #include "soft-interface.h"
 #include "hard-interface.h"
+#include "send.h"
 #include "hash.h"
 #include "originator.h"
+#include "routing.h"
 
-static void tt_local_purge(struct work_struct *work);
-static void _tt_global_del_orig(struct bat_priv *bat_priv,
-				 struct tt_global_entry *tt_global_entry,
-				 char *message);
+#include <linux/crc16.h>
+
+static void _tt_global_del(struct bat_priv *bat_priv,
+			   struct tt_global_entry *tt_global_entry,
+			   char *message);
+static void tt_purge(struct work_struct *work);
 
 /* returns 1 if they are the same mac addr */
 static int compare_ltt(struct hlist_node *node, void *data2)
@@ -47,14 +51,15 @@ static int compare_gtt(struct hlist_node *node, void *data2)
 	return (memcmp(data1, data2, ETH_ALEN) == 0 ? 1 : 0);
 }
 
-static void tt_local_start_timer(struct bat_priv *bat_priv)
+static void tt_start_timer(struct bat_priv *bat_priv)
 {
-	INIT_DELAYED_WORK(&bat_priv->tt_work, tt_local_purge);
-	queue_delayed_work(bat_event_workqueue, &bat_priv->tt_work, 10 * HZ);
+	INIT_DELAYED_WORK(&bat_priv->tt_work, tt_purge);
+	queue_delayed_work(bat_event_workqueue, &bat_priv->tt_work,
+			   msecs_to_jiffies(5000));
 }
 
 static struct tt_local_entry *tt_local_hash_find(struct bat_priv *bat_priv,
-						   void *data)
+						 void *data)
 {
 	struct hashtable_t *hash = bat_priv->tt_local_hash;
 	struct hlist_head *head;
@@ -82,7 +87,7 @@ static struct tt_local_entry *tt_local_hash_find(struct bat_priv *bat_priv,
 }
 
 static struct tt_global_entry *tt_global_hash_find(struct bat_priv *bat_priv,
-						     void *data)
+						   void *data)
 {
 	struct hashtable_t *hash = bat_priv->tt_global_hash;
 	struct hlist_head *head;
@@ -110,7 +115,42 @@ static struct tt_global_entry *tt_global_hash_find(struct bat_priv *bat_priv,
 	return tt_global_entry_tmp;
 }
 
-int tt_local_init(struct bat_priv *bat_priv)
+static bool is_out_of_time(unsigned long starting_time, unsigned long timeout)
+{
+	unsigned long deadline;
+	deadline = starting_time + msecs_to_jiffies(timeout);
+
+	return time_after(jiffies, deadline);
+}
+
+static void tt_local_event(struct bat_priv *bat_priv, uint8_t op, uint8_t *addr)
+{
+	struct tt_change_node *tt_change_node;
+
+	tt_change_node = (struct tt_change_node *)
+		kmalloc(sizeof(struct tt_change_node), GFP_ATOMIC);
+
+	if (!tt_change_node)
+		return;
+
+	tt_change_node->change.op = op;
+	memcpy(tt_change_node->change.addr, addr, ETH_ALEN);
+
+	spin_lock_bh(&bat_priv->tt_changes_list_lock);
+	/* track the change in the OGMinterval list */
+	list_add_tail(&tt_change_node->list, &bat_priv->tt_changes_list);
+	atomic_inc(&bat_priv->tt_local_changes);
+	spin_unlock_bh(&bat_priv->tt_changes_list_lock);
+
+	atomic_set(&bat_priv->tt_ogm_append_cnt, 0);
+}
+
+int tt_len(int changes_num)
+{
+	return changes_num * sizeof(struct tt_change);
+}
+
+static int tt_local_init(struct bat_priv *bat_priv)
 {
 	if (bat_priv->tt_local_hash)
 		return 1;
@@ -120,9 +160,6 @@ int tt_local_init(struct bat_priv *bat_priv)
 	if (!bat_priv->tt_local_hash)
 		return 0;
 
-	atomic_set(&bat_priv->tt_local_changed, 0);
-	tt_local_start_timer(bat_priv);
-
 	return 1;
 }
 
@@ -131,40 +168,24 @@ void tt_local_add(struct net_device *soft_iface, uint8_t *addr)
 	struct bat_priv *bat_priv = netdev_priv(soft_iface);
 	struct tt_local_entry *tt_local_entry;
 	struct tt_global_entry *tt_global_entry;
-	int required_bytes;
 
 	spin_lock_bh(&bat_priv->tt_lhash_lock);
 	tt_local_entry = tt_local_hash_find(bat_priv, addr);
-	spin_unlock_bh(&bat_priv->tt_lhash_lock);
 
 	if (tt_local_entry) {
 		tt_local_entry->last_seen = jiffies;
-		return;
+		goto unlock;
 	}
 
-	/* only announce as many hosts as possible in the batman-packet and
-	   space in batman_packet->num_tt That also should give a limit to
-	   MAC-flooding. */
-	required_bytes = (bat_priv->num_local_tt + 1) * ETH_ALEN;
-	required_bytes += BAT_PACKET_LEN;
-
-	if ((required_bytes > ETH_DATA_LEN) ||
-	    (atomic_read(&bat_priv->aggregated_ogms) &&
-	     required_bytes > MAX_AGGREGATION_BYTES) ||
-	    (bat_priv->num_local_tt + 1 > 255)) {
-		bat_dbg(DBG_ROUTES, bat_priv,
-			"Can't add new local tt entry (%pM): "
-			"number of local tt entries exceeds packet size\n",
-			addr);
-		return;
-	}
-
-	bat_dbg(DBG_ROUTES, bat_priv,
-		"Creating new local tt entry: %pM\n", addr);
-
 	tt_local_entry = kmalloc(sizeof(struct tt_local_entry), GFP_ATOMIC);
 	if (!tt_local_entry)
-		return;
+		goto unlock;
+
+	tt_local_event(bat_priv, TT_ADD, addr);
+
+	bat_dbg(DBG_ROUTES, bat_priv,
+		"Creating new local tt entry: %pM (ttvn: %d\n", addr,
+		(uint8_t)atomic_read(&bat_priv->tt_ver_num));
 
 	memcpy(tt_local_entry->addr, addr, ETH_ALEN);
 	tt_local_entry->last_seen = jiffies;
@@ -175,13 +196,9 @@ void tt_local_add(struct net_device *soft_iface, uint8_t *addr)
 	else
 		tt_local_entry->never_purge = 0;
 
-	spin_lock_bh(&bat_priv->tt_lhash_lock);
-
 	hash_add(bat_priv->tt_local_hash, compare_ltt, choose_orig,
 		 tt_local_entry, &tt_local_entry->hash_entry);
-	bat_priv->num_local_tt++;
-	atomic_set(&bat_priv->tt_local_changed, 1);
-
+	atomic_inc(&bat_priv->num_local_tt);
 	spin_unlock_bh(&bat_priv->tt_lhash_lock);
 
 	/* remove address from global hash if present */
@@ -190,46 +207,60 @@ void tt_local_add(struct net_device *soft_iface, uint8_t *addr)
 	tt_global_entry = tt_global_hash_find(bat_priv, addr);
 
 	if (tt_global_entry)
-		_tt_global_del_orig(bat_priv, tt_global_entry,
-				     "local tt received");
+		_tt_global_del(bat_priv, tt_global_entry,
+			       "local tt received");
 
 	spin_unlock_bh(&bat_priv->tt_ghash_lock);
+
+unlock:
+	spin_unlock_bh(&bat_priv->tt_lhash_lock);
 }
 
-int tt_local_fill_buffer(struct bat_priv *bat_priv,
-			  unsigned char *buff, int buff_len)
+int tt_changes_fill_buffer(struct bat_priv *bat_priv,
+			   unsigned char *buff, int buff_len)
 {
-	struct hashtable_t *hash = bat_priv->tt_local_hash;
-	struct tt_local_entry *tt_local_entry;
-	struct hlist_node *node;
-	struct hlist_head *head;
-	int i, count = 0;
+	int count = 0, tot_changes = 0;
+	struct tt_change_node *entry, *safe;
 
-	spin_lock_bh(&bat_priv->tt_lhash_lock);
+	if (buff_len > 0)
+		tot_changes = buff_len / tt_len(1);
 
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
-
-		rcu_read_lock();
-		hlist_for_each_entry_rcu(tt_local_entry, node,
-					 head, hash_entry) {
-			if (buff_len < (count + 1) * ETH_ALEN)
-				break;
-
-			memcpy(buff + (count * ETH_ALEN), tt_local_entry->addr,
-			       ETH_ALEN);
+	spin_lock_bh(&bat_priv->tt_changes_list_lock);
+	atomic_set(&bat_priv->tt_local_changes, 0);
 
+	list_for_each_entry_safe(entry, safe, &bat_priv->tt_changes_list,
+			list) {
+		if (count < tot_changes) {
+			memcpy(buff + tt_len(count),
+			       &entry->change, sizeof(struct tt_change));
 			count++;
 		}
-		rcu_read_unlock();
+		list_del(&entry->list);
+		kfree(entry);
 	}
+	spin_unlock_bh(&bat_priv->tt_changes_list_lock);
 
-	/* if we did not get all new local tts see you next time  ;-) */
-	if (count == bat_priv->num_local_tt)
-		atomic_set(&bat_priv->tt_local_changed, 0);
+	/* Keep the buffer for possible tt_request */
+	spin_lock_bh(&bat_priv->tt_buff_lock);
+	kfree(bat_priv->tt_buff);
+	bat_priv->tt_buff_len = 0;
+	bat_priv->tt_buff = NULL;
+	/* We check whether this new OGM has no changes due to size
+	 * problems */
+	if (buff_len > 0) {
+		/**
+		 * if kmalloc() fails we will reply with the full table
+		 * instead of providing the diff
+		 */
+		bat_priv->tt_buff = kmalloc(buff_len, GFP_ATOMIC);
+		if (bat_priv->tt_buff) {
+			memcpy(bat_priv->tt_buff, buff, buff_len);
+			bat_priv->tt_buff_len = buff_len;
+		}
+	}
+	spin_unlock_bh(&bat_priv->tt_buff_lock);
 
-	spin_unlock_bh(&bat_priv->tt_lhash_lock);
-	return count;
+	return tot_changes;
 }
 
 int tt_local_seq_print_text(struct seq_file *seq, void *offset)
@@ -261,8 +292,8 @@ int tt_local_seq_print_text(struct seq_file *seq, void *offset)
 	}
 
 	seq_printf(seq, "Locally retrieved addresses (from %s) "
-		   "announced via TT:\n",
-		   net_dev->name);
+		   "announced via TT (TTVN: %u):\n",
+		   net_dev->name, (uint8_t)atomic_read(&bat_priv->tt_ver_num));
 
 	spin_lock_bh(&bat_priv->tt_lhash_lock);
 
@@ -309,54 +340,50 @@ out:
 	return ret;
 }
 
-static void _tt_local_del(struct hlist_node *node, void *arg)
+static void tt_local_entry_free(struct hlist_node *node, void *arg)
 {
 	struct bat_priv *bat_priv = (struct bat_priv *)arg;
 	void *data = container_of(node, struct tt_local_entry, hash_entry);
 
 	kfree(data);
-	bat_priv->num_local_tt--;
-	atomic_set(&bat_priv->tt_local_changed, 1);
+	atomic_dec(&bat_priv->num_local_tt);
 }
 
 static void tt_local_del(struct bat_priv *bat_priv,
-			  struct tt_local_entry *tt_local_entry,
-			  char *message)
+			 struct tt_local_entry *tt_local_entry,
+			 char *message)
 {
 	bat_dbg(DBG_ROUTES, bat_priv, "Deleting local tt entry (%pM): %s\n",
 		tt_local_entry->addr, message);
 
+	atomic_dec(&bat_priv->num_local_tt);
+
 	hash_remove(bat_priv->tt_local_hash, compare_ltt, choose_orig,
 		    tt_local_entry->addr);
-	_tt_local_del(&tt_local_entry->hash_entry, bat_priv);
+
+	tt_local_entry_free(&tt_local_entry->hash_entry, bat_priv);
 }
 
-void tt_local_remove(struct bat_priv *bat_priv,
-		      uint8_t *addr, char *message)
+void tt_local_remove(struct bat_priv *bat_priv, uint8_t *addr, char *message)
 {
 	struct tt_local_entry *tt_local_entry;
 
 	spin_lock_bh(&bat_priv->tt_lhash_lock);
-
 	tt_local_entry = tt_local_hash_find(bat_priv, addr);
 
-	if (tt_local_entry)
+	if (tt_local_entry) {
+		tt_local_event(bat_priv, TT_DEL, tt_local_entry->addr);
 		tt_local_del(bat_priv, tt_local_entry, message);
-
+	}
 	spin_unlock_bh(&bat_priv->tt_lhash_lock);
 }
 
-static void tt_local_purge(struct work_struct *work)
+static void tt_local_purge(struct bat_priv *bat_priv)
 {
-	struct delayed_work *delayed_work =
-		container_of(work, struct delayed_work, work);
-	struct bat_priv *bat_priv =
-		container_of(delayed_work, struct bat_priv, tt_work);
 	struct hashtable_t *hash = bat_priv->tt_local_hash;
 	struct tt_local_entry *tt_local_entry;
 	struct hlist_node *node, *node_tmp;
 	struct hlist_head *head;
-	unsigned long timeout;
 	int i;
 
 	spin_lock_bh(&bat_priv->tt_lhash_lock);
@@ -369,32 +396,52 @@ static void tt_local_purge(struct work_struct *work)
 			if (tt_local_entry->never_purge)
 				continue;
 
-			timeout = tt_local_entry->last_seen;
-			timeout += TT_LOCAL_TIMEOUT * HZ;
-
-			if (time_before(jiffies, timeout))
+			if (!is_out_of_time(tt_local_entry->last_seen,
+					   TT_LOCAL_TIMEOUT * 1000))
 				continue;
 
+			tt_local_event(bat_priv, TT_DEL, tt_local_entry->addr);
 			tt_local_del(bat_priv, tt_local_entry,
-				      "address timed out");
+				     "address timed out");
 		}
 	}
 
 	spin_unlock_bh(&bat_priv->tt_lhash_lock);
-	tt_local_start_timer(bat_priv);
 }
 
-void tt_local_free(struct bat_priv *bat_priv)
+static void tt_local_table_free(struct bat_priv *bat_priv)
 {
+	struct hashtable_t *hash;
+	int i;
+	spinlock_t *list_lock;
+	struct hlist_head *head;
+	struct hlist_node *node, *node_tmp;
+	struct tt_local_entry *tt_local_entry;
+
 	if (!bat_priv->tt_local_hash)
 		return;
 
-	cancel_delayed_work_sync(&bat_priv->tt_work);
-	hash_delete(bat_priv->tt_local_hash, _tt_local_del, bat_priv);
+	hash = bat_priv->tt_local_hash;
+
+	for (i = 0; i < hash->size; i++) {
+		head = &hash->table[i];
+		list_lock = &hash->list_locks[i];
+
+		spin_lock_bh(list_lock);
+		hlist_for_each_entry_safe(tt_local_entry, node, node_tmp,
+					  head, hash_entry) {
+			hlist_del_rcu(node);
+			kfree(tt_local_entry);
+		}
+		spin_unlock_bh(list_lock);
+	}
+
+	hash_destroy(hash);
+
 	bat_priv->tt_local_hash = NULL;
 }
 
-int tt_global_init(struct bat_priv *bat_priv)
+static int tt_global_init(struct bat_priv *bat_priv)
 {
 	if (bat_priv->tt_global_hash)
 		return 1;
@@ -407,74 +454,79 @@ int tt_global_init(struct bat_priv *bat_priv)
 	return 1;
 }
 
-void tt_global_add_orig(struct bat_priv *bat_priv,
-			 struct orig_node *orig_node,
-			 unsigned char *tt_buff, int tt_buff_len)
+static void tt_changes_list_free(struct bat_priv *bat_priv)
+{
+	struct tt_change_node *entry, *safe;
+
+	spin_lock_bh(&bat_priv->tt_changes_list_lock);
+
+	list_for_each_entry_safe(entry, safe, &bat_priv->tt_changes_list,
+				 list) {
+		list_del(&entry->list);
+		kfree(entry);
+	}
+
+	atomic_set(&bat_priv->tt_local_changes, 0);
+	spin_unlock_bh(&bat_priv->tt_changes_list_lock);
+}
+
+/* caller must hold orig_node recount */
+int tt_global_add(struct bat_priv *bat_priv,
+		  struct orig_node *orig_node,
+		  unsigned char *tt_addr, uint8_t ttvn)
 {
 	struct tt_global_entry *tt_global_entry;
 	struct tt_local_entry *tt_local_entry;
-	int tt_buff_count = 0;
-	unsigned char *tt_ptr;
-
-	while ((tt_buff_count + 1) * ETH_ALEN <= tt_buff_len) {
-		spin_lock_bh(&bat_priv->tt_ghash_lock);
-
-		tt_ptr = tt_buff + (tt_buff_count * ETH_ALEN);
-		tt_global_entry = tt_global_hash_find(bat_priv, tt_ptr);
-
-		if (!tt_global_entry) {
-			spin_unlock_bh(&bat_priv->tt_ghash_lock);
-
-			tt_global_entry =
-				kmalloc(sizeof(struct tt_global_entry),
-					GFP_ATOMIC);
-
-			if (!tt_global_entry)
-				break;
-
-			memcpy(tt_global_entry->addr, tt_ptr, ETH_ALEN);
-
-			bat_dbg(DBG_ROUTES, bat_priv,
-				"Creating new global tt entry: "
-				"%pM (via %pM)\n",
-				tt_global_entry->addr, orig_node->orig);
-
-			spin_lock_bh(&bat_priv->tt_ghash_lock);
-			hash_add(bat_priv->tt_global_hash, compare_gtt,
-				 choose_orig, tt_global_entry,
-				 &tt_global_entry->hash_entry);
-
-		}
-
+	struct orig_node *orig_node_tmp;
+
+	spin_lock_bh(&bat_priv->tt_ghash_lock);
+	tt_global_entry = tt_global_hash_find(bat_priv, tt_addr);
+
+	if (!tt_global_entry) {
+		tt_global_entry =
+			kmalloc(sizeof(struct tt_global_entry),
+				GFP_ATOMIC);
+		if (!tt_global_entry)
+			goto unlock;
+		memcpy(tt_global_entry->addr, tt_addr, ETH_ALEN);
+		/* Assign the new orig_node */
+		atomic_inc(&orig_node->refcount);
 		tt_global_entry->orig_node = orig_node;
-		spin_unlock_bh(&bat_priv->tt_ghash_lock);
-
-		/* remove address from local hash if present */
-		spin_lock_bh(&bat_priv->tt_lhash_lock);
-
-		tt_ptr = tt_buff + (tt_buff_count * ETH_ALEN);
-		tt_local_entry = tt_local_hash_find(bat_priv, tt_ptr);
-
-		if (tt_local_entry)
-			tt_local_del(bat_priv, tt_local_entry,
-				      "global tt received");
-
-		spin_unlock_bh(&bat_priv->tt_lhash_lock);
-
-		tt_buff_count++;
-	}
-
-	/* initialize, and overwrite if malloc succeeds */
-	orig_node->tt_buff = NULL;
-	orig_node->tt_buff_len = 0;
-
-	if (tt_buff_len > 0) {
-		orig_node->tt_buff = kmalloc(tt_buff_len, GFP_ATOMIC);
-		if (orig_node->tt_buff) {
-			memcpy(orig_node->tt_buff, tt_buff, tt_buff_len);
-			orig_node->tt_buff_len = tt_buff_len;
+		tt_global_entry->ttvn = ttvn;
+		atomic_inc(&orig_node->tt_size);
+		hash_add(bat_priv->tt_global_hash, compare_gtt,
+			 choose_orig, tt_global_entry,
+			 &tt_global_entry->hash_entry);
+	} else {
+		if (tt_global_entry->orig_node != orig_node) {
+			atomic_dec(&tt_global_entry->orig_node->tt_size);
+			orig_node_tmp = tt_global_entry->orig_node;
+			atomic_inc(&orig_node->refcount);
+			tt_global_entry->orig_node = orig_node;
+			tt_global_entry->ttvn = ttvn;
+			orig_node_free_ref(orig_node_tmp);
+			atomic_inc(&orig_node->tt_size);
 		}
 	}
+
+	spin_unlock_bh(&bat_priv->tt_ghash_lock);
+
+	bat_dbg(DBG_ROUTES, bat_priv,
+		"Creating new global tt entry: %pM (via %pM)\n",
+		tt_global_entry->addr, orig_node->orig);
+
+	/* remove address from local hash if present */
+	spin_lock_bh(&bat_priv->tt_lhash_lock);
+	tt_local_entry = tt_local_hash_find(bat_priv, tt_addr);
+
+	if (tt_local_entry)
+		tt_local_del(bat_priv, tt_local_entry,
+			     "global tt received");
+	spin_unlock_bh(&bat_priv->tt_lhash_lock);
+	return 1;
+unlock:
+	spin_unlock_bh(&bat_priv->tt_ghash_lock);
+	return 0;
 }
 
 int tt_global_seq_print_text(struct seq_file *seq, void *offset)
@@ -507,17 +559,20 @@ int tt_global_seq_print_text(struct seq_file *seq, void *offset)
 
 	seq_printf(seq, "Globally announced TTs received via the mesh %s\n",
 		   net_dev->name);
+	seq_printf(seq, "       %-13s %s       %-15s %s\n",
+		   "Client", "(TTVN)", "Originator", "(Curr TTVN)");
 
 	spin_lock_bh(&bat_priv->tt_ghash_lock);
 
 	buf_size = 1;
-	/* Estimate length for: " * xx:xx:xx:xx:xx:xx via xx:xx:xx:xx:xx:xx\n"*/
+	/* Estimate length for: " * xx:xx:xx:xx:xx:xx (ttvn) via
+	 * xx:xx:xx:xx:xx:xx (cur_ttvn)\n"*/
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
 
 		rcu_read_lock();
 		__hlist_for_each_rcu(node, head)
-			buf_size += 43;
+			buf_size += 59;
 		rcu_read_unlock();
 	}
 
@@ -536,10 +591,14 @@ int tt_global_seq_print_text(struct seq_file *seq, void *offset)
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(tt_global_entry, node,
 					 head, hash_entry) {
-			pos += snprintf(buff + pos, 44,
-					" * %pM via %pM\n",
+			pos += snprintf(buff + pos, 61,
+					" * %pM  (%3u) via %pM     (%3u)\n",
 					tt_global_entry->addr,
-					tt_global_entry->orig_node->orig);
+					tt_global_entry->ttvn,
+					tt_global_entry->orig_node->orig,
+					(uint8_t) atomic_read(
+						&tt_global_entry->orig_node->
+						last_tt_ver_num));
 		}
 		rcu_read_unlock();
 	}
@@ -554,64 +613,80 @@ out:
 	return ret;
 }
 
-static void _tt_global_del_orig(struct bat_priv *bat_priv,
-				 struct tt_global_entry *tt_global_entry,
-				 char *message)
+static void _tt_global_del(struct bat_priv *bat_priv,
+			   struct tt_global_entry *tt_global_entry,
+			   char *message)
 {
+	if (!tt_global_entry)
+		return;
+
 	bat_dbg(DBG_ROUTES, bat_priv,
 		"Deleting global tt entry %pM (via %pM): %s\n",
 		tt_global_entry->addr, tt_global_entry->orig_node->orig,
 		message);
 
+	atomic_dec(&tt_global_entry->orig_node->tt_size);
 	hash_remove(bat_priv->tt_global_hash, compare_gtt, choose_orig,
 		    tt_global_entry->addr);
 	kfree(tt_global_entry);
 }
 
+void tt_global_del(struct bat_priv *bat_priv,
+		   struct orig_node *orig_node,
+		   unsigned char *addr, char *message)
+{
+	struct tt_global_entry *tt_global_entry;
+
+	spin_lock_bh(&bat_priv->tt_ghash_lock);
+	tt_global_entry = tt_global_hash_find(bat_priv, addr);
+
+	if (tt_global_entry && tt_global_entry->orig_node == orig_node) {
+		atomic_dec(&orig_node->tt_size);
+		_tt_global_del(bat_priv, tt_global_entry, message);
+	}
+	spin_unlock_bh(&bat_priv->tt_ghash_lock);
+}
+
 void tt_global_del_orig(struct bat_priv *bat_priv,
-			 struct orig_node *orig_node, char *message)
+			struct orig_node *orig_node, char *message)
 {
 	struct tt_global_entry *tt_global_entry;
-	int tt_buff_count = 0;
-	unsigned char *tt_ptr;
+	int i;
+	struct hashtable_t *hash = bat_priv->tt_global_hash;
+	struct hlist_node *node, *safe;
+	struct hlist_head *head;
 
-	if (orig_node->tt_buff_len == 0)
+	if (!bat_priv->tt_global_hash)
 		return;
 
 	spin_lock_bh(&bat_priv->tt_ghash_lock);
+	for (i = 0; i < hash->size; i++) {
+		head = &hash->table[i];
 
-	while ((tt_buff_count + 1) * ETH_ALEN <= orig_node->tt_buff_len) {
-		tt_ptr = orig_node->tt_buff + (tt_buff_count * ETH_ALEN);
-		tt_global_entry = tt_global_hash_find(bat_priv, tt_ptr);
-
-		if ((tt_global_entry) &&
-		    (tt_global_entry->orig_node == orig_node))
-			_tt_global_del_orig(bat_priv, tt_global_entry,
-					     message);
-
-		tt_buff_count++;
+		hlist_for_each_entry_safe(tt_global_entry, node, safe,
+					 head, hash_entry) {
+			if (tt_global_entry->orig_node == orig_node)
+				_tt_global_del(bat_priv, tt_global_entry,
+					       message);
+		}
 	}
+	atomic_set(&orig_node->tt_size, 0);
 
 	spin_unlock_bh(&bat_priv->tt_ghash_lock);
-
-	orig_node->tt_buff_len = 0;
-	kfree(orig_node->tt_buff);
-	orig_node->tt_buff = NULL;
 }
 
-static void tt_global_del(struct hlist_node *node, void *arg)
+static void tt_global_entry_free(struct hlist_node *node, void *arg)
 {
 	void *data = container_of(node, struct tt_global_entry, hash_entry);
-
 	kfree(data);
 }
 
-void tt_global_free(struct bat_priv *bat_priv)
+static void tt_global_table_free(struct bat_priv *bat_priv)
 {
 	if (!bat_priv->tt_global_hash)
 		return;
 
-	hash_delete(bat_priv->tt_global_hash, tt_global_del, NULL);
+	hash_delete(bat_priv->tt_global_hash, tt_global_entry_free, NULL);
 	bat_priv->tt_global_hash = NULL;
 }
 
@@ -635,3 +710,699 @@ out:
 	spin_unlock_bh(&bat_priv->tt_ghash_lock);
 	return orig_node;
 }
+
+/* Calculates the checksum of the local table of a given orig_node */
+uint16_t tt_global_crc(struct bat_priv *bat_priv, struct orig_node *orig_node)
+{
+	uint16_t total = 0, total_one;
+	struct hashtable_t *hash = bat_priv->tt_global_hash;
+	struct tt_global_entry *tt_global_entry;
+	struct hlist_node *node;
+	struct hlist_head *head;
+	int i, j;
+
+	for (i = 0; i < hash->size; i++) {
+		head = &hash->table[i];
+
+		rcu_read_lock();
+		hlist_for_each_entry_rcu(tt_global_entry, node,
+					 head, hash_entry) {
+			if (compare_eth(tt_global_entry->orig_node,
+					orig_node)) {
+				total_one = 0;
+				for (j = 0; j < ETH_ALEN; j++)
+					total_one = crc16_byte(total_one,
+						tt_global_entry->addr[j]);
+				total ^= total_one;
+			}
+		}
+		rcu_read_unlock();
+	}
+
+	return total;
+}
+
+/* Calculates the checksum of the local table */
+uint16_t tt_local_crc(struct bat_priv *bat_priv)
+{
+	uint16_t total = 0, total_one;
+	struct hashtable_t *hash = bat_priv->tt_local_hash;
+	struct tt_local_entry *tt_local_entry;
+	struct hlist_node *node;
+	struct hlist_head *head;
+	int i, j;
+
+	for (i = 0; i < hash->size; i++) {
+		head = &hash->table[i];
+
+		rcu_read_lock();
+		hlist_for_each_entry_rcu(tt_local_entry, node,
+					 head, hash_entry) {
+			total_one = 0;
+			for (j = 0; j < ETH_ALEN; j++)
+				total_one = crc16_byte(total_one,
+						   tt_local_entry->addr[j]);
+			total ^= total_one;
+		}
+
+		rcu_read_unlock();
+	}
+
+	return total;
+}
+
+static void tt_req_list_free(struct bat_priv *bat_priv)
+{
+	struct tt_req_node *node, *safe;
+
+	spin_lock_bh(&bat_priv->tt_req_list_lock);
+
+	list_for_each_entry_safe(node, safe, &bat_priv->tt_req_list, list) {
+		list_del(&node->list);
+		kfree(node);
+	}
+
+	spin_unlock_bh(&bat_priv->tt_req_list_lock);
+}
+
+void tt_save_orig_buffer(struct bat_priv *bat_priv, struct orig_node *orig_node,
+			 unsigned char *tt_buff, uint8_t tt_num_changes)
+{
+	uint16_t tt_buff_len = tt_len(tt_num_changes);
+
+	/* Replace the old buffer only if I received something in the
+	 * last OGM (the OGM could carry no changes) */
+	spin_lock_bh(&orig_node->tt_buff_lock);
+	if (tt_buff_len > 0) {
+		kfree(orig_node->tt_buff);
+		orig_node->tt_buff_len = 0;
+		orig_node->tt_buff = kmalloc(tt_buff_len, GFP_ATOMIC);
+		if (orig_node->tt_buff) {
+			memcpy(orig_node->tt_buff, tt_buff, tt_buff_len);
+			orig_node->tt_buff_len = tt_buff_len;
+		}
+	}
+	spin_unlock_bh(&orig_node->tt_buff_lock);
+}
+
+static void tt_req_purge(struct bat_priv *bat_priv)
+{
+	struct tt_req_node *node, *safe;
+
+	spin_lock_bh(&bat_priv->tt_req_list_lock);
+	list_for_each_entry_safe(node, safe, &bat_priv->tt_req_list, list) {
+		if (is_out_of_time(node->issued_at,
+		    TT_REQUEST_TIMEOUT * 1000)) {
+			list_del(&node->list);
+			kfree(node);
+		}
+	}
+	spin_unlock_bh(&bat_priv->tt_req_list_lock);
+}
+
+int send_tt_request(struct bat_priv *bat_priv, struct orig_node *dst_orig_node,
+		    uint8_t ttvn, uint16_t tt_crc, bool full_table)
+{
+	struct sk_buff *skb;
+	struct tt_query_packet *tt_request;
+	struct neigh_node *neigh_node = NULL;
+	struct hard_iface *primary_if;
+	struct tt_req_node *tt_req_node = NULL;
+	int ret = 0;
+
+	primary_if = primary_if_get_selected(bat_priv);
+	if (!primary_if)
+		goto out;
+
+	spin_lock_bh(&bat_priv->tt_req_list_lock);
+	/* The new tt_req will be issued only if I'm not waiting for a
+	 * reply from the same orig_node yet */
+	list_for_each_entry(tt_req_node, &bat_priv->tt_req_list, list) {
+		if (compare_eth(tt_req_node, dst_orig_node) &&
+		    !is_out_of_time(tt_req_node->issued_at,
+				    TT_REQUEST_TIMEOUT * 1000))
+			goto unlock_tt;
+	}
+
+	tt_req_node = kmalloc(sizeof(struct tt_req_node), GFP_ATOMIC);
+	if (!tt_req_node) {
+		ret = 1;
+		goto unlock_tt;
+	}
+
+	memcpy(tt_req_node->addr, dst_orig_node->orig, ETH_ALEN);
+	tt_req_node->issued_at = jiffies;
+
+	list_add(&tt_req_node->list, &bat_priv->tt_req_list);
+	spin_unlock_bh(&bat_priv->tt_req_list_lock);
+
+	skb = dev_alloc_skb(sizeof(struct tt_query_packet) + ETH_HLEN);
+	if (!skb)
+		goto out;
+
+	skb_reserve(skb, ETH_HLEN);
+
+	tt_request = (struct tt_query_packet *)skb_put(skb,
+				sizeof(struct tt_query_packet));
+
+	tt_request->packet_type = BAT_TT_QUERY;
+	tt_request->version = COMPAT_VERSION;
+	memcpy(tt_request->src, primary_if->net_dev->dev_addr, ETH_ALEN);
+	memcpy(tt_request->dst, dst_orig_node->orig, ETH_ALEN);
+	tt_request->ttl = TTL;
+	tt_request->ttvn = ttvn;
+	tt_request->tt_data = tt_crc;
+	tt_request->flags = TT_REQUEST;
+
+	/* Request the full table if needed */
+	if (full_table)
+		tt_request->flags |= TT_FULL_TABLE;
+
+	neigh_node = find_router(bat_priv, dst_orig_node, NULL);
+	if (!neigh_node)
+		goto out;
+
+	if (neigh_node->if_incoming->if_status != IF_ACTIVE)
+		goto out;
+
+	bat_dbg(DBG_ROUTES, bat_priv, "Sending TT_REQUEST to %pM via %pM "
+		"[%c]\n", dst_orig_node->orig, neigh_node->addr,
+		(full_table ? 'F' : '.'));
+
+	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
+	ret = 0;
+
+out:
+	if (neigh_node)
+		neigh_node_free_ref(neigh_node);
+	if (primary_if)
+		hardif_free_ref(primary_if);
+	if (ret == 1) {
+		kfree_skb(skb);
+		spin_lock_bh(&bat_priv->tt_req_list_lock);
+		list_del(&tt_req_node->list);
+		spin_unlock_bh(&bat_priv->tt_req_list_lock);
+		kfree(tt_req_node);
+	}
+	return ret;
+unlock_tt:
+	spin_unlock_bh(&bat_priv->tt_req_list_lock);
+	return ret;
+}
+
+static int send_other_tt_response(struct bat_priv *bat_priv,
+				  struct tt_query_packet *tt_request)
+{
+	struct orig_node *req_dst_orig_node = NULL, *res_dst_orig_node = NULL;
+	struct neigh_node *neigh_node = NULL;
+	struct hard_iface *primary_if = NULL;
+	struct tt_global_entry *tt_global_entry;
+	struct hlist_node *node;
+	struct hlist_head *head;
+	struct hashtable_t *hash;
+	uint8_t orig_ttvn, req_ttvn;
+	int i, ret = NET_RX_DROP;
+	unsigned char *tt_buff;
+	bool full_table;
+	uint16_t tt_len, tt_tot, tt_count;
+	struct sk_buff *skb = NULL;
+	struct tt_query_packet *tt_response;
+
+	bat_dbg(DBG_ROUTES, bat_priv,
+		"Received TT_REQUEST from %pM for "
+		"ttvn: %u (%pM) [%c]\n", tt_request->src,
+		tt_request->ttvn, tt_request->dst,
+		(tt_request->flags & TT_FULL_TABLE ? 'F' : '.'));
+
+	/* Let's get the orig node of the REAL destination */
+	req_dst_orig_node = get_orig_node(bat_priv, tt_request->dst);
+	if (!req_dst_orig_node)
+		goto out;
+
+	/* I don't have any info about this node yet! */
+	if (!req_dst_orig_node->tt_crc)
+		goto out;
+
+	res_dst_orig_node = get_orig_node(bat_priv, tt_request->src);
+	if (!res_dst_orig_node)
+		goto out;
+
+	neigh_node = find_router(bat_priv, res_dst_orig_node, NULL);
+	if (!neigh_node)
+		goto out;
+
+	if (neigh_node->if_incoming->if_status != IF_ACTIVE)
+		goto out;
+
+	primary_if = primary_if_get_selected(bat_priv);
+	if (!primary_if)
+		goto out;
+
+	orig_ttvn = (uint8_t)atomic_read(&req_dst_orig_node->last_tt_ver_num);
+	req_ttvn = tt_request->ttvn;
+
+	/* I have not the requested data */
+	if (orig_ttvn != req_ttvn ||
+	    tt_request->tt_data != req_dst_orig_node->tt_crc)
+		goto out;
+
+	/* If it has explicitly been requested the full table */
+	if (tt_request->flags & TT_FULL_TABLE ||
+	    !req_dst_orig_node->tt_buff)
+		full_table = true;
+	else
+		full_table = false;
+
+	/* In this version, fragmentation is not implemented, then
+	 * I'll send only one packet with as much TT entries as I can */
+	if (!full_table) {
+		spin_lock_bh(&req_dst_orig_node->tt_buff_lock);
+		tt_len = req_dst_orig_node->tt_buff_len;
+		tt_tot = tt_len / sizeof(struct tt_change);
+
+		skb = dev_alloc_skb(sizeof(struct tt_query_packet) +
+				    tt_len + ETH_HLEN);
+		if (!skb)
+			goto unlock;
+
+		skb_reserve(skb, ETH_HLEN);
+		tt_response = (struct tt_query_packet *)skb_put(skb,
+				sizeof(struct tt_query_packet) + tt_len);
+		tt_response->ttvn = req_ttvn;
+
+		tt_buff = skb->data + sizeof(struct tt_query_packet);
+		/* Copy the last orig_node's OGM buffer */
+		memcpy(tt_buff, req_dst_orig_node->tt_buff,
+		       req_dst_orig_node->tt_buff_len);
+
+		spin_unlock_bh(&req_dst_orig_node->tt_buff_lock);
+	} else {
+		tt_len = (uint16_t)atomic_read(&req_dst_orig_node->tt_size) *
+								ETH_ALEN;
+		if (sizeof(struct tt_query_packet) + tt_len >
+						primary_if->soft_iface->mtu) {
+			tt_len = primary_if->soft_iface->mtu -
+						sizeof(struct tt_query_packet);
+			tt_len -= tt_len % ETH_ALEN;
+		}
+		tt_tot = tt_len / ETH_ALEN;
+
+		skb = dev_alloc_skb(sizeof(struct tt_query_packet) +
+				    tt_len + ETH_HLEN);
+		if (!skb)
+			goto out;
+
+		skb_reserve(skb, ETH_HLEN);
+		tt_response = (struct tt_query_packet *)skb_put(skb,
+				sizeof(struct tt_query_packet) + tt_len);
+		tt_response->ttvn = (uint8_t)
+			atomic_read(&req_dst_orig_node->last_tt_ver_num);
+
+		tt_buff = skb->data + sizeof(struct tt_query_packet);
+		/* Fill the packet with the orig_node's local table */
+		hash = bat_priv->tt_global_hash;
+		tt_count = 0;
+		rcu_read_lock();
+		for (i = 0; i < hash->size; i++) {
+			head = &hash->table[i];
+
+			hlist_for_each_entry_rcu(tt_global_entry, node,
+					head, hash_entry) {
+				if (tt_count == tt_tot)
+					break;
+				if (tt_global_entry->orig_node ==
+				    req_dst_orig_node) {
+					memcpy(tt_buff + tt_count * ETH_ALEN,
+					       tt_global_entry->addr,
+					       ETH_ALEN);
+					tt_count++;
+				}
+			}
+		}
+		rcu_read_unlock();
+	}
+
+	tt_response->packet_type = BAT_TT_QUERY;
+	tt_response->version = COMPAT_VERSION;
+	memcpy(tt_response->src, req_dst_orig_node->orig, ETH_ALEN);
+	memcpy(tt_response->dst, tt_request->src, ETH_ALEN);
+	tt_response->tt_data = htons(tt_tot);
+	tt_response->flags = TT_RESPONSE;
+
+	if (full_table)
+		tt_response->flags |= TT_FULL_TABLE;
+
+	bat_dbg(DBG_ROUTES, bat_priv,
+		"Sending TT_RESPONSE %pM via %pM for %pM (ttvn: %u)\n",
+		res_dst_orig_node->orig, neigh_node->addr,
+		req_dst_orig_node->orig, req_ttvn);
+
+	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
+	ret = NET_RX_SUCCESS;
+	goto out;
+
+unlock:
+	spin_unlock_bh(&req_dst_orig_node->tt_buff_lock);
+
+out:
+	if (res_dst_orig_node)
+		orig_node_free_ref(res_dst_orig_node);
+	if (req_dst_orig_node)
+		orig_node_free_ref(req_dst_orig_node);
+	if (neigh_node)
+		neigh_node_free_ref(neigh_node);
+	if (primary_if)
+		hardif_free_ref(primary_if);
+	if (ret == NET_RX_DROP)
+		kfree_skb(skb);
+	return ret;
+
+}
+static int send_my_tt_response(struct bat_priv *bat_priv,
+			       struct tt_query_packet *tt_request)
+{
+	struct orig_node *orig_node = NULL;
+	struct neigh_node *neigh_node = NULL;
+	struct tt_local_entry *tt_local_entry;
+	struct hard_iface *primary_if = NULL;
+	struct hlist_node *node;
+	struct hlist_head *head;
+	struct hashtable_t *hash;
+	uint8_t my_ttvn, req_ttvn;
+	int i, ret = NET_RX_DROP;
+	unsigned char *tt_buff;
+	bool full_table;
+	uint16_t tt_len, tt_tot, tt_count;
+	struct sk_buff *skb = NULL;
+	struct tt_query_packet *tt_response;
+
+	bat_dbg(DBG_ROUTES, bat_priv,
+		"Received TT_REQUEST from %pM for "
+		"ttvn: %u (me) [%c]\n", tt_request->src,
+		tt_request->ttvn,
+		(tt_request->flags & TT_FULL_TABLE ? 'F' : '.'));
+
+
+	my_ttvn = (uint8_t)atomic_read(&bat_priv->tt_ver_num);
+	req_ttvn = tt_request->ttvn;
+
+	orig_node = get_orig_node(bat_priv, tt_request->src);
+	if (!orig_node)
+		goto out;
+
+	neigh_node = find_router(bat_priv, orig_node, NULL);
+	if (!neigh_node)
+		goto out;
+
+	if (neigh_node->if_incoming->if_status != IF_ACTIVE)
+		goto out;
+
+	primary_if = primary_if_get_selected(bat_priv);
+	if (!primary_if)
+		goto out;
+
+	/* If the full table has been explicitly requested or the gap
+	 * is too big send the whole local translation table */
+	if (tt_request->flags & TT_FULL_TABLE || my_ttvn != req_ttvn ||
+	    !bat_priv->tt_buff)
+		full_table = true;
+	else
+		full_table = false;
+
+	/* In this version, fragmentation is not implemented, then
+	 * I'll send only one packet with as much TT entries as I can */
+	if (!full_table) {
+		spin_lock_bh(&bat_priv->tt_buff_lock);
+		tt_len = bat_priv->tt_buff_len;
+		tt_tot = tt_len / sizeof(struct tt_change);
+
+		skb = dev_alloc_skb(sizeof(struct tt_query_packet) +
+				    tt_len + ETH_HLEN);
+		if (!skb)
+			goto unlock;
+
+		skb_reserve(skb, ETH_HLEN);
+		tt_response = (struct tt_query_packet *)skb_put(skb,
+				sizeof(struct tt_query_packet) + tt_len);
+		tt_response->ttvn = req_ttvn;
+
+		tt_buff = skb->data + sizeof(struct tt_query_packet);
+		memcpy(tt_buff, bat_priv->tt_buff,
+		       bat_priv->tt_buff_len);
+		spin_unlock_bh(&bat_priv->tt_buff_lock);
+	} else {
+		tt_len = (uint16_t)atomic_read(&bat_priv->num_local_tt) *
+								ETH_ALEN;
+		if (sizeof(struct tt_query_packet) + tt_len >
+				bat_priv->primary_if->soft_iface->mtu) {
+			tt_len = bat_priv->primary_if->soft_iface->mtu -
+				sizeof(struct tt_query_packet);
+			tt_len -= tt_len % ETH_ALEN;
+		}
+		tt_tot = tt_len / ETH_ALEN;
+
+		skb = dev_alloc_skb(sizeof(struct tt_query_packet) +
+				    tt_len + ETH_HLEN);
+		if (!skb)
+			goto out;
+
+		skb_reserve(skb, ETH_HLEN);
+		tt_response = (struct tt_query_packet *)skb_put(skb,
+				sizeof(struct tt_query_packet) + tt_len);
+		tt_buff = skb->data + sizeof(struct tt_query_packet);
+		/* Fill the packet with the local table */
+		tt_response->ttvn =
+			(uint8_t)atomic_read(&bat_priv->tt_ver_num);
+
+		hash = bat_priv->tt_local_hash;
+		tt_count = 0;
+		rcu_read_lock();
+		for (i = 0; i < hash->size; i++) {
+			head = &hash->table[i];
+
+			hlist_for_each_entry_rcu(tt_local_entry, node,
+					head, hash_entry) {
+				if (tt_count == tt_tot)
+					break;
+				memcpy(tt_buff + tt_count * ETH_ALEN,
+					tt_local_entry->addr,
+						ETH_ALEN);
+				tt_count++;
+			}
+		}
+		rcu_read_unlock();
+	}
+
+	tt_response->packet_type = BAT_TT_QUERY;
+	tt_response->version = COMPAT_VERSION;
+	memcpy(tt_response->src, primary_if->net_dev->dev_addr, ETH_ALEN);
+	memcpy(tt_response->dst, tt_request->src, ETH_ALEN);
+	tt_response->tt_data = htons(tt_tot);
+	tt_response->flags = TT_RESPONSE;
+
+	if (full_table)
+		tt_response->flags |= TT_FULL_TABLE;
+
+	bat_dbg(DBG_ROUTES, bat_priv,
+		"Sending TT_RESPONSE to %pM via %pM [%c]\n",
+		orig_node->orig, neigh_node->addr,
+		(tt_response->flags & TT_FULL_TABLE ? 'F' : '.'));
+
+	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
+	ret = NET_RX_SUCCESS;
+	goto out;
+
+unlock:
+	spin_unlock_bh(&bat_priv->tt_buff_lock);
+out:
+	if (orig_node)
+		orig_node_free_ref(orig_node);
+	if (neigh_node)
+		neigh_node_free_ref(neigh_node);
+	if (primary_if)
+		hardif_free_ref(primary_if);
+	if (ret == NET_RX_DROP)
+		kfree_skb(skb);
+	return ret;
+
+}
+
+int send_tt_response(struct bat_priv *bat_priv,
+		     struct tt_query_packet *tt_request)
+{
+	if (is_my_mac(tt_request->dst))
+		return send_my_tt_response(bat_priv, tt_request);
+	else
+		return send_other_tt_response(bat_priv, tt_request);
+}
+
+/* Substitute the TT response source's table with the newone carried by the
+ * packet */
+static void _tt_fill_gtable(struct bat_priv *bat_priv,
+			    struct orig_node *orig_node, unsigned char *tt_buff,
+			    uint16_t table_size, uint8_t ttvn)
+{
+	int count;
+	unsigned char *tt_ptr;
+
+	for (count = 0; count < table_size; count++) {
+		tt_ptr = tt_buff + (count * ETH_ALEN);
+
+		/* If we fail to allocate a new entry we return immediatly */
+		if (!tt_global_add(bat_priv, orig_node, tt_ptr, ttvn))
+			return;
+	}
+	atomic_set(&orig_node->last_tt_ver_num, ttvn);
+}
+
+static void tt_fill_gtable(struct bat_priv *bat_priv,
+			   struct tt_query_packet *tt_response)
+{
+	struct orig_node *orig_node = NULL;
+
+	orig_node = orig_hash_find(bat_priv, tt_response->src);
+	if (!orig_node)
+		goto out;
+
+	/* Purge the old table first.. */
+	tt_global_del_orig(bat_priv, orig_node, "Received full table");
+
+	_tt_fill_gtable(bat_priv, orig_node,
+		((unsigned char *)tt_response) +
+		sizeof(struct tt_query_packet),
+		tt_response->tt_data,
+		tt_response->ttvn);
+
+	spin_lock_bh(&orig_node->tt_buff_lock);
+	kfree(orig_node->tt_buff);
+	orig_node->tt_buff_len = 0;
+	orig_node->tt_buff = NULL;
+	spin_unlock_bh(&orig_node->tt_buff_lock);
+
+out:
+	if (orig_node)
+		orig_node_free_ref(orig_node);
+}
+
+static void tt_update_changes(struct bat_priv *bat_priv,
+			      struct tt_query_packet *tt_response,
+			      struct tt_change *tt_change)
+{
+	struct orig_node *orig_node = NULL;
+	int i;
+
+	orig_node = orig_hash_find(bat_priv, tt_response->src);
+
+	if (!orig_node)
+		goto out;
+
+	for (i = 0; i < tt_response->tt_data; i++) {
+		if ((tt_change + i)->op == TT_DEL)
+			tt_global_del(bat_priv, orig_node,
+				      (tt_change + i)->addr,
+				      "tt removed by tt_response");
+		else
+			if (!tt_global_add(bat_priv, orig_node,
+				     (tt_change + i)->addr, tt_response->ttvn))
+				return;
+	}
+
+	tt_save_orig_buffer(bat_priv, orig_node, (unsigned char *)tt_change,
+			    tt_response->tt_data);
+	atomic_set(&orig_node->last_tt_ver_num, tt_response->ttvn);
+
+out:
+	if (orig_node)
+		orig_node_free_ref(orig_node);
+}
+
+bool is_my_client(struct bat_priv *bat_priv, uint8_t *addr)
+{
+	struct tt_local_entry *tt_local_entry;
+
+	spin_lock_bh(&bat_priv->tt_lhash_lock);
+	tt_local_entry = tt_local_hash_find(bat_priv, addr);
+	spin_unlock_bh(&bat_priv->tt_lhash_lock);
+
+	if (tt_local_entry)
+		return true;
+	return false;
+}
+
+void handle_tt_response(struct bat_priv *bat_priv,
+			struct tt_query_packet *tt_response)
+{
+	struct tt_req_node *node, *safe;
+	struct orig_node *orig_node = NULL;
+
+	bat_dbg(DBG_ROUTES, bat_priv, "Received TT_RESPONSE from %pM for "
+		"ttvn %d t_size: %d [%c]\n",
+		tt_response->src, tt_response->ttvn,
+		tt_response->tt_data,
+		(tt_response->flags & TT_FULL_TABLE ? 'F' : '.'));
+
+	if (tt_response->flags & TT_FULL_TABLE)
+		tt_fill_gtable(bat_priv, tt_response);
+	else
+		tt_update_changes(bat_priv, tt_response,
+				  (struct tt_change *)(tt_response + 1));
+
+	/* Delete the tt_req_node from pending tt_requests list */
+	spin_lock_bh(&bat_priv->tt_req_list_lock);
+	list_for_each_entry_safe(node, safe, &bat_priv->tt_req_list, list) {
+		if (!compare_eth(node->addr, tt_response->src))
+			continue;
+		list_del(&node->list);
+		kfree(node);
+	}
+	spin_unlock_bh(&bat_priv->tt_req_list_lock);
+
+	/* Recalculate the CRC for this orig_node and store it */
+	orig_node = orig_hash_find(bat_priv, tt_response->src);
+	if (!orig_node)
+		goto out;
+
+	spin_lock_bh(&bat_priv->tt_ghash_lock);
+	orig_node->tt_crc = tt_global_crc(bat_priv, orig_node);
+	spin_unlock_bh(&bat_priv->tt_ghash_lock);
+out:
+	orig_node_free_ref(orig_node);
+}
+
+int tt_init(struct bat_priv *bat_priv)
+{
+	if (!tt_local_init(bat_priv))
+		return 0;
+
+	if (!tt_global_init(bat_priv))
+		return 0;
+
+	tt_start_timer(bat_priv);
+
+	return 1;
+}
+
+void tt_free(struct bat_priv *bat_priv)
+{
+	cancel_delayed_work_sync(&bat_priv->tt_work);
+
+	tt_local_table_free(bat_priv);
+	tt_global_table_free(bat_priv);
+	tt_req_list_free(bat_priv);
+	tt_changes_list_free(bat_priv);
+
+	kfree(bat_priv->tt_buff);
+}
+
+static void tt_purge(struct work_struct *work)
+{
+	struct delayed_work *delayed_work =
+		container_of(work, struct delayed_work, work);
+	struct bat_priv *bat_priv =
+		container_of(delayed_work, struct bat_priv, tt_work);
+
+	tt_local_purge(bat_priv);
+	tt_req_purge(bat_priv);
+
+	tt_start_timer(bat_priv);
+}
diff --git a/translation-table.h b/translation-table.h
index 46152c3..4eef4f8 100644
--- a/translation-table.h
+++ b/translation-table.h
@@ -22,22 +22,41 @@
 #ifndef _NET_BATMAN_ADV_TRANSLATION_TABLE_H_
 #define _NET_BATMAN_ADV_TRANSLATION_TABLE_H_
 
-int tt_local_init(struct bat_priv *bat_priv);
+int tt_len(int changes_num);
+void tt_changes_primary_if(struct bat_priv *bat_priv, uint8_t *old_addr,
+			   uint8_t *new_addr);
+int tt_changes_fill_buffer(struct bat_priv *bat_priv,
+			   unsigned char *buff, int buff_len);
+int tt_init(struct bat_priv *bat_priv);
 void tt_local_add(struct net_device *soft_iface, uint8_t *addr);
 void tt_local_remove(struct bat_priv *bat_priv,
-		      uint8_t *addr, char *message);
-int tt_local_fill_buffer(struct bat_priv *bat_priv,
-			  unsigned char *buff, int buff_len);
+		     uint8_t *addr, char *message);
 int tt_local_seq_print_text(struct seq_file *seq, void *offset);
-void tt_local_free(struct bat_priv *bat_priv);
-int tt_global_init(struct bat_priv *bat_priv);
 void tt_global_add_orig(struct bat_priv *bat_priv,
-			 struct orig_node *orig_node,
-			 unsigned char *tt_buff, int tt_buff_len);
+			struct orig_node *orig_node,
+			unsigned char *tt_buff, int tt_buff_len);
+int tt_global_add(struct bat_priv *bat_priv,
+		  struct orig_node *orig_node, unsigned char *addr,
+		  uint8_t ttvn);
 int tt_global_seq_print_text(struct seq_file *seq, void *offset);
 void tt_global_del_orig(struct bat_priv *bat_priv,
-			 struct orig_node *orig_node, char *message);
-void tt_global_free(struct bat_priv *bat_priv);
+			struct orig_node *orig_node, char *message);
+void tt_global_del(struct bat_priv *bat_priv,
+		   struct orig_node *orig_node, unsigned char *addr,
+		   char *message);
 struct orig_node *transtable_search(struct bat_priv *bat_priv, uint8_t *addr);
+void tt_save_orig_buffer(struct bat_priv *bat_priv, struct orig_node *orig_node,
+			 unsigned char *tt_buff, uint8_t tt_num_changes);
+uint16_t tt_local_crc(struct bat_priv *bat_priv);
+uint16_t tt_global_crc(struct bat_priv *bat_priv, struct orig_node *orig_node);
+void tt_free(struct bat_priv *bat_priv);
+int send_tt_request(struct bat_priv *bat_priv,
+		    struct orig_node *dst_orig_node, uint8_t hvn,
+		    uint16_t tt_crc, bool full_table);
+int send_tt_response(struct bat_priv *bat_priv,
+		     struct tt_query_packet *tt_request);
+bool is_my_client(struct bat_priv *bat_priv, uint8_t *addr);
+void handle_tt_response(struct bat_priv *bat_priv,
+			struct tt_query_packet *tt_response);
 
 #endif /* _NET_BATMAN_ADV_TRANSLATION_TABLE_H_ */
diff --git a/types.h b/types.h
index b8c72c3..3a629a3 100644
--- a/types.h
+++ b/types.h
@@ -75,8 +75,12 @@ struct orig_node {
 	unsigned long batman_seqno_reset;
 	uint8_t gw_flags;
 	uint8_t flags;
+	atomic_t last_tt_ver_num;
+	uint16_t tt_crc;
 	unsigned char *tt_buff;
 	int16_t tt_buff_len;
+	spinlock_t tt_buff_lock;
+	atomic_t tt_size;
 	uint32_t last_real_seqno;
 	uint8_t last_ttl;
 	unsigned long bcast_bits[NUM_WORDS];
@@ -94,10 +98,16 @@ struct orig_node {
 				  * neigh_node->real_packet_count */
 	spinlock_t bcast_seqno_lock; /* protects bcast_bits,
 				      *	 last_bcast_seqno */
+	spinlock_t tt_list_lock; /* protects tt_list */
 	atomic_t bond_candidates;
 	struct list_head bond_list;
 };
 
+struct tt_change {
+	uint8_t op;
+	uint8_t addr[ETH_ALEN];
+};
+
 struct gw_node {
 	struct hlist_node list;
 	struct orig_node *orig_node;
@@ -145,6 +155,9 @@ struct bat_priv {
 	atomic_t bcast_seqno;
 	atomic_t bcast_queue_left;
 	atomic_t batman_queue_left;
+	atomic_t tt_ver_num;
+	atomic_t tt_ogm_append_cnt;
+	atomic_t tt_local_changes; /* changes registered in a OGM interval */
 	char num_ifaces;
 	struct hlist_head softif_neigh_list;
 	struct softif_neigh __rcu *softif_neigh;
@@ -154,21 +167,29 @@ struct bat_priv {
 	struct hlist_head forw_bat_list;
 	struct hlist_head forw_bcast_list;
 	struct hlist_head gw_list;
+	struct list_head tt_changes_list; /* tracks changes in a OGM int */
 	struct list_head vis_send_list;
 	struct hashtable_t *orig_hash;
 	struct hashtable_t *tt_local_hash;
 	struct hashtable_t *tt_global_hash;
+	struct list_head tt_req_list; /* list of pending tt_requests */
 	struct hashtable_t *vis_hash;
 	spinlock_t forw_bat_list_lock; /* protects forw_bat_list */
 	spinlock_t forw_bcast_list_lock; /* protects  */
+	spinlock_t tt_changes_list_lock; /* protects tt_changes */
 	spinlock_t tt_lhash_lock; /* protects tt_local_hash */
 	spinlock_t tt_ghash_lock; /* protects tt_global_hash */
+	spinlock_t tt_req_list_lock; /* protects tt_req_list */
 	spinlock_t gw_list_lock; /* protects gw_list and curr_gw */
 	spinlock_t vis_hash_lock; /* protects vis_hash */
 	spinlock_t vis_list_lock; /* protects vis_info::recv_list */
 	spinlock_t softif_neigh_lock; /* protects soft-interface neigh list */
-	int16_t num_local_tt;
-	atomic_t tt_local_changed;
+	atomic_t num_local_tt;
+	atomic_t tt_crc; /* Checksum of the local table, recomputed before
+			  * sending a new OGM */
+	unsigned char *tt_buff;
+	int16_t tt_buff_len;
+	spinlock_t tt_buff_lock;
 	struct delayed_work tt_work;
 	struct delayed_work orig_work;
 	struct delayed_work vis_work;
@@ -202,9 +223,22 @@ struct tt_local_entry {
 struct tt_global_entry {
 	uint8_t addr[ETH_ALEN];
 	struct orig_node *orig_node;
+	uint8_t ttvn;
+	/* entry in the global table */
 	struct hlist_node hash_entry;
 };
 
+struct tt_change_node {
+	struct list_head list;
+	struct tt_change change;
+};
+
+struct tt_req_node {
+	uint8_t addr[ETH_ALEN];
+	unsigned long issued_at;
+	struct list_head list;
+};
+
 /**
  *	forw_packet - structure for forw_list maintaining packets to be
  *	              send/forwarded
diff --git a/unicast.c b/unicast.c
index 19c3daf..4a8cb9e 100644
--- a/unicast.c
+++ b/unicast.c
@@ -329,6 +329,9 @@ find_router:
 	unicast_packet->ttl = TTL;
 	/* copy the destination for faster routing */
 	memcpy(unicast_packet->dest, orig_node->orig, ETH_ALEN);
+	/* set the destination tt version number */
+	unicast_packet->ttvn =
+		(uint8_t)atomic_read(&orig_node->last_tt_ver_num);
 
 	if (atomic_read(&bat_priv->fragmentation) &&
 	    data_len + sizeof(struct unicast_packet) >
-- 
1.7.3.4


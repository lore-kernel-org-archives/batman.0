Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Fri,  7 May 2010 21:47:21 +0200
Message-Id: <1273261651-21378-17-git-send-email-andrew@lunn.ch>
In-Reply-To: <1273261651-21378-1-git-send-email-andrew@lunn.ch>
References: <1273261651-21378-1-git-send-email-andrew@lunn.ch>
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 16/26] Staging: batman-adv: remove redundant
	pointer to originator interface
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
To: greg@kroah.com
Cc: Marek Lindner <lindner_marek@yahoo.de>, b.a.t.m.a.n@lists.open-mesh.net

From: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/staging/batman-adv/device.c         |    2 +-
 drivers/staging/batman-adv/originator.c     |    1 -
 drivers/staging/batman-adv/routing.c        |   17 ++++-------------
 drivers/staging/batman-adv/soft-interface.c |    5 ++---
 drivers/staging/batman-adv/types.h          |    1 -
 drivers/staging/batman-adv/vis.c            |   15 +++++++--------
 6 files changed, 14 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/batman-adv/device.c b/drivers/staging/batman-adv/device.c
index 9887f05..c419c62 100644
--- a/drivers/staging/batman-adv/device.c
+++ b/drivers/staging/batman-adv/device.c
@@ -250,7 +250,7 @@ ssize_t bat_device_write(struct file *file, const char __user *buff,
 	if (!orig_node->router)
 		goto unlock;
 
-	batman_if = orig_node->batman_if;
+	batman_if = orig_node->router->if_incoming;
 	memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
 
 	spin_unlock_irqrestore(&orig_hash_lock, flags);
diff --git a/drivers/staging/batman-adv/originator.c b/drivers/staging/batman-adv/originator.c
index 684db75..4152701 100644
--- a/drivers/staging/batman-adv/originator.c
+++ b/drivers/staging/batman-adv/originator.c
@@ -137,7 +137,6 @@ struct orig_node *get_orig_node(uint8_t *addr)
 
 	memcpy(orig_node->orig, addr, ETH_ALEN);
 	orig_node->router = NULL;
-	orig_node->batman_if = NULL;
 	orig_node->hna_buff = NULL;
 
 	size = num_ifs * sizeof(TYPE_OF_WORD) * NUM_WORDS;
diff --git a/drivers/staging/batman-adv/routing.c b/drivers/staging/batman-adv/routing.c
index 8c055a1..0a9f52b 100644
--- a/drivers/staging/batman-adv/routing.c
+++ b/drivers/staging/batman-adv/routing.c
@@ -97,11 +97,6 @@ static void update_route(struct orig_node *orig_node,
 		bat_dbg(DBG_ROUTES, "Changing route towards: %pM (now via %pM - was via %pM)\n", orig_node->orig, neigh_node->addr, orig_node->router->addr);
 	}
 
-	if (neigh_node != NULL)
-		orig_node->batman_if = neigh_node->if_incoming;
-	else
-		orig_node->batman_if = NULL;
-
 	orig_node->router = neigh_node;
 }
 
@@ -616,12 +611,11 @@ static int recv_my_icmp_packet(struct sk_buff *skb)
 	ret = NET_RX_DROP;
 
 	if ((orig_node != NULL) &&
-	    (orig_node->batman_if != NULL) &&
 	    (orig_node->router != NULL)) {
 
 		/* don't lock while sending the packets ... we therefore
 		 * copy the required data before sending */
-		batman_if = orig_node->batman_if;
+		batman_if = orig_node->router->if_incoming;
 		memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
 		spin_unlock_irqrestore(&orig_hash_lock, flags);
 
@@ -678,12 +672,11 @@ static int recv_icmp_ttl_exceeded(struct sk_buff *skb)
 	ret = NET_RX_DROP;
 
 	if ((orig_node != NULL) &&
-	    (orig_node->batman_if != NULL) &&
 	    (orig_node->router != NULL)) {
 
 		/* don't lock while sending the packets ... we therefore
 		 * copy the required data before sending */
-		batman_if = orig_node->batman_if;
+		batman_if = orig_node->router->if_incoming;
 		memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
 		spin_unlock_irqrestore(&orig_hash_lock, flags);
 
@@ -760,12 +753,11 @@ int recv_icmp_packet(struct sk_buff *skb)
 		     hash_find(orig_hash, icmp_packet->dst));
 
 	if ((orig_node != NULL) &&
-	    (orig_node->batman_if != NULL) &&
 	    (orig_node->router != NULL)) {
 
 		/* don't lock while sending the packets ... we therefore
 		 * copy the required data before sending */
-		batman_if = orig_node->batman_if;
+		batman_if = orig_node->router->if_incoming;
 		memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
 		spin_unlock_irqrestore(&orig_hash_lock, flags);
 
@@ -844,12 +836,11 @@ int recv_unicast_packet(struct sk_buff *skb)
 		     hash_find(orig_hash, unicast_packet->dest));
 
 	if ((orig_node != NULL) &&
-	    (orig_node->batman_if != NULL) &&
 	    (orig_node->router != NULL)) {
 
 		/* don't lock while sending the packets ... we therefore
 		 * copy the required data before sending */
-		batman_if = orig_node->batman_if;
+		batman_if = orig_node->router->if_incoming;
 		memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
 		spin_unlock_irqrestore(&orig_hash_lock, flags);
 
diff --git a/drivers/staging/batman-adv/soft-interface.c b/drivers/staging/batman-adv/soft-interface.c
index 829deb6..4cdebe5 100644
--- a/drivers/staging/batman-adv/soft-interface.c
+++ b/drivers/staging/batman-adv/soft-interface.c
@@ -236,7 +236,6 @@ int interface_tx(struct sk_buff *skb, struct net_device *dev)
 			orig_node = transtable_search(ethhdr->h_dest);
 
 		if ((orig_node) &&
-		    (orig_node->batman_if) &&
 		    (orig_node->router)) {
 			if (my_skb_push(skb, sizeof(struct unicast_packet)) < 0)
 				goto unlock;
@@ -252,13 +251,13 @@ int interface_tx(struct sk_buff *skb, struct net_device *dev)
 			memcpy(unicast_packet->dest, orig_node->orig, ETH_ALEN);
 
 			/* net_dev won't be available when not active */
-			if (orig_node->batman_if->if_active != IF_ACTIVE)
+			if (orig_node->router->if_incoming->if_active != IF_ACTIVE)
 				goto unlock;
 
 			/* don't lock while sending the packets ... we therefore
 			 * copy the required data before sending */
 
-			batman_if = orig_node->batman_if;
+			batman_if = orig_node->router->if_incoming;
 			memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
 			spin_unlock_irqrestore(&orig_hash_lock, flags);
 
diff --git a/drivers/staging/batman-adv/types.h b/drivers/staging/batman-adv/types.h
index a8c6ad7..ffaa16c 100644
--- a/drivers/staging/batman-adv/types.h
+++ b/drivers/staging/batman-adv/types.h
@@ -49,7 +49,6 @@ struct batman_if {
 struct orig_node {               /* structure for orig_list maintaining nodes of mesh */
 	uint8_t orig[ETH_ALEN];
 	struct neigh_node *router;
-	struct batman_if *batman_if;
 	TYPE_OF_WORD *bcast_own;
 	uint8_t *bcast_own_sum;
 	uint8_t tq_own;
diff --git a/drivers/staging/batman-adv/vis.c b/drivers/staging/batman-adv/vis.c
index 5edeb32..57d69d7 100644
--- a/drivers/staging/batman-adv/vis.c
+++ b/drivers/staging/batman-adv/vis.c
@@ -498,14 +498,14 @@ static int generate_vis_packet(struct bat_priv *bat_priv)
 		if (orig_node->router != NULL
 			&& compare_orig(orig_node->router->addr,
 					orig_node->orig)
-			&& orig_node->batman_if
-			&& (orig_node->batman_if->if_active == IF_ACTIVE)
+			&& (orig_node->router->if_incoming->if_active ==
+								IF_ACTIVE)
 		    && orig_node->router->tq_avg > 0) {
 
 			/* fill one entry into buffer. */
 			entry = &entry_array[info->packet.entries];
 			memcpy(entry->src,
-			       orig_node->batman_if->net_dev->dev_addr,
+			     orig_node->router->if_incoming->net_dev->dev_addr,
 			       ETH_ALEN);
 			memcpy(entry->dest, orig_node->orig, ETH_ALEN);
 			entry->quality = orig_node->router->tq_avg;
@@ -573,8 +573,7 @@ static void broadcast_vis_packet(struct vis_info *info, int packet_length)
 		orig_node = hashit.bucket->data;
 
 		/* if it's a vis server and reachable, send it. */
-		if ((!orig_node) || (!orig_node->batman_if) ||
-		    (!orig_node->router))
+		if ((!orig_node) || (!orig_node->router))
 			continue;
 		if (!(orig_node->flags & VIS_SERVER))
 			continue;
@@ -584,7 +583,7 @@ static void broadcast_vis_packet(struct vis_info *info, int packet_length)
 			continue;
 
 		memcpy(info->packet.target_orig, orig_node->orig, ETH_ALEN);
-		batman_if = orig_node->batman_if;
+		batman_if = orig_node->router->if_incoming;
 		memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
 		spin_unlock_irqrestore(&orig_hash_lock, flags);
 
@@ -609,12 +608,12 @@ static void unicast_vis_packet(struct vis_info *info, int packet_length)
 	orig_node = ((struct orig_node *)
 		     hash_find(orig_hash, info->packet.target_orig));
 
-	if ((!orig_node) || (!orig_node->batman_if) || (!orig_node->router))
+	if ((!orig_node) || (!orig_node->router))
 		goto out;
 
 	/* don't lock while sending the packets ... we therefore
 	 * copy the required data before sending */
-	batman_if = orig_node->batman_if;
+	batman_if = orig_node->router->if_incoming;
 	memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
 	spin_unlock_irqrestore(&orig_hash_lock, flags);
 
-- 
1.7.1


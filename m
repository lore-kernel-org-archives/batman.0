Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 24 Mar 2010 12:52:41 +0800
Message-Id: <1269406363-9593-3-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <201003241252.18954.lindner_marek@yahoo.de>
References: <201003241252.18954.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/5] batman-adv: remove redundant pointer to
	originator interface
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
To: b.a.t.m.a.n@lists.open-mesh.net
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 batman-adv-kernelland/device.c     |    2 +-
 batman-adv-kernelland/originator.c |    1 -
 batman-adv-kernelland/routing.c    |   14 +++-----------
 batman-adv-kernelland/types.h      |    1 -
 batman-adv-kernelland/vis.c        |   15 +++++++--------
 5 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/batman-adv-kernelland/device.c b/batman-adv-kernelland/device.c
index 484b2a1..a3e066a 100644
--- a/batman-adv-kernelland/device.c
+++ b/batman-adv-kernelland/device.c
@@ -260,7 +260,7 @@ ssize_t bat_device_write(struct file *file, const char __user *buff,
 	if (!orig_node->router)
 		goto unlock;
 
-	batman_if = orig_node->batman_if;
+	batman_if = orig_node->router->if_incoming;
 	memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
 
 	spin_unlock_irqrestore(&orig_hash_lock, flags);
diff --git a/batman-adv-kernelland/originator.c b/batman-adv-kernelland/originator.c
index 1f607f4..dbc7cbf 100644
--- a/batman-adv-kernelland/originator.c
+++ b/batman-adv-kernelland/originator.c
@@ -139,7 +139,6 @@ struct orig_node *get_orig_node(uint8_t *addr)
 
 	memcpy(orig_node->orig, addr, ETH_ALEN);
 	orig_node->router = NULL;
-	orig_node->batman_if = NULL;
 	orig_node->hna_buff = NULL;
 
 	size = num_ifs * sizeof(TYPE_OF_WORD) * NUM_WORDS;
diff --git a/batman-adv-kernelland/routing.c b/batman-adv-kernelland/routing.c
index 2e357bf..3168215 100644
--- a/batman-adv-kernelland/routing.c
+++ b/batman-adv-kernelland/routing.c
@@ -99,11 +99,6 @@ static void update_route(struct orig_node *orig_node,
 		bat_dbg(DBG_ROUTES, "Changing route towards: %pM (now via %pM - was via %pM)\n", orig_node->orig, neigh_node->addr, orig_node->router->addr);
 	}
 
-	if (neigh_node != NULL)
-		orig_node->batman_if = neigh_node->if_incoming;
-	else
-		orig_node->batman_if = NULL;
-
 	orig_node->router = neigh_node;
 }
 
@@ -747,12 +742,11 @@ static int recv_my_icmp_packet(struct sk_buff *skb, size_t icmp_len)
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
 
@@ -809,12 +803,11 @@ static int recv_icmp_ttl_exceeded(struct sk_buff *skb, size_t icmp_len)
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
 
@@ -905,12 +898,11 @@ int recv_icmp_packet(struct sk_buff *skb)
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
 
diff --git a/batman-adv-kernelland/types.h b/batman-adv-kernelland/types.h
index 0794dfc..de13c99 100644
--- a/batman-adv-kernelland/types.h
+++ b/batman-adv-kernelland/types.h
@@ -49,7 +49,6 @@ struct orig_node {               /* structure for orig_list maintaining nodes of
 	uint8_t orig[ETH_ALEN];
 	uint8_t primary_addr[ETH_ALEN];	/* hosts primary interface address */
 	struct neigh_node *router;
-	struct batman_if *batman_if;
 	TYPE_OF_WORD *bcast_own;
 	uint8_t *bcast_own_sum;
 	uint8_t tq_own;
diff --git a/batman-adv-kernelland/vis.c b/batman-adv-kernelland/vis.c
index 91849f4..a774de7 100644
--- a/batman-adv-kernelland/vis.c
+++ b/batman-adv-kernelland/vis.c
@@ -499,14 +499,14 @@ static int generate_vis_packet(struct bat_priv *bat_priv)
 		if (orig_node->router != NULL
 			&& compare_orig(orig_node->router->addr,
 					orig_node->orig)
-			&& orig_node->batman_if
-			&& (orig_node->batman_if->if_active == IF_ACTIVE)
+			&& (orig_node->router->if_incoming->if_status ==
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
@@ -574,8 +574,7 @@ static void broadcast_vis_packet(struct vis_info *info, int packet_length)
 		orig_node = hashit.bucket->data;
 
 		/* if it's a vis server and reachable, send it. */
-		if ((!orig_node) || (!orig_node->batman_if) ||
-		    (!orig_node->router))
+		if ((!orig_node) || (!orig_node->router))
 			continue;
 		if (!(orig_node->flags & VIS_SERVER))
 			continue;
@@ -585,7 +584,7 @@ static void broadcast_vis_packet(struct vis_info *info, int packet_length)
 			continue;
 
 		memcpy(info->packet.target_orig, orig_node->orig, ETH_ALEN);
-		batman_if = orig_node->batman_if;
+		batman_if = orig_node->router->if_incoming;
 		memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
 		spin_unlock_irqrestore(&orig_hash_lock, flags);
 
@@ -610,12 +609,12 @@ static void unicast_vis_packet(struct vis_info *info, int packet_length)
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
1.7.0


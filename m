Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 26 Jun 2012 22:00:20 +0200
Message-Id: <1340740822-4516-4-git-send-email-ordex@autistici.org>
In-Reply-To: <1340740822-4516-1-git-send-email-ordex@autistici.org>
References: <1340740822-4516-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 3/5] batman-adv: enable roaming packets to
	carry flags
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

In case of client-roaming it would be useful to carry TT flags along with
the client entry. Information contained in the flags could be used on the new
mesh node for several reasons (e.g. particular roaming treatment).

This patch modifies the ROAMING_ADV packet according to this idea so that it can
also carry the flags together with the MAC address of the moving client.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 packet.h            |    2 +-
 routing.c           |    7 ++++---
 translation-table.c |   17 ++++++++++-------
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/packet.h b/packet.h
index 65d66e4..e0b94a3 100644
--- a/packet.h
+++ b/packet.h
@@ -214,7 +214,7 @@ struct batadv_tt_query_packet {
 
 struct batadv_roam_adv_packet {
 	struct batadv_header header;
-	uint8_t  reserved;
+	uint8_t  flags;
 	uint8_t  dst[ETH_ALEN];
 	uint8_t  src[ETH_ALEN];
 	uint8_t  client[ETH_ALEN];
diff --git a/routing.c b/routing.c
index bc2b88b..b3da42c 100644
--- a/routing.c
+++ b/routing.c
@@ -710,11 +710,12 @@ int batadv_recv_roam_adv(struct sk_buff *skb, struct batadv_hard_iface *recv_if)
 		goto out;
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
-		   "Received ROAMING_ADV from %pM (client %pM)\n",
-		   roam_adv_packet->src, roam_adv_packet->client);
+		   "Received ROAMING_ADV from %pM (client: %pM flags: 0x%.2x)\n",
+		   roam_adv_packet->src, roam_adv_packet->client,
+		   roam_adv_packet->flags);
 
 	batadv_tt_global_add(bat_priv, orig_node, roam_adv_packet->client,
-			     BATADV_TT_CLIENT_ROAM,
+			     roam_adv_packet->flags | BATADV_TT_CLIENT_ROAM,
 			     atomic_read(&orig_node->last_ttvn) + 1);
 
 	/* Roaming phase starts: I have new information but the ttvn has not
diff --git a/translation-table.c b/translation-table.c
index 2e90a97..b265c28 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -29,7 +29,8 @@
 
 #include <linux/crc16.h>
 
-static void batadv_send_roam_adv(struct batadv_priv *bat_priv, uint8_t *client,
+static void batadv_send_roam_adv(struct batadv_priv *bat_priv,
+				 struct batadv_tt_global_entry *tt_global_entry,
 				 struct batadv_orig_node *orig_node);
 static void batadv_tt_purge(struct work_struct *work);
 static void
@@ -303,8 +304,7 @@ void batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 		hlist_for_each_entry_rcu(orig_entry, node, head, list) {
 			orig_entry->orig_node->tt_poss_change = true;
 
-			batadv_send_roam_adv(bat_priv,
-					     tt_global_entry->common.addr,
+			batadv_send_roam_adv(bat_priv, tt_global_entry,
 					     orig_entry->orig_node);
 		}
 		rcu_read_unlock();
@@ -2051,7 +2051,8 @@ unlock:
 	return ret;
 }
 
-static void batadv_send_roam_adv(struct batadv_priv *bat_priv, uint8_t *client,
+static void batadv_send_roam_adv(struct batadv_priv *bat_priv,
+				 struct batadv_tt_global_entry *tt_global_entry,
 				 struct batadv_orig_node *orig_node)
 {
 	struct batadv_neigh_node *neigh_node = NULL;
@@ -2064,7 +2065,7 @@ static void batadv_send_roam_adv(struct batadv_priv *bat_priv, uint8_t *client,
 	/* before going on we have to check whether the client has
 	 * already roamed to us too many times
 	 */
-	if (!batadv_tt_check_roam_count(bat_priv, client))
+	if (!batadv_tt_check_roam_count(bat_priv, tt_global_entry->common.addr))
 		goto out;
 
 	skb = dev_alloc_skb(sizeof(*roam_adv_packet) + ETH_HLEN);
@@ -2084,7 +2085,8 @@ static void batadv_send_roam_adv(struct batadv_priv *bat_priv, uint8_t *client,
 	memcpy(roam_adv_packet->src, primary_if->net_dev->dev_addr, ETH_ALEN);
 	batadv_hardif_free_ref(primary_if);
 	memcpy(roam_adv_packet->dst, orig_node->orig, ETH_ALEN);
-	memcpy(roam_adv_packet->client, client, ETH_ALEN);
+	memcpy(roam_adv_packet->client, tt_global_entry->common.addr, ETH_ALEN);
+	roam_adv_packet->flags = BATADV_NO_FLAGS;
 
 	neigh_node = batadv_orig_node_get_router(orig_node);
 	if (!neigh_node)
@@ -2092,7 +2094,8 @@ static void batadv_send_roam_adv(struct batadv_priv *bat_priv, uint8_t *client,
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Sending ROAMING_ADV to %pM (client %pM) via %pM\n",
-		   orig_node->orig, client, neigh_node->addr);
+		   orig_node->orig, tt_global_entry->common.addr,
+		   neigh_node->addr);
 
 	batadv_inc_counter(bat_priv, BATADV_CNT_TT_ROAM_ADV_TX);
 
-- 
1.7.9.4


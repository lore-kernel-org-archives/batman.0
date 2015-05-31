Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 31 May 2015 10:10:21 +0200
Message-Id: <1433059821-8521-2-git-send-email-sven@narfation.org>
In-Reply-To: <1433059821-8521-1-git-send-email-sven@narfation.org>
References: <1433059821-8521-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Remove multiple assignment
	per line
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

The Linux CodingStyle disallows multiple assignments in a single line.
(see chapter 1)

Reported-by: Markus Pargmann <mpa@pengutronix.de>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_iv_ogm.c            |  6 ++++--
 net/batman-adv/bridge_loop_avoidance.c |  6 ++++--
 net/batman-adv/distributed-arp-table.c |  3 ++-
 net/batman-adv/gateway_client.c        | 15 ++++++++++-----
 net/batman-adv/gateway_common.c        |  5 ++++-
 net/batman-adv/network-coding.c        |  3 ++-
 net/batman-adv/translation-table.c     | 18 +++++++++++++-----
 7 files changed, 39 insertions(+), 17 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 753383c..d3ebf6f 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1006,7 +1006,8 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 {
 	struct batadv_neigh_ifinfo *neigh_ifinfo = NULL;
 	struct batadv_neigh_ifinfo *router_ifinfo = NULL;
-	struct batadv_neigh_node *neigh_node = NULL, *tmp_neigh_node = NULL;
+	struct batadv_neigh_node *neigh_node = NULL;
+	struct batadv_neigh_node *tmp_neigh_node = NULL;
 	struct batadv_neigh_node *router = NULL;
 	struct batadv_orig_node *orig_node_tmp;
 	int if_num;
@@ -1406,7 +1407,8 @@ batadv_iv_ogm_process_per_outif(const struct sk_buff *skb, int ogm_offset,
 				struct batadv_hard_iface *if_outgoing)
 {
 	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
-	struct batadv_neigh_node *router = NULL, *router_router = NULL;
+	struct batadv_neigh_node *router = NULL;
+	struct batadv_neigh_node *router_router = NULL;
 	struct batadv_orig_node *orig_neigh_node;
 	struct batadv_orig_ifinfo *orig_ifinfo;
 	struct batadv_neigh_node *orig_neigh_router = NULL;
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index ba06092..65cee82 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -89,7 +89,8 @@ static int batadv_compare_backbone_gw(const struct hlist_node *node,
 {
 	const void *data1 = container_of(node, struct batadv_bla_backbone_gw,
 					 hash_entry);
-	const struct batadv_bla_backbone_gw *gw1 = data1, *gw2 = data2;
+	const struct batadv_bla_backbone_gw *gw1 = data1;
+	const struct batadv_bla_backbone_gw *gw2 = data2;
 
 	if (!batadv_compare_eth(gw1->orig, gw2->orig))
 		return 0;
@@ -106,7 +107,8 @@ static int batadv_compare_claim(const struct hlist_node *node,
 {
 	const void *data1 = container_of(node, struct batadv_bla_claim,
 					 hash_entry);
-	const struct batadv_bla_claim *cl1 = data1, *cl2 = data2;
+	const struct batadv_bla_claim *cl1 = data1;
+	const struct batadv_bla_claim *cl2 = data2;
 
 	if (!batadv_compare_eth(cl1->addr, cl2->addr))
 		return 0;
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index fb54e6a..c829be0 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -496,7 +496,8 @@ static void batadv_choose_next_candidate(struct batadv_priv *bat_priv,
 					 int select, batadv_dat_addr_t ip_key,
 					 batadv_dat_addr_t *last_max)
 {
-	batadv_dat_addr_t max = 0, tmp_max = 0;
+	batadv_dat_addr_t max = 0;
+	batadv_dat_addr_t tmp_max = 0;
 	struct batadv_orig_node *orig_node, *max_orig_node = NULL;
 	struct batadv_hashtable *hash = bat_priv->orig_hash;
 	struct hlist_head *head;
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index bb01586..953553e 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -153,7 +153,8 @@ batadv_gw_get_best_gw_node(struct batadv_priv *bat_priv)
 	struct batadv_neigh_node *router;
 	struct batadv_neigh_ifinfo *router_ifinfo;
 	struct batadv_gw_node *gw_node, *curr_gw = NULL;
-	uint32_t max_gw_factor = 0, tmp_gw_factor = 0;
+	uint32_t max_gw_factor = 0;
+	uint32_t tmp_gw_factor = 0;
 	uint32_t gw_divisor;
 	uint8_t max_tq = 0;
 	uint8_t tq_avg;
@@ -267,7 +268,8 @@ void batadv_gw_check_client_stop(struct batadv_priv *bat_priv)
 
 void batadv_gw_election(struct batadv_priv *bat_priv)
 {
-	struct batadv_gw_node *curr_gw = NULL, *next_gw = NULL;
+	struct batadv_gw_node *curr_gw = NULL;
+	struct batadv_gw_node *next_gw = NULL;
 	struct batadv_neigh_node *router = NULL;
 	struct batadv_neigh_ifinfo *router_ifinfo = NULL;
 	char gw_addr[18] = { '\0' };
@@ -351,7 +353,8 @@ void batadv_gw_check_election(struct batadv_priv *bat_priv,
 	struct batadv_neigh_ifinfo *router_orig_tq = NULL;
 	struct batadv_neigh_ifinfo *router_gw_tq = NULL;
 	struct batadv_orig_node *curr_gw_orig;
-	struct batadv_neigh_node *router_gw = NULL, *router_orig = NULL;
+	struct batadv_neigh_node *router_gw = NULL;
+	struct batadv_neigh_node *router_orig = NULL;
 	uint8_t gw_tq_avg, orig_tq_avg;
 
 	curr_gw_orig = batadv_gw_get_selected_orig(bat_priv);
@@ -810,9 +813,11 @@ batadv_gw_dhcp_recipient_get(struct sk_buff *skb, unsigned int *header_len,
 bool batadv_gw_out_of_range(struct batadv_priv *bat_priv,
 			    struct sk_buff *skb)
 {
-	struct batadv_neigh_node *neigh_curr = NULL, *neigh_old = NULL;
+	struct batadv_neigh_node *neigh_curr = NULL;
+	struct batadv_neigh_node *neigh_old = NULL;
 	struct batadv_orig_node *orig_dst_node = NULL;
-	struct batadv_gw_node *gw_node = NULL, *curr_gw = NULL;
+	struct batadv_gw_node *gw_node = NULL;
+	struct batadv_gw_node *curr_gw = NULL;
 	struct batadv_neigh_ifinfo *curr_ifinfo, *old_ifinfo;
 	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
 	bool out_of_range = false;
diff --git a/net/batman-adv/gateway_common.c b/net/batman-adv/gateway_common.c
index 39cf44c..bf9a5c5 100644
--- a/net/batman-adv/gateway_common.c
+++ b/net/batman-adv/gateway_common.c
@@ -149,7 +149,10 @@ ssize_t batadv_gw_bandwidth_set(struct net_device *net_dev, char *buff,
 				size_t count)
 {
 	struct batadv_priv *bat_priv = netdev_priv(net_dev);
-	uint32_t down_curr, up_curr, down_new = 0, up_new = 0;
+	uint32_t down_curr;
+	uint32_t up_curr;
+	uint32_t down_new = 0;
+	uint32_t up_new = 0;
 	bool ret;
 
 	down_curr = (unsigned int)atomic_read(&bat_priv->gw.bandwidth_down);
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 3c89119..d26d3a7 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -887,7 +887,8 @@ void batadv_nc_update_nc_node(struct batadv_priv *bat_priv,
 			      struct batadv_ogm_packet *ogm_packet,
 			      int is_single_hop_neigh)
 {
-	struct batadv_nc_node *in_nc_node = NULL, *out_nc_node = NULL;
+	struct batadv_nc_node *in_nc_node = NULL;
+	struct batadv_nc_node *out_nc_node = NULL;
 
 	/* Check if network coding is enabled */
 	if (!atomic_read(&bat_priv->network_coding))
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index b482495..c47c64e 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -461,7 +461,8 @@ static uint16_t batadv_tt_entries(uint16_t tt_len)
  */
 static int batadv_tt_local_table_transmit_size(struct batadv_priv *bat_priv)
 {
-	uint16_t num_vlan = 0, tt_local_entries = 0;
+	uint16_t num_vlan = 0;
+	uint16_t tt_local_entries = 0;
 	struct batadv_softif_vlan *vlan;
 	int hdr_size;
 
@@ -535,7 +536,8 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 	struct hlist_head *head;
 	struct batadv_tt_orig_list_entry *orig_entry;
 	int hash_added, table_size, packet_size_max;
-	bool ret = false, roamed_back = false;
+	bool ret = false;
+	bool roamed_back = false;
 	uint8_t remote_flags;
 	uint32_t match_mark;
 
@@ -723,7 +725,10 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
 				   struct batadv_tvlv_tt_change **tt_change,
 				   int32_t *tt_len)
 {
-	uint16_t num_vlan = 0, num_entries = 0, change_offset, tvlv_len;
+	uint16_t num_vlan = 0;
+	uint16_t num_entries = 0;
+	uint16_t change_offset;
+	uint16_t tvlv_len;
 	struct batadv_tvlv_tt_vlan_data *tt_vlan;
 	struct batadv_orig_node_vlan *vlan;
 	uint8_t *tt_change_ptr;
@@ -796,7 +801,9 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 {
 	struct batadv_tvlv_tt_vlan_data *tt_vlan;
 	struct batadv_softif_vlan *vlan;
-	uint16_t num_vlan = 0, num_entries = 0, tvlv_len;
+	uint16_t num_vlan = 0;
+	uint16_t num_entries = 0;
+	uint16_t tvlv_len;
 	uint8_t *tt_change_ptr;
 	int change_offset;
 
@@ -853,7 +860,8 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
 	struct batadv_tvlv_tt_data *tt_data;
 	struct batadv_tvlv_tt_change *tt_change;
 	int tt_diff_len, tt_change_len = 0;
-	int tt_diff_entries_num = 0, tt_diff_entries_count = 0;
+	int tt_diff_entries_num = 0;
+	int tt_diff_entries_count = 0;
 	uint16_t tvlv_len;
 
 	tt_diff_entries_num = atomic_read(&bat_priv->tt.local_changes);
-- 
2.1.4


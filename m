Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 25 Dec 2012 17:03:24 +0800
Message-Id: <1356426206-8667-6-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1356426206-8667-1-git-send-email-lindner_marek@yahoo.de>
References: <1356426206-8667-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 6/8] batman-adv: rename batadv_backbone_gw
	struct to make clear it is used by bla
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 bridge_loop_avoidance.c |   52 ++++++++++++++++++++++++-----------------------
 compat.c                |    4 ++--
 types.h                 |    4 ++--
 3 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 5e834c1..3bcb1de 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -34,8 +34,9 @@
 static const uint8_t batadv_announce_mac[4] = {0x43, 0x05, 0x43, 0x05};
 
 static void batadv_bla_periodic_work(struct work_struct *work);
-static void batadv_bla_send_announce(struct batadv_priv *bat_priv,
-				     struct batadv_backbone_gw *backbone_gw);
+static void
+batadv_bla_send_announce(struct batadv_priv *bat_priv,
+			 struct batadv_bla_backbone_gw *backbone_gw);
 
 /* return the index of the claim */
 static inline uint32_t batadv_choose_claim(const void *data, uint32_t size)
@@ -75,9 +76,9 @@ static inline uint32_t batadv_choose_backbone_gw(const void *data,
 static int batadv_compare_backbone_gw(const struct hlist_node *node,
 				      const void *data2)
 {
-	const void *data1 = container_of(node, struct batadv_backbone_gw,
+	const void *data1 = container_of(node, struct batadv_bla_backbone_gw,
 					 hash_entry);
-	const struct batadv_backbone_gw *gw1 = data1, *gw2 = data2;
+	const struct batadv_bla_backbone_gw *gw1 = data1, *gw2 = data2;
 
 	if (!batadv_compare_eth(gw1->orig, gw2->orig))
 		return 0;
@@ -106,7 +107,8 @@ static int batadv_compare_claim(const struct hlist_node *node,
 }
 
 /* free a backbone gw */
-static void batadv_backbone_gw_free_ref(struct batadv_backbone_gw *backbone_gw)
+static void
+batadv_backbone_gw_free_ref(struct batadv_bla_backbone_gw *backbone_gw)
 {
 	if (atomic_dec_and_test(&backbone_gw->refcount))
 		kfree_rcu(backbone_gw, rcu);
@@ -176,15 +178,15 @@ static struct batadv_claim *batadv_claim_hash_find(struct batadv_priv *bat_priv,
  *
  * Returns claim if found or NULL otherwise.
  */
-static struct batadv_backbone_gw *
+static struct batadv_bla_backbone_gw *
 batadv_backbone_hash_find(struct batadv_priv *bat_priv,
 			  uint8_t *addr, short vid)
 {
 	struct batadv_hashtable *hash = bat_priv->bla.backbone_hash;
 	struct hlist_head *head;
 	struct hlist_node *node;
-	struct batadv_backbone_gw search_entry, *backbone_gw;
-	struct batadv_backbone_gw *backbone_gw_tmp = NULL;
+	struct batadv_bla_backbone_gw search_entry, *backbone_gw;
+	struct batadv_bla_backbone_gw *backbone_gw_tmp = NULL;
 	int index;
 
 	if (!hash)
@@ -215,7 +217,7 @@ batadv_backbone_hash_find(struct batadv_priv *bat_priv,
 
 /* delete all claims for a backbone */
 static void
-batadv_bla_del_backbone_claims(struct batadv_backbone_gw *backbone_gw)
+batadv_bla_del_backbone_claims(struct batadv_bla_backbone_gw *backbone_gw)
 {
 	struct batadv_hashtable *hash;
 	struct hlist_node *node, *node_tmp;
@@ -364,11 +366,11 @@ out:
  * searches for the backbone gw or creates a new one if it could not
  * be found.
  */
-static struct batadv_backbone_gw *
+static struct batadv_bla_backbone_gw *
 batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, uint8_t *orig,
 			   short vid, bool own_backbone)
 {
-	struct batadv_backbone_gw *entry;
+	struct batadv_bla_backbone_gw *entry;
 	struct batadv_orig_node *orig_node;
 	int hash_added;
 
@@ -435,7 +437,7 @@ batadv_bla_update_own_backbone_gw(struct batadv_priv *bat_priv,
 				  struct batadv_hard_iface *primary_if,
 				  short vid)
 {
-	struct batadv_backbone_gw *backbone_gw;
+	struct batadv_bla_backbone_gw *backbone_gw;
 
 	backbone_gw = batadv_bla_get_backbone_gw(bat_priv,
 						 primary_if->net_dev->dev_addr,
@@ -461,7 +463,7 @@ static void batadv_bla_answer_request(struct batadv_priv *bat_priv,
 	struct hlist_head *head;
 	struct batadv_hashtable *hash;
 	struct batadv_claim *claim;
-	struct batadv_backbone_gw *backbone_gw;
+	struct batadv_bla_backbone_gw *backbone_gw;
 	int i;
 
 	batadv_dbg(BATADV_DBG_BLA, bat_priv,
@@ -500,7 +502,7 @@ static void batadv_bla_answer_request(struct batadv_priv *bat_priv,
  * After the request, it will repeat all of his own claims and finally
  * send an announcement claim with which we can check again.
  */
-static void batadv_bla_send_request(struct batadv_backbone_gw *backbone_gw)
+static void batadv_bla_send_request(struct batadv_bla_backbone_gw *backbone_gw)
 {
 	/* first, remove all old entries */
 	batadv_bla_del_backbone_claims(backbone_gw);
@@ -526,7 +528,7 @@ static void batadv_bla_send_request(struct batadv_backbone_gw *backbone_gw)
  * places.
  */
 static void batadv_bla_send_announce(struct batadv_priv *bat_priv,
-				     struct batadv_backbone_gw *backbone_gw)
+				     struct batadv_bla_backbone_gw *backbone_gw)
 {
 	uint8_t mac[ETH_ALEN];
 	__be16 crc;
@@ -548,7 +550,7 @@ static void batadv_bla_send_announce(struct batadv_priv *bat_priv,
  */
 static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 				 const uint8_t *mac, const short vid,
-				 struct batadv_backbone_gw *backbone_gw)
+				 struct batadv_bla_backbone_gw *backbone_gw)
 {
 	struct batadv_claim *claim;
 	struct batadv_claim search_claim;
@@ -639,7 +641,7 @@ static int batadv_handle_announce(struct batadv_priv *bat_priv,
 				  uint8_t *an_addr, uint8_t *backbone_addr,
 				  short vid)
 {
-	struct batadv_backbone_gw *backbone_gw;
+	struct batadv_bla_backbone_gw *backbone_gw;
 	uint16_t crc;
 
 	if (memcmp(an_addr, batadv_announce_mac, 4) != 0)
@@ -711,7 +713,7 @@ static int batadv_handle_unclaim(struct batadv_priv *bat_priv,
 				 uint8_t *backbone_addr,
 				 uint8_t *claim_addr, short vid)
 {
-	struct batadv_backbone_gw *backbone_gw;
+	struct batadv_bla_backbone_gw *backbone_gw;
 
 	/* unclaim in any case if it is our own */
 	if (primary_if && batadv_compare_eth(backbone_addr,
@@ -740,7 +742,7 @@ static int batadv_handle_claim(struct batadv_priv *bat_priv,
 			       uint8_t *backbone_addr, uint8_t *claim_addr,
 			       short vid)
 {
-	struct batadv_backbone_gw *backbone_gw;
+	struct batadv_bla_backbone_gw *backbone_gw;
 
 	/* register the gateway if not yet available, and add the claim. */
 
@@ -954,7 +956,7 @@ static int batadv_bla_process_claim(struct batadv_priv *bat_priv,
  */
 static void batadv_bla_purge_backbone_gw(struct batadv_priv *bat_priv, int now)
 {
-	struct batadv_backbone_gw *backbone_gw;
+	struct batadv_bla_backbone_gw *backbone_gw;
 	struct hlist_node *node, *node_tmp;
 	struct hlist_head *head;
 	struct batadv_hashtable *hash;
@@ -1058,7 +1060,7 @@ void batadv_bla_update_orig_address(struct batadv_priv *bat_priv,
 				    struct batadv_hard_iface *primary_if,
 				    struct batadv_hard_iface *oldif)
 {
-	struct batadv_backbone_gw *backbone_gw;
+	struct batadv_bla_backbone_gw *backbone_gw;
 	struct hlist_node *node;
 	struct hlist_head *head;
 	struct batadv_hashtable *hash;
@@ -1121,7 +1123,7 @@ static void batadv_bla_periodic_work(struct work_struct *work)
 	struct batadv_priv_bla *priv_bla;
 	struct hlist_node *node;
 	struct hlist_head *head;
-	struct batadv_backbone_gw *backbone_gw;
+	struct batadv_bla_backbone_gw *backbone_gw;
 	struct batadv_hashtable *hash;
 	struct batadv_hard_iface *primary_if;
 	int i;
@@ -1326,7 +1328,7 @@ int batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv, uint8_t *orig)
 	struct batadv_hashtable *hash = bat_priv->bla.backbone_hash;
 	struct hlist_head *head;
 	struct hlist_node *node;
-	struct batadv_backbone_gw *backbone_gw;
+	struct batadv_bla_backbone_gw *backbone_gw;
 	int i;
 
 	if (!atomic_read(&bat_priv->bridge_loop_avoidance))
@@ -1367,7 +1369,7 @@ int batadv_bla_is_backbone_gw(struct sk_buff *skb,
 {
 	struct ethhdr *ethhdr;
 	struct vlan_ethhdr *vhdr;
-	struct batadv_backbone_gw *backbone_gw;
+	struct batadv_bla_backbone_gw *backbone_gw;
 	short vid = -1;
 
 	if (!atomic_read(&orig_node->bat_priv->bridge_loop_avoidance))
@@ -1653,7 +1655,7 @@ int batadv_bla_backbone_table_seq_print_text(struct seq_file *seq, void *offset)
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct batadv_priv *bat_priv = netdev_priv(net_dev);
 	struct batadv_hashtable *hash = bat_priv->bla.backbone_hash;
-	struct batadv_backbone_gw *backbone_gw;
+	struct batadv_bla_backbone_gw *backbone_gw;
 	struct batadv_hard_iface *primary_if;
 	struct hlist_node *node;
 	struct hlist_head *head;
diff --git a/compat.c b/compat.c
index c8006c6..a2a6f09 100644
--- a/compat.c
+++ b/compat.c
@@ -57,9 +57,9 @@ void batadv_free_rcu_tt_local_entry(struct rcu_head *rcu)
 #ifdef CONFIG_BATMAN_ADV_BLA
 void batadv_free_rcu_backbone_gw(struct rcu_head *rcu)
 {
-	struct batadv_backbone_gw *backbone_gw;
+	struct batadv_bla_backbone_gw *backbone_gw;
 
-	backbone_gw = container_of(rcu, struct batadv_backbone_gw, rcu);
+	backbone_gw = container_of(rcu, struct batadv_bla_backbone_gw, rcu);
 	kfree(backbone_gw);
 }
 #endif
diff --git a/types.h b/types.h
index c56e0d9..eb3d129 100644
--- a/types.h
+++ b/types.h
@@ -340,7 +340,7 @@ struct batadv_socket_packet {
 };
 
 #ifdef CONFIG_BATMAN_ADV_BLA
-struct batadv_backbone_gw {
+struct batadv_bla_backbone_gw {
 	uint8_t orig[ETH_ALEN];
 	short vid;		/* used VLAN ID */
 	struct hlist_node hash_entry;
@@ -356,7 +356,7 @@ struct batadv_backbone_gw {
 struct batadv_claim {
 	uint8_t addr[ETH_ALEN];
 	short vid;
-	struct batadv_backbone_gw *backbone_gw;
+	struct batadv_bla_backbone_gw *backbone_gw;
 	unsigned long lasttime;	/* last time we heard of claim (locals only) */
 	struct rcu_head rcu;
 	atomic_t refcount;
-- 
1.7.10.4


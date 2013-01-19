Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 19 Jan 2013 21:27:54 +0800
Message-Id: <1358602079-24024-9-git-send-email-ordex@autistici.org>
In-Reply-To: <1358602079-24024-1-git-send-email-ordex@autistici.org>
References: <1358602079-24024-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 08/13] batman-adv: rename batadv_claim struct
	to make clear it is used by bla
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/bridge_loop_avoidance.c | 41 +++++++++++++++++-----------------
 net/batman-adv/types.h                 |  2 +-
 2 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 5f9a206..9971892 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -41,7 +41,7 @@ batadv_bla_send_announce(struct batadv_priv *bat_priv,
 /* return the index of the claim */
 static inline uint32_t batadv_choose_claim(const void *data, uint32_t size)
 {
-	struct batadv_claim *claim = (struct batadv_claim *)data;
+	struct batadv_bla_claim *claim = (struct batadv_bla_claim *)data;
 	uint32_t hash = 0;
 
 	hash = batadv_hash_bytes(hash, &claim->addr, sizeof(claim->addr));
@@ -58,7 +58,7 @@ static inline uint32_t batadv_choose_claim(const void *data, uint32_t size)
 static inline uint32_t batadv_choose_backbone_gw(const void *data,
 						 uint32_t size)
 {
-	const struct batadv_claim *claim = (struct batadv_claim *)data;
+	const struct batadv_bla_claim *claim = (struct batadv_bla_claim *)data;
 	uint32_t hash = 0;
 
 	hash = batadv_hash_bytes(hash, &claim->addr, sizeof(claim->addr));
@@ -93,9 +93,9 @@ static int batadv_compare_backbone_gw(const struct hlist_node *node,
 static int batadv_compare_claim(const struct hlist_node *node,
 				const void *data2)
 {
-	const void *data1 = container_of(node, struct batadv_claim,
+	const void *data1 = container_of(node, struct batadv_bla_claim,
 					 hash_entry);
-	const struct batadv_claim *cl1 = data1, *cl2 = data2;
+	const struct batadv_bla_claim *cl1 = data1, *cl2 = data2;
 
 	if (!batadv_compare_eth(cl1->addr, cl2->addr))
 		return 0;
@@ -117,16 +117,16 @@ batadv_backbone_gw_free_ref(struct batadv_bla_backbone_gw *backbone_gw)
 /* finally deinitialize the claim */
 static void batadv_claim_free_rcu(struct rcu_head *rcu)
 {
-	struct batadv_claim *claim;
+	struct batadv_bla_claim *claim;
 
-	claim = container_of(rcu, struct batadv_claim, rcu);
+	claim = container_of(rcu, struct batadv_bla_claim, rcu);
 
 	batadv_backbone_gw_free_ref(claim->backbone_gw);
 	kfree(claim);
 }
 
 /* free a claim, call claim_free_rcu if its the last reference */
-static void batadv_claim_free_ref(struct batadv_claim *claim)
+static void batadv_claim_free_ref(struct batadv_bla_claim *claim)
 {
 	if (atomic_dec_and_test(&claim->refcount))
 		call_rcu(&claim->rcu, batadv_claim_free_rcu);
@@ -138,14 +138,15 @@ static void batadv_claim_free_ref(struct batadv_claim *claim)
  * looks for a claim in the hash, and returns it if found
  * or NULL otherwise.
  */
-static struct batadv_claim *batadv_claim_hash_find(struct batadv_priv *bat_priv,
-						   struct batadv_claim *data)
+static struct batadv_bla_claim
+*batadv_claim_hash_find(struct batadv_priv *bat_priv,
+			struct batadv_bla_claim *data)
 {
 	struct batadv_hashtable *hash = bat_priv->bla.claim_hash;
 	struct hlist_head *head;
 	struct hlist_node *node;
-	struct batadv_claim *claim;
-	struct batadv_claim *claim_tmp = NULL;
+	struct batadv_bla_claim *claim;
+	struct batadv_bla_claim *claim_tmp = NULL;
 	int index;
 
 	if (!hash)
@@ -222,7 +223,7 @@ batadv_bla_del_backbone_claims(struct batadv_bla_backbone_gw *backbone_gw)
 	struct batadv_hashtable *hash;
 	struct hlist_node *node, *node_tmp;
 	struct hlist_head *head;
-	struct batadv_claim *claim;
+	struct batadv_bla_claim *claim;
 	int i;
 	spinlock_t *list_lock;	/* protects write access to the hash lists */
 
@@ -462,7 +463,7 @@ static void batadv_bla_answer_request(struct batadv_priv *bat_priv,
 	struct hlist_node *node;
 	struct hlist_head *head;
 	struct batadv_hashtable *hash;
-	struct batadv_claim *claim;
+	struct batadv_bla_claim *claim;
 	struct batadv_bla_backbone_gw *backbone_gw;
 	int i;
 
@@ -552,8 +553,8 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 				 const uint8_t *mac, const short vid,
 				 struct batadv_bla_backbone_gw *backbone_gw)
 {
-	struct batadv_claim *claim;
-	struct batadv_claim search_claim;
+	struct batadv_bla_claim *claim;
+	struct batadv_bla_claim search_claim;
 	int hash_added;
 
 	memcpy(search_claim.addr, mac, ETH_ALEN);
@@ -615,7 +616,7 @@ claim_free_ref:
 static void batadv_bla_del_claim(struct batadv_priv *bat_priv,
 				 const uint8_t *mac, const short vid)
 {
-	struct batadv_claim search_claim, *claim;
+	struct batadv_bla_claim search_claim, *claim;
 
 	memcpy(search_claim.addr, mac, ETH_ALEN);
 	search_claim.vid = vid;
@@ -1011,7 +1012,7 @@ static void batadv_bla_purge_claims(struct batadv_priv *bat_priv,
 				    struct batadv_hard_iface *primary_if,
 				    int now)
 {
-	struct batadv_claim *claim;
+	struct batadv_bla_claim *claim;
 	struct hlist_node *node;
 	struct hlist_head *head;
 	struct batadv_hashtable *hash;
@@ -1434,7 +1435,7 @@ int batadv_bla_rx(struct batadv_priv *bat_priv, struct sk_buff *skb, short vid,
 		  bool is_bcast)
 {
 	struct ethhdr *ethhdr;
-	struct batadv_claim search_claim, *claim = NULL;
+	struct batadv_bla_claim search_claim, *claim = NULL;
 	struct batadv_hard_iface *primary_if;
 	int ret;
 
@@ -1528,7 +1529,7 @@ out:
 int batadv_bla_tx(struct batadv_priv *bat_priv, struct sk_buff *skb, short vid)
 {
 	struct ethhdr *ethhdr;
-	struct batadv_claim search_claim, *claim = NULL;
+	struct batadv_bla_claim search_claim, *claim = NULL;
 	struct batadv_hard_iface *primary_if;
 	int ret = 0;
 
@@ -1604,7 +1605,7 @@ int batadv_bla_claim_table_seq_print_text(struct seq_file *seq, void *offset)
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct batadv_priv *bat_priv = netdev_priv(net_dev);
 	struct batadv_hashtable *hash = bat_priv->bla.claim_hash;
-	struct batadv_claim *claim;
+	struct batadv_bla_claim *claim;
 	struct batadv_hard_iface *primary_if;
 	struct hlist_node *node;
 	struct hlist_head *head;
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index eb3d129..549ba56 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -353,7 +353,7 @@ struct batadv_bla_backbone_gw {
 	uint16_t crc;		/* crc checksum over all claims */
 };
 
-struct batadv_claim {
+struct batadv_bla_claim {
 	uint8_t addr[ETH_ALEN];
 	short vid;
 	struct batadv_bla_backbone_gw *backbone_gw;
-- 
1.8.0.2


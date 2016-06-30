Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 30 Jun 2016 20:11:33 +0200
Message-Id: <1467310294-5892-1-git-send-email-sven@narfation.org>
In-Reply-To: <1467310246-5820-1-git-send-email-sven@narfation.org>
References: <1467310246-5820-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v2 2/3] batman-adv: Fix non-atomic
	bla_claim::backbone_gw access
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

The pointer batadv_bla_claim::backbone_gw can be changed at any time.
Therefore, access to it must be protected to ensure that two function
accessing the same backbone_gw are actually accessing the same. This is
especially important when the crc_lock is used or when the backbone_gw of a
claim is exchanged.

Not doing so leads to invalid memory access and/or reference leaks.

Fixes: a9ce0dc43e2c ("batman-adv: add basic bridge loop avoidance code")
Fixes: b307e72d119f ("batman-adv: lock crc access in bridge loop avoidance")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
 - Move backbone release of claim to batadv_claim_release
 - added kerneldoc for backbone_lock
---
 net/batman-adv/bridge_loop_avoidance.c | 110 ++++++++++++++++++++++++++-------
 net/batman-adv/types.h                 |   2 +
 2 files changed, 89 insertions(+), 23 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index c5e62fa..ebc4c2b 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -178,10 +178,21 @@ static void batadv_backbone_gw_put(struct batadv_bla_backbone_gw *backbone_gw)
 static void batadv_claim_release(struct kref *ref)
 {
 	struct batadv_bla_claim *claim;
+	struct batadv_bla_backbone_gw *old_backbone_gw;
 
 	claim = container_of(ref, struct batadv_bla_claim, refcount);
 
-	batadv_backbone_gw_put(claim->backbone_gw);
+	spin_lock_bh(&claim->backbone_lock);
+	old_backbone_gw = claim->backbone_gw;
+	claim->backbone_gw = NULL;
+	spin_unlock_bh(&claim->backbone_lock);
+
+	spin_lock_bh(&old_backbone_gw->crc_lock);
+	old_backbone_gw->crc ^= crc16(0, claim->addr, ETH_ALEN);
+	spin_unlock_bh(&old_backbone_gw->crc_lock);
+
+	batadv_backbone_gw_put(old_backbone_gw);
+
 	kfree_rcu(claim, rcu);
 }
 
@@ -673,8 +684,10 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 				 const u8 *mac, const unsigned short vid,
 				 struct batadv_bla_backbone_gw *backbone_gw)
 {
+	struct batadv_bla_backbone_gw *old_backbone_gw;
 	struct batadv_bla_claim *claim;
 	struct batadv_bla_claim search_claim;
+	bool remove_crc = false;
 	int hash_added;
 
 	ether_addr_copy(search_claim.addr, mac);
@@ -688,8 +701,10 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 			return;
 
 		ether_addr_copy(claim->addr, mac);
+		spin_lock_init(&claim->backbone_lock);
 		claim->vid = vid;
 		claim->lasttime = jiffies;
+		kref_get(&backbone_gw->refcount);
 		claim->backbone_gw = backbone_gw;
 		kref_init(&claim->refcount);
 
@@ -718,15 +733,26 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 			   "bla_add_claim(): changing ownership for %pM, vid %d\n",
 			   mac, BATADV_PRINT_VID(vid));
 
-		spin_lock_bh(&claim->backbone_gw->crc_lock);
-		claim->backbone_gw->crc ^= crc16(0, claim->addr, ETH_ALEN);
-		spin_unlock_bh(&claim->backbone_gw->crc_lock);
-		batadv_backbone_gw_put(claim->backbone_gw);
+		remove_crc = true;
 	}
-	/* set (new) backbone gw */
+
+	/* replace backbone_gw atomically and adjust reference counters */
+	spin_lock_bh(&claim->backbone_lock);
+	old_backbone_gw = claim->backbone_gw;
 	kref_get(&backbone_gw->refcount);
 	claim->backbone_gw = backbone_gw;
+	spin_unlock_bh(&claim->backbone_lock);
+
+	if (remove_crc) {
+		/* remove claim address from old backbone_gw */
+		spin_lock_bh(&old_backbone_gw->crc_lock);
+		old_backbone_gw->crc ^= crc16(0, claim->addr, ETH_ALEN);
+		spin_unlock_bh(&old_backbone_gw->crc_lock);
+	}
 
+	batadv_backbone_gw_put(old_backbone_gw);
+
+	/* add claim address to new backbone_gw */
 	spin_lock_bh(&backbone_gw->crc_lock);
 	backbone_gw->crc ^= crc16(0, claim->addr, ETH_ALEN);
 	spin_unlock_bh(&backbone_gw->crc_lock);
@@ -737,6 +763,25 @@ claim_free_ref:
 }
 
 /**
+ * batadv_bla_claim_backbone_gw - Get valid reference for backbone_gw of claim
+ * @claim: claim whose backbone_gw should be returned
+ *
+ * Return: valid reference to claim::backbone_gw
+ */
+static struct batadv_bla_backbone_gw *
+batadv_bla_claim_backbone_gw(struct batadv_bla_claim *claim)
+{
+	struct batadv_bla_backbone_gw *backbone_gw;
+
+	spin_lock_bh(&claim->backbone_lock);
+	backbone_gw = claim->backbone_gw;
+	kref_get(&backbone_gw->refcount);
+	spin_unlock_bh(&claim->backbone_lock);
+
+	return backbone_gw;
+}
+
+/**
  * batadv_bla_del_claim - delete a claim from the claim hash
  * @bat_priv: the bat priv with all the soft interface information
  * @mac: mac address of the claim to be removed
@@ -760,10 +805,6 @@ static void batadv_bla_del_claim(struct batadv_priv *bat_priv,
 			   batadv_choose_claim, claim);
 	batadv_claim_put(claim); /* reference from the hash is gone */
 
-	spin_lock_bh(&claim->backbone_gw->crc_lock);
-	claim->backbone_gw->crc ^= crc16(0, claim->addr, ETH_ALEN);
-	spin_unlock_bh(&claim->backbone_gw->crc_lock);
-
 	/* don't need the reference from hash_find() anymore */
 	batadv_claim_put(claim);
 }
@@ -1216,6 +1257,7 @@ static void batadv_bla_purge_claims(struct batadv_priv *bat_priv,
 				    struct batadv_hard_iface *primary_if,
 				    int now)
 {
+	struct batadv_bla_backbone_gw *backbone_gw;
 	struct batadv_bla_claim *claim;
 	struct hlist_head *head;
 	struct batadv_hashtable *hash;
@@ -1230,14 +1272,17 @@ static void batadv_bla_purge_claims(struct batadv_priv *bat_priv,
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(claim, head, hash_entry) {
+			backbone_gw = batadv_bla_claim_backbone_gw(claim);
 			if (now)
 				goto purge_now;
-			if (!batadv_compare_eth(claim->backbone_gw->orig,
+
+			if (!batadv_compare_eth(backbone_gw->orig,
 						primary_if->net_dev->dev_addr))
-				continue;
+				goto skip;
+
 			if (!batadv_has_timed_out(claim->lasttime,
 						  BATADV_BLA_CLAIM_TIMEOUT))
-				continue;
+				goto skip;
 
 			batadv_dbg(BATADV_DBG_BLA, bat_priv,
 				   "bla_purge_claims(): %pM, vid %d, time out\n",
@@ -1245,8 +1290,10 @@ static void batadv_bla_purge_claims(struct batadv_priv *bat_priv,
 
 purge_now:
 			batadv_handle_unclaim(bat_priv, primary_if,
-					      claim->backbone_gw->orig,
+					      backbone_gw->orig,
 					      claim->addr, claim->vid);
+skip:
+			batadv_backbone_gw_put(backbone_gw);
 		}
 		rcu_read_unlock();
 	}
@@ -1757,9 +1804,11 @@ batadv_bla_loopdetect_check(struct batadv_priv *bat_priv, struct sk_buff *skb,
 bool batadv_bla_rx(struct batadv_priv *bat_priv, struct sk_buff *skb,
 		   unsigned short vid, bool is_bcast)
 {
+	struct batadv_bla_backbone_gw *backbone_gw;
 	struct ethhdr *ethhdr;
 	struct batadv_bla_claim search_claim, *claim = NULL;
 	struct batadv_hard_iface *primary_if;
+	bool own_claim;
 	bool ret;
 
 	ethhdr = eth_hdr(skb);
@@ -1794,8 +1843,12 @@ bool batadv_bla_rx(struct batadv_priv *bat_priv, struct sk_buff *skb,
 	}
 
 	/* if it is our own claim ... */
-	if (batadv_compare_eth(claim->backbone_gw->orig,
-			       primary_if->net_dev->dev_addr)) {
+	backbone_gw = batadv_bla_claim_backbone_gw(claim);
+	own_claim = batadv_compare_eth(backbone_gw->orig,
+				       primary_if->net_dev->dev_addr);
+	batadv_backbone_gw_put(backbone_gw);
+
+	if (own_claim) {
 		/* ... allow it in any case */
 		claim->lasttime = jiffies;
 		goto allow;
@@ -1859,7 +1912,9 @@ bool batadv_bla_tx(struct batadv_priv *bat_priv, struct sk_buff *skb,
 {
 	struct ethhdr *ethhdr;
 	struct batadv_bla_claim search_claim, *claim = NULL;
+	struct batadv_bla_backbone_gw *backbone_gw;
 	struct batadv_hard_iface *primary_if;
+	bool client_roamed;
 	bool ret = false;
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
@@ -1889,8 +1944,12 @@ bool batadv_bla_tx(struct batadv_priv *bat_priv, struct sk_buff *skb,
 		goto allow;
 
 	/* check if we are responsible. */
-	if (batadv_compare_eth(claim->backbone_gw->orig,
-			       primary_if->net_dev->dev_addr)) {
+	backbone_gw = batadv_bla_claim_backbone_gw(claim);
+	client_roamed = batadv_compare_eth(backbone_gw->orig,
+					   primary_if->net_dev->dev_addr);
+	batadv_backbone_gw_put(backbone_gw);
+
+	if (client_roamed) {
 		/* if yes, the client has roamed and we have
 		 * to unclaim it.
 		 */
@@ -1938,6 +1997,7 @@ int batadv_bla_claim_table_seq_print_text(struct seq_file *seq, void *offset)
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct batadv_priv *bat_priv = netdev_priv(net_dev);
 	struct batadv_hashtable *hash = bat_priv->bla.claim_hash;
+	struct batadv_bla_backbone_gw *backbone_gw;
 	struct batadv_bla_claim *claim;
 	struct batadv_hard_iface *primary_if;
 	struct hlist_head *head;
@@ -1962,17 +2022,21 @@ int batadv_bla_claim_table_seq_print_text(struct seq_file *seq, void *offset)
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(claim, head, hash_entry) {
-			is_own = batadv_compare_eth(claim->backbone_gw->orig,
+			backbone_gw = batadv_bla_claim_backbone_gw(claim);
+
+			is_own = batadv_compare_eth(backbone_gw->orig,
 						    primary_addr);
 
-			spin_lock_bh(&claim->backbone_gw->crc_lock);
-			backbone_crc = claim->backbone_gw->crc;
-			spin_unlock_bh(&claim->backbone_gw->crc_lock);
+			spin_lock_bh(&backbone_gw->crc_lock);
+			backbone_crc = backbone_gw->crc;
+			spin_unlock_bh(&backbone_gw->crc_lock);
 			seq_printf(seq, " * %pM on %5d by %pM [%c] (%#.4x)\n",
 				   claim->addr, BATADV_PRINT_VID(claim->vid),
-				   claim->backbone_gw->orig,
+				   backbone_gw->orig,
 				   (is_own ? 'x' : ' '),
 				   backbone_crc);
+
+			batadv_backbone_gw_put(backbone_gw);
 		}
 		rcu_read_unlock();
 	}
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index fb445c5..d82f6b4 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1167,6 +1167,7 @@ struct batadv_bla_backbone_gw {
  * @addr: mac address of claimed non-mesh client
  * @vid: vlan id this client was detected on
  * @backbone_gw: pointer to backbone gw claiming this client
+ * @backbone_lock: lock protecting backbone_gw pointer
  * @lasttime: last time we heard of claim (locals only)
  * @hash_entry: hlist node for batadv_priv_bla::claim_hash
  * @refcount: number of contexts the object is used
@@ -1176,6 +1177,7 @@ struct batadv_bla_claim {
 	u8 addr[ETH_ALEN];
 	unsigned short vid;
 	struct batadv_bla_backbone_gw *backbone_gw;
+	spinlock_t backbone_lock; /* protects backbone_gw */
 	unsigned long lasttime;
 	struct hlist_node hash_entry;
 	struct rcu_head rcu;
-- 
2.8.1


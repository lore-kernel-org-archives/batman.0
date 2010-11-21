Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 22 Nov 2010 00:55:52 +0100
Message-Id: <1290383767-32602-15-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
References: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 14/29] Staging: batman-adv: Unify sysfs file
	names with their bat_priv atomics
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
Cc: b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Linus Lüssing <linus.luessing@web.de>

Both sysfs entries and variable names shall be as descriptive as
possible while not exceeding a certain length. This patch renames
bat_priv atomics to be equally descriptive with their according sysfs
entries.

Unifying sysfs and bat_priv atomic names also makes it easier to find
each others pendant.

The reduced ("type"-)information which was previously indicated with a
_enabled for booleans got substituted by a comment in bat_priv.

This patch has also been done in regards for the future BAT_ATTR_*
macros (they only need one name argument instead of a file and variable
name).

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/aggregation.c       |    6 +++---
 drivers/staging/batman-adv/bat_sysfs.c         |   24 ++++++++++++------------
 drivers/staging/batman-adv/hard-interface.c    |    6 +++---
 drivers/staging/batman-adv/routing.c           |    4 ++--
 drivers/staging/batman-adv/soft-interface.c    |    6 +++---
 drivers/staging/batman-adv/translation-table.c |    2 +-
 drivers/staging/batman-adv/types.h             |   12 ++++++------
 drivers/staging/batman-adv/unicast.c           |    2 +-
 8 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/batman-adv/aggregation.c b/drivers/staging/batman-adv/aggregation.c
index 08624d4..3dfed2f 100644
--- a/drivers/staging/batman-adv/aggregation.c
+++ b/drivers/staging/batman-adv/aggregation.c
@@ -123,7 +123,7 @@ static void new_aggregated_packet(unsigned char *packet_buff, int packet_len,
 		return;
 	}
 
-	if ((atomic_read(&bat_priv->aggregation_enabled)) &&
+	if ((atomic_read(&bat_priv->aggregated_ogms)) &&
 	    (packet_len < MAX_AGGREGATION_BYTES))
 		forw_packet_aggr->skb = dev_alloc_skb(MAX_AGGREGATION_BYTES +
 						      sizeof(struct ethhdr));
@@ -206,7 +206,7 @@ void add_bat_packet_to_list(struct bat_priv *bat_priv,
 	/* find position for the packet in the forward queue */
 	spin_lock_irqsave(&bat_priv->forw_bat_list_lock, flags);
 	/* own packets are not to be aggregated */
-	if ((atomic_read(&bat_priv->aggregation_enabled)) && (!own_packet)) {
+	if ((atomic_read(&bat_priv->aggregated_ogms)) && (!own_packet)) {
 		hlist_for_each_entry(forw_packet_pos, tmp_node,
 				     &bat_priv->forw_bat_list, list) {
 			if (can_aggregate_with(batman_packet,
@@ -233,7 +233,7 @@ void add_bat_packet_to_list(struct bat_priv *bat_priv,
 		 * later on
 		 */
 		if ((!own_packet) &&
-		    (atomic_read(&bat_priv->aggregation_enabled)))
+		    (atomic_read(&bat_priv->aggregated_ogms)))
 			send_time += msecs_to_jiffies(MAX_AGGREGATION_MS);
 
 		new_aggregated_packet(packet_buff, packet_len,
diff --git a/drivers/staging/batman-adv/bat_sysfs.c b/drivers/staging/batman-adv/bat_sysfs.c
index 536f651..a67c54c 100644
--- a/drivers/staging/batman-adv/bat_sysfs.c
+++ b/drivers/staging/batman-adv/bat_sysfs.c
@@ -41,7 +41,7 @@ static ssize_t show_aggr_ogms(struct kobject *kobj, struct attribute *attr,
 {
 	struct device *dev = to_dev(kobj->parent);
 	struct bat_priv *bat_priv = netdev_priv(to_net_dev(dev));
-	int aggr_status = atomic_read(&bat_priv->aggregation_enabled);
+	int aggr_status = atomic_read(&bat_priv->aggregated_ogms);
 
 	return sprintf(buff, "%s\n",
 		       aggr_status == 0 ? "disabled" : "enabled");
@@ -73,15 +73,15 @@ static ssize_t store_aggr_ogms(struct kobject *kobj, struct attribute *attr,
 		return -EINVAL;
 	}
 
-	if (atomic_read(&bat_priv->aggregation_enabled) == aggr_tmp)
+	if (atomic_read(&bat_priv->aggregated_ogms) == aggr_tmp)
 		return count;
 
 	bat_info(net_dev, "Changing aggregation from: %s to: %s\n",
-		 atomic_read(&bat_priv->aggregation_enabled) == 1 ?
+		 atomic_read(&bat_priv->aggregated_ogms) == 1 ?
 		 "enabled" : "disabled", aggr_tmp == 1 ? "enabled" :
 		 "disabled");
 
-	atomic_set(&bat_priv->aggregation_enabled, (unsigned)aggr_tmp);
+	atomic_set(&bat_priv->aggregated_ogms, (unsigned)aggr_tmp);
 	return count;
 }
 
@@ -90,7 +90,7 @@ static ssize_t show_bond(struct kobject *kobj, struct attribute *attr,
 {
 	struct device *dev = to_dev(kobj->parent);
 	struct bat_priv *bat_priv = netdev_priv(to_net_dev(dev));
-	int bond_status = atomic_read(&bat_priv->bonding_enabled);
+	int bond_status = atomic_read(&bat_priv->bonding);
 
 	return sprintf(buff, "%s\n",
 		       bond_status == 0 ? "disabled" : "enabled");
@@ -122,15 +122,15 @@ static ssize_t store_bond(struct kobject *kobj, struct attribute *attr,
 		return -EINVAL;
 	}
 
-	if (atomic_read(&bat_priv->bonding_enabled) == bonding_enabled_tmp)
+	if (atomic_read(&bat_priv->bonding) == bonding_enabled_tmp)
 		return count;
 
 	bat_info(net_dev, "Changing bonding from: %s to: %s\n",
-		 atomic_read(&bat_priv->bonding_enabled) == 1 ?
+		 atomic_read(&bat_priv->bonding) == 1 ?
 		 "enabled" : "disabled",
 		 bonding_enabled_tmp == 1 ? "enabled" : "disabled");
 
-	atomic_set(&bat_priv->bonding_enabled, (unsigned)bonding_enabled_tmp);
+	atomic_set(&bat_priv->bonding, (unsigned)bonding_enabled_tmp);
 	return count;
 }
 
@@ -139,7 +139,7 @@ static ssize_t show_frag(struct kobject *kobj, struct attribute *attr,
 {
 	struct device *dev = to_dev(kobj->parent);
 	struct bat_priv *bat_priv = netdev_priv(to_net_dev(dev));
-	int frag_status = atomic_read(&bat_priv->frag_enabled);
+	int frag_status = atomic_read(&bat_priv->fragmentation);
 
 	return sprintf(buff, "%s\n",
 		       frag_status == 0 ? "disabled" : "enabled");
@@ -171,15 +171,15 @@ static ssize_t store_frag(struct kobject *kobj, struct attribute *attr,
 		return -EINVAL;
 	}
 
-	if (atomic_read(&bat_priv->frag_enabled) == frag_enabled_tmp)
+	if (atomic_read(&bat_priv->fragmentation) == frag_enabled_tmp)
 		return count;
 
 	bat_info(net_dev, "Changing fragmentation from: %s to: %s\n",
-		 atomic_read(&bat_priv->frag_enabled) == 1 ?
+		 atomic_read(&bat_priv->fragmentation) == 1 ?
 		 "enabled" : "disabled",
 		 frag_enabled_tmp == 1 ? "enabled" : "disabled");
 
-	atomic_set(&bat_priv->frag_enabled, (unsigned)frag_enabled_tmp);
+	atomic_set(&bat_priv->fragmentation, (unsigned)frag_enabled_tmp);
 	update_min_mtu(net_dev);
 	return count;
 }
diff --git a/drivers/staging/batman-adv/hard-interface.c b/drivers/staging/batman-adv/hard-interface.c
index c2ff294..ff0ac98 100644
--- a/drivers/staging/batman-adv/hard-interface.c
+++ b/drivers/staging/batman-adv/hard-interface.c
@@ -208,7 +208,7 @@ int hardif_min_mtu(struct net_device *soft_iface)
 	 * (have MTU > 1500 + BAT_HEADER_LEN) */
 	int min_mtu = ETH_DATA_LEN;
 
-	if (atomic_read(&bat_priv->frag_enabled))
+	if (atomic_read(&bat_priv->fragmentation))
 		goto out;
 
 	rcu_read_lock();
@@ -332,7 +332,7 @@ int hardif_enable_interface(struct batman_if *batman_if, char *iface_name)
 	bat_info(batman_if->soft_iface, "Adding interface: %s\n",
 		 batman_if->net_dev->name);
 
-	if (atomic_read(&bat_priv->frag_enabled) && batman_if->net_dev->mtu <
+	if (atomic_read(&bat_priv->fragmentation) && batman_if->net_dev->mtu <
 		ETH_DATA_LEN + BAT_HEADER_LEN)
 		bat_info(batman_if->soft_iface,
 			"The MTU of interface %s is too small (%i) to handle "
@@ -343,7 +343,7 @@ int hardif_enable_interface(struct batman_if *batman_if, char *iface_name)
 			batman_if->net_dev->name, batman_if->net_dev->mtu,
 			ETH_DATA_LEN + BAT_HEADER_LEN);
 
-	if (!atomic_read(&bat_priv->frag_enabled) && batman_if->net_dev->mtu <
+	if (!atomic_read(&bat_priv->fragmentation) && batman_if->net_dev->mtu <
 		ETH_DATA_LEN + BAT_HEADER_LEN)
 		bat_info(batman_if->soft_iface,
 			"The MTU of interface %s is too small (%i) to handle "
diff --git a/drivers/staging/batman-adv/routing.c b/drivers/staging/batman-adv/routing.c
index 3946c7c..1b35486 100644
--- a/drivers/staging/batman-adv/routing.c
+++ b/drivers/staging/batman-adv/routing.c
@@ -1019,7 +1019,7 @@ struct neigh_node *find_router(struct bat_priv *bat_priv,
 	/* without bonding, the first node should
 	 * always choose the default router. */
 
-	bonding_enabled = atomic_read(&bat_priv->bonding_enabled);
+	bonding_enabled = atomic_read(&bat_priv->bonding);
 
 	if ((!recv_if) && (!bonding_enabled))
 		return orig_node->router;
@@ -1168,7 +1168,7 @@ int route_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if,
 	unicast_packet = (struct unicast_packet *)skb->data;
 
 	if (unicast_packet->packet_type == BAT_UNICAST &&
-	    atomic_read(&bat_priv->frag_enabled) &&
+	    atomic_read(&bat_priv->fragmentation) &&
 	    skb->len > batman_if->net_dev->mtu)
 		return frag_send_skb(skb, bat_priv, batman_if,
 				     dstaddr);
diff --git a/drivers/staging/batman-adv/soft-interface.c b/drivers/staging/batman-adv/soft-interface.c
index c3313d0..c903a76 100644
--- a/drivers/staging/batman-adv/soft-interface.c
+++ b/drivers/staging/batman-adv/soft-interface.c
@@ -578,12 +578,12 @@ struct net_device *softif_create(char *name)
 
 	bat_priv = netdev_priv(soft_iface);
 
-	atomic_set(&bat_priv->aggregation_enabled, 1);
-	atomic_set(&bat_priv->bonding_enabled, 0);
+	atomic_set(&bat_priv->aggregated_ogms, 1);
+	atomic_set(&bat_priv->bonding, 0);
 	atomic_set(&bat_priv->vis_mode, VIS_TYPE_CLIENT_UPDATE);
 	atomic_set(&bat_priv->orig_interval, 1000);
 	atomic_set(&bat_priv->log_level, 0);
-	atomic_set(&bat_priv->frag_enabled, 1);
+	atomic_set(&bat_priv->fragmentation, 1);
 	atomic_set(&bat_priv->bcast_queue_left, BCAST_QUEUE_LEN);
 	atomic_set(&bat_priv->batman_queue_left, BATMAN_QUEUE_LEN);
 
diff --git a/drivers/staging/batman-adv/translation-table.c b/drivers/staging/batman-adv/translation-table.c
index 681ccbd..3bc7521 100644
--- a/drivers/staging/batman-adv/translation-table.c
+++ b/drivers/staging/batman-adv/translation-table.c
@@ -79,7 +79,7 @@ void hna_local_add(struct net_device *soft_iface, uint8_t *addr)
 	required_bytes += BAT_PACKET_LEN;
 
 	if ((required_bytes > ETH_DATA_LEN) ||
-	    (atomic_read(&bat_priv->aggregation_enabled) &&
+	    (atomic_read(&bat_priv->aggregated_ogms) &&
 	     required_bytes > MAX_AGGREGATION_BYTES) ||
 	    (bat_priv->num_local_hna + 1 > 255)) {
 		bat_dbg(DBG_ROUTES, bat_priv,
diff --git a/drivers/staging/batman-adv/types.h b/drivers/staging/batman-adv/types.h
index 835d51f..4463da3 100644
--- a/drivers/staging/batman-adv/types.h
+++ b/drivers/staging/batman-adv/types.h
@@ -113,12 +113,12 @@ struct neigh_node {
 struct bat_priv {
 	atomic_t mesh_state;
 	struct net_device_stats stats;
-	atomic_t aggregation_enabled;
-	atomic_t bonding_enabled;
-	atomic_t frag_enabled;
-	atomic_t vis_mode;
-	atomic_t orig_interval;
-	atomic_t log_level;
+	atomic_t aggregated_ogms;	/* boolean */
+	atomic_t bonding;		/* boolean */
+	atomic_t fragmentation;		/* boolean */
+	atomic_t vis_mode;		/* VIS_TYPE_* */
+	atomic_t orig_interval;		/* uint */
+	atomic_t log_level;		/* uint */
 	atomic_t bcast_seqno;
 	atomic_t bcast_queue_left;
 	atomic_t batman_queue_left;
diff --git a/drivers/staging/batman-adv/unicast.c b/drivers/staging/batman-adv/unicast.c
index e58e634..5ae9593 100644
--- a/drivers/staging/batman-adv/unicast.c
+++ b/drivers/staging/batman-adv/unicast.c
@@ -318,7 +318,7 @@ int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
 	/* copy the destination for faster routing */
 	memcpy(unicast_packet->dest, orig_node->orig, ETH_ALEN);
 
-	if (atomic_read(&bat_priv->frag_enabled) &&
+	if (atomic_read(&bat_priv->fragmentation) &&
 	    data_len + sizeof(struct unicast_packet) >
 	    batman_if->net_dev->mtu) {
 		/* send frag skb decreases ttl */
-- 
1.7.2.3


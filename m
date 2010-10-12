Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Wed, 13 Oct 2010 00:22:02 +0200
Message-Id: <1286922125-18097-2-git-send-email-linus.luessing@web.de>
In-Reply-To: <1286922125-18097-1-git-send-email-linus.luessing@web.de>
References: <1286922125-18097-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 1/4] batman-adv: Unify sysfs file names with
	their bat_priv atomics
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
---
 aggregation.c    |    4 ++--
 bat_sysfs.c      |   24 ++++++++++++------------
 hard-interface.c |    6 +++---
 routing.c        |    4 ++--
 soft-interface.c |    6 +++---
 types.h          |   16 ++++++++--------
 unicast.c        |    2 +-
 7 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/aggregation.c b/aggregation.c
index 46b9c2b..05a75a6 100644
--- a/aggregation.c
+++ b/aggregation.c
@@ -200,7 +200,7 @@ void add_bat_packet_to_list(struct bat_priv *bat_priv,
 	/* find position for the packet in the forward queue */
 	spin_lock_irqsave(&bat_priv->forw_bat_list_lock, flags);
 	/* own packets are not to be aggregated */
-	if ((atomic_read(&bat_priv->aggregation_enabled)) && (!own_packet)) {
+	if ((atomic_read(&bat_priv->aggregated_ogms)) && (!own_packet)) {
 		hlist_for_each_entry(forw_packet_pos, tmp_node,
 				     &bat_priv->forw_bat_list, list) {
 			if (can_aggregate_with(batman_packet,
@@ -227,7 +227,7 @@ void add_bat_packet_to_list(struct bat_priv *bat_priv,
 		 * later on
 		 */
 		if ((!own_packet) &&
-		    (atomic_read(&bat_priv->aggregation_enabled)))
+		    (atomic_read(&bat_priv->aggregated_ogms)))
 			send_time += msecs_to_jiffies(MAX_AGGREGATION_MS);
 
 		new_aggregated_packet(packet_buff, packet_len,
diff --git a/bat_sysfs.c b/bat_sysfs.c
index 3f551f3..a11aa46 100644
--- a/bat_sysfs.c
+++ b/bat_sysfs.c
@@ -44,7 +44,7 @@ static ssize_t show_aggr_ogms(struct kobject *kobj, struct attribute *attr,
 {
 	struct device *dev = to_dev(kobj->parent);
 	struct bat_priv *bat_priv = netdev_priv(to_net_dev(dev));
-	int aggr_status = atomic_read(&bat_priv->aggregation_enabled);
+	int aggr_status = atomic_read(&bat_priv->aggregated_ogms);
 
 	return sprintf(buff, "%s\n",
 		       aggr_status == 0 ? "disabled" : "enabled");
@@ -76,15 +76,15 @@ static ssize_t store_aggr_ogms(struct kobject *kobj, struct attribute *attr,
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
 
@@ -93,7 +93,7 @@ static ssize_t show_bond(struct kobject *kobj, struct attribute *attr,
 {
 	struct device *dev = to_dev(kobj->parent);
 	struct bat_priv *bat_priv = netdev_priv(to_net_dev(dev));
-	int bond_status = atomic_read(&bat_priv->bonding_enabled);
+	int bond_status = atomic_read(&bat_priv->bonding);
 
 	return sprintf(buff, "%s\n",
 		       bond_status == 0 ? "disabled" : "enabled");
@@ -125,15 +125,15 @@ static ssize_t store_bond(struct kobject *kobj, struct attribute *attr,
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
 
@@ -142,7 +142,7 @@ static ssize_t show_frag(struct kobject *kobj, struct attribute *attr,
 {
 	struct device *dev = to_dev(kobj->parent);
 	struct bat_priv *bat_priv = netdev_priv(to_net_dev(dev));
-	int frag_status = atomic_read(&bat_priv->frag_enabled);
+	int frag_status = atomic_read(&bat_priv->fragmentation);
 
 	return sprintf(buff, "%s\n",
 		       frag_status == 0 ? "disabled" : "enabled");
@@ -174,15 +174,15 @@ static ssize_t store_frag(struct kobject *kobj, struct attribute *attr,
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
diff --git a/hard-interface.c b/hard-interface.c
index afc2c3d..3c59209 100644
--- a/hard-interface.c
+++ b/hard-interface.c
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
diff --git a/routing.c b/routing.c
index 1377f01..cc8b77f 100644
--- a/routing.c
+++ b/routing.c
@@ -1035,7 +1035,7 @@ struct neigh_node *find_router(struct orig_node *orig_node,
 		return orig_node->router;
 
 	bat_priv = netdev_priv(recv_if->soft_iface);
-	bonding_enabled = atomic_read(&bat_priv->bonding_enabled);
+	bonding_enabled = atomic_read(&bat_priv->bonding);
 
 	if (!bonding_enabled)
 		return orig_node->router;
@@ -1184,7 +1184,7 @@ int route_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if,
 	unicast_packet = (struct unicast_packet *)skb->data;
 
 	if (unicast_packet->packet_type == BAT_UNICAST &&
-	    atomic_read(&bat_priv->frag_enabled) &&
+	    atomic_read(&bat_priv->fragmentation) &&
 	    skb->len > batman_if->net_dev->mtu)
 		return frag_send_skb(skb, bat_priv, batman_if,
 				     dstaddr);
diff --git a/soft-interface.c b/soft-interface.c
index 683ec5f..7a899b5 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -587,14 +587,14 @@ struct net_device *softif_create(char *name)
 
 	bat_priv = netdev_priv(soft_iface);
 
-	atomic_set(&bat_priv->aggregation_enabled, 1);
-	atomic_set(&bat_priv->bonding_enabled, 0);
+	atomic_set(&bat_priv->aggregated_ogms, 1);
+	atomic_set(&bat_priv->bonding, 0);
 	atomic_set(&bat_priv->vis_mode, VIS_TYPE_CLIENT_UPDATE);
 	atomic_set(&bat_priv->gw_mode, GW_MODE_OFF);
 	atomic_set(&bat_priv->gw_class, 0);
 	atomic_set(&bat_priv->orig_interval, 1000);
 	atomic_set(&bat_priv->log_level, 0);
-	atomic_set(&bat_priv->frag_enabled, 1);
+	atomic_set(&bat_priv->fragmentation, 1);
 	atomic_set(&bat_priv->bcast_queue_left, BCAST_QUEUE_LEN);
 	atomic_set(&bat_priv->batman_queue_left, BATMAN_QUEUE_LEN);
 
diff --git a/types.h b/types.h
index dec2791..44b3c07 100644
--- a/types.h
+++ b/types.h
@@ -124,14 +124,14 @@ struct neigh_node {
 struct bat_priv {
 	atomic_t mesh_state;
 	struct net_device_stats stats;
-	atomic_t aggregation_enabled;
-	atomic_t bonding_enabled;
-	atomic_t frag_enabled;
-	atomic_t vis_mode;
-	atomic_t gw_mode;
-	atomic_t gw_class;
-	atomic_t orig_interval;
-	atomic_t log_level;
+	atomic_t aggregated_ogms;	/* boolean */
+	atomic_t bonding;		/* boolean */
+	atomic_t fragmentation;		/* boolean */
+	atomic_t vis_mode;		/* VIS_TYPE_* */
+	atomic_t gw_mode;		/* GW_MODE_* */
+	atomic_t gw_class;		/* uint */
+	atomic_t orig_interval;		/* uint */
+	atomic_t log_level;		/* uint */
 	atomic_t bcast_seqno;
 	atomic_t bcast_queue_left;
 	atomic_t batman_queue_left;
diff --git a/unicast.c b/unicast.c
index bca69f6..6ceaf87 100644
--- a/unicast.c
+++ b/unicast.c
@@ -322,7 +322,7 @@ int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
 	/* copy the destination for faster routing */
 	memcpy(unicast_packet->dest, orig_node->orig, ETH_ALEN);
 
-	if (atomic_read(&bat_priv->frag_enabled) &&
+	if (atomic_read(&bat_priv->fragmentation) &&
 	    data_len + sizeof(struct unicast_packet) >
 	    batman_if->net_dev->mtu) {
 		/* send frag skb decreases ttl */
-- 
1.7.1


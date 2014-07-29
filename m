Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Wed, 30 Jul 2014 00:39:38 +0200
Message-Id: <1406673579-20110-3-git-send-email-linus.luessing@web.de>
In-Reply-To: <1406673579-20110-1-git-send-email-linus.luessing@web.de>
References: <1406673579-20110-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv6 2/3] batman-adv: Adding 'mcast' log level
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

This patch adds an 'mcast' log level. Currently, it will print changes
relevant to a nodes own multicast flag changes.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 multicast.c      |  152 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 soft-interface.c |    5 ++
 types.h          |   17 ++++++
 3 files changed, 169 insertions(+), 5 deletions(-)

diff --git a/multicast.c b/multicast.c
index c05f64a..2a80997 100644
--- a/multicast.c
+++ b/multicast.c
@@ -292,6 +292,123 @@ static bool batadv_mcast_has_bridge(struct batadv_priv *bat_priv)
 }
 
 /**
+ * batadv_mcast_querier_log - debug output regarding the querier status on link
+ * @bat_priv: the bat priv with all the soft interface information
+ * @str_proto: a string for the querier protocol (e.g. "IGMP" or "MLD")
+ * @old_querier: the previous querier state on our link
+ * @new_querier: the new querier state on our link
+ *
+ * Outputs debug messages to the logging facility with log level 'mcast'
+ * regarding changes to the querier status on the link which are relevant
+ * to our multicast optimizations.
+ *
+ * Usually this is about whether a querier appeared or vanished in
+ * our mesh or whether the querier is in the suboptimal position of being
+ * behind our local bridge segment.
+ *
+ * This is only interesting for nodes with a bridge on top of their
+ * soft interface.
+ */
+static void
+batadv_mcast_querier_log(struct batadv_priv *bat_priv, char *str_proto,
+			 struct batadv_mcast_querier_state *old_querier,
+			 struct batadv_mcast_querier_state *new_querier)
+{
+	if (!old_querier->exists && new_querier->exists)
+		batadv_dbg(BATADV_DBG_MCAST, bat_priv,
+			   "%s Querier appeared (good!)\n", str_proto);
+	else if (old_querier->exists && !new_querier->exists)
+		batadv_dbg(BATADV_DBG_MCAST, bat_priv,
+			   "%s Querier disappeared (bad)\n", str_proto);
+	else if (!bat_priv->mcast.bridged && !new_querier->exists)
+		batadv_dbg(BATADV_DBG_MCAST, bat_priv,
+			   "Note: No %s Querier present\n", str_proto);
+
+	if (!new_querier->exists)
+		return;
+
+	if (!old_querier->shadowing && new_querier->shadowing)
+		batadv_dbg(BATADV_DBG_MCAST, bat_priv,
+			   "%s Querier is behind our bridged segment: Might shadow listeners (bad)\n",
+			   str_proto);
+	else if (old_querier->shadowing && !new_querier->shadowing)
+		batadv_dbg(BATADV_DBG_MCAST, bat_priv,
+			   "%s Querier is not behind our bridged segment (good!)\n",
+			   str_proto);
+}
+
+/**
+ * batadv_mcast_bridge_log - debug output for topology changes in bridged setups
+ * @bat_priv: the bat priv with all the soft interface information
+ * @bridged: a flag about whether the soft interface is currently bridged or not
+ * @querier_ipv4: (maybe) new status of a potential, selected IGMP querier
+ * @querier_ipv6: (maybe) new status of a potential, selected MLD querier
+ *
+ * If no bridges are ever used on this node, then this function does nothing.
+ *
+ * Otherwise this function outputs debug information to the 'mcast' log level
+ * which might be relevant to our multicast optimizations.
+ *
+ * More precisely, it outputs information when a bridge interface is added or
+ * removed from a soft interface. And when a bridge is present, it further
+ * outputs information about the querier state which is relevant for the
+ * multicast flags this node is going to set.
+ */
+static void
+batadv_mcast_bridge_log(struct batadv_priv *bat_priv, bool bridged,
+			struct batadv_mcast_querier_state *querier_ipv4,
+			struct batadv_mcast_querier_state *querier_ipv6)
+{
+	if (!bat_priv->mcast.bridged && bridged)
+		batadv_dbg(BATADV_DBG_MCAST, bat_priv,
+			   "Bridge added: Setting U-flag\n");
+	else if (bat_priv->mcast.bridged && !bridged)
+		batadv_dbg(BATADV_DBG_MCAST, bat_priv,
+			   "Bridge removed: Unsetting U-flag\n");
+	if (!bridged)
+		return;
+
+	batadv_mcast_querier_log(bat_priv, "IGMP",
+				 &bat_priv->mcast.querier_ipv4, querier_ipv4);
+	batadv_mcast_querier_log(bat_priv, "MLD",
+				 &bat_priv->mcast.querier_ipv6, querier_ipv6);
+}
+
+/**
+ * batadv_mcast_flags_logs - output debug information about mcast flag changes
+ * @bat_priv: the bat priv with all the soft interface information
+ * @mcast_flags: flags indicating the new multicast state
+ *
+ * Whenever the multicast flags this nodes announces changes (@mcast_flags vs.
+ * bat_priv->mcast.flags), this notifies userspace via the 'mcast' log level.
+ */
+static void batadv_mcast_flags_log(struct batadv_priv *bat_priv, uint8_t flags)
+{
+	char str_undefined[] = "<undefined>";
+	char str_flags[] = "[...]";
+	char *str_flags_old = str_undefined;
+	uint8_t old_flags = bat_priv->mcast.flags;
+
+	if (!bat_priv->mcast.enabled)
+		goto print;
+
+	str_flags_old = str_flags;
+
+	sprintf(str_flags_old, "[%c%c%c]",
+		old_flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES ? 'U' : '.',
+		old_flags & BATADV_MCAST_WANT_ALL_IPV4 ? '4' : '.',
+		old_flags & BATADV_MCAST_WANT_ALL_IPV6 ? '6' : '.');
+
+print:
+	batadv_dbg(BATADV_DBG_MCAST, bat_priv,
+		   "Changing multicast flags from '%s' to '[%c%c%c]'\n",
+		   str_flags_old,
+		   flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES ? 'U' : '.',
+		   flags & BATADV_MCAST_WANT_ALL_IPV4 ? '4' : '.',
+		   flags & BATADV_MCAST_WANT_ALL_IPV6 ? '6' : '.');
+}
+
+/**
  * batadv_mcast_mla_tvlv_update - update multicast tvlv
  * @bat_priv: the bat priv with all the soft interface information
  *
@@ -304,18 +421,33 @@ static bool batadv_mcast_has_bridge(struct batadv_priv *bat_priv)
 static bool batadv_mcast_mla_tvlv_update(struct batadv_priv *bat_priv)
 {
 	struct batadv_tvlv_mcast_data mcast_data;
+	struct batadv_mcast_querier_state querier_ipv4, querier_ipv6;
 	struct net_device *dev = bat_priv->soft_iface;
+	bool bridged;
 
 	mcast_data.flags = BATADV_NO_FLAGS;
 	memset(mcast_data.reserved, 0, sizeof(mcast_data.reserved));
+	memset(&querier_ipv4, 0, sizeof(querier_ipv4));
+	memset(&querier_ipv6, 0, sizeof(querier_ipv6));
 
-	if (!batadv_mcast_has_bridge(bat_priv))
+	bridged = batadv_mcast_has_bridge(bat_priv);
+	if (!bridged)
 		goto update;
 
 #if !IS_ENABLED(CONFIG_BRIDGE_IGMP_SNOOPING)
 	pr_warn_once("No bridge IGMP snooping compiled - multicast optimizations disabled\n");
 #endif
 
+	querier_ipv4 = (struct batadv_mcast_querier_state){
+		.exists = br_multicast_has_querier_anywhere(dev, ETH_P_IP),
+		.shadowing = br_multicast_has_querier_adjacent(dev, ETH_P_IP),
+	};
+
+	querier_ipv6 = (struct batadv_mcast_querier_state){
+		.exists = br_multicast_has_querier_anywhere(dev, ETH_P_IPV6),
+		.shadowing = br_multicast_has_querier_adjacent(dev, ETH_P_IPV6),
+	};
+
 	mcast_data.flags |= BATADV_MCAST_WANT_ALL_UNSNOOPABLES;
 
 	/* 1) If no querier exists at all, then multicast listeners on
@@ -327,21 +459,31 @@ static bool batadv_mcast_mla_tvlv_update(struct batadv_priv *bat_priv)
 	 * In both cases, we will signalize other batman nodes that
 	 * we need all multicast traffic of the according protocol.
 	 */
-	if (!br_multicast_has_querier_anywhere(dev, ETH_P_IP) ||
-	    br_multicast_has_querier_adjacent(dev, ETH_P_IP))
+	if (!querier_ipv4.exists || querier_ipv4.shadowing)
 		mcast_data.flags |= BATADV_MCAST_WANT_ALL_IPV4;
 
-	if (!br_multicast_has_querier_anywhere(dev, ETH_P_IPV6) ||
-	    br_multicast_has_querier_adjacent(dev, ETH_P_IPV6))
+	if (!querier_ipv6.exists || querier_ipv6.shadowing)
 		mcast_data.flags |= BATADV_MCAST_WANT_ALL_IPV6;
 
 update:
+	batadv_mcast_bridge_log(bat_priv, bridged, &querier_ipv4,
+				&querier_ipv6);
+
+	if (memcmp(&bat_priv->mcast.querier_ipv4, &querier_ipv4,
+		   sizeof(querier_ipv4)))
+		bat_priv->mcast.querier_ipv4 = querier_ipv4;
+	if (memcmp(&bat_priv->mcast.querier_ipv6, &querier_ipv6,
+		   sizeof(querier_ipv6)))
+		bat_priv->mcast.querier_ipv6 = querier_ipv6;
+
 	if (!bat_priv->mcast.enabled ||
 	    mcast_data.flags != bat_priv->mcast.flags) {
+		batadv_mcast_flags_log(bat_priv, mcast_data.flags);
 		batadv_tvlv_container_register(bat_priv, BATADV_TVLV_MCAST, 1,
 					       &mcast_data, sizeof(mcast_data));
 		bat_priv->mcast.flags = mcast_data.flags;
 		bat_priv->mcast.enabled = true;
+		bat_priv->mcast.bridged = bridged;
 	}
 
 	return !(mcast_data.flags &
diff --git a/soft-interface.c b/soft-interface.c
index 9bf382d..0265a58 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -745,7 +745,12 @@ static int batadv_softif_init_late(struct net_device *dev)
 	atomic_set(&bat_priv->distributed_arp_table, 1);
 #endif
 #ifdef CONFIG_BATMAN_ADV_MCAST
+	bat_priv->mcast.querier_ipv4 = (struct batadv_mcast_querier_state){
+		.exists = false, .shadowing = false };
+	bat_priv->mcast.querier_ipv6 = (struct batadv_mcast_querier_state){
+		.exists = false, .shadowing = false };
 	bat_priv->mcast.flags = BATADV_NO_FLAGS;
+	bat_priv->mcast.bridged = false;
 	atomic_set(&bat_priv->multicast_mode, 1);
 	atomic_set(&bat_priv->mcast.num_disabled, 0);
 	atomic_set(&bat_priv->mcast.num_want_all_unsnoopables, 0);
diff --git a/types.h b/types.h
index 8854c05..b27c79d 100644
--- a/types.h
+++ b/types.h
@@ -625,14 +625,28 @@ struct batadv_priv_dat {
 
 #ifdef CONFIG_BATMAN_ADV_MCAST
 /**
+ * struct batadv_mcast_querier_state - IGMP/MLD querier state when bridged
+ * @exists: whether a querier exists in the mesh
+ * @shadowing: if a querier exists, whether it is potentially shadowing
+ *  multicast listeners (i.e. querier is behind our own bridge segment)
+ */
+struct batadv_mcast_querier_state {
+	bool exists;
+	bool shadowing;
+};
+
+/**
  * struct batadv_priv_mcast - per mesh interface mcast data
  * @mla_list: list of multicast addresses we are currently announcing via TT
  * @want_all_unsnoopables_list: a list of orig_nodes wanting all unsnoopable
  *  multicast traffic
  * @want_all_ipv4_list: a list of orig_nodes wanting all IPv4 multicast traffic
  * @want_all_ipv6_list: a list of orig_nodes wanting all IPv6 multicast traffic
+ * @querier_ipv4: the current state of an IGMP querier in the mesh (if bridged)
+ * @querier_ipv6: the current state of an MLD querier in the mesh (if bridged)
  * @flags: the flags we have last sent in our mcast tvlv
  * @enabled: whether the multicast tvlv is currently enabled
+ * @bridged: whether the soft interface currently has a bridge on top
  * @num_disabled: number of nodes that have no mcast tvlv
  * @num_want_all_unsnoopables: number of nodes wanting unsnoopable IP traffic
  * @num_want_all_ipv4: counter for items in want_all_ipv4_list
@@ -645,8 +659,11 @@ struct batadv_priv_mcast {
 	struct hlist_head want_all_unsnoopables_list;
 	struct hlist_head want_all_ipv4_list;
 	struct hlist_head want_all_ipv6_list;
+	struct batadv_mcast_querier_state querier_ipv4;
+	struct batadv_mcast_querier_state querier_ipv6;
 	uint8_t flags;
 	bool enabled;
+	bool bridged;
 	atomic_t num_disabled;
 	atomic_t num_want_all_unsnoopables;
 	atomic_t num_want_all_ipv4;
-- 
1.7.10.4


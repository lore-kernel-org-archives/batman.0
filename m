Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sun,  7 Sep 2014 07:42:38 +0200
Message-Id: <1410068560-7829-3-git-send-email-linus.luessing@web.de>
In-Reply-To: <1410068560-7829-1-git-send-email-linus.luessing@web.de>
References: <1410068560-7829-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv9 2/4] batman-adv: Adding 'mcast' log level
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
 multicast.c      |  142 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 soft-interface.c |    5 ++
 types.h          |   17 +++++++
 3 files changed, 159 insertions(+), 5 deletions(-)

diff --git a/multicast.c b/multicast.c
index cbe1b6c..341559e 100644
--- a/multicast.c
+++ b/multicast.c
@@ -291,6 +291,120 @@ static bool batadv_mcast_has_bridge(struct batadv_priv *bat_priv)
 }
 
 /**
+ * batadv_mcast_querier_log - debug output regarding the querier status on link
+ * @bat_priv: the bat priv with all the soft interface information
+ * @str_proto: a string for the querier protocol (e.g. "IGMP" or "MLD")
+ * @old_state: the previous querier state on our link
+ * @new_state: the new querier state on our link
+ *
+ * Outputs debug messages to the logging facility with log level 'mcast'
+ * regarding changes to the querier status on the link which are relevant
+ * to our multicast optimizations.
+ *
+ * Usually this is about whether a querier appeared or vanished in
+ * our mesh or whether the querier is in the suboptimal position of being
+ * behind our local bridge segment: Snooping switches will directly
+ * forward listener reports to the querier, therefore batman-adv and
+ * the bridge will potentially not see these listeners - the querier is
+ * potentially shadowing listeners from us then.
+ *
+ * This is only interesting for nodes with a bridge on top of their
+ * soft interface.
+ */
+static void
+batadv_mcast_querier_log(struct batadv_priv *bat_priv, char *str_proto,
+			 struct batadv_mcast_querier_state *old_state,
+			 struct batadv_mcast_querier_state *new_state)
+{
+	if (!old_state->exists && new_state->exists)
+		batadv_dbg(BATADV_DBG_MCAST, bat_priv,
+			   "%s Querier appeared\n", str_proto);
+	else if (old_state->exists && !new_state->exists)
+		batadv_dbg(BATADV_DBG_MCAST, bat_priv,
+			   "%s Querier disappeared\n", str_proto);
+	else if (!bat_priv->mcast.bridged && !new_state->exists)
+		batadv_dbg(BATADV_DBG_MCAST, bat_priv,
+			   "Note: No %s Querier present\n", str_proto);
+
+	if (new_state->exists) {
+		if ((!old_state->shadowing && new_state->shadowing) ||
+		    (!old_state->exists && new_state->shadowing))
+			batadv_dbg(BATADV_DBG_MCAST, bat_priv,
+				   "%s Querier is behind our bridged segment: Might shadow listeners\n",
+				   str_proto);
+		else if (old_state->shadowing && !new_state->shadowing)
+			batadv_dbg(BATADV_DBG_MCAST, bat_priv,
+				   "%s Querier is not behind our bridged segment\n",
+				   str_proto);
+	}
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
+			   "Bridge added: Setting Unsnoopables(U)-flag\n");
+	else if (bat_priv->mcast.bridged && !bridged)
+		batadv_dbg(BATADV_DBG_MCAST, bat_priv,
+			   "Bridge removed: Unsetting Unsnoopables(U)-flag\n");
+
+	if (bridged) {
+		batadv_mcast_querier_log(bat_priv, "IGMP",
+					 &bat_priv->mcast.querier_ipv4,
+					 querier_ipv4);
+		batadv_mcast_querier_log(bat_priv, "MLD",
+					 &bat_priv->mcast.querier_ipv6,
+					 querier_ipv6);
+	}
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
+	uint8_t old_flags = bat_priv->mcast.flags;
+	char str_old_flags[] = "[...]";
+
+	sprintf(str_old_flags, "[%c%c%c]",
+		old_flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES ? 'U' : '.',
+		old_flags & BATADV_MCAST_WANT_ALL_IPV4 ? '4' : '.',
+		old_flags & BATADV_MCAST_WANT_ALL_IPV6 ? '6' : '.');
+
+	batadv_dbg(BATADV_DBG_MCAST, bat_priv,
+		   "Changing multicast flags from '%s' to '[%c%c%c]'\n",
+		   bat_priv->mcast.enabled ? str_old_flags : "<undefined>",
+		   flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES ? 'U' : '.',
+		   flags & BATADV_MCAST_WANT_ALL_IPV4 ? '4' : '.',
+		   flags & BATADV_MCAST_WANT_ALL_IPV6 ? '6' : '.');
+}
+
+/**
  * batadv_mcast_mla_tvlv_update - update multicast tvlv
  * @bat_priv: the bat priv with all the soft interface information
  *
@@ -303,18 +417,28 @@ static bool batadv_mcast_has_bridge(struct batadv_priv *bat_priv)
 static bool batadv_mcast_mla_tvlv_update(struct batadv_priv *bat_priv)
 {
 	struct batadv_tvlv_mcast_data mcast_data;
+	struct batadv_mcast_querier_state querier4 = {false, false};
+	struct batadv_mcast_querier_state querier6 = {false, false};
 	struct net_device *dev = bat_priv->soft_iface;
+	bool bridged;
 
 	mcast_data.flags = BATADV_NO_FLAGS;
 	memset(mcast_data.reserved, 0, sizeof(mcast_data.reserved));
 
-	if (!batadv_mcast_has_bridge(bat_priv))
+	bridged = batadv_mcast_has_bridge(bat_priv);
+	if (!bridged)
 		goto update;
 
 #if !IS_ENABLED(CONFIG_BRIDGE_IGMP_SNOOPING)
 	pr_warn_once("No bridge IGMP snooping compiled - multicast optimizations disabled\n");
 #endif
 
+	querier4.exists = br_multicast_has_querier_anywhere(dev, ETH_P_IP);
+	querier4.shadowing = br_multicast_has_querier_adjacent(dev, ETH_P_IP);
+
+	querier6.exists = br_multicast_has_querier_anywhere(dev, ETH_P_IPV6);
+	querier6.shadowing = br_multicast_has_querier_adjacent(dev, ETH_P_IPV6);
+
 	mcast_data.flags |= BATADV_MCAST_WANT_ALL_UNSNOOPABLES;
 
 	/* 1) If no querier exists at all, then multicast listeners on
@@ -326,21 +450,29 @@ static bool batadv_mcast_mla_tvlv_update(struct batadv_priv *bat_priv)
 	 * In both cases, we will signalize other batman nodes that
 	 * we need all multicast traffic of the according protocol.
 	 */
-	if (!br_multicast_has_querier_anywhere(dev, ETH_P_IP) ||
-	    br_multicast_has_querier_adjacent(dev, ETH_P_IP))
+	if (!querier4.exists || querier4.shadowing)
 		mcast_data.flags |= BATADV_MCAST_WANT_ALL_IPV4;
 
-	if (!br_multicast_has_querier_anywhere(dev, ETH_P_IPV6) ||
-	    br_multicast_has_querier_adjacent(dev, ETH_P_IPV6))
+	if (!querier6.exists || querier6.shadowing)
 		mcast_data.flags |= BATADV_MCAST_WANT_ALL_IPV6;
 
 update:
+	batadv_mcast_bridge_log(bat_priv, bridged, &querier4, &querier6);
+
+	bat_priv->mcast.querier_ipv4.exists = querier4.exists;
+	bat_priv->mcast.querier_ipv4.shadowing = querier4.shadowing;
+
+	bat_priv->mcast.querier_ipv6.exists = querier6.exists;
+	bat_priv->mcast.querier_ipv6.shadowing = querier6.shadowing;
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
index 9bf382d..d4d892c 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -745,7 +745,12 @@ static int batadv_softif_init_late(struct net_device *dev)
 	atomic_set(&bat_priv->distributed_arp_table, 1);
 #endif
 #ifdef CONFIG_BATMAN_ADV_MCAST
+	bat_priv->mcast.querier_ipv4.exists = false;
+	bat_priv->mcast.querier_ipv4.shadowing = false;
+	bat_priv->mcast.querier_ipv6.exists = false;
+	bat_priv->mcast.querier_ipv6.shadowing = false;
 	bat_priv->mcast.flags = BATADV_NO_FLAGS;
+	bat_priv->mcast.bridged = false;
 	atomic_set(&bat_priv->multicast_mode, 1);
 	atomic_set(&bat_priv->mcast.num_disabled, 0);
 	atomic_set(&bat_priv->mcast.num_want_all_unsnoopables, 0);
diff --git a/types.h b/types.h
index 462a70c..bd56fc1 100644
--- a/types.h
+++ b/types.h
@@ -623,14 +623,28 @@ struct batadv_priv_dat {
 
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
@@ -643,8 +657,11 @@ struct batadv_priv_mcast {
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


Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri,  1 Jul 2016 15:09:08 +0200
Message-Id: <1467378549-9646-17-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1467378549-9646-1-git-send-email-sw@simonwunderlich.de>
References: <1467378549-9646-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 16/17] batman-adv: Adding logging of mcast
	flag changes
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>

From: Linus Lüssing <linus.luessing@c0d3.blue>

With this patch changes relevant to a node's own multicast flags are
printed to the 'mcast' log level.

Tested-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/main.h           |   4 +-
 net/batman-adv/multicast.c      | 133 +++++++++++++++++++++++++++++++++++++++-
 net/batman-adv/soft-interface.c |   4 ++
 net/batman-adv/types.h          |   4 ++
 4 files changed, 142 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index c356d91..cd83e28 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -231,6 +231,7 @@ __be32 batadv_skb_crc32(struct sk_buff *skb, u8 *payload_ptr);
  * @BATADV_DBG_BLA: bridge loop avoidance messages
  * @BATADV_DBG_DAT: ARP snooping and DAT related messages
  * @BATADV_DBG_NC: network coding related messages
+ * @BATADV_DBG_MCAST: multicast related messages
  * @BATADV_DBG_ALL: the union of all the above log levels
  */
 enum batadv_dbg_level {
@@ -240,7 +241,8 @@ enum batadv_dbg_level {
 	BATADV_DBG_BLA    = BIT(3),
 	BATADV_DBG_DAT    = BIT(4),
 	BATADV_DBG_NC	  = BIT(5),
-	BATADV_DBG_ALL    = 63,
+	BATADV_DBG_MCAST  = BIT(6),
+	BATADV_DBG_ALL    = 127,
 };
 
 #ifdef CONFIG_BATMAN_ADV_DEBUG
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index eb30316..2d1a896 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -33,6 +33,7 @@
 #include <linux/in6.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
+#include <linux/kernel.h>
 #include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/lockdep.h>
@@ -334,6 +335,122 @@ static bool batadv_mcast_has_bridge(struct batadv_priv *bat_priv)
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
+		batadv_info(bat_priv->soft_iface, "%s Querier appeared\n",
+			    str_proto);
+	else if (old_state->exists && !new_state->exists)
+		batadv_info(bat_priv->soft_iface,
+			    "%s Querier disappeared - multicast optimizations disabled\n",
+			    str_proto);
+	else if (!bat_priv->mcast.bridged && !new_state->exists)
+		batadv_info(bat_priv->soft_iface,
+			    "No %s Querier present - multicast optimizations disabled\n",
+			    str_proto);
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
+ * @flags: flags indicating the new multicast state
+ *
+ * Whenever the multicast flags this nodes announces changes (@mcast_flags vs.
+ * bat_priv->mcast.flags), this notifies userspace via the 'mcast' log level.
+ */
+static void batadv_mcast_flags_log(struct batadv_priv *bat_priv, u8 flags)
+{
+	u8 old_flags = bat_priv->mcast.flags;
+	char str_old_flags[] = "[...]";
+
+	sprintf(str_old_flags, "[%c%c%c]",
+		(old_flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES) ? 'U' : '.',
+		(old_flags & BATADV_MCAST_WANT_ALL_IPV4) ? '4' : '.',
+		(old_flags & BATADV_MCAST_WANT_ALL_IPV6) ? '6' : '.');
+
+	batadv_dbg(BATADV_DBG_MCAST, bat_priv,
+		   "Changing multicast flags from '%s' to '[%c%c%c]'\n",
+		   bat_priv->mcast.enabled ? str_old_flags : "<undefined>",
+		   (flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES) ? 'U' : '.',
+		   (flags & BATADV_MCAST_WANT_ALL_IPV4) ? '4' : '.',
+		   (flags & BATADV_MCAST_WANT_ALL_IPV6) ? '6' : '.');
+}
+
+/**
  * batadv_mcast_mla_tvlv_update - update multicast tvlv
  * @bat_priv: the bat priv with all the soft interface information
  *
@@ -349,12 +466,13 @@ static bool batadv_mcast_mla_tvlv_update(struct batadv_priv *bat_priv)
 	struct batadv_mcast_querier_state querier4 = {false, false};
 	struct batadv_mcast_querier_state querier6 = {false, false};
 	struct net_device *dev = bat_priv->soft_iface;
+	bool bridged;
 
 	mcast_data.flags = BATADV_NO_FLAGS;
 	memset(mcast_data.reserved, 0, sizeof(mcast_data.reserved));
 
-	bat_priv->mcast.bridged = batadv_mcast_has_bridge(bat_priv);
-	if (!bat_priv->mcast.bridged)
+	bridged = batadv_mcast_has_bridge(bat_priv);
+	if (!bridged)
 		goto update;
 
 #if !IS_ENABLED(CONFIG_BRIDGE_IGMP_SNOOPING)
@@ -385,8 +503,19 @@ static bool batadv_mcast_mla_tvlv_update(struct batadv_priv *bat_priv)
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
+	bat_priv->mcast.bridged = bridged;
+
 	if (!bat_priv->mcast.enabled ||
 	    mcast_data.flags != bat_priv->mcast.flags) {
+		batadv_mcast_flags_log(bat_priv, mcast_data.flags);
 		batadv_tvlv_container_register(bat_priv, BATADV_TVLV_MCAST, 2,
 					       &mcast_data, sizeof(mcast_data));
 		bat_priv->mcast.flags = mcast_data.flags;
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 81665b1..b60999d 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -808,6 +808,10 @@ static int batadv_softif_init_late(struct net_device *dev)
 	atomic_set(&bat_priv->distributed_arp_table, 1);
 #endif
 #ifdef CONFIG_BATMAN_ADV_MCAST
+	bat_priv->mcast.querier_ipv4.exists = false;
+	bat_priv->mcast.querier_ipv4.shadowing = false;
+	bat_priv->mcast.querier_ipv6.exists = false;
+	bat_priv->mcast.querier_ipv6.shadowing = false;
 	bat_priv->mcast.flags = BATADV_NO_FLAGS;
 	atomic_set(&bat_priv->multicast_mode, 1);
 	atomic_set(&bat_priv->mcast.num_disabled, 0);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 83303c2..ab863a5 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -772,6 +772,8 @@ struct batadv_mcast_querier_state {
  *  multicast traffic
  * @want_all_ipv4_list: a list of orig_nodes wanting all IPv4 multicast traffic
  * @want_all_ipv6_list: a list of orig_nodes wanting all IPv6 multicast traffic
+ * @querier_ipv4: the current state of an IGMP querier in the mesh
+ * @querier_ipv6: the current state of an MLD querier in the mesh
  * @flags: the flags we have last sent in our mcast tvlv
  * @enabled: whether the multicast tvlv is currently enabled
  * @bridged: whether the soft interface has a bridge on top
@@ -787,6 +789,8 @@ struct batadv_priv_mcast {
 	struct hlist_head want_all_unsnoopables_list;
 	struct hlist_head want_all_ipv4_list;
 	struct hlist_head want_all_ipv6_list;
+	struct batadv_mcast_querier_state querier_ipv4;
+	struct batadv_mcast_querier_state querier_ipv6;
 	u8 flags;
 	bool enabled;
 	bool bridged;
-- 
2.8.1


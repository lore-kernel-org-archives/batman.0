Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 13 Feb 2019 10:55:21 +0100
Message-Id: <20190213095524.10147-19-sw@simonwunderlich.de>
In-Reply-To: <20190213095524.10147-1-sw@simonwunderlich.de>
References: <20190213095524.10147-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 18/21] batman-adv: Add orig_interval mesh
 genl configuration
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

The OGM packets are transmitted every orig_interval milliseconds. This
value can be changed using the configuration interface.

The BATADV_CMD_SET_MESH/BATADV_CMD_GET_MESH commands allow to set/get the
configuration of this feature using the u32 BATADV_ATTR_ORIG_INTERVAL
attribute.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 include/uapi/linux/batman_adv.h |  6 ++++++
 net/batman-adv/netlink.c        | 17 +++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index a4239c147bde..6bedd4889c37 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -471,6 +471,12 @@ enum batadv_nl_attrs {
 	 */
 	BATADV_ATTR_NETWORK_CODING_ENABLED,
 
+	/**
+	 * @BATADV_ATTR_ORIG_INTERVAL: defines the interval in milliseconds in
+	 *  which batman sends its protocol messages.
+	 */
+	BATADV_ATTR_ORIG_INTERVAL,
+
 	/* add attributes above here, update the policy in netlink.c */
 
 	/**
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 6f01f92e6ab3..e25c139ba0e1 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -158,6 +158,7 @@ static const struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_LOG_LEVEL]			= { .type = NLA_U32 },
 	[BATADV_ATTR_MULTICAST_FORCEFLOOD_ENABLED]	= { .type = NLA_U8 },
 	[BATADV_ATTR_NETWORK_CODING_ENABLED]	= { .type = NLA_U8 },
+	[BATADV_ATTR_ORIG_INTERVAL]		= { .type = NLA_U32 },
 };
 
 /**
@@ -358,6 +359,10 @@ static int batadv_netlink_mesh_fill(struct sk_buff *msg,
 		goto nla_put_failure;
 #endif /* CONFIG_BATMAN_ADV_NC */
 
+	if (nla_put_u32(msg, BATADV_ATTR_ORIG_INTERVAL,
+			atomic_read(&bat_priv->orig_interval)))
+		goto nla_put_failure;
+
 	if (primary_if)
 		batadv_hardif_put(primary_if);
 
@@ -596,6 +601,18 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 	}
 #endif /* CONFIG_BATMAN_ADV_NC */
 
+	if (info->attrs[BATADV_ATTR_ORIG_INTERVAL]) {
+		u32 orig_interval;
+
+		attr = info->attrs[BATADV_ATTR_ORIG_INTERVAL];
+		orig_interval = nla_get_u32(attr);
+
+		orig_interval = min_t(u32, orig_interval, INT_MAX);
+		orig_interval = max_t(u32, orig_interval, 2 * BATADV_JITTER);
+
+		atomic_set(&bat_priv->orig_interval, orig_interval);
+	}
+
 	batadv_netlink_notify_mesh(bat_priv);
 
 	return 0;
-- 
2.11.0


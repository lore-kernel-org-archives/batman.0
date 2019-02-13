Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 13 Feb 2019 10:55:22 +0100
Message-Id: <20190213095524.10147-20-sw@simonwunderlich.de>
In-Reply-To: <20190213095524.10147-1-sw@simonwunderlich.de>
References: <20190213095524.10147-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 19/21] batman-adv: Add elp_interval hardif
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

The ELP packets are transmitted every elp_interval milliseconds on an
slave/hard-interface. This value can be changed using the configuration
interface.

The BATADV_CMD_SET_HARDIF/BATADV_CMD_GET_HARDIF commands allow to set/get
the configuration of this feature using the u32 BATADV_ATTR_ELP_INTERVAL
attribute.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 include/uapi/linux/batman_adv.h |  6 ++++++
 net/batman-adv/netlink.c        | 17 +++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index 6bedd4889c37..f966e497361b 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -477,6 +477,12 @@ enum batadv_nl_attrs {
 	 */
 	BATADV_ATTR_ORIG_INTERVAL,
 
+	/**
+	 * @BATADV_ATTR_ELP_INTERVAL: defines the interval in milliseconds in
+	 *  which batman emits probing packets for neighbor sensing (ELP).
+	 */
+	BATADV_ATTR_ELP_INTERVAL,
+
 	/* add attributes above here, update the policy in netlink.c */
 
 	/**
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index e25c139ba0e1..09187e6e92a3 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -159,6 +159,7 @@ static const struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_MULTICAST_FORCEFLOOD_ENABLED]	= { .type = NLA_U8 },
 	[BATADV_ATTR_NETWORK_CODING_ENABLED]	= { .type = NLA_U8 },
 	[BATADV_ATTR_ORIG_INTERVAL]		= { .type = NLA_U32 },
+	[BATADV_ATTR_ELP_INTERVAL]		= { .type = NLA_U32 },
 };
 
 /**
@@ -825,6 +826,12 @@ static int batadv_netlink_hardif_fill(struct sk_buff *msg,
 			goto nla_put_failure;
 	}
 
+#ifdef CONFIG_BATMAN_ADV_BATMAN_V
+	if (nla_put_u32(msg, BATADV_ATTR_ELP_INTERVAL,
+			atomic_read(&hard_iface->bat_v.elp_interval)))
+		goto nla_put_failure;
+#endif /* CONFIG_BATMAN_ADV_BATMAN_V */
+
 	genlmsg_end(msg, hdr);
 	return 0;
 
@@ -910,6 +917,16 @@ static int batadv_netlink_set_hardif(struct sk_buff *skb,
 	struct batadv_hard_iface *hard_iface = info->user_ptr[1];
 	struct batadv_priv *bat_priv = info->user_ptr[0];
 
+#ifdef CONFIG_BATMAN_ADV_BATMAN_V
+	struct nlattr *attr;
+
+	if (info->attrs[BATADV_ATTR_ELP_INTERVAL]) {
+		attr = info->attrs[BATADV_ATTR_ELP_INTERVAL];
+
+		atomic_set(&hard_iface->bat_v.elp_interval, nla_get_u32(attr));
+	}
+#endif /* CONFIG_BATMAN_ADV_BATMAN_V */
+
 	batadv_netlink_notify_hardif(bat_priv, hard_iface);
 
 	return 0;
-- 
2.11.0


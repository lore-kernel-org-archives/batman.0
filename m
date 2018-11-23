Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 23 Nov 2018 17:13:57 +0100
Message-Id: <20181123161359.13342-18-sven@narfation.org>
In-Reply-To: <20181123161359.13342-1-sven@narfation.org>
References: <20181123161359.13342-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC v2 17/19] batman-adv: Add elp_interval hardif
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org, Sven Eckelmann <sven@narfation.org>

The ELP packets are transmitted every elp_interval milliseconds on an
slave/hard-interface. This value can be changed using the configuration
interface.

The BATADV_CMD_SET_HARDIF/BATADV_CMD_GET_HARDIF commands allow to set/get
the configuration of this feature using the u32 BATADV_ATTR_ELP_INTERVAL
attribute.

Cc: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 include/uapi/linux/batman_adv.h |  6 ++++++
 net/batman-adv/netlink.c        | 17 +++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index f8661657..a4ab6bda 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -475,6 +475,12 @@ enum batadv_nl_attrs {
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
index 61a3e6f1..70ab010e 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -159,6 +159,7 @@ static const struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_MULTICAST_MODE]		= { .type = NLA_U8 },
 	[BATADV_ATTR_NETWORK_CODING]		= { .type = NLA_U8 },
 	[BATADV_ATTR_ORIG_INTERVAL]		= { .type = NLA_U32 },
+	[BATADV_ATTR_ELP_INTERVAL]		= { .type = NLA_U32 },
 };
 
 /**
@@ -823,6 +824,12 @@ static int batadv_netlink_hardif_put(struct sk_buff *msg,
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
 
@@ -908,6 +915,16 @@ static int batadv_netlink_set_hardif(struct sk_buff *skb,
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
2.19.1


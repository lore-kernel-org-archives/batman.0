Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri,  7 Dec 2018 14:58:43 +0100
Message-Id: <20181207135846.6152-17-sven@narfation.org>
In-Reply-To: <20181207135846.6152-1-sven@narfation.org>
References: <20181207135846.6152-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC v3 16/19] batman-adv: Add orig_interval mesh
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
Cc: Sven Eckelmann <sven@narfation.org>, Marek Lindner <mareklindner@neomailbox.ch>

The OGM packets are transmitted every orig_interval milliseconds. This
value can be changed using the configuration interface.

The BATADV_CMD_SET_MESH/BATADV_CMD_GET_MESH commands allow to set/get the
configuration of this feature using the u32 BATADV_ATTR_ORIG_INTERVAL
attribute.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Cc: Marek Lindner <mareklindner@neomailbox.ch>
---
 include/uapi/linux/batman_adv.h |  6 ++++++
 net/batman-adv/netlink.c        | 17 +++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index 7e8a086f..b8cb26d2 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -469,6 +469,12 @@ enum batadv_nl_attrs {
 	 */
 	BATADV_ATTR_NETWORK_CODING,
 
+	/**
+	 * @BATADV_ATTR_ORIG_INTERVAL: defines the interval in milliseconds in
+	 *  which batman sends its protocol messages.
+	 */
+	BATADV_ATTR_ORIG_INTERVAL,
+
 	/* add attributes above here, update the policy in netlink.c */
 
 	/**
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index bdfea982..831678fd 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -158,6 +158,7 @@ static const struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_LOG_LEVEL]			= { .type = NLA_U32 },
 	[BATADV_ATTR_MULTICAST_MODE]		= { .type = NLA_U8 },
 	[BATADV_ATTR_NETWORK_CODING]		= { .type = NLA_U8 },
+	[BATADV_ATTR_ORIG_INTERVAL]		= { .type = NLA_U32 },
 };
 
 /**
@@ -357,6 +358,10 @@ static int batadv_netlink_mesh_put(struct sk_buff *msg,
 		goto nla_put_failure;
 #endif /* CONFIG_BATMAN_ADV_NC */
 
+	if (nla_put_u32(msg, BATADV_ATTR_ORIG_INTERVAL,
+			atomic_read(&bat_priv->orig_interval)))
+		goto nla_put_failure;
+
 	batadv_hardif_put(primary_if);
 
 	genlmsg_end(msg, hdr);
@@ -594,6 +599,18 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
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
2.19.2


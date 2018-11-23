Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 23 Nov 2018 17:13:52 +0100
Message-Id: <20181123161359.13342-13-sven@narfation.org>
In-Reply-To: <20181123161359.13342-1-sven@narfation.org>
References: <20181123161359.13342-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC v2 12/19] batman-adv: Add hop_penalty mesh genl
 configuration
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

The TQ (B.A.T.M.A.N. IV) and throughput values (B.A.T.M.A.N. V) are reduced
when they are forwarded. One of the reductions is the penalty for
traversing an additional hop. This hop_penalty (0-255) defines the
percentage of reduction (0-100%).

The BATADV_CMD_SET_MESH/BATADV_CMD_GET_MESH commands allow to set/get the
configuration of this feature using the u8 BATADV_ATTR_HOP_PENALTY
attribute.

Cc: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 include/uapi/linux/batman_adv.h |  6 ++++++
 net/batman-adv/netlink.c        | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index e9c48dbd..b6d0eaf6 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -442,6 +442,12 @@ enum batadv_nl_attrs {
 	 */
 	BATADV_ATTR_GW_SEL_CLASS,
 
+	/**
+	 * @BATADV_ATTR_HOP_PENALTY: defines the penalty which will be applied
+	 *  to an originator message's tq-field on every hop.
+	 */
+	BATADV_ATTR_HOP_PENALTY,
+
 	/* add attributes above here, update the policy in netlink.c */
 
 	/**
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 4e806e48..4d3a23df 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -152,6 +152,7 @@ static const struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_GW_BANDWIDTH_UP]		= { .type = NLA_U32 },
 	[BATADV_ATTR_GW_MODE]			= { .type = NLA_U8 },
 	[BATADV_ATTR_GW_SEL_CLASS]		= { .type = NLA_U32 },
+	[BATADV_ATTR_HOP_PENALTY]		= { .type = NLA_U8 },
 };
 
 /**
@@ -329,6 +330,10 @@ static int batadv_netlink_mesh_put(struct sk_buff *msg,
 			goto nla_put_failure;
 	}
 
+	if (nla_put_u8(msg, BATADV_ATTR_HOP_PENALTY,
+		       atomic_read(&bat_priv->hop_penalty)))
+		goto nla_put_failure;
+
 	batadv_hardif_put(primary_if);
 
 	genlmsg_end(msg, hdr);
@@ -534,6 +539,12 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 		}
 	}
 
+	if (info->attrs[BATADV_ATTR_HOP_PENALTY]) {
+		attr = info->attrs[BATADV_ATTR_HOP_PENALTY];
+
+		atomic_set(&bat_priv->hop_penalty, nla_get_u8(attr));
+	}
+
 	batadv_netlink_notify_mesh(bat_priv);
 
 	return 0;
-- 
2.19.1


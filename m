Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 23 Nov 2018 17:13:47 +0100
Message-Id: <20181123161359.13342-8-sven@narfation.org>
In-Reply-To: <20181123161359.13342-1-sven@narfation.org>
References: <20181123161359.13342-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC v2 07/19] batman-adv: Add bonding mesh genl
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

The mesh interface can use multiple slave/hard-interface ports at the same
time to transport the traffic to other nodes.

The BATADV_CMD_SET_MESH/BATADV_CMD_GET_MESH commands allow to set/get the
configuration of this feature using the BATADV_ATTR_BONDING attribute.
Setting the u8 to zero will disable this feature and setting it to
something else is enabling this feature.

Cc: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 include/uapi/linux/batman_adv.h |  6 ++++++
 net/batman-adv/netlink.c        | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index 75738032..d209c468 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -374,6 +374,12 @@ enum batadv_nl_attrs {
 	 */
 	BATADV_ATTR_ISOLATION_MASK,
 
+	/**
+	 * @BATADV_ATTR_BONDING: whether the data traffic going through the
+	 *  mesh will be sent using multiple interfaces at the same time.
+	 */
+	BATADV_ATTR_BONDING,
+
 	/* add attributes above here, update the policy in netlink.c */
 
 	/**
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 217c4b30..a836a8f1 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -143,6 +143,7 @@ static const struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_AP_ISOLATION]		= { .type = NLA_U8 },
 	[BATADV_ATTR_ISOLATION_MARK]		= { .type = NLA_U32 },
 	[BATADV_ATTR_ISOLATION_MASK]		= { .type = NLA_U32 },
+	[BATADV_ATTR_BONDING]			= { .type = NLA_U8 },
 };
 
 /**
@@ -278,6 +279,10 @@ static int batadv_netlink_mesh_put(struct sk_buff *msg,
 			bat_priv->isolation_mark_mask))
 		goto nla_put_failure;
 
+	if (nla_put_u8(msg, BATADV_ATTR_BONDING,
+		       !!atomic_read(&bat_priv->bonding)))
+		goto nla_put_failure;
+
 	batadv_hardif_put(primary_if);
 
 	genlmsg_end(msg, hdr);
@@ -385,6 +390,12 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 		bat_priv->isolation_mark_mask = nla_get_u32(attr);
 	}
 
+	if (info->attrs[BATADV_ATTR_BONDING]) {
+		attr = info->attrs[BATADV_ATTR_BONDING];
+
+		atomic_set(&bat_priv->bonding, !!nla_get_u8(attr));
+	}
+
 	batadv_netlink_notify_mesh(bat_priv);
 
 	return 0;
-- 
2.19.1


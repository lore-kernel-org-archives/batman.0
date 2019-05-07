Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH v2] batman-adv: Introduce no noflood mark
Date: Tue,  7 May 2019 09:28:21 +0200
Message-Id: <20190507072821.8147-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

This mark prevents a multicast packet being flooded through the whole
mesh. The advantage of marking certain multicast packets via e.g.
ebtables instead of dropping is then the following:

This allows an administrator to let specific multicast packets pass as
long as they are forwarded to a limited number of nodes only and are
therefore creating no burdon to unrelated nodes.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>

---

https://www.open-mesh.org/projects/batman-adv/wiki/Noflood-broadcast-prevention

Changelog v2:

* rebased to master
* sysfs -> netlink
---
 include/uapi/linux/batman_adv.h | 12 ++++++++++++
 net/batman-adv/netlink.c        | 22 ++++++++++++++++++++++
 net/batman-adv/soft-interface.c | 20 ++++++++++++++++++++
 net/batman-adv/types.h          | 12 ++++++++++++
 4 files changed, 66 insertions(+)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index 67f46367..6fabb7aa 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -480,6 +480,18 @@ enum batadv_nl_attrs {
 	 */
 	BATADV_ATTR_MULTICAST_FANOUT,
 
+	/**
+	 * @BATADV_ATTR_NOFLOOD_MARK: the noflood mark which allows to tag
+	 *  frames which should never be broadcast flooded through the mesh.
+	 */
+	BATADV_ATTR_NOFLOOD_MARK,
+
+	/**
+	 * @BATADV_ATTR_NOFLOOD_MASK: the noflood (bit)mask which allows to tag
+	 *  frames which should never be broadcast flooded through the mesh.
+	 */
+	BATADV_ATTR_NOFLOOD_MASK,
+
 	/* add attributes above here, update the policy in netlink.c */
 
 	/**
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index a67720fa..a08a67af 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -134,6 +134,8 @@ static const struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_AP_ISOLATION_ENABLED]	= { .type = NLA_U8 },
 	[BATADV_ATTR_ISOLATION_MARK]		= { .type = NLA_U32 },
 	[BATADV_ATTR_ISOLATION_MASK]		= { .type = NLA_U32 },
+	[BATADV_ATTR_NOFLOOD_MARK]		= { .type = NLA_U32 },
+	[BATADV_ATTR_NOFLOOD_MASK]		= { .type = NLA_U32 },
 	[BATADV_ATTR_BONDING_ENABLED]		= { .type = NLA_U8 },
 	[BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE_ENABLED]	= { .type = NLA_U8 },
 	[BATADV_ATTR_DISTRIBUTED_ARP_TABLE_ENABLED]	= { .type = NLA_U8 },
@@ -286,6 +288,14 @@ static int batadv_netlink_mesh_fill(struct sk_buff *msg,
 			bat_priv->isolation_mark_mask))
 		goto nla_put_failure;
 
+	if (nla_put_u32(msg, BATADV_ATTR_NOFLOOD_MARK,
+			bat_priv->noflood_mark))
+		goto nla_put_failure;
+
+	if (nla_put_u32(msg, BATADV_ATTR_NOFLOOD_MASK,
+			bat_priv->noflood_mark_mask))
+		goto nla_put_failure;
+
 	if (nla_put_u8(msg, BATADV_ATTR_BONDING_ENABLED,
 		       !!atomic_read(&bat_priv->bonding)))
 		goto nla_put_failure;
@@ -466,6 +476,18 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 		bat_priv->isolation_mark_mask = nla_get_u32(attr);
 	}
 
+	if (info->attrs[BATADV_ATTR_NOFLOOD_MARK]) {
+		attr = info->attrs[BATADV_ATTR_NOFLOOD_MARK];
+
+		bat_priv->noflood_mark = nla_get_u32(attr);
+	}
+
+	if (info->attrs[BATADV_ATTR_NOFLOOD_MASK]) {
+		attr = info->attrs[BATADV_ATTR_NOFLOOD_MASK];
+
+		bat_priv->noflood_mark_mask = nla_get_u32(attr);
+	}
+
 	if (info->attrs[BATADV_ATTR_BONDING_ENABLED]) {
 		attr = info->attrs[BATADV_ATTR_BONDING_ENABLED];
 
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index a7677e1d..6912f651 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -176,6 +176,23 @@ static void batadv_interface_set_rx_mode(struct net_device *dev)
 {
 }
 
+/**
+ * batadv_send_skb_has_noflood_mark() - check if packet has a noflood mark
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: the packet to check
+ *
+ * Return: True if the skb's mark matches a configured noflood mark and
+ * noflood mark mask. False otherwise.
+ */
+static bool
+batadv_skb_has_noflood_mark(struct batadv_priv *bat_priv, struct sk_buff *skb)
+{
+	u32 match_mark = skb->mark & bat_priv->noflood_mark_mask;
+
+	return bat_priv->noflood_mark_mask &&
+	       match_mark == bat_priv->noflood_mark;
+}
+
 static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 				       struct net_device *soft_iface)
 {
@@ -326,6 +343,9 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 		if (batadv_dat_snoop_outgoing_arp_request(bat_priv, skb))
 			brd_delay = msecs_to_jiffies(ARP_REQ_DELAY);
 
+		if (batadv_skb_has_noflood_mark(bat_priv, skb))
+			goto dropped;
+
 		if (batadv_skb_head_push(skb, sizeof(*bcast_packet)) < 0)
 			goto dropped;
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 74b64473..325a41a8 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1592,6 +1592,18 @@ struct batadv_priv {
 	 */
 	u32 isolation_mark_mask;
 
+	/**
+	 * @noflood_mark: the skb->mark value used to allow directed targeting
+	 *  only
+	 */
+	u32 noflood_mark;
+
+	/**
+	 * @noflood_mark_mask: bitmask identifying the bits in skb->mark to be
+	 *  used for the noflood mark
+	 */
+	u32 noflood_mark_mask;
+
 	/** @bcast_seqno: last sent broadcast packet sequence number */
 	atomic_t bcast_seqno;
 
-- 
2.20.1


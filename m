Return-Path: <jiri@resnulli.us>
Date: Mon, 21 Jan 2019 10:44:30 +0100
From: Jiri Pirko <jiri@resnulli.us>
Message-ID: <20190121094430.GC2228@nanopsycho>
References: <20190119155626.6414-1-sven@narfation.org>
 <20190119155626.6414-5-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190119155626.6414-5-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [RFC v4 04/19] batman-adv: Prepare framework for
 vlan genl config
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org

Sat, Jan 19, 2019 at 04:56:11PM CET, sven@narfation.org wrote:

[...]

>+/**
>+ * batadv_netlink_vlan_put() - Fill message with vlan attributes
>+ * @msg: Netlink message to dump into
>+ * @bat_priv: the bat priv with all the soft interface information
>+ * @vlan: vlan which was modified
>+ * @cmd: type of message to generate
>+ * @portid: Port making netlink request
>+ * @seq: sequence number for message
>+ * @flags: Additional flags for message
>+ *
>+ * Return: 0 on success or negative error number in case of failure
>+ */
>+static int batadv_netlink_vlan_put(struct sk_buff *msg,
>+				   struct batadv_priv *bat_priv,
>+				   struct batadv_softif_vlan *vlan,
>+				   enum batadv_nl_commands cmd,
>+				   u32 portid, u32 seq, int flags)
>+{
>+	void *hdr;
>+
>+	hdr = genlmsg_put(msg, portid, seq, &batadv_netlink_family, flags, cmd);
>+	if (!hdr)
>+		return -ENOBUFS;
>+
>+	if (nla_put_u32(msg, BATADV_ATTR_MESH_IFINDEX,
>+			bat_priv->soft_iface->ifindex))
>+		goto nla_put_failure;
>+
>+	if (nla_put_u32(msg, BATADV_ATTR_VLANID, vlan->vid & VLAN_VID_MASK))
>+		goto nla_put_failure;
>+
>+	genlmsg_end(msg, hdr);
>+	return 0;
>+
>+nla_put_failure:
>+	genlmsg_cancel(msg, hdr);
>+	return -EMSGSIZE;
>+}
>+
>+/**
>+ * batadv_netlink_notify_vlan() - send vlan attributes to listener
>+ * @bat_priv: the bat priv with all the soft interface information
>+ * @vlan: vlan which was modified
>+ *
>+ * Return: 0 on success, < 0 on error
>+ */
>+static int batadv_netlink_notify_vlan(struct batadv_priv *bat_priv,
>+				      struct batadv_softif_vlan *vlan)
>+{
>+	struct sk_buff *msg;
>+	int ret;
>+
>+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
>+	if (!msg)
>+		return -ENOMEM;
>+
>+	ret = batadv_netlink_vlan_put(msg, bat_priv, vlan,
>+				      BATADV_CMD_SET_VLAN, 0, 0, 0);
>+	if (ret < 0) {
>+		nlmsg_free(msg);
>+		return ret;
>+	}
>+
>+	genlmsg_multicast_netns(&batadv_netlink_family,
>+				dev_net(bat_priv->soft_iface), msg, 0,
>+				BATADV_NL_MCGRP_CONFIG, GFP_KERNEL);
>+
>+	return 0;
>+}
>+
>+/**
>+ * batadv_netlink_get_vlan() - Get vlan attributes
>+ * @skb: Netlink message with request data
>+ * @info: receiver information
>+ *
>+ * Return: 0 on success or negative error number in case of failure
>+ */
>+static int batadv_netlink_get_vlan(struct sk_buff *skb, struct genl_info *info)
>+{
>+	struct batadv_softif_vlan *vlan = info->user_ptr[1];
>+	struct batadv_priv *bat_priv = info->user_ptr[0];
>+	struct sk_buff *msg;
>+	int ret;
>+
>+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
>+	if (!msg)
>+		return -ENOMEM;
>+
>+	ret = batadv_netlink_vlan_put(msg, bat_priv, vlan, BATADV_CMD_GET_VLAN,
>+				      info->snd_portid, info->snd_seq, 0);

This get/put naming here looks a bit confusing. Better to use "fill" for
example:
	ret = batadv_netlink_vlan_fill(msg, bat_priv, vlan, BATADV_CMD_GET_VLAN,
				       info->snd_portid, info->snd_seq, 0);

>+	if (ret < 0) {

Just "if (!ret)" would do. Same in the rest of the code.


>+		nlmsg_free(msg);
>+		return ret;
>+	}
>+
>+	ret = genlmsg_reply(msg, info);
>+
>+	return ret;
>+}
>+

[...]


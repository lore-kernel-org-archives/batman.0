Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  4 Nov 2018 20:33:13 +0100
Message-Id: <20181104193314.18104-2-sven@narfation.org>
In-Reply-To: <20181104193314.18104-1-sven@narfation.org>
References: <20181104193314.18104-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC 1/2] batman-adv: Add infrastructure for netlink
 config manipulation
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
Cc: Jiri Pirko <jiri@mellanox.com>, Sven Eckelmann <sven@narfation.org>

The batman-adv configuration interface was implemented solely using sysfs.
This approach was condemned by non-batadv developers as "huge mistake".
Instead a netlink/genl based implementation was suggested.

The different key-value pairs used for the configuration of batman-adv can
be split in three classes (sharing most of the setup code):

* mesh interface (the batadv device)
* hard interface specific  (the enslaved devices)
* vlan specific (vlan on top of the mesh interface)

For all three, genl commands to get, set and dump are specified. The actual
modification of datastructures is then trivial and abstracted away from the
genl handing via objects with callbacks (get, validate, set). The option
infrastructure is handling the actual retrieval of mesh interface object,
hard interface object and vlan object. It takes care of validation and
issuing netlink mcast messages back to userspace.

TODO add more description here.

Cc: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 include/uapi/linux/batman_adv.h |   55 ++
 net/batman-adv/Makefile         |    1 +
 net/batman-adv/netlink.c        |   50 +-
 net/batman-adv/netlink.h        |    6 +
 net/batman-adv/netlink_cfg.c    | 1051 +++++++++++++++++++++++++++++++
 net/batman-adv/netlink_cfg.h    |   78 +++
 6 files changed, 1235 insertions(+), 6 deletions(-)
 create mode 100644 net/batman-adv/netlink_cfg.c
 create mode 100644 net/batman-adv/netlink_cfg.h

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index 324a0e11..9b5f5f2c 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -27,6 +27,7 @@
 
 #define BATADV_NL_NAME "batadv"
 
+#define BATADV_NL_MCAST_GROUP_CONFIG	"config"
 #define BATADV_NL_MCAST_GROUP_TPMETER	"tpmeter"
 
 /**
@@ -344,6 +345,26 @@ enum batadv_nl_attrs {
 	 */
 	BATADV_ATTR_MCAST_FLAGS_PRIV,
 
+	/**
+	 * @BATADV_ATTR_VLANID: VLAN id on top of soft interface
+	 */
+	BATADV_ATTR_VLANID,
+
+	/**
+	 * @BATADV_ATTR_OPTION_NAME: name of option to modify
+	 */
+	BATADV_ATTR_OPTION_NAME,
+
+	/**
+	 * @BATADV_ATTR_OPTION_TYPE: type of @BATADV_ATTR_OPTION_VALUE
+	 */
+	BATADV_ATTR_OPTION_TYPE,
+
+	/**
+	 * @BATADV_ATTR_OPTION_VALUE: value set for @BATADV_ATTR_OPTION_NAME
+	 */
+	BATADV_ATTR_OPTION_VALUE,
+
 	/* add attributes above here, update the policy in netlink.c */
 
 	/**
@@ -443,6 +464,40 @@ enum batadv_nl_commands {
 	 */
 	BATADV_CMD_GET_MCAST_FLAGS,
 
+	/**
+	 * @BATADV_CMD_GET_OPTION: Get option(s) from softif
+	 */
+	BATADV_CMD_GET_OPTION,
+
+	/**
+	 * @BATADV_CMD_SET_OPTION: Set option for softif
+	 */
+	BATADV_CMD_SET_OPTION,
+
+	/**
+	 * @BATADV_CMD_GET_OPTION_HARDIF: Get option(s) from a hardif of the
+	 *  current softif
+	 */
+	BATADV_CMD_GET_OPTION_HARDIF,
+
+	/**
+	 * @BATADV_CMD_SET_OPTION_HARDIF: Set option for hardif of the
+	 *  current softif
+	 */
+	BATADV_CMD_SET_OPTION_HARDIF,
+
+	/**
+	 * @BATADV_CMD_GET_OPTION_VLAN: Get option(s) from a VLAN of the
+	 *  current softif
+	 */
+	BATADV_CMD_GET_OPTION_VLAN,
+
+	/**
+	 * @BATADV_CMD_SET_OPTION_VLAN: Set option for VLAN of the
+	 *  current softif
+	 */
+	BATADV_CMD_SET_OPTION_VLAN,
+
 	/* add new commands above here */
 
 	/**
diff --git a/net/batman-adv/Makefile b/net/batman-adv/Makefile
index 9b58160f..a503e145 100644
--- a/net/batman-adv/Makefile
+++ b/net/batman-adv/Makefile
@@ -36,6 +36,7 @@ batman-adv-$(CONFIG_BATMAN_ADV_DEBUG) += log.o
 batman-adv-y += main.o
 batman-adv-$(CONFIG_BATMAN_ADV_MCAST) += multicast.o
 batman-adv-y += netlink.o
+batman-adv-y += netlink_cfg.o
 batman-adv-$(CONFIG_BATMAN_ADV_NC) += network-coding.o
 batman-adv-y += originator.o
 batman-adv-y += routing.o
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 2dc3304c..ff290e5d 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -49,6 +49,7 @@
 #include "gateway_client.h"
 #include "hard-interface.h"
 #include "multicast.h"
+#include "netlink_cfg.h"
 #include "originator.h"
 #include "soft-interface.h"
 #include "tp_meter.h"
@@ -56,12 +57,8 @@
 
 struct genl_family batadv_netlink_family;
 
-/* multicast groups */
-enum batadv_netlink_multicast_groups {
-	BATADV_NL_MCGRP_TPMETER,
-};
-
 static const struct genl_multicast_group batadv_netlink_mcgrps[] = {
+	[BATADV_NL_MCGRP_CONFIG] = { .name = BATADV_NL_MCAST_GROUP_CONFIG },
 	[BATADV_NL_MCGRP_TPMETER] = { .name = BATADV_NL_MCAST_GROUP_TPMETER },
 };
 
@@ -104,6 +101,9 @@ static const struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_DAT_CACHE_VID]		= { .type = NLA_U16 },
 	[BATADV_ATTR_MCAST_FLAGS]		= { .type = NLA_U32 },
 	[BATADV_ATTR_MCAST_FLAGS_PRIV]		= { .type = NLA_U32 },
+	[BATADV_ATTR_VLANID]			= { .type = NLA_U16 },
+	[BATADV_ATTR_OPTION_NAME]		= { .type = NLA_NUL_STRING },
+	[BATADV_ATTR_OPTION_TYPE]		= { .type = NLA_U8 },
 };
 
 /**
@@ -630,7 +630,45 @@ static const struct genl_ops batadv_netlink_ops[] = {
 		.policy = batadv_netlink_policy,
 		.dumpit = batadv_mcast_flags_dump,
 	},
-
+	{
+		.cmd = BATADV_CMD_GET_OPTION,
+		/* can be retrieved by unprivileged users */
+		.policy = batadv_netlink_policy,
+		.dumpit = batadv_get_option_dump,
+		.doit = batadv_get_option,
+	},
+	{
+		.cmd = BATADV_CMD_SET_OPTION,
+		.flags = GENL_ADMIN_PERM,
+		.policy = batadv_netlink_policy,
+		.doit = batadv_set_option,
+	},
+	{
+		.cmd = BATADV_CMD_GET_OPTION_HARDIF,
+		/* can be retrieved by unprivileged users */
+		.policy = batadv_netlink_policy,
+		.dumpit = batadv_get_option_hardif_dump,
+		.doit = batadv_get_option_hardif,
+	},
+	{
+		.cmd = BATADV_CMD_SET_OPTION_HARDIF,
+		.flags = GENL_ADMIN_PERM,
+		.policy = batadv_netlink_policy,
+		.doit = batadv_set_option_hardif,
+	},
+	{
+		.cmd = BATADV_CMD_GET_OPTION_VLAN,
+		/* can be retrieved by unprivileged users */
+		.policy = batadv_netlink_policy,
+		.dumpit = batadv_get_option_vlan_dump,
+		.doit = batadv_get_option_vlan,
+	},
+	{
+		.cmd = BATADV_CMD_SET_OPTION_VLAN,
+		.flags = GENL_ADMIN_PERM,
+		.policy = batadv_netlink_policy,
+		.doit = batadv_set_option_vlan,
+	},
 };
 
 struct genl_family batadv_netlink_family __ro_after_init = {
diff --git a/net/batman-adv/netlink.h b/net/batman-adv/netlink.h
index 571d9a5a..9438572d 100644
--- a/net/batman-adv/netlink.h
+++ b/net/batman-adv/netlink.h
@@ -26,6 +26,12 @@
 
 struct nlmsghdr;
 
+/* multicast groups */
+enum batadv_netlink_multicast_groups {
+	BATADV_NL_MCGRP_CONFIG,
+	BATADV_NL_MCGRP_TPMETER,
+};
+
 void batadv_netlink_register(void);
 void batadv_netlink_unregister(void);
 int batadv_netlink_get_ifindex(const struct nlmsghdr *nlh, int attrtype);
diff --git a/net/batman-adv/netlink_cfg.c b/net/batman-adv/netlink_cfg.c
new file mode 100644
index 00000000..6e4229f1
--- /dev/null
+++ b/net/batman-adv/netlink_cfg.c
@@ -0,0 +1,1051 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2010-2018  B.A.T.M.A.N. contributors:
+ *
+ * Sven Eckelmann
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "netlink_cfg.h"
+#include "main.h"
+
+#include <linux/errno.h>
+#include <linux/genetlink.h>
+#include <linux/gfp.h>
+#include <linux/if_vlan.h>
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+#include <linux/netlink.h>
+#include <linux/skbuff.h>
+#include <linux/stddef.h>
+#include <linux/string.h>
+#include <net/genetlink.h>
+#include <net/netlink.h>
+#include <net/sock.h>
+#include <uapi/linux/batadv_packet.h>
+#include <uapi/linux/batman_adv.h>
+
+#include "hard-interface.h"
+#include "netlink.h"
+#include "soft-interface.h"
+
+static const struct batadv_option softif_options[] = {
+};
+
+static const struct batadv_option hardif_options[] = {
+};
+
+static const struct batadv_option vlan_options[] = {
+};
+
+/**
+ * batadv_find_option() - Search for option with the correct name
+ * @name: name of the option to find
+ * @options: array of available options
+ * @options_num: number of entries in @options
+ *
+ * Return: pointer to option on success or NULL in case of failure
+ */
+static const struct batadv_option *
+batadv_find_option(const char *name, const struct batadv_option options[],
+		   size_t options_num)
+{
+	size_t i;
+
+	for (i = 0; i < options_num; i++) {
+		if (strcmp(options[i].name, name) != 0)
+			continue;
+
+		return &options[i];
+	}
+
+	return NULL;
+}
+
+/**
+ * batadv_option_value_get_from_info() - Validate and extract value from msg
+ * @option: option to extract value for
+ * @info: generic netlink info with attributes
+ * @val: Target to save value
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int batadv_option_value_get_from_info(const struct batadv_option *option,
+					     struct genl_info *info,
+					     union batadv_config_value *val)
+{
+	struct nlattr *nla = info->attrs[BATADV_ATTR_OPTION_VALUE];
+	int attrlen;
+	int minlen;
+
+	if (option->type != NLA_FLAG && !nla)
+		return -EINVAL;
+
+	switch (option->type) {
+	case NLA_U8:
+		attrlen = nla_len(nla);
+		if (attrlen < sizeof(u8))
+			return -EINVAL;
+
+		val->vu8 = nla_get_u8(nla);
+		break;
+	case NLA_U16:
+		attrlen = nla_len(nla);
+		if (attrlen < sizeof(u16))
+			return -EINVAL;
+
+		val->vu16 = nla_get_u16(nla);
+		break;
+	case NLA_U32:
+		attrlen = nla_len(nla);
+		if (attrlen < sizeof(u32))
+			return -EINVAL;
+
+		val->vu32 = nla_get_u32(nla);
+		break;
+	case NLA_NUL_STRING:
+		attrlen = nla_len(nla);
+		minlen = min_t(int, __BATADV_PARAM_MAX_STRING_VALUE, attrlen);
+		if (!minlen || !memchr(nla_data(nla), '\0', minlen))
+			return -EINVAL;
+
+		strlcpy(val->string, nla_data(nla), sizeof(val->string));
+		break;
+	case NLA_FLAG:
+		val->vbool = !!nla;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * batadv_get_option_fill_open() - Fill message with option data and keep it
+ *  open for further attributes
+ * @msg: Netlink message to dump into
+ * @hdr: storage position for header
+ * @bat_priv: the bat priv with all the soft interface information
+ * @option: option to dump
+ * @ext_arg: Additional option argument
+ * @cmd: type of message to generate
+ * @portid: Port making netlink request
+ * @seq: sequence number for message
+ * @flags: Additional flags for message
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int batadv_get_option_fill_open(struct sk_buff *msg, void **hdr,
+				       struct batadv_priv *bat_priv,
+				       const struct batadv_option *option,
+				       void *ext_arg,
+				       enum batadv_nl_commands cmd,
+				       u32 portid, u32 seq, int flags)
+{
+	union batadv_config_value val;
+	int ret;
+
+	ret = option->get(bat_priv, ext_arg, &val);
+	if (ret < 0)
+		return ret;
+
+	*hdr = genlmsg_put(msg, portid, seq, &batadv_netlink_family, flags,
+			   cmd);
+	if (!*hdr)
+		return -EMSGSIZE;
+
+	if (nla_put_string(msg, BATADV_ATTR_OPTION_NAME, option->name))
+		return -EMSGSIZE;
+
+	if (nla_put_u8(msg, BATADV_ATTR_OPTION_TYPE, option->type))
+		return -EMSGSIZE;
+
+	switch (option->type) {
+	case NLA_U8:
+		if (nla_put_u8(msg, BATADV_ATTR_OPTION_VALUE, val.vu8))
+			return -EMSGSIZE;
+		break;
+	case NLA_U16:
+		if (nla_put_u16(msg, BATADV_ATTR_OPTION_VALUE, val.vu16))
+			return -EMSGSIZE;
+		break;
+	case NLA_U32:
+		if (nla_put_u32(msg, BATADV_ATTR_OPTION_VALUE, val.vu32))
+			return -EMSGSIZE;
+		break;
+	case NLA_NUL_STRING:
+		if (nla_put_string(msg, BATADV_ATTR_OPTION_VALUE, val.string))
+			return -EMSGSIZE;
+		break;
+	case NLA_FLAG:
+		if (val.vbool && nla_put_flag(msg, BATADV_ATTR_OPTION_VALUE))
+			return -EMSGSIZE;
+		break;
+	}
+
+	return 0;
+}
+
+/**
+ * batadv_get_option_fill() - Fill message with option data
+ * @msg: Netlink message to dump into
+ * @bat_priv: the bat priv with all the soft interface information
+ * @option: option to dump
+ * @ext_arg: Additional option argument
+ * @cmd: type of message to generate
+ * @portid: Port making netlink request
+ * @seq: sequence number for message
+ * @flags: Additional flags for message
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int batadv_get_option_fill(struct sk_buff *msg,
+				  struct batadv_priv *bat_priv,
+				  const struct batadv_option *option,
+				  void *ext_arg, enum batadv_nl_commands cmd,
+				  u32 portid, u32 seq, int flags)
+{
+	void *hdr;
+	int ret;
+
+	ret = batadv_get_option_fill_open(msg, &hdr, bat_priv, option, ext_arg,
+					  cmd, portid, seq, flags);
+	if (ret < 0)
+		return ret;
+
+	genlmsg_end(msg, hdr);
+	return 0;
+}
+
+/**
+ * batadv_option_notify() - send new option value to listener
+ * @bat_priv: the bat priv with all the soft interface information
+ * @option: option which was modified
+ *
+ * Return: 0 on success, < 0 on error
+ */
+static int batadv_option_notify(struct batadv_priv *bat_priv,
+				const struct batadv_option *option)
+{
+	struct sk_buff *msg;
+	void *hdr;
+	int ret;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	ret = batadv_get_option_fill_open(msg, &hdr, bat_priv, option, NULL,
+					  BATADV_CMD_SET_OPTION, 0, 0, 0);
+	if (ret < 0)
+		goto nla_put_failure;
+
+	if (nla_put_u32(msg, BATADV_ATTR_MESH_IFINDEX,
+			bat_priv->soft_iface->ifindex))
+		goto nla_put_failure;
+
+	genlmsg_end(msg, hdr);
+
+	genlmsg_multicast_netns(&batadv_netlink_family,
+				dev_net(bat_priv->soft_iface), msg, 0,
+				BATADV_NL_MCGRP_CONFIG, GFP_KERNEL);
+
+	return 0;
+
+nla_put_failure:
+	genlmsg_cancel(msg, hdr);
+	ret = -EMSGSIZE;
+	nlmsg_free(msg);
+	return ret;
+}
+
+/**
+ * batadv_get_option() - Get softif option
+ * @skb: Netlink message with request data
+ * @info: receiver information
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+int batadv_get_option(struct sk_buff *skb, struct genl_info *info)
+{
+	struct net *net = genl_info_net(info);
+	const struct batadv_option *option;
+	struct net_device *soft_iface;
+	struct batadv_priv *bat_priv;
+	const char *option_name;
+	struct sk_buff *msg;
+	int ifindex;
+	int ret;
+
+	if (!info->attrs[BATADV_ATTR_MESH_IFINDEX])
+		return -EINVAL;
+
+	if (!info->attrs[BATADV_ATTR_OPTION_NAME])
+		return -EINVAL;
+
+	option_name = nla_data(info->attrs[BATADV_ATTR_OPTION_NAME]);
+	option = batadv_find_option(option_name, softif_options,
+				    ARRAY_SIZE(softif_options));
+	if (!option)
+		return -EOPNOTSUPP;
+
+	ifindex = nla_get_u32(info->attrs[BATADV_ATTR_MESH_IFINDEX]);
+	soft_iface = dev_get_by_index(net, ifindex);
+	if (!soft_iface)
+		return -ENODEV;
+
+	if (!batadv_softif_is_valid(soft_iface)) {
+		ret = -EINVAL;
+		goto err_put_softif;
+	}
+
+	bat_priv = netdev_priv(soft_iface);
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg) {
+		ret = -ENOMEM;
+		goto err_put_softif;
+	}
+
+	ret = batadv_get_option_fill(msg, bat_priv, option,
+				     NULL, BATADV_CMD_GET_OPTION,
+				     info->snd_portid, info->snd_seq, 0);
+	if (ret < 0) {
+		nlmsg_free(msg);
+		goto err_put_softif;
+	}
+
+	ret = genlmsg_reply(msg, info);
+
+err_put_softif:
+	dev_put(soft_iface);
+
+	return ret;
+}
+
+/**
+ * batadv_set_option() - Set softif option
+ * @skb: Netlink message with request data
+ * @info: receiver information
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+int batadv_set_option(struct sk_buff *skb, struct genl_info *info)
+{
+	struct net *net = genl_info_net(info);
+	const struct batadv_option *option;
+	struct net_device *soft_iface;
+	union batadv_config_value val;
+	struct batadv_priv *bat_priv;
+	const char *option_name;
+	int option_type;
+	int ifindex;
+	int ret;
+
+	if (!info->attrs[BATADV_ATTR_MESH_IFINDEX])
+		return -EINVAL;
+
+	if (!info->attrs[BATADV_ATTR_OPTION_NAME])
+		return -EINVAL;
+
+	if (!info->attrs[BATADV_ATTR_OPTION_TYPE])
+		return -EINVAL;
+
+	option_name = nla_data(info->attrs[BATADV_ATTR_OPTION_NAME]);
+	option = batadv_find_option(option_name, softif_options,
+				    ARRAY_SIZE(softif_options));
+	if (!option)
+		return -EOPNOTSUPP;
+
+	option_type = nla_get_u8(info->attrs[BATADV_ATTR_OPTION_TYPE]);
+	if (option_type != option->type)
+		return -EINVAL;
+
+	ret = batadv_option_value_get_from_info(option, info, &val);
+	if (ret < 0)
+		return ret;
+
+	ifindex = nla_get_u32(info->attrs[BATADV_ATTR_MESH_IFINDEX]);
+	soft_iface = dev_get_by_index(net, ifindex);
+	if (!soft_iface)
+		return -ENODEV;
+
+	if (!batadv_softif_is_valid(soft_iface)) {
+		ret = -EINVAL;
+		goto err_put_softif;
+	}
+
+	bat_priv = netdev_priv(soft_iface);
+
+	ret = option->set(bat_priv, NULL, &val);
+	if (ret < 0)
+		goto err_put_softif;
+
+	batadv_option_notify(bat_priv, option);
+
+err_put_softif:
+	dev_put(soft_iface);
+
+	return ret;
+}
+
+/**
+ * batadv_get_option_dump() - Dump softif options into a message
+ * @msg: Netlink message to dump into
+ * @cb: Control block containing additional options
+ *
+ * Return: Error code, or length of message
+ */
+int batadv_get_option_dump(struct sk_buff *msg, struct netlink_callback *cb)
+{
+	struct net *net = sock_net(cb->skb->sk);
+	unsigned int start = cb->args[0];
+	struct net_device *soft_iface;
+	struct batadv_priv *bat_priv;
+	unsigned int i;
+	int ifindex;
+	int ret;
+
+	ifindex = batadv_netlink_get_ifindex(cb->nlh,
+					     BATADV_ATTR_MESH_IFINDEX);
+	if (!ifindex)
+		return -EINVAL;
+
+	soft_iface = dev_get_by_index(net, ifindex);
+	if (!soft_iface)
+		return -ENODEV;
+
+	if (!batadv_softif_is_valid(soft_iface)) {
+		ret = -EINVAL;
+		goto err_put_softif;
+	}
+
+	bat_priv = netdev_priv(soft_iface);
+
+	for (i = start; i < ARRAY_SIZE(softif_options); i++) {
+		ret = batadv_get_option_fill(msg, bat_priv, &softif_options[i],
+					     NULL, BATADV_CMD_GET_OPTION,
+					     NETLINK_CB(cb->skb).portid,
+					     cb->nlh->nlmsg_seq,
+					     NLM_F_MULTI);
+		if (ret == -EOPNOTSUPP)
+			continue;
+		if (ret < 0)
+			break;
+	}
+
+	cb->args[0] = i;
+	ret = msg->len;
+
+err_put_softif:
+	dev_put(soft_iface);
+
+	return ret;
+}
+
+/**
+ * batadv_option_hardif_notify() - send new hardif option value to listener
+ * @bat_priv: the bat priv with all the soft interface information
+ * @hard_iface: hard interface which was modified
+ * @option: option which was modified
+ *
+ * Return: 0 on success, < 0 on error
+ */
+static int batadv_option_hardif_notify(struct batadv_priv *bat_priv,
+				       struct batadv_hard_iface *hard_iface,
+				       const struct batadv_option *option)
+{
+	struct sk_buff *msg;
+	void *hdr;
+	int ret;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	ret = batadv_get_option_fill_open(msg, &hdr, bat_priv, option,
+					  hard_iface,
+					  BATADV_CMD_SET_OPTION_HARDIF, 0, 0,
+					  0);
+	if (ret < 0)
+		goto nla_put_failure;
+
+	if (nla_put_u32(msg, BATADV_ATTR_MESH_IFINDEX,
+			bat_priv->soft_iface->ifindex))
+		goto nla_put_failure;
+
+	if (nla_put_u32(msg, BATADV_ATTR_HARD_IFINDEX,
+			hard_iface->net_dev->ifindex))
+		goto nla_put_failure;
+
+	genlmsg_end(msg, hdr);
+
+	genlmsg_multicast_netns(&batadv_netlink_family,
+				dev_net(bat_priv->soft_iface), msg, 0,
+				BATADV_NL_MCGRP_CONFIG, GFP_KERNEL);
+
+	return 0;
+
+nla_put_failure:
+	genlmsg_cancel(msg, hdr);
+	ret = -EMSGSIZE;
+	nlmsg_free(msg);
+	return ret;
+}
+
+/**
+ * batadv_get_option_hardif() - Get hardif option
+ * @skb: Netlink message with request data
+ * @info: receiver information
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+int batadv_get_option_hardif(struct sk_buff *skb, struct genl_info *info)
+{
+	struct net *net = genl_info_net(info);
+	struct batadv_hard_iface *hard_iface;
+	const struct batadv_option *option;
+	struct net_device *soft_iface;
+	struct batadv_priv *bat_priv;
+	struct net_device *hard_dev;
+	unsigned int hardif_index;
+	const char *option_name;
+	struct sk_buff *msg;
+	int ifindex;
+	int ret;
+
+	if (!info->attrs[BATADV_ATTR_MESH_IFINDEX])
+		return -EINVAL;
+
+	if (!info->attrs[BATADV_ATTR_HARD_IFINDEX])
+		return -EINVAL;
+
+	if (!info->attrs[BATADV_ATTR_OPTION_NAME])
+		return -EINVAL;
+
+	option_name = nla_data(info->attrs[BATADV_ATTR_OPTION_NAME]);
+	option = batadv_find_option(option_name, hardif_options,
+				    ARRAY_SIZE(hardif_options));
+	if (!option)
+		return -EOPNOTSUPP;
+
+	ifindex = nla_get_u32(info->attrs[BATADV_ATTR_MESH_IFINDEX]);
+	soft_iface = dev_get_by_index(net, ifindex);
+	if (!soft_iface)
+		return -ENODEV;
+
+	if (!batadv_softif_is_valid(soft_iface)) {
+		ret = -EINVAL;
+		goto err_put_softif;
+	}
+
+	bat_priv = netdev_priv(soft_iface);
+
+	hardif_index = nla_get_u32(info->attrs[BATADV_ATTR_HARD_IFINDEX]);
+	hard_dev = dev_get_by_index(net, hardif_index);
+	if (!hard_dev) {
+		ret = -ENODEV;
+		goto err_put_softif;
+	}
+
+	hard_iface = batadv_hardif_get_by_netdev(hard_dev);
+	if (!hard_iface) {
+		ret = -EINVAL;
+		goto err_put_harddev;
+	}
+
+	if (hard_iface->soft_iface != soft_iface) {
+		ret = -EINVAL;
+		goto err_put_hardif;
+	}
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg) {
+		ret = -ENOMEM;
+		goto err_put_hardif;
+	}
+
+	ret = batadv_get_option_fill(msg, bat_priv, option, hard_iface,
+				     BATADV_CMD_GET_OPTION_HARDIF,
+				     info->snd_portid, info->snd_seq, 0);
+	if (ret < 0) {
+		nlmsg_free(msg);
+		goto err_put_hardif;
+	}
+
+	ret = genlmsg_reply(msg, info);
+
+err_put_hardif:
+	batadv_hardif_put(hard_iface);
+err_put_harddev:
+	dev_put(hard_dev);
+err_put_softif:
+	dev_put(soft_iface);
+
+	return ret;
+}
+
+/**
+ * batadv_set_option_hardif() - Set hardif option
+ * @skb: Netlink message with request data
+ * @info: receiver information
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+int batadv_set_option_hardif(struct sk_buff *skb, struct genl_info *info)
+{
+	struct net *net = genl_info_net(info);
+	struct batadv_hard_iface *hard_iface;
+	const struct batadv_option *option;
+	struct net_device *soft_iface;
+	union batadv_config_value val;
+	struct batadv_priv *bat_priv;
+	struct net_device *hard_dev;
+	unsigned int hardif_index;
+	const char *option_name;
+	int option_type;
+	int ifindex;
+	int ret;
+
+	if (!info->attrs[BATADV_ATTR_MESH_IFINDEX])
+		return -EINVAL;
+
+	if (!info->attrs[BATADV_ATTR_HARD_IFINDEX])
+		return -EINVAL;
+
+	if (!info->attrs[BATADV_ATTR_OPTION_NAME])
+		return -EINVAL;
+
+	if (!info->attrs[BATADV_ATTR_OPTION_TYPE])
+		return -EINVAL;
+
+	option_name = nla_data(info->attrs[BATADV_ATTR_OPTION_NAME]);
+	option = batadv_find_option(option_name, hardif_options,
+				    ARRAY_SIZE(hardif_options));
+	if (!option)
+		return -EOPNOTSUPP;
+
+	option_type = nla_get_u8(info->attrs[BATADV_ATTR_OPTION_TYPE]);
+	if (option_type != option->type)
+		return -EINVAL;
+
+	ret = batadv_option_value_get_from_info(option, info, &val);
+	if (ret < 0)
+		return ret;
+
+	ifindex = nla_get_u32(info->attrs[BATADV_ATTR_MESH_IFINDEX]);
+	soft_iface = dev_get_by_index(net, ifindex);
+	if (!soft_iface)
+		return -ENODEV;
+
+	if (!batadv_softif_is_valid(soft_iface)) {
+		ret = -EINVAL;
+		goto err_put_softif;
+	}
+
+	bat_priv = netdev_priv(soft_iface);
+
+	hardif_index = nla_get_u32(info->attrs[BATADV_ATTR_HARD_IFINDEX]);
+	hard_dev = dev_get_by_index(net, hardif_index);
+	if (!hard_dev) {
+		ret = -ENODEV;
+		goto err_put_softif;
+	}
+
+	hard_iface = batadv_hardif_get_by_netdev(hard_dev);
+	if (!hard_iface) {
+		ret = -EINVAL;
+		goto err_put_harddev;
+	}
+
+	if (hard_iface->soft_iface != soft_iface) {
+		ret = -EINVAL;
+		goto err_put_hardif;
+	}
+
+	ret = option->set(bat_priv, hard_iface, &val);
+	if (ret < 0)
+		goto err_put_hardif;
+
+	batadv_option_hardif_notify(bat_priv, hard_iface, option);
+
+err_put_hardif:
+	batadv_hardif_put(hard_iface);
+err_put_harddev:
+	dev_put(hard_dev);
+err_put_softif:
+	dev_put(soft_iface);
+
+	return ret;
+}
+
+/**
+ * batadv_get_option_hardif_dump() - Dump hardif options into a message
+ * @msg: Netlink message to dump into
+ * @cb: Control block containing additional options
+ *
+ * Return: Error code, or length of message
+ */
+int batadv_get_option_hardif_dump(struct sk_buff *msg,
+				  struct netlink_callback *cb)
+{
+	struct net *net = sock_net(cb->skb->sk);
+	struct batadv_hard_iface *hard_iface;
+	unsigned int start = cb->args[0];
+	struct net_device *soft_iface;
+	struct batadv_priv *bat_priv;
+	struct net_device *hard_dev;
+	unsigned int hardif_index;
+	unsigned int i;
+	int ifindex;
+	int ret;
+
+	ifindex = batadv_netlink_get_ifindex(cb->nlh,
+					     BATADV_ATTR_MESH_IFINDEX);
+	if (!ifindex)
+		return -EINVAL;
+
+	hardif_index = batadv_netlink_get_ifindex(cb->nlh,
+						  BATADV_ATTR_HARD_IFINDEX);
+	if (!hardif_index)
+		return -EINVAL;
+
+	soft_iface = dev_get_by_index(net, ifindex);
+	if (!soft_iface)
+		return -ENODEV;
+
+	if (!batadv_softif_is_valid(soft_iface)) {
+		ret = -EINVAL;
+		goto err_put_softif;
+	}
+
+	bat_priv = netdev_priv(soft_iface);
+
+	hard_dev = dev_get_by_index(net, hardif_index);
+	if (!hard_dev) {
+		ret = -ENODEV;
+		goto err_put_softif;
+	}
+
+	hard_iface = batadv_hardif_get_by_netdev(hard_dev);
+	if (!hard_iface) {
+		ret = -EINVAL;
+		goto err_put_harddev;
+	}
+
+	if (hard_iface->soft_iface != soft_iface) {
+		ret = -EINVAL;
+		goto err_put_hardif;
+	}
+
+	for (i = start; i < ARRAY_SIZE(hardif_options); i++) {
+		ret = batadv_get_option_fill(msg, bat_priv, &hardif_options[i],
+					     hard_iface,
+					     BATADV_CMD_GET_OPTION_HARDIF,
+					     NETLINK_CB(cb->skb).portid,
+					     cb->nlh->nlmsg_seq,
+					     NLM_F_MULTI);
+		if (ret == -EOPNOTSUPP)
+			continue;
+		if (ret < 0)
+			break;
+	}
+
+	cb->args[0] = i;
+	ret = msg->len;
+
+err_put_hardif:
+	batadv_hardif_put(hard_iface);
+err_put_harddev:
+	dev_put(hard_dev);
+err_put_softif:
+	dev_put(soft_iface);
+
+	return ret;
+}
+
+/**
+ * batadv_option_vlan_notify() - send new vlan option value to listener
+ * @bat_priv: the bat priv with all the soft interface information
+ * @vlan: vlan which was modified
+ * @option: option which was modified
+ *
+ * Return: 0 on success, < 0 on error
+ */
+static int batadv_option_vlan_notify(struct batadv_priv *bat_priv,
+				     struct batadv_softif_vlan *vlan,
+				     const struct batadv_option *option)
+{
+	struct sk_buff *msg;
+	void *hdr;
+	int ret;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	ret = batadv_get_option_fill_open(msg, &hdr, bat_priv, option, vlan,
+					  BATADV_CMD_SET_OPTION_VLAN, 0, 0, 0);
+	if (ret < 0)
+		goto nla_put_failure;
+
+	if (nla_put_u32(msg, BATADV_ATTR_MESH_IFINDEX,
+			bat_priv->soft_iface->ifindex))
+		goto nla_put_failure;
+
+	if (nla_put_u32(msg, BATADV_ATTR_VLANID, vlan->vid & VLAN_VID_MASK))
+		goto nla_put_failure;
+
+	genlmsg_end(msg, hdr);
+
+	genlmsg_multicast_netns(&batadv_netlink_family,
+				dev_net(bat_priv->soft_iface), msg, 0,
+				BATADV_NL_MCGRP_CONFIG, GFP_KERNEL);
+
+	return 0;
+
+nla_put_failure:
+	genlmsg_cancel(msg, hdr);
+	ret = -EMSGSIZE;
+	nlmsg_free(msg);
+	return ret;
+}
+
+/**
+ * batadv_get_option_vlan() - Get vlan option
+ * @skb: Netlink message with request data
+ * @info: receiver information
+ *
+ * Return: Error code, or length of message
+ */
+int batadv_get_option_vlan(struct sk_buff *skb, struct genl_info *info)
+{
+	struct net *net = genl_info_net(info);
+	const struct batadv_option *option;
+	struct batadv_softif_vlan *vlan;
+	struct net_device *soft_iface;
+	struct batadv_priv *bat_priv;
+	const char *option_name;
+	struct sk_buff *msg;
+	int ifindex;
+	u16 vid;
+	int ret;
+
+	if (!info->attrs[BATADV_ATTR_MESH_IFINDEX])
+		return -EINVAL;
+
+	if (!info->attrs[BATADV_ATTR_VLANID])
+		return -EINVAL;
+
+	if (!info->attrs[BATADV_ATTR_OPTION_NAME])
+		return -EINVAL;
+
+	option_name = nla_data(info->attrs[BATADV_ATTR_OPTION_NAME]);
+	option = batadv_find_option(option_name, vlan_options,
+				    ARRAY_SIZE(vlan_options));
+	if (!option)
+		return -EOPNOTSUPP;
+
+	ifindex = nla_get_u32(info->attrs[BATADV_ATTR_MESH_IFINDEX]);
+	soft_iface = dev_get_by_index(net, ifindex);
+	if (!soft_iface)
+		return -ENODEV;
+
+	if (!batadv_softif_is_valid(soft_iface)) {
+		ret = -EINVAL;
+		goto err_put_softif;
+	}
+
+	bat_priv = netdev_priv(soft_iface);
+
+	vid = nla_get_u16(info->attrs[BATADV_ATTR_VLANID]);
+	vlan = batadv_softif_vlan_get(bat_priv, vid | BATADV_VLAN_HAS_TAG);
+	if (!vlan) {
+		ret = -ENOENT;
+		goto err_put_softif;
+	}
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg) {
+		ret = -ENOMEM;
+		goto err_put_vlan;
+	}
+
+	ret = batadv_get_option_fill(msg, bat_priv, option,
+				     vlan, BATADV_CMD_GET_OPTION_VLAN,
+				     info->snd_portid, info->snd_seq, 0);
+	if (ret < 0) {
+		nlmsg_free(msg);
+		goto err_put_vlan;
+	}
+
+	ret = genlmsg_reply(msg, info);
+
+err_put_vlan:
+	batadv_softif_vlan_put(vlan);
+err_put_softif:
+	dev_put(soft_iface);
+
+	return ret;
+}
+
+/**
+ * batadv_set_option_vlan() - Get vlan option
+ * @skb: Netlink message with request data
+ * @info: receiver information
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+int batadv_set_option_vlan(struct sk_buff *skb, struct genl_info *info)
+{
+	struct net *net = genl_info_net(info);
+	const struct batadv_option *option;
+	struct batadv_softif_vlan *vlan;
+	struct net_device *soft_iface;
+	union batadv_config_value val;
+	struct batadv_priv *bat_priv;
+	const char *option_name;
+	int option_type;
+	int ifindex;
+	u16 vid;
+	int ret;
+
+	if (!info->attrs[BATADV_ATTR_MESH_IFINDEX])
+		return -EINVAL;
+
+	if (!info->attrs[BATADV_ATTR_VLANID])
+		return -EINVAL;
+
+	if (!info->attrs[BATADV_ATTR_OPTION_NAME])
+		return -EINVAL;
+
+	if (!info->attrs[BATADV_ATTR_OPTION_TYPE])
+		return -EINVAL;
+
+	option_name = nla_data(info->attrs[BATADV_ATTR_OPTION_NAME]);
+	option = batadv_find_option(option_name, vlan_options,
+				    ARRAY_SIZE(vlan_options));
+	if (!option)
+		return -EOPNOTSUPP;
+
+	option_type = nla_get_u8(info->attrs[BATADV_ATTR_OPTION_TYPE]);
+	if (option_type != option->type)
+		return -EINVAL;
+
+	ret = batadv_option_value_get_from_info(option, info, &val);
+	if (ret < 0)
+		return ret;
+
+	ifindex = nla_get_u32(info->attrs[BATADV_ATTR_MESH_IFINDEX]);
+	soft_iface = dev_get_by_index(net, ifindex);
+	if (!soft_iface)
+		return -ENODEV;
+
+	if (!batadv_softif_is_valid(soft_iface)) {
+		ret = -EINVAL;
+		goto err_put_softif;
+	}
+
+	bat_priv = netdev_priv(soft_iface);
+
+	vid = nla_get_u16(info->attrs[BATADV_ATTR_VLANID]);
+	vlan = batadv_softif_vlan_get(bat_priv, vid | BATADV_VLAN_HAS_TAG);
+	if (!vlan) {
+		ret = -ENOENT;
+		goto err_put_softif;
+	}
+
+	ret = option->set(bat_priv, vlan, &val);
+	if (ret < 0)
+		goto err_put_vlan;
+
+	batadv_option_vlan_notify(bat_priv, vlan, option);
+
+err_put_vlan:
+	batadv_softif_vlan_put(vlan);
+err_put_softif:
+	dev_put(soft_iface);
+
+	return ret;
+}
+
+/**
+ * batadv_get_option_vlan_dump() - Dump vlan options into a message
+ * @msg: Netlink message to dump into
+ * @cb: Control block containing additional options
+ *
+ * Return: Error code, or length of message
+ */
+int batadv_get_option_vlan_dump(struct sk_buff *msg,
+				struct netlink_callback *cb)
+{
+	struct net *net = sock_net(cb->skb->sk);
+	unsigned int start = cb->args[0];
+	struct batadv_softif_vlan *vlan;
+	struct net_device *soft_iface;
+	struct batadv_priv *bat_priv;
+	struct nlattr *vid_attr;
+	unsigned int i;
+	int ifindex;
+	u16 vid;
+	int ret;
+
+	vid_attr = nlmsg_find_attr(cb->nlh, GENL_HDRLEN, BATADV_ATTR_VLANID);
+	if (!vid_attr)
+		return -EINVAL;
+
+	ifindex = batadv_netlink_get_ifindex(cb->nlh,
+					     BATADV_ATTR_MESH_IFINDEX);
+	if (!ifindex)
+		return -EINVAL;
+
+	soft_iface = dev_get_by_index(net, ifindex);
+	if (!soft_iface)
+		return -ENODEV;
+
+	if (!batadv_softif_is_valid(soft_iface)) {
+		ret = -EINVAL;
+		goto err_put_softif;
+	}
+
+	bat_priv = netdev_priv(soft_iface);
+
+	vid = nla_get_u16(vid_attr);
+	vlan = batadv_softif_vlan_get(bat_priv, vid | BATADV_VLAN_HAS_TAG);
+	if (!vlan) {
+		ret = -ENOENT;
+		goto err_put_softif;
+	}
+
+	for (i = start; i < ARRAY_SIZE(vlan_options); i++) {
+		ret = batadv_get_option_fill(msg, bat_priv, &vlan_options[i],
+					     vlan, BATADV_CMD_GET_OPTION_VLAN,
+					     NETLINK_CB(cb->skb).portid,
+					     cb->nlh->nlmsg_seq,
+					     NLM_F_MULTI);
+		if (ret == -EOPNOTSUPP)
+			continue;
+		if (ret < 0)
+			break;
+	}
+
+	cb->args[0] = i;
+	ret = msg->len;
+
+	batadv_softif_vlan_put(vlan);
+err_put_softif:
+	dev_put(soft_iface);
+
+	return ret;
+}
diff --git a/net/batman-adv/netlink_cfg.h b/net/batman-adv/netlink_cfg.h
new file mode 100644
index 00000000..0548926e
--- /dev/null
+++ b/net/batman-adv/netlink_cfg.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2010-2018  B.A.T.M.A.N. contributors:
+ *
+ * Sven Eckelmann
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef _NET_BATMAN_ADV_NETLINK_CFG_H_
+#define _NET_BATMAN_ADV_NETLINK_CFG_H_
+
+#include "main.h"
+
+#include <linux/types.h>
+
+struct genl_info;
+struct netlink_callback;
+struct netlink_ext_ack;
+struct sk_buff;
+
+#define __BATADV_PARAM_MAX_STRING_VALUE 32
+
+/**
+ * union batadv_config_value - variant storage for batadv_option
+ */
+union batadv_config_value {
+	u8 vu8;
+	u16 vu16;
+	u32 vu32;
+	unsigned int vbool:1;
+	char string[__BATADV_PARAM_MAX_STRING_VALUE];
+};
+
+/**
+ * struct batadv_option - configuration option data
+ * @name: name of option
+ * @type: netlink type of option
+ * @get: get option value
+ * @set: set option value
+ * @validate: (optional) pre-validate input data
+ */
+struct batadv_option {
+	const char *name;
+	int type;
+	int (*get)(struct batadv_priv *bat_priv, void *ext_arg,
+		   union batadv_config_value *val);
+	int (*set)(struct batadv_priv *bat_priv, void *ext_arg,
+		   const union batadv_config_value *val);
+	int (*validate)(struct batadv_priv *bat_priv, void *ext_arg,
+			const union batadv_config_value *val,
+			struct netlink_ext_ack *extack);
+};
+
+int batadv_get_option(struct sk_buff *skb, struct genl_info *info);
+int batadv_set_option(struct sk_buff *skb, struct genl_info *info);
+int batadv_get_option_dump(struct sk_buff *msg, struct netlink_callback *cb);
+
+int batadv_get_option_hardif(struct sk_buff *skb, struct genl_info *info);
+int batadv_set_option_hardif(struct sk_buff *skb, struct genl_info *info);
+int batadv_get_option_hardif_dump(struct sk_buff *msg,
+				  struct netlink_callback *cb);
+
+int batadv_get_option_vlan(struct sk_buff *skb, struct genl_info *info);
+int batadv_set_option_vlan(struct sk_buff *skb, struct genl_info *info);
+int batadv_get_option_vlan_dump(struct sk_buff *msg,
+				struct netlink_callback *cb);
+
+#endif /* _NET_BATMAN_ADV_NETLINK_CFG_H_ */
-- 
2.19.1


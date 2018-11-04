Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  4 Nov 2018 20:34:07 +0100
Message-Id: <20181104193408.18253-2-sven@narfation.org>
In-Reply-To: <20181104193408.18253-1-sven@narfation.org>
References: <20181104193408.18253-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC 1/2] batctl: Add generic netlink configuration
 subcommand
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

The batman-adv netlink commandset receive different new commands to read
and set the configuration values for mesh interfaces, hard interfaces and
VLANs. These are not yet accessible via the normal subcommands. But
developers still need access to them to test the kernel interface.

The "config" subcommand provides this functionality for all previously
mentioned command classes. It is not suitable for endusers because
there is no pretty printing and the user must know the exact type of
data (and unit) for the option he wants to change.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile     |   1 +
 batman_adv.h |  55 ++++++
 config.c     | 542 +++++++++++++++++++++++++++++++++++++++++++++++++++
 man/batctl.8 |  37 ++++
 netlink.c    |   3 +
 5 files changed, 638 insertions(+)
 create mode 100644 config.c

diff --git a/Makefile b/Makefile
index e6b2412..c285658 100755
--- a/Makefile
+++ b/Makefile
@@ -57,6 +57,7 @@ $(eval $(call add_command,bisect_iv,$(CONFIG_BATCTL_BISECT)))
 $(eval $(call add_command,bonding,y))
 $(eval $(call add_command,bridge_loop_avoidance,y))
 $(eval $(call add_command,claimtable,y))
+$(eval $(call add_command,config,n))
 $(eval $(call add_command,dat_cache,y))
 $(eval $(call add_command,distributed_arp_table,y))
 $(eval $(call add_command,event,y))
diff --git a/batman_adv.h b/batman_adv.h
index 324a0e1..9b5f5f2 100644
--- a/batman_adv.h
+++ b/batman_adv.h
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
diff --git a/config.c b/config.c
new file mode 100644
index 0000000..2c46e8d
--- /dev/null
+++ b/config.c
@@ -0,0 +1,542 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+ *
+ * Sven Eckelmann <sven@narfation.org>
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
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ */
+
+#include "main.h"
+#include "functions.h"
+
+#include <errno.h>
+#include <getopt.h>
+#include <net/if.h>
+#include <netinet/if_ether.h>
+#include <netlink/netlink.h>
+#include <netlink/genl/genl.h>
+#include <netlink/genl/ctrl.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <string.h>
+
+#include "batadv_packet.h"
+#include "batman_adv.h"
+#include "bat-hosts.h"
+#include "debug.h"
+#include "functions.h"
+#include "main.h"
+#include "netlink.h"
+
+enum config_mode {
+	CONFIG_MODE_MESH,
+	CONFIG_MODE_HARDIF,
+	CONFIG_MODE_VLAN,
+};
+
+static void config_usage(void)
+{
+	fprintf(stderr, "Usage: batctl [options] config [parameters] [name [type value]]\n");
+	fprintf(stderr, "parameters:\n");
+	fprintf(stderr, " \t -H,--hardif hardif to modify\n");
+	fprintf(stderr, " \t -V,--vlan   vlan to modify\n");
+}
+
+static int config_callback(struct nl_msg *msg, void *arg __maybe_unused)
+{
+	static const int config_mandatory[] = {
+		BATADV_ATTR_OPTION_NAME,
+		BATADV_ATTR_OPTION_TYPE,
+		/* BATADV_ATTR_OPTION_VALUE, */
+	};
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct nlattr *attrs[NUM_BATADV_ATTR];
+	struct genlmsghdr *ghdr;
+	const char *name;
+	uint8_t type;
+
+	if (!genlmsg_valid_hdr(nlh, 0))
+		return NL_OK;
+
+	ghdr = nlmsg_data(nlh);
+
+	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		return NL_OK;
+	}
+
+	/* ignore entry when attributes are missing */
+	if (missing_mandatory_attrs(attrs, config_mandatory,
+				    ARRAY_SIZE(config_mandatory)))
+		return NL_OK;
+
+	name = nla_get_string(attrs[BATADV_ATTR_OPTION_NAME]);
+	type = nla_get_u8(attrs[BATADV_ATTR_OPTION_TYPE]);
+
+	if (type != NLA_FLAG && !attrs[BATADV_ATTR_OPTION_VALUE])
+		return NL_OK;
+
+	switch (type) {
+	case NLA_U8:
+		printf("%s u8 %u\n", name,
+		       nla_get_u8(attrs[BATADV_ATTR_OPTION_VALUE]));
+		break;
+	case NLA_U16:
+		printf("%s u16 %u\n", name,
+		       nla_get_u16(attrs[BATADV_ATTR_OPTION_VALUE]));
+		break;
+	case NLA_U32:
+		printf("%s u32 %u\n", name,
+		       nla_get_u32(attrs[BATADV_ATTR_OPTION_VALUE]));
+		break;
+	case NLA_NUL_STRING:
+		printf("%s string %s\n", name,
+		       nla_get_string(attrs[BATADV_ATTR_OPTION_VALUE]));
+		break;
+	case NLA_FLAG:
+		printf("%s bool %s\n", name,
+		       attrs[BATADV_ATTR_OPTION_VALUE] ? "true" : "false");
+		break;
+	}
+
+	return NL_OK;
+}
+
+static int nl_error_cb(struct sockaddr_nl *nla __maybe_unused,
+		       struct nlmsgerr *nlerr, void *arg)
+{
+	int *ret = arg;
+
+	*ret = nlerr->error;
+
+	return NL_STOP;
+}
+
+static int nl_stop_cb(struct nl_msg *msg, void *arg)
+{
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	int *ret = arg;
+	int *error = nlmsg_data(nlh);
+
+	if (*error)
+		*ret = *error;
+
+	return NL_STOP;
+}
+
+static int config_nl_request(struct state *state, int ifindex,
+			     uint8_t nl_cmd, nl_recvmsg_msg_cb_t callback,
+			     int flags, enum config_mode config_mode,
+			     unsigned int hardif_index,
+			     uint16_t vlan_id, const char *option, int type,
+			     const void *val)
+{
+	struct nl_msg *msg;
+	void *user_hdr;
+	int ret;
+	int res;
+
+	ret = 0;
+
+	if (!state->sock)
+		return -EOPNOTSUPP;
+
+	if (callback)
+		nl_cb_set(state->cb, NL_CB_VALID, NL_CB_CUSTOM, config_callback, &ret);
+	else
+		nl_cb_set(state->cb, NL_CB_VALID, NL_CB_DEFAULT, NULL, NULL);
+
+	nl_cb_set(state->cb, NL_CB_FINISH, NL_CB_CUSTOM, nl_stop_cb, &ret);
+	nl_cb_err(state->cb, NL_CB_CUSTOM, nl_error_cb, &ret);
+
+	msg = nlmsg_alloc();
+	if (!msg) {
+		fprintf(stderr, "Error - could not allocate netlink message\n");
+		return EXIT_FAILURE;
+	}
+
+	user_hdr = genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ,
+			       state->batadv_family, 0, flags, nl_cmd, 1);
+	if (!user_hdr) {
+		fprintf(stderr, "Error - failed to store genl header in netlink message\n");
+		goto err_free_msg;
+	}
+
+	ret = nla_put_u32(msg, BATADV_ATTR_MESH_IFINDEX, ifindex);
+	if (ret < 0) {
+		fprintf(stderr, "Error - failed to store mesh ifindex in netlink message\n");
+		goto err_free_msg;
+	}
+
+	if (config_mode == CONFIG_MODE_HARDIF) {
+		ret = nla_put_u32(msg, BATADV_ATTR_HARD_IFINDEX, hardif_index);
+		if (ret < 0) {
+			fprintf(stderr, "Error - failed to store hard ifindex in netlink message\n");
+			goto err_free_msg;
+		}
+	}
+
+	if (config_mode == CONFIG_MODE_VLAN) {
+		ret = nla_put_u16(msg, BATADV_ATTR_VLANID, vlan_id);
+		if (ret < 0) {
+			fprintf(stderr, "Error - failed to store vlan id in netlink message\n");
+			goto err_free_msg;
+		}
+	}
+
+	if (option) {
+		ret = nla_put_string(msg, BATADV_ATTR_OPTION_NAME, option);
+		if (ret < 0) {
+			fprintf(stderr, "Error - failed to store option name in netlink message\n");
+			goto err_free_msg;
+		}
+	}
+
+	if (val) {
+		switch (type) {
+		case NLA_NUL_STRING:
+			ret = nla_put_string(msg, BATADV_ATTR_OPTION_VALUE, val);
+			break;
+		case NLA_U32:
+			ret = nla_put_u32(msg, BATADV_ATTR_OPTION_VALUE,
+					  *(uint32_t *)val);
+			break;
+		case NLA_U16:
+			ret = nla_put_u16(msg, BATADV_ATTR_OPTION_VALUE,
+					  *(uint16_t *)val);
+			break;
+		case NLA_U8:
+			ret = nla_put_u8(msg, BATADV_ATTR_OPTION_VALUE,
+					  *(uint8_t *)val);
+			break;
+		case NLA_FLAG:
+			if (*(bool *)val)
+				ret = nla_put_flag(msg,
+						   BATADV_ATTR_OPTION_VALUE);
+			else
+				ret = 0;
+			break;
+		default:
+			fprintf(stderr, "Error - unsupported type for option\n");
+			ret = -EINVAL;
+			goto err_free_msg;
+		}
+		if (ret < 0) {
+			fprintf(stderr, "Error - failed to store option value in netlink message\n");
+			goto err_free_msg;
+		}
+
+		ret = nla_put_u8(msg, BATADV_ATTR_OPTION_TYPE, type);
+		if (ret < 0) {
+			fprintf(stderr, "Error - failed to store option type in netlink message\n");
+			goto err_free_msg;
+		}
+	}
+
+	res = nl_send_auto_complete(state->sock, msg);
+	nlmsg_free(msg);
+
+	if (res < 0) {
+		fprintf(stderr, "Error - failed to send message: %s\n",
+			strerror(-res));
+		return res;
+	}
+
+	res = nl_recvmsgs(state->sock, state->cb);
+	if (res < 0 && res != -ECHILD) {
+		fprintf(stderr, "Error - failed to receive message: %s\n",
+			strerror(-res));
+		return res;
+	}
+
+	if (ret < 0) {
+		fprintf(stderr, "Error - failure while processing config request: %s\n",
+			strerror(-ret));
+		return res;
+	}
+
+	return ret;
+
+err_free_msg:
+	nlmsg_free(msg);
+	return ret;
+}
+
+static int config_dump(struct state *state, int ifindex,
+		       enum config_mode config_mode, unsigned int hardif_index,
+		       uint16_t vlan_id)
+{
+	enum batadv_nl_commands cmd;
+	int ret;
+
+	switch (config_mode) {
+	case CONFIG_MODE_MESH:
+		cmd = BATADV_CMD_GET_OPTION;
+		break;
+	case CONFIG_MODE_HARDIF:
+		cmd = BATADV_CMD_GET_OPTION_HARDIF;
+		break;
+	case CONFIG_MODE_VLAN:
+		cmd = BATADV_CMD_GET_OPTION_VLAN;
+		break;
+	}
+
+	ret = config_nl_request(state, ifindex, cmd, config_callback,
+				NLM_F_DUMP, config_mode, hardif_index, vlan_id,
+				NULL, NLA_UNSPEC, NULL);
+	if (ret < 0)
+		return EXIT_FAILURE;
+
+	return EXIT_SUCCESS;
+}
+
+static int config_get_option(struct state *state, int ifindex,
+			     enum config_mode config_mode,
+			     unsigned int hardif_index, uint16_t vlan_id,
+			     const char *option)
+{
+	enum batadv_nl_commands cmd;
+	int ret;
+
+	switch (config_mode) {
+	case CONFIG_MODE_MESH:
+		cmd = BATADV_CMD_GET_OPTION;
+		break;
+	case CONFIG_MODE_HARDIF:
+		cmd = BATADV_CMD_GET_OPTION_HARDIF;
+		break;
+	case CONFIG_MODE_VLAN:
+		cmd = BATADV_CMD_GET_OPTION_VLAN;
+		break;
+	}
+
+	ret = config_nl_request(state, ifindex, cmd, config_callback, 0,
+				config_mode, hardif_index, vlan_id, option,
+				NLA_UNSPEC, NULL);
+	if (ret < 0)
+		return EXIT_FAILURE;
+
+	return EXIT_SUCCESS;
+}
+
+static int config_set_option(struct state *state, int ifindex,
+			     enum config_mode config_mode,
+			     unsigned int hardif_index, uint16_t vlan_id,
+			     const char *option, const char *type,
+			     const char *value)
+{
+	enum batadv_nl_commands cmd;
+	unsigned long int val_ul;
+	const void *val;
+	uint32_t val_u32;
+	uint16_t val_u16;
+	uint8_t val_u8;
+	bool val_bool;
+	char *endptr;
+	int nl_type;
+	int ret;
+
+	switch (config_mode) {
+	case CONFIG_MODE_MESH:
+		cmd = BATADV_CMD_SET_OPTION;
+		break;
+	case CONFIG_MODE_HARDIF:
+		cmd = BATADV_CMD_SET_OPTION_HARDIF;
+		break;
+	case CONFIG_MODE_VLAN:
+		cmd = BATADV_CMD_SET_OPTION_VLAN;
+		break;
+	}
+
+	if (strcmp(type, "u32") == 0) {
+		nl_type = NLA_U32;
+	} else if (strcmp(type, "u16") == 0) {
+		nl_type = NLA_U16;
+	} else if (strcmp(type, "u8") == 0) {
+		nl_type = NLA_U8;
+	} else if (strcmp(type, "bool") == 0) {
+		nl_type = NLA_FLAG;
+	} else if (strcmp(type, "string") == 0) {
+		nl_type = NLA_NUL_STRING;
+	} else {
+		fprintf(stderr, "Error - unsupported type %s\n", type);
+		return EXIT_FAILURE;
+	}
+
+	switch (nl_type) {
+	case NLA_U32:
+	case NLA_U16:
+	case NLA_U8:
+		val_ul = strtoul(value, &endptr, 0);
+		if (value[0] == '\0' || endptr[0] != '\0') {
+			fprintf(stderr, "Error - failed to parse value as integer\n");
+			return EXIT_FAILURE;
+		}
+		break;
+	}
+
+	switch (nl_type) {
+	case NLA_U32:
+		if (val_ul > UINT32_MAX) {
+			fprintf(stderr, "Error - value too large for u32\n");
+			return EXIT_FAILURE;
+		}
+
+		val_u32 = val_ul;
+		val = &val_u32;
+		break;
+	case NLA_U16:
+		if (val_ul > UINT16_MAX) {
+			fprintf(stderr, "Error - value too large for u16\n");
+			return EXIT_FAILURE;
+		}
+
+		val_u16 = val_ul;
+		val = &val_u16;
+		break;
+	case NLA_U8:
+		if (val_ul > UINT8_MAX) {
+			fprintf(stderr, "Error - value too large for u8\n");
+			return EXIT_FAILURE;
+		}
+
+		val_u8 = val_ul;
+		val = &val_u8;
+		break;
+	case NLA_FLAG:
+		if (strcmp(value, "true") == 0) {
+			val_bool = true;
+		} else if (strcmp(value, "false") == 0) {
+			val_bool = false;
+		} else {
+			fprintf(stderr, "Error - unsupported boolean value %s\n", value);
+			return EXIT_FAILURE;
+		}
+		val = &val_bool;
+		break;
+	case NLA_NUL_STRING:
+		val = value;
+		break;
+	}
+
+	ret = config_nl_request(state, ifindex, cmd, NULL, 0,
+				config_mode, hardif_index, vlan_id, option,
+				nl_type, val);
+	if (ret < 0)
+		return EXIT_FAILURE;
+
+	return EXIT_SUCCESS;
+}
+
+static int config(struct state *state, int argc, char **argv)
+{
+	static const struct option config_options[] = {
+		{ "hardif", required_argument, NULL, 'H' },
+		{ "vlan", required_argument, NULL,  'V' },
+		{ NULL, 0, NULL, 0 }
+	};
+
+	enum config_mode config_mode = CONFIG_MODE_MESH;
+	unsigned int hardif_index = 0;
+	unsigned long int vlan;
+	uint16_t vlan_id = 0;
+	const char *option;
+	const char *value;
+	const char *type;
+	char *endptr;
+	int ifindex;
+	int opt;
+
+	while ((opt = getopt_long(argc, argv, "+H:V:", config_options,
+				  NULL)) != -1) {
+		switch (opt) {
+		case 'H':
+			if (config_mode != CONFIG_MODE_MESH) {
+				fprintf(stderr, "Error - multiple targets specified\n");
+				return EXIT_FAILURE;
+			}
+
+			config_mode = CONFIG_MODE_HARDIF;
+			hardif_index = if_nametoindex(optarg);
+			if (hardif_index == 0) {
+				perror("Error - unable to get index for interface");
+				return EXIT_FAILURE;
+			}
+			break;
+		case 'V':
+			if (config_mode != CONFIG_MODE_MESH) {
+				fprintf(stderr, "Error - multiple targets specified\n");
+				return EXIT_FAILURE;
+			}
+
+			config_mode = CONFIG_MODE_VLAN;
+			vlan = strtoul(optarg, &endptr, 0);
+			if (optarg[0] == '\0' || endptr[0] != '\0') {
+				fprintf(stderr, "Error - failed to parse vlan id\n");
+				return EXIT_FAILURE;
+			}
+
+			if (vlan > 4095) {
+				fprintf(stderr, "Error - invalid vlan id\n");
+				return EXIT_FAILURE;
+			}
+
+			vlan_id = vlan;
+			break;
+		default:
+			config_usage();
+			return EXIT_FAILURE;
+		}
+	}
+
+	argv += optind;
+	argc -= optind;
+	optind = 0;
+
+	ifindex = if_nametoindex(state->mesh_iface);
+	if (!ifindex) {
+		perror("Error - failed to retrieve mesh interface");
+		return EXIT_FAILURE;
+	}
+
+	if (argc <= 0)
+		return config_dump(state, ifindex, config_mode, hardif_index,
+				   vlan_id);
+
+	option = argv[0];
+	if (argc == 1)
+		return config_get_option(state, ifindex, config_mode,
+					 hardif_index, vlan_id, option);
+
+	if (argc != 3) {
+		config_usage();
+		return EXIT_FAILURE;
+	}
+
+	type = argv[1];
+	value = argv[2];
+
+	return config_set_option(state, ifindex, config_mode, hardif_index,
+				 vlan_id, option, type, value);
+}
+
+COMMAND(SUBCOMMAND, config, "c",
+	COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK, NULL,
+	"<selector>     \treceive or set config option");
diff --git a/man/batctl.8 b/man/batctl.8
index 2e3232f..c542eef 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -338,6 +338,43 @@ specific sequence number, min. Furthermore using "\-o" you can filter the output
 given batctl will not replace the MAC addresses with bat\-host names in the output.
 .RE
 .br
+.IP "\fBconfig\fP [\fB\-H hardif\fP][\fB\-V VLANID\fP] \fBoption\fP [\fBtype\fP \fBvalue\fP]"
+Gets or sets raw configuration options in the batman-adv module for either the
+batadv soft interface, a hard (slave) interface or a VLAN of the batadv soft
+interface. Providing no option name will dump all the configuration options
+for the selected softif/hardif/VLAN. Providing only the option name will
+retrieve the configuration configuration value. Providing a full
+option\-type\-value tripplet will set the value in the kernel. The supported
+types are u32 (0-4294967295), u16 (0-65535), u8 (0-255), bool (true/false) and
+string.
+For example:
+.sp
+.if n \{\
+.RS 10
+.\}
+.nf
+# retrieve all configuration options for the soft interface
+batctl config
+# retrieve all configuration options for the hard interface
+batctl config -H eth0
+# retrieve all configuration options for the VLANID 0
+batctl config -V 0
+
+# retrieve throughput_override for hard interface eth0
+batctl config -H eth0 throughput_override u32
+
+# set fragmentation for bat0
+batctl config fragmentation bool false
+
+# set orig_interval for bat0
+batctl config orig_interval u32 5000
+.fi
+.if n \{\
+.RE
+.\}
+.RE
+.PP
+.br
 .IP "\fBthroughputmeter\fP|\fBtp\fP \fBMAC\fP"
 This command starts a throughput test entirely controlled by batman module in
 kernel space: the computational resources needed to align memory and copy data
diff --git a/netlink.c b/netlink.c
index 5285759..34cd720 100644
--- a/netlink.c
+++ b/netlink.c
@@ -107,6 +107,9 @@ struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_DAT_CACHE_VID]		= { .type = NLA_U16 },
 	[BATADV_ATTR_MCAST_FLAGS]		= { .type = NLA_U32 },
 	[BATADV_ATTR_MCAST_FLAGS_PRIV]		= { .type = NLA_U32 },
+	[BATADV_ATTR_VLANID]			= { .type = NLA_U16 },
+	[BATADV_ATTR_OPTION_NAME]		= { .type = NLA_NUL_STRING },
+	[BATADV_ATTR_OPTION_TYPE]		= { .type = NLA_U8 },
 };
 
 int netlink_create(struct state *state)
-- 
2.19.1


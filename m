Return-Path: <sven.eckelmann@openmesh.com>
From: Sven Eckelmann <sven.eckelmann@openmesh.com>
Date: Wed, 24 May 2017 12:32:07 +0200
Message-Id: <20170524103211.810-1-sven.eckelmann@openmesh.com>
In-Reply-To: <4690435.IOLn72U8Ez@bentobox>
References: <4690435.IOLn72U8Ez@bentobox>
Subject: [B.A.T.M.A.N.] [PATCH 1/5] alfred: Move alfred specific netlink
	code in separate file
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
Cc: Sven Eckelmann <sven.eckelmann@openmesh.com>

The vis daemon doesn't require the same set of netlink functions as alfred
daemon. But the netlink.c file is shared between both. Split the file to
avoid a lot of dead code in vis.

Signed-off-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
---
 Makefile         |   1 +
 batadv_query.c   |   2 +-
 batadv_querynl.c | 236 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 batadv_querynl.h |  35 +++++++++
 netlink.c        | 195 ---------------------------------------------
 netlink.h        |   7 --
 6 files changed, 273 insertions(+), 203 deletions(-)
 create mode 100644 batadv_querynl.c
 create mode 100644 batadv_querynl.h

diff --git a/Makefile b/Makefile
index 3c88e96..4c1c6b5 100755
--- a/Makefile
+++ b/Makefile
@@ -21,6 +21,7 @@
 # alfred build
 BINARY_NAME = alfred
 OBJ += batadv_query.o
+OBJ += batadv_querynl.o
 OBJ += client.o
 OBJ += debugfs.o
 OBJ += hash.o
diff --git a/batadv_query.c b/batadv_query.c
index 6ec086b..e68052b 100644
--- a/batadv_query.c
+++ b/batadv_query.c
@@ -34,7 +34,7 @@
 #endif
 #include <sys/types.h>
 
-#include "netlink.h"
+#include "batadv_querynl.h"
 #include "debugfs.h"
 
 #define DEBUG_BATIF_PATH_FMT "%s/batman_adv/%s"
diff --git a/batadv_querynl.c b/batadv_querynl.c
new file mode 100644
index 0000000..8dab96e
--- /dev/null
+++ b/batadv_querynl.c
@@ -0,0 +1,236 @@
+/*
+ * Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner <mareklindner@neomailbox.ch>, Andrew Lunn <andrew@lunn.ch>
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
+ */
+
+#include "batadv_querynl.h"
+
+#include <stdbool.h>
+#include <stddef.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <errno.h>
+#include <net/ethernet.h>
+#include <net/if.h>
+#include <netlink/netlink.h>
+#include <netlink/genl/genl.h>
+#include <netlink/genl/ctrl.h>
+#include <net/ethernet.h>
+
+#include "batman_adv.h"
+#include "netlink.h"
+
+#ifndef __unused
+#define __unused __attribute__((unused))
+#endif
+
+static const int translate_mac_netlink_mandatory[] = {
+	BATADV_ATTR_TT_ADDRESS,
+	BATADV_ATTR_ORIG_ADDRESS,
+};
+
+struct translate_mac_netlink_opts {
+	struct ether_addr mac;
+	bool found;
+	struct nlquery_opts query_opts;
+};
+
+static int translate_mac_netlink_cb(struct nl_msg *msg, void *arg)
+{
+	struct nlattr *attrs[BATADV_ATTR_MAX + 1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct nlquery_opts *query_opts = arg;
+	struct translate_mac_netlink_opts *opts;
+	struct genlmsghdr *ghdr;
+	uint8_t *addr;
+	uint8_t *orig;
+
+	opts = container_of(query_opts, struct translate_mac_netlink_opts,
+			    query_opts);
+
+	if (!genlmsg_valid_hdr(nlh, 0))
+		return NL_OK;
+
+	ghdr = nlmsg_data(nlh);
+
+	if (ghdr->cmd != BATADV_CMD_GET_TRANSTABLE_GLOBAL)
+		return NL_OK;
+
+	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
+		return NL_OK;
+	}
+
+	if (missing_mandatory_attrs(attrs, translate_mac_netlink_mandatory,
+				    ARRAY_SIZE(translate_mac_netlink_mandatory)))
+		return NL_OK;
+
+	addr = nla_data(attrs[BATADV_ATTR_TT_ADDRESS]);
+	orig = nla_data(attrs[BATADV_ATTR_ORIG_ADDRESS]);
+
+	if (!attrs[BATADV_ATTR_FLAG_BEST])
+		return NL_OK;
+
+	if (memcmp(&opts->mac, addr, ETH_ALEN) != 0)
+		return NL_OK;
+
+	memcpy(&opts->mac, orig, ETH_ALEN);
+	opts->found = true;
+	opts->query_opts.err = 0;
+
+	return NL_STOP;
+}
+
+int translate_mac_netlink(const char *mesh_iface, const struct ether_addr *mac,
+			  struct ether_addr *mac_out)
+{
+	struct translate_mac_netlink_opts opts = {
+		.found = false,
+		.query_opts = {
+			.err = 0,
+		},
+	};
+	int ret;
+
+	memcpy(&opts.mac, mac, ETH_ALEN);
+
+	ret = netlink_query_common(mesh_iface,
+				   BATADV_CMD_GET_TRANSTABLE_GLOBAL,
+				   translate_mac_netlink_cb, &opts.query_opts);
+	if (ret < 0)
+		return ret;
+
+	if (!opts.found)
+		return -ENOENT;
+
+	memcpy(mac_out, &opts.mac, ETH_ALEN);
+
+	return 0;
+}
+
+static const int get_tq_netlink_mandatory[] = {
+	BATADV_ATTR_ORIG_ADDRESS,
+	BATADV_ATTR_TQ,
+};
+
+struct get_tq_netlink_opts {
+	struct ether_addr mac;
+	uint8_t tq;
+	bool found;
+	struct nlquery_opts query_opts;
+};
+
+static int get_tq_netlink_cb(struct nl_msg *msg, void *arg)
+{
+	struct nlattr *attrs[BATADV_ATTR_MAX + 1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct nlquery_opts *query_opts = arg;
+	struct get_tq_netlink_opts *opts;
+	struct genlmsghdr *ghdr;
+	uint8_t *orig;
+	uint8_t tq;
+
+	opts = container_of(query_opts, struct get_tq_netlink_opts,
+			    query_opts);
+
+	if (!genlmsg_valid_hdr(nlh, 0))
+		return NL_OK;
+
+	ghdr = nlmsg_data(nlh);
+
+	if (ghdr->cmd != BATADV_CMD_GET_ORIGINATORS)
+		return NL_OK;
+
+	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
+		return NL_OK;
+	}
+
+	if (missing_mandatory_attrs(attrs, get_tq_netlink_mandatory,
+				    ARRAY_SIZE(get_tq_netlink_mandatory)))
+		return NL_OK;
+
+	orig = nla_data(attrs[BATADV_ATTR_ORIG_ADDRESS]);
+	tq = nla_get_u8(attrs[BATADV_ATTR_TQ]);
+
+	if (!attrs[BATADV_ATTR_FLAG_BEST])
+		return NL_OK;
+
+	if (memcmp(&opts->mac, orig, ETH_ALEN) != 0)
+		return NL_OK;
+
+	opts->tq = tq;
+	opts->found = true;
+	opts->query_opts.err = 0;
+
+	return NL_STOP;
+}
+
+int get_tq_netlink(const char *mesh_iface, const struct ether_addr *mac,
+		   uint8_t *tq)
+{
+	struct get_tq_netlink_opts opts = {
+		.tq = 0,
+		.found = false,
+		.query_opts = {
+			.err = 0,
+		},
+	};
+	int ret;
+
+	memcpy(&opts.mac, mac, ETH_ALEN);
+
+	ret = netlink_query_common(mesh_iface,  BATADV_CMD_GET_ORIGINATORS,
+				   get_tq_netlink_cb, &opts.query_opts);
+	if (ret < 0)
+		return ret;
+
+	if (!opts.found)
+		return -ENOENT;
+
+	*tq = opts.tq;
+
+	return 0;
+}
+
+static int check_nlcmd_cb(struct nl_msg *msg __unused, void *arg __unused)
+{
+	return NL_STOP;
+}
+
+int batadv_interface_check_netlink(const char *mesh_iface)
+{
+	struct nlquery_opts opts = {
+		.err = 0,
+	};
+	int ret;
+
+	ret = netlink_query_common(mesh_iface,  BATADV_CMD_GET_ORIGINATORS,
+				   check_nlcmd_cb, &opts);
+	if (ret < 0)
+		return ret;
+
+	ret = netlink_query_common(mesh_iface, BATADV_CMD_GET_TRANSTABLE_GLOBAL,
+				   check_nlcmd_cb, &opts);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
diff --git a/batadv_querynl.h b/batadv_querynl.h
new file mode 100644
index 0000000..9b93a47
--- /dev/null
+++ b/batadv_querynl.h
@@ -0,0 +1,35 @@
+/*
+ * Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner <mareklindner@neomailbox.ch>, Andrew Lunn <andrew@lunn.ch>
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
+ */
+
+#ifndef _BATADV_QUERYNL_H
+#define _BATADV_QUERYNL_H
+
+#include <stdint.h>
+
+struct ether_addr;
+
+int translate_mac_netlink(const char *mesh_iface, const struct ether_addr *mac,
+			  struct ether_addr *mac_out);
+int get_tq_netlink(const char *mesh_iface, const struct ether_addr *mac,
+		   uint8_t *tq);
+int batadv_interface_check_netlink(const char *mesh_iface);
+
+#endif /* _BATADV_QUERYNL_H */
diff --git a/netlink.c b/netlink.c
index 1964ab8..7ef4308 100644
--- a/netlink.c
+++ b/netlink.c
@@ -27,7 +27,6 @@
 #include <string.h>
 #include <unistd.h>
 #include <errno.h>
-#include <net/ethernet.h>
 #include <net/if.h>
 #include <netlink/netlink.h>
 #include <netlink/genl/genl.h>
@@ -196,197 +195,3 @@ err_free_sock:
 
 	return query_opts->err;
 }
-
-static const int translate_mac_netlink_mandatory[] = {
-	BATADV_ATTR_TT_ADDRESS,
-	BATADV_ATTR_ORIG_ADDRESS,
-};
-
-struct translate_mac_netlink_opts {
-	struct ether_addr mac;
-	bool found;
-	struct nlquery_opts query_opts;
-};
-
-static int translate_mac_netlink_cb(struct nl_msg *msg, void *arg)
-{
-	struct nlattr *attrs[BATADV_ATTR_MAX+1];
-	struct nlmsghdr *nlh = nlmsg_hdr(msg);
-	struct nlquery_opts *query_opts = arg;
-	struct translate_mac_netlink_opts *opts;
-	struct genlmsghdr *ghdr;
-	uint8_t *addr;
-	uint8_t *orig;
-
-	opts = container_of(query_opts, struct translate_mac_netlink_opts,
-			    query_opts);
-
-	if (!genlmsg_valid_hdr(nlh, 0))
-		return NL_OK;
-
-	ghdr = nlmsg_data(nlh);
-
-	if (ghdr->cmd != BATADV_CMD_GET_TRANSTABLE_GLOBAL)
-		return NL_OK;
-
-	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
-		      genlmsg_len(ghdr), batadv_netlink_policy)) {
-		return NL_OK;
-	}
-
-	if (missing_mandatory_attrs(attrs, translate_mac_netlink_mandatory,
-				    ARRAY_SIZE(translate_mac_netlink_mandatory)))
-		return NL_OK;
-
-	addr = nla_data(attrs[BATADV_ATTR_TT_ADDRESS]);
-	orig = nla_data(attrs[BATADV_ATTR_ORIG_ADDRESS]);
-
-	if (!attrs[BATADV_ATTR_FLAG_BEST])
-		return NL_OK;
-
-	if (memcmp(&opts->mac, addr, ETH_ALEN) != 0)
-		return NL_OK;
-
-	memcpy(&opts->mac, orig, ETH_ALEN);
-	opts->found = true;
-	opts->query_opts.err = 0;
-
-	return NL_STOP;
-}
-
-int translate_mac_netlink(const char *mesh_iface, const struct ether_addr *mac,
-			  struct ether_addr *mac_out)
-{
-	struct translate_mac_netlink_opts opts = {
-		.found = false,
-		.query_opts = {
-			.err = 0,
-		},
-	};
-	int ret;
-
-	memcpy(&opts.mac, mac, ETH_ALEN);
-
-	ret = netlink_query_common(mesh_iface,
-				   BATADV_CMD_GET_TRANSTABLE_GLOBAL,
-			           translate_mac_netlink_cb, &opts.query_opts);
-	if (ret < 0)
-		return ret;
-
-	if (!opts.found)
-		return -ENOENT;
-
-	memcpy(mac_out, &opts.mac, ETH_ALEN);
-
-	return 0;
-}
-
-static const int get_tq_netlink_mandatory[] = {
-	BATADV_ATTR_ORIG_ADDRESS,
-	BATADV_ATTR_TQ,
-};
-
-struct get_tq_netlink_opts {
-	struct ether_addr mac;
-	uint8_t tq;
-	bool found;
-	struct nlquery_opts query_opts;
-};
-
-static int get_tq_netlink_cb(struct nl_msg *msg, void *arg)
-{
-	struct nlattr *attrs[BATADV_ATTR_MAX+1];
-	struct nlmsghdr *nlh = nlmsg_hdr(msg);
-	struct nlquery_opts *query_opts = arg;
-	struct get_tq_netlink_opts *opts;
-	struct genlmsghdr *ghdr;
-	uint8_t *orig;
-	uint8_t tq;
-
-	opts = container_of(query_opts, struct get_tq_netlink_opts,
-			    query_opts);
-
-	if (!genlmsg_valid_hdr(nlh, 0))
-		return NL_OK;
-
-	ghdr = nlmsg_data(nlh);
-
-	if (ghdr->cmd != BATADV_CMD_GET_ORIGINATORS)
-		return NL_OK;
-
-	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
-		      genlmsg_len(ghdr), batadv_netlink_policy)) {
-		return NL_OK;
-	}
-
-	if (missing_mandatory_attrs(attrs, get_tq_netlink_mandatory,
-				    ARRAY_SIZE(get_tq_netlink_mandatory)))
-		return NL_OK;
-
-	orig = nla_data(attrs[BATADV_ATTR_ORIG_ADDRESS]);
-	tq = nla_get_u8(attrs[BATADV_ATTR_TQ]);
-
-	if (!attrs[BATADV_ATTR_FLAG_BEST])
-		return NL_OK;
-
-	if (memcmp(&opts->mac, orig, ETH_ALEN) != 0)
-		return NL_OK;
-
-	opts->tq = tq;
-	opts->found = true;
-	opts->query_opts.err = 0;
-
-	return NL_STOP;
-}
-
-int get_tq_netlink(const char *mesh_iface, const struct ether_addr *mac,
-		   uint8_t *tq)
-{
-	struct get_tq_netlink_opts opts = {
-		.tq = 0,
-		.found = false,
-		.query_opts = {
-			.err = 0,
-		},
-	};
-	int ret;
-
-	memcpy(&opts.mac, mac, ETH_ALEN);
-
-	ret = netlink_query_common(mesh_iface,  BATADV_CMD_GET_ORIGINATORS,
-			           get_tq_netlink_cb, &opts.query_opts);
-	if (ret < 0)
-		return ret;
-
-	if (!opts.found)
-		return -ENOENT;
-
-	*tq = opts.tq;
-
-	return 0;
-}
-
-static int check_nlcmd_cb(struct nl_msg *msg __unused, void *arg __unused)
-{
-	return NL_STOP;
-}
-
-int batadv_interface_check_netlink(const char *mesh_iface)
-{
-	struct nlquery_opts opts = {
-		.err = 0,
-	};
-	int ret;
-
-	ret = netlink_query_common(mesh_iface,  BATADV_CMD_GET_ORIGINATORS,
-				   check_nlcmd_cb, &opts);
-	if (ret < 0)
-		return ret;
-
-	ret = netlink_query_common(mesh_iface, BATADV_CMD_GET_TRANSTABLE_GLOBAL,
-				   check_nlcmd_cb, &opts);
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
diff --git a/netlink.h b/netlink.h
index 1c87695..a4471a1 100644
--- a/netlink.h
+++ b/netlink.h
@@ -26,8 +26,6 @@
 #include <netlink/genl/ctrl.h>
 #include <stddef.h>
 
-struct ether_addr;
-
 struct nlquery_opts {
 	int err;
 };
@@ -45,11 +43,6 @@ int netlink_query_common(const char *mesh_iface, uint8_t nl_cmd,
 			 struct nlquery_opts *query_opts);
 int missing_mandatory_attrs(struct nlattr *attrs[],  const int mandatory[],
 			    size_t num);
-int translate_mac_netlink(const char *mesh_iface, const struct ether_addr *mac,
-			  struct ether_addr *mac_out);
-int get_tq_netlink(const char *mesh_iface, const struct ether_addr *mac,
-		   uint8_t *tq);
-int batadv_interface_check_netlink(const char *mesh_iface);
 
 extern struct nla_policy batadv_netlink_policy[];
 
-- 
2.11.0


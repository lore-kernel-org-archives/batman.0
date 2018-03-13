Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Tue, 13 Mar 2018 11:43:58 +0100
Message-Id: <20180313104358.19895-5-linus.luessing@c0d3.blue>
In-Reply-To: <20180313104358.19895-1-linus.luessing@c0d3.blue>
References: <20180313104358.19895-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH v3 4/4] batctl: add netlink dump function for
 multicast flags table
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

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 debug.c   |   1 +
 netlink.c | 143 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 netlink.h |   2 +
 3 files changed, 146 insertions(+)

diff --git a/debug.c b/debug.c
index 5f9a87b..63fb633 100644
--- a/debug.c
+++ b/debug.c
@@ -100,6 +100,7 @@ const struct debug_table_data batctl_debug_tables[BATCTL_TABLE_NUM] = {
 		.opt_short = "mf",
 		.debugfs_name = "mcast_flags",
 		.header_lines = 6,
+		.netlink_fn = netlink_print_mcast_flags,
 	},
 };
 
diff --git a/netlink.c b/netlink.c
index 124ff67..ab7be1e 100644
--- a/netlink.c
+++ b/netlink.c
@@ -123,10 +123,14 @@ struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 						    .minlen = ETH_ALEN,
 						    .maxlen = ETH_ALEN },
 	[BATADV_ATTR_DAT_CACHE_VID]		= { .type = NLA_U16 },
+	[BATADV_ATTR_MCAST_FLAGS]		= { .type = NLA_U32 },
+	[BATADV_ATTR_MCAST_FLAGS_PRIV]		= { .type = NLA_U32 },
 };
 
 static int last_err;
 static char algo_name_buf[256] = "";
+static int64_t mcast_flags = -EOPNOTSUPP;
+static int64_t mcast_flags_priv = -EOPNOTSUPP;
 
 static int missing_mandatory_attrs(struct nlattr *attrs[],
 				   const int mandatory[], int num)
@@ -240,6 +244,16 @@ static int info_callback(struct nl_msg *msg, void *arg)
 		if (attrs[BATADV_ATTR_BLA_CRC])
 			bla_group_id = nla_get_u16(attrs[BATADV_ATTR_BLA_CRC]);
 
+		if (attrs[BATADV_ATTR_MCAST_FLAGS])
+			mcast_flags = nla_get_u32(attrs[BATADV_ATTR_MCAST_FLAGS]);
+		else
+			mcast_flags = -EOPNOTSUPP;
+
+		if (attrs[BATADV_ATTR_MCAST_FLAGS_PRIV])
+			mcast_flags_priv = nla_get_u32(attrs[BATADV_ATTR_MCAST_FLAGS_PRIV]);
+		else
+			mcast_flags = -EOPNOTSUPP;
+
 		switch (opts->nl_cmd) {
 		case BATADV_CMD_GET_TRANSTABLE_LOCAL:
 			ret = asprintf(&extra_info, ", TTVN: %u", ttvn);
@@ -1183,6 +1197,72 @@ static int dat_cache_callback(struct nl_msg *msg, void *arg)
 	return NL_OK;
 }
 
+static const int mcast_flags_mandatory[] = {
+	BATADV_ATTR_ORIG_ADDRESS,
+};
+
+static int mcast_flags_callback(struct nl_msg *msg, void *arg)
+{
+	struct nlattr *attrs[BATADV_ATTR_MAX+1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct print_opts *opts = arg;
+	struct bat_host *bat_host;
+	struct genlmsghdr *ghdr;
+	uint32_t flags;
+	uint8_t *addr;
+
+	if (!genlmsg_valid_hdr(nlh, 0)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	ghdr = nlmsg_data(nlh);
+
+	if (ghdr->cmd != BATADV_CMD_GET_MCAST_FLAGS)
+		return NL_OK;
+
+	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	if (missing_mandatory_attrs(attrs, mcast_flags_mandatory,
+				    ARRAY_SIZE(mcast_flags_mandatory))) {
+		fputs("Missing attributes from kernel\n", stderr);
+		exit(1);
+	}
+
+	addr = nla_data(attrs[BATADV_ATTR_ORIG_ADDRESS]);
+
+	if (opts->read_opt & MULTICAST_ONLY && !(addr[0] & 0x01))
+		return NL_OK;
+
+	if (opts->read_opt & UNICAST_ONLY && (addr[0] & 0x01))
+		return NL_OK;
+
+	bat_host = bat_hosts_find_by_mac((char *)addr);
+	if (!(opts->read_opt & USE_BAT_HOSTS) || !bat_host)
+		printf("%02x:%02x:%02x:%02x:%02x:%02x ",
+		       addr[0], addr[1], addr[2],
+		       addr[3], addr[4], addr[5]);
+	else
+		printf("%17s ", bat_host->name);
+
+	if (attrs[BATADV_ATTR_MCAST_FLAGS]) {
+		flags = nla_get_u32(attrs[BATADV_ATTR_MCAST_FLAGS]);
+
+		printf("[%c%c%c]\n",
+		       flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES ? 'U' : '.',
+		       flags & BATADV_MCAST_WANT_ALL_IPV4 ? '4' : '.',
+		       flags & BATADV_MCAST_WANT_ALL_IPV6 ? '6' : '.');
+	} else {
+		printf("-\n");
+	}
+
+	return NL_OK;
+}
+
 static int netlink_print_common(char *mesh_iface, char *orig_iface,
 				int read_opt, float orig_timeout,
 				float watch_interval, const char *header,
@@ -1437,6 +1517,69 @@ int netlink_print_dat_cache(char *mesh_iface, char *orig_iface, int read_opts,
 	return ret;
 }
 
+int netlink_print_mcast_flags(char *mesh_iface, char *orig_iface, int read_opts,
+			      float orig_timeout, float watch_interval)
+{
+	char querier4, querier6, shadowing4, shadowing6;
+	char *info_header;
+	char *header;
+	bool bridged;
+	int ifindex;
+	int ret;
+
+	ifindex = if_nametoindex(mesh_iface);
+	if (!ifindex) {
+		fprintf(stderr, "Interface %s is unknown\n", mesh_iface);
+		return -ENODEV;
+	}
+
+	/* only parse own multicast flags */
+	info_header = netlink_get_info(ifindex, BATADV_CMD_GET_MCAST_FLAGS, NULL);
+	free(info_header);
+
+	if (mcast_flags == -EOPNOTSUPP || mcast_flags_priv == -EOPNOTSUPP)
+		return -EOPNOTSUPP;
+
+	bridged = mcast_flags_priv & BATADV_MCAST_FLAGS_BRIDGED;
+
+	if (bridged) {
+                querier4 = (mcast_flags_priv & BATADV_MCAST_FLAGS_QUERIER_IPV4_EXISTS) ? '.' : '4';
+                querier6 = (mcast_flags_priv & BATADV_MCAST_FLAGS_QUERIER_IPV6_EXISTS) ? '.' : '6';
+                shadowing4 = (mcast_flags_priv & BATADV_MCAST_FLAGS_QUERIER_IPV4_SHADOWING) ? '4' : '.';
+                shadowing6 = (mcast_flags_priv & BATADV_MCAST_FLAGS_QUERIER_IPV6_SHADOWING) ? '6' : '.';
+        } else {
+                querier4 = '?';
+                querier6 = '?';
+                shadowing4 = '?';
+                shadowing6 = '?';
+        }
+
+	ret = asprintf(&header,
+		"Multicast flags (own flags: [%c%c%c])\n"
+		 "* Bridged [U]\t\t\t\t%c\n"
+		 "* No IGMP/MLD Querier [4/6]:\t\t%c/%c\n"
+		 "* Shadowing IGMP/MLD Querier [4/6]:\t%c/%c\n"
+		 "-------------------------------------------\n"
+		 "       %-10s %s\n",
+		 (mcast_flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES) ? 'U' : '.',
+		 (mcast_flags & BATADV_MCAST_WANT_ALL_IPV4) ? '4' : '.',
+		 (mcast_flags & BATADV_MCAST_WANT_ALL_IPV6) ? '6' : '.',
+		 bridged ? 'U' : '.',
+		 querier4, querier6, shadowing4, shadowing6,
+		 "Originator", "Flags");
+
+	if (ret < 0)
+		return ret;
+
+	ret = netlink_print_common(mesh_iface, orig_iface, read_opts,
+				   orig_timeout, watch_interval, header,
+				   BATADV_CMD_GET_MCAST_FLAGS,
+				   mcast_flags_callback);
+
+	free(header);
+	return ret;
+}
+
 static int nlquery_error_cb(struct sockaddr_nl *nla __maybe_unused,
 			    struct nlmsgerr *nlerr, void *arg)
 {
diff --git a/netlink.h b/netlink.h
index 57870c2..089e25e 100644
--- a/netlink.h
+++ b/netlink.h
@@ -47,6 +47,8 @@ int netlink_print_bla_backbone(char *mesh_iface, char *orig_iface, int read_opt,
 			       float orig_timeout, float watch_interval);
 int netlink_print_dat_cache(char *mesh_iface, char *orig_iface, int read_opt,
 			    float orig_timeout, float watch_interval);
+int netlink_print_mcast_flags(char *mesh_iface, char *orig_iface, int read_opt,
+			      float orig_timeout, float watch_interval);
 
 int translate_mac_netlink(const char *mesh_iface, const struct ether_addr *mac,
 			  struct ether_addr *mac_out);
-- 
2.11.0


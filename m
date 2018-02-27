Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Tue, 27 Feb 2018 09:10:57 +0100
Message-Id: <20180227081059.13234-2-linus.luessing@c0d3.blue>
In-Reply-To: <20180227081059.13234-1-linus.luessing@c0d3.blue>
References: <20180227081059.13234-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 2/4] batctl: add netlink dump function for
 DAT cache table
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
 netlink.c | 103 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 netlink.h |   2 ++
 3 files changed, 106 insertions(+)

diff --git a/debug.c b/debug.c
index a7c5adf..5f9a87b 100644
--- a/debug.c
+++ b/debug.c
@@ -87,6 +87,7 @@ const struct debug_table_data batctl_debug_tables[BATCTL_TABLE_NUM] = {
 		.opt_short = "dc",
 		.debugfs_name = "dat_cache",
 		.header_lines = 2,
+		.netlink_fn = netlink_print_dat_cache,
 	},
 	{
 		.opt_long = "nc_nodes",
diff --git a/netlink.c b/netlink.c
index 126066b..35f74c9 100644
--- a/netlink.c
+++ b/netlink.c
@@ -118,6 +118,11 @@ struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 					    .minlen = ETH_ALEN,
 					    .maxlen = ETH_ALEN },
 	[BATADV_ATTR_BLA_CRC]		= { .type = NLA_U16 },
+	[BATADV_ATTR_DC_ADDRESS]	= { .type = NLA_U32 },
+	[BATADV_ATTR_DC_HWADDRESS]	= { .type = NLA_UNSPEC,
+					    .minlen = ETH_ALEN,
+					    .maxlen = ETH_ALEN },
+	[BATADV_ATTR_DC_VID]		= { .type = NLA_U16 },
 };
 
 static int last_err;
@@ -1104,6 +1109,82 @@ static int bla_backbone_callback(struct nl_msg *msg, void *arg)
 	return NL_OK;
 }
 
+static const int dat_cache_mandatory[] = {
+	BATADV_ATTR_DC_ADDRESS,
+	BATADV_ATTR_DC_HWADDRESS,
+	BATADV_ATTR_DC_VID,
+	BATADV_ATTR_LAST_SEEN_MSECS,
+};
+
+static int dat_cache_callback(struct nl_msg *msg, void *arg)
+{
+	int last_seen_msecs, last_seen_secs, last_seen_mins;
+	struct nlattr *attrs[BATADV_ATTR_MAX+1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct print_opts *opts = arg;
+	struct bat_host *bat_host;
+	struct genlmsghdr *ghdr;
+	struct in_addr in_addr;
+	uint8_t *hwaddr;
+	uint32_t u_addr;
+	int16_t vid;
+	char *addr;
+
+	if (!genlmsg_valid_hdr(nlh, 0)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	ghdr = nlmsg_data(nlh);
+
+	if (ghdr->cmd != BATADV_CMD_GET_DAT_CACHE)
+		return NL_OK;
+
+	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	if (missing_mandatory_attrs(attrs, dat_cache_mandatory,
+				    ARRAY_SIZE(dat_cache_mandatory))) {
+		fputs("Missing attributes from kernel\n", stderr);
+		exit(1);
+	}
+
+	u_addr = nla_get_u32(attrs[BATADV_ATTR_DC_ADDRESS]);
+	in_addr.s_addr = htonl(u_addr);
+	addr = inet_ntoa(in_addr);
+	hwaddr = nla_data(attrs[BATADV_ATTR_DC_HWADDRESS]);
+	vid = nla_get_u16(attrs[BATADV_ATTR_DC_VID]);
+
+	last_seen_msecs = nla_get_u32(attrs[BATADV_ATTR_LAST_SEEN_MSECS]);
+	last_seen_mins = last_seen_msecs / 60000;
+	last_seen_msecs = last_seen_msecs % 60000;
+	last_seen_secs = last_seen_msecs / 1000;
+
+	if (opts->read_opt & MULTICAST_ONLY && !(addr[0] & 0x01))
+		return NL_OK;
+
+	if (opts->read_opt & UNICAST_ONLY && (addr[0] & 0x01))
+		return NL_OK;
+
+	printf(" * %15s ", addr);
+
+	bat_host = bat_hosts_find_by_mac((char *)hwaddr);
+	if (!(opts->read_opt & USE_BAT_HOSTS) || !bat_host)
+		printf("%02x:%02x:%02x:%02x:%02x:%02x ",
+		       hwaddr[0], hwaddr[1], hwaddr[2],
+		       hwaddr[3], hwaddr[4], hwaddr[5]);
+	else
+		printf("%17s ", bat_host->name);
+
+	printf("%4i %6i:%02i\n",
+	       BATADV_PRINT_VID(vid), last_seen_mins, last_seen_secs);
+
+	return NL_OK;
+}
+
 static int netlink_print_common(char *mesh_iface, char *orig_iface,
 				int read_opt, float orig_timeout,
 				float watch_interval, const char *header,
@@ -1336,6 +1417,28 @@ int netlink_print_bla_backbone(char *mesh_iface, char *orig_iface, int read_opts
 				    bla_backbone_callback);
 }
 
+int netlink_print_dat_cache(char *mesh_iface, char *orig_iface, int read_opts,
+			    float orig_timeout, float watch_interval)
+{
+	char *header;
+	int ret;
+
+	ret = asprintf(&header, "Distributed ARP Table (%s):\n%s\n",
+		       mesh_iface,
+		       "          IPv4             MAC        VID   last-seen");
+
+	if (ret < 0)
+		return ret;
+
+	ret = netlink_print_common(mesh_iface, orig_iface, read_opts,
+				   orig_timeout, watch_interval, header,
+				   BATADV_CMD_GET_DAT_CACHE,
+				   dat_cache_callback);
+
+	free(header);
+	return ret;
+}
+
 static int nlquery_error_cb(struct sockaddr_nl *nla __maybe_unused,
 			    struct nlmsgerr *nlerr, void *arg)
 {
diff --git a/netlink.h b/netlink.h
index a75e5cf..57870c2 100644
--- a/netlink.h
+++ b/netlink.h
@@ -45,6 +45,8 @@ int netlink_print_bla_claim(char *mesh_iface, char *orig_iface, int read_opt,
 			    float orig_timeout, float watch_interval);
 int netlink_print_bla_backbone(char *mesh_iface, char *orig_iface, int read_opt,
 			       float orig_timeout, float watch_interval);
+int netlink_print_dat_cache(char *mesh_iface, char *orig_iface, int read_opt,
+			    float orig_timeout, float watch_interval);
 
 int translate_mac_netlink(const char *mesh_iface, const struct ether_addr *mac,
 			  struct ether_addr *mac_out);
-- 
2.11.0


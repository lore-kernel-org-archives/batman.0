Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  3 Jul 2016 13:35:08 +0200
Message-Id: <1467545714-20722-3-git-send-email-sven@narfation.org>
In-Reply-To: <1467545714-20722-1-git-send-email-sven@narfation.org>
References: <1467545714-20722-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v10 2/8] batctl: add netlink dump function
	for backbone tables
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

From: Simon Wunderlich <sw@simonwunderlich.de>

Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 batman_adv.h |  2 ++
 debug.c      |  1 +
 netlink.c    | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 netlink.h    |  2 ++
 4 files changed, 84 insertions(+)

diff --git a/batman_adv.h b/batman_adv.h
index 778e238..37157d0 100644
--- a/batman_adv.h
+++ b/batman_adv.h
@@ -157,6 +157,7 @@ enum batadv_nl_attrs {
  * @BATADV_CMD_GET_NEIGHBORS: Query list of neighbours
  * @BATADV_CMD_GET_GATEWAYS: Query list of gateways
  * @BATADV_CMD_GET_BLA_CLAIM: Query list of bridge loop avoidance claims
+ * @BATADV_CMD_GET_BLA_BACKBONE: Query list of bridge loop avoidance backbones
  * @__BATADV_CMD_AFTER_LAST: internal use
  * @BATADV_CMD_MAX: highest used command number
  */
@@ -173,6 +174,7 @@ enum batadv_nl_commands {
 	BATADV_CMD_GET_NEIGHBORS,
 	BATADV_CMD_GET_GATEWAYS,
 	BATADV_CMD_GET_BLA_CLAIM,
+	BATADV_CMD_GET_BLA_BACKBONE,
 	/* add new commands above here */
 	__BATADV_CMD_AFTER_LAST,
 	BATADV_CMD_MAX = __BATADV_CMD_AFTER_LAST - 1
diff --git a/debug.c b/debug.c
index 46f03da..ddabbfb 100644
--- a/debug.c
+++ b/debug.c
@@ -79,6 +79,7 @@ const struct debug_table_data batctl_debug_tables[BATCTL_TABLE_NUM] = {
 		.opt_short = "bbt",
 		.debugfs_name = "bla_backbone_table",
 		.header_lines = 2,
+		.netlink_fn = netlink_print_bla_backbone,
 	},
 	{
 		.opt_long = "dat_cache",
diff --git a/netlink.c b/netlink.c
index c07ed55..bb543ca 100644
--- a/netlink.c
+++ b/netlink.c
@@ -223,6 +223,7 @@ static int info_callback(struct nl_msg *msg, void *arg)
 			case BATADV_CMD_GET_TRANSTABLE_LOCAL:
 				asprintf(&extra_info, ", TTVN: %u", ttvn);
 				break;
+			case BATADV_CMD_GET_BLA_BACKBONE:
 			case BATADV_CMD_GET_BLA_CLAIM:
 				asprintf(&extra_info, ", group id: 0x%04x",
 					 bla_group_id);
@@ -942,6 +943,74 @@ static int bla_claim_callback(struct nl_msg *msg, void *arg)
 	return NL_OK;
 }
 
+static const int bla_backbone_mandatory[] = {
+	BATADV_ATTR_BLA_VID,
+	BATADV_ATTR_BLA_BACKBONE,
+	BATADV_ATTR_BLA_CRC,
+	BATADV_ATTR_LAST_SEEN_MSECS,
+};
+
+static int bla_backbone_callback(struct nl_msg *msg, void *arg)
+{
+	struct nlattr *attrs[BATADV_ATTR_MAX+1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	int last_seen_msecs, last_seen_secs;
+	struct print_opts *opts = arg;
+	struct bat_host *bat_host;
+	struct genlmsghdr *ghdr;
+	uint16_t backbone_crc;
+	uint8_t *backbone;
+	uint16_t vid;
+
+	if (!genlmsg_valid_hdr(nlh, 0)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	ghdr = nlmsg_data(nlh);
+
+	if (ghdr->cmd != BATADV_CMD_GET_BLA_BACKBONE)
+		return NL_OK;
+
+	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	if (missing_mandatory_attrs(attrs, bla_backbone_mandatory,
+				       ARRAY_SIZE(bla_backbone_mandatory))) {
+		fputs("Missing attributes from kernel\n", stderr);
+		exit(1);
+	}
+
+	/* don't show own backbones */
+	if (attrs[BATADV_ATTR_BLA_OWN])
+		return NL_OK;
+
+	vid = nla_get_u16(attrs[BATADV_ATTR_BLA_VID]);
+	backbone = nla_data(attrs[BATADV_ATTR_BLA_BACKBONE]);
+	backbone_crc = nla_get_u16(attrs[BATADV_ATTR_BLA_CRC]);
+
+	last_seen_msecs = nla_get_u32(attrs[BATADV_ATTR_LAST_SEEN_MSECS]);
+	last_seen_secs = last_seen_msecs / 1000;
+	last_seen_msecs = last_seen_msecs % 1000;
+
+	bat_host = bat_hosts_find_by_mac((char *)backbone);
+	if (!(opts->read_opt & USE_BAT_HOSTS) || !bat_host)
+		printf("%02x:%02x:%02x:%02x:%02x:%02x ",
+		       backbone[0], backbone[1], backbone[2],
+		       backbone[3], backbone[4], backbone[5]);
+	else
+		printf("%17s ", bat_host->name);
+
+	printf("on %5d %4i.%03is (0x%04x)\n",
+	       BATADV_PRINT_VID(vid), last_seen_secs, last_seen_msecs,
+	       backbone_crc);
+
+	return NL_OK;
+}
+
 static int netlink_print_common(char *mesh_iface, char *orig_iface,
 				int read_opt, float orig_timeout,
 				float watch_interval, const char *header,
@@ -1112,3 +1181,13 @@ int netlink_print_bla_claim(char *mesh_iface, char *orig_iface, int read_opts,
 				    BATADV_CMD_GET_BLA_CLAIM,
 				    bla_claim_callback);
 }
+
+int netlink_print_bla_backbone(char *mesh_iface, char *orig_iface, int read_opts,
+			       float orig_timeout, float watch_interval)
+{
+	return netlink_print_common(mesh_iface, orig_iface, read_opts,
+				    orig_timeout, watch_interval,
+				    "Originator           VID   last seen (CRC   )\n",
+				    BATADV_CMD_GET_BLA_BACKBONE,
+				    bla_backbone_callback);
+}
diff --git a/netlink.h b/netlink.h
index 69f0958..5ff7ace 100644
--- a/netlink.h
+++ b/netlink.h
@@ -40,6 +40,8 @@ int netlink_print_gateways(char *mesh_iface, char *orig_iface, int read_opt,
 			   float orig_timeout, float watch_interval);
 int netlink_print_bla_claim(char *mesh_iface, char *orig_iface, int read_opt,
 			    float orig_timeout, float watch_interval);
+int netlink_print_bla_backbone(char *mesh_iface, char *orig_iface, int read_opt,
+			       float orig_timeout, float watch_interval);
 
 extern struct nla_policy batadv_netlink_policy[];
 
-- 
2.8.1


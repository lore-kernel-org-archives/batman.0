Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  5 Jun 2016 20:47:06 +0200
Message-Id: <1465152428-17299-8-git-send-email-sven@narfation.org>
In-Reply-To: <1465152428-17299-1-git-send-email-sven@narfation.org>
References: <1465152428-17299-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 08/10] alfred: Query TQ of originators via
	netlink
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

The debugfs entries are only available on the main network namespace. All
other network namespaces have to fall back to netlink to read the
originator table.

alfred has therefore try to access the originator via netlink and try to
fall back to the debugfs table in case the batman-adv module doesn't
support BATADV_CMD_GET_ORIGINATORS.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 batadv_query.c |  8 +++++-
 netlink.c      | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 netlink.h      |  2 ++
 3 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/batadv_query.c b/batadv_query.c
index a893995..a671b79 100644
--- a/batadv_query.c
+++ b/batadv_query.c
@@ -366,13 +366,19 @@ uint8_t get_tq(const char *mesh_iface, struct ether_addr *mac)
 {
 	struct ether_addr in_mac;
 	uint8_t tq = 0;
+	int ret;
 
 	/* input mac has to be copied because it could be in the shared
 	 * ether_aton buffer
 	 */
 	memcpy(&in_mac, mac, sizeof(in_mac));
 
-	get_tq_debugfs(mesh_iface, &in_mac, &tq);
+	enable_net_admin_capability(1);
+	ret = get_tq_netlink(mesh_iface, &in_mac, &tq);
+	enable_net_admin_capability(0);
+
+	if (ret == -EOPNOTSUPP)
+		get_tq_debugfs(mesh_iface, &in_mac, &tq);
 
 	return tq;
 }
diff --git a/netlink.c b/netlink.c
index e1ebc07..1b5695c 100644
--- a/netlink.c
+++ b/netlink.c
@@ -280,3 +280,88 @@ int translate_mac_netlink(const char *mesh_iface, const struct ether_addr *mac,
 
 	return 0;
 }
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
+	struct nlattr *attrs[BATADV_ATTR_MAX+1];
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
+			           get_tq_netlink_cb, &opts.query_opts);
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
diff --git a/netlink.h b/netlink.h
index 8e54235..b08e872 100644
--- a/netlink.h
+++ b/netlink.h
@@ -47,6 +47,8 @@ int missing_mandatory_attrs(struct nlattr *attrs[],  const int mandatory[],
 			    size_t num);
 int translate_mac_netlink(const char *mesh_iface, const struct ether_addr *mac,
 			  struct ether_addr *mac_out);
+int get_tq_netlink(const char *mesh_iface, const struct ether_addr *mac,
+		   uint8_t *tq);
 
 extern struct nla_policy batadv_netlink_policy[];
 
-- 
2.8.1


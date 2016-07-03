Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  3 Jul 2016 13:35:09 +0200
Message-Id: <1467545714-20722-4-git-send-email-sven@narfation.org>
In-Reply-To: <1467545714-20722-1-git-send-email-sven@narfation.org>
References: <1467545714-20722-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v10 3/8] batctl: add netlink dump support for
	B.A.T.M.A.N. V gateways
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 netlink.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/netlink.c b/netlink.c
index bb543ca..9dff93a 100644
--- a/netlink.c
+++ b/netlink.c
@@ -789,7 +789,6 @@ static int translocal_callback(struct nl_msg *msg, void *arg)
 
 static const int gateways_mandatory[] = {
 	BATADV_ATTR_ORIG_ADDRESS,
-	BATADV_ATTR_TQ,
 	BATADV_ATTR_ROUTER,
 	BATADV_ATTR_HARD_IFNAME,
 	BATADV_ATTR_BANDWIDTH_DOWN,
@@ -806,6 +805,7 @@ static int gateways_callback(struct nl_msg *msg, void *arg)
 	const char *primary_if;
 	uint32_t bandwidth_down;
 	uint32_t bandwidth_up;
+	uint32_t throughput;
 	uint8_t *router;
 	uint8_t *orig;
 	char c = ' ';
@@ -837,7 +837,6 @@ static int gateways_callback(struct nl_msg *msg, void *arg)
 		c = '*';
 
 	orig = nla_data(attrs[BATADV_ATTR_ORIG_ADDRESS]);
-	tq = nla_get_u8(attrs[BATADV_ATTR_TQ]);
 	router = nla_data(attrs[BATADV_ATTR_ROUTER]);
 	primary_if = nla_get_string(attrs[BATADV_ATTR_HARD_IFNAME]);
 	bandwidth_down = nla_get_u32(attrs[BATADV_ATTR_BANDWIDTH_DOWN]);
@@ -853,7 +852,13 @@ static int gateways_callback(struct nl_msg *msg, void *arg)
 	else
 		printf("%17s ", bat_host->name);
 
-	printf("(%3i) ", tq);
+	if (attrs[BATADV_ATTR_THROUGHPUT]) {
+		throughput = nla_get_u32(attrs[BATADV_ATTR_THROUGHPUT]);
+		printf("(%9u.%1u) ", throughput / 10, throughput % 10);
+	} else if (attrs[BATADV_ATTR_TQ]) {
+		tq = nla_get_u8(attrs[BATADV_ATTR_TQ]);
+		printf("(%3i) ", tq);
+	}
 
 	bat_host = bat_hosts_find_by_mac((char *)router);
 	if (!(opts->read_opt & USE_BAT_HOSTS) || !bat_host)
@@ -1163,10 +1168,31 @@ int netlink_print_translocal(char *mesh_iface, char *orig_iface, int read_opts,
 int netlink_print_gateways(char *mesh_iface, char *orig_iface, int read_opts,
 			   float orig_timeout,
 			   float watch_interval)
-{
+{	char *header;
+	int ifindex;
+
+	ifindex = if_nametoindex(mesh_iface);
+	if (!ifindex) {
+		fprintf(stderr, "Interface %s is unknown\n", mesh_iface);
+		return -ENODEV;
+	}
+
+	netlink_print_info(ifindex, BATADV_CMD_GET_ORIGINATORS, PARSE_ONLY);
+
+	if (strlen(algo_name_buf) == 0)
+		return -EINVAL;
+
+	if (!strcmp("BATMAN_IV", algo_name_buf))
+		header = "  Router            ( TQ) Next Hop          [outgoingIf]  Bandwidth\n";
+	if (!strcmp("BATMAN_V", algo_name_buf))
+		header = "  Router            ( throughput) Next Hop          [outgoingIf]  Bandwidth\n";
+
+	if (!header)
+		return -EINVAL;
+
 	return netlink_print_common(mesh_iface, orig_iface, read_opts,
 				    orig_timeout, watch_interval,
-				    "    Router           TQ      Next Hop        outgoingIf   Bandwidth\n",
+				    header,
 				    BATADV_CMD_GET_GATEWAYS,
 				    gateways_callback);
 }
-- 
2.8.1


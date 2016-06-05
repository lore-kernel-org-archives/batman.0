Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  5 Jun 2016 20:47:08 +0200
Message-Id: <1465152428-17299-10-git-send-email-sven@narfation.org>
In-Reply-To: <1465152428-17299-1-git-send-email-sven@narfation.org>
References: <1465152428-17299-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 10/10] alfred: vis: Add support for netlink
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

The debugfs entries are only available on the main network namespace.
All other network namespaces have to fallback to netlink to read the local
translation table and the originator table.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 vis/vis.c | 219 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 217 insertions(+), 2 deletions(-)

diff --git a/vis/vis.c b/vis/vis.c
index bac451b..d6bac41 100644
--- a/vis/vis.c
+++ b/vis/vis.c
@@ -35,10 +35,18 @@
 #include <sys/socket.h>
 #include <sys/un.h>
 #include <unistd.h>
+
+#include "batman_adv.h"
+#include "netlink.h"
 #include "debugfs.h"
 
 static struct globals vis_globals;
 
+struct vis_netlink_opts {
+	struct globals *globals;
+	struct nlquery_opts query_opts;
+};
+
 static char *read_file(char *fname)
 {
 	FILE *fp;
@@ -163,6 +171,45 @@ static int get_if_index_byname(struct globals *globals, char *ifname)
 	return i;
 }
 
+static int get_if_index_devindex(struct globals *globals, int devindex)
+{
+	struct iface_list_entry *i_entry;
+	char *ifname;
+	char ifnamebuf[IF_NAMESIZE];
+	int i;
+
+	if (!devindex)
+		return -1;
+
+	i = 0;
+	list_for_each_entry(i_entry, &globals->iface_list, list) {
+		if (i_entry->devindex == devindex)
+			return i;
+		i++;
+	}
+
+	ifname = if_indextoname(devindex, ifnamebuf);
+	if (!ifname)
+		return -1;
+
+	i_entry = malloc(sizeof(*i_entry));
+	if (!i_entry)
+		return -1;
+
+	if (get_if_mac(ifname, i_entry->mac)) {
+		free(i_entry);
+		return -1;
+	}
+
+	i_entry->devindex = devindex;
+	strncpy(i_entry->name, ifname, sizeof(i_entry->name));
+	/* just to be safe ... */
+	i_entry->name[sizeof(i_entry->name) - 1] = 0;
+	list_add_tail(&i_entry->list, &globals->iface_list);
+
+	return i;
+}
+
 static int alfred_open_sock(struct globals *globals)
 {
 	struct sockaddr_un addr;
@@ -189,7 +236,75 @@ static int alfred_open_sock(struct globals *globals)
 	return 0;
 }
 
-static int parse_transtable_local(struct globals *globals)
+static const int parse_transtable_local_mandatory[] = {
+	BATADV_ATTR_TT_ADDRESS,
+};
+
+static int parse_transtable_local_netlink_cb(struct nl_msg *msg, void *arg)
+{
+	struct nlattr *attrs[BATADV_ATTR_MAX+1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct nlquery_opts *query_opts = arg;
+	struct vis_netlink_opts *opts;
+	struct genlmsghdr *ghdr;
+	struct vis_list_entry *v_entry;
+	uint8_t *addr;
+
+	opts = container_of(query_opts, struct vis_netlink_opts,
+			    query_opts);
+
+	if (!genlmsg_valid_hdr(nlh, 0))
+		return NL_OK;
+
+	ghdr = nlmsg_data(nlh);
+
+	if (ghdr->cmd != BATADV_CMD_GET_TRANSTABLE_LOCAL)
+		return NL_OK;
+
+	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
+		return NL_OK;
+	}
+
+	if (missing_mandatory_attrs(attrs, parse_transtable_local_mandatory,
+				    ARRAY_SIZE(parse_transtable_local_mandatory)))
+		return NL_OK;
+
+	addr = nla_data(attrs[BATADV_ATTR_TT_ADDRESS]);
+
+	v_entry = malloc(sizeof(*v_entry));
+	if (!v_entry)
+		return NL_OK;
+
+	memcpy(v_entry->v.mac, addr, ETH_ALEN);
+	v_entry->v.ifindex = 255;
+	v_entry->v.qual = 0;
+	list_add_tail(&v_entry->list, &opts->globals->entry_list);
+
+	return NL_OK;
+}
+
+static int parse_transtable_local_netlink(struct globals *globals)
+{
+	struct vis_netlink_opts opts = {
+		.globals = globals,
+		.query_opts = {
+			.err = 0,
+		},
+	};
+	int ret;
+
+	ret = netlink_query_common(globals->interface,
+				   BATADV_CMD_GET_TRANSTABLE_LOCAL,
+			           parse_transtable_local_netlink_cb,
+				   &opts.query_opts);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int parse_transtable_local_debugfs(struct globals *globals)
 {
 	char *fbuf;
 	char *lptr, *tptr;
@@ -241,6 +356,17 @@ static int parse_transtable_local(struct globals *globals)
 	return 0;
 }
 
+static int parse_transtable_local(struct globals *globals)
+{
+	int ret;
+
+	ret = parse_transtable_local_netlink(globals);
+	if (ret != EOPNOTSUPP)
+		return ret;
+
+	return parse_transtable_local_debugfs(globals);
+}
+
 static void clear_lists(struct globals *globals)
 {
 	struct vis_list_entry *v_entry, *v_entry_safe;
@@ -325,8 +451,86 @@ err:
 	return EXIT_FAILURE;
 }
 
+static const int parse_orig_list_mandatory[] = {
+	BATADV_ATTR_ORIG_ADDRESS,
+	BATADV_ATTR_TQ,
+	BATADV_ATTR_HARD_IFINDEX,
+};
 
-static int parse_orig_list(struct globals *globals)
+static int parse_orig_list_netlink_cb(struct nl_msg *msg, void *arg)
+{
+	struct nlattr *attrs[BATADV_ATTR_MAX+1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct nlquery_opts *query_opts = arg;
+	struct vis_netlink_opts *opts;
+	struct genlmsghdr *ghdr;
+	struct vis_list_entry *v_entry;
+	uint8_t *orig;
+	uint8_t tq;
+	uint32_t hardif;
+
+	opts = container_of(query_opts, struct vis_netlink_opts,
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
+	if (missing_mandatory_attrs(attrs, parse_orig_list_mandatory,
+				    ARRAY_SIZE(parse_orig_list_mandatory)))
+		return NL_OK;
+
+	if (!attrs[BATADV_ATTR_FLAG_BEST])
+		return NL_OK;
+
+	orig = nla_data(attrs[BATADV_ATTR_ORIG_ADDRESS]);
+	tq = nla_get_u8(attrs[BATADV_ATTR_TQ]);
+	hardif = nla_get_u32(attrs[BATADV_ATTR_HARD_IFINDEX]);
+
+	if (tq < 1)
+		return NL_OK;
+
+	v_entry = malloc(sizeof(*v_entry));
+	if (!v_entry)
+		return NL_OK;
+
+	memcpy(v_entry->v.mac, orig, ETH_ALEN);
+	v_entry->v.ifindex = get_if_index_devindex(opts->globals, hardif);
+	v_entry->v.qual = tq;
+	list_add_tail(&v_entry->list, &opts->globals->entry_list);
+
+	return NL_OK;
+}
+
+static int parse_orig_list_netlink(struct globals *globals)
+{
+	struct vis_netlink_opts opts = {
+		.globals = globals,
+		.query_opts = {
+			.err = 0,
+		},
+	};
+	int ret;
+
+	ret = netlink_query_common(globals->interface,
+				   BATADV_CMD_GET_ORIGINATORS,
+			           parse_orig_list_netlink_cb, &opts.query_opts);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int parse_orig_list_debugfs(struct globals *globals)
 {
 	char *fbuf;
 	char *lptr, *tptr;
@@ -393,6 +597,17 @@ static int parse_orig_list(struct globals *globals)
 	return 0;
 }
 
+static int parse_orig_list(struct globals *globals)
+{
+	int ret;
+
+	ret = parse_orig_list_netlink(globals);
+	if (ret != EOPNOTSUPP)
+		return ret;
+
+	return parse_orig_list_debugfs(globals);
+}
+
 static int vis_publish_data(struct globals *globals)
 {
 	int len, ret;
-- 
2.8.1


Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  9 Feb 2019 14:42:11 +0100
Message-Id: <20190209134222.15035-10-sven@narfation.org>
In-Reply-To: <20190209134222.15035-1-sven@narfation.org>
References: <20190209134222.15035-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH v5 09/20] batctl: Support generic netlink for
 isolation_mark command
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
Cc: Sven Eckelmann <sven@narfation.org>, Antonio Quartulli <a@unstable.cc>

sysfs should be avoided for new settings of network interfaces. To still
provide a common configuration infrastructure, all the existing settings
subcommands also have to be reimplemented via generic netlink while still
using sysfs as fallback.

The isolation_mark implementation is using the commands
BATADV_CMD_SET_MESH/BATADV_CMD_GET_MESH to set/get the configuration of
the mark/mask using the u32 attributes BATADV_ATTR_ISOLATION_MARK
and BATADV_ATTR_ISOLATION_MASK.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Cc: Antonio Quartulli <a@unstable.cc>
---
 isolation_mark.c | 123 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 121 insertions(+), 2 deletions(-)

diff --git a/isolation_mark.c b/isolation_mark.c
index c9d296e..aeb2da3 100644
--- a/isolation_mark.c
+++ b/isolation_mark.c
@@ -20,16 +20,135 @@
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
+#include <errno.h>
 #include <stddef.h>
+#include <stdint.h>
+#include <string.h>
 
 #include "main.h"
 #include "sys.h"
 
+static struct isolation_mark_data {
+	uint32_t isolation_mark;
+	uint32_t isolation_mask;
+} isolation_mark;
+
+static int parse_isolation_mark(struct state *state, int argc, char *argv[])
+{
+	struct settings_data *settings = state->cmd->arg;
+	struct isolation_mark_data *data = settings->data;
+	char *mask_ptr;
+	char buff[256];
+	uint32_t mark;
+	uint32_t mask;
+	char *endptr;
+
+	if (argc != 2) {
+		fprintf(stderr, "Error - incorrect number of arguments (expected 1)\n");
+		return -EINVAL;
+	}
+
+	strncpy(buff, argv[1], sizeof(buff));
+	buff[sizeof(buff) - 1] = '\0';
+
+	/* parse the mask if it has been specified, otherwise assume the mask is
+	 * the biggest possible
+	 */
+	mask = 0xFFFFFFFF;
+	mask_ptr = strchr(buff, '/');
+	if (mask_ptr) {
+		*mask_ptr = '\0';
+		mask_ptr++;
+
+		/* the mask must be entered in hex base as it is going to be a
+		 * bitmask and not a prefix length
+		 */
+		mask = strtoul(mask_ptr, &endptr, 16);
+		if (!endptr || *endptr != '\0')
+			goto inval_format;
+	}
+
+	/* the mark can be entered in any base */
+	mark = strtoul(buff, &endptr, 0);
+	if (!endptr || *endptr != '\0')
+		goto inval_format;
+
+	data->isolation_mask = mask;
+	/* erase bits not covered by the mask */
+	data->isolation_mark = mark & mask;
+
+	return 0;
+
+inval_format:
+	fprintf(stderr, "Error - incorrect number of arguments (expected 1)\n");
+	fprintf(stderr, "The following formats for mark(/mask) are allowed:\n");
+	fprintf(stderr, " * 0x12345678\n");
+	fprintf(stderr, " * 0x12345678/0xabcdef09\n");
+	return -EINVAL;
+}
+
+static int print_isolation_mark(struct nl_msg *msg, void *arg)
+{
+	struct nlattr *attrs[BATADV_ATTR_MAX + 1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct genlmsghdr *ghdr;
+	int *result = arg;
+
+	if (!genlmsg_valid_hdr(nlh, 0))
+		return NL_OK;
+
+	ghdr = nlmsg_data(nlh);
+
+	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
+		return NL_OK;
+	}
+
+	if (!attrs[BATADV_ATTR_ISOLATION_MARK] ||
+	    !attrs[BATADV_ATTR_ISOLATION_MASK])
+		return NL_OK;
+
+	printf("0x%08x/0x%08x\n",
+	       nla_get_u32(attrs[BATADV_ATTR_ISOLATION_MARK]),
+	       nla_get_u32(attrs[BATADV_ATTR_ISOLATION_MASK]));
+
+	*result = 0;
+	return NL_STOP;
+}
+
+static int get_isolation_mark(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_GET_MESH,
+				  NULL, print_isolation_mark);
+}
+
+static int set_attrs_isolation_mark(struct nl_msg *msg, void *arg)
+{
+	struct state *state = arg;
+	struct settings_data *settings = state->cmd->arg;
+	struct isolation_mark_data *data = settings->data;
+
+	nla_put_u32(msg, BATADV_ATTR_ISOLATION_MARK, data->isolation_mark);
+	nla_put_u32(msg, BATADV_ATTR_ISOLATION_MASK, data->isolation_mask);
+
+	return 0;
+}
+
+static int set_isolation_mark(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_SET_MESH,
+				  set_attrs_isolation_mark, NULL);
+}
+
 static struct settings_data batctl_settings_isolation_mark = {
 	.sysfs_name = "isolation_mark",
-	.params = NULL,
+	.data = &isolation_mark,
+	.parse = parse_isolation_mark,
+	.netlink_get = get_isolation_mark,
+	.netlink_set = set_isolation_mark,
 };
 
 COMMAND_NAMED(SUBCOMMAND, isolation_mark, "mark", handle_sys_setting,
-	      COMMAND_FLAG_MESH_IFACE, &batctl_settings_isolation_mark,
+	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
+	      &batctl_settings_isolation_mark,
 	      "[mark]            \tdisplay or modify isolation_mark setting");
-- 
2.20.1


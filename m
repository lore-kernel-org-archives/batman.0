Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  9 Feb 2019 14:42:09 +0100
Message-Id: <20190209134222.15035-8-sven@narfation.org>
In-Reply-To: <20190209134222.15035-1-sven@narfation.org>
References: <20190209134222.15035-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH v5 07/20] batctl: Support generic netlink for
 gw_mode command
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
Cc: Sven Eckelmann <sven@narfation.org>, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <a@unstable.cc>

sysfs should be avoided for new settings of network interfaces. To still
provide a common configuration infrastructure, all the existing settings
subcommands also have to be reimplemented via generic netlink while still
using sysfs as fallback.

The gw_mode implementation is using the commands
BATADV_CMD_SET_MESH/BATADV_CMD_GET_MESH to set/get the configuration of
this feature using the attributes:

* u8 BATADV_ATTR_GW_MODE (0 == off, 1 == client, 2 == server)
* u32 BATADV_ATTR_GW_BANDWIDTH_DOWN (in 100 kbit/s steps)
* u32 BATADV_ATTR_GW_BANDWIDTH_UP (in 100 kbit/s steps)
* u32 BATADV_ATTR_GW_SEL_CLASS
  - 1-255 for BATMAN_IV
  - 1-UINT32_MAX for BATMAN_V

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Cc: Marek Lindner <mareklindner@neomailbox.ch>
Cc: Antonio Quartulli <a@unstable.cc>
---
 gw_mode.c | 275 ++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 206 insertions(+), 69 deletions(-)

diff --git a/gw_mode.c b/gw_mode.c
index d671fab..e67a1d1 100644
--- a/gw_mode.c
+++ b/gw_mode.c
@@ -162,80 +162,233 @@ static int parse_gw(struct state *state, int argc, char *argv[])
 	return 0;
 }
 
-static int gw_mode(struct state *state, int argc, char **argv)
+static int print_gw(struct nl_msg *msg, void *arg)
 {
-	int optchar, res = EXIT_FAILURE;
-	char *path_buff, gw_mode;
+	static const int mandatory[] = {
+		BATADV_ATTR_GW_MODE,
+	};
+	static const int mandatory_client[] = {
+		BATADV_ATTR_ALGO_NAME,
+		BATADV_ATTR_GW_SEL_CLASS,
+	};
+	static const int mandatory_server[] = {
+		BATADV_ATTR_GW_BANDWIDTH_DOWN,
+		BATADV_ATTR_GW_BANDWIDTH_UP,
+	};
+	struct nlattr *attrs[BATADV_ATTR_MAX + 1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct genlmsghdr *ghdr;
+	int *result = arg;
+	const char *algo;
+	uint8_t gw_mode;
+	uint32_t val;
+	uint32_t down;
+	uint32_t up;
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
 
-	while ((optchar = getopt(argc, argv, "h")) != -1) {
-		switch (optchar) {
-		case 'h':
-			gw_mode_usage();
-			return EXIT_SUCCESS;
-		default:
-			gw_mode_usage();
-			return EXIT_FAILURE;
-		}
+	/* ignore entry when attributes are missing */
+	if (missing_mandatory_attrs(attrs, mandatory, ARRAY_SIZE(mandatory)))
+		return NL_OK;
+
+	gw_mode = nla_get_u8(attrs[BATADV_ATTR_GW_MODE]);
+	switch (gw_mode) {
+	case BATADV_GW_MODE_OFF:
+		printf("off\n");
+		break;
+	case BATADV_GW_MODE_CLIENT:
+		if (missing_mandatory_attrs(attrs, mandatory_client,
+		    ARRAY_SIZE(mandatory_client)))
+			return NL_OK;
+
+		algo = nla_data(attrs[BATADV_ATTR_ALGO_NAME]);
+		val = nla_get_u32(attrs[BATADV_ATTR_GW_SEL_CLASS]);
+
+		if (strcmp(algo, "BATMAN_V") == 0)
+			printf("client (selection class: %u.%01u MBit)\n",
+			       val / 10, val % 10);
+		else
+			printf("client (selection class: %u)\n", val);
+		break;
+	case BATADV_GW_MODE_SERVER:
+		if (missing_mandatory_attrs(attrs, mandatory_server,
+		    ARRAY_SIZE(mandatory_server)))
+			return NL_OK;
+
+		down = nla_get_u32(attrs[BATADV_ATTR_GW_BANDWIDTH_DOWN]);
+		up = nla_get_u32(attrs[BATADV_ATTR_GW_BANDWIDTH_UP]);
+
+		printf("server (announced bw: %u.%01u/%u.%01u MBit)\n",
+		       down / 10, down % 10, up / 10, up % 10);
+		break;
+	default:
+		printf("unknown\n");
+		break;
 	}
 
-	path_buff = malloc(PATH_BUFF_LEN);
-	if (!path_buff) {
-		fprintf(stderr, "Error - could not allocate path buffer: out of memory ?\n");
+	*result = 0;
+	return NL_STOP;
+}
+
+static int get_gw(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_GET_MESH, NULL, print_gw);
+}
+
+static int set_attrs_gw(struct nl_msg *msg, void *arg __maybe_unused)
+{
+	nla_put_u8(msg, BATADV_ATTR_GW_MODE, gw_globals.mode);
+
+	if (gw_globals.bandwidth_down_found)
+		nla_put_u32(msg, BATADV_ATTR_GW_BANDWIDTH_DOWN,
+			    gw_globals.bandwidth_down);
+
+	if (gw_globals.bandwidth_up_found)
+		nla_put_u32(msg, BATADV_ATTR_GW_BANDWIDTH_UP,
+			    gw_globals.bandwidth_up);
+
+	if (gw_globals.sel_class_found)
+		nla_put_u32(msg, BATADV_ATTR_GW_SEL_CLASS,
+			    gw_globals.sel_class);
+
+	return 0;
+}
+
+static int set_gw(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_SET_MESH, set_attrs_gw,
+				  NULL);
+}
+
+static int gw_read_setting(struct state *state, const char *path_buff)
+{
+	enum batadv_gw_modes gw_mode;
+	int res;
+
+	res = get_gw(state);
+	if (res < 0 && res != -EOPNOTSUPP)
 		return EXIT_FAILURE;
+	if (res >= 0)
+		return EXIT_SUCCESS;
+
+	/* fallback to sysfs */
+	res = read_file(path_buff, SYS_GW_MODE, USE_READ_BUFF, 0, 0, 0);
+	if (res != EXIT_SUCCESS)
+		goto out;
+
+	if (line_ptr[strlen(line_ptr) - 1] == '\n')
+		line_ptr[strlen(line_ptr) - 1] = '\0';
+
+	if (strcmp(line_ptr, "client") == 0)
+		gw_mode = BATADV_GW_MODE_CLIENT;
+	else if (strcmp(line_ptr, "server") == 0)
+		gw_mode = BATADV_GW_MODE_SERVER;
+	else
+		gw_mode = BATADV_GW_MODE_OFF;
+
+	free(line_ptr);
+	line_ptr = NULL;
+
+	switch (gw_mode) {
+	case BATADV_GW_MODE_CLIENT:
+		res = read_file(path_buff, SYS_GW_SEL, USE_READ_BUFF, 0, 0, 0);
+		break;
+	case BATADV_GW_MODE_SERVER:
+		res = read_file(path_buff, SYS_GW_BW, USE_READ_BUFF, 0, 0, 0);
+		break;
+	default:
+		printf("off\n");
+		goto out;
 	}
 
-	snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT, state->mesh_iface);
+	if (res != EXIT_SUCCESS)
+		goto out;
 
-	if (argc == 1) {
-		res = read_file(path_buff, SYS_GW_MODE, USE_READ_BUFF, 0, 0, 0);
+	if (line_ptr[strlen(line_ptr) - 1] == '\n')
+		line_ptr[strlen(line_ptr) - 1] = '\0';
 
-		if (res != EXIT_SUCCESS)
-			goto out;
+	switch (gw_mode) {
+	case BATADV_GW_MODE_CLIENT:
+		printf("client (selection class: %s)\n", line_ptr);
+		break;
+	case BATADV_GW_MODE_SERVER:
+		printf("server (announced bw: %s)\n", line_ptr);
+		break;
+	default:
+		goto out;
+	}
 
-		if (line_ptr[strlen(line_ptr) - 1] == '\n')
-			line_ptr[strlen(line_ptr) - 1] = '\0';
+out:
+	free(line_ptr);
+	line_ptr = NULL;
 
-		if (strcmp(line_ptr, "client") == 0)
-			gw_mode = BATADV_GW_MODE_CLIENT;
-		else if (strcmp(line_ptr, "server") == 0)
-			gw_mode = BATADV_GW_MODE_SERVER;
-		else
-			gw_mode = BATADV_GW_MODE_OFF;
+	return res;
+}
+
+static int gw_write_setting(struct state *state, const char *path_buff,
+			    int argc, char *argv[])
+{
+	int res = EXIT_FAILURE;
+
+	res = set_gw(state);
+	if (res < 0 && res != -EOPNOTSUPP)
+		return EXIT_FAILURE;
+	if (res >= 0)
+		return EXIT_SUCCESS;
 
-		free(line_ptr);
-		line_ptr = NULL;
+	/* sysfs fallback */
+	res = write_file(path_buff, SYS_GW_MODE, argv[1], NULL);
+	if (res != EXIT_SUCCESS)
+		return res;
 
-		switch (gw_mode) {
+	if (argc > 2) {
+		switch (gw_globals.mode) {
 		case BATADV_GW_MODE_CLIENT:
-			res = read_file(path_buff, SYS_GW_SEL, USE_READ_BUFF, 0, 0, 0);
+			res = write_file(path_buff, SYS_GW_SEL, argv[2], NULL);
 			break;
 		case BATADV_GW_MODE_SERVER:
-			res = read_file(path_buff, SYS_GW_BW, USE_READ_BUFF, 0, 0, 0);
+			res = write_file(path_buff, SYS_GW_BW, argv[2], NULL);
 			break;
-		default:
-			printf("off\n");
-			goto out;
 		}
+	}
 
-		if (res != EXIT_SUCCESS)
-			goto out;
+	return res;
+}
 
-		if (line_ptr[strlen(line_ptr) - 1] == '\n')
-			line_ptr[strlen(line_ptr) - 1] = '\0';
+static int gw_mode(struct state *state, int argc, char **argv)
+{
+	int optchar, res = EXIT_FAILURE;
+	char *path_buff;
 
-		switch (gw_mode) {
-		case BATADV_GW_MODE_CLIENT:
-			printf("client (selection class: %s)\n", line_ptr);
-			break;
-		case BATADV_GW_MODE_SERVER:
-			printf("server (announced bw: %s)\n", line_ptr);
-			break;
+	while ((optchar = getopt(argc, argv, "h")) != -1) {
+		switch (optchar) {
+		case 'h':
+			gw_mode_usage();
+			return EXIT_SUCCESS;
 		default:
-			goto out;
+			gw_mode_usage();
+			return EXIT_FAILURE;
 		}
+	}
 
-		free(line_ptr);
-		line_ptr = NULL;
+	path_buff = malloc(PATH_BUFF_LEN);
+	if (!path_buff) {
+		fprintf(stderr, "Error - could not allocate path buffer: out of memory ?\n");
+		return EXIT_FAILURE;
+	}
+
+	snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT, state->mesh_iface);
+
+	if (argc == 1) {
+		res = gw_read_setting(state, path_buff);
 		goto out;
 	}
 
@@ -247,28 +400,12 @@ static int gw_mode(struct state *state, int argc, char **argv)
 		goto out;
 	}
 
-	res = write_file(path_buff, SYS_GW_MODE, argv[1], NULL);
-	if (res != EXIT_SUCCESS)
-		goto out;
-
-	if (argc == 2)
-		goto out;
-
-	switch (gw_globals.mode) {
-	case BATADV_GW_MODE_CLIENT:
-		res = write_file(path_buff, SYS_GW_SEL, argv[2], NULL);
-		break;
-	case BATADV_GW_MODE_SERVER:
-		res = write_file(path_buff, SYS_GW_BW, argv[2], NULL);
-		break;
-	}
-
-	goto out;
-
+	res = gw_write_setting(state, path_buff, argc, argv);
 out:
 	free(path_buff);
 	return res;
 }
 
-COMMAND(SUBCOMMAND, gw_mode, "gw", COMMAND_FLAG_MESH_IFACE, NULL,
+COMMAND(SUBCOMMAND, gw_mode, "gw",
+	COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK, NULL,
 	"[mode]            \tdisplay or modify the gateway mode");
-- 
2.20.1


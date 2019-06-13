Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 1/4] batctl: Make vlan setting explicit
Date: Thu, 13 Jun 2019 21:12:14 +0200
Message-Id: <20190613191217.28139-2-sven@narfation.org>
In-Reply-To: <20190613191217.28139-1-sven@narfation.org>
References: <20190613191217.28139-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The requirement to have a VLAN master device on top of the batadv mesh
interface is artificially limiting the capabilities of batctl. Not all
master devices in linux which register a VLAN are from type "vlan" and are
only registering a single VLAN.

For example VLAN aware bridges can create multiple VLANs. These require
that the VLAN is identified using the VID and not the vlan device.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 ap_isolation.c |   5 ++
 main.c         | 133 ++++++++++++++++++++++++++++++++++++++++---------
 main.h         |   7 +--
 man/batctl.8   |   2 +-
 sys.c          |  32 ++++++++++--
 5 files changed, 148 insertions(+), 31 deletions(-)

diff --git a/ap_isolation.c b/ap_isolation.c
index 71dcd00..7c34649 100644
--- a/ap_isolation.c
+++ b/ap_isolation.c
@@ -81,3 +81,8 @@ COMMAND_NAMED(SUBCOMMAND, ap_isolation, "ap", handle_sys_setting,
 	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
 	      &batctl_settings_ap_isolation,
 	      "[0|1]             \tdisplay or modify ap_isolation setting");
+
+COMMAND_NAMED(SUBCOMMAND_VID, ap_isolation, "ap", handle_sys_setting,
+	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
+	      &batctl_settings_ap_isolation,
+	      "[0|1]             \tdisplay or modify ap_isolation setting for vlan device or id");
diff --git a/main.c b/main.c
index 278683c..6ca13ac 100644
--- a/main.c
+++ b/main.c
@@ -28,48 +28,75 @@ extern const struct command *__stop___command[];
 
 static void print_usage(void)
 {
-	enum command_type type[] = {
-		SUBCOMMAND,
-		DEBUGTABLE,
+	struct {
+		const char *label;
+		uint32_t types;
+	} type[] = {
+		{
+			.label = "commands:\n",
+			.types = BIT(SUBCOMMAND) |
+				 BIT(SUBCOMMAND_VID),
+		},
+		{
+			.label = "debug tables:                                   \tdisplay the corresponding debug table\n",
+			.types = BIT(DEBUGTABLE),
+		},
+	};
+	const char *default_prefixes[] = {
+		"",
+		NULL,
+	};
+	const char *vlan_prefixes[] = {
+		"vlan <vdev> ",
+		"vid <vid> ",
+		NULL,
 	};
 	const struct command **p;
-	char buf[32];
+	const char **prefixes;
+	const char **prefix;
+	char buf[64];
 	size_t i;
 
 	fprintf(stderr, "Usage: batctl [options] command|debug table [parameters]\n");
 	fprintf(stderr, "options:\n");
-	fprintf(stderr, " \t-m mesh interface or VLAN created on top of a mesh interface (default 'bat0')\n");
+	fprintf(stderr, " \t-m mesh interface (default 'bat0')\n");
 	fprintf(stderr, " \t-h print this help (or 'batctl <command|debug table> -h' for the parameter help)\n");
 	fprintf(stderr, " \t-v print version\n");
 
 	for (i = 0; i < sizeof(type) / sizeof(*type); i++) {
 		fprintf(stderr, "\n");
 
-		switch (type[i]) {
-		case SUBCOMMAND:
-			fprintf(stderr, "commands:\n");
-			break;
-		case DEBUGTABLE:
-			fprintf(stderr, "debug tables:                                   \tdisplay the corresponding debug table\n");
-			break;
-		}
+		fprintf(stderr, "%s", type[i].label);
 
 		for (p = __start___command; p < __stop___command; p++) {
 			const struct command *cmd = *p;
 
-			if (cmd->type != type[i])
+			if (!(BIT(cmd->type) & type[i].types))
 				continue;
 
 			if (!cmd->usage)
 				continue;
 
-			if (strcmp(cmd->name, cmd->abbr) == 0)
-				snprintf(buf, sizeof(buf), "%s", cmd->name);
-			else
-				snprintf(buf, sizeof(buf), "%s|%s", cmd->name,
-					 cmd->abbr);
+			switch (cmd->type) {
+			case SUBCOMMAND_VID:
+				prefixes = vlan_prefixes;
+				break;
+			default:
+				prefixes = default_prefixes;
+				break;
+			}
+
+			for (prefix = &prefixes[0]; *prefix; prefix++) {
+				if (strcmp(cmd->name, cmd->abbr) == 0)
+					snprintf(buf, sizeof(buf), "%s%s",
+						 *prefix, cmd->name);
+				else
+					snprintf(buf, sizeof(buf), "%s%s|%s",
+						 *prefix, cmd->name, cmd->abbr);
 
-			fprintf(stderr, " \t%-27s%s\n", buf, cmd->usage);
+				fprintf(stderr, " \t%-35s%s\n", buf,
+					cmd->usage);
+			}
 		}
 	}
 }
@@ -93,13 +120,19 @@ static void version(void)
 	exit(EXIT_SUCCESS);
 }
 
-static const struct command *find_command(const char *name)
+static const struct command *find_command(struct state *state, const char *name)
 {
 	const struct command **p;
 
 	for (p = __start___command; p < __stop___command; p++) {
 		const struct command *cmd = *p;
 
+		if (state->vid >= 0 && cmd->type != SUBCOMMAND_VID)
+			continue;
+
+		if (state->vid < 0 && cmd->type == SUBCOMMAND_VID)
+			continue;
+
 		if (strcmp(cmd->name, name) == 0)
 			return cmd;
 
@@ -110,6 +143,51 @@ static const struct command *find_command(const char *name)
 	return NULL;
 }
 
+static int parse_dev_args(struct state *state, int argc, char *argv[])
+{
+	unsigned long vid;
+	char *endptr;
+
+	/* not enough arguments to parse */
+	if (argc < 2) {
+		translate_mesh_iface(state);
+		return 0;
+	}
+
+	if (strcmp(argv[0], "vid") == 0) {
+		if (argv[1] == '\0') {
+			fprintf(stderr, "Error - unparsable vid\n");
+			return -EINVAL;
+		}
+
+		vid = strtoul(argv[1], &endptr, 0);
+		if (!endptr || *endptr != '\0') {
+			fprintf(stderr, "Error - unparsable vid\n");
+			return -EINVAL;
+		}
+
+		if (vid > 4095) {
+			fprintf(stderr, "Error - too large vid (max 4095)\n");
+			return -ERANGE;
+		}
+
+		/* get mesh interface and overwrite vid afterwards */
+		translate_mesh_iface(state);
+		state->vid = vid;
+
+		return 2;
+	} else if (strcmp(argv[0], "vlan") == 0) {
+		state->arg_iface = argv[1];
+		translate_mesh_iface(state);
+
+		return 2;
+	} else {
+		/* parse vlan as part of -m parameter */
+		translate_mesh_iface(state);
+		return 0;
+	}
+}
+
 int main(int argc, char **argv)
 {
 	const struct command *cmd;
@@ -117,6 +195,7 @@ int main(int argc, char **argv)
 		.arg_iface = mesh_dfl_iface,
 		.cmd = NULL,
 	};
+	int dev_arguments;
 	int opt;
 	int ret;
 
@@ -152,7 +231,15 @@ int main(int argc, char **argv)
 	argc -= optind;
 	optind = 0;
 
-	cmd = find_command(argv[0]);
+	/* parse arguments to identify vlan, ... */
+	dev_arguments = parse_dev_args(&state, argc, argv);
+	if (dev_arguments < 0)
+		goto err;
+
+	argv += dev_arguments;
+	argc -= dev_arguments;
+
+	cmd = find_command(&state, argv[0]);
 	if (!cmd) {
 		fprintf(stderr,
 			"Error - no valid command or debug table specified: %s\n",
@@ -162,8 +249,6 @@ int main(int argc, char **argv)
 
 	state.cmd = cmd;
 
-	translate_mesh_iface(&state);
-
 	if (cmd->flags & COMMAND_FLAG_MESH_IFACE &&
 	    check_mesh_iface(&state) < 0) {
 		fprintf(stderr,
diff --git a/main.h b/main.h
index 1a47015..1d95261 100644
--- a/main.h
+++ b/main.h
@@ -58,6 +58,7 @@ enum command_flags {
 
 enum command_type {
 	SUBCOMMAND,
+	SUBCOMMAND_VID,
 	DEBUGTABLE,
 };
 
@@ -84,7 +85,7 @@ struct command {
 };
 
 #define COMMAND_NAMED(_type, _name, _abbr, _handler, _flags, _arg, _usage) \
-	static const struct command command_ ## _name = { \
+	static const struct command command_ ## _name ## _ ## _type = { \
 		.type = (_type), \
 		.name = (#_name), \
 		.abbr = _abbr, \
@@ -93,8 +94,8 @@ struct command {
 		.arg = (_arg), \
 		.usage = (_usage), \
 	}; \
-	static const struct command *__command_ ## _name \
-	__attribute__((__used__)) __attribute__ ((__section__ ("__command"))) = &command_ ## _name
+	static const struct command *__command_ ## _name ## _ ## _type \
+	__attribute__((__used__)) __attribute__ ((__section__ ("__command"))) = &command_ ## _name ## _ ## _type
 
 #define COMMAND(_type, _handler, _abbr, _flags, _arg, _usage) \
 	COMMAND_NAMED(_type, _handler, _abbr, _handler, _flags, _arg, _usage)
diff --git a/man/batctl.8 b/man/batctl.8
index 0b43031..acb4288 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -68,7 +68,7 @@ free all attached interfaces and remove batman-adv interface.
 If no parameter is given the current originator interval setting is displayed otherwise the parameter is used to set the
 originator interval. The interval is in units of milliseconds.
 .br
-.IP "\fBap_isolation\fP|\fBap\fP [\fB0\fP|\fB1\fP]"
+.IP "[\fBvlan <vdev>\fP|\fBvid <vid>\fP] \fBap_isolation\fP|\fBap\fP [\fB0\fP|\fB1\fP]"
 If no parameter is given the current ap isolation setting is displayed. Otherwise the parameter is used to enable or
 disable ap isolation. This command can be used in conjunction with "\-m" option to target per VLAN configurations.
 .br
diff --git a/sys.c b/sys.c
index 39123db..f19719c 100644
--- a/sys.c
+++ b/sys.c
@@ -141,9 +141,35 @@ int sys_simple_print_boolean(struct nl_msg *msg, void *arg,
 
 static void settings_usage(struct state *state)
 {
-	fprintf(stderr, "Usage: batctl [options] %s|%s [parameters] %s\n",
-		state->cmd->name, state->cmd->abbr,
-		state->cmd->usage ? state->cmd->usage : "");
+	const char *default_prefixes[] = {
+		"",
+		NULL,
+	};
+	const char *vlan_prefixes[] = {
+		"vlan <vdev> ",
+		"vid <vid> ",
+		NULL,
+	};
+	const char *linestart = "Usage:";
+	const char **prefixes;
+	const char **prefix;
+
+	switch (state->cmd->type) {
+	case SUBCOMMAND_VID:
+		prefixes = vlan_prefixes;
+		break;
+	default:
+		prefixes = default_prefixes;
+		break;
+	}
+
+	for (prefix = &prefixes[0]; *prefix; prefix++) {
+		fprintf(stderr, "%s batctl [options] %s%s|%s [parameters] %s\n",
+			linestart, *prefix, state->cmd->name, state->cmd->abbr,
+			state->cmd->usage ? state->cmd->usage : "");
+
+		linestart = "      ";
+	}
 
 	fprintf(stderr, "parameters:\n");
 	fprintf(stderr, " \t -h print this help\n");
-- 
2.20.1


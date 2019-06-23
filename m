Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH v2 2/6] batctl: Integrate hardif setting framework
Date: Sun, 23 Jun 2019 15:07:05 +0200
Message-Id: <20190623130709.24751-3-sven@narfation.org>
In-Reply-To: <20190623130709.24751-1-sven@narfation.org>
References: <20190623130709.24751-1-sven@narfation.org>
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

batctl currently supports settings which are either mesh interface or vlan
specific. But B.A.T.M.A.N. V introduced two additional settings which are
hard (slave) interface specific.

To support these, an additional command prefix called hardif is implemented
for some sysfs commands:

  $ batctl hardif eth0 ...

Alternative form is to use the prefix selector "slave"

  $ batctl slave eth0 ...

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 functions.c | 22 ++++++++++++++++++++++
 functions.h |  1 +
 main.c      | 27 ++++++++++++++++++++++++++-
 main.h      |  8 +++++++-
 sys.c       | 15 +++++++++++++++
 sys.h       |  5 +++--
 6 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/functions.c b/functions.c
index 61ea487..4ffa86c 100644
--- a/functions.c
+++ b/functions.c
@@ -998,6 +998,28 @@ int translate_vid(struct state *state, const char *vidstr)
 	return 0;
 }
 
+int translate_hard_iface(struct state *state, const char *hardif)
+{
+	struct rtnl_link_iface_data link_data;
+	unsigned int arg_ifindex;
+
+	arg_ifindex = if_nametoindex(hardif);
+	if (arg_ifindex == 0)
+		return -ENODEV;
+
+	query_rtnl_link_single(arg_ifindex, &link_data);
+	if (!link_data.master_found)
+		return -ENOLINK;
+
+	if (!if_indextoname(link_data.master, state->mesh_iface))
+		return -ENOLINK;
+
+	state->hif = arg_ifindex;
+	state->selector = SP_HARDIF;
+
+	return 0;
+}
+
 static int check_mesh_iface_netlink(struct state *state)
 {
 	struct rtnl_link_iface_data link_data;
diff --git a/functions.h b/functions.h
index 7474c40..0a08870 100644
--- a/functions.h
+++ b/functions.h
@@ -53,6 +53,7 @@ int netlink_simple_request(struct nl_msg *msg);
 int translate_mesh_iface_vlan(struct state *state, const char *vlandev);
 int translate_vlan_iface(struct state *state, const char *vlandev);
 int translate_vid(struct state *state, const char *vidstr);
+int translate_hard_iface(struct state *state, const char *hardif);
 int get_algoname(const char *mesh_iface, char *algoname, size_t algoname_len);
 int check_mesh_iface(struct state *state);
 int check_mesh_iface_ownership(struct state *state, char *hard_iface);
diff --git a/main.c b/main.c
index 3090877..f81109b 100644
--- a/main.c
+++ b/main.c
@@ -35,7 +35,8 @@ static void print_usage(void)
 		{
 			.label = "commands:\n",
 			.types = BIT(SUBCOMMAND) |
-				 BIT(SUBCOMMAND_VID),
+				 BIT(SUBCOMMAND_VID) |
+				 BIT(SUBCOMMAND_HIF),
 		},
 		{
 			.label = "debug tables:                                   \tdisplay the corresponding debug table\n",
@@ -51,6 +52,10 @@ static void print_usage(void)
 		"vid <vid> ",
 		NULL,
 	};
+	const char *hardif_prefixes[] = {
+		"hardif <netdev> ",
+		NULL,
+	};
 	const struct command **p;
 	const char **prefixes;
 	const char **prefix;
@@ -81,6 +86,9 @@ static void print_usage(void)
 			case SUBCOMMAND_VID:
 				prefixes = vlan_prefixes;
 				break;
+			case SUBCOMMAND_HIF:
+				prefixes = hardif_prefixes;
+				break;
 			default:
 				prefixes = default_prefixes;
 				break;
@@ -153,6 +161,9 @@ static const struct command *find_command(struct state *state, const char *name)
 	case SP_VLAN:
 		types = BIT(SUBCOMMAND_VID);
 		break;
+	case SP_HARDIF:
+		types = BIT(SUBCOMMAND_HIF);
+		break;
 	default:
 		return NULL;
 	}
@@ -171,6 +182,10 @@ static int detect_selector_prefix(int argc, char *argv[],
 	if (strcmp(argv[0], "vlan") == 0) {
 		*selector = SP_VLAN;
 		return 2;
+	} else if (strcmp(argv[0], "hardif") == 0 ||
+		   strcmp(argv[0], "slave") == 0) {
+		*selector = SP_HARDIF;
+		return 2;
 	}
 
 	return 0;
@@ -197,7 +212,17 @@ static int parse_meshif_args(struct state *state, int argc, char *argv[])
 				dev_arg, strerror(-ret));
 			return ret;
 		}
+		return parsed_args;
+	case SP_HARDIF:
+		ret = translate_hard_iface(state, dev_arg);
+		if (ret < 0) {
+			fprintf(stderr, "Error - invalid hardif %s: %s\n",
+				dev_arg, strerror(-ret));
+			return ret;
+		}
 
+		snprintf(state->hard_iface, sizeof(state->hard_iface), "%s",
+			 dev_arg);
 		return parsed_args;
 	case SP_NONE_OR_MESHIF:
 		/* not allowed - see detect_selector_prefix */
diff --git a/main.h b/main.h
index 846efed..e3a95b5 100644
--- a/main.h
+++ b/main.h
@@ -59,11 +59,13 @@ enum command_flags {
 enum selector_prefix {
 	SP_NONE_OR_MESHIF,
 	SP_VLAN,
+	SP_HARDIF,
 };
 
 enum command_type {
 	SUBCOMMAND,
 	SUBCOMMAND_VID,
+	SUBCOMMAND_HIF,
 	DEBUGTABLE,
 };
 
@@ -72,7 +74,11 @@ struct state {
 	enum selector_prefix selector;
 	char mesh_iface[IF_NAMESIZE];
 	unsigned int mesh_ifindex;
-	int vid;
+	char hard_iface[IF_NAMESIZE];
+	union {
+		unsigned int hif;
+		int vid;
+	};
 	const struct command *cmd;
 
 	struct nl_sock *sock;
diff --git a/sys.c b/sys.c
index 61a314d..b9555ee 100644
--- a/sys.c
+++ b/sys.c
@@ -150,6 +150,10 @@ static void settings_usage(struct state *state)
 		"vid <vid> ",
 		NULL,
 	};
+	const char *hardif_prefixes[] = {
+		"hardif <netdev> ",
+		NULL,
+	};
 	const char *linestart = "Usage:";
 	const char **prefixes;
 	const char **prefix;
@@ -158,6 +162,9 @@ static void settings_usage(struct state *state)
 	case SUBCOMMAND_VID:
 		prefixes = vlan_prefixes;
 		break;
+	case SUBCOMMAND_HIF:
+		prefixes = hardif_prefixes;
+		break;
 	default:
 		prefixes = default_prefixes;
 		break;
@@ -271,6 +278,14 @@ int handle_sys_setting(struct state *state, int argc, char **argv)
 		snprintf(path_buff, PATH_BUFF_LEN, SYS_VLAN_PATH,
 			 state->mesh_iface, state->vid);
 		break;
+	case SP_HARDIF:
+		/* if a hard interface was specified then change the path to
+		 * point to the proper ${hardif}/batman-adv path in the sysfs
+		 * tree.
+		 */
+		snprintf(path_buff, PATH_BUFF_LEN, SYS_HARDIF_PATH,
+			 state->hard_iface);
+		break;
 	}
 
 	if (argc == 1) {
diff --git a/sys.h b/sys.h
index d4f2fcf..b6f0f90 100644
--- a/sys.h
+++ b/sys.h
@@ -21,8 +21,9 @@
 #define SYS_BATIF_PATH_FMT	"/sys/class/net/%s/mesh/"
 #define SYS_IFACE_PATH		"/sys/class/net"
 #define SYS_IFACE_DIR		SYS_IFACE_PATH"/%s/"
-#define SYS_MESH_IFACE_FMT	SYS_IFACE_PATH"/%s/batman_adv/mesh_iface"
-#define SYS_IFACE_STATUS_FMT	SYS_IFACE_PATH"/%s/batman_adv/iface_status"
+#define SYS_HARDIF_PATH		SYS_IFACE_DIR "batman_adv/"
+#define SYS_MESH_IFACE_FMT	SYS_HARDIF_PATH "mesh_iface"
+#define SYS_IFACE_STATUS_FMT	SYS_HARDIF_PATH "iface_status"
 #define SYS_VLAN_PATH		SYS_IFACE_PATH"/%s/mesh/vlan%d/"
 #define SYS_ROUTING_ALGO_FMT	SYS_IFACE_PATH"/%s/mesh/routing_algo"
 #define VLAN_ID_MAX_LEN		4
-- 
2.20.1


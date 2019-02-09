Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  9 Feb 2019 14:42:05 +0100
Message-Id: <20190209134222.15035-4-sven@narfation.org>
In-Reply-To: <20190209134222.15035-1-sven@narfation.org>
References: <20190209134222.15035-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH v5 03/20] batctl: Automatically translate
 vlan to mesh_iface
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

The way batctl is implementing support for VLANs is rather suboptimal. The
program has to guess whether it is started with an batadv or vlan interface
as argument.

Instead of distributing this over the whole program, do it on startup and
already retrieve the required mesh interface index and vid before the rest
of the program runs.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 functions.c   | 34 ++++++++++++++++++++++++++--------
 functions.h   |  6 ++++--
 gateways.c    | 10 ++--------
 main.c        | 10 ++++++----
 main.h        |  6 +++++-
 mcast_flags.c | 10 ++--------
 netlink.c     | 12 ++----------
 originators.c | 10 ++--------
 sys.c         | 14 +++++++-------
 9 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/functions.c b/functions.c
index aeebebf..953dcf9 100644
--- a/functions.c
+++ b/functions.c
@@ -820,7 +820,7 @@ static int vlan_get_link_parse(struct nl_msg *msg, void *arg)
  *
  * Returns the vlan identifier on success or -1 on error
  */
-int vlan_get_link(const char *ifname, char *parent)
+static int vlan_get_link(const char *ifname, char *parent)
 {
 	struct nl_sock *sock;
 	int ret;
@@ -987,19 +987,33 @@ int netlink_simple_request(struct nl_msg *msg)
 	return err;
 }
 
-int check_mesh_iface(char *mesh_iface)
+int translate_mesh_iface(struct state *state)
+{
+	state->vid = vlan_get_link(state->arg_iface, state->mesh_iface);
+	if (state->vid < 0) {
+		/* if there is no iface then the argument must be the
+		 * mesh interface
+		 */
+		snprintf(state->mesh_iface, sizeof(state->mesh_iface), "%s",
+			 state->arg_iface);
+	}
+
+	return 0;
+}
+
+int check_mesh_iface(struct state *state)
 {
 	char path_buff[PATH_BUFF_LEN];
-	char base_dev[IF_NAMESIZE];
-	int ret = -1, vid;
+	int ret = -1;
 	DIR *dir;
 
 	/* use the parent interface if this is a VLAN */
-	vid = vlan_get_link(mesh_iface, base_dev);
-	if (vid >= 0)
-		snprintf(path_buff, PATH_BUFF_LEN, SYS_VLAN_PATH, base_dev, vid);
+	if (state->vid >= 0)
+		snprintf(path_buff, PATH_BUFF_LEN, SYS_VLAN_PATH,
+			 state->mesh_iface, state->vid);
 	else
-		snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT, mesh_iface);
+		snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT,
+			 state->mesh_iface);
 
 	/* try to open the mesh sys directory */
 	dir = opendir(path_buff);
@@ -1008,6 +1022,10 @@ int check_mesh_iface(char *mesh_iface)
 
 	closedir(dir);
 
+	state->mesh_ifindex = if_nametoindex(state->mesh_iface);
+	if (state->mesh_ifindex == 0)
+		goto out;
+
 	ret = 0;
 out:
 	return ret;
diff --git a/functions.h b/functions.h
index a38d5f8..fd32d70 100644
--- a/functions.h
+++ b/functions.h
@@ -34,6 +34,8 @@
 
 #define PATH_BUFF_LEN 400
 
+struct state;
+
 /* return time delta from start to end in milliseconds */
 void start_timer(void);
 double end_timer(void);
@@ -48,10 +50,10 @@ int write_file(const char *dir, const char *fname, const char *arg1,
 struct ether_addr *translate_mac(const char *mesh_iface,
 				 const struct ether_addr *mac);
 struct ether_addr *resolve_mac(const char *asc);
-int vlan_get_link(const char *ifname, char *parent);
 int query_rtnl_link(int ifindex, nl_recvmsg_msg_cb_t func, void *arg);
 int netlink_simple_request(struct nl_msg *msg);
-int check_mesh_iface(char *mesh_iface);
+int translate_mesh_iface(struct state *state);
+int check_mesh_iface(struct state *state);
 int check_mesh_iface_ownership(char *mesh_iface, char *hard_iface);
 
 void get_random_bytes(void *buf, size_t buflen);
diff --git a/gateways.c b/gateways.c
index 46d41b3..be45d2e 100644
--- a/gateways.c
+++ b/gateways.c
@@ -133,17 +133,11 @@ static int netlink_print_gateways(struct state *state, char *orig_iface,
 {
 	char *header = NULL;
 	char *info_header;
-	int ifindex;
-
-	ifindex = if_nametoindex(state->mesh_iface);
-	if (!ifindex) {
-		fprintf(stderr, "Interface %s is unknown\n", state->mesh_iface);
-		return -ENODEV;
-	}
 
 	/* only parse routing algorithm name */
 	last_err = -EINVAL;
-	info_header = netlink_get_info(ifindex, BATADV_CMD_GET_ORIGINATORS, NULL);
+	info_header = netlink_get_info(state->mesh_ifindex,
+				       BATADV_CMD_GET_ORIGINATORS, NULL);
 	free(info_header);
 
 	if (strlen(algo_name_buf) == 0)
diff --git a/main.c b/main.c
index cf62b15..2a28642 100644
--- a/main.c
+++ b/main.c
@@ -125,7 +125,7 @@ int main(int argc, char **argv)
 {
 	const struct command *cmd;
 	struct state state = {
-		.mesh_iface = mesh_dfl_iface,
+		.arg_iface = mesh_dfl_iface,
 		.cmd = NULL,
 	};
 	int opt;
@@ -138,13 +138,13 @@ int main(int argc, char **argv)
 			exit(EXIT_SUCCESS);
 			break;
 		case 'm':
-			if (state.mesh_iface != mesh_dfl_iface) {
+			if (state.arg_iface != mesh_dfl_iface) {
 				fprintf(stderr,
 					"Error - multiple mesh interfaces specified\n");
 				goto err;
 			}
 
-			state.mesh_iface = argv[2];
+			state.arg_iface = argv[2];
 			break;
 		case 'v':
 			version();
@@ -173,8 +173,10 @@ int main(int argc, char **argv)
 
 	state.cmd = cmd;
 
+	translate_mesh_iface(&state);
+
 	if (cmd->flags & COMMAND_FLAG_MESH_IFACE &&
-	    check_mesh_iface(state.mesh_iface) < 0) {
+	    check_mesh_iface(&state) < 0) {
 		fprintf(stderr,
 			"Error - interface %s is not present or not a batman-adv interface\n",
 			state.mesh_iface);
diff --git a/main.h b/main.h
index 2cc6975..fca2a32 100644
--- a/main.h
+++ b/main.h
@@ -25,6 +25,7 @@
 
 #include <stdint.h>
 
+#include <net/if.h>
 #include <netlink/genl/ctrl.h>
 #include <netlink/genl/genl.h>
 #include <netlink/netlink.h>
@@ -74,7 +75,10 @@ enum command_type {
 };
 
 struct state {
-	char *mesh_iface;
+	char *arg_iface;
+	char mesh_iface[IF_NAMESIZE];
+	unsigned int mesh_ifindex;
+	int vid;
 	const struct command *cmd;
 
 	struct nl_sock *sock;
diff --git a/mcast_flags.c b/mcast_flags.c
index ef4b440..8529394 100644
--- a/mcast_flags.c
+++ b/mcast_flags.c
@@ -113,17 +113,11 @@ static int netlink_print_mcast_flags(struct state *state, char *orig_iface,
 	char *info_header;
 	char *header;
 	bool bridged;
-	int ifindex;
 	int ret;
 
-	ifindex = if_nametoindex(state->mesh_iface);
-	if (!ifindex) {
-		fprintf(stderr, "Interface %s is unknown\n", state->mesh_iface);
-		return -ENODEV;
-	}
-
 	/* only parse own multicast flags */
-	info_header = netlink_get_info(ifindex, BATADV_CMD_GET_MCAST_FLAGS, NULL);
+	info_header = netlink_get_info(state->mesh_ifindex,
+				       BATADV_CMD_GET_MCAST_FLAGS, NULL);
 	free(info_header);
 
 	if (mcast_flags == -EOPNOTSUPP || mcast_flags_priv == -EOPNOTSUPP)
diff --git a/netlink.c b/netlink.c
index abd3316..f4921df 100644
--- a/netlink.c
+++ b/netlink.c
@@ -443,20 +443,12 @@ int netlink_print_common(struct state *state, char *orig_iface, int read_opt,
 	};
 	int hardifindex = 0;
 	struct nl_msg *msg;
-	int ifindex;
 
 	if (!state->sock) {
 		last_err = -EOPNOTSUPP;
 		return last_err;
 	}
 
-	ifindex = if_nametoindex(state->mesh_iface);
-	if (!ifindex) {
-		fprintf(stderr, "Interface %s is unknown\n", state->mesh_iface);
-		last_err = -ENODEV;
-		return last_err;
-	}
-
 	if (orig_iface) {
 		hardifindex = if_nametoindex(orig_iface);
 		if (!hardifindex) {
@@ -479,7 +471,7 @@ int netlink_print_common(struct state *state, char *orig_iface, int read_opt,
 			printf("\033[2J\033[0;0f");
 
 		if (!(read_opt & SKIP_HEADER))
-			opts.remaining_header = netlink_get_info(ifindex,
+			opts.remaining_header = netlink_get_info(state->mesh_ifindex,
 								 nl_cmd,
 								 header);
 
@@ -490,7 +482,7 @@ int netlink_print_common(struct state *state, char *orig_iface, int read_opt,
 		genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, state->batadv_family,
 			    0, NLM_F_DUMP, nl_cmd, 1);
 
-		nla_put_u32(msg, BATADV_ATTR_MESH_IFINDEX, ifindex);
+		nla_put_u32(msg, BATADV_ATTR_MESH_IFINDEX, state->mesh_ifindex);
 		if (hardifindex)
 			nla_put_u32(msg, BATADV_ATTR_HARD_IFINDEX,
 				    hardifindex);
diff --git a/originators.c b/originators.c
index 57476c0..59e3d34 100644
--- a/originators.c
+++ b/originators.c
@@ -185,17 +185,11 @@ static int netlink_print_originators(struct state *state, char *orig_iface,
 {
 	char *header = NULL;
 	char *info_header;
-	int ifindex;
-
-	ifindex = if_nametoindex(state->mesh_iface);
-	if (!ifindex) {
-		fprintf(stderr, "Interface %s is unknown\n", state->mesh_iface);
-		return -ENODEV;
-	}
 
 	/* only parse routing algorithm name */
 	last_err = -EINVAL;
-	info_header = netlink_get_info(ifindex, BATADV_CMD_GET_ORIGINATORS, NULL);
+	info_header = netlink_get_info(state->mesh_ifindex,
+				       BATADV_CMD_GET_ORIGINATORS, NULL);
 	free(info_header);
 
 	if (strlen(algo_name_buf) == 0)
diff --git a/sys.c b/sys.c
index bf2720b..102d3df 100644
--- a/sys.c
+++ b/sys.c
@@ -66,8 +66,7 @@ static void settings_usage(struct state *state)
 int handle_sys_setting(struct state *state, int argc, char **argv)
 {
 	struct settings_data *settings = state->cmd->arg;
-	int vid, optchar, res = EXIT_FAILURE;
-	char base_dev[IF_NAMESIZE];
+	int optchar, res = EXIT_FAILURE;
 	char *path_buff;
 	const char **ptr;
 
@@ -89,14 +88,15 @@ int handle_sys_setting(struct state *state, int argc, char **argv)
 		return EXIT_FAILURE;
 	}
 
-	snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT, state->mesh_iface);
-
 	/* if the specified interface is a VLAN then change the path to point
 	 * to the proper "vlan%{vid}" subfolder in the sysfs tree.
 	 */
-	vid = vlan_get_link(state->mesh_iface, base_dev);
-	if (vid >= 0)
-		snprintf(path_buff, PATH_BUFF_LEN, SYS_VLAN_PATH, base_dev, vid);
+	if (state->vid >= 0)
+		snprintf(path_buff, PATH_BUFF_LEN, SYS_VLAN_PATH,
+			 state->mesh_iface, state->vid);
+	else
+		snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT,
+			 state->mesh_iface);
 
 	if (argc == 1) {
 		res = read_file(path_buff, settings->sysfs_name,
-- 
2.20.1


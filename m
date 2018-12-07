Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri,  7 Dec 2018 21:31:53 +0100
Message-Id: <20181207203209.22633-5-sven@narfation.org>
In-Reply-To: <20181207203209.22633-1-sven@narfation.org>
References: <20181207203209.22633-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC v4 04/20] batctl: Add settings_data hooks for
 netlink integration
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

The generic netlink infrastructure will be used in the future to replace
sysfs for manipulating the runtime configuation of batman-adv meshifs,
hardifs and vlans. These will not use the raw strings when communicating
with the kernel interface but a well defined binary message format.

This means that the read function for settings must parse the binary format
and convert it to a textual representation for the user. The netlink_get
hook of struct settings_data will be used for that.

A similar problem is the setting of configuration entries. The textual
representation of the user input has to be parsed and validated. And the
resulting attributes have to be put in a message which the kernel can
interpret. The parsing is done in the parse hook which can use the data
pointer to store the results. The netlink_set hook has to prepare the
generic netlink message and send it to the kernel.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 sys.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
 sys.h |  4 ++++
 2 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/sys.c b/sys.c
index be20be7..e883369 100644
--- a/sys.c
+++ b/sys.c
@@ -63,6 +63,47 @@ static void settings_usage(struct state *state)
 	fprintf(stderr, " \t -h print this help\n");
 }
 
+static int sys_read_setting(struct state *state, const char *path_buff,
+			    const char *sysfs_name)
+{
+	struct settings_data *settings = state->cmd->arg;
+	int res = EXIT_FAILURE;
+
+	if (settings->netlink_get) {
+		res = settings->netlink_get(state);
+		if (res < 0 && res != -EOPNOTSUPP)
+			return EXIT_FAILURE;
+		if (res >= 0)
+			return EXIT_SUCCESS;
+	}
+
+	if (sysfs_name)
+		res = read_file(path_buff, sysfs_name, NO_FLAGS, 0, 0, 0);
+
+	return res;
+}
+
+static int sys_write_setting(struct state *state, const char *path_buff,
+			    const char *sysfs_name, int argc, char **argv)
+{
+	struct settings_data *settings = state->cmd->arg;
+	int res = EXIT_FAILURE;
+
+	if (settings->netlink_set) {
+		res = settings->netlink_set(state);
+		if (res < 0 && res != -EOPNOTSUPP)
+			return EXIT_FAILURE;
+		if (res >= 0)
+			return EXIT_SUCCESS;
+	}
+
+	if (sysfs_name)
+		res = write_file(path_buff, sysfs_name,
+				 argv[1], argc > 2 ? argv[2] : NULL);
+
+	return res;
+}
+
 int handle_sys_setting(struct state *state, int argc, char **argv)
 {
 	struct settings_data *settings = state->cmd->arg;
@@ -99,13 +140,20 @@ int handle_sys_setting(struct state *state, int argc, char **argv)
 			 state->mesh_iface);
 
 	if (argc == 1) {
-		res = read_file(path_buff, settings->sysfs_name,
-				NO_FLAGS, 0, 0, 0);
+		res = sys_read_setting(state, path_buff, settings->sysfs_name);
 		goto out;
 	}
 
 	check_root_or_die("batctl");
 
+	if (settings->parse) {
+		res = settings->parse(state, argc, argv);
+		if (res < 0) {
+			res = EXIT_FAILURE;
+			goto out;
+		}
+	}
+
 	if (!settings->params)
 		goto write_file;
 
@@ -129,8 +177,8 @@ int handle_sys_setting(struct state *state, int argc, char **argv)
 	goto out;
 
 write_file:
-	res = write_file(path_buff, settings->sysfs_name,
-			 argv[1], argc > 2 ? argv[2] : NULL);
+	res = sys_write_setting(state, path_buff, settings->sysfs_name, argc,
+				argv);
 
 out:
 	free(path_buff);
diff --git a/sys.h b/sys.h
index 20e1934..cac2c53 100644
--- a/sys.h
+++ b/sys.h
@@ -42,6 +42,10 @@
 struct settings_data {
 	const char *sysfs_name;
 	const char **params;
+	void *data;
+	int (*parse)(struct state *state, int argc, char *argv[]);
+	int (*netlink_get)(struct state *state);
+	int (*netlink_set)(struct state *state);
 };
 
 extern const char *sysfs_param_enable[];
-- 
2.19.2


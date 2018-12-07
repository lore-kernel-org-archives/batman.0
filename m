Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri,  7 Dec 2018 21:32:09 +0100
Message-Id: <20181207203209.22633-21-sven@narfation.org>
In-Reply-To: <20181207203209.22633-1-sven@narfation.org>
References: <20181207203209.22633-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC v4 20/20] batctl: Drop settings_date param lists
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

The parsing and validation of the settings command parameters is handled by
the parse function. The params struct member is therefore no longer used
and can just be dropped.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 sys.c | 32 --------------------------------
 sys.h |  3 ---
 2 files changed, 35 deletions(-)

diff --git a/sys.c b/sys.c
index ede8b09..a53b419 100644
--- a/sys.c
+++ b/sys.c
@@ -39,14 +39,6 @@
 #include "functions.h"
 #include "debug.h"
 
-const char *sysfs_param_enable[] = {
-	"enable",
-	"disable",
-	"1",
-	"0",
-	NULL,
-};
-
 int parse_simple_boolean(struct state *state, int argc, char *argv[])
 {
 	struct settings_data *settings = state->cmd->arg;
@@ -216,7 +208,6 @@ int handle_sys_setting(struct state *state, int argc, char **argv)
 	struct settings_data *settings = state->cmd->arg;
 	int optchar, res = EXIT_FAILURE;
 	char *path_buff;
-	const char **ptr;
 
 	while ((optchar = getopt(argc, argv, "h")) != -1) {
 		switch (optchar) {
@@ -261,29 +252,6 @@ int handle_sys_setting(struct state *state, int argc, char **argv)
 		}
 	}
 
-	if (!settings->params)
-		goto write_file;
-
-	ptr = settings->params;
-	while (*ptr) {
-		if (strcmp(*ptr, argv[1]) == 0)
-			goto write_file;
-
-		ptr++;
-	}
-
-	fprintf(stderr, "Error - the supplied argument is invalid: %s\n", argv[1]);
-	fprintf(stderr, "The following values are allowed:\n");
-
-	ptr = settings->params;
-	while (*ptr) {
-		fprintf(stderr, " * %s\n", *ptr);
-		ptr++;
-	}
-
-	goto out;
-
-write_file:
 	res = sys_write_setting(state, path_buff, settings->sysfs_name, argc,
 				argv);
 
diff --git a/sys.h b/sys.h
index f32f134..e7d227d 100644
--- a/sys.h
+++ b/sys.h
@@ -49,15 +49,12 @@
 
 struct settings_data {
 	const char *sysfs_name;
-	const char **params;
 	void *data;
 	int (*parse)(struct state *state, int argc, char *argv[]);
 	int (*netlink_get)(struct state *state);
 	int (*netlink_set)(struct state *state);
 };
 
-extern const char *sysfs_param_enable[];
-
 struct simple_boolean_data {
 	bool val;
 };
-- 
2.19.2


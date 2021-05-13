Return-Path: <asarmanow@gmail.com>
From: Alexander Sarmanow <asarmanow@gmail.com>
Subject: [PATCH v3 2/2] batctl: debug: Introduce handler for DEBUGJSON
Date: Thu, 13 May 2021 16:10:34 +0200
Message-Id: <20210513141034.1649576-3-asarmanow@gmail.com>
In-Reply-To: <20210513141034.1649576-1-asarmanow@gmail.com>
References: <20210513141034.1649576-1-asarmanow@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: sven@narfation.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, sw@simonwunderlich.de, Alexander Sarmanow <asarmanow@gmail.com>

DEBUGJSON commands require an own handler, since they may have their own
parameters. So far there is currently only the help parameter, but more can be
added in future.

Signed-off-by: Alexander Sarmanow <asarmanow@gmail.com>
---
 debug.c | 29 +++++++++++++++++++++++++++++
 debug.h |  5 +++++
 2 files changed, 34 insertions(+)

diff --git a/debug.c b/debug.c
index 458c137..20467c7 100644
--- a/debug.c
+++ b/debug.c
@@ -42,6 +42,14 @@ static void debug_table_usage(struct state *state)
 		fprintf(stderr, " \t -m print multicast mac addresses only\n");
 }
 
+static void debug_json_usage(struct state *state)
+{
+	fprintf(stderr, "Usage: batctl [options] %s|%s [parameters]\n",
+		state->cmd->name, state->cmd->abbr);
+	fprintf(stderr, "parameters:\n");
+	fprintf(stderr, " \t -h print this help\n");
+}
+
 int handle_debug_table(struct state *state, int argc, char **argv)
 {
 	struct debug_table_data *debug_table = state->cmd->arg;
@@ -148,3 +156,24 @@ int handle_debug_table(struct state *state, int argc, char **argv)
 				      orig_timeout, watch_interval);
 	return err;
 }
+
+int handle_debug_json(struct state *state, int argc, char **argv)
+{
+	struct debug_json_data *debug_json = state->cmd->arg;
+	int optchar;
+	int err;
+
+	while ((optchar = getopt(argc, argv, "h")) != -1) {
+		switch (optchar) {
+		case 'h':
+			debug_json_usage(state);
+			return EXIT_SUCCESS;
+		}
+	}
+
+	check_root_or_die("batctl");
+
+	err = debug_json->netlink_fn(state);
+
+	return err;
+}
diff --git a/debug.h b/debug.h
index bfc6224..90f2e68 100644
--- a/debug.h
+++ b/debug.h
@@ -21,6 +21,11 @@ struct debug_table_data {
 	unsigned int option_orig_iface:1;
 };
 
+struct debug_json_data {
+	int (*netlink_fn)(struct state *state);
+};
+
 int handle_debug_table(struct state *state, int argc, char **argv);
+int handle_debug_json(struct state *state, int argc, char **argv);
 
 #endif
-- 
2.25.1


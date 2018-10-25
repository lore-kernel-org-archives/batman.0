Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 25 Oct 2018 18:22:13 +0200
Message-Id: <20181025162245.19389-11-sven@narfation.org>
In-Reply-To: <20181025162245.19389-1-sven@narfation.org>
References: <20181025162245.19389-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v3 10/42] batctl: Add per command flags
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

Some commands have different prerequists than other commands. Using flags
to specify them would allow batctl to use the same command structure for
the non-mesh_iface based command as for mesh_iface based commands.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 gw_mode.c         |  2 +-
 log.c             |  2 +-
 loglevel.c        |  2 +-
 main.c            | 13 ++++++++++---
 main.h            | 12 +++++++++---
 ping.c            |  2 +-
 statistics.c      |  2 +-
 throughputmeter.c |  2 +-
 traceroute.c      |  2 +-
 translate.c       |  2 +-
 10 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/gw_mode.c b/gw_mode.c
index 884f38e..f07dc99 100644
--- a/gw_mode.c
+++ b/gw_mode.c
@@ -167,4 +167,4 @@ static int gw_mode(char *mesh_iface, int argc, char **argv)
 	return res;
 }
 
-COMMAND(gw_mode, "gw");
+COMMAND(gw_mode, "gw", COMMAND_FLAG_MESH_IFACE);
diff --git a/log.c b/log.c
index 66594f6..585f1c9 100644
--- a/log.c
+++ b/log.c
@@ -69,4 +69,4 @@ static int log_print(char *mesh_iface, int argc, char **argv)
 	return res;
 }
 
-COMMAND_NAMED(log, "l", log_print);
+COMMAND_NAMED(log, "l", log_print, COMMAND_FLAG_MESH_IFACE);
diff --git a/loglevel.c b/loglevel.c
index 3d9cf3a..06519e7 100644
--- a/loglevel.c
+++ b/loglevel.c
@@ -143,4 +143,4 @@ static int loglevel(char *mesh_iface, int argc, char **argv)
 	return res;
 }
 
-COMMAND(loglevel, "ll");
+COMMAND(loglevel, "ll", COMMAND_FLAG_MESH_IFACE);
diff --git a/main.c b/main.c
index 14f4774..dacfb12 100644
--- a/main.c
+++ b/main.c
@@ -169,12 +169,19 @@ int main(int argc, char **argv)
 
 		ret = routing_algo(mesh_iface, argc - 1, argv + 1);
 
-	} else if (check_mesh_iface(mesh_iface) < 0) {
-		fprintf(stderr, "Error - interface %s is not present or not a batman-adv interface\n", mesh_iface);
-		exit(EXIT_FAILURE);
 	} else if ((cmd = find_command(argv[1]))) {
+		if (cmd->flags & COMMAND_FLAG_MESH_IFACE &&
+		    check_mesh_iface(mesh_iface) < 0) {
+			fprintf(stderr, "Error - interface %s is not present or not a batman-adv interface\n", mesh_iface);
+			exit(EXIT_FAILURE);
+		}
+
 		ret = cmd->handler(mesh_iface, argc - 1, argv + 1);
 	} else {
+		if (check_mesh_iface(mesh_iface) < 0) {
+			fprintf(stderr, "Error - interface %s is not present or not a batman-adv interface\n", mesh_iface);
+			exit(EXIT_FAILURE);
+		}
 
 		for (i = 0; i < BATCTL_SETTINGS_NUM; i++) {
 			if ((strcmp(argv[1], batctl_settings[i].opt_long) != 0) &&
diff --git a/main.h b/main.h
index f7e2f64..c461d6b 100644
--- a/main.h
+++ b/main.h
@@ -57,22 +57,28 @@ extern char module_ver_path[];
 #define BATADV_PRINT_VID(vid) (vid & BATADV_VLAN_HAS_TAG ? \
 			       (int)(vid & VLAN_VID_MASK) : -1)
 
+enum command_flags {
+	COMMAND_FLAG_MESH_IFACE = BIT(0),
+};
+
 struct command {
 	const char *name;
 	const char *abbr;
 	int (*handler)(char *mesh_iface, int argc, char **argv);
+	uint32_t flags;
 };
 
-#define COMMAND_NAMED(_name, _abbr, _handler) \
+#define COMMAND_NAMED(_name, _abbr, _handler, _flags) \
 	static const struct command command_ ## _name = { \
 		.name = (#_name), \
 		.abbr = _abbr, \
 		.handler = (_handler), \
+		.flags = (_flags), \
 	}; \
 	static const struct command *__command_ ## _name \
 	__attribute__((__used__)) __attribute__ ((__section__ ("__command"))) = &command_ ## _name
 
-#define COMMAND(_handler, _abbr) \
-	COMMAND_NAMED(_handler, _abbr, _handler)
+#define COMMAND(_handler, _abbr, _flags) \
+	COMMAND_NAMED(_handler, _abbr, _handler, _flags)
 
 #endif
diff --git a/ping.c b/ping.c
index a4a1851..2da49d4 100644
--- a/ping.c
+++ b/ping.c
@@ -345,4 +345,4 @@ static int ping(char *mesh_iface, int argc, char **argv)
 	return ret;
 }
 
-COMMAND(ping, "p");
+COMMAND(ping, "p", COMMAND_FLAG_MESH_IFACE);
diff --git a/statistics.c b/statistics.c
index dea3ac1..cb6c1e8 100644
--- a/statistics.c
+++ b/statistics.c
@@ -126,4 +126,4 @@ static int statistics(char *mesh_iface, int argc __maybe_unused,
 	return ret;
 }
 
-COMMAND(statistics, "s");
+COMMAND(statistics, "s", COMMAND_FLAG_MESH_IFACE);
diff --git a/throughputmeter.c b/throughputmeter.c
index 372bfc4..e9e318c 100644
--- a/throughputmeter.c
+++ b/throughputmeter.c
@@ -543,4 +543,4 @@ static int throughputmeter(char *mesh_iface, int argc, char **argv)
 	return ret;
 }
 
-COMMAND(throughputmeter, "tp");
+COMMAND(throughputmeter, "tp", COMMAND_FLAG_MESH_IFACE);
diff --git a/traceroute.c b/traceroute.c
index 5c55c7b..1352201 100644
--- a/traceroute.c
+++ b/traceroute.c
@@ -231,4 +231,4 @@ static int traceroute(char *mesh_iface, int argc, char **argv)
 	return ret;
 }
 
-COMMAND(traceroute, "tr");
+COMMAND(traceroute, "tr", COMMAND_FLAG_MESH_IFACE);
diff --git a/translate.c b/translate.c
index ec6baaf..d2d34f5 100644
--- a/translate.c
+++ b/translate.c
@@ -78,4 +78,4 @@ static int translate(char *mesh_iface, int argc, char **argv)
 	return ret;
 }
 
-COMMAND(translate, "t");
+COMMAND(translate, "t", COMMAND_FLAG_MESH_IFACE);
-- 
2.11.0


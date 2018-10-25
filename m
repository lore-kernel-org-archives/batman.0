Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 25 Oct 2018 18:22:18 +0200
Message-Id: <20181025162245.19389-16-sven@narfation.org>
In-Reply-To: <20181025162245.19389-1-sven@narfation.org>
References: <20181025162245.19389-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v3 15/42] batctl: Add type to command to
 structure usage output
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

The usage output of batctl is structured in different sections. This should
be preserved when the remaining subcommands are converted to the command
infrastructure.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bisect_iv.c       |  2 +-
 gw_mode.c         |  2 +-
 interface.c       |  2 +-
 log.c             |  2 +-
 loglevel.c        |  2 +-
 main.c            | 68 +++++++++++++++++++++++++++++++++++--------------------
 main.h            | 12 +++++++---
 ping.c            |  2 +-
 routing_algo.c    |  2 +-
 statistics.c      |  2 +-
 tcpdump.c         |  2 +-
 throughputmeter.c |  2 +-
 traceroute.c      |  2 +-
 translate.c       |  2 +-
 14 files changed, 64 insertions(+), 40 deletions(-)

diff --git a/bisect_iv.c b/bisect_iv.c
index c6fc708..420317e 100644
--- a/bisect_iv.c
+++ b/bisect_iv.c
@@ -1595,5 +1595,5 @@ static int bisect_iv(struct state *state __maybe_unused, int argc, char **argv)
 	return ret;
 }
 
-COMMAND(bisect_iv, "bisect_iv", 0, NULL,
+COMMAND(SUBCOMMAND, bisect_iv, "bisect_iv", 0, NULL,
 	"<file1> .. <fileN>\tanalyze given batman iv log files for routing stability");
diff --git a/gw_mode.c b/gw_mode.c
index bd530d5..4093f89 100644
--- a/gw_mode.c
+++ b/gw_mode.c
@@ -167,5 +167,5 @@ static int gw_mode(struct state *state, int argc, char **argv)
 	return res;
 }
 
-COMMAND(gw_mode, "gw", COMMAND_FLAG_MESH_IFACE, NULL,
+COMMAND(SUBCOMMAND, gw_mode, "gw", COMMAND_FLAG_MESH_IFACE, NULL,
 	"[mode]            \tdisplay or modify the gateway mode");
diff --git a/interface.c b/interface.c
index 5f69cb3..3c176a8 100644
--- a/interface.c
+++ b/interface.c
@@ -458,5 +458,5 @@ static int interface(struct state *state, int argc, char **argv)
 	return EXIT_FAILURE;
 }
 
-COMMAND(interface, "if", 0, NULL,
+COMMAND(SUBCOMMAND, interface, "if", 0, NULL,
 	"[add|del iface(s)]\tdisplay or modify the interface settings");
diff --git a/log.c b/log.c
index b4f0b86..cd69676 100644
--- a/log.c
+++ b/log.c
@@ -69,5 +69,5 @@ static int log_print(struct state *state, int argc, char **argv)
 	return res;
 }
 
-COMMAND_NAMED(log, "l", log_print, COMMAND_FLAG_MESH_IFACE, NULL,
+COMMAND_NAMED(SUBCOMMAND, log, "l", log_print, COMMAND_FLAG_MESH_IFACE, NULL,
 	      "                  \tread the log produced by the kernel module");
diff --git a/loglevel.c b/loglevel.c
index 7a61524..fed70c8 100644
--- a/loglevel.c
+++ b/loglevel.c
@@ -143,5 +143,5 @@ static int loglevel(struct state *state, int argc, char **argv)
 	return res;
 }
 
-COMMAND(loglevel, "ll", COMMAND_FLAG_MESH_IFACE, NULL,
+COMMAND(SUBCOMMAND, loglevel, "ll", COMMAND_FLAG_MESH_IFACE, NULL,
 	"[level]           \tdisplay or modify the log level");
diff --git a/main.c b/main.c
index e20f914..251d753 100644
--- a/main.c
+++ b/main.c
@@ -41,45 +41,63 @@ extern const struct command *__stop___command[];
 
 static void print_usage(void)
 {
+	enum command_type type[] = {
+		SUBCOMMAND,
+	};
 	const struct command **p;
-	int i, opt_indent;
+	int opt_indent;
 	char buf[32];
+	size_t i;
+	size_t j;
 
 	fprintf(stderr, "Usage: batctl [options] command|debug table [parameters]\n");
 	fprintf(stderr, "options:\n");
 	fprintf(stderr, " \t-m mesh interface or VLAN created on top of a mesh interface (default 'bat0')\n");
 	fprintf(stderr, " \t-h print this help (or 'batctl <command|debug table> -h' for the parameter help)\n");
 	fprintf(stderr, " \t-v print version\n");
-	fprintf(stderr, "\n");
 
-	fprintf(stderr, "commands:\n");
+	for (i = 0; i < sizeof(type) / sizeof(*type); i++) {
+		fprintf(stderr, "\n");
 
-	for (p = __start___command; p < __stop___command; p++) {
-		const struct command *cmd = *p;
+		switch (type[i]) {
+		case SUBCOMMAND:
+			fprintf(stderr, "commands:\n");
+			break;
+		}
 
-		if (strcmp(cmd->name, cmd->abbr) == 0)
-			snprintf(buf, sizeof(buf), "%s", cmd->name);
-		else
-			snprintf(buf, sizeof(buf), "%s|%s", cmd->name,
-				 cmd->abbr);
+		for (p = __start___command; p < __stop___command; p++) {
+			const struct command *cmd = *p;
 
-		fprintf(stderr, " \t%-27s%s\n", buf, cmd->usage);
-	}
+			if (cmd->type != type[i])
+				continue;
+
+			if (strcmp(cmd->name, cmd->abbr) == 0)
+				snprintf(buf, sizeof(buf), "%s", cmd->name);
+			else
+				snprintf(buf, sizeof(buf), "%s|%s", cmd->name,
+					 cmd->abbr);
+
+			fprintf(stderr, " \t%-27s%s\n", buf, cmd->usage);
+		}
 
-	for (i = 0; i < BATCTL_SETTINGS_NUM; i++) {
-		fprintf(stderr, " \t%s|%s", batctl_settings[i].opt_long, batctl_settings[i].opt_short);
-		opt_indent = strlen(batctl_settings[i].opt_long) + strlen(batctl_settings[i].opt_short);
-
-		if (batctl_settings[i].params == sysfs_param_enable)
-			fprintf(stderr, "%*s                display or modify %s setting\n",
-			       31 - opt_indent, "[0|1]", batctl_settings[i].opt_long);
-		else if (batctl_settings[i].params == sysfs_param_server)
-			fprintf(stderr, "%*s      display or modify %s setting\n",
-			       41 - opt_indent, "[client|server]", batctl_settings[i].opt_long);
-		else
-			fprintf(stderr, "                                display or modify %s setting\n",
-			       batctl_settings[i].opt_long);
+		if (type[i] == SUBCOMMAND) {
+			for (j = 0; j < BATCTL_SETTINGS_NUM; j++) {
+				fprintf(stderr, " \t%s|%s", batctl_settings[j].opt_long, batctl_settings[j].opt_short);
+				opt_indent = strlen(batctl_settings[j].opt_long) + strlen(batctl_settings[j].opt_short);
+
+				if (batctl_settings[j].params == sysfs_param_enable)
+					fprintf(stderr, "%*s                display or modify %s setting\n",
+						31 - opt_indent, "[0|1]", batctl_settings[j].opt_long);
+				else if (batctl_settings[j].params == sysfs_param_server)
+					fprintf(stderr, "%*s      display or modify %s setting\n",
+						41 - opt_indent, "[client|server]", batctl_settings[j].opt_long);
+				else
+					fprintf(stderr, "                                display or modify %s setting\n",
+						batctl_settings[j].opt_long);
+			}
+		}
 	}
+
 	fprintf(stderr, "\n");
 
 	fprintf(stderr, "debug tables:                                   \tdisplay the corresponding debug table\n");
diff --git a/main.h b/main.h
index 77eb432..052304c 100644
--- a/main.h
+++ b/main.h
@@ -61,12 +61,17 @@ enum command_flags {
 	COMMAND_FLAG_MESH_IFACE = BIT(0),
 };
 
+enum command_type {
+	SUBCOMMAND,
+};
+
 struct state {
 	char *mesh_iface;
 	const struct command *cmd;
 };
 
 struct command {
+	enum command_type type;
 	const char *name;
 	const char *abbr;
 	int (*handler)(struct state *state, int argc, char **argv);
@@ -75,8 +80,9 @@ struct command {
 	const char *usage;
 };
 
-#define COMMAND_NAMED(_name, _abbr, _handler, _flags, _arg, _usage) \
+#define COMMAND_NAMED(_type, _name, _abbr, _handler, _flags, _arg, _usage) \
 	static const struct command command_ ## _name = { \
+		.type = (_type), \
 		.name = (#_name), \
 		.abbr = _abbr, \
 		.handler = (_handler), \
@@ -87,7 +93,7 @@ struct command {
 	static const struct command *__command_ ## _name \
 	__attribute__((__used__)) __attribute__ ((__section__ ("__command"))) = &command_ ## _name
 
-#define COMMAND(_handler, _abbr, _flags, _arg, _usage) \
-	COMMAND_NAMED(_handler, _abbr, _handler, _flags, _arg, _usage)
+#define COMMAND(_type, _handler, _abbr, _flags, _arg, _usage) \
+	COMMAND_NAMED(_type, _handler, _abbr, _handler, _flags, _arg, _usage)
 
 #endif
diff --git a/ping.c b/ping.c
index 24af0e8..5c13d81 100644
--- a/ping.c
+++ b/ping.c
@@ -345,5 +345,5 @@ static int ping(struct state *state, int argc, char **argv)
 	return ret;
 }
 
-COMMAND(ping, "p", COMMAND_FLAG_MESH_IFACE, NULL,
+COMMAND(SUBCOMMAND, ping, "p", COMMAND_FLAG_MESH_IFACE, NULL,
 	"<destination>     \tping another batman adv host via layer 2");
diff --git a/routing_algo.c b/routing_algo.c
index 30e588b..ded9284 100644
--- a/routing_algo.c
+++ b/routing_algo.c
@@ -126,5 +126,5 @@ static int routing_algo(struct state *state __maybe_unused, int argc, char **arg
 	return res;
 }
 
-COMMAND(routing_algo, "ra", 0, NULL,
+COMMAND(SUBCOMMAND, routing_algo, "ra", 0, NULL,
 	"[mode]            \tdisplay or modify the routing algorithm");
diff --git a/statistics.c b/statistics.c
index 26ffe44..d684fa5 100644
--- a/statistics.c
+++ b/statistics.c
@@ -126,5 +126,5 @@ static int statistics(struct state *state, int argc __maybe_unused,
 	return ret;
 }
 
-COMMAND(statistics, "s", COMMAND_FLAG_MESH_IFACE, NULL,
+COMMAND(SUBCOMMAND, statistics, "s", COMMAND_FLAG_MESH_IFACE, NULL,
 	"                  \tprint mesh statistics");
diff --git a/tcpdump.c b/tcpdump.c
index 5c93842..42713d3 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -1352,5 +1352,5 @@ static int tcpdump(struct state *state __maybe_unused, int argc, char **argv)
 	return ret;
 }
 
-COMMAND(tcpdump, "td", 0, NULL,
+COMMAND(SUBCOMMAND, tcpdump, "td", 0, NULL,
 	"<interface>       \ttcpdump layer 2 traffic on the given interface");
diff --git a/throughputmeter.c b/throughputmeter.c
index 0c5e38a..de20b66 100644
--- a/throughputmeter.c
+++ b/throughputmeter.c
@@ -543,5 +543,5 @@ static int throughputmeter(struct state *state, int argc, char **argv)
 	return ret;
 }
 
-COMMAND(throughputmeter, "tp", COMMAND_FLAG_MESH_IFACE, NULL,
+COMMAND(SUBCOMMAND, throughputmeter, "tp", COMMAND_FLAG_MESH_IFACE, NULL,
 	"<destination>     \tstart a throughput measurement");
diff --git a/traceroute.c b/traceroute.c
index 77c3188..6e325c4 100644
--- a/traceroute.c
+++ b/traceroute.c
@@ -231,5 +231,5 @@ static int traceroute(struct state *state, int argc, char **argv)
 	return ret;
 }
 
-COMMAND(traceroute, "tr", COMMAND_FLAG_MESH_IFACE, NULL,
+COMMAND(SUBCOMMAND, traceroute, "tr", COMMAND_FLAG_MESH_IFACE, NULL,
 	"<destination>     \ttraceroute another batman adv host via layer 2");
diff --git a/translate.c b/translate.c
index 38f26df..ad51ddf 100644
--- a/translate.c
+++ b/translate.c
@@ -78,5 +78,5 @@ static int translate(struct state *state, int argc, char **argv)
 	return ret;
 }
 
-COMMAND(translate, "t", COMMAND_FLAG_MESH_IFACE, NULL,
+COMMAND(SUBCOMMAND, translate, "t", COMMAND_FLAG_MESH_IFACE, NULL,
 	"<destination>     \ttranslate a destination to the originator responsible for it");
-- 
2.11.0


Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 22 Oct 2018 00:54:59 +0200
Message-Id: <20181021225524.8155-14-sven@narfation.org>
In-Reply-To: <20181021225524.8155-1-sven@narfation.org>
References: <20181021225524.8155-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 13/38] batctl: Store usage line next to
 command
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

The single line usage information for a subcommand is the simplest way to
learn how to use a command. It is displayed when either the -h option is
used or when the initial part of the batctl command is incorrect.

Since the commands are no longer registered manually in the main function,
the usage line should also no longer be stored there. Instead add it to the
same file as the command itself.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile          | 13 +++++++------
 bisect_iv.c       |  3 ++-
 gw_mode.c         |  3 ++-
 interface.c       |  3 ++-
 log.c             |  3 ++-
 loglevel.c        |  3 ++-
 main.c            | 31 +++++++++++++++----------------
 main.h            |  8 +++++---
 ping.c            |  3 ++-
 routing_algo.c    |  3 ++-
 statistics.c      |  3 ++-
 tcpdump.c         |  3 ++-
 throughputmeter.c |  3 ++-
 traceroute.c      |  3 ++-
 translate.c       |  3 ++-
 15 files changed, 51 insertions(+), 37 deletions(-)

diff --git a/Makefile b/Makefile
index b4777b7..842795b 100755
--- a/Makefile
+++ b/Makefile
@@ -26,7 +26,13 @@ export CONFIG_BATCTL_BISECT=n
 
 # batctl build
 BINARY_NAME = batctl
+
+OBJ_BISECT = bisect_iv.o
+
 OBJ += bat-hosts.o
+ifeq ($(CONFIG_BATCTL_BISECT),y)
+OBJ += $(OBJ_BISECT)
+endif
 OBJ += debugfs.o
 OBJ += debug.o
 OBJ += functions.o
@@ -47,7 +53,7 @@ OBJ += tcpdump.o
 OBJ += throughputmeter.o
 OBJ += traceroute.o
 OBJ += translate.o
-OBJ_BISECT = bisect_iv.o
+
 MANPAGE = man/batctl.8
 
 # batctl flags and options
@@ -95,11 +101,6 @@ CFLAGS += $(LIBNL_GENL_CFLAGS)
 LDLIBS += $(LIBNL_GENL_LDLIBS)
 
 # standard build tools
-ifeq ($(CONFIG_BATCTL_BISECT),y)
-OBJ += $(OBJ_BISECT)
-CPPFLAGS += -DBATCTL_BISECT
-endif
-
 CC ?= gcc
 RM ?= rm -f
 INSTALL ?= install
diff --git a/bisect_iv.c b/bisect_iv.c
index f87f915..6da82b9 100644
--- a/bisect_iv.c
+++ b/bisect_iv.c
@@ -1595,4 +1595,5 @@ static int bisect_iv(char *mesh_iface __maybe_unused, int argc, char **argv)
 	return ret;
 }
 
-COMMAND(bisect_iv, "bisect_iv", 0);
+COMMAND(bisect_iv, "bisect_iv", 0,
+	"<file1> .. <fileN>\tanalyze given batman iv log files for routing stability");
diff --git a/gw_mode.c b/gw_mode.c
index f07dc99..da22ff0 100644
--- a/gw_mode.c
+++ b/gw_mode.c
@@ -167,4 +167,5 @@ static int gw_mode(char *mesh_iface, int argc, char **argv)
 	return res;
 }
 
-COMMAND(gw_mode, "gw", COMMAND_FLAG_MESH_IFACE);
+COMMAND(gw_mode, "gw", COMMAND_FLAG_MESH_IFACE,
+	"[mode]            \tdisplay or modify the gateway mode");
diff --git a/interface.c b/interface.c
index 485ed0a..d2883a9 100644
--- a/interface.c
+++ b/interface.c
@@ -458,4 +458,5 @@ static int interface(char *mesh_iface, int argc, char **argv)
 	return EXIT_FAILURE;
 }
 
-COMMAND(interface, "if", 0);
+COMMAND(interface, "if", 0,
+	"[add|del iface(s)]\tdisplay or modify the interface settings");
diff --git a/log.c b/log.c
index 585f1c9..e28466d 100644
--- a/log.c
+++ b/log.c
@@ -69,4 +69,5 @@ static int log_print(char *mesh_iface, int argc, char **argv)
 	return res;
 }
 
-COMMAND_NAMED(log, "l", log_print, COMMAND_FLAG_MESH_IFACE);
+COMMAND_NAMED(log, "l", log_print, COMMAND_FLAG_MESH_IFACE,
+	      "                  \tread the log produced by the kernel module");
diff --git a/loglevel.c b/loglevel.c
index 06519e7..3dc1a1c 100644
--- a/loglevel.c
+++ b/loglevel.c
@@ -143,4 +143,5 @@ static int loglevel(char *mesh_iface, int argc, char **argv)
 	return res;
 }
 
-COMMAND(loglevel, "ll", COMMAND_FLAG_MESH_IFACE);
+COMMAND(loglevel, "ll", COMMAND_FLAG_MESH_IFACE,
+	"[level]           \tdisplay or modify the log level");
diff --git a/main.c b/main.c
index f5df477..b9b19de 100644
--- a/main.c
+++ b/main.c
@@ -41,7 +41,9 @@ extern const struct command *__stop___command[];
 
 static void print_usage(void)
 {
+	const struct command **p;
 	int i, opt_indent;
+	char buf[32];
 
 	fprintf(stderr, "Usage: batctl [options] command|debug table [parameters]\n");
 	fprintf(stderr, "options:\n");
@@ -51,7 +53,19 @@ static void print_usage(void)
 	fprintf(stderr, "\n");
 
 	fprintf(stderr, "commands:\n");
-	fprintf(stderr, " \tinterface|if               [add|del iface(s)]\tdisplay or modify the interface settings\n");
+
+	for (p = __start___command; p < __stop___command; p++) {
+		const struct command *cmd = *p;
+
+		if (strcmp(cmd->name, cmd->abbr) == 0)
+			snprintf(buf, sizeof(buf), "%s", cmd->name);
+		else
+			snprintf(buf, sizeof(buf), "%s|%s", cmd->name,
+				 cmd->abbr);
+
+		fprintf(stderr, " \t%-27s%s\n", buf, cmd->usage);
+	}
+
 	for (i = 0; i < BATCTL_SETTINGS_NUM; i++) {
 		fprintf(stderr, " \t%s|%s", batctl_settings[i].opt_long, batctl_settings[i].opt_short);
 		opt_indent = strlen(batctl_settings[i].opt_long) + strlen(batctl_settings[i].opt_short);
@@ -66,26 +80,11 @@ static void print_usage(void)
 			fprintf(stderr, "                                display or modify %s setting\n",
 			       batctl_settings[i].opt_long);
 	}
-	fprintf(stderr, " \tloglevel|ll                [level]           \tdisplay or modify the log level\n");
-	fprintf(stderr, " \tlog|l                                        \tread the log produced by the kernel module\n");
-	fprintf(stderr, " \tgw_mode|gw                 [mode]            \tdisplay or modify the gateway mode\n");
-	fprintf(stderr, " \trouting_algo|ra            [mode]            \tdisplay or modify the routing algorithm\n");
 	fprintf(stderr, "\n");
 
 	fprintf(stderr, "debug tables:                                   \tdisplay the corresponding debug table\n");
 	for (i = 0; i < BATCTL_TABLE_NUM; i++)
 		fprintf(stderr, " \t%s|%s\n", batctl_debug_tables[i].opt_long, batctl_debug_tables[i].opt_short);
-
-	fprintf(stderr, "\n");
-	fprintf(stderr, " \tstatistics|s                                 \tprint mesh statistics\n");
-	fprintf(stderr, " \tping|p                     <destination>     \tping another batman adv host via layer 2\n");
-	fprintf(stderr, " \ttraceroute|tr              <destination>     \ttraceroute another batman adv host via layer 2\n");
-	fprintf(stderr, " \ttcpdump|td                 <interface>       \ttcpdump layer 2 traffic on the given interface\n");
-	printf(" \tthroughputmeter|tp         <destination>     \tstart a throughput measurement\n");
-	fprintf(stderr, " \ttranslate|t                <destination>     \ttranslate a destination to the originator responsible for it\n");
-#ifdef BATCTL_BISECT
-	fprintf(stderr, " \tbisect_iv                  <file1> .. <fileN>\tanalyze given batman iv log files for routing stability\n");
-#endif
 }
 
 static void version(void)
diff --git a/main.h b/main.h
index c461d6b..b39e350 100644
--- a/main.h
+++ b/main.h
@@ -66,19 +66,21 @@ struct command {
 	const char *abbr;
 	int (*handler)(char *mesh_iface, int argc, char **argv);
 	uint32_t flags;
+	const char *usage;
 };
 
-#define COMMAND_NAMED(_name, _abbr, _handler, _flags) \
+#define COMMAND_NAMED(_name, _abbr, _handler, _flags, _usage) \
 	static const struct command command_ ## _name = { \
 		.name = (#_name), \
 		.abbr = _abbr, \
 		.handler = (_handler), \
 		.flags = (_flags), \
+		.usage = (_usage), \
 	}; \
 	static const struct command *__command_ ## _name \
 	__attribute__((__used__)) __attribute__ ((__section__ ("__command"))) = &command_ ## _name
 
-#define COMMAND(_handler, _abbr, _flags) \
-	COMMAND_NAMED(_handler, _abbr, _handler, _flags)
+#define COMMAND(_handler, _abbr, _flags, _usage) \
+	COMMAND_NAMED(_handler, _abbr, _handler, _flags, _usage)
 
 #endif
diff --git a/ping.c b/ping.c
index 2da49d4..efaf011 100644
--- a/ping.c
+++ b/ping.c
@@ -345,4 +345,5 @@ static int ping(char *mesh_iface, int argc, char **argv)
 	return ret;
 }
 
-COMMAND(ping, "p", COMMAND_FLAG_MESH_IFACE);
+COMMAND(ping, "p", COMMAND_FLAG_MESH_IFACE,
+	"<destination>     \tping another batman adv host via layer 2");
diff --git a/routing_algo.c b/routing_algo.c
index 2026224..8cc4ff1 100644
--- a/routing_algo.c
+++ b/routing_algo.c
@@ -126,4 +126,5 @@ static int routing_algo(char *mesh_iface __maybe_unused, int argc, char **argv)
 	return res;
 }
 
-COMMAND(routing_algo, "ra", 0);
+COMMAND(routing_algo, "ra", 0,
+	"[mode]            \tdisplay or modify the routing algorithm");
diff --git a/statistics.c b/statistics.c
index cb6c1e8..908bbaf 100644
--- a/statistics.c
+++ b/statistics.c
@@ -126,4 +126,5 @@ static int statistics(char *mesh_iface, int argc __maybe_unused,
 	return ret;
 }
 
-COMMAND(statistics, "s", COMMAND_FLAG_MESH_IFACE);
+COMMAND(statistics, "s", COMMAND_FLAG_MESH_IFACE,
+	"                  \tprint mesh statistics");
diff --git a/tcpdump.c b/tcpdump.c
index fd2b35a..62e4a64 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -1352,4 +1352,5 @@ static int tcpdump(char *mesh_iface __maybe_unused, int argc, char **argv)
 	return ret;
 }
 
-COMMAND(tcpdump, "td", 0);
+COMMAND(tcpdump, "td", 0,
+	"<interface>       \ttcpdump layer 2 traffic on the given interface");
diff --git a/throughputmeter.c b/throughputmeter.c
index e9e318c..ebd35a6 100644
--- a/throughputmeter.c
+++ b/throughputmeter.c
@@ -543,4 +543,5 @@ static int throughputmeter(char *mesh_iface, int argc, char **argv)
 	return ret;
 }
 
-COMMAND(throughputmeter, "tp", COMMAND_FLAG_MESH_IFACE);
+COMMAND(throughputmeter, "tp", COMMAND_FLAG_MESH_IFACE,
+	"<destination>     \tstart a throughput measurement");
diff --git a/traceroute.c b/traceroute.c
index 1352201..9446bcd 100644
--- a/traceroute.c
+++ b/traceroute.c
@@ -231,4 +231,5 @@ static int traceroute(char *mesh_iface, int argc, char **argv)
 	return ret;
 }
 
-COMMAND(traceroute, "tr", COMMAND_FLAG_MESH_IFACE);
+COMMAND(traceroute, "tr", COMMAND_FLAG_MESH_IFACE,
+	"<destination>     \ttraceroute another batman adv host via layer 2");
diff --git a/translate.c b/translate.c
index d2d34f5..95de9a2 100644
--- a/translate.c
+++ b/translate.c
@@ -78,4 +78,5 @@ static int translate(char *mesh_iface, int argc, char **argv)
 	return ret;
 }
 
-COMMAND(translate, "t", COMMAND_FLAG_MESH_IFACE);
+COMMAND(translate, "t", COMMAND_FLAG_MESH_IFACE,
+	"<destination>     \ttranslate a destination to the originator responsible for it");
-- 
2.19.1


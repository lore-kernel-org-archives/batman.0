Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 25 Oct 2018 18:22:17 +0200
Message-Id: <20181025162245.19389-15-sven@narfation.org>
In-Reply-To: <20181025162245.19389-1-sven@narfation.org>
References: <20181025162245.19389-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v3 14/42] batctl: Prepare command
 infrastructure for shared functions
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

The command structure first mapped from one name and abbrevation to a
single function of batctl. But there can be commands which share a
significant portion of the code. To support these kind of things better,
add an additional arg pointer to the command structure. The handler then
receive a state struct from the main function instead of the mesh_iface.

The command implementation can then use the state to retrieve both the
mesh_iface and the cmd with the arg pointer.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bisect_iv.c       |  4 ++--
 gw_mode.c         |  6 +++---
 interface.c       | 20 ++++++++++----------
 log.c             |  6 +++---
 loglevel.c        |  6 +++---
 main.c            | 29 +++++++++++++++++++----------
 main.h            | 15 +++++++++++----
 ping.c            |  8 ++++----
 routing_algo.c    |  4 ++--
 statistics.c      |  6 +++---
 tcpdump.c         |  4 ++--
 throughputmeter.c |  8 ++++----
 traceroute.c      |  8 ++++----
 translate.c       |  6 +++---
 14 files changed, 73 insertions(+), 57 deletions(-)

diff --git a/bisect_iv.c b/bisect_iv.c
index 6da82b9..c6fc708 100644
--- a/bisect_iv.c
+++ b/bisect_iv.c
@@ -1441,7 +1441,7 @@ static int get_orig_addr(char *orig_name, char *orig_addr)
 	return 0;
 }
 
-static int bisect_iv(char *mesh_iface __maybe_unused, int argc, char **argv)
+static int bisect_iv(struct state *state __maybe_unused, int argc, char **argv)
 {
 	int ret = EXIT_FAILURE, res, optchar, found_args = 1;
 	int read_opt = USE_BAT_HOSTS, num_parsed_files;
@@ -1595,5 +1595,5 @@ static int bisect_iv(char *mesh_iface __maybe_unused, int argc, char **argv)
 	return ret;
 }
 
-COMMAND(bisect_iv, "bisect_iv", 0,
+COMMAND(bisect_iv, "bisect_iv", 0, NULL,
 	"<file1> .. <fileN>\tanalyze given batman iv log files for routing stability");
diff --git a/gw_mode.c b/gw_mode.c
index da22ff0..bd530d5 100644
--- a/gw_mode.c
+++ b/gw_mode.c
@@ -45,7 +45,7 @@ static void gw_mode_usage(void)
 	fprintf(stderr, " \t -h print this help\n");
 }
 
-static int gw_mode(char *mesh_iface, int argc, char **argv)
+static int gw_mode(struct state *state, int argc, char **argv)
 {
 	int optchar, res = EXIT_FAILURE;
 	char *path_buff, gw_mode;
@@ -68,7 +68,7 @@ static int gw_mode(char *mesh_iface, int argc, char **argv)
 		return EXIT_FAILURE;
 	}
 
-	snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT, mesh_iface);
+	snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT, state->mesh_iface);
 
 	if (argc == 1) {
 		res = read_file(path_buff, SYS_GW_MODE, USE_READ_BUFF, 0, 0, 0);
@@ -167,5 +167,5 @@ static int gw_mode(char *mesh_iface, int argc, char **argv)
 	return res;
 }
 
-COMMAND(gw_mode, "gw", COMMAND_FLAG_MESH_IFACE,
+COMMAND(gw_mode, "gw", COMMAND_FLAG_MESH_IFACE, NULL,
 	"[mode]            \tdisplay or modify the gateway mode");
diff --git a/interface.c b/interface.c
index d2883a9..5f69cb3 100644
--- a/interface.c
+++ b/interface.c
@@ -297,7 +297,7 @@ static int set_master_interface(const char *iface, unsigned int ifmaster)
 	return err;
 }
 
-static int interface(char *mesh_iface, int argc, char **argv)
+static int interface(struct state *state, int argc, char **argv)
 {
 	int i, optchar;
 	int ret;
@@ -327,7 +327,7 @@ static int interface(char *mesh_iface, int argc, char **argv)
 	rest_argv = &argv[optind];
 
 	if (rest_argc == 0)
-		return print_interfaces(mesh_iface);
+		return print_interfaces(state->mesh_iface);
 
 	check_root_or_die("batctl interface");
 
@@ -370,7 +370,7 @@ static int interface(char *mesh_iface, int argc, char **argv)
 
 	switch (rest_argv[0][0]) {
 	case 'c':
-		ret = create_interface(mesh_iface);
+		ret = create_interface(state->mesh_iface);
 		if (ret < 0) {
 			fprintf(stderr,
 				"Error - failed to add create batman-adv interface: %s\n",
@@ -379,7 +379,7 @@ static int interface(char *mesh_iface, int argc, char **argv)
 		}
 		return EXIT_SUCCESS;
 	case 'D':
-		ret = destroy_interface(mesh_iface);
+		ret = destroy_interface(state->mesh_iface);
 		if (ret < 0) {
 			fprintf(stderr,
 				"Error - failed to destroy batman-adv interface: %s\n",
@@ -392,9 +392,9 @@ static int interface(char *mesh_iface, int argc, char **argv)
 	}
 
 	/* get index of batman-adv interface - or try to create it */
-	ifmaster = if_nametoindex(mesh_iface);
+	ifmaster = if_nametoindex(state->mesh_iface);
 	if (!manual_mode && !ifmaster && rest_argv[0][0] == 'a') {
-		ret = create_interface(mesh_iface);
+		ret = create_interface(state->mesh_iface);
 		if (ret < 0) {
 			fprintf(stderr,
 				"Error - failed to create batman-adv interface: %s\n",
@@ -402,7 +402,7 @@ static int interface(char *mesh_iface, int argc, char **argv)
 			goto err;
 		}
 
-		ifmaster = if_nametoindex(mesh_iface);
+		ifmaster = if_nametoindex(state->mesh_iface);
 	}
 
 	if (!ifmaster) {
@@ -447,9 +447,9 @@ static int interface(char *mesh_iface, int argc, char **argv)
 
 	/* check if there is no interface left and then destroy mesh_iface */
 	if (!manual_mode && rest_argv[0][0] == 'd') {
-		cnt = count_interfaces(mesh_iface);
+		cnt = count_interfaces(state->mesh_iface);
 		if (cnt == 0)
-			destroy_interface(mesh_iface);
+			destroy_interface(state->mesh_iface);
 	}
 
 	return EXIT_SUCCESS;
@@ -458,5 +458,5 @@ static int interface(char *mesh_iface, int argc, char **argv)
 	return EXIT_FAILURE;
 }
 
-COMMAND(interface, "if", 0,
+COMMAND(interface, "if", 0, NULL,
 	"[add|del iface(s)]\tdisplay or modify the interface settings");
diff --git a/log.c b/log.c
index e28466d..b4f0b86 100644
--- a/log.c
+++ b/log.c
@@ -36,7 +36,7 @@ static void log_usage(void)
 	fprintf(stderr, " \t -n don't replace mac addresses with bat-host names\n");
 }
 
-static int log_print(char *mesh_iface, int argc, char **argv)
+static int log_print(struct state *state, int argc, char **argv)
 {
 	int optchar, res, read_opt = USE_BAT_HOSTS | LOG_MODE;
 	char full_path[MAX_PATH+1];
@@ -64,10 +64,10 @@ static int log_print(char *mesh_iface, int argc, char **argv)
 		return EXIT_FAILURE;
 	}
 
-	debugfs_make_path(DEBUG_BATIF_PATH_FMT "/", mesh_iface, full_path, sizeof(full_path));
+	debugfs_make_path(DEBUG_BATIF_PATH_FMT "/", state->mesh_iface, full_path, sizeof(full_path));
 	res = read_file(full_path, DEBUG_LOG, read_opt, 0, 0, 0);
 	return res;
 }
 
-COMMAND_NAMED(log, "l", log_print, COMMAND_FLAG_MESH_IFACE,
+COMMAND_NAMED(log, "l", log_print, COMMAND_FLAG_MESH_IFACE, NULL,
 	      "                  \tread the log produced by the kernel module");
diff --git a/loglevel.c b/loglevel.c
index 3dc1a1c..7a61524 100644
--- a/loglevel.c
+++ b/loglevel.c
@@ -47,7 +47,7 @@ static void log_level_usage(void)
 	fprintf(stderr, " \t tp      Messages related to throughput meter\n");
 }
 
-static int loglevel(char *mesh_iface, int argc, char **argv)
+static int loglevel(struct state *state, int argc, char **argv)
 {
 	int optchar, res = EXIT_FAILURE;
 	int log_level = 0;
@@ -72,7 +72,7 @@ static int loglevel(char *mesh_iface, int argc, char **argv)
 		return EXIT_FAILURE;
 	}
 
-	snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT, mesh_iface);
+	snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT, state->mesh_iface);
 
 	if (argc != 1) {
 		check_root_or_die("batctl loglevel");
@@ -143,5 +143,5 @@ static int loglevel(char *mesh_iface, int argc, char **argv)
 	return res;
 }
 
-COMMAND(loglevel, "ll", COMMAND_FLAG_MESH_IFACE,
+COMMAND(loglevel, "ll", COMMAND_FLAG_MESH_IFACE, NULL,
 	"[level]           \tdisplay or modify the log level");
diff --git a/main.c b/main.c
index b9b19de..e20f914 100644
--- a/main.c
+++ b/main.c
@@ -127,7 +127,10 @@ int main(int argc, char **argv)
 {
 	const struct command *cmd;
 	int i, ret = EXIT_FAILURE;
-	char *mesh_iface = mesh_dfl_iface;
+	struct state state = {
+		.mesh_iface = mesh_dfl_iface,
+		.cmd = NULL,
+	};
 	int opt;
 
 	while ((opt = getopt(argc, argv, "+hm:v")) != -1) {
@@ -137,13 +140,13 @@ int main(int argc, char **argv)
 			exit(EXIT_SUCCESS);
 			break;
 		case 'm':
-			if (mesh_iface != mesh_dfl_iface) {
+			if (state.mesh_iface != mesh_dfl_iface) {
 				fprintf(stderr,
 					"Error - multiple mesh interfaces specified\n");
 				goto err;
 			}
 
-			mesh_iface = argv[2];
+			state.mesh_iface = argv[2];
 			break;
 		case 'v':
 			version();
@@ -163,16 +166,22 @@ int main(int argc, char **argv)
 	optind = 0;
 
 	if ((cmd = find_command(argv[0]))) {
+		state.cmd = cmd;
+
 		if (cmd->flags & COMMAND_FLAG_MESH_IFACE &&
-		    check_mesh_iface(mesh_iface) < 0) {
-			fprintf(stderr, "Error - interface %s is not present or not a batman-adv interface\n", mesh_iface);
+		    check_mesh_iface(state.mesh_iface) < 0) {
+			fprintf(stderr,
+				"Error - interface %s is not present or not a batman-adv interface\n",
+				state.mesh_iface);
 			exit(EXIT_FAILURE);
 		}
 
-		ret = cmd->handler(mesh_iface, argc, argv);
+		ret = cmd->handler(&state, argc, argv);
 	} else {
-		if (check_mesh_iface(mesh_iface) < 0) {
-			fprintf(stderr, "Error - interface %s is not present or not a batman-adv interface\n", mesh_iface);
+		if (check_mesh_iface(state.mesh_iface) < 0) {
+			fprintf(stderr,
+				"Error - interface %s is not present or not a batman-adv interface\n",
+				state.mesh_iface);
 			exit(EXIT_FAILURE);
 		}
 
@@ -181,7 +190,7 @@ int main(int argc, char **argv)
 			    (strcmp(argv[0], batctl_settings[i].opt_short) != 0))
 				continue;
 
-			ret = handle_sys_setting(mesh_iface, i, argc, argv);
+			ret = handle_sys_setting(state.mesh_iface, i, argc, argv);
 			goto out;
 		}
 
@@ -190,7 +199,7 @@ int main(int argc, char **argv)
 			    (strcmp(argv[0], batctl_debug_tables[i].opt_short) != 0))
 				continue;
 
-			ret = handle_debug_table(mesh_iface, i, argc, argv);
+			ret = handle_debug_table(state.mesh_iface, i, argc, argv);
 			goto out;
 		}
 
diff --git a/main.h b/main.h
index b39e350..77eb432 100644
--- a/main.h
+++ b/main.h
@@ -61,26 +61,33 @@ enum command_flags {
 	COMMAND_FLAG_MESH_IFACE = BIT(0),
 };
 
+struct state {
+	char *mesh_iface;
+	const struct command *cmd;
+};
+
 struct command {
 	const char *name;
 	const char *abbr;
-	int (*handler)(char *mesh_iface, int argc, char **argv);
+	int (*handler)(struct state *state, int argc, char **argv);
 	uint32_t flags;
+	void *arg;
 	const char *usage;
 };
 
-#define COMMAND_NAMED(_name, _abbr, _handler, _flags, _usage) \
+#define COMMAND_NAMED(_name, _abbr, _handler, _flags, _arg, _usage) \
 	static const struct command command_ ## _name = { \
 		.name = (#_name), \
 		.abbr = _abbr, \
 		.handler = (_handler), \
 		.flags = (_flags), \
+		.arg = (_arg), \
 		.usage = (_usage), \
 	}; \
 	static const struct command *__command_ ## _name \
 	__attribute__((__used__)) __attribute__ ((__section__ ("__command"))) = &command_ ## _name
 
-#define COMMAND(_handler, _abbr, _flags, _usage) \
-	COMMAND_NAMED(_handler, _abbr, _handler, _flags, _usage)
+#define COMMAND(_handler, _abbr, _flags, _arg, _usage) \
+	COMMAND_NAMED(_handler, _abbr, _handler, _flags, _arg, _usage)
 
 #endif
diff --git a/ping.c b/ping.c
index efaf011..24af0e8 100644
--- a/ping.c
+++ b/ping.c
@@ -72,7 +72,7 @@ static void sig_handler(int sig)
 	}
 }
 
-static int ping(char *mesh_iface, int argc, char **argv)
+static int ping(struct state *state, int argc, char **argv)
 {
 	struct batadv_icmp_packet_rr icmp_packet_out, icmp_packet_in;
 	struct timeval tv;
@@ -152,7 +152,7 @@ static int ping(char *mesh_iface, int argc, char **argv)
 	}
 
 	if (!disable_translate_mac)
-		dst_mac = translate_mac(mesh_iface, dst_mac);
+		dst_mac = translate_mac(state->mesh_iface, dst_mac);
 
 	mac_string = ether_ntoa_long(dst_mac);
 	signal(SIGINT, sig_handler);
@@ -199,7 +199,7 @@ static int ping(char *mesh_iface, int argc, char **argv)
 
 		icmp_packet_out.seqno = htons(++seq_counter);
 
-		res = icmp_interface_write(mesh_iface,
+		res = icmp_interface_write(state->mesh_iface,
 					   (struct batadv_icmp_header *)&icmp_packet_out,
 					   packet_len);
 		if (res < 0) {
@@ -345,5 +345,5 @@ static int ping(char *mesh_iface, int argc, char **argv)
 	return ret;
 }
 
-COMMAND(ping, "p", COMMAND_FLAG_MESH_IFACE,
+COMMAND(ping, "p", COMMAND_FLAG_MESH_IFACE, NULL,
 	"<destination>     \tping another batman adv host via layer 2");
diff --git a/routing_algo.c b/routing_algo.c
index 8cc4ff1..30e588b 100644
--- a/routing_algo.c
+++ b/routing_algo.c
@@ -41,7 +41,7 @@ static void ra_mode_usage(void)
 	fprintf(stderr, " \t -h print this help\n");
 }
 
-static int routing_algo(char *mesh_iface __maybe_unused, int argc, char **argv)
+static int routing_algo(struct state *state __maybe_unused, int argc, char **argv)
 {
 	DIR *iface_base_dir;
 	struct dirent *iface_dir;
@@ -126,5 +126,5 @@ static int routing_algo(char *mesh_iface __maybe_unused, int argc, char **argv)
 	return res;
 }
 
-COMMAND(routing_algo, "ra", 0,
+COMMAND(routing_algo, "ra", 0, NULL,
 	"[mode]            \tdisplay or modify the routing algorithm");
diff --git a/statistics.c b/statistics.c
index 908bbaf..26ffe44 100644
--- a/statistics.c
+++ b/statistics.c
@@ -102,14 +102,14 @@ static int statistics_custom_get(int fd, struct ifreq *ifr)
 	return ret;
 }
 
-static int statistics(char *mesh_iface, int argc __maybe_unused,
+static int statistics(struct state *state, int argc __maybe_unused,
 		      char **argv __maybe_unused)
 {
 	struct ifreq ifr;
 	int fd = -1, ret = EXIT_FAILURE;
 
 	memset(&ifr, 0, sizeof(ifr));
-	strncpy(ifr.ifr_name, mesh_iface, sizeof(ifr.ifr_name));
+	strncpy(ifr.ifr_name, state->mesh_iface, sizeof(ifr.ifr_name));
 	ifr.ifr_name[sizeof(ifr.ifr_name) - 1] = '\0';
 
 	fd = socket(AF_INET, SOCK_DGRAM, 0);
@@ -126,5 +126,5 @@ static int statistics(char *mesh_iface, int argc __maybe_unused,
 	return ret;
 }
 
-COMMAND(statistics, "s", COMMAND_FLAG_MESH_IFACE,
+COMMAND(statistics, "s", COMMAND_FLAG_MESH_IFACE, NULL,
 	"                  \tprint mesh statistics");
diff --git a/tcpdump.c b/tcpdump.c
index 62e4a64..5c93842 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -1210,7 +1210,7 @@ static void sig_handler(int sig)
 	}
 }
 
-static int tcpdump(char *mesh_iface __maybe_unused, int argc, char **argv)
+static int tcpdump(struct state *state __maybe_unused, int argc, char **argv)
 {
 	struct timeval tv;
 	struct dump_if *dump_if, *dump_if_tmp;
@@ -1352,5 +1352,5 @@ static int tcpdump(char *mesh_iface __maybe_unused, int argc, char **argv)
 	return ret;
 }
 
-COMMAND(tcpdump, "td", 0,
+COMMAND(tcpdump, "td", 0, NULL,
 	"<interface>       \ttcpdump layer 2 traffic on the given interface");
diff --git a/throughputmeter.c b/throughputmeter.c
index ebd35a6..0c5e38a 100644
--- a/throughputmeter.c
+++ b/throughputmeter.c
@@ -388,7 +388,7 @@ static void tp_meter_usage(void)
 	fprintf(stderr, "\t -n don't convert addresses to bat-host names\n");
 }
 
-static int throughputmeter(char *mesh_iface, int argc, char **argv)
+static int throughputmeter(struct state *state, int argc, char **argv)
 {
 	struct bat_host *bat_host;
 	uint64_t throughput;
@@ -458,7 +458,7 @@ static int throughputmeter(char *mesh_iface, int argc, char **argv)
 		dst_string = ether_ntoa_long(dst_mac);
 
 	/* for sighandler */
-	tp_mesh_iface = mesh_iface;
+	tp_mesh_iface = state->mesh_iface;
 	signal(SIGINT, tp_sig_handler);
 	signal(SIGTERM, tp_sig_handler);
 
@@ -466,7 +466,7 @@ static int throughputmeter(char *mesh_iface, int argc, char **argv)
 	if (!listen_sock)
 		goto out;
 
-	ret = tp_meter_start(mesh_iface, dst_mac, time, &cookie);
+	ret = tp_meter_start(state->mesh_iface, dst_mac, time, &cookie);
 	if (ret < 0) {
 		printf("Failed to send tp_meter request to kernel: %d\n", ret);
 		goto out;
@@ -543,5 +543,5 @@ static int throughputmeter(char *mesh_iface, int argc, char **argv)
 	return ret;
 }
 
-COMMAND(throughputmeter, "tp", COMMAND_FLAG_MESH_IFACE,
+COMMAND(throughputmeter, "tp", COMMAND_FLAG_MESH_IFACE, NULL,
 	"<destination>     \tstart a throughput measurement");
diff --git a/traceroute.c b/traceroute.c
index 9446bcd..77c3188 100644
--- a/traceroute.c
+++ b/traceroute.c
@@ -55,7 +55,7 @@ static void traceroute_usage(void)
 	fprintf(stderr, " \t -T don't try to translate mac to originator address\n");
 }
 
-static int traceroute(char *mesh_iface, int argc, char **argv)
+static int traceroute(struct state *state, int argc, char **argv)
 {
 	struct batadv_icmp_packet icmp_packet_out, icmp_packet_in;
 	struct bat_host *bat_host;
@@ -113,7 +113,7 @@ static int traceroute(char *mesh_iface, int argc, char **argv)
 	}
 
 	if (!disable_translate_mac)
-		dst_mac = translate_mac(mesh_iface, dst_mac);
+		dst_mac = translate_mac(state->mesh_iface, dst_mac);
 
 	mac_string = ether_ntoa_long(dst_mac);
 
@@ -146,7 +146,7 @@ static int traceroute(char *mesh_iface, int argc, char **argv)
 			icmp_packet_out.seqno = htons(++seq_counter);
 			time_delta[i] = 0.0;
 
-			res = icmp_interface_write(mesh_iface,
+			res = icmp_interface_write(state->mesh_iface,
 					   (struct batadv_icmp_header *)&icmp_packet_out,
 					   sizeof(icmp_packet_out));
 			if (res < 0) {
@@ -231,5 +231,5 @@ static int traceroute(char *mesh_iface, int argc, char **argv)
 	return ret;
 }
 
-COMMAND(traceroute, "tr", COMMAND_FLAG_MESH_IFACE,
+COMMAND(traceroute, "tr", COMMAND_FLAG_MESH_IFACE, NULL,
 	"<destination>     \ttraceroute another batman adv host via layer 2");
diff --git a/translate.c b/translate.c
index 95de9a2..38f26df 100644
--- a/translate.c
+++ b/translate.c
@@ -33,7 +33,7 @@ static void translate_usage(void)
 	fprintf(stderr, "Usage: batctl [options] translate mac|bat-host|host_name|IPv4_address\n");
 }
 
-static int translate(char *mesh_iface, int argc, char **argv)
+static int translate(struct state *state, int argc, char **argv)
 {
 	struct ether_addr *dst_mac = NULL;
 	struct bat_host *bat_host;
@@ -64,7 +64,7 @@ static int translate(char *mesh_iface, int argc, char **argv)
 		}
 	}
 
-	dst_mac = translate_mac(mesh_iface, dst_mac);
+	dst_mac = translate_mac(state->mesh_iface, dst_mac);
 	if (dst_mac) {
 		mac_string = ether_ntoa_long(dst_mac);
 		printf("%s\n", mac_string);
@@ -78,5 +78,5 @@ static int translate(char *mesh_iface, int argc, char **argv)
 	return ret;
 }
 
-COMMAND(translate, "t", COMMAND_FLAG_MESH_IFACE,
+COMMAND(translate, "t", COMMAND_FLAG_MESH_IFACE, NULL,
 	"<destination>     \ttranslate a destination to the originator responsible for it");
-- 
2.11.0


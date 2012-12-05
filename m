Return-Path: <moritzwarning@web.de>
Message-ID: <50BE9250.2050303@web.de>
Date: Wed, 05 Dec 2012 01:16:16 +0100
From: Moritz Warning <moritzwarning@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] [PATCH] batctl: output errors to stderr
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

batctl outputs many errors to stdout instead of stderr.
This patch corrects this behavior by redirecting errors
and the usage texts to stderr.

Signed-off-by: Moritz Warning <moritzwarning at web.de>
---
From: Moritz Warning <moritzwarning@web.de>
Date: Wed, 5 Dec 2012 00:59:21 +0100
Subject: [PATCH] batctl: output errors to stderr
Context: http://www.open-mesh.org/issues/167

---
 bisect_iv.c  |   34 ++++++++++++-------------
 debug.c      |   36 +++++++++++++-------------
 debugfs.c    |    2 +-
 functions.c  |   18 ++++++-------
 ioctl.c      |   10 ++++----
 main.c       |   68 +++++++++++++++++++++++++------------------------
 ping.c       |   30 +++++++++++-----------
 sys.c        |   80 +++++++++++++++++++++++++++++-----------------------------
 tcpdump.c    |   34 ++++++++++++-------------
 traceroute.c |   28 ++++++++++----------
 translate.c  |    2 +-
 vis.c        |    8 +++---
 12 files changed, 176 insertions(+), 174 deletions(-)

diff --git a/bisect_iv.c b/bisect_iv.c
index 09171fb..49fcb9e 100644
--- a/bisect_iv.c
+++ b/bisect_iv.c
@@ -37,15 +37,15 @@ static struct bat_node *curr_bat_node = NULL;
 
 static void bisect_iv_usage(void)
 {
-	printf("Usage: batctl bisect_iv [parameters] <file1> <file2> .. <fileN>\n");
-	printf("parameters:\n");
-	printf(" \t -h print this help\n");
-	printf(" \t -l run a loop detection of given mac address or bat-host (default)\n");
-	printf(" \t -n don't convert addresses to bat-host names\n");
-	printf(" \t -o only display orig events that affect given mac address or bat-host\n");
-	printf(" \t -r print routing tables of given mac address or bat-host\n");
-	printf(" \t -s seqno range to limit the output\n");
-	printf(" \t -t trace seqnos of given mac address or bat-host\n");
+	fprintf(stderr, "Usage: batctl bisect_iv [parameters] <file1> <file2> .. <fileN>\n");
+	fprintf(stderr, "parameters:\n");
+	fprintf(stderr, " \t -h print this help\n");
+	fprintf(stderr, " \t -l run a loop detection of given mac address or bat-host (default)\n");
+	fprintf(stderr, " \t -n don't convert addresses to bat-host names\n");
+	fprintf(stderr, " \t -o only display orig events that affect given mac address or bat-host\n");
+	fprintf(stderr, " \t -r print routing tables of given mac address or bat-host\n");
+	fprintf(stderr, " \t -s seqno range to limit the output\n");
+	fprintf(stderr, " \t -t trace seqnos of given mac address or bat-host\n");
 }
 
 static int compare_name(void *data1, void *data2)
@@ -1425,7 +1425,7 @@ static int get_orig_addr(char *orig_name, char *orig_addr)
 	orig_mac = ether_aton(orig_name_tmp);
 
 	if (!orig_mac) {
-		printf("Error - the originator is not a mac address or bat-host name: %s\n", orig_name);
+		fprintf(stderr, "Error - the originator is not a mac address or bat-host name: %s\n", orig_name);
 		goto err;
 	}
 
@@ -1509,7 +1509,7 @@ int bisect_iv(int argc, char **argv)
 	}
 
 	if (argc <= found_args + 1) {
-		printf("Error - need at least 2 log files to compare\n");
+		fprintf(stderr, "Error - need at least 2 log files to compare\n");
 		bisect_iv_usage();
 		goto err;
 	}
@@ -1517,7 +1517,7 @@ int bisect_iv(int argc, char **argv)
 	node_hash = hash_new(64, compare_name, choose_name);
 
 	if (!node_hash) {
-		printf("Error - could not create node hash table\n");
+		fprintf(stderr, "Error - could not create node hash table\n");
 		goto err;
 	}
 
@@ -1525,13 +1525,13 @@ int bisect_iv(int argc, char **argv)
 	num_parsed_files = 0;
 
 	if ((rt_orig_ptr) && (trace_orig_ptr)) {
-		printf("Error - the 'print routing table' option can't be used together with the the 'trace seqno' option\n");
+		fprintf(stderr, "Error - the 'print routing table' option can't be used together with the the 'trace seqno' option\n");
 		goto err;
 	} else if ((loop_orig_ptr) && (trace_orig_ptr)) {
-		printf("Error - the 'loop detection' option can't be used together with the the 'trace seqno' option\n");
+		fprintf(stderr, "Error - the 'loop detection' option can't be used together with the the 'trace seqno' option\n");
 		goto err;
 	} else if ((loop_orig_ptr) && (rt_orig_ptr)) {
-		printf("Error - the 'loop detection' option can't be used together with the the 'print routing table' option\n");
+		fprintf(stderr, "Error - the 'loop detection' option can't be used together with the the 'print routing table' option\n");
 		goto err;
 	} else if (rt_orig_ptr) {
 		res = get_orig_addr(rt_orig_ptr, orig);
@@ -1555,7 +1555,7 @@ int bisect_iv(int argc, char **argv)
 		seqno_max = seqno_min;
 
 	if (seqno_min > seqno_max) {
-		printf("Error - the sequence range minimum (%lli) should be smaller than the maximum (%lli)\n",
+		fprintf(stderr, "Error - the sequence range minimum (%lli) should be smaller than the maximum (%lli)\n",
 		       seqno_min, seqno_max);
 		goto err;
 	}
@@ -1577,7 +1577,7 @@ int bisect_iv(int argc, char **argv)
 	}
 
 	if (num_parsed_files < 2) {
-		printf("Error - need at least 2 log files to compare\n");
+		fprintf(stderr, "Error - need at least 2 log files to compare\n");
 		goto err;
 	}
 
diff --git a/debug.c b/debug.c
index 260448b..cdcbd39 100644
--- a/debug.c
+++ b/debug.c
@@ -80,16 +80,16 @@ const struct debug_table_data batctl_debug_tables[BATCTL_TABLE_NUM] = {
 
 void debug_table_usage(int debug_table)
 {
-	printf("Usage: batctl [options] %s|%s [parameters]\n",
+	fprintf(stderr, "Usage: batctl [options] %s|%s [parameters]\n",
 	       batctl_debug_tables[debug_table].opt_long, batctl_debug_tables[debug_table].opt_short);
-	printf("parameters:\n");
-	printf(" \t -h print this help\n");
-	printf(" \t -n don't replace mac addresses with bat-host names\n");
-	printf(" \t -H don't show the header\n");
-	printf(" \t -w [interval] watch mode - refresh the table continuously\n");
+	fprintf(stderr, "parameters:\n");
+	fprintf(stderr, " \t -h print this help\n");
+	fprintf(stderr, " \t -n don't replace mac addresses with bat-host names\n");
+	fprintf(stderr, " \t -H don't show the header\n");
+	fprintf(stderr, " \t -w [interval] watch mode - refresh the table continuously\n");
 
 	if (debug_table == BATCTL_TABLE_ORIGINATORS)
-		printf(" \t -t timeout interval - don't print originators not seen for x.y seconds \n");
+		fprintf(stderr, " \t -t timeout interval - don't print originators not seen for x.y seconds \n");
 }
 
 int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv)
@@ -117,20 +117,20 @@ int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv)
 			}
 
 			if (!sscanf(optarg, "%f", &watch_interval)) {
-				printf("Error - provided argument of '-%c' is not a number\n", optchar);
+				fprintf(stderr, "Error - provided argument of '-%c' is not a number\n", optchar);
 				return EXIT_FAILURE;
 			}
 			break;
 		case 't':
 			if (debug_table != BATCTL_TABLE_ORIGINATORS) {
-				printf("Error - unrecognised option '-%c'\n", optchar);
+				fprintf(stderr, "Error - unrecognised option '-%c'\n", optchar);
 				debug_table_usage(debug_table);
 				return EXIT_FAILURE;
 			}
 
 			read_opt |= NO_OLD_ORIGS;
 			if (!sscanf(optarg, "%f", &orig_timeout)) {
-				printf("Error - provided argument of '-%c' is not a number\n", optchar);
+				fprintf(stderr, "Error - provided argument of '-%c' is not a number\n", optchar);
 				return EXIT_FAILURE;
 			}
 			break;
@@ -139,14 +139,14 @@ int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv)
 			break;
 		case '?':
 			if (optopt == 't')
-				printf("Error - option '-t' needs a number as argument\n");
+				fprintf(stderr, "Error - option '-t' needs a number as argument\n");
 
 			else if (optopt == 'w') {
 				read_opt |= CLR_CONT_READ;
 				break;
 			}
 			else
-				printf("Error - unrecognised option: '-%c'\n", optopt);
+				fprintf(stderr, "Error - unrecognised option: '-%c'\n", optopt);
 
 			return EXIT_FAILURE;
 		default:
@@ -157,7 +157,7 @@ int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv)
 
 	debugfs_mnt = debugfs_mount(NULL);
 	if (!debugfs_mnt) {
-		printf("Error - can't mount or find debugfs\n");
+		fprintf(stderr, "Error - can't mount or find debugfs\n");
 		return EXIT_FAILURE;
 	}
 
@@ -169,10 +169,10 @@ int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv)
 
 static void log_usage(void)
 {
-	printf("Usage: batctl [options] log [parameters]\n");
-	printf("parameters:\n");
-	printf(" \t -h print this help\n");
-	printf(" \t -n don't replace mac addresses with bat-host names\n");
+	fprintf(stderr, "Usage: batctl [options] log [parameters]\n");
+	fprintf(stderr, "parameters:\n");
+	fprintf(stderr, " \t -h print this help\n");
+	fprintf(stderr, " \t -n don't replace mac addresses with bat-host names\n");
 }
 
 int log_print(char *mesh_iface, int argc, char **argv)
@@ -197,7 +197,7 @@ int log_print(char *mesh_iface, int argc, char **argv)
 
 	debugfs_mnt = debugfs_mount(NULL);
 	if (!debugfs_mnt) {
-		printf("Error - can't mount or find debugfs\n");
+		fprintf(stderr, "Error - can't mount or find debugfs\n");
 		return EXIT_FAILURE;
 	}
 
diff --git a/debugfs.c b/debugfs.c
index 9fc6f42..bfedcfe 100644
--- a/debugfs.c
+++ b/debugfs.c
@@ -85,7 +85,7 @@ const char *debugfs_find_mountpoint(void)
 	/* give up and parse /proc/mounts */
 	fp = fopen("/proc/mounts", "r");
 	if (fp == NULL) {
-		printf("Error - can't open /proc/mounts for read: %s\n",
+		fprintf(stderr, "Error - can't open /proc/mounts for read: %s\n",
 		       strerror(errno));
 		return NULL;
 	}
diff --git a/functions.c b/functions.c
index 57c2bba..516d29f 100644
--- a/functions.c
+++ b/functions.c
@@ -130,20 +130,20 @@ static void file_open_problem_dbg(char *dir, char *fname, char *full_path)
 
 	if (strstr(dir, "/sys/")) {
 		if (stat("/sys/", &st) != 0) {
-			printf("Error - the folder '/sys/' was not found on the system\n");
-			printf("Please make sure that the sys filesystem is properly mounted\n");
+			fprintf(stderr, "Error - the folder '/sys/' was not found on the system\n");
+			fprintf(stderr, "Please make sure that the sys filesystem is properly mounted\n");
 			return;
 		}
 	}
 
 	if (!file_exists(module_ver_path)) {
-		printf("Error - batman-adv module has not been loaded\n");
+		fprintf(stderr, "Error - batman-adv module has not been loaded\n");
 		return;
 	}
 
 	if (!file_exists(dir)) {
-		printf("Error - mesh has not been enabled yet\n");
-		printf("Activate your mesh by adding interfaces to batman-adv\n");
+		fprintf(stderr, "Error - mesh has not been enabled yet\n");
+		fprintf(stderr, "Activate your mesh by adding interfaces to batman-adv\n");
 		return;
 	}
 
@@ -154,10 +154,10 @@ static void file_open_problem_dbg(char *dir, char *fname, char *full_path)
 		break;
 	}
 
-	printf("Error - can't open file '%s': %s\n", full_path, strerror(errno));
+	fprintf(stderr, "Error - can't open file '%s': %s\n", full_path, strerror(errno));
 	if (*ptr) {
-		printf("The option you called seems not to be compiled into your batman-adv kernel module.\n");
-		printf("Consult the README if you wish to learn more about compiling options into batman-adv.\n");
+		fprintf(stderr, "The option you called seems not to be compiled into your batman-adv kernel module.\n");
+		fprintf(stderr, "Consult the README if you wish to learn more about compiling options into batman-adv.\n");
 	}
 }
 
@@ -318,7 +318,7 @@ int write_file(char *dir, char *fname, char *arg1, char *arg2)
 		write_len = write(fd, arg1, strlen(arg1) + 1);
 
 	if (write_len < 0) {
-		printf("Error - can't write to file '%s': %s\n", full_path, strerror(errno));
+		fprintf(stderr, "Error - can't write to file '%s': %s\n", full_path, strerror(errno));
 		goto out;
 	}
 
diff --git a/ioctl.c b/ioctl.c
index 5056d2f..4347c20 100644
--- a/ioctl.c
+++ b/ioctl.c
@@ -50,7 +50,7 @@ static int statistics_custom_get(int fd, struct ifreq *ifr)
 	ifr->ifr_data = (caddr_t)&drvinfo;
 	err = ioctl(fd, SIOCETHTOOL, ifr);
 	if (err < 0) {
-		printf("Error - can't open driver information: %s\n", strerror(errno));
+		fprintf(stderr, "Error - can't open driver information: %s\n", strerror(errno));
 		goto out;
 	}
 
@@ -64,7 +64,7 @@ static int statistics_custom_get(int fd, struct ifreq *ifr)
 	strings = calloc(1, sz_str + sizeof(struct ethtool_gstrings));
 	stats = calloc(1, sz_stats + sizeof(struct ethtool_stats));
 	if (!strings || !stats) {
-		printf("Error - out of memory\n");
+		fprintf(stderr, "Error - out of memory\n");
 		goto out;
 	}
 
@@ -74,7 +74,7 @@ static int statistics_custom_get(int fd, struct ifreq *ifr)
 	ifr->ifr_data = (caddr_t)strings;
 	err = ioctl(fd, SIOCETHTOOL, ifr);
 	if (err < 0) {
-		printf("Error - can't get stats strings information: %s\n", strerror(errno));
+		fprintf(stderr, "Error - can't get stats strings information: %s\n", strerror(errno));
 		goto out;
 	}
 
@@ -83,7 +83,7 @@ static int statistics_custom_get(int fd, struct ifreq *ifr)
 	ifr->ifr_data = (caddr_t) stats;
 	err = ioctl(fd, SIOCETHTOOL, ifr);
 	if (err < 0) {
-		printf("Error - can't get stats information: %s\n", strerror(errno));
+		fprintf(stderr, "Error - can't get stats information: %s\n", strerror(errno));
 		goto out;
 	}
 
@@ -111,7 +111,7 @@ int ioctl_statistics_get(char *mesh_iface)
 
 	fd = socket(AF_INET, SOCK_DGRAM, 0);
 	if (fd < 0) {
-		printf("Error - can't open socket: %s\n", strerror(errno));
+		fprintf(stderr, "Error - can't open socket: %s\n", strerror(errno));
 		goto out;
 	}
 
diff --git a/main.c b/main.c
index 5d85d8b..ea83bbf 100644
--- a/main.c
+++ b/main.c
@@ -48,47 +48,47 @@ void print_usage(void)
 {
 	int i, opt_indent;
 
-	printf("Usage: batctl [options] command|debug table [parameters]\n");
-	printf("options:\n");
-	printf(" \t-m mesh interface (default 'bat0')\n");
-	printf(" \t-h print this help (or 'batctl <command|debug table> -h' for the parameter help)\n");
-	printf(" \t-v print version\n");
-	printf("\n");
-
-	printf("commands:\n");
-	printf(" \tinterface|if               [add|del iface(s)]\tdisplay or modify the interface settings\n");
+	fprintf(stderr, "Usage: batctl [options] command|debug table [parameters]\n");
+	fprintf(stderr, "options:\n");
+	fprintf(stderr, " \t-m mesh interface (default 'bat0')\n");
+	fprintf(stderr, " \t-h print this help (or 'batctl <command|debug table> -h' for the parameter help)\n");
+	fprintf(stderr, " \t-v print version\n");
+	fprintf(stderr, "\n");
+
+	fprintf(stderr, "commands:\n");
+	fprintf(stderr, " \tinterface|if               [add|del iface(s)]\tdisplay or modify the interface settings\n");
 	for (i = 0; i < BATCTL_SETTINGS_NUM; i++) {
-		printf(" \t%s|%s", batctl_settings[i].opt_long, batctl_settings[i].opt_short);
+		fprintf(stderr, " \t%s|%s", batctl_settings[i].opt_long, batctl_settings[i].opt_short);
 		opt_indent = strlen(batctl_settings[i].opt_long) + strlen(batctl_settings[i].opt_short);
 
 		if (batctl_settings[i].params == sysfs_param_enable)
-			printf("%*s                display or modify %s setting\n",
+			fprintf(stderr, "%*s                display or modify %s setting\n",
 			       31 - opt_indent, "[0|1]", batctl_settings[i].opt_long);
 		else if (batctl_settings[i].params == sysfs_param_server)
-			printf("%*s      display or modify %s setting\n",
+			fprintf(stderr, "%*s      display or modify %s setting\n",
 			       41 - opt_indent, "[client|server]", batctl_settings[i].opt_long);
 		else
-			printf("                                display or modify %s setting\n",
+			fprintf(stderr, "                                display or modify %s setting\n",
 			       batctl_settings[i].opt_long);
 	}
-	printf(" \tloglevel|ll                [level]           \tdisplay or modify the log level\n");
-	printf(" \tlog|l                                        \tread the log produced by the kernel module\n");
-	printf(" \tgw_mode|gw                 [mode]            \tdisplay or modify the gateway mode\n");
-	printf(" \tvis_data|vd                [dot|JSON]        \tdisplay the VIS data in dot or JSON format\n");
-	printf("\n");
+	fprintf(stderr, " \tloglevel|ll                [level]           \tdisplay or modify the log level\n");
+	fprintf(stderr, " \tlog|l                                        \tread the log produced by the kernel module\n");
+	fprintf(stderr, " \tgw_mode|gw                 [mode]            \tdisplay or modify the gateway mode\n");
+	fprintf(stderr, " \tvis_data|vd                [dot|JSON]        \tdisplay the VIS data in dot or JSON format\n");
+	fprintf(stderr, "\n");
 
-	printf("debug tables:                                   \tdisplay the corresponding debug table\n");
+	fprintf(stderr, "debug tables:                                   \tdisplay the corresponding debug table\n");
 	for (i = 0; i < BATCTL_TABLE_NUM; i++)
-		printf(" \t%s|%s\n", batctl_debug_tables[i].opt_long, batctl_debug_tables[i].opt_short);
-
-	printf("\n");
-	printf(" \tstatistics|s                                 \tprint mesh statistics\n");
-	printf(" \tping|p                     <destination>     \tping another batman adv host via layer 2\n");
-	printf(" \ttraceroute|tr              <destination>     \ttraceroute another batman adv host via layer 2\n");
-	printf(" \ttcpdump|td                 <interface>       \ttcpdump layer 2 traffic on the given interface\n");
-	printf(" \ttranslate|t                <destination>     \ttranslate a destination to the originator responsible for it\n");
+		fprintf(stderr, " \t%s|%s\n", batctl_debug_tables[i].opt_long, batctl_debug_tables[i].opt_short);
+
+	fprintf(stderr, "\n");
+	fprintf(stderr, " \tstatistics|s                                 \tprint mesh statistics\n");
+	fprintf(stderr, " \tping|p                     <destination>     \tping another batman adv host via layer 2\n");
+	fprintf(stderr, " \ttraceroute|tr              <destination>     \ttraceroute another batman adv host via layer 2\n");
+	fprintf(stderr, " \ttcpdump|td                 <interface>       \ttcpdump layer 2 traffic on the given interface\n");
+	fprintf(stderr, " \ttranslate|t                <destination>     \ttranslate a destination to the originator responsible for it\n");
 #ifdef BATCTL_BISECT
-	printf(" \tbisect_iv                  <file1> .. <fileN>\tanalyze given batman iv log files for routing stability\n");
+	fprintf(stderr, " \tbisect_iv                  <file1> .. <fileN>\tanalyze given batman iv log files for routing stability\n");
 #endif
 }
 
@@ -99,7 +99,7 @@ int main(int argc, char **argv)
 
 	if ((argc > 1) && (strcmp(argv[1], "-m") == 0)) {
 		if (argc < 3) {
-			printf("Error - the option '-m' needs a parameter\n");
+			fprintf(stderr, "Error - the option '-m' needs a parameter\n");
 			goto err;
 		}
 
@@ -110,12 +110,14 @@ int main(int argc, char **argv)
 	}
 
 	if (argc < 2) {
-		printf("Error - no command specified\n");
+		fprintf(stderr, "Error - no command specified\n");
 		goto err;
 	}
 
-	if (strcmp(argv[1], "-h") == 0)
-		goto err;
+	if (strcmp(argv[1], "-h") == 0) {
+		print_usage();
+		exit(EXIT_SUCCESS);
+	}
 
 	if (strcmp(argv[1], "-v") == 0) {
 		printf("batctl %s [batman-adv: ", SOURCE_VERSION);
@@ -206,7 +208,7 @@ int main(int argc, char **argv)
 			goto out;
 		}
 
-		printf("Error - no valid command or debug table specified: %s\n", argv[1]);
+		fprintf(stderr, "Error - no valid command or debug table specified: %s\n", argv[1]);
 		print_usage();
 	}
 
diff --git a/ping.c b/ping.c
index 51d18e8..4f52c66 100644
--- a/ping.c
+++ b/ping.c
@@ -44,14 +44,14 @@ char is_aborted = 0;
 
 void ping_usage(void)
 {
-	printf("Usage: batctl [options] ping [parameters] mac|bat-host|host_name|IPv4_address \n");
-	printf("parameters:\n");
-	printf(" \t -c ping packet count \n");
-	printf(" \t -h print this help\n");
-	printf(" \t -i interval in seconds\n");
-	printf(" \t -t timeout in seconds\n");
-	printf(" \t -R record route\n");
-	printf(" \t -T don't try to translate mac to originator address\n");
+	fprintf(stderr, "Usage: batctl [options] ping [parameters] mac|bat-host|host_name|IPv4_address \n");
+	fprintf(stderr, "parameters:\n");
+	fprintf(stderr, " \t -c ping packet count \n");
+	fprintf(stderr, " \t -h print this help\n");
+	fprintf(stderr, " \t -i interval in seconds\n");
+	fprintf(stderr, " \t -t timeout in seconds\n");
+	fprintf(stderr, " \t -R record route\n");
+	fprintf(stderr, " \t -T don't try to translate mac to originator address\n");
 }
 
 void sig_handler(int sig)
@@ -124,7 +124,7 @@ int ping(char *mesh_iface, int argc, char **argv)
 	}
 
 	if (argc <= found_args) {
-		printf("Error - target mac address or bat-host name not specified\n");
+		fprintf(stderr, "Error - target mac address or bat-host name not specified\n");
 		ping_usage();
 		return EXIT_FAILURE;
 	}
@@ -140,7 +140,7 @@ int ping(char *mesh_iface, int argc, char **argv)
 		dst_mac = resolve_mac(dst_string);
 
 		if (!dst_mac) {
-			printf("Error - mac address of the ping destination could not be resolved and is not a bat-host name: %s\n", dst_string);
+			fprintf(stderr, "Error - mac address of the ping destination could not be resolved and is not a bat-host name: %s\n", dst_string);
 			goto out;
 		}
 	}
@@ -154,7 +154,7 @@ int ping(char *mesh_iface, int argc, char **argv)
 
 	debugfs_mnt = debugfs_mount(NULL);
 	if (!debugfs_mnt) {
-		printf("Error - can't mount or find debugfs\n");
+		fprintf(stderr, "Error - can't mount or find debugfs\n");
 		goto out;
 	}
 
@@ -163,7 +163,7 @@ int ping(char *mesh_iface, int argc, char **argv)
 	ping_fd = open(icmp_socket, O_RDWR);
 
 	if (ping_fd < 0) {
-		printf("Error - can't open a connection to the batman adv kernel module via the socket '%s': %s\n",
+		fprintf(stderr, "Error - can't open a connection to the batman adv kernel module via the socket '%s': %s\n",
 				icmp_socket, strerror(errno));
 		printf("Check whether the module is loaded and active.\n");
 		goto out;
@@ -203,7 +203,7 @@ int ping(char *mesh_iface, int argc, char **argv)
 		icmp_packet_out.seqno = htons(++seq_counter);
 
 		if (write(ping_fd, (char *)&icmp_packet_out, packet_len) < 0) {
-			printf("Error - can't write to batman adv kernel file '%s': %s\n", icmp_socket, strerror(errno));
+			fprintf(stderr, "Error - can't write to batman adv kernel file '%s': %s\n", icmp_socket, strerror(errno));
 			goto sleep;
 		}
 
@@ -231,7 +231,7 @@ read_packet:
 		read_len = read(ping_fd, (char *)&icmp_packet_in, packet_len);
 
 		if (read_len < 0) {
-			printf("Error - can't read from batman adv kernel file '%s': %s\n", icmp_socket, strerror(errno));
+			fprintf(stderr, "Error - can't read from batman adv kernel file '%s': %s\n", icmp_socket, strerror(errno));
 			goto sleep;
 		}
 
@@ -298,7 +298,7 @@ read_packet:
 			printf("From %s: Time to live exceeded (icmp_seq %hu)\n", dst_string, ntohs(icmp_packet_in.seqno));
 			break;
 		case BATADV_PARAMETER_PROBLEM:
-			printf("Error - the batman adv kernel module version (%d) differs from ours (%d)\n",
+			fprintf(stderr, "Error - the batman adv kernel module version (%d) differs from ours (%d)\n",
 					icmp_packet_in.header.version, BATADV_COMPAT_VERSION);
 			printf("Please make sure to use compatible versions!\n");
 			goto out;
diff --git a/sys.c b/sys.c
index e4112b7..f628363 100644
--- a/sys.c
+++ b/sys.c
@@ -103,9 +103,9 @@ const struct settings_data batctl_settings[BATCTL_SETTINGS_NUM] = {
 
 static void interface_usage(void)
 {
-	printf("Usage: batctl [options] interface [parameters] [add|del iface(s)]\n");
-	printf("parameters:\n");
-	printf(" \t -h print this help\n");
+	fprintf(stderr, "Usage: batctl [options] interface [parameters] [add|del iface(s)]\n");
+	fprintf(stderr, "parameters:\n");
+	fprintf(stderr, " \t -h print this help\n");
 }
 
 static int print_interfaces(char *mesh_iface)
@@ -116,21 +116,21 @@ static int print_interfaces(char *mesh_iface)
 	int res;
 
 	if (!file_exists(module_ver_path)) {
-		printf("Error - batman-adv module has not been loaded\n");
+		fprintf(stderr, "Error - batman-adv module has not been loaded\n");
 		goto err;
 	}
 
 	path_buff = malloc(PATH_BUFF_LEN);
 	if (!path_buff) {
-		printf("Error - could not allocate path buffer: out of memory ?\n");
+		fprintf(stderr, "Error - could not allocate path buffer: out of memory ?\n");
 		goto err;
 	}
 
 	iface_base_dir = opendir(SYS_IFACE_PATH);
 	if (!iface_base_dir) {
-		printf("Error - the directory '%s' could not be read: %s\n",
+		fprintf(stderr, "Error - the directory '%s' could not be read: %s\n",
 		       SYS_IFACE_PATH, strerror(errno));
-		printf("Is the batman-adv module loaded and sysfs mounted ?\n");
+		fprintf(stderr, "Is the batman-adv module loaded and sysfs mounted ?\n");
 		goto err_buff;
 	}
 
@@ -157,7 +157,7 @@ static int print_interfaces(char *mesh_iface)
 		path_buff[PATH_BUFF_LEN - 1] = '\0';
 		res = read_file("", path_buff, USE_READ_BUFF | SILENCE_ERRORS, 0, 0, 0);
 		if (res != EXIT_SUCCESS) {
-			printf("<error reading status>\n");
+			fprintf(stderr, "<error reading status>\n");
 			continue;
 		}
 
@@ -199,20 +199,20 @@ int interface(char *mesh_iface, int argc, char **argv)
 
 	if ((strcmp(argv[1], "add") != 0) && (strcmp(argv[1], "a") != 0) &&
 	    (strcmp(argv[1], "del") != 0) && (strcmp(argv[1], "d") != 0)) {
-		printf("Error - unknown argument specified: %s\n", argv[1]);
+		fprintf(stderr, "Error - unknown argument specified: %s\n", argv[1]);
 		interface_usage();
 		goto err;
 	}
 
 	if (argc == 2) {
-		printf("Error - missing interface name(s) after '%s'\n", argv[1]);
+		fprintf(stderr, "Error - missing interface name(s) after '%s'\n", argv[1]);
 		interface_usage();
 		goto err;
 	}
 
 	path_buff = malloc(PATH_BUFF_LEN);
 	if (!path_buff) {
-		printf("Error - could not allocate path buffer: out of memory ?\n");
+		fprintf(stderr, "Error - could not allocate path buffer: out of memory ?\n");
 		goto err;
 	}
 
@@ -225,16 +225,16 @@ int interface(char *mesh_iface, int argc, char **argv)
 			path_buff[PATH_BUFF_LEN - 1] = '\0';
 
 			if (!file_exists(path_buff)) {
-				printf("Error - interface does not exist: %s\n", argv[i]);
+				fprintf(stderr, "Error - interface does not exist: %s\n", argv[i]);
 				continue;
 			}
 
 			if (!file_exists(module_ver_path)) {
-				printf("Error - batman-adv module has not been loaded\n");
+				fprintf(stderr, "Error - batman-adv module has not been loaded\n");
 				goto err;
 			}
 
-			printf("Error - interface type not supported by batman-adv: %s\n", argv[i]);
+			fprintf(stderr, "Error - interface type not supported by batman-adv: %s\n", argv[i]);
 			continue;
 		}
 
@@ -258,17 +258,17 @@ err:
 
 static void log_level_usage(void)
 {
-	printf("Usage: batctl [options] loglevel [parameters] [level[ level[ level]]...]\n");
-	printf("parameters:\n");
-	printf(" \t -h print this help\n");
-	printf("levels:\n");
-	printf(" \t none    Debug logging is disabled\n");
-	printf(" \t all     Print messages from all below\n");
-	printf(" \t batman  Messages related to routing / flooding / broadcasting\n");
-	printf(" \t routes  Messages related to route added / changed / deleted\n");
-	printf(" \t tt      Messages related to translation table operations\n");
-	printf(" \t bla     Messages related to bridge loop avoidance\n");
-	printf(" \t dat     Messages related to arp snooping and distributed arp table\n");
+	fprintf(stderr, "Usage: batctl [options] loglevel [parameters] [level[ level[ level]]...]\n");
+	fprintf(stderr, "parameters:\n");
+	fprintf(stderr, " \t -h print this help\n");
+	fprintf(stderr, "levels:\n");
+	fprintf(stderr, " \t none    Debug logging is disabled\n");
+	fprintf(stderr, " \t all     Print messages from all below\n");
+	fprintf(stderr, " \t batman  Messages related to routing / flooding / broadcasting\n");
+	fprintf(stderr, " \t routes  Messages related to route added / changed / deleted\n");
+	fprintf(stderr, " \t tt      Messages related to translation table operations\n");
+	fprintf(stderr, " \t bla     Messages related to bridge loop avoidance\n");
+	fprintf(stderr, " \t dat     Messages related to arp snooping and distributed arp table\n");
 }
 
 int handle_loglevel(char *mesh_iface, int argc, char **argv)
@@ -352,18 +352,18 @@ out:
 
 static void settings_usage(int setting)
 {
-	printf("Usage: batctl [options] %s|%s [parameters]",
+	fprintf(stderr, "Usage: batctl [options] %s|%s [parameters]",
 	       (char *)batctl_settings[setting].opt_long, (char *)batctl_settings[setting].opt_short);
 
 	if (batctl_settings[setting].params == sysfs_param_enable)
-		printf(" [0|1]\n");
+		fprintf(stderr, " [0|1]\n");
 	else if (batctl_settings[setting].params == sysfs_param_server)
-		printf(" [client|server]\n");
+		fprintf(stderr, " [client|server]\n");
 	else
-		printf("\n");
+		fprintf(stderr, "\n");
 
-	printf("parameters:\n");
-	printf(" \t -h print this help\n");
+	fprintf(stderr, "parameters:\n");
+	fprintf(stderr, " \t -h print this help\n");
 }
 
 int handle_sys_setting(char *mesh_iface, int setting, int argc, char **argv)
@@ -404,12 +404,12 @@ int handle_sys_setting(char *mesh_iface, int setting, int argc, char **argv)
 		ptr++;
 	}
 
-	printf("Error - the supplied argument is invalid: %s\n", argv[1]);
-	printf("The following values are allowed:\n");
+	fprintf(stderr, "Error - the supplied argument is invalid: %s\n", argv[1]);
+	fprintf(stderr, "The following values are allowed:\n");
 
 	ptr = batctl_settings[setting].params;
 	while (*ptr) {
-		printf(" * %s\n", *ptr);
+		fprintf(stderr, " * %s\n", *ptr);
 		ptr++;
 	}
 
@@ -426,9 +426,9 @@ out:
 
 static void gw_mode_usage(void)
 {
-	printf("Usage: batctl [options] gw_mode [mode] [sel_class|bandwidth]\n");
-	printf("options:\n");
-	printf(" \t -h print this help\n");
+	fprintf(stderr, "Usage: batctl [options] gw_mode [mode] [sel_class|bandwidth]\n");
+	fprintf(stderr, "options:\n");
+	fprintf(stderr, " \t -h print this help\n");
 }
 
 int handle_gw_setting(char *mesh_iface, int argc, char **argv)
@@ -533,12 +533,12 @@ int handle_gw_setting(char *mesh_iface, int argc, char **argv)
 	goto out;
 
 opt_err:
-	printf("Error - the supplied argument is invalid: %s\n", argv[1]);
-	printf("The following values are allowed:\n");
+	fprintf(stderr, "Error - the supplied argument is invalid: %s\n", argv[1]);
+	fprintf(stderr, "The following values are allowed:\n");
 
 	ptr = sysfs_param_server;
 	while (*ptr) {
-		printf(" * %s\n", *ptr);
+		fprintf(stderr, " * %s\n", *ptr);
 		ptr++;
 	}
 
diff --git a/tcpdump.c b/tcpdump.c
index 4424dfd..d9aa6a8 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -62,23 +62,23 @@ static void parse_eth_hdr(unsigned char *packet_buff, ssize_t buff_len, int read
 
 static void tcpdump_usage(void)
 {
-	printf("Usage: batctl tcpdump [parameters] interface [interface]\n");
-	printf("parameters:\n");
-	printf(" \t -c compat filter - only display packets matching own compat version (%i)\n", BATADV_COMPAT_VERSION);
-	printf(" \t -h print this help\n");
-	printf(" \t -n don't convert addresses to bat-host names\n");
-	printf(" \t -p dump specific packet type\n");
-	printf(" \t -x dump all packet types except specified\n");
-	printf("packet types:\n");
-	printf(" \t\t%3d - batman ogm packets\n", DUMP_TYPE_BATOGM);
-	printf(" \t\t%3d - batman icmp packets\n", DUMP_TYPE_BATICMP);
-	printf(" \t\t%3d - batman unicast packets\n", DUMP_TYPE_BATUCAST);
-	printf(" \t\t%3d - batman broadcast packets\n", DUMP_TYPE_BATBCAST);
-	printf(" \t\t%3d - batman vis packets\n", DUMP_TYPE_BATVIS);
-	printf(" \t\t%3d - batman fragmented packets\n", DUMP_TYPE_BATFRAG);
-	printf(" \t\t%3d - batman tt / roaming packets\n", DUMP_TYPE_BATTT);
-	printf(" \t\t%3d - non batman packets\n", DUMP_TYPE_NONBAT);
-	printf(" \t\t%3d - batman ogm & non batman packets\n", DUMP_TYPE_BATOGM | DUMP_TYPE_NONBAT);
+	fprintf(stderr, "Usage: batctl tcpdump [parameters] interface [interface]\n");
+	fprintf(stderr, "parameters:\n");
+	fprintf(stderr, " \t -c compat filter - only display packets matching own compat version (%i)\n", BATADV_COMPAT_VERSION);
+	fprintf(stderr, " \t -h print this help\n");
+	fprintf(stderr, " \t -n don't convert addresses to bat-host names\n");
+	fprintf(stderr, " \t -p dump specific packet type\n");
+	fprintf(stderr, " \t -x dump all packet types except specified\n");
+	fprintf(stderr, "packet types:\n");
+	fprintf(stderr, " \t\t%3d - batman ogm packets\n", DUMP_TYPE_BATOGM);
+	fprintf(stderr, " \t\t%3d - batman icmp packets\n", DUMP_TYPE_BATICMP);
+	fprintf(stderr, " \t\t%3d - batman unicast packets\n", DUMP_TYPE_BATUCAST);
+	fprintf(stderr, " \t\t%3d - batman broadcast packets\n", DUMP_TYPE_BATBCAST);
+	fprintf(stderr, " \t\t%3d - batman vis packets\n", DUMP_TYPE_BATVIS);
+	fprintf(stderr, " \t\t%3d - batman fragmented packets\n", DUMP_TYPE_BATFRAG);
+	fprintf(stderr, " \t\t%3d - batman tt / roaming packets\n", DUMP_TYPE_BATTT);
+	fprintf(stderr, " \t\t%3d - non batman packets\n", DUMP_TYPE_NONBAT);
+	fprintf(stderr, " \t\t%3d - batman ogm & non batman packets\n", DUMP_TYPE_BATOGM | DUMP_TYPE_NONBAT);
 }
 
 static int print_time(void)
diff --git a/traceroute.c b/traceroute.c
index ac2f1fa..9da9bf6 100644
--- a/traceroute.c
+++ b/traceroute.c
@@ -43,11 +43,11 @@
 
 void traceroute_usage(void)
 {
-	printf("Usage: batctl [options] traceroute [parameters] mac|bat-host|host_name|IPv4_address \n");
-	printf("parameters:\n");
-	printf(" \t -h print this help\n");
-	printf(" \t -n don't convert addresses to bat-host names\n");
-	printf(" \t -T don't try to translate mac to originator address\n");
+	fprintf(stderr, "Usage: batctl [options] traceroute [parameters] mac|bat-host|host_name|IPv4_address \n");
+	fprintf(stderr, "parameters:\n");
+	fprintf(stderr, " \t -h print this help\n");
+	fprintf(stderr, " \t -n don't convert addresses to bat-host names\n");
+	fprintf(stderr, " \t -T don't try to translate mac to originator address\n");
 }
 
 int traceroute(char *mesh_iface, int argc, char **argv)
@@ -86,7 +86,7 @@ int traceroute(char *mesh_iface, int argc, char **argv)
 	}
 
 	if (argc <= found_args) {
-		printf("Error - target mac address or bat-host name not specified\n");
+		fprintf(stderr, "Error - target mac address or bat-host name not specified\n");
 		traceroute_usage();
 		return EXIT_FAILURE;
 	}
@@ -102,7 +102,7 @@ int traceroute(char *mesh_iface, int argc, char **argv)
 		dst_mac = resolve_mac(dst_string);
 
 		if (!dst_mac) {
-			printf("Error - mac address of the ping destination could not be resolved and is not a bat-host name: %s\n", dst_string);
+			fprintf(stderr, "Error - mac address of the ping destination could not be resolved and is not a bat-host name: %s\n", dst_string);
 			goto out;
 		}
 	}
@@ -114,7 +114,7 @@ int traceroute(char *mesh_iface, int argc, char **argv)
 
 	debugfs_mnt = debugfs_mount(NULL);
 	if (!debugfs_mnt) {
-		printf("Error - can't mount or find debugfs\n");
+		fprintf(stderr, "Error - can't mount or find debugfs\n");
 		goto out;
 	}
 
@@ -123,9 +123,9 @@ int traceroute(char *mesh_iface, int argc, char **argv)
 	trace_fd = open(icmp_socket, O_RDWR);
 
 	if (trace_fd < 0) {
-		printf("Error - can't open a connection to the batman adv kernel module via the socket '%s': %s\n",
+		fprintf(stderr, "Error - can't open a connection to the batman adv kernel module via the socket '%s': %s\n",
 				icmp_socket, strerror(errno));
-		printf("Check whether the module is loaded and active.\n");
+		fprintf(stderr, "Check whether the module is loaded and active.\n");
 		goto out;
 	}
 
@@ -148,7 +148,7 @@ int traceroute(char *mesh_iface, int argc, char **argv)
 			time_delta[i] = 0.0;
 
 			if (write(trace_fd, (char *)&icmp_packet_out, sizeof(icmp_packet_out)) < 0) {
-				printf("Error - can't write to batman adv kernel file '%s': %s\n", icmp_socket, strerror(errno));
+				fprintf(stderr, "Error - can't write to batman adv kernel file '%s': %s\n", icmp_socket, strerror(errno));
 				continue;
 			}
 
@@ -169,7 +169,7 @@ read_packet:
 			read_len = read(trace_fd, (char *)&icmp_packet_in, sizeof(icmp_packet_in));
 
 			if (read_len < 0) {
-				printf("Error - can't read from batman adv kernel file '%s': %s\n", icmp_socket, strerror(errno));
+				fprintf(stderr, "Error - can't read from batman adv kernel file '%s': %s\n", icmp_socket, strerror(errno));
 				continue;
 			}
 
@@ -202,9 +202,9 @@ read_packet:
 				printf("%s: Destination Host Unreachable\n", dst_string);
 				goto out;
 			case BATADV_PARAMETER_PROBLEM:
-				printf("Error - the batman adv kernel module version (%d) differs from ours (%d)\n",
+				fprintf(stderr, "Error - the batman adv kernel module version (%d) differs from ours (%d)\n",
 						icmp_packet_in.header.version, BATADV_COMPAT_VERSION);
-				printf("Please make sure to use compatible versions!\n");
+				fprintf(stderr, "Please make sure to use compatible versions!\n");
 				goto out;
 			default:
 				printf("Unknown message type %d len %zd received\n", icmp_packet_in.msg_type, read_len);
diff --git a/translate.c b/translate.c
index 2d6ede9..bf33e90 100644
--- a/translate.c
+++ b/translate.c
@@ -31,7 +31,7 @@
 
 static void translate_usage(void)
 {
-	printf("Usage: batctl [options] translate mac|bat-host|host_name|IPv4_address\n");
+	fprintf(stderr, "Usage: batctl [options] translate mac|bat-host|host_name|IPv4_address\n");
 }
 
 int translate(char *mesh_iface, int argc, char **argv)
diff --git a/vis.c b/vis.c
index b040497..f42d85a 100644
--- a/vis.c
+++ b/vis.c
@@ -58,9 +58,9 @@ static bool with_names = true;
 
 static void usage(void)
 {
-	printf("batctl vis_data dot {-h}{--no-TT|-T} {--no-2nd|-2} {--numbers|-n}\n");
-	printf("or\n");
-	printf("batctl vis_data json {-h}{--no-TT|-T} {--no-2nd|-2} {--numbers|-n}\n");
+	fprintf(stderr, "batctl vis_data dot {-h}{--no-TT|-T} {--no-2nd|-2} {--numbers|-n}\n");
+	fprintf(stderr, "or\n");
+	fprintf(stderr, "batctl vis_data json {-h}{--no-TT|-T} {--no-2nd|-2} {--numbers|-n}\n");
 }
 
 static void dot_print_tq(char *orig, char *from, const long tq)
@@ -171,7 +171,7 @@ static FILE *open_vis(char *mesh_iface)
 
 	debugfs_mnt = debugfs_mount(NULL);
 	if (!debugfs_mnt) {
-		printf("Error - can't mount or find debugfs\n");
+		fprintf(stderr, "Error - can't mount or find debugfs\n");
 		return NULL;
 	}
 

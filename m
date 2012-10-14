Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 14 Oct 2012 22:20:52 +0200
Message-Id: <1350246055-18000-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv4 1/4] batctl: Translate client mac to
	originator mac for ping/traceroute
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

A user may want to check the path selected by batman-adv for any client when
only the MAC of the device with the IPv4 is known, but not the originator
address. batctl can assist the user by parsing the global translation table
to automatically translate it for him.

The ping itself will only be done until the originator is reached and not until
the actual client could be contacted because the client cannot understand
batman-adv ping packets.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
rebased on DAT

 README       |    1 +
 debug.h      |    1 +
 functions.c  |   82 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 functions.h  |    1 +
 man/batctl.8 |   10 ++++---
 ping.c       |   11 +++++++-
 traceroute.c |   11 +++++++-
 7 files changed, 111 insertions(+), 6 deletions(-)

diff --git a/README b/README
index 22ad616..04a6e66 100644
--- a/README
+++ b/README
@@ -87,6 +87,7 @@ parameters:
          -h print this help
          -i interval in seconds
          -t timeout in seconds
+	 -T don't try to translate mac to originator address
          -R record route
 
 Example:
diff --git a/debug.h b/debug.h
index 4e935cb..5bd7f3e 100644
--- a/debug.h
+++ b/debug.h
@@ -22,6 +22,7 @@
 
 #define DEBUG_BATIF_PATH_FMT "%s/batman_adv/%s"
 #define DEBUG_VIS_DATA "vis_data"
+#define DEBUG_TRANSTABLE_GLOBAL "transtable_global"
 #define DEBUG_LOG "log"
 
 enum batctl_debug_tables {
diff --git a/functions.c b/functions.c
index 1cde235..7875716 100644
--- a/functions.c
+++ b/functions.c
@@ -37,6 +37,7 @@
 #include "bat-hosts.h"
 #include "sys.h"
 #include "debug.h"
+#include "debugfs.h"
 
 static struct timeval start_time;
 static char *host_name;
@@ -320,3 +321,84 @@ out:
 		close(fd);
 	return res;
 }
+
+struct ether_addr *translate_mac(char *mesh_iface, struct ether_addr *mac)
+{
+	enum {
+		tg_start,
+		tg_mac,
+		tg_via,
+		tg_originator,
+	} pos;
+	char full_path[MAX_PATH+1];
+	char *debugfs_mnt;
+	static struct ether_addr in_mac;
+	struct ether_addr *mac_result, *mac_tmp;
+	FILE *f = NULL;
+	size_t len = 0;
+	char *line = NULL;
+	char *input, *saveptr, *token;
+	int line_invalid;
+
+	memcpy(&in_mac, mac, sizeof(in_mac));
+	mac_result = &in_mac;
+
+	debugfs_mnt = debugfs_mount(NULL);
+	if (!debugfs_mnt)
+		goto out;
+
+	debugfs_make_path(DEBUG_BATIF_PATH_FMT "/" DEBUG_TRANSTABLE_GLOBAL, mesh_iface, full_path, sizeof(full_path));
+
+	f = fopen(full_path, "r");
+	if (!f)
+		goto out;
+
+	while (getline(&line, &len, f) != -1) {
+		line_invalid = 0;
+		pos = tg_start;
+		input = line;
+
+		while ((token = strtok_r(input, " \t", &saveptr))) {
+			input = NULL;
+
+			switch (pos) {
+			case tg_start:
+				if (strcmp(token, "*") != 0)
+					line_invalid = 1;
+				else
+					pos = tg_mac;
+				break;
+			case tg_mac:
+				mac_tmp = ether_aton(token);
+				if (!mac_tmp || memcmp(mac_tmp, &in_mac,
+						       sizeof(in_mac)) != 0)
+					line_invalid = 1;
+				else
+					pos = tg_via;
+				break;
+			case tg_via:
+				if (strcmp(token, "via") == 0)
+					pos = tg_originator;
+				break;
+			case tg_originator:
+				mac_tmp = ether_aton(token);
+				if (!mac_tmp) {
+					line_invalid = 1;
+				} else {
+					mac_result = mac_tmp;
+					goto out;
+				}
+				break;
+			}
+
+			if (line_invalid)
+				break;
+		}
+	}
+
+out:
+	if (f)
+		fclose(f);
+	free(line);
+	return mac_result;
+}
diff --git a/functions.h b/functions.h
index 92d6ae5..a59bb24 100644
--- a/functions.h
+++ b/functions.h
@@ -37,6 +37,7 @@ int file_exists(const char *fpath);
 int read_file(char *dir, char *path, int read_opt,
 	      float orig_timeout, float watch_interval);
 int write_file(char *dir, char *fname, char *arg1, char *arg2);
+struct ether_addr *translate_mac(char *mesh_iface, struct ether_addr *mac);
 
 extern char *line_ptr;
 
diff --git a/man/batctl.8 b/man/batctl.8
index fdc788e..369be20 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -212,17 +212,19 @@ tt - translation table counters
 All counters without a prefix concern payload (pure user data) traffic.
 .RE
 .br
-.IP "\fBping\fP|\fBp\fP [\fB\-c count\fP][\fB\-i interval\fP][\fB\-t time\fP][\fB\-R\fP] \fBMAC_address\fP|\fBbat\-host_name\fP"
+.IP "\fBping\fP|\fBp\fP [\fB\-c count\fP][\fB\-i interval\fP][\fB\-t time\fP][\fB\-R\fP][\fB\-T\fP] \fBMAC_address\fP|\fBbat\-host_name\fP"
 Layer 2 ping of a MAC address or bat\-host name.  batctl will try to find the bat\-host name if the given parameter was
 not a MAC address. The "\-c" option tells batctl how man pings should be sent before the program exits. Without the "\-c"
 option batctl will continue pinging without end. Use CTRL + C to stop it.  With "\-i" and "\-t" you can set the default
 interval between pings and the timeout time for replies, both in seconds. When run with "\-R", the route taken by the ping
-messages will be recorded.
+messages will be recorded. With "\-T" you can disable the automatic translation of a client MAC address to the originator
+address which is responsible for this client.
 .br
-.IP "\fBtraceroute\fP|\fBtr\fP [\fB\-n\fP] \fBMAC_address\fP|\fBbat\-host_name\fP"
+.IP "\fBtraceroute\fP|\fBtr\fP [\fB\-n\fP][\fB\-T\fP] \fBMAC_address\fP|\fBbat\-host_name\fP"
 Layer 2 traceroute to a MAC address or bat\-host name. batctl will try to find the bat\-host name if the given parameter
 was not a MAC address. batctl will send 3 packets to each host and display the response time. If "\-n" is given batctl will
-not replace the MAC addresses with bat\-host names in the output.
+not replace the MAC addresses with bat\-host names in the output. With "\-T" you can disable the automatic translation of a
+client MAC address to the originator address which is responsible for this client.
 .br
 .IP "\fBtcpdump\fP|\fBtd\fP [\fB\-c\fP][\fB\-n\fP][\fB\-p filter\fP][\fB\-x filter\fP] \fBinterface ...\fP"
 batctl will display all packets that are seen on the given interface(s). A variety of options to filter the output
diff --git a/ping.c b/ping.c
index ce8f457..02132f4 100644
--- a/ping.c
+++ b/ping.c
@@ -51,6 +51,7 @@ void ping_usage(void)
 	printf(" \t -i interval in seconds\n");
 	printf(" \t -t timeout in seconds\n");
 	printf(" \t -R record route\n");
+	printf(" \t -T don't try to translate mac to originator address\n");
 }
 
 void sig_handler(int sig)
@@ -83,8 +84,9 @@ int ping(char *mesh_iface, int argc, char **argv)
 	size_t packet_len;
 	char *debugfs_mnt;
 	char icmp_socket[MAX_PATH+1];
+	int disable_translate_mac = 0;
 
-	while ((optchar = getopt(argc, argv, "hc:i:t:R")) != -1) {
+	while ((optchar = getopt(argc, argv, "hc:i:t:RT")) != -1) {
 		switch (optchar) {
 		case 'c':
 			loop_count = strtol(optarg, NULL , 10);
@@ -111,6 +113,10 @@ int ping(char *mesh_iface, int argc, char **argv)
 			rr = 1;
 			found_args++;
 			break;
+		case 'T':
+			disable_translate_mac = 1;
+			found_args += 1;
+			break;
 		default:
 			ping_usage();
 			return EXIT_FAILURE;
@@ -139,6 +145,9 @@ int ping(char *mesh_iface, int argc, char **argv)
 		}
 	}
 
+	if (!disable_translate_mac)
+		dst_mac = translate_mac(mesh_iface, dst_mac);
+
 	mac_string = ether_ntoa_long(dst_mac);
 	signal(SIGINT, sig_handler);
 	signal(SIGTERM, sig_handler);
diff --git a/traceroute.c b/traceroute.c
index 75ff2b3..4e42419 100644
--- a/traceroute.c
+++ b/traceroute.c
@@ -47,6 +47,7 @@ void traceroute_usage(void)
 	printf("parameters:\n");
 	printf(" \t -h print this help\n");
 	printf(" \t -n don't convert addresses to bat-host names\n");
+	printf(" \t -T don't try to translate mac to originator address\n");
 }
 
 int traceroute(char *mesh_iface, int argc, char **argv)
@@ -63,8 +64,9 @@ int traceroute(char *mesh_iface, int argc, char **argv)
 	double time_delta[NUM_PACKETS];
 	char *debugfs_mnt;
 	char icmp_socket[MAX_PATH+1];
+	int disable_translate_mac = 0;
 
-	while ((optchar = getopt(argc, argv, "hn")) != -1) {
+	while ((optchar = getopt(argc, argv, "hnT")) != -1) {
 		switch (optchar) {
 		case 'h':
 			traceroute_usage();
@@ -73,6 +75,10 @@ int traceroute(char *mesh_iface, int argc, char **argv)
 			read_opt &= ~USE_BAT_HOSTS;
 			found_args += 1;
 			break;
+		case 'T':
+			disable_translate_mac = 1;
+			found_args += 1;
+			break;
 		default:
 			traceroute_usage();
 			return EXIT_FAILURE;
@@ -101,6 +107,9 @@ int traceroute(char *mesh_iface, int argc, char **argv)
 		}
 	}
 
+	if (!disable_translate_mac)
+		dst_mac = translate_mac(mesh_iface, dst_mac);
+
 	mac_string = ether_ntoa_long(dst_mac);
 
 	debugfs_mnt = debugfs_mount(NULL);
-- 
1.7.10.4


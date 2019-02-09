Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  9 Feb 2019 14:42:10 +0100
Message-Id: <20190209134222.15035-9-sven@narfation.org>
In-Reply-To: <20190209134222.15035-1-sven@narfation.org>
References: <20190209134222.15035-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH v5 08/20] batctl: Support generic netlink for
 loglevel command
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
Cc: Sven Eckelmann <sven@narfation.org>, Marek Lindner <mareklindner@neomailbox.ch>

sysfs should be avoided for new settings of network interfaces. To still
provide a common configuration infrastructure, all the existing settings
subcommands also have to be reimplemented via generic netlink while still
using sysfs as fallback.

The loglevel implementation is using the commands
BATADV_CMD_SET_MESH/BATADV_CMD_GET_MESH to set/get the configuration of
this feature using the u32 (bitmask) BATADV_ATTR_LOG_LEVEL attribute.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Cc: Marek Lindner <mareklindner@neomailbox.ch>
---
 loglevel.c | 138 ++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 110 insertions(+), 28 deletions(-)

diff --git a/loglevel.c b/loglevel.c
index de1f351..778c4b4 100644
--- a/loglevel.c
+++ b/loglevel.c
@@ -20,7 +20,9 @@
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
+#include <errno.h>
 #include <getopt.h>
+#include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -31,6 +33,10 @@
 
 #define SYS_LOG_LEVEL		"log_level"
 
+static struct log_level_data {
+	uint32_t log_level;
+} log_level_globals;
+
 static void log_level_usage(void)
 {
 	fprintf(stderr, "Usage: batctl [options] loglevel [parameters] [level[ level[ level]]...]\n");
@@ -49,14 +55,93 @@ static void log_level_usage(void)
 	fprintf(stderr, " \t tp      Messages related to throughput meter\n");
 }
 
+static int extract_log_level(struct nl_msg *msg, void *arg)
+{
+	struct nlattr *attrs[BATADV_ATTR_MAX + 1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct genlmsghdr *ghdr;
+	int *result = arg;
+
+	if (!genlmsg_valid_hdr(nlh, 0))
+		return NL_OK;
+
+	ghdr = nlmsg_data(nlh);
+
+	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
+		return NL_OK;
+	}
+
+	if (!attrs[BATADV_ATTR_LOG_LEVEL])
+		return NL_OK;
+
+	log_level_globals.log_level = nla_get_u32(attrs[BATADV_ATTR_LOG_LEVEL]);
+
+	*result = 0;
+	return NL_STOP;
+}
+
+static int get_log_level(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_GET_MESH,
+				  NULL, extract_log_level);
+}
+
+static int set_attrs_log_level(struct nl_msg *msg, void *arg __maybe_unused)
+{
+	nla_put_u32(msg, BATADV_ATTR_LOG_LEVEL, log_level_globals.log_level);
+
+	return 0;
+}
+
+static int set_log_level(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_SET_MESH,
+				  set_attrs_log_level, NULL);
+}
+
+static int log_level_read_setting(struct state *state, const char *path_buff)
+{
+	int res;
+
+	res = get_log_level(state);
+	if (res < 0 && res != -EOPNOTSUPP)
+		return EXIT_FAILURE;
+	if (res >= 0)
+		return EXIT_SUCCESS;
+
+	res = read_file(path_buff, SYS_LOG_LEVEL, USE_READ_BUFF, 0, 0, 0);
+	if (res != EXIT_SUCCESS)
+		return res;
+
+	log_level_globals.log_level = strtol(line_ptr, (char **) NULL, 10);
+
+	return res;
+}
+
+static int log_level_write_setting(struct state *state, const char *path_buff)
+{
+	int res;
+	char str[4];
+
+	res = set_log_level(state);
+	if (res < 0 && res != -EOPNOTSUPP)
+		return EXIT_FAILURE;
+	if (res >= 0)
+		return EXIT_SUCCESS;
+
+	snprintf(str, sizeof(str), "%i", log_level_globals.log_level);
+	return write_file(path_buff, SYS_LOG_LEVEL, str, NULL);
+}
+
 static int loglevel(struct state *state, int argc, char **argv)
 {
 	int optchar, res = EXIT_FAILURE;
-	int log_level = 0;
 	char *path_buff;
-	char str[4];
 	int i;
 
+	log_level_globals.log_level = 0;
+
 	while ((optchar = getopt(argc, argv, "h")) != -1) {
 		switch (optchar) {
 		case 'h':
@@ -81,63 +166,59 @@ static int loglevel(struct state *state, int argc, char **argv)
 
 		for (i = 1; i < argc; i++) {
 			if (strcmp(argv[i], "none") == 0) {
-				log_level = 0;
+				log_level_globals.log_level = 0;
 				break;
 			} else if (strcmp(argv[i], "all") == 0) {
-				log_level = 255;
+				log_level_globals.log_level = 255;
 				break;
 			} else if (strcmp(argv[i], "batman") == 0)
-				log_level |= BIT(0);
+				log_level_globals.log_level |= BIT(0);
 			else if (strcmp(argv[i], "routes") == 0)
-				log_level |= BIT(1);
+				log_level_globals.log_level |= BIT(1);
 			else if (strcmp(argv[i], "tt") == 0)
-				log_level |= BIT(2);
+				log_level_globals.log_level |= BIT(2);
 			else if (strcmp(argv[i], "bla") == 0)
-				log_level |= BIT(3);
+				log_level_globals.log_level |= BIT(3);
 			else if (strcmp(argv[i], "dat") == 0)
-				log_level |= BIT(4);
+				log_level_globals.log_level |= BIT(4);
 			else if (strcmp(argv[i], "nc") == 0)
-				log_level |= BIT(5);
+				log_level_globals.log_level |= BIT(5);
 			else if (strcmp(argv[i], "mcast") == 0)
-				log_level |= BIT(6);
+				log_level_globals.log_level |= BIT(6);
 			else if (strcmp(argv[i], "tp") == 0)
-				log_level |= BIT(7);
+				log_level_globals.log_level |= BIT(7);
 			else {
 				log_level_usage();
 				goto out;
 			}
 		}
 
-		snprintf(str, sizeof(str), "%i", log_level);
-		res = write_file(path_buff, SYS_LOG_LEVEL, str, NULL);
+		log_level_write_setting(state, path_buff);
 		goto out;
 	}
 
-	res = read_file(path_buff, SYS_LOG_LEVEL, USE_READ_BUFF, 0, 0, 0);
-
+	res = log_level_read_setting(state, path_buff);
 	if (res != EXIT_SUCCESS)
 		goto out;
 
-	log_level = strtol(line_ptr, (char **) NULL, 10);
-
-	printf("[%c] %s (%s)\n", (!log_level) ? 'x' : ' ',
+	printf("[%c] %s (%s)\n", (!log_level_globals.log_level) ? 'x' : ' ',
 	       "all debug output disabled", "none");
-	printf("[%c] %s (%s)\n", (log_level & BIT(0)) ? 'x' : ' ',
+	printf("[%c] %s (%s)\n", (log_level_globals.log_level & BIT(0)) ? 'x' : ' ',
 	       "messages related to routing / flooding / broadcasting",
 	       "batman");
-	printf("[%c] %s (%s)\n", (log_level & BIT(1)) ? 'x' : ' ',
+	printf("[%c] %s (%s)\n", (log_level_globals.log_level & BIT(1)) ? 'x' : ' ',
 	       "messages related to route added / changed / deleted", "routes");
-	printf("[%c] %s (%s)\n", (log_level & BIT(2)) ? 'x' : ' ',
+	printf("[%c] %s (%s)\n", (log_level_globals.log_level & BIT(2)) ? 'x' : ' ',
 	       "messages related to translation table operations", "tt");
-	printf("[%c] %s (%s)\n", (log_level & BIT(3)) ? 'x' : ' ',
+	printf("[%c] %s (%s)\n", (log_level_globals.log_level & BIT(3)) ? 'x' : ' ',
 	       "messages related to bridge loop avoidance", "bla");
-	printf("[%c] %s (%s)\n", (log_level & BIT(4)) ? 'x' : ' ',
+	printf("[%c] %s (%s)\n", (log_level_globals.log_level & BIT(4)) ? 'x' : ' ',
 	       "messages related to arp snooping and distributed arp table", "dat");
-	printf("[%c] %s (%s)\n", (log_level & BIT(5)) ? 'x' : ' ',
+	printf("[%c] %s (%s)\n", (log_level_globals.log_level & BIT(5)) ? 'x' : ' ',
 	       "messages related to network coding", "nc");
-	printf("[%c] %s (%s)\n", (log_level & BIT(6)) ? 'x' : ' ',
+	printf("[%c] %s (%s)\n", (log_level_globals.log_level & BIT(6)) ? 'x' : ' ',
 	       "messages related to multicast", "mcast");
-	printf("[%c] %s (%s)\n", (log_level & BIT(7)) ? 'x' : ' ',
+	printf("[%c] %s (%s)\n", (log_level_globals.log_level & BIT(7)) ? 'x' : ' ',
 	       "messages related to throughput meter", "tp");
 
 out:
@@ -145,5 +226,6 @@ static int loglevel(struct state *state, int argc, char **argv)
 	return res;
 }
 
-COMMAND(SUBCOMMAND, loglevel, "ll", COMMAND_FLAG_MESH_IFACE, NULL,
+COMMAND(SUBCOMMAND, loglevel, "ll",
+	COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK, NULL,
 	"[level]           \tdisplay or modify the log level");
-- 
2.20.1


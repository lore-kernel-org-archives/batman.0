Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 22 Oct 2018 00:54:55 +0200
Message-Id: <20181021225524.8155-10-sven@narfation.org>
In-Reply-To: <20181021225524.8155-1-sven@narfation.org>
References: <20181021225524.8155-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 09/38] batctl: Introduce datastructure for
 subcommands
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

The registration of more complex subcommands in batctl required a lot of
extra code to get it integrated in the main routine. This lead to a hard
to read main function which switches between the subcommand which performs
an action.

The command structure allows us to provide an simpler way to insert
functionality. It currently only works for complete separated commands
which operates on already existing batman-adv interface. But it is flexible
enough to later also support the rest of the commands.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 gw_mode.c         |  4 ++-
 gw_mode.h         | 28 ---------------------
 log.c             |  4 ++-
 log.h             | 28 ---------------------
 loglevel.c        |  4 ++-
 loglevel.h        | 28 ---------------------
 main.c            | 63 +++++++++++++++++------------------------------
 main.h            | 18 ++++++++++++++
 ping.c            |  5 ++--
 ping.h            | 28 ---------------------
 statistics.c      |  7 +++---
 statistics.h      | 28 ---------------------
 throughputmeter.c |  5 ++--
 throughputmeter.h | 28 ---------------------
 traceroute.c      |  5 ++--
 traceroute.h      | 28 ---------------------
 translate.c       |  5 ++--
 translate.h       | 28 ---------------------
 18 files changed, 66 insertions(+), 278 deletions(-)
 delete mode 100644 gw_mode.h
 delete mode 100644 log.h
 delete mode 100644 loglevel.h
 delete mode 100644 ping.h
 delete mode 100644 statistics.h
 delete mode 100644 throughputmeter.h
 delete mode 100644 traceroute.h
 delete mode 100644 translate.h

diff --git a/gw_mode.c b/gw_mode.c
index a92644e..884f38e 100644
--- a/gw_mode.c
+++ b/gw_mode.c
@@ -45,7 +45,7 @@ static void gw_mode_usage(void)
 	fprintf(stderr, " \t -h print this help\n");
 }
 
-int gw_mode(char *mesh_iface, int argc, char **argv)
+static int gw_mode(char *mesh_iface, int argc, char **argv)
 {
 	int optchar, res = EXIT_FAILURE;
 	char *path_buff, gw_mode;
@@ -166,3 +166,5 @@ int gw_mode(char *mesh_iface, int argc, char **argv)
 	free(path_buff);
 	return res;
 }
+
+COMMAND(gw_mode, "gw");
diff --git a/gw_mode.h b/gw_mode.h
deleted file mode 100644
index d4d3fb5..0000000
--- a/gw_mode.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
- *
- * Marek Lindner <mareklindner@neomailbox.ch>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
- * License-Filename: LICENSES/preferred/GPL-2.0
- */
-
-#ifndef _BATCTL_GW_MODE_H
-#define _BATCTL_GW_MODE_H
-
-int gw_mode(char *mesh_iface, int argc, char **argv);
-
-#endif
diff --git a/log.c b/log.c
index fc31c66..66594f6 100644
--- a/log.c
+++ b/log.c
@@ -36,7 +36,7 @@ static void log_usage(void)
 	fprintf(stderr, " \t -n don't replace mac addresses with bat-host names\n");
 }
 
-int log_print(char *mesh_iface, int argc, char **argv)
+static int log_print(char *mesh_iface, int argc, char **argv)
 {
 	int optchar, res, read_opt = USE_BAT_HOSTS | LOG_MODE;
 	char full_path[MAX_PATH+1];
@@ -68,3 +68,5 @@ int log_print(char *mesh_iface, int argc, char **argv)
 	res = read_file(full_path, DEBUG_LOG, read_opt, 0, 0, 0);
 	return res;
 }
+
+COMMAND_NAMED(log, "l", log_print);
diff --git a/log.h b/log.h
deleted file mode 100644
index 4ba00e3..0000000
--- a/log.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
- *
- * Marek Lindner <mareklindner@neomailbox.ch>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
- * License-Filename: LICENSES/preferred/GPL-2.0
- */
-
-#ifndef _BATCTL_LOG_H
-#define _BATCTL_LOG_H
-
-int log_print(char *mesh_iface, int argc, char **argv);
-
-#endif
diff --git a/loglevel.c b/loglevel.c
index 584cb37..3d9cf3a 100644
--- a/loglevel.c
+++ b/loglevel.c
@@ -47,7 +47,7 @@ static void log_level_usage(void)
 	fprintf(stderr, " \t tp      Messages related to throughput meter\n");
 }
 
-int loglevel(char *mesh_iface, int argc, char **argv)
+static int loglevel(char *mesh_iface, int argc, char **argv)
 {
 	int optchar, res = EXIT_FAILURE;
 	int log_level = 0;
@@ -142,3 +142,5 @@ int loglevel(char *mesh_iface, int argc, char **argv)
 	free(path_buff);
 	return res;
 }
+
+COMMAND(loglevel, "ll");
diff --git a/loglevel.h b/loglevel.h
deleted file mode 100644
index 2644f46..0000000
--- a/loglevel.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
- *
- * Marek Lindner <mareklindner@neomailbox.ch>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
- * License-Filename: LICENSES/preferred/GPL-2.0
- */
-
-#ifndef _BATCTL_LOGLEVEL_H
-#define _BATCTL_LOGLEVEL_H
-
-int loglevel(char *mesh_iface, int argc, char **argv);
-
-#endif
diff --git a/main.c b/main.c
index 34f5a62..14f4774 100644
--- a/main.c
+++ b/main.c
@@ -31,22 +31,17 @@
 #include "sys.h"
 #include "debug.h"
 #include "interface.h"
-#include "ping.h"
-#include "translate.h"
-#include "traceroute.h"
 #include "tcpdump.h"
-#include "throughputmeter.h"
 #include "bisect_iv.h"
-#include "statistics.h"
-#include "loglevel.h"
-#include "log.h"
-#include "gw_mode.h"
 #include "routing_algo.h"
 #include "functions.h"
 
 char mesh_dfl_iface[] = "bat0";
 char module_ver_path[] = "/sys/module/batman_adv/version";
 
+extern const struct command *__start___command[];
+extern const struct command *__stop___command[];
+
 static void print_usage(void)
 {
 	int i, opt_indent;
@@ -96,8 +91,26 @@ static void print_usage(void)
 #endif
 }
 
+static const struct command *find_command(const char *name)
+{
+	const struct command **p;
+
+	for (p = __start___command; p < __stop___command; p++) {
+		const struct command *cmd = *p;
+
+		if (strcmp(cmd->name, name) == 0)
+			return cmd;
+
+		if (strcmp(cmd->abbr, name) == 0)
+			return cmd;
+	}
+
+	return NULL;
+}
+
 int main(int argc, char **argv)
 {
+	const struct command *cmd;
 	int i, ret = EXIT_FAILURE;
 	char *mesh_iface = mesh_dfl_iface;
 
@@ -159,38 +172,8 @@ int main(int argc, char **argv)
 	} else if (check_mesh_iface(mesh_iface) < 0) {
 		fprintf(stderr, "Error - interface %s is not present or not a batman-adv interface\n", mesh_iface);
 		exit(EXIT_FAILURE);
-	} else if ((strcmp(argv[1], "ping") == 0) || (strcmp(argv[1], "p") == 0)) {
-
-		ret = ping(mesh_iface, argc - 1, argv + 1);
-
-	} else if ((strcmp(argv[1], "throughputmeter") == 0) || (strcmp(argv[1], "tp") == 0)) {
-
-		ret = throughputmeter(mesh_iface, argc -1, argv + 1);
-
-	} else if ((strcmp(argv[1], "traceroute") == 0) || (strcmp(argv[1], "tr") == 0)) {
-
-		ret = traceroute(mesh_iface, argc - 1, argv + 1);
-
-	} else if ((strcmp(argv[1], "loglevel") == 0) || (strcmp(argv[1], "ll") == 0)) {
-
-		ret = loglevel(mesh_iface, argc - 1, argv + 1);
-
-	} else if ((strcmp(argv[1], "log") == 0) || (strcmp(argv[1], "l") == 0)) {
-
-		ret = log_print(mesh_iface, argc - 1, argv + 1);
-
-	} else if ((strcmp(argv[1], "gw_mode") == 0) || (strcmp(argv[1], "gw") == 0)) {
-
-		ret = gw_mode(mesh_iface, argc - 1, argv + 1);
-
-	} else if ((strcmp(argv[1], "statistics") == 0) || (strcmp(argv[1], "s") == 0)) {
-
-		ret = statistics(mesh_iface, argc - 1, argv + 1);
-
-	} else if ((strcmp(argv[1], "translate") == 0) || (strcmp(argv[1], "t") == 0)) {
-
-		ret = translate(mesh_iface, argc - 1, argv + 1);
-
+	} else if ((cmd = find_command(argv[1]))) {
+		ret = cmd->handler(mesh_iface, argc - 1, argv + 1);
 	} else {
 
 		for (i = 0; i < BATCTL_SETTINGS_NUM; i++) {
diff --git a/main.h b/main.h
index e8c6db7..f7e2f64 100644
--- a/main.h
+++ b/main.h
@@ -57,4 +57,22 @@ extern char module_ver_path[];
 #define BATADV_PRINT_VID(vid) (vid & BATADV_VLAN_HAS_TAG ? \
 			       (int)(vid & VLAN_VID_MASK) : -1)
 
+struct command {
+	const char *name;
+	const char *abbr;
+	int (*handler)(char *mesh_iface, int argc, char **argv);
+};
+
+#define COMMAND_NAMED(_name, _abbr, _handler) \
+	static const struct command command_ ## _name = { \
+		.name = (#_name), \
+		.abbr = _abbr, \
+		.handler = (_handler), \
+	}; \
+	static const struct command *__command_ ## _name \
+	__attribute__((__used__)) __attribute__ ((__section__ ("__command"))) = &command_ ## _name
+
+#define COMMAND(_handler, _abbr) \
+	COMMAND_NAMED(_handler, _abbr, _handler)
+
 #endif
diff --git a/ping.c b/ping.c
index dc88e22..a4a1851 100644
--- a/ping.c
+++ b/ping.c
@@ -39,7 +39,6 @@
 
 #include "batadv_packet.h"
 #include "main.h"
-#include "ping.h"
 #include "functions.h"
 #include "bat-hosts.h"
 #include "debugfs.h"
@@ -73,7 +72,7 @@ static void sig_handler(int sig)
 	}
 }
 
-int ping(char *mesh_iface, int argc, char **argv)
+static int ping(char *mesh_iface, int argc, char **argv)
 {
 	struct batadv_icmp_packet_rr icmp_packet_out, icmp_packet_in;
 	struct timeval tv;
@@ -345,3 +344,5 @@ int ping(char *mesh_iface, int argc, char **argv)
 	bat_hosts_free();
 	return ret;
 }
+
+COMMAND(ping, "p");
diff --git a/ping.h b/ping.h
deleted file mode 100644
index f09ffb2..0000000
--- a/ping.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
- *
- * Marek Lindner <mareklindner@neomailbox.ch>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
- * License-Filename: LICENSES/preferred/GPL-2.0
- */
-
-#ifndef _BATCTL_PING_H
-#define _BATCTL_PING_H
-
-int ping(char *mesh_iface, int argc, char **argv);
-
-#endif
diff --git a/statistics.c b/statistics.c
index 8a889ca..dea3ac1 100644
--- a/statistics.c
+++ b/statistics.c
@@ -35,7 +35,6 @@
 #include <stdint.h>
 
 #include "main.h"
-#include "statistics.h"
 
 void check_root_or_die(const char *cmd);
 
@@ -103,8 +102,8 @@ static int statistics_custom_get(int fd, struct ifreq *ifr)
 	return ret;
 }
 
-int statistics(char *mesh_iface, int argc __maybe_unused,
-	       char **argv __maybe_unused)
+static int statistics(char *mesh_iface, int argc __maybe_unused,
+		      char **argv __maybe_unused)
 {
 	struct ifreq ifr;
 	int fd = -1, ret = EXIT_FAILURE;
@@ -126,3 +125,5 @@ int statistics(char *mesh_iface, int argc __maybe_unused,
 		close(fd);
 	return ret;
 }
+
+COMMAND(statistics, "s");
diff --git a/statistics.h b/statistics.h
deleted file mode 100644
index 3737a48..0000000
--- a/statistics.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2012-2018  B.A.T.M.A.N. contributors:
- *
- * Marek Lindner <mareklindner@neomailbox.ch>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
- * License-Filename: LICENSES/preferred/GPL-2.0
- */
-
-#ifndef _BATCTL_STATISTICS_H
-#define _BATCTL_STATISTICS_H
-
-int statistics(char *mesh_iface, int argc, char **argv);
-
-#endif
diff --git a/throughputmeter.c b/throughputmeter.c
index bb53d56..372bfc4 100644
--- a/throughputmeter.c
+++ b/throughputmeter.c
@@ -21,7 +21,6 @@
  */
 
 #include "main.h"
-#include "throughputmeter.h"
 
 #include <netinet/ether.h>
 #include <netinet/in.h>
@@ -389,7 +388,7 @@ static void tp_meter_usage(void)
 	fprintf(stderr, "\t -n don't convert addresses to bat-host names\n");
 }
 
-int throughputmeter(char *mesh_iface, int argc, char **argv)
+static int throughputmeter(char *mesh_iface, int argc, char **argv)
 {
 	struct bat_host *bat_host;
 	uint64_t throughput;
@@ -543,3 +542,5 @@ int throughputmeter(char *mesh_iface, int argc, char **argv)
 	bat_hosts_free();
 	return ret;
 }
+
+COMMAND(throughputmeter, "tp");
diff --git a/throughputmeter.h b/throughputmeter.h
deleted file mode 100644
index 2c04c12..0000000
--- a/throughputmeter.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2013-2018  B.A.T.M.A.N. contributors:
- *
- * Antonio Quartulli <a@unstable.cc>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
- * License-Filename: LICENSES/preferred/GPL-2.0
- */
-
-#ifndef _BATCTL_THROUGHPUTMETER_H
-#define _BATCTL_THROUGHPUTMETER_H
-
-int throughputmeter(char *mesh_iface, int argc, char **argv);
-
-#endif /* _BATCTL_THROUGHPUTMETER_H */
diff --git a/traceroute.c b/traceroute.c
index ba7e27d..5c55c7b 100644
--- a/traceroute.c
+++ b/traceroute.c
@@ -36,7 +36,6 @@
 
 #include "batadv_packet.h"
 #include "main.h"
-#include "traceroute.h"
 #include "functions.h"
 #include "bat-hosts.h"
 #include "debugfs.h"
@@ -56,7 +55,7 @@ static void traceroute_usage(void)
 	fprintf(stderr, " \t -T don't try to translate mac to originator address\n");
 }
 
-int traceroute(char *mesh_iface, int argc, char **argv)
+static int traceroute(char *mesh_iface, int argc, char **argv)
 {
 	struct batadv_icmp_packet icmp_packet_out, icmp_packet_in;
 	struct bat_host *bat_host;
@@ -231,3 +230,5 @@ int traceroute(char *mesh_iface, int argc, char **argv)
 	bat_hosts_free();
 	return ret;
 }
+
+COMMAND(traceroute, "tr");
diff --git a/traceroute.h b/traceroute.h
deleted file mode 100644
index ffe0252..0000000
--- a/traceroute.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
- *
- * Marek Lindner <mareklindner@neomailbox.ch>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
- * License-Filename: LICENSES/preferred/GPL-2.0
- */
-
-#ifndef _BATCTL_TRACEROUTE_H
-#define _BATCTL_TRACEROUTE_H
-
-int traceroute(char *mesh_iface, int argc, char **argv);
-
-#endif
diff --git a/translate.c b/translate.c
index 9059f20..ec6baaf 100644
--- a/translate.c
+++ b/translate.c
@@ -24,7 +24,6 @@
 #include <stdlib.h>
 
 #include "main.h"
-#include "translate.h"
 #include "functions.h"
 #include "bat-hosts.h"
 
@@ -34,7 +33,7 @@ static void translate_usage(void)
 	fprintf(stderr, "Usage: batctl [options] translate mac|bat-host|host_name|IPv4_address\n");
 }
 
-int translate(char *mesh_iface, int argc, char **argv)
+static int translate(char *mesh_iface, int argc, char **argv)
 {
 	struct ether_addr *dst_mac = NULL;
 	struct bat_host *bat_host;
@@ -78,3 +77,5 @@ int translate(char *mesh_iface, int argc, char **argv)
 	bat_hosts_free();
 	return ret;
 }
+
+COMMAND(translate, "t");
diff --git a/translate.h b/translate.h
deleted file mode 100644
index 8155827..0000000
--- a/translate.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
- *
- * Marek Lindner <mareklindner@neomailbox.ch>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
- * License-Filename: LICENSES/preferred/GPL-2.0
- */
-
-#ifndef _BATCTL_TRANSLATE_H
-#define _BATCTL_TRANSLATE_H
-
-int translate(char *mesh_iface, int argc, char **argv);
-
-#endif
-- 
2.19.1


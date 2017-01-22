Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 22 Jan 2017 13:21:08 +0100
Message-Id: <20170122122113.29588-4-sven@narfation.org>
In-Reply-To: <3266034.EiLA6asg3G@sven-edge>
References: <3266034.EiLA6asg3G@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH 4/9] batctl: Make root privileges check
	function specific
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

It is a long standing TODO to move the root check to each batctl
sub-application. This will allow later to make the checks specific to the
requirements for each function instead of disallowing the use of batctl for
non-root users completely.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 debug.c      | 6 ++++++
 interface.c  | 2 ++
 ioctl.c      | 3 +++
 main.c       | 5 -----
 ping.c       | 2 ++
 sys.c        | 8 ++++++++
 tcpdump.c    | 2 ++
 tp_meter.c   | 2 ++
 traceroute.c | 2 ++
 translate.c  | 2 ++
 10 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/debug.c b/debug.c
index ee04928..07a91c4 100644
--- a/debug.c
+++ b/debug.c
@@ -219,6 +219,8 @@ int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv)
 		}
 	}
 
+	check_root_or_die("batctl");
+
 	if (read_opt & UNICAST_ONLY && read_opt & MULTICAST_ONLY) {
 		fprintf(stderr, "Error - '-u' and '-m' are exclusive options\n");
 		debug_table_usage(debug_table);
@@ -270,6 +272,8 @@ int print_vis_info(char *mesh_iface)
 	char *debugfs_mnt;
 	FILE *fp;
 
+	check_root_or_die("batctl vis_data");
+
 	debugfs_mnt = debugfs_mount(NULL);
 	if (!debugfs_mnt) {
 		fprintf(stderr, "Error - can't mount or find debugfs\n");
@@ -318,6 +322,8 @@ int log_print(char *mesh_iface, int argc, char **argv)
 		}
 	}
 
+	check_root_or_die("batctl log");
+
 	debugfs_mnt = debugfs_mount(NULL);
 	if (!debugfs_mnt) {
 		fprintf(stderr, "Error - can't mount or find debugfs\n");
diff --git a/interface.c b/interface.c
index 8cc4f92..01ee6fc 100644
--- a/interface.c
+++ b/interface.c
@@ -324,6 +324,8 @@ int interface(char *mesh_iface, int argc, char **argv)
 		}
 	}
 
+	check_root_or_die("batctl interface");
+
 	rest_argc = argc - optind;
 	rest_argv = &argv[optind];
 
diff --git a/ioctl.c b/ioctl.c
index b1db5e4..2ef4f8b 100644
--- a/ioctl.c
+++ b/ioctl.c
@@ -33,6 +33,7 @@
 #include <linux/ethtool.h>
 #include <stdint.h>
 
+#include "functions.h"
 #include "ioctl.h"
 
 /* code borrowed from ethtool */
@@ -104,6 +105,8 @@ int ioctl_statistics_get(char *mesh_iface)
 	struct ifreq ifr;
 	int fd = -1, ret = EXIT_FAILURE;
 
+	check_root_or_die("batctl statistics");
+
 	memset(&ifr, 0, sizeof(ifr));
 	strncpy(ifr.ifr_name, mesh_iface, sizeof(ifr.ifr_name));
 	ifr.ifr_name[sizeof(ifr.ifr_name) - 1] = '\0';
diff --git a/main.c b/main.c
index 2fc9b75..02d89c4 100644
--- a/main.c
+++ b/main.c
@@ -134,11 +134,6 @@ int main(int argc, char **argv)
 		exit(EXIT_SUCCESS);
 	}
 
-	/* TODO: remove this generic check here and move it into the individual functions */
-	/* check if user is root */
-	if (strncmp(argv[1], "bisect", strlen("bisect")) != 0)
-		check_root_or_die(argv[0]);
-
 	if ((strcmp(argv[1], "interface") == 0) || (strcmp(argv[1], "if") == 0)) {
 
 		ret = interface(mesh_iface, argc - 1, argv + 1);
diff --git a/ping.c b/ping.c
index 4fef663..4f83afe 100644
--- a/ping.c
+++ b/ping.c
@@ -133,6 +133,8 @@ int ping(char *mesh_iface, int argc, char **argv)
 		return EXIT_FAILURE;
 	}
 
+	check_root_or_die("batctl ping");
+
 	dst_string = argv[found_args];
 	bat_hosts_init(0);
 	bat_host = bat_hosts_find_by_name(dst_string);
diff --git a/sys.c b/sys.c
index 7817234..9dcb4f2 100644
--- a/sys.c
+++ b/sys.c
@@ -152,6 +152,8 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv)
 		}
 	}
 
+	check_root_or_die("batctl loglevel");
+
 	path_buff = malloc(PATH_BUFF_LEN);
 	snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT, mesh_iface);
 
@@ -251,6 +253,8 @@ int handle_sys_setting(char *mesh_iface, int setting, int argc, char **argv)
 		}
 	}
 
+	check_root_or_die("batctl");
+
 	/* prepare the classic path */
 	path_buff = malloc(PATH_BUFF_LEN);
 	snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT, mesh_iface);
@@ -324,6 +328,8 @@ int handle_gw_setting(char *mesh_iface, int argc, char **argv)
 		}
 	}
 
+	check_root_or_die("batctl gw_mode");
+
 	path_buff = malloc(PATH_BUFF_LEN);
 	snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT, mesh_iface);
 
@@ -449,6 +455,8 @@ int handle_ra_setting(int argc, char **argv)
 		}
 	}
 
+	check_root_or_die("batctl routing_algo");
+
 	if (argc == 2) {
 		res = write_file(SYS_SELECTED_RA_PATH, "", argv[1], NULL);
 		goto out;
diff --git a/tcpdump.c b/tcpdump.c
index c7e0cbc..d52a451 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -1165,6 +1165,8 @@ int tcpdump(int argc, char **argv)
 		return EXIT_FAILURE;
 	}
 
+	check_root_or_die("batctl tcpdump");
+
 	bat_hosts_init(read_opt);
 
 	/* init interfaces list */
diff --git a/tp_meter.c b/tp_meter.c
index 4f4122c..918fb79 100644
--- a/tp_meter.c
+++ b/tp_meter.c
@@ -432,6 +432,8 @@ int tp_meter(char *mesh_iface, int argc, char **argv)
 		return EXIT_FAILURE;
 	}
 
+	check_root_or_die("batctl throughputmeter");
+
 	dst_string = argv[found_args];
 	bat_hosts_init(read_opt);
 	bat_host = bat_hosts_find_by_name(dst_string);
diff --git a/traceroute.c b/traceroute.c
index e7c55ef..124ce7c 100644
--- a/traceroute.c
+++ b/traceroute.c
@@ -94,6 +94,8 @@ int traceroute(char *mesh_iface, int argc, char **argv)
 		return EXIT_FAILURE;
 	}
 
+	check_root_or_die("batctl traceroute");
+
 	dst_string = argv[found_args];
 	bat_hosts_init(read_opt);
 	bat_host = bat_hosts_find_by_name(dst_string);
diff --git a/translate.c b/translate.c
index 18bde4d..31da3a3 100644
--- a/translate.c
+++ b/translate.c
@@ -46,6 +46,8 @@ int translate(char *mesh_iface, int argc, char **argv)
 		return EXIT_FAILURE;
 	}
 
+	check_root_or_die("batctl translate");
+
 	dst_string = argv[1];
 	bat_hosts_init(0);
 	bat_host = bat_hosts_find_by_name(dst_string);
-- 
2.11.0


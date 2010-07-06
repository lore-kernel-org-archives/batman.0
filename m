Return-Path: <an.langer@gmx.de>
From: Andreas Langer <an.langer@gmx.de>
Date: Tue,  6 Jul 2010 17:59:19 +0200
Message-Id: <1278431960-4636-1-git-send-email-an.langer@gmx.de>
In-Reply-To: <20100706175814.6927f767@rechenknecht>
References: <20100706175814.6927f767@rechenknecht>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batctl: layer2 unicast packet
	fragmentation
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.net

This patch add options to enable/disable fragmentation

Signed-off-by: Andreas Langer <an.langer at gmx.de>
---
 batctl/main.c |   41 +++++++++++++++++++++++------------------
 batctl/sys.c  |    7 +++++++
 batctl/sys.h  |    2 ++
 3 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/batctl/main.c b/batctl/main.c
index 0506dce..1ee4279 100644
--- a/batctl/main.c
+++ b/batctl/main.c
@@ -1,7 +1,7 @@
 /*
  * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
  *
- * Andreas Langer <a.langer@q-dsl.de>, Marek Lindner <lindner_marek@yahoo.de>
+ * Andreas Langer <an.langer@gmx.de>, Marek Lindner <lindner_marek@yahoo.de>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of version 2 of the GNU General Public
@@ -41,24 +41,25 @@
 void print_usage(void) {
 	printf("Usage: batctl [options] commands \n");
 	printf("commands:\n");
-	printf(" \tinterface|if   [add|del iface(s)]\tdisplay or modify the interface settings\n");
-	printf(" \toriginators|o                    \tdisplay the originator table\n");
-	printf(" \tinterval|it    [orig_interval]   \tdisplay or modify the originator interval (in ms)\n");
-	printf(" \tloglevel|ll    [level]           \tdisplay or modify the log level\n");
-	printf(" \tlog|l                            \tread the log produced by the kernel module\n");
-	printf(" \tgw_mode|gw     [mode]            \tdisplay or modify the gateway mode\n");
-	printf(" \tgateways|gwl                     \tdisplay the gateway server list\n");
-	printf(" \ttranslocal|tl                    \tdisplay the local translation table\n");
-	printf(" \ttransglobal|tg                   \tdisplay the global translation table\n");
-	printf(" \tvis_mode|vm    [mode]            \tdisplay or modify the status of the VIS server\n");
-	printf(" \tvis_data|vd    [dot|JSON]        \tdisplay the VIS data in dot or JSON format\n");
-	printf(" \taggregation|ag [0|1]             \tdisplay or modify the packet aggregation setting\n");
-	printf(" \tbonding|b      [0|1]             \tdisplay or modify the bonding mode setting\n");
+	printf(" \tinterface|if    [add|del iface(s)]\tdisplay or modify the interface settings\n");
+	printf(" \toriginators|o                     \tdisplay the originator table\n");
+	printf(" \tinterval|it     [orig_interval]   \tdisplay or modify the originator interval (in ms)\n");
+	printf(" \tloglevel|ll     [level]           \tdisplay or modify the log level\n");
+	printf(" \tlog|l                             \tread the log produced by the kernel module\n");
+	printf(" \tgw_mode|gw      [mode]            \tdisplay or modify the gateway mode\n");
+	printf(" \tgateways|gwl                      \tdisplay the gateway server list\n");
+	printf(" \ttranslocal|tl                     \tdisplay the local translation table\n");
+	printf(" \ttransglobal|tg                    \tdisplay the global translation table\n");
+	printf(" \tvis_mode|vm     [mode]            \tdisplay or modify the status of the VIS server\n");
+	printf(" \tvis_data|vd     [dot|JSON]        \tdisplay the VIS data in dot or JSON format\n");
+	printf(" \taggregation|ag  [0|1]             \tdisplay or modify the packet aggregation setting\n");
+	printf(" \tbonding|b       [0|1]             \tdisplay or modify the bonding mode setting\n");
+	printf(" \tfragmentation|f [0|1]             \tdisplay or modify the fragmentation mode setting\n");
 	printf("\n");
-	printf(" \tping|p         <destination>     \tping another batman adv host via layer 2\n");
-	printf(" \ttraceroute|tr  <destination>     \ttraceroute another batman adv host via layer 2\n");
-	printf(" \ttcpdump|td     <interface>       \ttcpdump layer 2 traffic on the given interface\n");
-	printf(" \tbisect         <file1> .. <fileN>\tanalyze given log files for routing stability\n");
+	printf(" \tping|p          <destination>     \tping another batman adv host via layer 2\n");
+	printf(" \ttraceroute|tr   <destination>     \ttraceroute another batman adv host via layer 2\n");
+	printf(" \ttcpdump|td      <interface>       \ttcpdump layer 2 traffic on the given interface\n");
+	printf(" \tbisect          <file1> .. <fileN>\tanalyze given log files for routing stability\n");
 	printf("options:\n");
 	printf(" \t-h print this help (or 'batctl <command> -h' for the command specific help)\n");
 	printf(" \t-v print version\n");
@@ -149,6 +150,10 @@ int main(int argc, char **argv)
 
 		ret = handle_sys_setting(argc - 1, argv + 1, SYS_BONDING, bonding_usage, sysfs_param_enable);
 
+	} else if ((strcmp(argv[1], "fragmentation") == 0) || (strcmp(argv[1], "f") == 0)) {
+
+		ret = handle_sys_setting(argc - 1, argv + 1, SYS_FRAG, fragmentation_usage, sysfs_param_enable);
+
 	} else if ((strcmp(argv[1], "bisect") == 0)) {
 
 		ret = bisect(argc - 1, argv + 1);
diff --git a/batctl/sys.c b/batctl/sys.c
index 321dfc9..1fa59d8 100644
--- a/batctl/sys.c
+++ b/batctl/sys.c
@@ -252,6 +252,13 @@ void orig_interval_usage(void)
 	printf(" \t -h print this help\n");
 }
 
+void fragmentation_usage(void)
+{
+	printf("Usage: batctl [options] fragmentation [0|1]\n");
+	printf("options:\n");
+	printf(" \t -h print this help\n");
+}
+
 int handle_sys_setting(int argc, char **argv,
 		       char *file_path, void setting_usage(void),
 		       const char *sysfs_param[])
diff --git a/batctl/sys.h b/batctl/sys.h
index 7a1db03..7e0d52e 100644
--- a/batctl/sys.h
+++ b/batctl/sys.h
@@ -31,12 +31,14 @@
 #define SYS_IFACE_PATH "/sys/class/net"
 #define SYS_MESH_IFACE_FMT SYS_IFACE_PATH"/%s/batman_adv/mesh_iface"
 #define SYS_IFACE_STATUS_FMT SYS_IFACE_PATH"/%s/batman_adv/iface_status"
+#define SYS_FRAG "fragmentation"
 
 extern const char *sysfs_param_enable[];
 extern const char *sysfs_param_server[];
 
 void aggregation_usage(void);
 void bonding_usage(void);
+void fragmentation_usage(void);
 void gw_mode_usage(void);
 void vis_mode_usage(void);
 void orig_interval_usage(void);
-- 
1.7.0.4


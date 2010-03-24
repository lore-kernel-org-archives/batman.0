Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 24 Mar 2010 12:52:40 +0800
Message-Id: <1269406363-9593-2-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <201003241252.18954.lindner_marek@yahoo.de>
References: <201003241252.18954.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/5] batctl: follow the orig_interval move to
	/sys
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 batctl/main.c |    4 ++--
 batctl/proc.c |    7 -------
 batctl/proc.h |    2 --
 batctl/sys.c  |    7 +++++++
 batctl/sys.h  |    2 ++
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/batctl/main.c b/batctl/main.c
index a07e75b..da7fb4a 100644
--- a/batctl/main.c
+++ b/batctl/main.c
@@ -43,7 +43,7 @@ void print_usage(void) {
 	printf("commands:\n");
 	printf(" \tinterface|if   [none|interface]  \tdisplay or modify the interface settings\n");
 	printf(" \toriginators|o                    \tdisplay the originator table\n");
-	printf(" \tinterval|it    [orig_interval]   \tdisplay or modify the originator interval in ms\n");
+	printf(" \tinterval|it    [orig_interval]   \tdisplay or modify the originator interval (in ms)\n");
 	printf(" \tloglevel|ll    [level]           \tdisplay or modify the log level\n");
 	printf(" \tlog|l                            \tread the log produced by the kernel module\n");
 	printf(" \tgw_mode|gw     [mode]            \tdisplay or modify the gateway mode\n");
@@ -123,7 +123,7 @@ int main(int argc, char **argv)
 
 	} else if ((strcmp(argv[1], "interval") == 0) || (strcmp(argv[1], "it") == 0)) {
 
-		ret = handle_proc_setting(argc - 1, argv + 1, PROC_ORIG_INTERVAL, orig_interval_usage);
+		ret = handle_sys_setting(argc - 1, argv + 1, SYS_ORIG_INTERVAL, orig_interval_usage);
 
 	} else if ((strcmp(argv[1], "vis_mode") == 0) || (strcmp(argv[1], "vm") == 0)) {
 
diff --git a/batctl/proc.c b/batctl/proc.c
index 9f5c24f..192d4fb 100644
--- a/batctl/proc.c
+++ b/batctl/proc.c
@@ -68,13 +68,6 @@ int interface(int argc, char **argv)
 	return EXIT_SUCCESS;
 }
 
-void orig_interval_usage(void)
-{
-	printf("Usage: batctl [options] interval \n");
-	printf("options:\n");
-	printf(" \t -h print this help\n");
-}
-
 int handle_table(int argc, char **argv, char *file_path, void table_usage(void))
 {
 	int optchar, read_opt = USE_BAT_HOSTS;
diff --git a/batctl/proc.h b/batctl/proc.h
index 0b5a6f2..61d6058 100644
--- a/batctl/proc.h
+++ b/batctl/proc.h
@@ -21,10 +21,8 @@
 
 #define PROC_ROOT_PATH "/proc/net/batman-adv/"
 #define PROC_INTERFACES "interfaces"
-#define PROC_ORIG_INTERVAL "orig_interval"
 
 int interface(int argc, char **argv);
 
-void orig_interval_usage(void);
 int handle_table(int argc, char **argv, char *file_path, void table_usage(void));
 int handle_proc_setting(int argc, char **argv, char *file_path, void setting_usage(void));
diff --git a/batctl/sys.c b/batctl/sys.c
index 7d035d6..cd8979a 100644
--- a/batctl/sys.c
+++ b/batctl/sys.c
@@ -207,6 +207,13 @@ void vis_mode_usage(void)
 	printf(" \t -h print this help\n");
 }
 
+void orig_interval_usage(void)
+{
+	printf("Usage: batctl [options] interval \n");
+	printf("options:\n");
+	printf(" \t -h print this help\n");
+}
+
 int handle_sys_setting(int argc, char **argv, char *file_path, void setting_usage(void))
 {
 	int optchar, res;
diff --git a/batctl/sys.h b/batctl/sys.h
index 4f10cee..19d19f5 100644
--- a/batctl/sys.h
+++ b/batctl/sys.h
@@ -33,6 +33,7 @@
 #define SYS_GATEWAYS "gateways"
 #define SYS_VIS_MODE "vis_mode"
 #define SYS_VIS_DATA "vis_data"
+#define SYS_ORIG_INTERVAL "orig_interval"
 
 void originators_usage(void);
 void trans_local_usage(void);
@@ -42,6 +43,7 @@ void bonding_usage(void);
 void gw_mode_usage(void);
 void gateways_usage(void);
 void vis_mode_usage(void);
+void orig_interval_usage(void);
 int log_print(int argc, char **argv);
 int handle_loglevel(int argc, char **argv);
 int handle_sys_table(int argc, char **argv, char *file_path, void table_usage(void));
-- 
1.7.0


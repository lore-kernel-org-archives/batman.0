Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 10 Sep 2013 23:11:55 +0200
Message-Id: <1378847522-13776-5-git-send-email-sven@narfation.org>
In-Reply-To: <1378847522-13776-1-git-send-email-sven@narfation.org>
References: <1378847522-13776-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 04/11] batctl: Mark all local functions as
	static
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
Cc: Sven Eckelmann <sven@narfation.org>

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 debug.c      | 2 +-
 main.c       | 2 +-
 ping.c       | 4 ++--
 traceroute.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/debug.c b/debug.c
index 3ea112a..2589dbc 100644
--- a/debug.c
+++ b/debug.c
@@ -84,7 +84,7 @@ const struct debug_table_data batctl_debug_tables[BATCTL_TABLE_NUM] = {
 	},
 };
 
-void debug_table_usage(int debug_table)
+static void debug_table_usage(int debug_table)
 {
 	fprintf(stderr, "Usage: batctl [options] %s|%s [parameters]\n",
 	       batctl_debug_tables[debug_table].opt_long, batctl_debug_tables[debug_table].opt_short);
diff --git a/main.c b/main.c
index 24d42fb..6b44359 100644
--- a/main.c
+++ b/main.c
@@ -43,7 +43,7 @@
 char mesh_dfl_iface[] = "bat0";
 char module_ver_path[] = "/sys/module/batman_adv/version";
 
-void print_usage(void)
+static void print_usage(void)
 {
 	int i, opt_indent;
 
diff --git a/ping.c b/ping.c
index 6679604..4d76484 100644
--- a/ping.c
+++ b/ping.c
@@ -42,7 +42,7 @@
 char is_aborted = 0;
 
 
-void ping_usage(void)
+static void ping_usage(void)
 {
 	fprintf(stderr, "Usage: batctl [options] ping [parameters] mac|bat-host|host_name|IPv4_address \n");
 	fprintf(stderr, "parameters:\n");
@@ -54,7 +54,7 @@ void ping_usage(void)
 	fprintf(stderr, " \t -T don't try to translate mac to originator address\n");
 }
 
-void sig_handler(int sig)
+static void sig_handler(int sig)
 {
 	switch (sig) {
 	case SIGINT:
diff --git a/traceroute.c b/traceroute.c
index 362d293..d62df5e 100644
--- a/traceroute.c
+++ b/traceroute.c
@@ -41,7 +41,7 @@
 #define NUM_PACKETS 3
 
 
-void traceroute_usage(void)
+static void traceroute_usage(void)
 {
 	fprintf(stderr, "Usage: batctl [options] traceroute [parameters] mac|bat-host|host_name|IPv4_address \n");
 	fprintf(stderr, "parameters:\n");
-- 
1.8.4.rc3


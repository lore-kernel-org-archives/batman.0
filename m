Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 20 Jun 2009 21:18:00 +0200
Message-Id: <1245525480-23538-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] [batctl] Expand ~ in paths to host files
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.net


Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batctl/bat-hosts.c |   21 ++++++++++++++++++---
 1 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/batctl/bat-hosts.c b/batctl/bat-hosts.c
index 95d105f..e997ad0 100644
--- a/batctl/bat-hosts.c
+++ b/batctl/bat-hosts.c
@@ -67,7 +67,6 @@ static void parse_hosts_file(struct hashtable_t *hash, const char path[])
 	struct hashtable_t *swaphash;
 
 	name[0] = mac_str[0] = '\0';
-
 	fd = fopen(path, "r");
 	if (fd == NULL)
 		return;
@@ -129,6 +128,9 @@ static void parse_hosts_file(struct hashtable_t *hash, const char path[])
 void bat_hosts_init(void)
 {
 	unsigned int i;
+#define CONF_DIR_LEN 256
+	char confdir[CONF_DIR_LEN];
+	char *homedir;
 
 	host_hash = hash_new(64, compare_mac, choose_mac);
 
@@ -137,8 +139,21 @@ void bat_hosts_init(void)
 		return;
 	}
 
-	for (i = 0; i < sizeof(bat_hosts_path) / sizeof(char *); i++)
-		parse_hosts_file(host_hash, bat_hosts_path[i]);
+	homedir = getenv("HOME");
+
+	for (i = 0; i < sizeof(bat_hosts_path) / sizeof(char *); i++) {
+		strcpy(confdir, "");
+		if (strlen(bat_hosts_path[i]) >= 2
+		    && bat_hosts_path[i][0] == '~' && bat_hosts_path[i][1] == '/') {
+			strncpy(confdir, homedir, CONF_DIR_LEN);
+			confdir[CONF_DIR_LEN - 1] = '\0';
+			strncat(confdir, &bat_hosts_path[i][1], CONF_DIR_LEN - strlen(confdir));
+		} else {
+			strncpy(confdir, bat_hosts_path[i], CONF_DIR_LEN);
+			confdir[CONF_DIR_LEN - 1] = '\0';
+		}
+		parse_hosts_file(host_hash, confdir);
+	}
 }
 
 struct bat_host *bat_hosts_find_by_name(char *name)
-- 
1.6.3.1


Return-Path: <sven.eckelmann@openmesh.com>
From: Sven Eckelmann <sven.eckelmann@openmesh.com>
Date: Thu, 23 Nov 2017 15:04:44 +0100
Message-Id: <20171123140444.17119-11-sven.eckelmann@openmesh.com>
In-Reply-To: <20171123140444.17119-1-sven.eckelmann@openmesh.com>
References: <20171123140444.17119-1-sven.eckelmann@openmesh.com>
Subject: [B.A.T.M.A.N.] [PATCH 10/10] batctl: Simplify concatenation of
 pathnames
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
Cc: Sven Eckelmann <sven.eckelmann@openmesh.com>

The combination of strncpy and strncat is hard to read and it is rather
easy to introduce some kind of problems when using that. The usage of
snprintf simplifies it slightly.

Signed-off-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
---
 bat-hosts.c | 4 +---
 functions.c | 8 ++------
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/bat-hosts.c b/bat-hosts.c
index b530243..54b0a18 100644
--- a/bat-hosts.c
+++ b/bat-hosts.c
@@ -194,9 +194,7 @@ void bat_hosts_init(int read_opt)
 			if (!homedir)
 				continue;
 
-			strncpy(confdir, homedir, CONF_DIR_LEN);
-			confdir[CONF_DIR_LEN - 1] = '\0';
-			strncat(confdir, &bat_hosts_path[i][1], CONF_DIR_LEN - strlen(confdir) - 1);
+			snprintf(confdir, CONF_DIR_LEN, "%s%s", homedir, &bat_hosts_path[i][1]);
 		} else {
 			strncpy(confdir, bat_hosts_path[i], CONF_DIR_LEN);
 			confdir[CONF_DIR_LEN - 1] = '\0';
diff --git a/functions.c b/functions.c
index 868e0ae..8bcf52d 100644
--- a/functions.c
+++ b/functions.c
@@ -208,9 +208,7 @@ int read_file(const char *dir, const char *fname, int read_opt,
 	if (read_opt & USE_BAT_HOSTS)
 		bat_hosts_init(read_opt);
 
-	strncpy(full_path, dir, sizeof(full_path));
-	full_path[sizeof(full_path) - 1] = '\0';
-	strncat(full_path, fname, sizeof(full_path) - strlen(full_path) - 1);
+	snprintf(full_path, sizeof(full_path), "%s%s", dir, fname);
 
 open:
 	line = 0;
@@ -349,9 +347,7 @@ int write_file(const char *dir, const char *fname, const char *arg1,
 	char full_path[500];
 	ssize_t write_len;
 
-	strncpy(full_path, dir, sizeof(full_path));
-	full_path[sizeof(full_path) - 1] = '\0';
-	strncat(full_path, fname, sizeof(full_path) - strlen(full_path) - 1);
+	snprintf(full_path, sizeof(full_path), "%s%s", dir, fname);
 
 	fd = open(full_path, O_WRONLY);
 
-- 
2.11.0


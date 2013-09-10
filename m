Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 10 Sep 2013 23:11:52 +0200
Message-Id: <1378847522-13776-2-git-send-email-sven@narfation.org>
In-Reply-To: <1378847522-13776-1-git-send-email-sven@narfation.org>
References: <1378847522-13776-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 01/11] batctl: Fix possible buffer overflow
	when using strncat
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

The length field (n) of strncat is used to specify the length of the buffer
without the \0 delimiter. strncat will add it even when it will write it to the
limit of n bytes was written.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bat-hosts.c | 2 +-
 functions.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/bat-hosts.c b/bat-hosts.c
index 04e7a9b..f0adb9c 100644
--- a/bat-hosts.c
+++ b/bat-hosts.c
@@ -194,7 +194,7 @@ void bat_hosts_init(int read_opt)
 
 			strncpy(confdir, homedir, CONF_DIR_LEN);
 			confdir[CONF_DIR_LEN - 1] = '\0';
-			strncat(confdir, &bat_hosts_path[i][1], CONF_DIR_LEN - strlen(confdir));
+			strncat(confdir, &bat_hosts_path[i][1], CONF_DIR_LEN - strlen(confdir) - 1);
 		} else {
 			strncpy(confdir, bat_hosts_path[i], CONF_DIR_LEN);
 			confdir[CONF_DIR_LEN - 1] = '\0';
diff --git a/functions.c b/functions.c
index cc05a48..0359287 100644
--- a/functions.c
+++ b/functions.c
@@ -180,7 +180,7 @@ int read_file(char *dir, char *fname, int read_opt,
 
 	strncpy(full_path, dir, strlen(dir));
 	full_path[strlen(dir)] = '\0';
-	strncat(full_path, fname, sizeof(full_path) - strlen(full_path));
+	strncat(full_path, fname, sizeof(full_path) - strlen(full_path) - 1);
 
 open:
 	line = 0;
@@ -305,7 +305,7 @@ int write_file(char *dir, char *fname, char *arg1, char *arg2)
 
 	strncpy(full_path, dir, strlen(dir));
 	full_path[strlen(dir)] = '\0';
-	strncat(full_path, fname, sizeof(full_path) - strlen(full_path));
+	strncat(full_path, fname, sizeof(full_path) - strlen(full_path) - 1);
 
 	fd = open(full_path, O_WRONLY);
 
-- 
1.8.4.rc3


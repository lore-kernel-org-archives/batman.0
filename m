Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 10 Sep 2013 23:11:54 +0200
Message-Id: <1378847522-13776-4-git-send-email-sven@narfation.org>
In-Reply-To: <1378847522-13776-1-git-send-email-sven@narfation.org>
References: <1378847522-13776-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 03/11] batctl: Avoid assigning const buffer
	to non-const pointer
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

Strings in C are tried to be saved in the .rodata by the compiler/linker. This
section is readonly as the name suggests. Pointer to these strings should
therefore be const.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 functions.c | 8 +++++---
 functions.h | 5 +++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/functions.c b/functions.c
index 2a2f392..bd4da59 100644
--- a/functions.c
+++ b/functions.c
@@ -124,7 +124,8 @@ int file_exists(const char *fpath)
 	return stat(fpath, &st) == 0;
 }
 
-static void file_open_problem_dbg(char *dir, char *fname, char *full_path)
+static void file_open_problem_dbg(const char *dir, const char *fname,
+				  const char *full_path)
 {
 	const char **ptr;
 	struct stat st;
@@ -162,7 +163,7 @@ static void file_open_problem_dbg(char *dir, char *fname, char *full_path)
 	}
 }
 
-int read_file(char *dir, char *fname, int read_opt,
+int read_file(const char *dir, const char *fname, int read_opt,
 	      float orig_timeout, float watch_interval, size_t header_lines)
 {
 	struct ether_addr *mac_addr;
@@ -296,7 +297,8 @@ out:
 	return res;
 }
 
-int write_file(char *dir, char *fname, char *arg1, char *arg2)
+int write_file(const char *dir, const char *fname, const char *arg1,
+	       const char *arg2)
 {
 	int fd = 0, res = EXIT_FAILURE;
 	char full_path[500];
diff --git a/functions.h b/functions.h
index d88c494..f9c8191 100644
--- a/functions.h
+++ b/functions.h
@@ -34,9 +34,10 @@ char *ether_ntoa_long(const struct ether_addr *addr);
 char *get_name_by_macaddr(struct ether_addr *mac_addr, int read_opt);
 char *get_name_by_macstr(char *mac_str, int read_opt);
 int file_exists(const char *fpath);
-int read_file(char *dir, char *path, int read_opt,
+int read_file(const char *dir, const char *path, int read_opt,
 	      float orig_timeout, float watch_interval, size_t header_lines);
-int write_file(char *dir, char *fname, char *arg1, char *arg2);
+int write_file(const char *dir, const char *fname, const char *arg1,
+	       const char *arg2);
 struct ether_addr *translate_mac(char *mesh_iface, struct ether_addr *mac);
 struct ether_addr *resolve_mac(const char *asc);
 
-- 
1.8.4.rc3


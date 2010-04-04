Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun,  4 Apr 2010 18:33:57 +0200
Message-Id: <1270398837-17050-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1270345460-20555-1-git-send-email-sven.eckelmann@gmx.de>
References: <1270345460-20555-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: Parse allowed settings for sysfs
	without whitespace before newline
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
To: b.a.t.m.a.n@lists.open-mesh.org

The current settings parser assumes that a newline is at the end of each
line starting with "commands:". Luis de Bethencourt reported that this
is a bad coding style and should be avoided.

To parse the new settings lines we must also check for \n and not only
for single whitespaces. After each check it must be ensured that the old
character is placed again at the old place and the line seems to be
unmodified to the user.

For old versions with extra whitespace before a newline an extra check
must be applied to not allow commands with empty parameter like in
 batctl vis_mode ''

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batctl/functions.c |   18 ++++++++++++++++++
 batctl/functions.h |    1 +
 batctl/sys.c       |   13 +++++++++----
 3 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/batctl/functions.c b/batctl/functions.c
index 7d8be51..e5fe670 100644
--- a/batctl/functions.c
+++ b/batctl/functions.c
@@ -311,3 +311,21 @@ out:
 		close(fd);
 	return res;
 }
+
+char *strchr_anyof(const char *s, const char *n)
+{
+	char *cur, *first = NULL;
+	size_t i, len;
+
+	if (s == NULL || n == NULL)
+		return first;
+
+	len = strlen(n);
+	for (i = 0; i < len; i++) {
+		cur = strchr(s, n[i]);
+		if (cur != NULL && (cur < first || first == NULL))
+			first = cur;
+	}
+
+	return first;
+}
diff --git a/batctl/functions.h b/batctl/functions.h
index 63740d2..14b8478 100644
--- a/batctl/functions.h
+++ b/batctl/functions.h
@@ -37,6 +37,7 @@ char *get_name_by_macstr(char *mac_str, int read_opt);
 int read_file(char *dir, char *path, int read_opt);
 int write_file(char *dir, char *fname, char *arg1, char *arg2);
 int check_proc_dir(char *dir);
+char *strchr_anyof(const char *s, const char *n);
 
 extern char *line_ptr;
 
diff --git a/batctl/sys.c b/batctl/sys.c
index 1b0b784..5f44c6a 100644
--- a/batctl/sys.c
+++ b/batctl/sys.c
@@ -335,6 +335,7 @@ void orig_interval_usage(void)
 int handle_sys_setting(int argc, char **argv, char *file_path, void setting_usage(void))
 {
 	int optchar, res;
+	char space_char;
 	char *space_ptr, *comma_char, *cmds = NULL;
 
 	while ((optchar = getopt(argc, argv, "h")) != -1) {
@@ -355,15 +356,19 @@ int handle_sys_setting(int argc, char **argv, char *file_path, void setting_usag
 	if (res != EXIT_SUCCESS)
 		return res;
 
-	while ((space_ptr = strchr(line_ptr, ' ')) != NULL) {
+	while ((space_ptr = strchr_anyof(line_ptr, " \n")) != NULL) {
+		space_char = *space_ptr;
 		*space_ptr = '\0';
+		comma_char = NULL;
 
 		if (strncmp(line_ptr, SEARCH_ARGS_TAG, strlen(SEARCH_ARGS_TAG)) == 0) {
 			cmds = space_ptr + 1;
 			goto next;
 		}
 
-		comma_char = NULL;
+		if (strlen(line_ptr) == 0)
+			goto next;
+
 		if (line_ptr[strlen(line_ptr) - 1] == ',') {
 			comma_char = line_ptr + strlen(line_ptr) - 1;
 			*comma_char = '\0';
@@ -372,11 +377,11 @@ int handle_sys_setting(int argc, char **argv, char *file_path, void setting_usag
 		if (strcmp(line_ptr, argv[1]) == 0)
 			goto write_file;
 
-		*space_ptr = ' ';
+next:
+		*space_ptr = space_char;
 		if (comma_char)
 			*comma_char = ',';
 
-next:
 		line_ptr = space_ptr + 1;
 	}
 
-- 
1.7.0.3


Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 21 Jun 2010 12:06:47 +0200
Message-Id: <1277114808-16584-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batctl: Remove dead code from old sysfs
	parsing
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

The old batman-adv sysfs files provided all their available options
inside their output. This made it necessary to parse the output to
analyse it before we accept an input given to batctl.

This functionality was removed as it wasn't the correct style according
to the sysfs maintainer. Not all code related to that were removed right
away when batctl was adopted to the new sysfs handling.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 functions.c |   18 ------------------
 functions.h |    1 -
 2 files changed, 0 insertions(+), 19 deletions(-)

diff --git a/functions.c b/functions.c
index 3bcb0b2..7be9511 100644
--- a/functions.c
+++ b/functions.c
@@ -303,21 +303,3 @@ out:
 		close(fd);
 	return res;
 }
-
-char *strchr_anyof(const char *s, const char *n)
-{
-	char *cur, *first = NULL;
-	size_t i, len;
-
-	if (s == NULL || n == NULL)
-		return first;
-
-	len = strlen(n);
-	for (i = 0; i < len; i++) {
-		cur = strchr(s, n[i]);
-		if (cur != NULL && (cur < first || first == NULL))
-			first = cur;
-	}
-
-	return first;
-}
diff --git a/functions.h b/functions.h
index 847a482..885df34 100644
--- a/functions.h
+++ b/functions.h
@@ -35,7 +35,6 @@ char *get_name_by_macaddr(struct ether_addr *mac_addr, int read_opt);
 char *get_name_by_macstr(char *mac_str, int read_opt);
 int read_file(char *dir, char *path, int read_opt);
 int write_file(char *dir, char *fname, char *arg1, char *arg2);
-char *strchr_anyof(const char *s, const char *n);
 
 extern char *line_ptr;
 
-- 
1.7.1


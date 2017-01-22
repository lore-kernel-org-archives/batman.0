Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 22 Jan 2017 13:21:05 +0100
Message-Id: <20170122122113.29588-1-sven@narfation.org>
In-Reply-To: <3266034.EiLA6asg3G@sven-edge>
References: <3266034.EiLA6asg3G@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH 1/9] batctl: Move root privileges check in
	separate function
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 functions.c | 8 ++++++++
 functions.h | 1 +
 main.c      | 6 ++----
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/functions.c b/functions.c
index f8bacda..c1aaf12 100644
--- a/functions.c
+++ b/functions.c
@@ -1138,3 +1138,11 @@ void get_random_bytes(void *buf, size_t buflen)
 
 	get_random_bytes_fallback(buf, buflen);
 }
+
+void check_root_or_die(const char *cmd)
+{
+	if (getuid() || getgid()) {
+		fprintf(stderr, "Error - you must be root to run '%s' !\n", cmd);
+		exit(EXIT_FAILURE);
+	}
+}
diff --git a/functions.h b/functions.h
index b085f9d..eca1406 100644
--- a/functions.h
+++ b/functions.h
@@ -54,6 +54,7 @@ int check_mesh_iface(char *mesh_iface);
 int check_mesh_iface_ownership(char *mesh_iface, char *hard_iface);
 
 void get_random_bytes(void *buf, size_t buflen);
+void check_root_or_die(const char *cmd);
 
 int print_routing_algos(void);
 extern char *line_ptr;
diff --git a/main.c b/main.c
index 3f0b008..2fc9b75 100644
--- a/main.c
+++ b/main.c
@@ -136,10 +136,8 @@ int main(int argc, char **argv)
 
 	/* TODO: remove this generic check here and move it into the individual functions */
 	/* check if user is root */
-	if ((strncmp(argv[1], "bisect", strlen("bisect")) != 0) && ((getuid()) || (getgid()))) {
-		fprintf(stderr, "Error - you must be root to run '%s' !\n", argv[0]);
-		exit(EXIT_FAILURE);
-	}
+	if (strncmp(argv[1], "bisect", strlen("bisect")) != 0)
+		check_root_or_die(argv[0]);
 
 	if ((strcmp(argv[1], "interface") == 0) || (strcmp(argv[1], "if") == 0)) {
 
-- 
2.11.0


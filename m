Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 24 May 2014 13:44:09 +0200
Message-Id: <1400931855-7961-4-git-send-email-sven@narfation.org>
In-Reply-To: <1400931855-7961-1-git-send-email-sven@narfation.org>
References: <1400931855-7961-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 04/10] alfred: Use pre-allocated object for
	global variables
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

The object storing the global variables is a good way to keep track of all
data. But it is unnecessary to allocate an object on the heap for it. Using
an object with static storage allows better compiler optimization and makes
checking for actual memory leaks (unreachable memory) easier.

Signed-off-by: Sven Eckelmann <sven@narfation.org>

---
 gpsd/alfred-gpsd.c | 7 +++----
 main.c             | 6 ++----
 vis/vis.c          | 7 +++----
 3 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/gpsd/alfred-gpsd.c b/gpsd/alfred-gpsd.c
index b71a9b2..ef20f28 100644
--- a/gpsd/alfred-gpsd.c
+++ b/gpsd/alfred-gpsd.c
@@ -21,6 +21,8 @@
 
 #include "alfred-gpsd.h"
 
+static struct globals gpsd_globals;
+
 static int alfred_open_sock(struct globals *globals)
 {
 	struct sockaddr_un addr;
@@ -394,10 +396,7 @@ static struct globals *gpsd_init(int argc, char *argv[])
 		{NULL,		0,			NULL,	0},
 	};
 
-	globals = malloc(sizeof(*globals));
-	if (!globals)
-		return NULL;
-
+	globals = &gpsd_globals;
 	memset(globals, 0, sizeof(*globals));
 
 	globals->opmode = OPMODE_CLIENT;
diff --git a/main.c b/main.c
index 32fb9b8..d848589 100644
--- a/main.c
+++ b/main.c
@@ -27,6 +27,7 @@
 #include "alfred.h"
 #include "packet.h"
 
+static struct globals alfred_globals;
 
 static void alfred_usage(void)
 {
@@ -69,10 +70,7 @@ static struct globals *alfred_init(int argc, char *argv[])
 		{NULL,		0,			NULL,	0},
 	};
 
-	globals = malloc(sizeof(*globals));
-	if (!globals)
-		return NULL;
-
+	globals = &alfred_globals;
 	memset(globals, 0, sizeof(*globals));
 
 	globals->opmode = OPMODE_SLAVE;
diff --git a/vis/vis.c b/vis/vis.c
index a5ac664..31f60d7 100644
--- a/vis/vis.c
+++ b/vis/vis.c
@@ -37,6 +37,8 @@
 #include <unistd.h>
 #include "debugfs.h"
 
+static struct globals vis_globals;
+
 static char *read_file(char *fname)
 {
 	FILE *fp;
@@ -832,10 +834,7 @@ static struct globals *vis_init(int argc, char *argv[])
 		{NULL,		0,			NULL,	0},
 	};
 
-	globals = malloc(sizeof(*globals));
-	if (!globals)
-		return NULL;
-
+	globals = &vis_globals;
 	memset(globals, 0, sizeof(*globals));
 
 	globals->opmode = OPMODE_CLIENT;
-- 
2.0.0.rc2


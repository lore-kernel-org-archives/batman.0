Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 21 Jun 2010 12:06:48 +0200
Message-Id: <1277114808-16584-2-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1277114808-16584-1-git-send-email-sven.eckelmann@gmx.de>
References: <1277114808-16584-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batctl: Use NULL instead of 0 for
	pointers
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

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 debugfs.c |    2 +-
 sys.c     |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/debugfs.c b/debugfs.c
index 3b6e2bf..6d2222f 100644
--- a/debugfs.c
+++ b/debugfs.c
@@ -38,7 +38,7 @@ static char debugfs_mountpoint[MAX_PATH+1];
 static const char *debugfs_known_mountpoints[] = {
 	"/sys/kernel/debug/",
 	"/debug/",
-	0,
+	NULL,
 };
 
 /* use this to force a umount */
diff --git a/sys.c b/sys.c
index dfe3979..9137424 100644
--- a/sys.c
+++ b/sys.c
@@ -39,14 +39,14 @@ const char *sysfs_param_enable[] = {
 	"disable",
 	"1",
 	"0",
-	0,
+	NULL,
 };
 
 const char *sysfs_param_server[] = {
 	"off",
 	"client",
 	"server",
-	0,
+	NULL,
 };
 
 static void interface_usage(void)
-- 
1.7.1


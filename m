Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  3 Jun 2012 22:19:08 +0200
Message-Id: <1338754762-28424-2-git-send-email-sven@narfation.org>
In-Reply-To: <1338754762-28424-1-git-send-email-sven@narfation.org>
References: <1338754762-28424-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 02/16] batman-adv: Prefix debugfs defines
	with BATADV_
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

Reported-by: Martin Hundebøll <martin@hundeboll.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bat_debugfs.c |    2 +-
 bat_debugfs.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bat_debugfs.c b/bat_debugfs.c
index 095e6e8..c28b9de 100644
--- a/bat_debugfs.c
+++ b/bat_debugfs.c
@@ -311,7 +311,7 @@ void batadv_debugfs_init(void)
 	struct bat_debuginfo *bat_debug;
 	struct dentry *file;
 
-	batadv_debugfs = debugfs_create_dir(DEBUGFS_BAT_SUBDIR, NULL);
+	batadv_debugfs = debugfs_create_dir(BATADV_DEBUGFS_SUBDIR, NULL);
 	if (batadv_debugfs == ERR_PTR(-ENODEV))
 		batadv_debugfs = NULL;
 
diff --git a/bat_debugfs.h b/bat_debugfs.h
index eb0d576..3319e1f 100644
--- a/bat_debugfs.h
+++ b/bat_debugfs.h
@@ -20,7 +20,7 @@
 #ifndef _NET_BATMAN_ADV_DEBUGFS_H_
 #define _NET_BATMAN_ADV_DEBUGFS_H_
 
-#define DEBUGFS_BAT_SUBDIR "batman_adv"
+#define BATADV_DEBUGFS_SUBDIR "batman_adv"
 
 void batadv_debugfs_init(void);
 void batadv_debugfs_destroy(void);
-- 
1.7.10


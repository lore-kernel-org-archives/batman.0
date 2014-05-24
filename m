Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 24 May 2014 14:16:44 +0200
Message-Id: <1400933804-9661-6-git-send-email-sven@narfation.org>
In-Reply-To: <1400933804-9661-1-git-send-email-sven@narfation.org>
References: <1400933804-9661-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 6/6] batctl: Don't provide uninitialized
	parameter to read_file
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

The debug table function uses a parameter to filter out old originator nodes
when read_file processes the file. The variable is by default not initialized
and still given to this function. This is bad practice and irritates checker
tools.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/debug.c b/debug.c
index e7f463d..dfcf3c3 100644
--- a/debug.c
+++ b/debug.c
@@ -107,7 +107,7 @@ int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv)
 	char full_path[MAX_PATH+1];
 	char *debugfs_mnt;
 	char *orig_iface = NULL;
-	float orig_timeout;
+	float orig_timeout = 0.0f;
 	float watch_interval = 1;
 	opterr = 0;
 
-- 
2.0.0.rc2


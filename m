Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 12 Sep 2013 22:58:43 +0200
Message-Id: <1379019524-23543-13-git-send-email-sven@narfation.org>
In-Reply-To: <1379019524-23543-1-git-send-email-sven@narfation.org>
References: <1379019524-23543-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 12/13] batmand: Fix preprocessor check for
	defined DEBUG_MALLOC && MEMORY_USAGE
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 batman.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/batman.c b/batman.c
index 39ef9be..89b3bf1 100644
--- a/batman.c
+++ b/batman.c
@@ -47,7 +47,7 @@ uint8_t debug_level = 0;
 
 uint8_t debug_level_max = 5;
 
-#elif DEBUG_MALLOC && MEMORY_USAGE
+#elif defined DEBUG_MALLOC && defined MEMORY_USAGE
 
 uint8_t debug_level_max = 5;
 
-- 
1.8.4.rc3


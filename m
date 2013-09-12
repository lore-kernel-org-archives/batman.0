Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 12 Sep 2013 22:58:44 +0200
Message-Id: <1379019524-23543-14-git-send-email-sven@narfation.org>
In-Reply-To: <1379019524-23543-1-git-send-email-sven@narfation.org>
References: <1379019524-23543-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 13/13] batmand: Add error for MEMORY_USAGE
	dependency
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

Print error during build when MEMORY_USAGE is requested but the build is done
without DEBUG_MALLOC.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 allocate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/allocate.c b/allocate.c
index c6c3082..fe61847 100644
--- a/allocate.c
+++ b/allocate.c
@@ -32,6 +32,10 @@
 
 #if defined DEBUG_MALLOC
 
+#ifndef MEMORY_USAGE
+#error DEBUG_MALLOC can only be used together with MEMORY_USAGE
+#endif
+
 static pthread_mutex_t chunk_mutex = PTHREAD_MUTEX_INITIALIZER;
 
 struct chunkHeader *chunkList = NULL;
-- 
1.8.4.rc3


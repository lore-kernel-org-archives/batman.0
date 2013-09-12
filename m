Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 12 Sep 2013 22:58:42 +0200
Message-Id: <1379019524-23543-12-git-send-email-sven@narfation.org>
In-Reply-To: <1379019524-23543-1-git-send-email-sven@narfation.org>
References: <1379019524-23543-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 11/13] batmand: Mark unused parameter in
	dummy functions
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
 allocate.c | 4 +++-
 profile.c  | 7 ++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/allocate.c b/allocate.c
index 4196dab..c6c3082 100644
--- a/allocate.c
+++ b/allocate.c
@@ -421,6 +421,8 @@ void debugFree(void *memoryParameter, int tag)
 
 #else
 
+#include "batman.h"
+
 void checkIntegrity(void)
 {
 }
@@ -459,7 +461,7 @@ void *debugRealloc(void *memory, uint32_t length, int32_t tag)
 	return result;
 }
 
-void debugFree(void *memory, int32_t tag)
+void debugFree(void *memory, int32_t BATMANUNUSED(tag))
 {
 	free(memory);
 }
diff --git a/profile.c b/profile.c
index 9692d7d..a063750 100644
--- a/profile.c
+++ b/profile.c
@@ -80,20 +80,21 @@ void prof_print(void) {
 
 #else
 
+#include "batman.h"
 
-void prof_init( int32_t index, const char *name ) {
+void prof_init( int32_t BATMANUNUSED(index), const char *BATMANUNUSED(name) ) {
 
 }
 
 
 
-void prof_start( int32_t index ) {
+void prof_start( int32_t BATMANUNUSED(index) ) {
 
 }
 
 
 
-void prof_stop( int32_t index ) {
+void prof_stop( int32_t BATMANUNUSED(index) ) {
 
 }
 
-- 
1.8.4.rc3


Date: Sat, 13 Sep 2008 01:24:46 +0200
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Message-ID: <20080912232446.GA9690@sven-desktop.lazhur.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [PATCH] Make batman debug allocation function thread
	safe
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

Different list structures are manually managed inside the debug malloc functions
of batman. When different threads try to allocate and free memory it is possible
that lists get corrupted and we get a segfault.
Also the memory usage pointer can hold a wrong value and removeMemory could stop
batman without any real reason.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman/allocate.c |   27 +++++++++++++++++++++++++--
 1 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/batman/allocate.c b/batman/allocate.c
index d51bec0..c845431 100644
--- a/batman/allocate.c
+++ b/batman/allocate.c
@@ -31,6 +31,8 @@
 
 #if defined DEBUG_MALLOC
 
+static pthread_mutex_t chunk_mutex = PTHREAD_MUTEX_INITIALIZER;
+
 struct chunkHeader *chunkList = NULL;
 
 struct chunkHeader
@@ -51,6 +53,7 @@ struct chunkTrailer
 #if defined MEMORY_USAGE
 
 struct memoryUsage *memoryList = NULL;
+static pthread_mutex_t memory_mutex = PTHREAD_MUTEX_INITIALIZER;
 
 
 struct memoryUsage
@@ -66,7 +69,7 @@ void addMemory( uint32_t length, int32_t tag ) {
 
 	struct memoryUsage *walker;
 
-
+	pthread_mutex_lock(&memory_mutex);
 	for ( walker = memoryList; walker != NULL; walker = walker->next ) {
 
 		if ( walker->tag == tag ) {
@@ -90,6 +93,7 @@ void addMemory( uint32_t length, int32_t tag ) {
 		memoryList = walker;
 
 	}
+	pthread_mutex_unlock(&memory_mutex);
 
 }
 
@@ -98,7 +102,7 @@ void removeMemory( int32_t tag, int32_t freetag ) {
 
 	struct memoryUsage *walker;
 
-
+	pthread_mutex_lock(&memory_mutex);
 	for ( walker = memoryList; walker != NULL; walker = walker->next ) {
 
 		if ( walker->tag == tag ) {
@@ -106,6 +110,7 @@ void removeMemory( int32_t tag, int32_t freetag ) {
 			if ( walker->counter == 0 ) {
 
 				debug_output( 0, "Freeing more memory than was allocated: malloc tag = %d, free tag = %d\n", tag, freetag );
+				pthread_mutex_unlock(&memory_mutex);
 				restore_and_exit(0);
 
 			}
@@ -120,9 +125,11 @@ void removeMemory( int32_t tag, int32_t freetag ) {
 	if ( walker == NULL ) {
 
 		debug_output( 0, "Freeing memory that was never allocated: malloc tag = %d, free tag = %d\n", tag, freetag );
+		pthread_mutex_unlock(&memory_mutex);
 		restore_and_exit(0);
 
 	}
+	pthread_mutex_unlock(&memory_mutex);
 
 }
 
@@ -143,21 +150,25 @@ void checkIntegrity(void)
 
 	debug_output( 5, " \nMemory usage information:\n" );
 
+	pthread_mutex_lock(&memory_mutex);
 	for ( memoryWalker = memoryList; memoryWalker != NULL; memoryWalker = memoryWalker->next ) {
 
 		if ( memoryWalker->counter != 0 )
 			debug_output( 5, "   tag: %''4i, num malloc: %4i, bytes per malloc: %''4i, total: %6i\n", memoryWalker->tag, memoryWalker->counter, memoryWalker->length, memoryWalker->counter * memoryWalker->length );
 
 	}
+	pthread_mutex_unlock(&memory_mutex);
 
 #endif
 
+	pthread_mutex_lock(&chunk_mutex);
 
 	for (walker = chunkList; walker != NULL; walker = walker->next)
 	{
 		if (walker->magicNumber != MAGIC_NUMBER)
 		{
 			debug_output( 0, "checkIntegrity - invalid magic number in header: %08x, malloc tag = %d\n", walker->magicNumber, walker->tag );
+			pthread_mutex_unlock(&chunk_mutex);
 			restore_and_exit(0);
 		}
 
@@ -168,17 +179,23 @@ void checkIntegrity(void)
 		if (chunkTrailer->magicNumber != MAGIC_NUMBER)
 		{
 			debug_output( 0, "checkIntegrity - invalid magic number in trailer: %08x, malloc tag = %d\n", chunkTrailer->magicNumber, walker->tag );
+			pthread_mutex_unlock(&chunk_mutex);
 			restore_and_exit(0);
 		}
 	}
+
+	pthread_mutex_unlock(&chunk_mutex);
 }
 
 void checkLeak(void)
 {
 	struct chunkHeader *walker;
 
+	pthread_mutex_lock(&chunk_mutex);
 	for (walker = chunkList; walker != NULL; walker = walker->next)
 		debug_output( 0, "Memory leak detected, malloc tag = %d\n", walker->tag );
+
+	pthread_mutex_unlock(&chunk_mutex);
 }
 
 void *debugMalloc(uint32_t length, int32_t tag)
@@ -208,8 +225,10 @@ void *debugMalloc(uint32_t length, int32_t tag)
 
 	chunkTrailer->magicNumber = MAGIC_NUMBER;
 
+	pthread_mutex_lock(&chunk_mutex);
 	chunkHeader->next = chunkList;
 	chunkList = chunkHeader;
+	pthread_mutex_unlock(&chunk_mutex);
 
 #if defined MEMORY_USAGE
 
@@ -282,6 +301,7 @@ void debugFree(void *memoryParameter, int tag)
 
 	previous = NULL;
 
+	pthread_mutex_lock(&chunk_mutex);
 	for (walker = chunkList; walker != NULL; walker = walker->next)
 	{
 		if (walker == chunkHeader)
@@ -293,6 +313,7 @@ void debugFree(void *memoryParameter, int tag)
 	if (walker == NULL)
 	{
 		debug_output( 0, "Double free detected, malloc tag = %d, free tag = %d\n", chunkHeader->tag, tag );
+		pthread_mutex_unlock(&chunk_mutex);
 		restore_and_exit(0);
 	}
 
@@ -302,6 +323,8 @@ void debugFree(void *memoryParameter, int tag)
 	else
 		previous->next = walker->next;
 
+	pthread_mutex_unlock(&chunk_mutex);
+
 	chunkTrailer = (struct chunkTrailer *)(memory + chunkHeader->length);
 
 	if (chunkTrailer->magicNumber != MAGIC_NUMBER)
-- 
1.6.0.1



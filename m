From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu, 28 May 2009 12:40:08 +0200
Message-Id: <1243507208-8999-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <4313f3060905190727x279f2d0boc4e74e4df6e821bc@mail.gmail.com>
References: <4313f3060905190727x279f2d0boc4e74e4df6e821bc@mail.gmail.com>
Subject: [B.A.T.M.A.N.] [PATCH] [batman] Add padding around allocation
	debugger structures
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

Architectures with a special alignment for load and store operations on
datatypes bigger than bytes will return a prealigned memory region when
calling malloc. When we add our data structure before and after this
region we destroy this alignment.
To fix this problem we add special regions with "magic" padding data.
To be sure that it is big enough for every load/store operation we use
the alignment for uintmax_t or a pointer even when the architecture only
supports smaller load/store operations.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman/allocate.c |   77 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 69 insertions(+), 8 deletions(-)

diff --git a/batman/allocate.c b/batman/allocate.c
index 3cb1d65..a779504 100644
--- a/batman/allocate.c
+++ b/batman/allocate.c
@@ -67,6 +67,44 @@ struct memoryUsage
 };
 
 
+static size_t getHeaderPad() {
+	size_t pad = sizeof(uintmax_t) - (sizeof(struct chunkHeader) % sizeof(uintmax_t));
+	if (pad == sizeof(uintmax_t))
+		return 0;
+	else
+		return pad;
+}
+
+static size_t getTrailerPad(size_t length) {
+	size_t pad = sizeof(uintmax_t) - (length % sizeof(uintmax_t));
+	if (pad == sizeof(uintmax_t))
+		return 0;
+	else
+		return pad;
+}
+
+static void fillPadding(unsigned char* padding, size_t length) {
+	unsigned char c = 0x00;
+	size_t i;
+
+	for (i = 0; i < length; i++) {
+		c += 0xA7;
+		padding[i] = c;
+	}
+}
+
+static int checkPadding(unsigned char* padding, size_t length) {
+	unsigned char c = 0x00;
+	size_t i;
+
+	for (i = 0; i < length; i++) {
+		c += 0xA7;
+		if (padding[i] != c)
+			return 0;
+	}
+	return 1;
+}
+
 static void addMemory( uint32_t length, int32_t tag ) {
 
 	struct memoryUsage *walker;
@@ -176,7 +214,7 @@ void checkIntegrity(void)
 
 		memory = (unsigned char *)walker;
 
-		chunkTrailer = (struct chunkTrailer *)(memory + sizeof(struct chunkHeader) + walker->length);
+		chunkTrailer = (struct chunkTrailer *)(memory + sizeof(struct chunkHeader) + getHeaderPad() + walker->length + getTrailerPad(walker->length));
 
 		if (chunkTrailer->magicNumber != MAGIC_NUMBER)
 		{
@@ -209,7 +247,7 @@ void *debugMalloc(uint32_t length, int32_t tag)
 
 /* 	printf("sizeof(struct chunkHeader) = %u, sizeof (struct chunkTrailer) = %u\n", sizeof (struct chunkHeader), sizeof (struct chunkTrailer)); */
 
-	memory = malloc(length + sizeof(struct chunkHeader) + sizeof(struct chunkTrailer));
+	memory = malloc(length + sizeof(struct chunkHeader) + sizeof(struct chunkTrailer) + getHeaderPad() + getTrailerPad(length));
 
 	if (memory == NULL)
 	{
@@ -218,8 +256,11 @@ void *debugMalloc(uint32_t length, int32_t tag)
 	}
 
 	chunkHeader = (struct chunkHeader *)memory;
-	chunk = memory + sizeof(struct chunkHeader);
-	chunkTrailer = (struct chunkTrailer *)(memory + sizeof(struct chunkHeader) + length);
+	chunk = memory + sizeof(struct chunkHeader) + getHeaderPad();
+	chunkTrailer = (struct chunkTrailer *)(memory + sizeof(struct chunkHeader) + length + getHeaderPad() + getTrailerPad(length));
+
+	fillPadding((unsigned char*)chunkHeader + sizeof(struct chunkHeader), getHeaderPad());
+	fillPadding(chunk + length, getTrailerPad(length));
 
 	chunkHeader->length = length;
 	chunkHeader->tag = tag;
@@ -251,7 +292,7 @@ void *debugRealloc(void *memoryParameter, uint32_t length, int32_t tag)
 
 	if (memoryParameter) { /* if memoryParameter==NULL, realloc() should work like malloc() !! */
 		memory = memoryParameter;
-		chunkHeader = (struct chunkHeader *)(memory - sizeof(struct chunkHeader));
+		chunkHeader = (struct chunkHeader *)(memory - sizeof(struct chunkHeader) - getHeaderPad());
 
 		if (chunkHeader->magicNumber != MAGIC_NUMBER)
 		{
@@ -259,13 +300,23 @@ void *debugRealloc(void *memoryParameter, uint32_t length, int32_t tag)
 			restore_and_exit(0);
 		}
 
-		chunkTrailer = (struct chunkTrailer *)(memory + chunkHeader->length);
+		if (checkPadding(memory - getHeaderPad(), getHeaderPad()) == 0) {
+			debug_output( 0, "debugRealloc - invalid magic padding in header, malloc tag = %d\n", chunkHeader->tag );
+			restore_and_exit(0);
+		}
+
+		chunkTrailer = (struct chunkTrailer *)(memory + chunkHeader->length + getTrailerPad(chunkHeader->length));
 
 		if (chunkTrailer->magicNumber != MAGIC_NUMBER)
 		{
 			debug_output( 0, "debugRealloc - invalid magic number in trailer: %08x, malloc tag = %d\n", chunkTrailer->magicNumber, chunkHeader->tag );
 			restore_and_exit(0);
 		}
+
+		if (checkPadding(memory + chunkHeader->length, getTrailerPad(chunkHeader->length)) == 0) {
+			debug_output( 0, "debugRealloc - invalid magic padding in trailer, malloc tag = %d\n", chunkHeader->tag );
+			restore_and_exit(0);
+		}
 	}
 
 
@@ -292,7 +343,7 @@ void debugFree(void *memoryParameter, int tag)
 	struct chunkHeader *previous;
 
 	memory = memoryParameter;
-	chunkHeader = (struct chunkHeader *)(memory - sizeof(struct chunkHeader));
+	chunkHeader = (struct chunkHeader *)(memory - sizeof(struct chunkHeader) - getHeaderPad());
 
 	if (chunkHeader->magicNumber != MAGIC_NUMBER)
 	{
@@ -300,6 +351,11 @@ void debugFree(void *memoryParameter, int tag)
 		restore_and_exit(0);
 	}
 
+	if (checkPadding(memory - getHeaderPad(), getHeaderPad()) == 0) {
+		debug_output( 0, "debugFree - invalid magic padding in header, malloc tag = %d\n", chunkHeader->tag );
+		restore_and_exit(0);
+	}
+
 	previous = NULL;
 
 	pthread_mutex_lock(&chunk_mutex);
@@ -326,7 +382,7 @@ void debugFree(void *memoryParameter, int tag)
 
 	pthread_mutex_unlock(&chunk_mutex);
 
-	chunkTrailer = (struct chunkTrailer *)(memory + chunkHeader->length);
+	chunkTrailer = (struct chunkTrailer *)(memory + chunkHeader->length + getTrailerPad(chunkHeader->length));
 
 	if (chunkTrailer->magicNumber != MAGIC_NUMBER)
 	{
@@ -334,6 +390,11 @@ void debugFree(void *memoryParameter, int tag)
 		restore_and_exit(0);
 	}
 
+	if (checkPadding(memory + chunkHeader->length, getTrailerPad(chunkHeader->length)) == 0) {
+		debug_output( 0, "debugFree - invalid magic padding in trailer, malloc tag = %d\n", chunkHeader->tag );
+		restore_and_exit(0);
+	}
+
 #if defined MEMORY_USAGE
 
 	removeMemory( chunkHeader->tag, tag );
-- 
1.6.3.1


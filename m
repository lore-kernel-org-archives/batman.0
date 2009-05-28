From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu, 28 May 2009 13:36:58 +0200
Message-Id: <1243510619-10749-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <4313f3060905190727x279f2d0boc4e74e4df6e821bc@mail.gmail.com>
References: <4313f3060905190727x279f2d0boc4e74e4df6e821bc@mail.gmail.com>
Subject: [B.A.T.M.A.N.] [PATCH 2/3] [batman] Make TYPE_OF_WORD the largest
	integral type
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


Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman/allocate.c |   24 ++++++++++++++++++++----
 batman/batman.h   |    2 ++
 batman/bitarray.h |    4 +---
 3 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/batman/allocate.c b/batman/allocate.c
index a779504..5e28c71 100644
--- a/batman/allocate.c
+++ b/batman/allocate.c
@@ -68,16 +68,32 @@ struct memoryUsage
 
 
 static size_t getHeaderPad() {
-	size_t pad = sizeof(uintmax_t) - (sizeof(struct chunkHeader) % sizeof(uintmax_t));
-	if (pad == sizeof(uintmax_t))
+	size_t alignwith, pad;
+
+	if (sizeof(TYPE_OF_WORD) > sizeof(void*))
+		alignwith = sizeof(TYPE_OF_WORD);
+	else
+		alignwith = sizeof(void*);
+
+	pad = alignwith - (sizeof(struct chunkHeader) % alignwith);
+
+	if (pad == alignwith)
 		return 0;
 	else
 		return pad;
 }
 
 static size_t getTrailerPad(size_t length) {
-	size_t pad = sizeof(uintmax_t) - (length % sizeof(uintmax_t));
-	if (pad == sizeof(uintmax_t))
+	size_t alignwith, pad;
+
+	if (sizeof(TYPE_OF_WORD) > sizeof(void*))
+		alignwith = sizeof(TYPE_OF_WORD);
+	else
+		alignwith = sizeof(void*);
+
+	pad = alignwith - (length % alignwith);
+
+	if (pad == alignwith)
 		return 0;
 	else
 		return pad;
diff --git a/batman/batman.h b/batman/batman.h
index c02ce8d..1cc5896 100644
--- a/batman/batman.h
+++ b/batman/batman.h
@@ -31,6 +31,8 @@
 #include <stdint.h>
 #include <stdio.h>
 
+#define TYPE_OF_WORD uintmax_t /* you should choose something big, if you don't want to waste cpu */
+
 #include "list-batman.h"
 #include "bitarray.h"
 #include "hash.h"
diff --git a/batman/bitarray.h b/batman/bitarray.h
index 5472ef1..0bb0710 100644
--- a/batman/bitarray.h
+++ b/batman/bitarray.h
@@ -21,10 +21,8 @@
 
 
 
-#define TYPE_OF_WORD unsigned long /* you should choose something big, if you don't want to waste cpu */
-#define WORD_BIT_SIZE ( sizeof(TYPE_OF_WORD) * 8 )
 #include "batman.h"
-
+#define WORD_BIT_SIZE ( sizeof(TYPE_OF_WORD) * 8 )
 
 
 void bit_init( TYPE_OF_WORD *seq_bits );
-- 
1.6.3.1


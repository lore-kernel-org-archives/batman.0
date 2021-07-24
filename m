Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH] asm-generic: avoid sparse {get,put}_unaligned warning
Date: Sat, 24 Jul 2021 18:24:29 +0200
Message-Id: <20210724162429.394792-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Arnd Bergmann <arnd@arndb.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Sven Eckelmann <sven@narfation.org>

Sparse will try to check casting of simple integer types which are marked
as __bitwise. This for example "disallows" simple casting of __be{16,32,64}
or __le{16,32,64} to other types. This is also true for pointers to
variables with this type.

But the new generic {get,put}_unaligned is doing that by (reinterpret)
casting the original pointer to a new (anonymous) struct pointer. This will
then create warnings like:

  net/batman-adv/distributed-arp-table.c:1461:19: warning: cast from restricted __be32 *
  net/batman-adv/distributed-arp-table.c:1510:23: warning: cast from restricted __be32 [usertype] *[assigned] magic
  net/batman-adv/distributed-arp-table.c:1588:24: warning: cast from restricted __be32 [usertype] *[assigned] yiaddr

The special attribute force must be used in such statements when the cast
is known to be safe to avoid these warnings.

Fixes: 803f4e1eab7a ("asm-generic: simplify asm/unaligned.h")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 include/asm-generic/unaligned.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/unaligned.h b/include/asm-generic/unaligned.h
index 1c4242416c9f..e2b23e5bf945 100644
--- a/include/asm-generic/unaligned.h
+++ b/include/asm-generic/unaligned.h
@@ -10,12 +10,13 @@
 #include <asm/byteorder.h>
 
 #define __get_unaligned_t(type, ptr) ({						\
-	const struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);	\
+	const struct { type x; } __packed *__pptr;				\
+	__pptr = (__force typeof(__pptr))(ptr);					\
 	__pptr->x;								\
 })
 
 #define __put_unaligned_t(type, val, ptr) do {					\
-	struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);		\
+	struct { type x; } __packed *__pptr = (__force typeof(__pptr))(ptr);	\
 	__pptr->x = (val);							\
 } while (0)
 
-- 
2.30.2


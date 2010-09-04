Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun,  5 Sep 2010 01:58:22 +0200
Message-Id: <1283644718-653-6-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1283644718-653-1-git-send-email-sven.eckelmann@gmx.de>
References: <1283644718-653-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 05/21] Staging: batman-adv: Calculate hamming
	weight using optimized kernel functions
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
To: greg@kroah.com
Cc: b.a.t.m.a.n@lists.open-mesh.net

The Kernighan algorithm is not able to calculate the number of set bits
in parallel and the compiler cannot replace it with optimized
instructions.

The kernel provides specialised functions for each cpu which can either
use a software implementation or hardware instruction depending on the
target cpu.

Reported-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/TODO       |    1 -
 drivers/staging/batman-adv/bitarray.c |   15 +++++----------
 drivers/staging/batman-adv/bitarray.h |    3 ++-
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/batman-adv/TODO b/drivers/staging/batman-adv/TODO
index 9c5aea2..d8bf845 100644
--- a/drivers/staging/batman-adv/TODO
+++ b/drivers/staging/batman-adv/TODO
@@ -1,4 +1,3 @@
- * Use hweight* for hamming weight calculation
  * Save/cache packets direktly as skb instead of using a normal memory region
    and copying it in a skb using send_raw_packet and similar functions
  * Request a new review
diff --git a/drivers/staging/batman-adv/bitarray.c b/drivers/staging/batman-adv/bitarray.c
index dd4193c..9dbaf1e 100644
--- a/drivers/staging/batman-adv/bitarray.c
+++ b/drivers/staging/batman-adv/bitarray.c
@@ -22,6 +22,8 @@
 #include "main.h"
 #include "bitarray.h"
 
+#include <linux/bitops.h>
+
 /* returns true if the corresponding bit in the given seq_bits indicates true
  * and curr_seqno is within range of last_seqno */
 uint8_t get_bit_status(TYPE_OF_WORD *seq_bits, uint32_t last_seqno,
@@ -187,21 +189,14 @@ char bit_get_packet(TYPE_OF_WORD *seq_bits, int32_t seq_num_diff,
 }
 
 /* count the hamming weight, how many good packets did we receive? just count
- * the 1's. The inner loop uses the Kernighan algorithm, see
- * http://graphics.stanford.edu/~seander/bithacks.html#CountBitsSetKernighan
+ * the 1's.
  */
 int bit_packet_count(TYPE_OF_WORD *seq_bits)
 {
 	int i, hamming = 0;
-	TYPE_OF_WORD word;
 
-	for (i = 0; i < NUM_WORDS; i++) {
-		word = seq_bits[i];
+	for (i = 0; i < NUM_WORDS; i++)
+		hamming += hweight_long(seq_bits[i]);
 
-		while (word) {
-			word &= word-1;
-			hamming++;
-		}
-	}
 	return hamming;
 }
diff --git a/drivers/staging/batman-adv/bitarray.h b/drivers/staging/batman-adv/bitarray.h
index 01897d6..c0c1730 100644
--- a/drivers/staging/batman-adv/bitarray.h
+++ b/drivers/staging/batman-adv/bitarray.h
@@ -22,7 +22,8 @@
 #ifndef _NET_BATMAN_ADV_BITARRAY_H_
 #define _NET_BATMAN_ADV_BITARRAY_H_
 
-/* you should choose something big, if you don't want to waste cpu */
+/* you should choose something big, if you don't want to waste cpu
+ * and keep the type in sync with bit_packet_count */
 #define TYPE_OF_WORD unsigned long
 #define WORD_BIT_SIZE (sizeof(TYPE_OF_WORD) * 8)
 
-- 
1.7.1


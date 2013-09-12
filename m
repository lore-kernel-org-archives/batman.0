Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 12 Sep 2013 22:58:35 +0200
Message-Id: <1379019524-23543-5-git-send-email-sven@narfation.org>
In-Reply-To: <1379019524-23543-1-git-send-email-sven@narfation.org>
References: <1379019524-23543-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 04/13] batmand: Add include guards to avoid
	redundant declarations or include loops
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
 allocate.h    | 6 +++---
 batman.h      | 4 ++--
 bitarray.h    | 4 +++-
 hash.h        | 4 ++--
 hna.h         | 5 ++++-
 originator.h  | 4 +++-
 os.h          | 4 ++--
 packet.h      | 5 +++++
 profile.h     | 5 ++++-
 ring_buffer.h | 5 ++++-
 schedule.h    | 4 ++++
 types.h       | 4 ++--
 12 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/allocate.h b/allocate.h
index 167ab33..99c3a49 100644
--- a/allocate.h
+++ b/allocate.h
@@ -20,10 +20,10 @@
  */
 
 
-#ifndef _ALLOCATE_H
-#define _ALLOCATE_H 1
-#include <stdint.h>
+#ifndef _BATMAND_ALLOCATE_H
+#define _BATMAND_ALLOCATE_H
 
+#include <stdint.h>
 
 
 void checkIntegrity(void);
diff --git a/batman.h b/batman.h
index c8e35f1..05c48c1 100644
--- a/batman.h
+++ b/batman.h
@@ -21,8 +21,8 @@
 
 
 
-#ifndef _BATMAN_BATMAN_H
-#define _BATMAN_BATMAN_H
+#ifndef _BATMAND_BATMAN_H
+#define _BATMAND_BATMAN_H
 
 #include <sys/types.h>
 #include <netinet/in.h>
diff --git a/bitarray.h b/bitarray.h
index 9a1f80d..e0ca302 100644
--- a/bitarray.h
+++ b/bitarray.h
@@ -19,7 +19,8 @@
  *
  */
 
-
+#ifndef _BATMAND_BITARRAY_H
+#define _BATMAND_BITARRAY_H
 
 #include "batman.h"
 #define WORD_BIT_SIZE ( sizeof(TYPE_OF_WORD) * 8 )
@@ -34,3 +35,4 @@ char bit_get_packet( TYPE_OF_WORD *seq_bits, int16_t seq_num_diff, int8_t set_ma
 int  bit_packet_count( TYPE_OF_WORD *seq_bits );
 uint8_t bit_count( int32_t to_count );
 
+#endif
diff --git a/hash.h b/hash.h
index 91ee7d8..66d7162 100644
--- a/hash.h
+++ b/hash.h
@@ -18,8 +18,8 @@
  * 02110-1301, USA
  *
  */
-#ifndef _BATMAN_HASH_H
-#define _BATMAN_HASH_H
+#ifndef _BATMAND_HASH_H
+#define _BATMAND_HASH_H
 
 
 
diff --git a/hna.h b/hna.h
index 5af9317..99f7664 100644
--- a/hna.h
+++ b/hna.h
@@ -19,7 +19,8 @@
  *
  */
 
-
+#ifndef _BATMAND_HNA_H
+#define _BATMAND_HNA_H
 
 #include "batman.h"
 
@@ -82,3 +83,5 @@ void hna_global_update(struct orig_node *orig_node, unsigned char *new_hna,
 				int16_t new_hna_len, struct neigh_node *old_router);
 void hna_global_check_tq(struct orig_node *orig_node);
 void hna_global_del(struct orig_node *orig_node);
+
+#endif
diff --git a/originator.h b/originator.h
index fb5e063..5ce5162 100644
--- a/originator.h
+++ b/originator.h
@@ -19,7 +19,8 @@
  *
  */
 
-
+#ifndef _BATMAND_ORIGINATOR_H
+#define _BATMAND_ORIGINATOR_H
 
 #include "batman.h"
 #include "types.h"
@@ -33,3 +34,4 @@ void update_orig( struct orig_node *orig_node, struct bat_packet *in, uint32_t n
 void purge_orig( uint32_t curr_time );
 void debug_orig(void);
 
+#endif
diff --git a/os.h b/os.h
index ab02497..26e97f5 100644
--- a/os.h
+++ b/os.h
@@ -19,8 +19,8 @@
  *
  */
 
-#ifndef _BATMAN_OS_H
-#define _BATMAN_OS_H
+#ifndef _BATMAND_OS_H
+#define _BATMAND_OS_H
 
 #include "batman.h"
 
diff --git a/packet.h b/packet.h
index 7d7e5b4..3a98ea5 100644
--- a/packet.h
+++ b/packet.h
@@ -19,6 +19,9 @@
  *
  */
 
+#ifndef _BATMAND_PACKET_H
+#define _BATMAND_PACKET_H
+
 #define COMPAT_VERSION 5
 #define VIS_COMPAT_VERSION 23
 
@@ -57,3 +60,5 @@ struct vis_data {
 	uint8_t data;
 	uint32_t ip;
 } __attribute__((packed));
+
+#endif
diff --git a/profile.h b/profile.h
index a4afde0..d9221d5 100644
--- a/profile.h
+++ b/profile.h
@@ -19,7 +19,8 @@
  *
  */
 
-
+#ifndef _BATMAND_PROFILE_H
+#define _BATMAND_PROFILE_H
 
 enum {
 
@@ -51,3 +52,5 @@ void prof_init(int32_t index, char *name);
 void prof_start(int32_t index);
 void prof_stop(int32_t index);
 void prof_print(void);
+
+#endif
diff --git a/ring_buffer.h b/ring_buffer.h
index 78d8f9e..c1679d9 100644
--- a/ring_buffer.h
+++ b/ring_buffer.h
@@ -19,7 +19,8 @@
  *
  */
 
-
+#ifndef _BATMAND_RING_BUFFER_H
+#define _BATMAND_RING_BUFFER_H
 
 #include <stdint.h>
 #include "batman.h"
@@ -28,3 +29,5 @@
 
 void ring_buffer_set(uint8_t tq_recv[], uint8_t *tq_index, uint8_t value);
 uint8_t ring_buffer_avg(uint8_t tq_recv[]);
+
+#endif
diff --git a/schedule.h b/schedule.h
index 50fd5aa..8bd54cd 100644
--- a/schedule.h
+++ b/schedule.h
@@ -19,7 +19,11 @@
  *
  */
 
+#ifndef _BATMAND_SCHEDULE_H
+#define _BATMAND_SCHEDULE_H
 
 void schedule_own_packet( struct batman_if *batman_if );
 void schedule_forward_packet(struct orig_node *orig_node, struct bat_packet *in, uint32_t neigh, uint8_t directlink, int16_t hna_buff_len, struct batman_if *if_outgoing, uint32_t curr_time);
 void send_outstanding_packets(uint32_t curr_time);
+
+#endif
diff --git a/types.h b/types.h
index 7aa4884..6ae336e 100644
--- a/types.h
+++ b/types.h
@@ -19,8 +19,8 @@
  *
  */
 
-#ifndef TYPES_H
-#define TYPES_H
+#ifndef _BATMAND_TYPES_H
+#define _BATMAND_TYPES_H
 
 #include "packet.h"
 
-- 
1.8.4.rc3


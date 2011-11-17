Return-Path: <daniele.furlan@gmail.com>
From: Daniele Furlan <daniele.furlan@gmail.com>
Date: Thu, 17 Nov 2011 16:53:51 +0100
Message-Id: <1321545233-32676-3-git-send-email-daniele.furlan@gmail.com>
In-Reply-To: <1321545233-32676-1-git-send-email-daniele.furlan@gmail.com>
References: <1321545233-32676-1-git-send-email-daniele.furlan@gmail.com>
Subject: [B.A.T.M.A.N.] [PATCH 3/5] Remove TQ global window and tq averaging.
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
To: b.a.t.m.a.n@lists.open-mesh.org

 This patch remove TQ global window and tq averaging, only the latest tq
 value is maintained, this is necessary to guarantee metric monotonicity
 necessary to ensure loop-freeness.
 This patch remove also unused ring_buffer.c and ring_buffer.h files.

Signed-off-by: Daniele Furlan <daniele.furlan@gmail.com>
---
 Makefile.kbuild |    1 -
 bat_iv_ogm.c    |   21 +++++++--------------
 main.h          |    2 +-
 ring_buffer.c   |   52 ----------------------------------------------------
 ring_buffer.h   |   28 ----------------------------
 types.h         |    2 --
 6 files changed, 8 insertions(+), 98 deletions(-)
 delete mode 100644 ring_buffer.c
 delete mode 100644 ring_buffer.h

diff --git a/Makefile.kbuild b/Makefile.kbuild
index bd7e93c..ee83b89 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -43,7 +43,6 @@ batman-adv-y += hash.o
 batman-adv-y += icmp_socket.o
 batman-adv-y += main.o
 batman-adv-y += originator.o
-batman-adv-y += ring_buffer.o
 batman-adv-y += routing.o
 batman-adv-y += send.o
 batman-adv-y += soft-interface.o
diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index bdb4f1a..9f6cc9b 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -22,7 +22,6 @@
 #include "main.h"
 #include "bat_ogm.h"
 #include "translation-table.h"
-#include "ring_buffer.h"
 #include "originator.h"
 #include "routing.h"
 #include "gateway_common.h"
@@ -604,12 +603,11 @@ static void bat_ogm_orig_update(struct bat_priv *bat_priv,
 		if (is_duplicate)
 			continue;
 
-		spin_lock_bh(&tmp_neigh_node->tq_lock);
-		ring_buffer_set(tmp_neigh_node->tq_recv,
-				&tmp_neigh_node->tq_index, 0);
-		tmp_neigh_node->tq =
-			ring_buffer_avg(tmp_neigh_node->tq_recv);
-		spin_unlock_bh(&tmp_neigh_node->tq_lock);
+		/* if not received more than TQ_MAX_SEQNO_GAP OGM from neighbour
+		 * set its tq to 0 */
+		if ((batman_ogm_packet->seqno - tmp_neigh_node->last_seqno) >
+		    												TQ_MAX_SEQNO_GAP)
+			tmp_neigh_node->tq = 0;
 	}
 
 	if (!neigh_node) {
@@ -633,13 +631,8 @@ static void bat_ogm_orig_update(struct bat_priv *bat_priv,
 
 	orig_node->flags = batman_ogm_packet->flags;
 	neigh_node->last_valid = jiffies;
-
-	spin_lock_bh(&neigh_node->tq_lock);
-	ring_buffer_set(neigh_node->tq_recv,
-			&neigh_node->tq_index,
-			batman_ogm_packet->tq);
-	neigh_node->tq = ring_buffer_avg(neigh_node->tq_recv);
-	spin_unlock_bh(&neigh_node->tq_lock);
+	/* update tq of neighbour */
+	neigh_node->tq = batman_ogm_packet->tq;
 
 	if (!is_duplicate) {
 		orig_node->last_ttl = batman_ogm_packet->ttl;
diff --git a/main.h b/main.h
index 464439f..a778388 100644
--- a/main.h
+++ b/main.h
@@ -49,7 +49,7 @@
 #define TQ_LOCAL_WINDOW_SIZE 64
 #define TT_REQUEST_TIMEOUT 3 /* seconds we have to keep pending tt_req */
 
-#define TQ_GLOBAL_WINDOW_SIZE 5
+#define TQ_MAX_SEQNO_GAP 5 /* max ogm loss before declaring a path broken */
 #define TQ_LOCAL_BIDRECT_SEND_MINIMUM 1
 #define TQ_LOCAL_BIDRECT_RECV_MINIMUM 1
 #define TQ_TOTAL_BIDRECT_LIMIT 1
diff --git a/ring_buffer.c b/ring_buffer.c
deleted file mode 100644
index f1ccfa7..0000000
--- a/ring_buffer.c
+++ /dev/null
@@ -1,52 +0,0 @@
-/*
- * Copyright (C) 2007-2011 B.A.T.M.A.N. contributors:
- *
- * Marek Lindner
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
- */
-
-#include "main.h"
-#include "ring_buffer.h"
-
-void ring_buffer_set(uint8_t lq_recv[], uint8_t *lq_index, uint8_t value)
-{
-	lq_recv[*lq_index] = value;
-	*lq_index = (*lq_index + 1) % TQ_GLOBAL_WINDOW_SIZE;
-}
-
-uint8_t ring_buffer_avg(const uint8_t lq_recv[])
-{
-	const uint8_t *ptr;
-	uint16_t count = 0, i = 0, sum = 0;
-
-	ptr = lq_recv;
-
-	while (i < TQ_GLOBAL_WINDOW_SIZE) {
-		if (*ptr != 0) {
-			count++;
-			sum += *ptr;
-		}
-
-		i++;
-		ptr++;
-	}
-
-	if (count == 0)
-		return 0;
-
-	return (uint8_t)(sum / count);
-}
diff --git a/ring_buffer.h b/ring_buffer.h
deleted file mode 100644
index 7cdfe62..0000000
--- a/ring_buffer.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- * Copyright (C) 2007-2011 B.A.T.M.A.N. contributors:
- *
- * Marek Lindner
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
- */
-
-#ifndef _NET_BATMAN_ADV_RING_BUFFER_H_
-#define _NET_BATMAN_ADV_RING_BUFFER_H_
-
-void ring_buffer_set(uint8_t lq_recv[], uint8_t *lq_index, uint8_t value);
-uint8_t ring_buffer_avg(const uint8_t lq_recv[]);
-
-#endif /* _NET_BATMAN_ADV_RING_BUFFER_H_ */
diff --git a/types.h b/types.h
index 910ce85..2006277 100644
--- a/types.h
+++ b/types.h
@@ -126,8 +126,6 @@ struct neigh_node {
 	struct hlist_node list;
 	uint8_t addr[ETH_ALEN];
 	uint8_t real_packet_count;
-	uint8_t tq_recv[TQ_GLOBAL_WINDOW_SIZE];
-	uint8_t tq_index;
 	uint8_t tq;
 	uint32_t last_seqno;
 	uint8_t last_ttl;
-- 
1.7.1


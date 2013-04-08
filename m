Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon,  8 Apr 2013 09:38:12 +0200
Message-Id: <1365406692-16390-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: move ring_buffer helper
	functions in bat_iv_ogm
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

the two lonely ring_buffer helper functions are used by the
bat_iv_ogm module only and therefore they can be moved
inside it.

Reported-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 Makefile.kbuild |  1 -
 bat_iv_ogm.c    | 30 +++++++++++++++++++++++++++++-
 ring_buffer.c   | 51 ---------------------------------------------------
 ring_buffer.h   | 27 ---------------------------
 4 files changed, 29 insertions(+), 80 deletions(-)
 delete mode 100644 ring_buffer.c
 delete mode 100644 ring_buffer.h

diff --git a/Makefile.kbuild b/Makefile.kbuild
index acbac2a..489bb36 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -32,7 +32,6 @@ batman-adv-y += icmp_socket.o
 batman-adv-y += main.o
 batman-adv-$(CONFIG_BATMAN_ADV_NC) += network-coding.o
 batman-adv-y += originator.o
-batman-adv-y += ring_buffer.o
 batman-adv-y += routing.o
 batman-adv-y += send.o
 batman-adv-y += soft-interface.o
diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 3c6670f..66d2c3b 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -19,7 +19,6 @@
 
 #include "main.h"
 #include "translation-table.h"
-#include "ring_buffer.h"
 #include "originator.h"
 #include "routing.h"
 #include "gateway_common.h"
@@ -29,6 +28,35 @@
 #include "bat_algo.h"
 #include "network-coding.h"
 
+static void batadv_ring_buffer_set(uint8_t lq_recv[], uint8_t *lq_index,
+				   uint8_t value)
+{
+	lq_recv[*lq_index] = value;
+	*lq_index = (*lq_index + 1) % BATADV_TQ_GLOBAL_WINDOW_SIZE;
+}
+
+static uint8_t batadv_ring_buffer_avg(const uint8_t lq_recv[])
+{
+	const uint8_t *ptr;
+	uint16_t count = 0, i = 0, sum = 0;
+
+	ptr = lq_recv;
+
+	while (i < BATADV_TQ_GLOBAL_WINDOW_SIZE) {
+		if (*ptr != 0) {
+			count++;
+			sum += *ptr;
+		}
+
+		i++;
+		ptr++;
+	}
+
+	if (count == 0)
+		return 0;
+
+	return (uint8_t)(sum / count);
+}
 static struct batadv_neigh_node *
 batadv_iv_ogm_neigh_new(struct batadv_hard_iface *hard_iface,
 			const uint8_t *neigh_addr,
diff --git a/ring_buffer.c b/ring_buffer.c
deleted file mode 100644
index ccab0bb..0000000
--- a/ring_buffer.c
+++ /dev/null
@@ -1,51 +0,0 @@
-/* Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
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
- */
-
-#include "main.h"
-#include "ring_buffer.h"
-
-void batadv_ring_buffer_set(uint8_t lq_recv[], uint8_t *lq_index,
-			    uint8_t value)
-{
-	lq_recv[*lq_index] = value;
-	*lq_index = (*lq_index + 1) % BATADV_TQ_GLOBAL_WINDOW_SIZE;
-}
-
-uint8_t batadv_ring_buffer_avg(const uint8_t lq_recv[])
-{
-	const uint8_t *ptr;
-	uint16_t count = 0, i = 0, sum = 0;
-
-	ptr = lq_recv;
-
-	while (i < BATADV_TQ_GLOBAL_WINDOW_SIZE) {
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
index 3f92ae2..0000000
--- a/ring_buffer.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/* Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
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
- */
-
-#ifndef _NET_BATMAN_ADV_RING_BUFFER_H_
-#define _NET_BATMAN_ADV_RING_BUFFER_H_
-
-void batadv_ring_buffer_set(uint8_t lq_recv[], uint8_t *lq_index,
-			    uint8_t value);
-uint8_t batadv_ring_buffer_avg(const uint8_t lq_recv[]);
-
-#endif /* _NET_BATMAN_ADV_RING_BUFFER_H_ */
-- 
1.8.1.5


Return-Path: <andrew.lunn@ascom.ch>
Date: Sat, 18 Jul 2009 16:54:35 +0200
From: Andrew Lunn <andrew.lunn@ascom.ch>
Message-ID: <20090718145435.GO4656@ma.tech.ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [batman-adv] Cleanup ring_buffer.[ch]
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>

Make proc.[ch] clean with respect to the 2.6.29 checkpatch
script.

Signed-off-by: Andrew Lunn <andrew.lunn@ascom.ch>
Index: batman-adv-kernelland/ring_buffer.c
===================================================================
--- batman-adv-kernelland/ring_buffer.c	(revision 1351)
+++ batman-adv-kernelland/ring_buffer.c	(working copy)
@@ -17,15 +17,9 @@
  *
  */
 
-
-
-
-
 #include "main.h"
 #include "ring_buffer.h"
 
-
-
 void ring_buffer_set(uint8_t lq_recv[], uint8_t *lq_index, uint8_t value)
 {
 	lq_recv[*lq_index] = value;
Index: batman-adv-kernelland/ring_buffer.h
===================================================================
--- batman-adv-kernelland/ring_buffer.h	(revision 1351)
+++ batman-adv-kernelland/ring_buffer.h	(working copy)
@@ -17,9 +17,5 @@
  *
  */
 
-
-
-
-
-void ring_buffer_set( uint8_t lq_recv[], uint8_t *lq_index, uint8_t value );
-uint8_t ring_buffer_avg( uint8_t lq_recv[] );
+void ring_buffer_set(uint8_t lq_recv[], uint8_t *lq_index, uint8_t value);
+uint8_t ring_buffer_avg(uint8_t lq_recv[]);

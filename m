Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sun, 14 Mar 2010 16:46:28 +0100
Message-Id: <1268581588-5153-1-git-send-email-linus.luessing@web.de>
In-Reply-To: <201003122009.02956.sven.eckelmann@gmx.de>
References: <201003122009.02956.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Fixing wrap-around bug in vis
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
To: b.a.t.m.a.n@lists.open-mesh.net

When the seqno for a vis packet had a wrap around from i.e. 255 to 0,
add_packet() would falsely claim the older packet with the seqno 255 as
newer as the one with the seqno of 0 and would therefore ignore the new
packet. This happens with all following vis packets until the old vis
packet expires after 180 seconds timeout. This patch fixes this issue
and gets rid of these highly undesired 3min. breaks for the vis-server.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv-kernelland/vis.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/batman-adv-kernelland/vis.c b/batman-adv-kernelland/vis.c
index fa8a487..5fd8710 100644
--- a/batman-adv-kernelland/vis.c
+++ b/batman-adv-kernelland/vis.c
@@ -28,6 +28,22 @@
 #include "hash.h"
 #include "compat.h"
 
+/* Returns the smallest signed integer in two's complement with the sizeof x */
+#define smallest_signed_int(x) (1u << (7u + 8u * (sizeof(x) - 1u)))
+
+/* Checks if a sequence number x is a predecessor/successor of y.
+   they handle overflows/underflows and can correctly check for a
+   predecessor/successor unless the variable sequence number has grown by
+   more then 2**(bitwidth(x)-1)-1.
+   This means that for a uint8_t with the maximum value 255, it would think:
+    * when adding nothing - it is neither a predecessor nor a successor
+    * before adding more than 127 to the starting value - it is a predecessor,
+    * when adding 128 - it is neither a predecessor nor a successor,
+    * after adding more than 127 to the starting value - it is a successor */
+#define seq_before(x,y) ({typeof(x) _dummy = (x - y); \
+                         _dummy > smallest_signed_int(_dummy); })
+#define seq_after(x,y) seq_before(y,x)
+
 struct hashtable_t *vis_hash;
 DEFINE_SPINLOCK(vis_hash_lock);
 static DEFINE_SPINLOCK(recv_list_lock);
@@ -213,7 +229,7 @@ static struct vis_info *add_packet(struct vis_packet *vis_packet,
 	old_info = hash_find(vis_hash, &search_elem);
 
 	if (old_info != NULL) {
-		if (vis_packet->seqno - old_info->packet.seqno <= 0) {
+		if (!seq_after(vis_packet->seqno, old_info->packet.seqno)) {
 			if (old_info->packet.seqno == vis_packet->seqno) {
 				recv_list_add(&old_info->recv_list,
 					      vis_packet->sender_orig);
-- 
1.7.0


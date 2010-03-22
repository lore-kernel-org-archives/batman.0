Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Mon, 22 Mar 2010 22:46:15 +0100
Message-Id: <1269294375-11043-4-git-send-email-andrew@lunn.ch>
In-Reply-To: <1269294375-11043-1-git-send-email-andrew@lunn.ch>
References: <1269294375-11043-1-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 3/3] Staging: batman-adv: Fixing wrap-around
	bug in vis
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
To: gregkh@suse.de
Cc: b.a.t.m.a.n@lists.open-mesh.net

From: Linus Lüssing <linus.luessing@web.de>

When the seqno for a vis packet had a wrap around from i.e. 255 to 0,
add_packet() would falsely claim the older packet with the seqno 255 as
newer as the one with the seqno of 0 and would therefore ignore the new
packet. This happens with all following vis packets until the old vis
packet expires after 180 seconds timeout. This patch fixes this issue
and gets rid of these highly undesired 3min. breaks for the vis-server.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/staging/batman-adv/vis.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/batman-adv/vis.c b/drivers/staging/batman-adv/vis.c
index 222db01..28eac7e 100644
--- a/drivers/staging/batman-adv/vis.c
+++ b/drivers/staging/batman-adv/vis.c
@@ -27,6 +27,22 @@
 #include "hard-interface.h"
 #include "hash.h"
 
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
+#define seq_before(x, y) ({typeof(x) _dummy = (x - y); \
+			  _dummy > smallest_signed_int(_dummy); })
+#define seq_after(x, y) seq_before(y, x)
+
 struct hashtable_t *vis_hash;
 DEFINE_SPINLOCK(vis_hash_lock);
 static DEFINE_SPINLOCK(recv_list_lock);
@@ -212,7 +228,7 @@ static struct vis_info *add_packet(struct vis_packet *vis_packet,
 	old_info = hash_find(vis_hash, &search_elem);
 
 	if (old_info != NULL) {
-		if (vis_packet->seqno - old_info->packet.seqno <= 0) {
+		if (!seq_after(vis_packet->seqno, old_info->packet.seqno)) {
 			if (old_info->packet.seqno == vis_packet->seqno) {
 				recv_list_add(&old_info->recv_list,
 					      vis_packet->sender_orig);
-- 
1.7.0


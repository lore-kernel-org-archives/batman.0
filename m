Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 30 Nov 2014 22:33:57 +0100
Message-Id: <1417383237-15348-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH-maint] batman-adv: Check total_size when
	reassembling fragments
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

The fragmentation code was replaced in 9b3eab61754d74a93c9840c296013fe3b4a1b606
("batman-adv: Receive fragmented packets and merge") by an implementation which
handles the queueing+merging of fragments based on their size and the
total_size of the non-fragmented packet. This total_size is announced by each
fragment. The new implementation doesn't check if the the total_size
information of the packets inside one chain is consistent. This allows an
attacker to inject packets belonging to the same fragmentation sequence number
with varying total_size information. The missing validation can cause a crash
when the fragments are merged because the total_size information is only
retrieved from the first packet by batadv_frag_merge_packets. But the queueing
function batadv_frag_insert_packet always uses the total_size from the latest
packet to check if the fragmented packet was transferred completely and is now
ready to be merged.

Assume two packets with the size x and y.

1. first packet (fragno 1) is sent with a size x and the total_size x+y' (y' < y)
2. second packet (fragno 0) is sent with a size y and the total_size x+y

The fragmentation code would try to merge the two packets because the
accumulated packets have a combined size of x+y and the second packet was sent
with total_size of x+y.

The fragments merging code only took the information from the first packet with
the total_size x+y' and created a buffer with enough space for x+y' bytes. But
the second packet cannot be copied inside the prepared free space because it is
y-y' bytes larger than the remaining space.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Acked-by: Martin Hundebøll <martin@hundeboll.net>
---
This is only a resend of the patch
 https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2014-November/012584.html

This was necessary because the mail thread was hijacked by others who started
to discuss a different problem which may or may not be caused by the
fragmentation code (or batman-adv at all). At least they removed me from the
Cc so I had not received their "responses".

This also gave me the opportunity to change some words in the commit message.
---
 fragmentation.c | 7 +++++--
 types.h         | 2 ++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fragmentation.c b/fragmentation.c
index 362e91a..3a19d4d 100644
--- a/fragmentation.c
+++ b/fragmentation.c
@@ -161,6 +161,7 @@ static bool batadv_frag_insert_packet(struct batadv_orig_node *orig_node,
 		hlist_add_head(&frag_entry_new->list, &chain->head);
 		chain->size = skb->len - hdr_size;
 		chain->timestamp = jiffies;
+		chain->total_size = ntohs(frag_packet->total_size);
 		ret = true;
 		goto out;
 	}
@@ -195,9 +196,11 @@ static bool batadv_frag_insert_packet(struct batadv_orig_node *orig_node,
 
 out:
 	if (chain->size > batadv_frag_size_limit() ||
-	    ntohs(frag_packet->total_size) > batadv_frag_size_limit()) {
+	    chain->total_size != ntohs(frag_packet->total_size) ||
+	    chain->total_size > batadv_frag_size_limit()) {
 		/* Clear chain if total size of either the list or the packet
-		 * exceeds the maximum size of one merged packet.
+		 * exceeds the maximum size of one merged packet. Don't allow
+		 * packets to have different total_size.
 		 */
 		batadv_frag_clear_chain(&chain->head);
 		chain->size = 0;
diff --git a/types.h b/types.h
index 462a70c..c4d7d24 100644
--- a/types.h
+++ b/types.h
@@ -132,6 +132,7 @@ struct batadv_orig_ifinfo {
  * @timestamp: time (jiffie) of last received fragment
  * @seqno: sequence number of the fragments in the list
  * @size: accumulated size of packets in list
+ * @total_size: expected size of the assembled packet
  */
 struct batadv_frag_table_entry {
 	struct hlist_head head;
@@ -139,6 +140,7 @@ struct batadv_frag_table_entry {
 	unsigned long timestamp;
 	uint16_t seqno;
 	uint16_t size;
+	uint16_t total_size;
 };
 
 /**
-- 
2.1.3


Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon,  1 Dec 2014 00:05:20 +0100
Message-Id: <1417388720-5019-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [RFC] batman-adv: Calculate extra tail size based on
	queued fragments
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
Cc: martin@hundeboll.net, Sven Eckelmann <sven@narfation.org>

The fragmentation code was replaced in 9b3eab61754d74a93c9840c296013fe3b4a1b606
("batman-adv: Receive fragmented packets and merge"). The new code provided a
mostly unused parameter skb for the merging function. It is used inside the
function to calculate the additionally needed skb tailroom. But instead of
increasing its own tailroom, it is only increasing the tailroom of the first
queued skb. This is not correct in most situations because the first queued
entry can be a different one than the parameter.

An observed problem was:

1. packet with size 104, total_size 1464, fragno 1 was received
   - packet is queued
2. packet with size 1400, total_size 1464, fragno 0 was received
   - packet is queued at the end of the list
3. enough data was received and can be given to the merge function
   (1464 == (1400 - 20) + (104 - 20))
   - merge functions gets 1400 byte large packet as skb argument
4. merge function gets first entry in queue (104 byte)
   - stored as skb_out
5. merge function calculates the required extra tail as total_size - skb->len
   - pskb_expand_head tail of skb_out with 64 bytes
6. merge function tries to squeeze the extra 1380 bytes from the second queued
   skb (1400 byte aka skb parameter) in the 64 extra tail bytes of skb_out

Instead take only skbs from the queue to merge a packet and remove the
problematic parameter.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Reported-by: Philipp Psurek <philipp.psurek@gmail.com>
---
This patch requires also the patch
"Check total_size when reassembling fragments" to be applied.

This is only compile tested.

 fragmentation.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/fragmentation.c b/fragmentation.c
index c741318..aeaf1ab 100644
--- a/fragmentation.c
+++ b/fragmentation.c
@@ -228,18 +228,13 @@ err:
  * Returns the merged skb or NULL on error.
  */
 static struct sk_buff *
-batadv_frag_merge_packets(struct hlist_head *chain, struct sk_buff *skb)
+batadv_frag_merge_packets(struct hlist_head *chain)
 {
 	struct batadv_frag_packet *packet;
 	struct batadv_frag_list_entry *entry;
 	struct sk_buff *skb_out = NULL;
 	int size, hdr_size = sizeof(struct batadv_frag_packet);
-
-	/* Make sure incoming skb has non-bogus data. */
-	packet = (struct batadv_frag_packet *)skb->data;
-	size = ntohs(packet->total_size);
-	if (size > batadv_frag_size_limit())
-		goto free;
+	int extra_tail;
 
 	/* Remove first entry, as this is the destination for the rest of the
 	 * fragments.
@@ -249,11 +244,17 @@ batadv_frag_merge_packets(struct hlist_head *chain, struct sk_buff *skb)
 	skb_out = entry->skb;
 	kfree(entry);
 
+	packet = (struct batadv_frag_packet *)skb_out->data;
+	size = ntohs(packet->total_size);
+
 	/* Make room for the rest of the fragments. */
-	if (pskb_expand_head(skb_out, 0, size - skb->len, GFP_ATOMIC) < 0) {
-		kfree_skb(skb_out);
-		skb_out = NULL;
-		goto free;
+	if (size > skb_out->len) {
+		extra_tail = size - skb_out->len;
+		if (pskb_expand_head(skb_out, 0, extra_tail, GFP_ATOMIC) < 0) {
+			kfree_skb(skb_out);
+			skb_out = NULL;
+			goto free;
+		}
 	}
 
 	/* Move the existing MAC header to just before the payload. (Override
@@ -304,7 +305,7 @@ bool batadv_frag_skb_buffer(struct sk_buff **skb,
 	if (hlist_empty(&head))
 		goto out;
 
-	skb_out = batadv_frag_merge_packets(&head, *skb);
+	skb_out = batadv_frag_merge_packets(&head);
 	if (!skb_out)
 		goto out_err;
 
-- 
2.1.3


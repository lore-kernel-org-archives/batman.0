Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Fri, 29 May 2015 11:05:15 +0200
Message-Id: <1432890328-8247-4-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1432890328-8247-1-git-send-email-antonio@meshcoding.com>
References: <1432890328-8247-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 03/16] batman-adv: Check total_size when
	queueing fragments
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <antonio@meshcoding.com>, Marek Lindner <mareklindner@neomailbox.ch>

From: Sven Eckelmann <sven@narfation.org>

The fragmentation code was replaced in
610bfc6bc99bc83680d190ebc69359a05fc7f605 ("batman-adv: Receive fragmented
packets and merge") by an implementation which handles the queueing+merging
of fragments based on their size and the total_size of the non-fragmented
packet. This total_size is announced by each fragment. The new
implementation doesn't check if the the total_size information of the
packets inside one chain is consistent.

This is consistency check is recommended to allow using any of the packets
in the queue to decide whether all fragments of a packet are received or
not.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Acked-by: Martin Hundebøll <martin@hundeboll.net>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/fragmentation.c | 7 +++++--
 net/batman-adv/types.h         | 2 ++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index af495cc..a9fc653 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
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
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 28f2461..e95db42 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
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
2.4.2


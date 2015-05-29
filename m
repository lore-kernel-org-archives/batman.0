Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Fri, 29 May 2015 11:05:16 +0200
Message-Id: <1432890328-8247-5-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1432890328-8247-1-git-send-email-antonio@meshcoding.com>
References: <1432890328-8247-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 04/16] batman-adv: Use only queued fragments
	when merging
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

The fragment queueing code now validates the total_size of each fragment,
checks when enough fragments are queued to allow to merge them into a
single packet and if the fragments have the correct size. Therefore, it is
not required to have any other parameter for the merging function than a
list of queued fragments.

This change should avoid problems like in the past when the different skb
from the list and the function parameter were mixed incorrectly.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Acked-by: Martin Hundebøll <martin@hundeboll.net>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/fragmentation.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index a9fc653..6ce3c84 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -231,19 +231,13 @@ err:
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
 
-	/* Make sure incoming skb has non-bogus data. */
-	packet = (struct batadv_frag_packet *)skb->data;
-	size = ntohs(packet->total_size);
-	if (size > batadv_frag_size_limit())
-		goto free;
-
 	/* Remove first entry, as this is the destination for the rest of the
 	 * fragments.
 	 */
@@ -252,6 +246,9 @@ batadv_frag_merge_packets(struct hlist_head *chain, struct sk_buff *skb)
 	skb_out = entry->skb;
 	kfree(entry);
 
+	packet = (struct batadv_frag_packet *)skb_out->data;
+	size = ntohs(packet->total_size);
+
 	/* Make room for the rest of the fragments. */
 	if (pskb_expand_head(skb_out, 0, size - skb_out->len, GFP_ATOMIC) < 0) {
 		kfree_skb(skb_out);
@@ -307,7 +304,7 @@ bool batadv_frag_skb_buffer(struct sk_buff **skb,
 	if (hlist_empty(&head))
 		goto out;
 
-	skb_out = batadv_frag_merge_packets(&head, *skb);
+	skb_out = batadv_frag_merge_packets(&head);
 	if (!skb_out)
 		goto out_err;
 
-- 
2.4.2


Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 12 Feb 2017 11:26:33 +0100
Message-Id: <20170212102634.6279-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH maint 1/2] batman-adv: Fix double free during
	fragment merge error
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
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>

The function batadv_frag_skb_buffer was supposed not to consume the skbuff
on errors. This was followed in the helper function
batadv_frag_insert_packet when the skb would potentially be inserted in the
fragment queue. But it could happen that the next helper function
batadv_frag_merge_packets would try to merge the fragments and fail. This
results in a kfree_skb of all the enqueued fragments (including the just
inserted one). batadv_recv_frag_packet would detect the error in
batadv_frag_skb_buffer and try to free the skb again.

The behavior of batadv_frag_skb_buffer (and its helper
batadv_frag_insert_packet) must therefore be changed to always consume the
skbuff to have a common behavior and avoid the double kfree_skb.

Fixes: 9b3eab61754d ("batman-adv: Receive fragmented packets and merge")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Cc: Martin Hundebøll <martin@hundeboll.net>

 net/batman-adv/fragmentation.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index ead18ca8..7b523e6c 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -239,8 +239,10 @@ err_unlock:
 	spin_unlock_bh(&chain->lock);
 
 err:
-	if (!ret)
+	if (!ret) {
 		kfree(frag_entry_new);
+		kfree_skb(skb);
+	}
 
 	return ret;
 }
@@ -313,7 +315,7 @@ free:
  *
  * There are three possible outcomes: 1) Packet is merged: Return true and
  * set *skb to merged packet; 2) Packet is buffered: Return true and set *skb
- * to NULL; 3) Error: Return false and leave skb as is.
+ * to NULL; 3) Error: Return false and free skb.
  *
  * Return: true when packet is merged or buffered, false when skb is not not
  * used.
@@ -338,9 +340,9 @@ bool batadv_frag_skb_buffer(struct sk_buff **skb,
 		goto out_err;
 
 out:
-	*skb = skb_out;
 	ret = true;
 out_err:
+	*skb = skb_out;
 	return ret;
 }
 
-- 
2.11.0


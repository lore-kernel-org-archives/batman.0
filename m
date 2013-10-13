Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sun, 13 Oct 2013 02:50:17 +0200
Message-Id: <1381625420-4062-2-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1381625420-4062-1-git-send-email-antonio@meshcoding.com>
References: <1381625420-4062-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCHv2 1/4] batman-adv: don't switch byte order
	too often if not needed
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

If possible, operations like ntohs/ntohl should not be
performed too often. Use a variable to locally store the
converted value and then use it.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 routing.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/routing.c b/routing.c
index 666f02d..4336361 100644
--- a/routing.c
+++ b/routing.c
@@ -947,6 +947,7 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 	int hdr_size = sizeof(*bcast_packet);
 	int ret = NET_RX_DROP;
 	int32_t seq_diff;
+	uint32_t seqno;
 
 	/* drop packet if it has not necessary minimum size */
 	if (unlikely(!pskb_may_pull(skb, hdr_size)))
@@ -982,12 +983,13 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 
 	spin_lock_bh(&orig_node->bcast_seqno_lock);
 
+	seqno = ntohl(bcast_packet->seqno);
 	/* check whether the packet is a duplicate */
 	if (batadv_test_bit(orig_node->bcast_bits, orig_node->last_bcast_seqno,
-			    ntohl(bcast_packet->seqno)))
+			    seqno))
 		goto spin_unlock;
 
-	seq_diff = ntohl(bcast_packet->seqno) - orig_node->last_bcast_seqno;
+	seq_diff = seqno - orig_node->last_bcast_seqno;
 
 	/* check whether the packet is old and the host just restarted. */
 	if (batadv_window_protected(bat_priv, seq_diff,
@@ -998,7 +1000,7 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 	 * if required.
 	 */
 	if (batadv_bit_get_packet(bat_priv, orig_node->bcast_bits, seq_diff, 1))
-		orig_node->last_bcast_seqno = ntohl(bcast_packet->seqno);
+		orig_node->last_bcast_seqno = seqno;
 
 	spin_unlock_bh(&orig_node->bcast_seqno_lock);
 
-- 
1.8.3.2


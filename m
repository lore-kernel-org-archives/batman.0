Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Thu,  9 Jan 2014 15:52:51 +0100
Message-Id: <1389279182-3256-3-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1389279182-3256-1-git-send-email-antonio@meshcoding.com>
References: <1389279182-3256-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 02/13] batman-adv: don't switch byte order
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <antonio@meshcoding.com>, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

If possible, operations like ntohs/ntohl should not be
performed too often. Use a variable to locally store the
converted value and then use it.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/routing.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 46278bf..a89e812 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1135,6 +1135,7 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 	int hdr_size = sizeof(*bcast_packet);
 	int ret = NET_RX_DROP;
 	int32_t seq_diff;
+	uint32_t seqno;
 
 	/* drop packet if it has not necessary minimum size */
 	if (unlikely(!pskb_may_pull(skb, hdr_size)))
@@ -1170,12 +1171,13 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 
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
@@ -1186,7 +1188,7 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 	 * if required.
 	 */
 	if (batadv_bit_get_packet(bat_priv, orig_node->bcast_bits, seq_diff, 1))
-		orig_node->last_bcast_seqno = ntohl(bcast_packet->seqno);
+		orig_node->last_bcast_seqno = seqno;
 
 	spin_unlock_bh(&orig_node->bcast_seqno_lock);
 
-- 
1.8.5.2


Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon,  1 Dec 2014 13:59:44 +0100
Message-Id: <1417438784-20880-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Unify fragment size calculation
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
can handle up to 16 fragments of a packet. The packet is prepared for the split
in fragments by the function batadv_frag_send_packet and the actual split is
done by batadv_frag_create.

Both functions calculate the size of a fragment themself. But their calculation
differs because batadv_frag_send_packet also subtracts ETH_HLEN. Therefore,
the check in batadv_frag_send_packet if a full fragment can be created may
return true even when batadv_frag_create cannot create a full fragment.

The function batadv_frag_create doesn't check the size of the skb before
splitting it and therefore might try to create a larger fragment than the
remaining buffer. This creates an integer underflow and an invalid len is given
to skb_split.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 fragmentation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fragmentation.c b/fragmentation.c
index 0ab228f..9e06457 100644
--- a/fragmentation.c
+++ b/fragmentation.c
@@ -433,7 +433,7 @@ bool batadv_frag_send_packet(struct sk_buff *skb,
 	 * fragments larger than BATADV_FRAG_MAX_FRAG_SIZE
 	 */
 	mtu = min_t(unsigned, mtu, BATADV_FRAG_MAX_FRAG_SIZE);
-	max_fragment_size = (mtu - header_size - ETH_HLEN);
+	max_fragment_size = mtu - header_size;
 	max_packet_size = max_fragment_size * BATADV_FRAG_MAX_FRAGMENTS;
 
 	/* Don't even try to fragment, if we need more than 16 fragments */
-- 
2.1.3


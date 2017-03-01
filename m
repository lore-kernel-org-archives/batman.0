Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed,  1 Mar 2017 16:53:33 +0100
Message-Id: <20170301155333.19406-3-sw@simonwunderlich.de>
In-Reply-To: <20170301155333.19406-1-sw@simonwunderlich.de>
References: <20170301155333.19406-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Fix transmission of final,
	16th fragment
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Linus Lüssing <linus.luessing@c0d3.blue>

Trying to split and transmit a unicast packet in 16 parts will fail for
the final fragment: After having sent the 15th one with a frag_packet.no
index of 14, we will increase the the index to 15 - and return with an
error code immediately, even though one more fragment is due for
transmission and allowed.

Fixing this issue by moving the check before incrementing the index.

While at it, adding an unlikely(), because the check is actually more of
an assertion.

Fixes: ee75ed88879a ("batman-adv: Fragment and send skbs larger than mtu")
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/fragmentation.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 31e97e9aee0d..11149e5be4e0 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -501,6 +501,12 @@ int batadv_frag_send_packet(struct sk_buff *skb,
 
 	/* Eat and send fragments from the tail of skb */
 	while (skb->len > max_fragment_size) {
+		/* The initial check in this function should cover this case */
+		if (unlikely(frag_header.no == BATADV_FRAG_MAX_FRAGMENTS - 1)) {
+			ret = -EINVAL;
+			goto put_primary_if;
+		}
+
 		skb_fragment = batadv_frag_create(skb, &frag_header, mtu);
 		if (!skb_fragment) {
 			ret = -ENOMEM;
@@ -517,12 +523,6 @@ int batadv_frag_send_packet(struct sk_buff *skb,
 		}
 
 		frag_header.no++;
-
-		/* The initial check in this function should cover this case */
-		if (frag_header.no == BATADV_FRAG_MAX_FRAGMENTS - 1) {
-			ret = -EINVAL;
-			goto put_primary_if;
-		}
 	}
 
 	/* Make room for the fragment header. */
-- 
2.11.0


Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Mon, 13 Feb 2017 20:44:31 +0100
Message-Id: <20170213194431.24075-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Fix transmission of final,
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
To: b.a.t.m.a.n@lists.open-mesh.org

Trying to split and transmit a unicast packet in 16 parts will fail for
the final fragment: After having sent the 15th one with a frag_packet.no
index of 14, we will increase the the index to 15 - and return with an
error code immediately, even though one more fragment is due for
transmission and allowed.

Fixing this issue by moving the check before incrementing the index.

While at it, adding an unlikely(), because the check is actually more of
an assertion.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>

---

Compile time tested only
---
 net/batman-adv/fragmentation.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 0854ebd..f181868 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -499,6 +499,12 @@ int batadv_frag_send_packet(struct sk_buff *skb,
 
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
@@ -515,12 +521,6 @@ int batadv_frag_send_packet(struct sk_buff *skb,
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
2.1.4


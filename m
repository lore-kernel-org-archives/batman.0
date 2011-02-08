Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed,  9 Feb 2011 00:35:02 +0100
Message-Id: <1297208102-4931-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Use successive sequence numbers
	for fragments
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

The two fragments of an unicast packet must have successive sequence numbers to
allow the receiver side to detect matching fragments and merge them again. The
current implementation doesn't provide that property because a sequence of two
atomic_inc_return may be interleaved with another sequence which also changes
the variable.

The access to the fragment sequence number pool has either to be protected by
correct locking or the access to the pool has to reserve two sequence numbers
in a single access. The latter one can easily be done by increasing the value
of the last used sequence number by 2 in a single access. The generated window
of two currently unused sequence numbers can now be scattered across the two
fragments.

Reported-by: Linus Lüssing <linus.luessing@web.de>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 batman-adv/unicast.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/batman-adv/unicast.c b/batman-adv/unicast.c
index db62b66..29ad9b8 100644
--- a/batman-adv/unicast.c
+++ b/batman-adv/unicast.c
@@ -237,6 +237,7 @@ int frag_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 	int ucf_hdr_len = sizeof(struct unicast_frag_packet);
 	int data_len = skb->len - uc_hdr_len;
 	int large_tail = 0;
+	uint16_t seqno;
 
 	if (!bat_priv->primary_if)
 		goto dropped;
@@ -272,10 +273,9 @@ int frag_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 	frag1->flags = UNI_FRAG_HEAD | large_tail;
 	frag2->flags = large_tail;
 
-	frag1->seqno = htons((uint16_t)atomic_inc_return(
-			     &batman_if->frag_seqno));
-	frag2->seqno = htons((uint16_t)atomic_inc_return(
-			     &batman_if->frag_seqno));
+	seqno = atomic_add_return(2, &batman_if->frag_seqno);
+	frag1->seqno = htons(seqno - 1);
+	frag2->seqno = htons(seqno);
 
 	send_skb_packet(skb, batman_if, dstaddr);
 	send_skb_packet(frag_skb, batman_if, dstaddr);
-- 
1.7.2.3


Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  5 Feb 2011 22:41:58 +0100
Message-Id: <1296942118-4875-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Linearize fragment packets
	before merge
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

We access the data inside the skbs of two fragments directly using memmove
during the merge. The data of the skb could span over multiple skb pages. An
direct access without knowledge about the pages would lead to an invalid memory
access.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 batman-adv/unicast.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/batman-adv/unicast.c b/batman-adv/unicast.c
index 6a9ab61..04b152c 100644
--- a/batman-adv/unicast.c
+++ b/batman-adv/unicast.c
@@ -50,6 +50,11 @@ static struct sk_buff *frag_merge_packet(struct list_head *head,
 		skb = tfp->skb;
 	}
 
+	if (skb_linearize(skb) < 0 || skb_linearize(tmp_skb) < 0) {
+		kfree_skb(tfp->skb);
+		return NULL;
+	}
+
 	skb_pull(tmp_skb, sizeof(struct unicast_frag_packet));
 	if (pskb_expand_head(skb, 0, tmp_skb->len, GFP_ATOMIC) < 0) {
 		/* free buffered skb, skb will be freed later */
-- 
1.7.2.3


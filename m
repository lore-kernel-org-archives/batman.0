Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 16 Jan 2011 03:38:46 +0100
Message-Id: <1295145527-17537-2-git-send-email-sven@narfation.org>
In-Reply-To: <1295145527-17537-1-git-send-email-sven@narfation.org>
References: <1295145527-17537-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Even Batman should not
	dereference NULL pointers
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Jesper Juhl <jj@chaosbits.net>

From: Jesper Juhl <jj@chaosbits.net>

There's a problem in net/batman-adv/unicast.c::frag_send_skb().
dev_alloc_skb() allocates memory and may fail, thus returning NULL. If
this happens we'll pass a NULL pointer on to skb_split() which in turn
hands it to skb_split_inside_header() from where it gets passed to
skb_put() that lets skb_tail_pointer() play with it and that function
dereferences it. And thus the bat dies.

While I was at it I also moved the call to dev_alloc_skb() above the
assignment to 'unicast_packet' since there's no reason to do that
assignment if the memory allocation fails.

Signed-off-by: Jesper Juhl <jj@chaosbits.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/unicast.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/unicast.c b/net/batman-adv/unicast.c
index dc2e28b..ee41fef 100644
--- a/net/batman-adv/unicast.c
+++ b/net/batman-adv/unicast.c
@@ -229,10 +229,12 @@ int frag_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 	if (!bat_priv->primary_if)
 		goto dropped;
 
-	unicast_packet = (struct unicast_packet *) skb->data;
+	frag_skb = dev_alloc_skb(data_len - (data_len / 2) + ucf_hdr_len);
+	if (!frag_skb)
+		goto dropped;
 
+	unicast_packet = (struct unicast_packet *) skb->data;
 	memcpy(&tmp_uc, unicast_packet, uc_hdr_len);
-	frag_skb = dev_alloc_skb(data_len - (data_len / 2) + ucf_hdr_len);
 	skb_split(skb, frag_skb, data_len / 2);
 
 	if (my_skb_head_push(skb, ucf_hdr_len - uc_hdr_len) < 0 ||
-- 
1.7.2.3


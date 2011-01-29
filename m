Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 29 Jan 2011 22:47:29 +0100
Message-Id: <1296337660-12376-3-git-send-email-sven@narfation.org>
In-Reply-To: <1296337660-12376-1-git-send-email-sven@narfation.org>
References: <1296337660-12376-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 02/13] batman-adv: Create roughly equal sized
	fragments
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

The routing algorithm must know how large two fragments are to be able to
decide that it is safe to merge them or if it should resubmit without waiting
for the second part. When these two fragments have a too different size, it is
not possible to guess right in every situation.

The user could easily configure the MTU of the attached cards so that one
fragment is forwarded and the other one is added to the fragments table to wait
for the missing part.

For even sized packets, it is possible to split it so that the resulting
packages are equal sized by ignoring the old non-fragment header at the
beginning of the original packet.

This still creates different sized fragments for uneven sized packets.

Reported-by: Russell Senior <russell@personaltelco.net>
Reported-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/unicast.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/unicast.c b/net/batman-adv/unicast.c
index ee41fef..811f7fc 100644
--- a/net/batman-adv/unicast.c
+++ b/net/batman-adv/unicast.c
@@ -224,7 +224,7 @@ int frag_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 	struct unicast_frag_packet *frag1, *frag2;
 	int uc_hdr_len = sizeof(struct unicast_packet);
 	int ucf_hdr_len = sizeof(struct unicast_frag_packet);
-	int data_len = skb->len;
+	int data_len = skb->len - uc_hdr_len;
 
 	if (!bat_priv->primary_if)
 		goto dropped;
@@ -232,10 +232,11 @@ int frag_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 	frag_skb = dev_alloc_skb(data_len - (data_len / 2) + ucf_hdr_len);
 	if (!frag_skb)
 		goto dropped;
+	skb_reserve(frag_skb, ucf_hdr_len);
 
 	unicast_packet = (struct unicast_packet *) skb->data;
 	memcpy(&tmp_uc, unicast_packet, uc_hdr_len);
-	skb_split(skb, frag_skb, data_len / 2);
+	skb_split(skb, frag_skb, data_len / 2 + uc_hdr_len);
 
 	if (my_skb_head_push(skb, ucf_hdr_len - uc_hdr_len) < 0 ||
 	    my_skb_head_push(frag_skb, ucf_hdr_len) < 0)
-- 
1.7.2.3


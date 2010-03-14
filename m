Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun, 14 Mar 2010 18:15:55 +0100
Message-Id: <1268586955-29220-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <20100314155025.GA18908@sven-atom.lazhur.ath.cx>
References: <20100314155025.GA18908@sven-atom.lazhur.ath.cx>
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: Clone shared bat packets
	before modifying them
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

"tcpdump" and "batctl td" will receive packets with a wrong sequence
number on systems with a different endianess than network byte order.
This happens due to the reordering of bytes in the function which
handles aggregated bat packets. The function which receives the bat
packets must ensure that these buffers aren't shared with anything else
before that function tries to write into it. Otherwise it has to copy
the buffers so it is save again to change them.

Reported-by: Kevin Steen <batman@kevinsteen.net>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv-kernelland/routing.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/batman-adv-kernelland/routing.c b/batman-adv-kernelland/routing.c
index 8610b22..0051259 100644
--- a/batman-adv-kernelland/routing.c
+++ b/batman-adv-kernelland/routing.c
@@ -680,6 +680,7 @@ int recv_bat_packet(struct sk_buff *skb,
 {
 	struct ethhdr *ethhdr;
 	unsigned long flags;
+	struct sk_buff *skb_old;
 
 	/* drop packet if it has not necessary minimum size */
 	if (skb_headlen(skb) < sizeof(struct batman_packet))
@@ -695,12 +696,19 @@ int recv_bat_packet(struct sk_buff *skb,
 	if (is_bcast(ethhdr->h_source))
 		return NET_RX_DROP;
 
-	spin_lock_irqsave(&orig_hash_lock, flags);
 	/* TODO: we use headlen instead of "length", because
 	 * only this data is paged in. */
-	/* TODO: is another skb_copy needed here? there will be
-	 * written on the data, but nobody (?) should further use
-	 * this data */
+
+	/* create a copy of the skb, if needed, to modify it. */
+	if (!skb_clone_writable(skb, skb_headlen(skb))) {
+		skb_old = skb;
+		skb = skb_copy(skb, GFP_ATOMIC);
+		if (!skb)
+			return NET_RX_DROP;
+		kfree_skb(skb_old);
+	}
+
+	spin_lock_irqsave(&orig_hash_lock, flags);
 	receive_aggr_bat_packet(ethhdr,
 				skb->data,
 				skb_headlen(skb),
-- 
1.7.0


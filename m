Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Thu,  6 May 2010 22:18:28 +0200
Message-Id: <1273177132-8792-3-git-send-email-andrew@lunn.ch>
In-Reply-To: <1273177132-8792-1-git-send-email-andrew@lunn.ch>
References: <1273177132-8792-1-git-send-email-andrew@lunn.ch>
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 02/26] staging:batman-adv: Clone shared bat
	packets before modifying them
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
To: gregkh@suse.de
Cc: b.a.t.m.a.n@lists.open-mesh.net

From: Sven Eckelmann <sven.eckelmann@gmx.de>

"tcpdump" and "batctl td" will receive packets with a wrong sequence
number on systems with a different endianess than network byte order.
This happens due to the reordering of bytes in the function which
handles aggregated bat packets. The function which receives the bat
packets must ensure that these buffers aren't shared with anything else
before that function tries to write into it. Otherwise it has to copy
the buffers so it is save again to change them.

Reported-by: Kevin Steen <batman@kevinsteen.net>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/staging/batman-adv/routing.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/batman-adv/routing.c b/drivers/staging/batman-adv/routing.c
index d89048b..39dd093 100644
--- a/drivers/staging/batman-adv/routing.c
+++ b/drivers/staging/batman-adv/routing.c
@@ -549,6 +549,7 @@ int recv_bat_packet(struct sk_buff *skb,
 {
 	struct ethhdr *ethhdr;
 	unsigned long flags;
+	struct sk_buff *skb_old;
 
 	/* drop packet if it has not necessary minimum size */
 	if (skb_headlen(skb) < sizeof(struct batman_packet))
@@ -564,12 +565,19 @@ int recv_bat_packet(struct sk_buff *skb,
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
1.7.1


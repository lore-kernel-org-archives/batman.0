Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Fri, 13 Jun 2014 11:27:14 +0200
Message-Id: <1402651634-30966-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH] net: add __pskb_copy_fclone and
	pskb_copy_for_clone
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
Cc: antonio@meshcoding.com

From: Octavian Purdila <octavian.purdila@intel.com>

There are several instances where a pskb_copy or __pskb_copy is
immediately followed by an skb_clone.

Add a couple of new functions to allow the copy skb to be allocated
from the fclone cache and thus speed up subsequent skb_clone calls.

Cc: Alexander Smirnov <alex.bluesman.smirnov@gmail.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Marek Lindner <mareklindner@neomailbox.ch>
Cc: Simon Wunderlich <sw@simonwunderlich.de>
Cc: Antonio Quartulli <antonio@meshcoding.com>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Gustavo Padovan <gustavo@padovan.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Arvid Brodin <arvid.brodin@alten.se>
Cc: Patrick McHardy <kaber@trash.net>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
Cc: Lauro Ramos Venancio <lauro.venancio@openbossa.org>
Cc: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Jon Maloy <jon.maloy@ericsson.com>
Cc: Allan Stephens <allan.stephens@windriver.com>
Cc: Andrew Hendry <andrew.hendry@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>
Reviewed-by: Christoph Paasch <christoph.paasch@uclouvain.be>
Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 compat.h                | 6 ++++++
 distributed-arp-table.c | 2 +-
 network-coding.c        | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/compat.h b/compat.h
index 28f4cfe..ed5b815 100644
--- a/compat.h
+++ b/compat.h
@@ -440,4 +440,10 @@ static int __batadv_interface_kill_vid(struct net_device *dev, __be16 proto,\
 
 #endif /* < KERNEL_VERSION(3, 14, 0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 16, 0)
+
+#define pskb_copy_for_clone pskb_copy
+
+#endif /* < KERNEL_VERSION(3, 16, 0) */
+
 #endif /* _NET_BATMAN_ADV_COMPAT_H_ */
diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index b7406e0..b598111 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -595,7 +595,7 @@ static bool batadv_dat_send_data(struct batadv_priv *bat_priv,
 		if (!neigh_node)
 			goto free_orig;
 
-		tmp_skb = pskb_copy(skb, GFP_ATOMIC);
+		tmp_skb = pskb_copy_for_clone(skb, GFP_ATOMIC);
 		if (!batadv_send_skb_prepare_unicast_4addr(bat_priv, tmp_skb,
 							   cand[i].orig_node,
 							   packet_subtype)) {
diff --git a/network-coding.c b/network-coding.c
index 40a2fc4..8d04d17 100644
--- a/network-coding.c
+++ b/network-coding.c
@@ -1344,7 +1344,7 @@ static void batadv_nc_skb_store_before_coding(struct batadv_priv *bat_priv,
 	struct ethhdr *ethhdr;
 
 	/* Copy skb header to change the mac header */
-	skb = pskb_copy(skb, GFP_ATOMIC);
+	skb = pskb_copy_for_clone(skb, GFP_ATOMIC);
 	if (!skb)
 		return;
 
-- 
1.8.5.5


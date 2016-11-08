Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue,  8 Nov 2016 17:45:25 +0100
Message-Id: <20161108164526.7518-17-sw@simonwunderlich.de>
In-Reply-To: <20161108164526.7518-1-sw@simonwunderlich.de>
References: <20161108164526.7518-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 16/17] batman-adv: Disallow zero and mcast
	src address for mgmt frames
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

From: Sven Eckelmann <sven@narfation.org>

The routing check for management frames is validating the source mac
address in the outer ethernet header. It rejects every source mac address
which is a broadcast address. But it also has to reject the zero-mac
address and multicast mac addresses.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/routing.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 9646623..381f040 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -196,8 +196,8 @@ bool batadv_check_management_packet(struct sk_buff *skb,
 	if (!is_broadcast_ether_addr(ethhdr->h_dest))
 		return false;
 
-	/* packet with broadcast sender address */
-	if (is_broadcast_ether_addr(ethhdr->h_source))
+	/* packet with invalid sender address */
+	if (!is_valid_ether_addr(ethhdr->h_source))
 		return false;
 
 	/* create a copy of the skb, if needed, to modify it. */
-- 
2.10.1


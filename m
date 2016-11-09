Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed,  9 Nov 2016 23:25:55 +0100
Message-Id: <20161109222606.29039-7-sw@simonwunderlich.de>
In-Reply-To: <20161109222606.29039-1-sw@simonwunderlich.de>
References: <20161109222606.29039-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 06/17] batman-adv: Remove unused
	skb_reset_mac_header()
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

During broadcast queueing, the skb_reset_mac_header() sets the skb
to a place invalid for a MAC header, pointing right into the
batman-adv broadcast packet. Luckily, no one seems to actually use
eth_hdr(skb) afterwards until batadv_send_skb_packet() resets the
header to a valid position again.

Therefore removing this unnecessary, weird skb_reset_mac_header()
call.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/send.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index e1e9136..be3f6d7 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -586,8 +586,6 @@ int batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
 	bcast_packet = (struct batadv_bcast_packet *)newskb->data;
 	bcast_packet->ttl--;
 
-	skb_reset_mac_header(newskb);
-
 	forw_packet->skb = newskb;
 
 	INIT_DELAYED_WORK(&forw_packet->delayed_work,
-- 
2.10.1


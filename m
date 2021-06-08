Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 04/11] batman-adv: bcast: avoid skb-copy for (re)queued broadcasts
Date: Tue,  8 Jun 2021 17:26:53 +0200
Message-Id: <20210608152700.30315-5-sw@simonwunderlich.de>
In-Reply-To: <20210608152700.30315-1-sw@simonwunderlich.de>
References: <20210608152700.30315-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: kuba@kernel.org, davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Linus Lüssing <linus.luessing@c0d3.blue>

Broadcast packets send via batadv_send_outstanding_bcast_packet() were
originally copied in batadv_forw_bcast_packet_to_list() before being
queued. And after that only the ethernet header will be pushed through
batadv_send_broadcast_skb()->batadv_send_skb_packet() which works safely
on skb clones as it uses batadv_skb_head_push()->skb_cow_head().

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 07b0ba265472..0b9dd29d3b6a 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -1072,7 +1072,7 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 	}
 
 	/* send a copy of the saved skb */
-	skb1 = skb_copy(forw_packet->skb, GFP_ATOMIC);
+	skb1 = skb_clone(forw_packet->skb, GFP_ATOMIC);
 	if (!skb1)
 		goto out;
 
-- 
2.20.1


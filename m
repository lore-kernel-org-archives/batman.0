Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Fri, 22 Jul 2016 13:38:01 +0200
Message-Id: <1469187482-29894-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Remove unused
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
To: b.a.t.m.a.n@lists.open-mesh.org

During broadcast queueing, the skb_reset_mac_header() sets the skb
to a place invalid for a MAC header, pointing right into the
batman-adv broadcast packet. Luckily, no one seems to actually use
eth_hdr(skb) afterwards until batadv_send_skb_packet() resets the
header to a valid position again.

Therefore removing this unnecessary, weird skb_reset_mac_header()
call.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/batman-adv/send.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 8d4e1f5..97bdb0c 100644
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
2.1.4


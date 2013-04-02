Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue,  2 Apr 2013 13:59:35 +0200
Message-Id: <1364903975-7141-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH maint] batman-adv: properly push NET_IP_ALIGN
	bytes more
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

every batman-adv encapsulated packet is supposed to begin
with an Ethernet header plus 2 bytes for correct alignment
on 4 bytes boundary.

However, even if allocations are made correctly, the final
encapsulation is not made properly since the encapsulating
function does not push NET_IP_ALIGN bytes other than
ETH_HLEN.

Fix it by pushing the correct amount of bytes.

Introduced by 7f91790974c258e71a62f6dee8cb1dbe5dff36c3
("batman-adv: Reserve extra bytes in skb for better alignment")

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---

Please review this patch as I am not 100% sure this is correct.
What I understood is that any batman-adv should have this shape:

+--------------+
| ETH_HEADER   |
|              |
+--------------+
| NET_IP_ALIGN |
+--------------+
| BATADV_HEADER|
+--------------+
| ...          |

but by pushing ETH_HLEN only, we end up in a shorter packet, because the head
pointer is not moved up enough to contain the NET_IP_ALIGN bytes too (so we are
back to the situation where our headers are not properly placed in memory).

Cheers,


 send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/send.c b/send.c
index a67cffd..a338093 100644
--- a/send.c
+++ b/send.c
@@ -54,7 +54,7 @@ int batadv_send_skb_packet(struct sk_buff *skb,
 	}
 
 	/* push to the ethernet header. */
-	if (batadv_skb_head_push(skb, ETH_HLEN) < 0)
+	if (batadv_skb_head_push(skb, ETH_HLEN + NET_IP_ALIGN) < 0)
 		goto send_skb_err;
 
 	skb_reset_mac_header(skb);
-- 
1.8.1.5


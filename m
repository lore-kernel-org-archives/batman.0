Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sun, 13 Oct 2013 13:22:46 +0200
Message-Id: <1381663381-626-2-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1381663381-626-1-git-send-email-antonio@meshcoding.com>
References: <1381663381-626-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 01/16] batman-adv: only add recordroute
	information to icmp request/reply
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>, Antonio Quartulli <antonio@meshcoding.com>, Marek Lindner <lindner_marek@yahoo.de>

From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>

Adding host information for record route is only required for ICMP
requests and replys, and should not be added to just any (future?)
packet type.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/routing.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 457dfef..0dc1c0e 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -379,7 +379,9 @@ int batadv_recv_icmp_packet(struct sk_buff *skb,
 	icmp_packet = (struct batadv_icmp_packet_rr *)skb->data;
 
 	/* add record route information if not full */
-	if ((hdr_size == sizeof(struct batadv_icmp_packet_rr)) &&
+	if ((icmp_packet->msg_type == BATADV_ECHO_REPLY ||
+	     icmp_packet->msg_type == BATADV_ECHO_REQUEST) &&
+	    (hdr_size == sizeof(struct batadv_icmp_packet_rr)) &&
 	    (icmp_packet->rr_cur < BATADV_RR_LEN)) {
 		memcpy(&(icmp_packet->rr[icmp_packet->rr_cur]),
 		       ethhdr->h_dest, ETH_ALEN);
-- 
1.8.3.2


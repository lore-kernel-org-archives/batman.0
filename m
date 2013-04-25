Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Thu, 25 Apr 2013 10:37:26 +0200
Message-Id: <1366879046-24507-7-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1366879046-24507-1-git-send-email-siwu@hrz.tu-chemnitz.de>
References: <1366879046-24507-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCHv4 6/6] batman-adv: only add recordroute
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

Adding host information for record route is only required for ICMP
requests and replys, and should not be added to just any (future?)
packet type.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 routing.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/routing.c b/routing.c
index 3f5802c..7c372f1 100644
--- a/routing.c
+++ b/routing.c
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
1.7.10.4


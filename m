Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 12 Dec 2011 19:31:54 +0800
Message-Id: <1323689516-24427-11-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1323689516-24427-1-git-send-email-lindner_marek@yahoo.de>
References: <1323689516-24427-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 10/11] batman-adv: Directly check read of
	icmp packet in copy_from_user
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Sven Eckelmann <sven@narfation.org>

The access_ok read check can be directly done in copy_from_user since a failure
of access_ok is handled the same way as an error in __copy_from_user.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 net/batman-adv/icmp_socket.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/icmp_socket.c b/net/batman-adv/icmp_socket.c
index 88ab26f..3b04fff 100644
--- a/net/batman-adv/icmp_socket.c
+++ b/net/batman-adv/icmp_socket.c
@@ -187,12 +187,7 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 	skb_reserve(skb, sizeof(struct ethhdr));
 	icmp_packet = (struct icmp_packet_rr *)skb_put(skb, packet_len);
 
-	if (!access_ok(VERIFY_READ, buff, packet_len)) {
-		len = -EFAULT;
-		goto free_skb;
-	}
-
-	if (__copy_from_user(icmp_packet, buff, packet_len)) {
+	if (copy_from_user(icmp_packet, buff, packet_len)) {
 		len = -EFAULT;
 		goto free_skb;
 	}
-- 
1.7.5.4


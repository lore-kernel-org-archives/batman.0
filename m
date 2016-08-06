Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  6 Aug 2016 16:59:37 +0200
Message-Id: <1470495578-20476-2-git-send-email-sven@narfation.org>
In-Reply-To: <1470495578-20476-1-git-send-email-sven@narfation.org>
References: <1470495578-20476-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v2 2/3] batman-adv: Disallow zero and mcast
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
To: b.a.t.m.a.n@lists.open-mesh.org

The routing check for management frames is validating the source mac
address in the outer ethernet header. It rejects every source mac address
which is a broadcast address. But it also has to reject the zero-mac
address and multicast mac addresses.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
 - clarify in commit message that only the outer ethernet header is
   affected
   (thanks Linus)
 - split in patch 1/2
---
 net/batman-adv/routing.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 913ab51..e2b91e6 100644
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
2.8.1


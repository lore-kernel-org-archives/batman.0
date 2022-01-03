Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 3/3] batman-adv: remove unneeded variable in batadv_nc_init
Date: Mon,  3 Jan 2022 18:17:22 +0100
Message-Id: <20220103171722.1126109-4-sw@simonwunderlich.de>
In-Reply-To: <20220103171722.1126109-1-sw@simonwunderlich.de>
References: <20220103171722.1126109-1-sw@simonwunderlich.de>
MIME-Version: 1.0
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Minghao Chi <chi.minghao@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Minghao Chi <chi.minghao@zte.com.cn>

Return status directly from function called.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/network-coding.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 0a7f1d36a6a8..974d726fabb9 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -58,13 +58,9 @@ static int batadv_nc_recv_coded_packet(struct sk_buff *skb,
  */
 int __init batadv_nc_init(void)
 {
-	int ret;
-
 	/* Register our packet type */
-	ret = batadv_recv_handler_register(BATADV_CODED,
-					   batadv_nc_recv_coded_packet);
-
-	return ret;
+	return batadv_recv_handler_register(BATADV_CODED,
+					    batadv_nc_recv_coded_packet);
 }
 
 /**
-- 
2.30.2


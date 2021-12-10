Return-Path: <cgel.zte@gmail.com>
From: cgel.zte@gmail.com
Subject: [PATCHv2] net/batman-adv:remove unneeded variable
Date: Fri, 10 Dec 2021 09:42:06 +0000
Message-Id: <20211210094206.426283-1-chi.minghao@zte.com.cn>
In-Reply-To: <2844186.8fJna1iEf4@ripper>
References: <2844186.8fJna1iEf4@ripper>
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
To: sven@narfation.org
Cc: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, cgel.zte@gmail.com, chi.minghao@zte.com.cn, davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch, netdev@vger.kernel.org, sw@simonwunderlich.de, Zeal Robot <zealci@zte.com.cn>

From: Minghao Chi <chi.minghao@zte.com.cn>

Return status directly from function called.
change since v1: zealci@zte.com.cm
             v2: zealci@zte.com.cn
Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 net/batman-adv/network-coding.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 0a7f1d36a6a8..0c300476d335 100644
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
+	return batadv_recv_handler_register(BATADV_CODED,
 					   batadv_nc_recv_coded_packet);
-
-	return ret;
 }
 
 /**
-- 
2.25.1


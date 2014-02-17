Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Mon, 17 Feb 2014 21:48:47 +0100
Message-Id: <1392670129-2498-9-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1392670129-2498-1-git-send-email-antonio@meshcoding.com>
References: <1392670129-2498-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 08/10] batman-adv: free skb on TVLV parsing
	success
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

When the TVLV parsing routine succeed the skb is left
untouched thus leading to a memory leak.

Fix this by consuming the skb in case of success.

Introduced by ef26157747d42254453f6b3ac2bd8bd3c53339c3
("batman-adv: tvlv - basic infrastructure")

Reported-by: Russel Senior <russell@personaltelco.net>
Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
Tested-by: Russell Senior <russell@personaltelco.net>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 net/batman-adv/routing.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index c26f073..a953d5b 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -918,6 +918,8 @@ int batadv_recv_unicast_tvlv(struct sk_buff *skb,
 
 	if (ret != NET_RX_SUCCESS)
 		ret = batadv_route_unicast_packet(skb, recv_if);
+	else
+		consume_skb(skb);
 
 	return ret;
 }
-- 
1.8.5.3


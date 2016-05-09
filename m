Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Mon,  9 May 2016 20:03:35 +0200
Message-Id: <1462817016-17867-2-git-send-email-andrew@lunn.ch>
In-Reply-To: <1462817016-17867-1-git-send-email-andrew@lunn.ch>
References: <1462817016-17867-1-git-send-email-andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Set skb priority in fragments
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

BATMAN will set the skb->priority based on the IP precedence or 802.1q
tag. However, if it needs to fragment the frame, it currently leaves
the fragment skb with the default priority and actually overwrites the
priority in the unfragmented frame. Fix this.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 net/batman-adv/fragmentation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 65536db..a3fefbd 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -414,7 +414,7 @@ static struct sk_buff *batadv_frag_create(struct sk_buff *skb,
 	if (!skb_fragment)
 		goto err;
 
-	skb->priority = TC_PRIO_CONTROL;
+	skb_fragment->priority = skb->priority;
 
 	/* Eat the last mtu-bytes of the skb */
 	skb_reserve(skb_fragment, header_size + ETH_HLEN);
-- 
2.8.0.rc3


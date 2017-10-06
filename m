Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri,  6 Oct 2017 15:54:36 +0200
Message-Id: <20171006135437.26736-4-sw@simonwunderlich.de>
In-Reply-To: <20171006135437.26736-1-sw@simonwunderlich.de>
References: <20171006135437.26736-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/4] batman-adv: Fix "line over 80
 characters" checkpatch warning
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

Fixes: 242c1a28eb61 ("net: Remove useless function skb_header_release")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/soft-interface.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 7c8288245f80..3af4b0b29b23 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -69,8 +69,8 @@ int batadv_skb_head_push(struct sk_buff *skb, unsigned int len)
 	int result;
 
 	/* TODO: We must check if we can release all references to non-payload
-	 * data using __skb_header_release in our skbs to allow skb_cow_header to
-	 * work optimally. This means that those skbs are not allowed to read
+	 * data using __skb_header_release in our skbs to allow skb_cow_header
+	 * to work optimally. This means that those skbs are not allowed to read
 	 * or write any data which is before the current position of skb->data
 	 * after that call and thus allow other skbs with the same data buffer
 	 * to write freely in that area.
-- 
2.11.0


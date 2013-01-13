Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 14 Jan 2013 09:41:07 +1000
Message-Id: <1358120480-25960-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1358120480-25960-1-git-send-email-ordex@autistici.org>
References: <1358120480-25960-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 02/15] batman-adv: Do not add multicast MAC
	addresses to translation table
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Linus Lüssing <linus.luessing@web.de>

The current translation table mechanism is not suitable for multicast
addresses and we are currently flooding such frames anyway.

Therefore this patch prevents multicast MAC addresses being added to the
translation table.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
Acked-by: Antonio Quartulli <ordex@autistici.org>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/soft-interface.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 90f4049..f8cc142 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -180,7 +180,8 @@ static int batadv_interface_tx(struct sk_buff *skb,
 		goto dropped;
 
 	/* Register the client MAC in the transtable */
-	batadv_tt_local_add(soft_iface, ethhdr->h_source, skb->skb_iif);
+	if (!is_multicast_ether_addr(ethhdr->h_source))
+		batadv_tt_local_add(soft_iface, ethhdr->h_source, skb->skb_iif);
 
 	/* don't accept stp packets. STP does not help in meshes.
 	 * better use the bridge loop avoidance ...
-- 
1.8.0.2


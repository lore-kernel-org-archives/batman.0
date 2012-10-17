Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Wed, 17 Oct 2012 15:07:35 +0200
Message-Id: <1350479255-904-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Do not add multicast MAC
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
To: b.a.t.m.a.n@lists.open-mesh.org

The current translation table mechanism is not suitable for multicast
addresses and we are currently flooding such frames anyway.

Therefore this patch prevents multicast MAC addresses being added to the
translation table.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 soft-interface.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/soft-interface.c b/soft-interface.c
index 2d1f895..9955319 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -180,7 +180,8 @@ static int batadv_interface_tx(struct sk_buff *skb,
 		goto dropped;
 
 	/* Register the client MAC in the transtable */
-	batadv_tt_local_add(soft_iface, ethhdr->h_source, skb->skb_iif);
+	if (!is_multicast_ether_addr(ethhdr->h_source))
+		batadv_tt_local_add(soft_iface, ethhdr->h_source, skb->skb_iif);
 
 	/* don't accept stp packets. STP does not help in meshes.
 	 * better use the bridge loop avoidance ...
-- 
1.7.10.4


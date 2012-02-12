Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 12 Feb 2012 14:35:29 +0100
Message-Id: <1329053731-4737-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Remove useless branch for
	NET_ADDR_RANDOM
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
To: b.a.t.m.a.n@lists.open-mesh.org

910ccacb9dd2bfac8ce1ac411af514fe72fa84c0 introduced a branch for a statement
that doesn't need it.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 soft-interface.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/soft-interface.c b/soft-interface.c
index 0087052..3750e9b 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -108,8 +108,7 @@ static int interface_set_mac_addr(struct net_device *dev, void *p)
 	}
 
 	memcpy(dev->dev_addr, addr->sa_data, ETH_ALEN);
-	if (dev->addr_assign_type & NET_ADDR_RANDOM)
-		dev->addr_assign_type &= ~NET_ADDR_RANDOM;
+	dev->addr_assign_type &= ~NET_ADDR_RANDOM;
 
 	return 0;
 }
-- 
1.7.9


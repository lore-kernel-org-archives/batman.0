Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun, 21 Nov 2010 15:33:01 +0100
Message-Id: <1290349981-23883-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <201011211432.44862.lindner_marek@yahoo.de>
References: <201011211432.44862.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Ensure that eth_type_trans gets
	linear memory
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
To: b.a.t.m.a.n@lists.open-mesh.org, lesniak@sra.uni-hannover.de

eth_type_trans tries to pull data with the length of the ethernet header
from the skb. We only ensured that enough data for the first ethernet
header and the batman header is available in non-paged memory of the skb
and not for the ethernet after the batman header.

eth_type_trans would fail sometimes with drivers which don't ensure that
all there data is perfectly linearised.

Reported-by: thorkill <lesniak@sra.uni-hannover.de>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv/soft-interface.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/batman-adv/soft-interface.c b/batman-adv/soft-interface.c
index e93a99f..e89ede1 100644
--- a/batman-adv/soft-interface.c
+++ b/batman-adv/soft-interface.c
@@ -494,6 +494,8 @@ void interface_rx(struct net_device *soft_iface,
 	}
 
 	/* skb->dev & skb->pkt_type are set here */
+	if (unlikely(!pskb_may_pull(skb, ETH_HLEN)))
+		goto dropped;
 	skb->protocol = eth_type_trans(skb, soft_iface);
 
 	/* should not be neccesary anymore as we use skb_pull_rcsum()
-- 
1.7.2.3


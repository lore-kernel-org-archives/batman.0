Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 17 Jun 2014 12:16:03 +0200
Message-Id: <1403000163-8148-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: increase default hop penalty
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
Cc: Simon Wunderlich <simon@open-mesh.com>

From: Simon Wunderlich <simon@open-mesh.com>

The default hop penalty is currently set to 15, which is applied like
that for multi interface devices (e.g. dual band APs). Single band
devices will still use an effective penalty of 30 (hop penalty + wifi
penalty).

After receiving reports of too long paths in mesh networks with dual
band APs which were fixed by increasing the hop penalty, we'd like to
suggest to increase that default value in the default setting as well.
We've evaluated that increase in a handful of medium sized mesh
networks (5-20 nodes) with single and dual band devices, with changes
for the better (shorter routes, higher throughput) or no change at all.

This patch changes the hop penalty to 30, which will give an effective
penalty of 60 on single band devices (hop penalty + wifi penalty).

Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
---
 soft-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/soft-interface.c b/soft-interface.c
index e783afb..9bf382d 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -757,7 +757,7 @@ static int batadv_softif_init_late(struct net_device *dev)
 	atomic_set(&bat_priv->gw.bandwidth_down, 100);
 	atomic_set(&bat_priv->gw.bandwidth_up, 20);
 	atomic_set(&bat_priv->orig_interval, 1000);
-	atomic_set(&bat_priv->hop_penalty, 15);
+	atomic_set(&bat_priv->hop_penalty, 30);
 #ifdef CONFIG_BATMAN_ADV_DEBUG
 	atomic_set(&bat_priv->log_level, 0);
 #endif
-- 
1.9.1


Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun,  5 Sep 2010 00:25:00 +0200
Message-Id: <1283639100-6506-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Don't free unicast skb on failure
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

The soft-interface transmission function expects that the unicast skb is
still available when a send failed. Otherwise we would try to free the
skb twice and create many different and hard to debug memory access
failures due to access on not (anymore) allocated memory.

Reported-by: Andreas Langer <an.langer@gmx.de>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 unicast.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/unicast.c b/unicast.c
index 84b204b..796d9c1 100644
--- a/unicast.c
+++ b/unicast.c
@@ -264,6 +264,5 @@ int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
 unlock:
 	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
 dropped:
-	kfree_skb(skb);
 	return 1;
 }
-- 
1.7.1


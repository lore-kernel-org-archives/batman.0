Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 2/4] batman-adv: Remove redundant 'flush_workqueue()' calls
Date: Wed,  2 Mar 2022 17:35:20 +0100
Message-Id: <20220302163522.102842-3-sw@simonwunderlich.de>
In-Reply-To: <20220302163522.102842-1-sw@simonwunderlich.de>
References: <20220302163522.102842-1-sw@simonwunderlich.de>
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
To: kuba@kernel.org, davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

'destroy_workqueue()' already drains the queue before destroying it, so
there is no need to flush it explicitly.

Remove the redundant 'flush_workqueue()' calls.

This was generated with coccinelle:

@@
expression E;
@@
- 	flush_workqueue(E);
	destroy_workqueue(E);

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 5207cd8d6ad8..8f1b724d0412 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -132,7 +132,6 @@ static void __exit batadv_exit(void)
 	rtnl_link_unregister(&batadv_link_ops);
 	unregister_netdevice_notifier(&batadv_hard_if_notifier);
 
-	flush_workqueue(batadv_event_workqueue);
 	destroy_workqueue(batadv_event_workqueue);
 	batadv_event_workqueue = NULL;
 
-- 
2.30.2


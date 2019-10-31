Return-Path: <christophe.jaillet@wanadoo.fr>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] batman-adv: Simplify 'batadv_v_ogm_aggr_list_free()'
Date: Thu, 31 Oct 2019 08:42:55 +0100
Message-Id: <20191031074255.3234-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net, mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc, sven@narfation.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Use 'skb_queue_purge()' instead of re-implementing it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
BTW, I don't really see the need of 'aggr_list_lock'. I think that the code
could be refactored to drop 'aggr_list_lock' and use the already existing
'aggr_list.lock'.
This would require to use the lock-free __skb_... variants when working on
'aggr_list'.

As far as I understand, the use of 'aggr_list' and 'aggr_list_lock' is
limited to bat_v_ogm.c'. So the impact would be limited.
This would avoid a useless locking that never fails, so the performance
gain should be really limited.

So, I'm not sure this would be more readable and/or future proof, so
I just note it here to open the discussion.

If interested, I have a (compiled tested only) patch that implements this
change.
---
 net/batman-adv/bat_v_ogm.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index dc4f7430cb5a..b841c83d9c3b 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -177,13 +177,9 @@ static bool batadv_v_ogm_queue_left(struct sk_buff *skb,
  */
 static void batadv_v_ogm_aggr_list_free(struct batadv_hard_iface *hard_iface)
 {
-	struct sk_buff *skb;
-
 	lockdep_assert_held(&hard_iface->bat_v.aggr_list_lock);
 
-	while ((skb = skb_dequeue(&hard_iface->bat_v.aggr_list)))
-		kfree_skb(skb);
-
+	skb_queue_purge(&hard_iface->bat_v.aggr_list);
 	hard_iface->bat_v.aggr_len = 0;
 }
 
-- 
2.20.1


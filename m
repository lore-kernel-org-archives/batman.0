Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 2/5] batman-adv: Simplify 'batadv_v_ogm_aggr_list_free()'
Date: Tue,  5 Nov 2019 10:35:28 +0100
Message-Id: <20191105093531.11398-3-sw@simonwunderlich.de>
In-Reply-To: <20191105093531.11398-1-sw@simonwunderlich.de>
References: <20191105093531.11398-1-sw@simonwunderlich.de>
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Use 'skb_queue_purge()' instead of re-implementing it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_v_ogm.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 8033f24f506c..76b732e2f31c 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -178,13 +178,9 @@ static bool batadv_v_ogm_queue_left(struct sk_buff *skb,
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


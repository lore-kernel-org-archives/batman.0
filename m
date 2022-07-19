Return-Path: <bigeasy@linutronix.de>
Date: Tue, 19 Jul 2022 18:08:12 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 5.15] batman-adv: Use netif_rx_any_context() any.
Message-ID: <YtbW7Ca3t4/3qB7k@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, Antonio Quartulli <a@unstable.cc>, Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>

This reverts the stable commit
   e65d78b12fbc0 ("batman-adv: Use netif_rx().")

The commit message says:

| Since commit
|    baebdf48c3600 ("net: dev: Makes sure netif_rx() can be invoked in any context.")
|
| the function netif_rx() can be used in preemptible/thread context as
| well as in interrupt context.

This commit (baebdf48c3600) has not been backported to the 5.15 stable
series and therefore, the commit which builds upon it, must not be
backported either.

Revert the backport and use netif_rx_any_context() again.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/batman-adv/bridge_loop_avoidance.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 11f6ef657d822..17687848daec5 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -443,7 +443,7 @@ static void batadv_bla_send_claim(struct batadv_priv *bat_priv, u8 *mac,
 	batadv_add_counter(bat_priv, BATADV_CNT_RX_BYTES,
 			   skb->len + ETH_HLEN);
 
-	netif_rx(skb);
+	netif_rx_any_context(skb);
 out:
 	batadv_hardif_put(primary_if);
 }
-- 
2.36.1


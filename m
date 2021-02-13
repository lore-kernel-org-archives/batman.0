Return-Path: <bigeasy@linutronix.de>
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] batman-adv: Use netif_rx_any_context().
Date: Sat, 13 Feb 2021 18:02:04 +0100
Message-Id: <20210213170204.3092113-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>, Sven Eckelmann <sven@narfation.org>, Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The usage of in_interrupt() in non-core code is phased out. Ideally the
information of the calling context should be passed by the callers or the
functions be split as appropriate.

The attempt to consolidate the code by passing an arguemnt or by
distangling it failed due lack of knowledge about this driver and because
the call chains are hard to follow.

As a stop gap use netif_rx_any_context() which invokes the correct code path
depending on context and confines the in_interrupt() usage to core code.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/batman-adv/bridge_loop_avoidance.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge=
_loop_avoidance.c
index d2de12e527baa..b3411a034d87e 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -438,10 +438,7 @@ static void batadv_bla_send_claim(struct batadv_priv *=
bat_priv, u8 *mac,
 	batadv_add_counter(bat_priv, BATADV_CNT_RX_BYTES,
 			   skb->len + ETH_HLEN);
=20
-	if (in_interrupt())
-		netif_rx(skb);
-	else
-		netif_rx_ni(skb);
+	netif_rx_any_context(skb);
 out:
 	if (primary_if)
 		batadv_hardif_put(primary_if);
--=20
2.30.0


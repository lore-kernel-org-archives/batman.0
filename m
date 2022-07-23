Return-Path: <gregkh@linuxfoundation.org>
Subject: Patch "batman-adv: Use netif_rx_any_context() any." has been added to
 the 5.15-stable tree
From: <gregkh@linuxfoundation.org>
Date: Sat, 23 Jul 2022 17:19:55 +0200
In-Reply-To: <YtbW7Ca3t4/3qB7k@linutronix.de>
Message-ID: <1658589595237141@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, bigeasy@linutronix.de, davem@davemloft.net, gregkh@linuxfoundation.org, mareklindner@neomailbox.ch, sashal@kernel.org, sven@narfation.org, sw@simonwunderlich.de, tglx@linutronix.de
Cc: stable-commits@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    batman-adv: Use netif_rx_any_context() any.

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     batman-adv-use-netif_rx_any_context-any.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From bigeasy@linutronix.de  Sat Jul 23 17:18:39 2022
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Tue, 19 Jul 2022 18:08:12 +0200
Subject: batman-adv: Use netif_rx_any_context() any.
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, Antonio Quartulli <a@unstable.cc>, Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>
Message-ID: <YtbW7Ca3t4/3qB7k@linutronix.de>
Content-Disposition: inline

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/bridge_loop_avoidance.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -443,7 +443,7 @@ static void batadv_bla_send_claim(struct
 	batadv_add_counter(bat_priv, BATADV_CNT_RX_BYTES,
 			   skb->len + ETH_HLEN);
 
-	netif_rx(skb);
+	netif_rx_any_context(skb);
 out:
 	batadv_hardif_put(primary_if);
 }


Patches currently in stable-queue which might be from bigeasy@linutronix.de are

queue-5.15/batman-adv-use-netif_rx_any_context-any.patch

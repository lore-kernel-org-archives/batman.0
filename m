Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 15 Dec 2017 12:31:42 +0100
Message-Id: <20171215113143.12852-4-sw@simonwunderlich.de>
In-Reply-To: <20171215113143.12852-1-sw@simonwunderlich.de>
References: <20171215113143.12852-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/4] batman-adv: Fix kernel-doc for timer
 functions
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

The commit e99e88a9d2b0 ("treewide: setup_timer() -> timer_setup()")
changed the argument name and type of the timer function but didn't adjust
the kernel-doc of these functions.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/tp_meter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 15cd2139381e..ebc4e2241c77 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -482,7 +482,7 @@ static void batadv_tp_reset_sender_timer(struct batadv_tp_vars *tp_vars)
 
 /**
  * batadv_tp_sender_timeout - timer that fires in case of packet loss
- * @arg: address of the related tp_vars
+ * @t: address to timer_list inside tp_vars
  *
  * If fired it means that there was packet loss.
  * Switch to Slow Start, set the ss_threshold to half of the current cwnd and
@@ -1106,7 +1106,7 @@ static void batadv_tp_reset_receiver_timer(struct batadv_tp_vars *tp_vars)
 /**
  * batadv_tp_receiver_shutdown - stop a tp meter receiver when timeout is
  *  reached without received ack
- * @arg: address of the related tp_vars
+ * @t: address to timer_list inside tp_vars
  */
 static void batadv_tp_receiver_shutdown(struct timer_list *t)
 {
-- 
2.11.0


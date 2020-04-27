Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 4/5] batman-adv: Utilize prandom_u32_max for random [0, max) values
Date: Mon, 27 Apr 2020 17:06:06 +0200
Message-Id: <20200427150607.31401-5-sw@simonwunderlich.de>
In-Reply-To: <20200427150607.31401-1-sw@simonwunderlich.de>
References: <20200427150607.31401-1-sw@simonwunderlich.de>
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>

From: Sven Eckelmann <sven@narfation.org>

The kernel provides a function to create random values from 0 - (max-1)
since commit f337db64af05 ("random32: add prandom_u32_max and convert open
coded users"). Simply use this function to replace code sections which use
prandom_u32 and a handcrafted method to map it to the correct range.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_iv_ogm.c | 4 ++--
 net/batman-adv/bat_v_elp.c  | 2 +-
 net/batman-adv/bat_v_ogm.c  | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index a7c8dd7ae513..e87f19c82e8d 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -280,7 +280,7 @@ batadv_iv_ogm_emit_send_time(const struct batadv_priv *bat_priv)
 	unsigned int msecs;
 
 	msecs = atomic_read(&bat_priv->orig_interval) - BATADV_JITTER;
-	msecs += prandom_u32() % (2 * BATADV_JITTER);
+	msecs += prandom_u32_max(2 * BATADV_JITTER);
 
 	return jiffies + msecs_to_jiffies(msecs);
 }
@@ -288,7 +288,7 @@ batadv_iv_ogm_emit_send_time(const struct batadv_priv *bat_priv)
 /* when do we schedule a ogm packet to be sent */
 static unsigned long batadv_iv_ogm_fwd_send_time(void)
 {
-	return jiffies + msecs_to_jiffies(prandom_u32() % (BATADV_JITTER / 2));
+	return jiffies + msecs_to_jiffies(prandom_u32_max(BATADV_JITTER / 2));
 }
 
 /* apply hop penalty for a normal link */
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 1e3172db7492..353e49c40e7f 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -49,7 +49,7 @@ static void batadv_v_elp_start_timer(struct batadv_hard_iface *hard_iface)
 	unsigned int msecs;
 
 	msecs = atomic_read(&hard_iface->bat_v.elp_interval) - BATADV_JITTER;
-	msecs += prandom_u32() % (2 * BATADV_JITTER);
+	msecs += prandom_u32_max(2 * BATADV_JITTER);
 
 	queue_delayed_work(batadv_event_workqueue, &hard_iface->bat_v.elp_wq,
 			   msecs_to_jiffies(msecs));
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 969466218999..0959d32be65c 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -88,7 +88,7 @@ static void batadv_v_ogm_start_queue_timer(struct batadv_hard_iface *hard_iface)
 	unsigned int msecs = BATADV_MAX_AGGREGATION_MS * 1000;
 
 	/* msecs * [0.9, 1.1] */
-	msecs += prandom_u32() % (msecs / 5) - (msecs / 10);
+	msecs += prandom_u32_max(msecs / 5) - (msecs / 10);
 	queue_delayed_work(batadv_event_workqueue, &hard_iface->bat_v.aggr_wq,
 			   msecs_to_jiffies(msecs / 1000));
 }
@@ -107,7 +107,7 @@ static void batadv_v_ogm_start_timer(struct batadv_priv *bat_priv)
 		return;
 
 	msecs = atomic_read(&bat_priv->orig_interval) - BATADV_JITTER;
-	msecs += prandom_u32() % (2 * BATADV_JITTER);
+	msecs += prandom_u32_max(2 * BATADV_JITTER);
 	queue_delayed_work(batadv_event_workqueue, &bat_priv->bat_v.ogm_wq,
 			   msecs_to_jiffies(msecs));
 }
-- 
2.20.1


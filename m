Return-Path: <geliangtang@163.com>
From: Geliang Tang <geliangtang@163.com>
Date: Mon, 28 Dec 2015 23:43:37 +0800
Message-Id: <2c0e66fe07809e4069df34cbeba51583ad943c7a.1451317025.git.geliangtang@163.com>
Subject: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: use to_delayed_work
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>, "David S. Miller" <davem@davemloft.net>
Cc: Geliang Tang <geliangtang@163.com>, b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Use to_delayed_work() instead of open-coding it.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 net/batman-adv/bridge_loop_avoidance.c | 2 +-
 net/batman-adv/distributed-arp-table.c | 2 +-
 net/batman-adv/network-coding.c        | 2 +-
 net/batman-adv/originator.c            | 2 +-
 net/batman-adv/send.c                  | 4 ++--
 net/batman-adv/translation-table.c     | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 99dcae3..4f47c82 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1183,7 +1183,7 @@ static void batadv_bla_periodic_work(struct work_struct *work)
 	struct batadv_hard_iface *primary_if;
 	int i;
 
-	delayed_work = container_of(work, struct delayed_work, work);
+	delayed_work = to_delayed_work(work);
 	priv_bla = container_of(delayed_work, struct batadv_priv_bla, work);
 	bat_priv = container_of(priv_bla, struct batadv_priv, bla);
 	primary_if = batadv_primary_if_get_selected(bat_priv);
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index a49c705..64facfc 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -138,7 +138,7 @@ static void batadv_dat_purge(struct work_struct *work)
 	struct batadv_priv_dat *priv_dat;
 	struct batadv_priv *bat_priv;
 
-	delayed_work = container_of(work, struct delayed_work, work);
+	delayed_work = to_delayed_work(work);
 	priv_dat = container_of(delayed_work, struct batadv_priv_dat, work);
 	bat_priv = container_of(priv_dat, struct batadv_priv, dat);
 
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index f5276be..a5ffe20 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -700,7 +700,7 @@ static void batadv_nc_worker(struct work_struct *work)
 	struct batadv_priv *bat_priv;
 	unsigned long timeout;
 
-	delayed_work = container_of(work, struct delayed_work, work);
+	delayed_work = to_delayed_work(work);
 	priv_nc = container_of(delayed_work, struct batadv_priv_nc, work);
 	bat_priv = container_of(priv_nc, struct batadv_priv, nc);
 
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 3c782a33..0eb5d01 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -1232,7 +1232,7 @@ static void batadv_purge_orig(struct work_struct *work)
 	struct delayed_work *delayed_work;
 	struct batadv_priv *bat_priv;
 
-	delayed_work = container_of(work, struct delayed_work, work);
+	delayed_work = to_delayed_work(work);
 	bat_priv = container_of(delayed_work, struct batadv_priv, orig_work);
 	_batadv_purge_orig(bat_priv);
 	queue_delayed_work(batadv_event_workqueue,
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index f664324..848ce65 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -506,7 +506,7 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 	struct net_device *soft_iface;
 	struct batadv_priv *bat_priv;
 
-	delayed_work = container_of(work, struct delayed_work, work);
+	delayed_work = to_delayed_work(work);
 	forw_packet = container_of(delayed_work, struct batadv_forw_packet,
 				   delayed_work);
 	soft_iface = forw_packet->if_incoming->soft_iface;
@@ -559,7 +559,7 @@ void batadv_send_outstanding_bat_ogm_packet(struct work_struct *work)
 	struct batadv_forw_packet *forw_packet;
 	struct batadv_priv *bat_priv;
 
-	delayed_work = container_of(work, struct delayed_work, work);
+	delayed_work = to_delayed_work(work);
 	forw_packet = container_of(delayed_work, struct batadv_forw_packet,
 				   delayed_work);
 	bat_priv = netdev_priv(forw_packet->if_incoming->soft_iface);
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index ec67def..ed6fcc7 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3157,7 +3157,7 @@ static void batadv_tt_purge(struct work_struct *work)
 	struct batadv_priv_tt *priv_tt;
 	struct batadv_priv *bat_priv;
 
-	delayed_work = container_of(work, struct delayed_work, work);
+	delayed_work = to_delayed_work(work);
 	priv_tt = container_of(delayed_work, struct batadv_priv_tt, work);
 	bat_priv = container_of(priv_tt, struct batadv_priv, tt);
 
-- 
2.5.0



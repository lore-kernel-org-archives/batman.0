Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sun, 10 Oct 2010 06:30:00 +0200
Message-Id: <1286685001-15227-4-git-send-email-linus.luessing@web.de>
In-Reply-To: <1286685001-15227-1-git-send-email-linus.luessing@web.de>
References: <1286685001-15227-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 4/5] batman-adv: Make number of
	(re)broadcasts configurable via sysfs
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

Depending on the scenario, people might want to adjust the number of
(re)broadcast of data packets - usually higher values in sparse or lower
values in dense networks.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 bat_sysfs.c |    2 ++
 send.c      |    3 ++-
 types.h     |    1 +
 3 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/bat_sysfs.c b/bat_sysfs.c
index 9fda75e..2f7f118 100644
--- a/bat_sysfs.c
+++ b/bat_sysfs.c
@@ -273,6 +273,7 @@ static BAT_ATTR(vis_mode, S_IRUGO | S_IWUSR, show_vis_mode, store_vis_mode);
 static BAT_ATTR(gw_mode, S_IRUGO | S_IWUSR, show_gw_mode, store_gw_mode);
 BAT_ATTR_UINT(orig_interval, S_IRUGO | S_IWUSR, 2 * JITTER, INT_MAX, NULL);
 BAT_ATTR_UINT(hop_penalty, S_IRUGO | S_IWUSR, 0, TQ_MAX_VALUE, NULL);
+BAT_ATTR_UINT(num_bcasts, S_IRUGO | S_IWUSR, 0, INT_MAX, NULL);
 #ifdef CONFIG_BATMAN_ADV_DEBUG
 BAT_ATTR_UINT(log_level, S_IRUGO | S_IWUSR, 0, 3, NULL);
 #endif
@@ -285,6 +286,7 @@ static struct bat_attribute *mesh_attrs[] = {
 	&bat_attr_gw_mode,
 	&bat_attr_orig_interval,
 	&bat_attr_hop_penalty,
+	&bat_attr_num_bcasts,
 #ifdef CONFIG_BATMAN_ADV_DEBUG
 	&bat_attr_log_level,
 #endif
diff --git a/send.c b/send.c
index 943437b..2f18a0d 100644
--- a/send.c
+++ b/send.c
@@ -455,6 +455,7 @@ static void send_outstanding_bcast_packet(struct work_struct *work)
 	struct sk_buff *skb1;
 	struct net_device *soft_iface = forw_packet->if_incoming->soft_iface;
 	struct bat_priv *bat_priv = netdev_priv(soft_iface);
+	int num_bcasts = atomic_read(&bat_priv->num_bcasts);
 
 	spin_lock_irqsave(&bat_priv->forw_bcast_list_lock, flags);
 	hlist_del(&forw_packet->list);
@@ -479,7 +480,7 @@ static void send_outstanding_bcast_packet(struct work_struct *work)
 	forw_packet->num_packets++;
 
 	/* if we still have some more bcasts to send */
-	if (forw_packet->num_packets < 3) {
+	if (forw_packet->num_packets < num_bcasts) {
 		_add_bcast_packet_to_list(bat_priv, forw_packet,
 					  ((5 * HZ) / 1000));
 		return;
diff --git a/types.h b/types.h
index 75e0b71..0063ad7 100644
--- a/types.h
+++ b/types.h
@@ -132,6 +132,7 @@ struct bat_priv {
 	atomic_t gw_class;
 	atomic_t orig_interval;
 	atomic_t hop_penalty;
+	atomic_t num_bcasts;
 	atomic_t log_level;
 	atomic_t bcast_seqno;
 	atomic_t bcast_queue_left;
-- 
1.7.1


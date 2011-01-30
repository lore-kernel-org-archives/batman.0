Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@saxnet.de>
Date: Sun, 30 Jan 2011 05:39:25 +0100
Message-Id: <1296362366-3852-18-git-send-email-linus.luessing@saxnet.de>
In-Reply-To: <1296362366-3852-1-git-send-email-linus.luessing@saxnet.de>
References: <1296362366-3852-1-git-send-email-linus.luessing@saxnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 17/18] batman-adv: Make number of
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
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@saxnet.de>

Depending on the scenario, people might want to adjust the number of
(re)broadcast of data packets - usually higher values in sparse or lower
values in dense networks.

Signed-off-by: Linus Lüssing <linus.luessing@saxnet.de>
---
 bat_sysfs.c |    2 ++
 send.c      |    3 ++-
 types.h     |    1 +
 3 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/batman-adv/bat_sysfs.c b/batman-adv/bat_sysfs.c
index f6e918f..406ab7c 100644
--- a/batman-adv/bat_sysfs.c
+++ b/batman-adv/bat_sysfs.c
@@ -520,6 +520,7 @@ static BAT_ATTR(gw_mode, S_IRUGO | S_IWUSR, show_gw_mode, store_gw_mode);
 BAT_ATTR_UINT(orig_interval, S_IRUGO | S_IWUSR, 2 * JITTER, INT_MAX,
 	      update_mcast_tracker);
 BAT_ATTR_UINT(hop_penalty, S_IRUGO | S_IWUSR, 0, TQ_MAX_VALUE, NULL);
+BAT_ATTR_UINT(num_bcasts, S_IRUGO | S_IWUSR, 0, INT_MAX, NULL);
 BAT_ATTR_UINT(gw_sel_class, S_IRUGO | S_IWUSR, 1, TQ_MAX_VALUE,
 	      post_gw_deselect);
 static BAT_ATTR(gw_bandwidth, S_IRUGO | S_IWUSR, show_gw_bwidth,
@@ -544,6 +545,7 @@ static struct bat_attribute *mesh_attrs[] = {
 	&bat_attr_gw_mode,
 	&bat_attr_orig_interval,
 	&bat_attr_hop_penalty,
+	&bat_attr_num_bcasts,
 	&bat_attr_gw_sel_class,
 	&bat_attr_gw_bandwidth,
 	&bat_attr_mcast_mode,
diff --git a/batman-adv/send.c b/batman-adv/send.c
index 0d4a2a6..80dfa80 100644
--- a/batman-adv/send.c
+++ b/batman-adv/send.c
@@ -510,6 +510,7 @@ static void send_outstanding_bcast_packet(struct work_struct *work)
 	struct sk_buff *skb1;
 	struct net_device *soft_iface = forw_packet->if_incoming->soft_iface;
 	struct bat_priv *bat_priv = netdev_priv(soft_iface);
+	int num_bcasts = atomic_read(&bat_priv->num_bcasts);
 
 	spin_lock_bh(&bat_priv->forw_bcast_list_lock);
 	hlist_del(&forw_packet->list);
@@ -534,7 +535,7 @@ static void send_outstanding_bcast_packet(struct work_struct *work)
 	forw_packet->num_packets++;
 
 	/* if we still have some more bcasts to send */
-	if (forw_packet->num_packets < 3) {
+	if (forw_packet->num_packets < num_bcasts) {
 		_add_bcast_packet_to_list(bat_priv, forw_packet,
 					  ((5 * HZ) / 1000));
 		return;
diff --git a/batman-adv/types.h b/batman-adv/types.h
index 1af391e..a27b442 100644
--- a/batman-adv/types.h
+++ b/batman-adv/types.h
@@ -146,6 +146,7 @@ struct bat_priv {
 	atomic_t gw_bandwidth;		/* gw bandwidth */
 	atomic_t orig_interval;		/* uint */
 	atomic_t hop_penalty;		/* uint */
+	atomic_t num_bcasts;		/* uint */
 	atomic_t mcast_mode;		/* MCAST_MODE_* */
 	atomic_t mcast_tracker_interval;/* uint, auto */
 	atomic_t mcast_tracker_timeout; /* uint, auto */
-- 
1.7.2.3


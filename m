Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sun, 10 Oct 2010 06:29:59 +0200
Message-Id: <1286685001-15227-3-git-send-email-linus.luessing@web.de>
In-Reply-To: <1286685001-15227-1-git-send-email-linus.luessing@web.de>
References: <1286685001-15227-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 3/5] batman-adv: Make hop_penalty
	configurable via sysfs
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

When having a mixed topology of both very mobile and rather static
nodes, you are usually best advised to set the originator interval on
all nodes to a level best suited for the most mobile node.

However, if most of the nodes are rather static, this can create a lot
of undesired overhead as a trade-off then. If setting the interval too
low on the static nodes, a mobile node might be chosen as a router for
too long, not switching away from it fast enough because of its
mobility and the low frequency of ogms of static nodes.

Exposing the hop_penalty is especially useful for the stated scenario: A
static node can keep the default originator interval, a mobile node can
select a quicker one resulting in faster route updates towards this
mobile node. Additionally, such a mobile node could select a higher hop
penalty (or even set it to 255 to disable acting as a router for other
nodes) to make it less desirable, letting other nodes avoid selecting
this mobile node as a router.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 bat_sysfs.c      |    2 ++
 send.c           |    7 ++++---
 soft-interface.c |    1 +
 types.h          |    1 +
 4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/bat_sysfs.c b/bat_sysfs.c
index 878cb8e..9fda75e 100644
--- a/bat_sysfs.c
+++ b/bat_sysfs.c
@@ -272,6 +272,7 @@ BAT_ATTR_SWITCH(frag, S_IRUGO | S_IWUSR, update_min_mtu);
 static BAT_ATTR(vis_mode, S_IRUGO | S_IWUSR, show_vis_mode, store_vis_mode);
 static BAT_ATTR(gw_mode, S_IRUGO | S_IWUSR, show_gw_mode, store_gw_mode);
 BAT_ATTR_UINT(orig_interval, S_IRUGO | S_IWUSR, 2 * JITTER, INT_MAX, NULL);
+BAT_ATTR_UINT(hop_penalty, S_IRUGO | S_IWUSR, 0, TQ_MAX_VALUE, NULL);
 #ifdef CONFIG_BATMAN_ADV_DEBUG
 BAT_ATTR_UINT(log_level, S_IRUGO | S_IWUSR, 0, 3, NULL);
 #endif
@@ -283,6 +284,7 @@ static struct bat_attribute *mesh_attrs[] = {
 	&bat_attr_vis_mode,
 	&bat_attr_gw_mode,
 	&bat_attr_orig_interval,
+	&bat_attr_hop_penalty,
 #ifdef CONFIG_BATMAN_ADV_DEBUG
 	&bat_attr_log_level,
 #endif
diff --git a/send.c b/send.c
index 180e18b..943437b 100644
--- a/send.c
+++ b/send.c
@@ -35,9 +35,10 @@
 static void send_outstanding_bcast_packet(struct work_struct *work);
 
 /* apply hop penalty for a normal link */
-static uint8_t hop_penalty(const uint8_t tq)
+static uint8_t hop_penalty(const uint8_t tq, struct bat_priv *bat_priv)
 {
-	return (tq * (TQ_MAX_VALUE - TQ_HOP_PENALTY)) / (TQ_MAX_VALUE);
+	int hop_penalty = atomic_read(&bat_priv->hop_penalty);
+	return (tq * (TQ_MAX_VALUE - hop_penalty)) / (TQ_MAX_VALUE);
 }
 
 /* when do we schedule our own packet to be sent */
@@ -339,7 +340,7 @@ void schedule_forward_packet(struct orig_node *orig_node,
 	}
 
 	/* apply hop penalty */
-	batman_packet->tq = hop_penalty(batman_packet->tq);
+	batman_packet->tq = hop_penalty(batman_packet->tq, bat_priv);
 
 	bat_dbg(DBG_BATMAN, bat_priv,
 		"Forwarding packet: tq_orig: %i, tq_avg: %i, "
diff --git a/soft-interface.c b/soft-interface.c
index 22fe548..d42cd02 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -592,6 +592,7 @@ struct net_device *softif_create(char *name)
 	atomic_set(&bat_priv->gw_mode, GW_MODE_OFF);
 	atomic_set(&bat_priv->gw_class, 0);
 	atomic_set(&bat_priv->orig_interval, 1000);
+	atomic_set(&bat_priv->hop_penalty, 30);
 	atomic_set(&bat_priv->log_level, 0);
 	atomic_set(&bat_priv->frag_enabled, 1);
 	atomic_set(&bat_priv->bcast_queue_left, BCAST_QUEUE_LEN);
diff --git a/types.h b/types.h
index dec2791..75e0b71 100644
--- a/types.h
+++ b/types.h
@@ -131,6 +131,7 @@ struct bat_priv {
 	atomic_t gw_mode;
 	atomic_t gw_class;
 	atomic_t orig_interval;
+	atomic_t hop_penalty;
 	atomic_t log_level;
 	atomic_t bcast_seqno;
 	atomic_t bcast_queue_left;
-- 
1.7.1


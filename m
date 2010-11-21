Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 22 Nov 2010 00:55:55 +0100
Message-Id: <1290383767-32602-18-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
References: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 17/29] Staging: batman-adv: Make hop_penalty
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
To: greg@kroah.com
Cc: b.a.t.m.a.n@lists.open-mesh.org, =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>

From: Linus Lüssing <linus.luessing@ascom.ch>

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

Signed-off-by: Linus Lüssing <linus.luessing@ascom.ch>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/bat_sysfs.c          |    2 ++
 drivers/staging/batman-adv/main.h               |    2 --
 drivers/staging/batman-adv/send.c               |    7 ++++---
 drivers/staging/batman-adv/soft-interface.c     |    1 +
 drivers/staging/batman-adv/sysfs-class-net-mesh |    7 +++++++
 drivers/staging/batman-adv/types.h              |    1 +
 6 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/batman-adv/bat_sysfs.c b/drivers/staging/batman-adv/bat_sysfs.c
index 9bec60d..5ff6e5e 100644
--- a/drivers/staging/batman-adv/bat_sysfs.c
+++ b/drivers/staging/batman-adv/bat_sysfs.c
@@ -254,6 +254,7 @@ BAT_ATTR_BOOL(bonding, S_IRUGO | S_IWUSR, NULL);
 BAT_ATTR_BOOL(fragmentation, S_IRUGO | S_IWUSR, update_min_mtu);
 static BAT_ATTR(vis_mode, S_IRUGO | S_IWUSR, show_vis_mode, store_vis_mode);
 BAT_ATTR_UINT(orig_interval, S_IRUGO | S_IWUSR, 2 * JITTER, INT_MAX, NULL);
+BAT_ATTR_UINT(hop_penalty, S_IRUGO | S_IWUSR, 0, TQ_MAX_VALUE, NULL);
 #ifdef CONFIG_BATMAN_ADV_DEBUG
 BAT_ATTR_UINT(log_level, S_IRUGO | S_IWUSR, 0, 3, NULL);
 #endif
@@ -264,6 +265,7 @@ static struct bat_attribute *mesh_attrs[] = {
 	&bat_attr_fragmentation,
 	&bat_attr_vis_mode,
 	&bat_attr_orig_interval,
+	&bat_attr_hop_penalty,
 #ifdef CONFIG_BATMAN_ADV_DEBUG
 	&bat_attr_log_level,
 #endif
diff --git a/drivers/staging/batman-adv/main.h b/drivers/staging/batman-adv/main.h
index ec35ef8..d8d50f3 100644
--- a/drivers/staging/batman-adv/main.h
+++ b/drivers/staging/batman-adv/main.h
@@ -52,8 +52,6 @@
 #define TQ_LOCAL_BIDRECT_RECV_MINIMUM 1
 #define TQ_TOTAL_BIDRECT_LIMIT 1
 
-#define TQ_HOP_PENALTY 10
-
 #define NUM_WORDS (TQ_LOCAL_WINDOW_SIZE / WORD_BIT_SIZE)
 
 #define PACKBUFF_SIZE 2000
diff --git a/drivers/staging/batman-adv/send.c b/drivers/staging/batman-adv/send.c
index 7adf76d..1489b6c 100644
--- a/drivers/staging/batman-adv/send.c
+++ b/drivers/staging/batman-adv/send.c
@@ -33,9 +33,10 @@
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
@@ -330,7 +331,7 @@ void schedule_forward_packet(struct orig_node *orig_node,
 	}
 
 	/* apply hop penalty */
-	batman_packet->tq = hop_penalty(batman_packet->tq);
+	batman_packet->tq = hop_penalty(batman_packet->tq, bat_priv);
 
 	bat_dbg(DBG_BATMAN, bat_priv,
 		"Forwarding packet: tq_orig: %i, tq_avg: %i, "
diff --git a/drivers/staging/batman-adv/soft-interface.c b/drivers/staging/batman-adv/soft-interface.c
index c903a76..1cf9aa2 100644
--- a/drivers/staging/batman-adv/soft-interface.c
+++ b/drivers/staging/batman-adv/soft-interface.c
@@ -582,6 +582,7 @@ struct net_device *softif_create(char *name)
 	atomic_set(&bat_priv->bonding, 0);
 	atomic_set(&bat_priv->vis_mode, VIS_TYPE_CLIENT_UPDATE);
 	atomic_set(&bat_priv->orig_interval, 1000);
+	atomic_set(&bat_priv->hop_penalty, 10);
 	atomic_set(&bat_priv->log_level, 0);
 	atomic_set(&bat_priv->fragmentation, 1);
 	atomic_set(&bat_priv->bcast_queue_left, BCAST_QUEUE_LEN);
diff --git a/drivers/staging/batman-adv/sysfs-class-net-mesh b/drivers/staging/batman-adv/sysfs-class-net-mesh
index b4cdb60..bd20e14 100644
--- a/drivers/staging/batman-adv/sysfs-class-net-mesh
+++ b/drivers/staging/batman-adv/sysfs-class-net-mesh
@@ -29,6 +29,13 @@ Description:
                 Defines the interval in milliseconds in which batman
                 sends its protocol messages.
 
+What:           /sys/class/net/<mesh_iface>/mesh/hop_penalty
+Date:           Oct 2010
+Contact:        Linus Lüssing <linus.luessing@web.de>
+Description:
+		Defines the penalty which will be applied to an
+		originator message's tq-field on every hop.
+
 What:           /sys/class/net/<mesh_iface>/mesh/vis_mode
 Date:           May 2010
 Contact:        Marek Lindner <lindner_marek@yahoo.de>
diff --git a/drivers/staging/batman-adv/types.h b/drivers/staging/batman-adv/types.h
index 4463da3..e41f95f 100644
--- a/drivers/staging/batman-adv/types.h
+++ b/drivers/staging/batman-adv/types.h
@@ -118,6 +118,7 @@ struct bat_priv {
 	atomic_t fragmentation;		/* boolean */
 	atomic_t vis_mode;		/* VIS_TYPE_* */
 	atomic_t orig_interval;		/* uint */
+	atomic_t hop_penalty;		/* uint */
 	atomic_t log_level;		/* uint */
 	atomic_t bcast_seqno;
 	atomic_t bcast_queue_left;
-- 
1.7.2.3


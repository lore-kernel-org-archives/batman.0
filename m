Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Fri,  8 Mar 2013 18:38:55 +0100
Message-Id: <1362764336-1591-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Make number of
	(re)broadcasts configurable via sysfs
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
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
 send.c               |    4 +++-
 soft-interface.c     |    1 +
 sysfs-class-net-mesh |    8 ++++++++
 sysfs.c              |    2 ++
 types.h              |    1 +
 5 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/send.c b/send.c
index 0a0bb45..4a73c37 100644
--- a/send.c
+++ b/send.c
@@ -237,12 +237,14 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 	struct sk_buff *skb1;
 	struct net_device *soft_iface;
 	struct batadv_priv *bat_priv;
+	int num_bcasts;
 
 	delayed_work = container_of(work, struct delayed_work, work);
 	forw_packet = container_of(delayed_work, struct batadv_forw_packet,
 				   delayed_work);
 	soft_iface = forw_packet->if_incoming->soft_iface;
 	bat_priv = netdev_priv(soft_iface);
+	num_bcasts = atomic_read(&bat_priv->num_bcasts);
 
 	spin_lock_bh(&bat_priv->forw_bcast_list_lock);
 	hlist_del(&forw_packet->list);
@@ -271,7 +273,7 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 	forw_packet->num_packets++;
 
 	/* if we still have some more bcasts to send */
-	if (forw_packet->num_packets < 3) {
+	if (forw_packet->num_packets < num_bcasts) {
 		_batadv_add_bcast_packet_to_list(bat_priv, forw_packet,
 						 msecs_to_jiffies(5));
 		return;
diff --git a/soft-interface.c b/soft-interface.c
index 403b8c4..53771a4 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -464,6 +464,7 @@ static int batadv_softif_init_late(struct net_device *dev)
 	atomic_set(&bat_priv->gw_bandwidth, 41);
 	atomic_set(&bat_priv->orig_interval, 1000);
 	atomic_set(&bat_priv->hop_penalty, 30);
+	atomic_set(&bat_priv->num_bcasts, 3);
 #ifdef CONFIG_BATMAN_ADV_DEBUG
 	atomic_set(&bat_priv->log_level, 0);
 #endif
diff --git a/sysfs-class-net-mesh b/sysfs-class-net-mesh
index bdcd8b4..2058cad 100644
--- a/sysfs-class-net-mesh
+++ b/sysfs-class-net-mesh
@@ -75,6 +75,14 @@ Description:
                 to send fewer wifi packets but still the same
                 content) is enabled or not.
 
+What:           /sys/class/net/<mesh_iface>/mesh/num_bcasts
+Date:           Mar 2013
+Contact:        Linus Lüssing <linus.luessing@web.de>
+Description:
+		Defines the number of broadcasts used to forward
+		a multicast (including broadcast) payload frame on an
+		interface.
+
 What:           /sys/class/net/<mesh_iface>/mesh/orig_interval
 Date:           May 2010
 Contact:        Marek Lindner <lindner_marek@yahoo.de>
diff --git a/sysfs.c b/sysfs.c
index 15a22ef..d166b87 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -435,6 +435,7 @@ BATADV_ATTR_SIF_UINT(orig_interval, S_IRUGO | S_IWUSR, 2 * BATADV_JITTER,
 		     INT_MAX, NULL);
 BATADV_ATTR_SIF_UINT(hop_penalty, S_IRUGO | S_IWUSR, 0, BATADV_TQ_MAX_VALUE,
 		     NULL);
+BATADV_ATTR_SIF_UINT(num_bcasts, S_IRUGO | S_IWUSR, 1, INT_MAX, NULL);
 BATADV_ATTR_SIF_UINT(gw_sel_class, S_IRUGO | S_IWUSR, 1, BATADV_TQ_MAX_VALUE,
 		     batadv_post_gw_deselect);
 static BATADV_ATTR(gw_bandwidth, S_IRUGO | S_IWUSR, batadv_show_gw_bwidth,
@@ -462,6 +463,7 @@ static struct batadv_attribute *batadv_mesh_attrs[] = {
 	&batadv_attr_gw_mode,
 	&batadv_attr_orig_interval,
 	&batadv_attr_hop_penalty,
+	&batadv_attr_num_bcasts,
 	&batadv_attr_gw_sel_class,
 	&batadv_attr_gw_bandwidth,
 #ifdef CONFIG_BATMAN_ADV_DEBUG
diff --git a/types.h b/types.h
index aba8364..41bfa0b 100644
--- a/types.h
+++ b/types.h
@@ -555,6 +555,7 @@ struct batadv_priv {
 	atomic_t gw_bandwidth;
 	atomic_t orig_interval;
 	atomic_t hop_penalty;
+	atomic_t num_bcasts;
 #ifdef CONFIG_BATMAN_ADV_DEBUG
 	atomic_t log_level;
 #endif
-- 
1.7.10.4


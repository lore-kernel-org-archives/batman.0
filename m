Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 18 May 2018 09:47:54 +0800
Message-Id: <20180518014754.23644-8-mareklindner@neomailbox.ch>
In-Reply-To: <20180518014754.23644-1-mareklindner@neomailbox.ch>
References: <20180518014754.23644-1-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [PATCH v2 7/7] batman-adv: ELP - add throughput
 meter test duration attribute
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

When the ELP throughput meter fallback kicks in to trigger
a throughput meter measurement the test duration can be
configured via this attribute.

Default tp test duration: 1000ms

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 Documentation/ABI/testing/sysfs-class-net-batman-adv | 7 +++++++
 net/batman-adv/bat_v.c                               | 1 +
 net/batman-adv/bat_v_elp.c                           | 5 ++++-
 net/batman-adv/sysfs.c                               | 3 +++
 net/batman-adv/types.h                               | 3 +++
 5 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-net-batman-adv b/Documentation/ABI/testing/sysfs-class-net-batman-adv
index 89810684..7b3974a5 100644
--- a/Documentation/ABI/testing/sysfs-class-net-batman-adv
+++ b/Documentation/ABI/testing/sysfs-class-net-batman-adv
@@ -6,6 +6,13 @@ Description:
                 Defines the interval in milliseconds in which batman
                 emits probing packets for neighbor sensing (ELP).
 
+What:           /sys/class/net/<iface>/batman-adv/elp_tp_duration
+Date:           May 2018
+Contact:        Marek Lindner <mareklindner@neomailbox.ch>
+Description:
+                Defines measurement duration in milliseconds upon
+                ELP fallback throughput meter measurements.
+
 What:           /sys/class/net/<iface>/batman-adv/iface_status
 Date:           May 2010
 Contact:        Marek Lindner <mareklindner@neomailbox.ch>
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index ec93337e..be068516 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -1084,6 +1084,7 @@ void batadv_v_hardif_init(struct batadv_hard_iface *hard_iface)
 	 */
 	atomic_set(&hard_iface->bat_v.throughput_override, 0);
 	atomic_set(&hard_iface->bat_v.elp_interval, 500);
+	atomic_set(&hard_iface->bat_v.elp_tp_duration, 1000);
 }
 
 /**
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 3f0d7816..818a9a6a 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -76,9 +76,12 @@ static void batadv_v_elp_tp_start(struct batadv_hardif_neigh_node *neigh)
 {
 	struct batadv_hard_iface *hard_iface = neigh->if_incoming;
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
+	u32 elp_tp_duration;
 
 	neigh->bat_v.tp_meter_running = true;
-	batadv_tp_start(bat_priv, neigh->addr, neigh, 10, NULL, BATADV_TP_ELP);
+	elp_tp_duration = atomic_read(&hard_iface->bat_v.elp_tp_duration);
+	batadv_tp_start(bat_priv, neigh->addr, neigh, elp_tp_duration,
+			NULL, BATADV_TP_ELP);
 }
 
 /**
diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index f2eef43b..d8d08bfa 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -1128,6 +1128,8 @@ static BATADV_ATTR(iface_status, 0444, batadv_show_iface_status, NULL);
 #ifdef CONFIG_BATMAN_ADV_BATMAN_V
 BATADV_ATTR_HIF_UINT(elp_interval, bat_v.elp_interval, 0644,
 		     2 * BATADV_JITTER, INT_MAX, NULL);
+BATADV_ATTR_HIF_UINT(elp_tp_duration, bat_v.elp_tp_duration, 0644,
+		     1, INT_MAX, NULL);
 static BATADV_ATTR(throughput_override, 0644, batadv_show_throughput_override,
 		   batadv_store_throughput_override);
 #endif
@@ -1137,6 +1139,7 @@ static struct batadv_attribute *batadv_batman_attrs[] = {
 	&batadv_attr_iface_status,
 #ifdef CONFIG_BATMAN_ADV_BATMAN_V
 	&batadv_attr_elp_interval,
+	&batadv_attr_elp_tp_duration,
 	&batadv_attr_throughput_override,
 #endif
 	NULL,
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 148f23ad..8efe295a 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -117,6 +117,9 @@ struct batadv_hard_iface_bat_v {
 	/** @elp_interval: time interval between two ELP transmissions */
 	atomic_t elp_interval;
 
+	/** @elp_tp_duration: throughput meter fallback test duration */
+	atomic_t elp_tp_duration;
+
 	/** @elp_seqno: current ELP sequence number */
 	atomic_t elp_seqno;
 
-- 
2.17.0


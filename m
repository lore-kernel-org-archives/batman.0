Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 11 Feb 2014 13:48:11 +0100
Message-Id: <1392122903-805-12-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [RFC 11/23] batman-adv: add throughput attribute to
	hard_ifaces
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

This attribute is exported to the user which can manually
select its value. It is the throughput value to be used
by default when batman-adv is trying to compute the link
throughput towards a neighbour using this interface.

If the value is set to 0 then batman-adv will try to detect
the throughput by itself.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 bat_v.c | 3 +++
 sysfs.c | 3 +++
 types.h | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/bat_v.c b/bat_v.c
index b4214c5..d5457b3 100644
--- a/bat_v.c
+++ b/bat_v.c
@@ -34,6 +34,9 @@ static int batadv_v_iface_enable(struct batadv_hard_iface *hard_iface)
 	if (ret < 0)
 		batadv_v_elp_iface_disable(hard_iface);
 
+	/* disable user customised throughput by default */
+	atomic_set(&hard_iface->bat_v.user_throughput, 0);
+
 	return ret;
 }
 
diff --git a/sysfs.c b/sysfs.c
index 9139319..8bbbdfa 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -889,6 +889,8 @@ static BATADV_ATTR(iface_status, S_IRUGO, batadv_show_iface_status, NULL);
 #ifdef CONFIG_BATMAN_ADV_BATMAN_V
 BATADV_ATTR_HIF_UINT(elp_interval, bat_v.elp_interval, S_IRUGO | S_IWUSR,
 		     2 * BATADV_JITTER, INT_MAX, NULL);
+BATADV_ATTR_HIF_UINT(throughput, bat_v.user_throughput, S_IRUGO | S_IWUSR,
+		     0, UINT_MAX, NULL);
 #endif
 
 static struct batadv_attribute *batadv_batman_attrs[] = {
@@ -896,6 +898,7 @@ static struct batadv_attribute *batadv_batman_attrs[] = {
 	&batadv_attr_iface_status,
 #ifdef CONFIG_BATMAN_ADV_BATMAN_V
 	&batadv_attr_elp_interval,
+	&batadv_attr_throughput,
 #endif
 	NULL,
 };
diff --git a/types.h b/types.h
index 28f2b85..64316b9 100644
--- a/types.h
+++ b/types.h
@@ -78,6 +78,7 @@ struct batadv_hard_iface_bat_iv {
  * @num_neighbours: number of neighbours in the neigh_list
  * @elp_skb: base skb containing the ELP message to send
  * @elp_wq: workqueue used to schedule ELP transmissions
+ * @user_throughput: user specified throughput
  */
 struct batadv_hard_iface_bat_v {
 	atomic_t elp_interval;
@@ -87,6 +88,7 @@ struct batadv_hard_iface_bat_v {
 	atomic_t num_neighbors;
 	struct sk_buff *elp_skb;
 	struct delayed_work elp_wq;
+	atomic_t user_throughput;
 };
 
 /**
-- 
1.8.5.3


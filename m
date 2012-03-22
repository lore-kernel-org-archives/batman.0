Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 22 Mar 2012 22:51:15 +0100
Message-Id: <1332453075-27999-5-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1332453075-27999-1-git-send-email-lindner_marek@yahoo.de>
References: <201203222250.31309.lindner_marek@yahoo.de>
	<1332453075-27999-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] =?utf-8?q?=5BRFC_5/5=5D_batman-adv=3A_ELP_-_add_co?=
	=?utf-8?q?nfigurable_minimum_ELP_packet_length_=28def=3A_300B=29?=
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

From: Linus Luessing <linus.luessing@web.de>

With the current setting of no minimum ELP packet length, BATMAN very
often choses too short paths. These paths are often only usable for small
packets, but not for e.g. larger TCP downloads.

Therefore this commit introduces a minimum ELP packet length. If the ELP
packet size is smaller than the specified minimum size the packet will be
padded with zeroes up to this specified size.

Developed by Linus during a 6 months trainee study period in Ascom
(Switzerland) AG.

Signed-off-by: Linus Luessing <linus.luessing@web.de>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 bat_sysfs.c                |    2 ++
 bat_v_elp.c                |    9 ++++++++-
 hard-interface.c           |    1 +
 sysfs-class-net-batman-adv |    8 +++++++-
 types.h                    |    1 +
 5 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/bat_sysfs.c b/bat_sysfs.c
index 6195a66..69df249 100644
--- a/bat_sysfs.c
+++ b/bat_sysfs.c
@@ -632,6 +632,7 @@ static BAT_ATTR(mesh_iface, S_IRUGO | S_IWUSR,
 static BAT_ATTR(iface_status, S_IRUGO, show_iface_status, NULL);
 #ifdef CONFIG_BATMAN_ADV_BATMAN_V
 BAT_ATTR_HIF_UINT(elp_interval, S_IRUGO | S_IWUSR, 2 * JITTER, INT_MAX, NULL);
+BAT_ATTR_HIF_UINT(elp_min_len, S_IRUGO | S_IWUSR, 0, ETH_DATA_LEN, NULL);
 #endif
 
 static struct bat_attribute *batman_attrs[] = {
@@ -639,6 +640,7 @@ static struct bat_attribute *batman_attrs[] = {
 	&bat_attr_iface_status,
 #ifdef CONFIG_BATMAN_ADV_BATMAN_V
 	&bat_attr_elp_interval,
+	&bat_attr_elp_min_len,
 #endif
 	NULL,
 };
diff --git a/bat_v_elp.c b/bat_v_elp.c
index 9232f28..1bde84e 100644
--- a/bat_v_elp.c
+++ b/bat_v_elp.c
@@ -108,7 +108,7 @@ static void bat_v_elp_send_outstanding(struct work_struct *work)
 	struct neigh_node *neigh_node;
 	struct hlist_node *node;
 	struct sk_buff *skb;
-	unsigned int max_len;
+	unsigned int max_len, min_len;
 
 	hard_iface = container_of(work, struct hard_iface, elp_wq.work);
 	bat_priv = netdev_priv(hard_iface->soft_iface);
@@ -126,6 +126,8 @@ static void bat_v_elp_send_outstanding(struct work_struct *work)
 		goto restart_timer;
 
 	max_len = min_t(unsigned int, ETH_DATA_LEN, hard_iface->net_dev->mtu);
+	min_len = min_t(unsigned int, atomic_read(&hard_iface->elp_min_len),
+			max_len);
 
 	skb = skb_copy(hard_iface->elp_skb, GFP_ATOMIC);
 	if (!skb)
@@ -159,6 +161,11 @@ static void bat_v_elp_send_outstanding(struct work_struct *work)
 	}
 	rcu_read_unlock();
 
+	if (skb->len < min_len) {
+		memset(elp_neigh_entry, 0, min_len - skb->len);
+		skb_put(skb, min_len - skb->len);
+	}
+
 	bat_dbg(DBG_BATMAN, bat_priv,
 		"Sending elp packet on interface %s, seqno %d\n",
 		hard_iface->net_dev->name, atomic_read(&hard_iface->elp_seqno));
diff --git a/hard-interface.c b/hard-interface.c
index e53e143..68cd564 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -452,6 +452,7 @@ static struct hard_iface *hardif_add_interface(struct net_device *net_dev)
 
 #ifdef CONFIG_BATMAN_ADV_BATMAN_V
 	atomic_set(&hard_iface->elp_interval, 500);
+	atomic_set(&hard_iface->elp_min_len, 300);
 	atomic_set(&hard_iface->elp_seqno, 1);
 	hard_iface->elp_skb = NULL;
 #endif /* CONFIG_BATMAN_ADV_BATMAN_V */
diff --git a/sysfs-class-net-batman-adv b/sysfs-class-net-batman-adv
index 954ab1f..ddaa273 100644
--- a/sysfs-class-net-batman-adv
+++ b/sysfs-class-net-batman-adv
@@ -18,4 +18,10 @@ Date:           Mar 2012
 Contact:        Linus Lüssing <linus.luessing@web.de>
 Description:
                 Defines the interval in milliseconds in which batman
-                sends its probing packets for link quality measurements.
\ No newline at end of file
+                sends its probing packets for link quality measurements.
+
+What:           /sys/class/net/<mesh_iface>/batman-adv/elp_min_len
+Date:           Mar 2012
+Contact:        Linus Lüssing <linus.luessing@web.de>
+Description:
+                Defines the minimum ELP packet size.
diff --git a/types.h b/types.h
index abe27dd..f4164ea 100644
--- a/types.h
+++ b/types.h
@@ -60,6 +60,7 @@ struct hard_iface {
 	struct rcu_head rcu;
 #ifdef CONFIG_BATMAN_ADV_BATMAN_V
 	atomic_t elp_interval;
+	atomic_t elp_min_len;
 	atomic_t elp_seqno;
 	struct hlist_head neigh_list;
 	spinlock_t neigh_list_lock;
-- 
1.7.9.1


Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 1/2] batman-adv: Avoid free/alloc race when handling OGM2
 buffer
Date: Fri, 25 Oct 2019 11:22:15 +0200
Message-Id: <20191025092216.12791-2-sw@simonwunderlich.de>
In-Reply-To: <20191025092216.12791-1-sw@simonwunderlich.de>
References: <20191025092216.12791-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

A B.A.T.M.A.N. V virtual interface has an OGM2 packet buffer which is
initialized using data from the netdevice notifier and other rtnetlink
related hooks. It is sent regularly via various slave interfaces of the
batadv virtual interface and in this process also modified (realloced) to
integrate additional state information via TVLV containers.

It must be avoided that the worker item is executed without a common lock
with the netdevice notifier/rtnetlink helpers. Otherwise it can either
happen that half modified data is sent out or the functions modifying the
OGM2 buffer try to access already freed memory regions.

Fixes: 0da0035942d4 ("batman-adv: OGMv2 - add basic infrastructure")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_v_ogm.c | 41 ++++++++++++++++++++++++++++++--------
 net/batman-adv/types.h     |  4 ++++
 2 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index dc4f7430cb5a..8033f24f506c 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -18,6 +18,7 @@
 #include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/lockdep.h>
+#include <linux/mutex.h>
 #include <linux/netdevice.h>
 #include <linux/random.h>
 #include <linux/rculist.h>
@@ -256,14 +257,12 @@ static void batadv_v_ogm_queue_on_if(struct sk_buff *skb,
 }
 
 /**
- * batadv_v_ogm_send() - periodic worker broadcasting the own OGM
- * @work: work queue item
+ * batadv_v_ogm_send_softif() - periodic worker broadcasting the own OGM
+ * @bat_priv: the bat priv with all the soft interface information
  */
-static void batadv_v_ogm_send(struct work_struct *work)
+static void batadv_v_ogm_send_softif(struct batadv_priv *bat_priv)
 {
 	struct batadv_hard_iface *hard_iface;
-	struct batadv_priv_bat_v *bat_v;
-	struct batadv_priv *bat_priv;
 	struct batadv_ogm2_packet *ogm_packet;
 	struct sk_buff *skb, *skb_tmp;
 	unsigned char *ogm_buff;
@@ -271,8 +270,7 @@ static void batadv_v_ogm_send(struct work_struct *work)
 	u16 tvlv_len = 0;
 	int ret;
 
-	bat_v = container_of(work, struct batadv_priv_bat_v, ogm_wq.work);
-	bat_priv = container_of(bat_v, struct batadv_priv, bat_v);
+	lockdep_assert_held(&bat_priv->bat_v.ogm_buff_mutex);
 
 	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING)
 		goto out;
@@ -363,6 +361,23 @@ static void batadv_v_ogm_send(struct work_struct *work)
 	return;
 }
 
+/**
+ * batadv_v_ogm_send() - periodic worker broadcasting the own OGM
+ * @work: work queue item
+ */
+static void batadv_v_ogm_send(struct work_struct *work)
+{
+	struct batadv_priv_bat_v *bat_v;
+	struct batadv_priv *bat_priv;
+
+	bat_v = container_of(work, struct batadv_priv_bat_v, ogm_wq.work);
+	bat_priv = container_of(bat_v, struct batadv_priv, bat_v);
+
+	mutex_lock(&bat_priv->bat_v.ogm_buff_mutex);
+	batadv_v_ogm_send_softif(bat_priv);
+	mutex_unlock(&bat_priv->bat_v.ogm_buff_mutex);
+}
+
 /**
  * batadv_v_ogm_aggr_work() - OGM queue periodic task per interface
  * @work: work queue item
@@ -424,11 +439,15 @@ void batadv_v_ogm_primary_iface_set(struct batadv_hard_iface *primary_iface)
 	struct batadv_priv *bat_priv = netdev_priv(primary_iface->soft_iface);
 	struct batadv_ogm2_packet *ogm_packet;
 
+	mutex_lock(&bat_priv->bat_v.ogm_buff_mutex);
 	if (!bat_priv->bat_v.ogm_buff)
-		return;
+		goto unlock;
 
 	ogm_packet = (struct batadv_ogm2_packet *)bat_priv->bat_v.ogm_buff;
 	ether_addr_copy(ogm_packet->orig, primary_iface->net_dev->dev_addr);
+
+unlock:
+	mutex_unlock(&bat_priv->bat_v.ogm_buff_mutex);
 }
 
 /**
@@ -1050,6 +1069,8 @@ int batadv_v_ogm_init(struct batadv_priv *bat_priv)
 	atomic_set(&bat_priv->bat_v.ogm_seqno, random_seqno);
 	INIT_DELAYED_WORK(&bat_priv->bat_v.ogm_wq, batadv_v_ogm_send);
 
+	mutex_init(&bat_priv->bat_v.ogm_buff_mutex);
+
 	return 0;
 }
 
@@ -1061,7 +1082,11 @@ void batadv_v_ogm_free(struct batadv_priv *bat_priv)
 {
 	cancel_delayed_work_sync(&bat_priv->bat_v.ogm_wq);
 
+	mutex_lock(&bat_priv->bat_v.ogm_buff_mutex);
+
 	kfree(bat_priv->bat_v.ogm_buff);
 	bat_priv->bat_v.ogm_buff = NULL;
 	bat_priv->bat_v.ogm_buff_len = 0;
+
+	mutex_unlock(&bat_priv->bat_v.ogm_buff_mutex);
 }
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index be7c02aa91e2..a9fb7b17f557 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -17,6 +17,7 @@
 #include <linux/if.h>
 #include <linux/if_ether.h>
 #include <linux/kref.h>
+#include <linux/mutex.h>
 #include <linux/netdevice.h>
 #include <linux/netlink.h>
 #include <linux/sched.h> /* for linux/wait.h */
@@ -1539,6 +1540,9 @@ struct batadv_priv_bat_v {
 	/** @ogm_seqno: OGM sequence number - used to identify each OGM */
 	atomic_t ogm_seqno;
 
+	/** @ogm_buff_mutex: lock protecting ogm_buff and ogm_buff_len */
+	struct mutex ogm_buff_mutex;
+
 	/** @ogm_wq: workqueue used to schedule OGM transmissions */
 	struct delayed_work ogm_wq;
 };
-- 
2.20.1


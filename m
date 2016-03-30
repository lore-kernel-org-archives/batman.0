Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 30 Mar 2016 14:19:31 +0200
Message-Id: <1459340372-6971-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [RFC 1/2] batman-adv: Split the setting for number
	re-broadcasts
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

The number of rebroadcasts are currently not differenciated between
re-broadcasts on the same interface and the re-broadcasts on a different
interface. This differenciation can be important when the link medium
already guarantees to some extend that a packet received by one participant
is also received by all other participants.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/hard-interface.c | 10 +++++++---
 net/batman-adv/main.h           |  3 ++-
 net/batman-adv/send.c           |  8 +++++++-
 net/batman-adv/types.h          |  8 ++++++--
 4 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index f41b472..a8385fa 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -678,9 +678,13 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 
 	spin_lock_init(&hard_iface->neigh_list_lock);
 
-	hard_iface->num_bcasts = BATADV_NUM_BCASTS_DEFAULT;
-	if (batadv_is_wifi_netdev(net_dev))
-		hard_iface->num_bcasts = BATADV_NUM_BCASTS_WIRELESS;
+	if (batadv_is_wifi_netdev(net_dev)) {
+		hard_iface->num_bcasts_sameif = BATADV_NUM_BCASTS_WIRELESS;
+		hard_iface->num_bcasts_otherif = BATADV_NUM_BCASTS_WIRELESS;
+	} else {
+		hard_iface->num_bcasts_sameif = BATADV_NUM_BCASTS_SAMEIF;
+		hard_iface->num_bcasts_otherif = BATADV_NUM_BCASTS_OTHERIF;
+	}
 
 	/* extra reference for return */
 	kref_init(&hard_iface->refcount);
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 1565df0..aad4a3a 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -96,7 +96,8 @@
 #define BATADV_LOG_BUF_LEN 8192	  /* has to be a power of 2 */
 
 /* number of packets to send for broadcasts on different interface types */
-#define BATADV_NUM_BCASTS_DEFAULT 1
+#define BATADV_NUM_BCASTS_SAMEIF 1
+#define BATADV_NUM_BCASTS_OTHERIF 1
 #define BATADV_NUM_BCASTS_WIRELESS 3
 #define BATADV_NUM_BCASTS_MAX 3
 
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 2e8433b..724bd6e 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -552,6 +552,7 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 	struct sk_buff *skb1;
 	struct net_device *soft_iface;
 	struct batadv_priv *bat_priv;
+	u8 num_bcasts;
 
 	delayed_work = to_delayed_work(work);
 	forw_packet = container_of(delayed_work, struct batadv_forw_packet,
@@ -575,7 +576,12 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 		if (hard_iface->soft_iface != soft_iface)
 			continue;
 
-		if (forw_packet->num_packets >= hard_iface->num_bcasts)
+		if (forw_packet->skb->dev == hard_iface->net_dev)
+			num_bcasts = hard_iface->num_bcasts_sameif;
+		else
+			num_bcasts = hard_iface->num_bcasts_otherif;
+
+		if (forw_packet->num_packets >= num_bcasts)
 			continue;
 
 		if (!kref_get_unless_zero(&hard_iface->refcount))
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 9abfb3e..5e80113 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -122,7 +122,10 @@ struct batadv_hard_iface_bat_v {
  * @if_num: identificator of the interface
  * @if_status: status of the interface for batman-adv
  * @net_dev: pointer to the net_device
- * @num_bcasts: number of payload re-broadcasts on this interface (ARQ)
+ * @num_bcasts_sameif: number of payload re-broadcasts on this interface (ARQ)
+ *  when the packet was received on this interface
+ * @num_bcasts_otherif: number of payload re-broadcasts on this interface (ARQ)
+ *  when the packet was received on a different interface
  * @hardif_obj: kobject of the per interface sysfs "mesh" directory
  * @refcount: number of contexts the object is used
  * @batman_adv_ptype: packet type describing packets that should be processed by
@@ -141,7 +144,8 @@ struct batadv_hard_iface {
 	s16 if_num;
 	char if_status;
 	struct net_device *net_dev;
-	u8 num_bcasts;
+	u8 num_bcasts_sameif;
+	u8 num_bcasts_otherif;
 	struct kobject *hardif_obj;
 	struct kref refcount;
 	struct packet_type batman_adv_ptype;
-- 
2.8.0.rc3


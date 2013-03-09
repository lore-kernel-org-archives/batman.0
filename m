Return-Path: <mschiffer@universe-factory.net>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Date: Sat,  9 Mar 2013 11:33:52 +0100
Message-Id: <cbb43bcdb70a791087a6d9284732ff94963ce51b.1362825185.git.mschiffer@universe-factory.net>
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: send each broadcast only once
	on non-wireless interfaces
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

While it makes sense to send each broadcast thrice on 802.11 (WLAN) interfaces
as broadcasts are often unreliable on there, there is no reason to do so on
other interface types.

The increased the overhead can be harmful on low-bandwidth links like VPN
connections over slow internet lines, therefore it is better to reduce the
number of broadcast packets sent on non-wireless links to one.

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
---
 hard-interface.c | 11 +++++++++++
 main.h           |  5 +++++
 send.c           |  5 ++++-
 types.h          |  1 +
 4 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/hard-interface.c b/hard-interface.c
index fd99e42..3f3ff9f 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -515,6 +515,17 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 	INIT_WORK(&hard_iface->cleanup_work,
 		  batadv_hardif_remove_interface_finish);
 
+	hard_iface->num_bcasts = BATADV_NUM_BCASTS_DEFAULT;
+
+#if IS_ENABLED(CONFIG_WIRELESS_EXT) || IS_ENABLED(CONFIG_CFG80211)
+	if (net_dev->ieee80211_ptr)
+		hard_iface->num_bcasts = BATADV_NUM_BCASTS_WIRELESS;
+#if IS_ENABLED(CONFIG_WIRELESS_EXT)
+	else if (net_dev->wireless_handlers)
+		hard_iface->num_bcasts = BATADV_NUM_BCASTS_WIRELESS;
+#endif
+#endif
+
 	/* extra reference for return */
 	atomic_set(&hard_iface->refcount, 2);
 
diff --git a/main.h b/main.h
index e6eaf43..2c751c6 100644
--- a/main.h
+++ b/main.h
@@ -76,6 +76,11 @@
 
 #define BATADV_LOG_BUF_LEN 8192	  /* has to be a power of 2 */
 
+/* number of packets to send for broadcasts on different interface types */
+#define BATADV_NUM_BCASTS_DEFAULT 1
+#define BATADV_NUM_BCASTS_WIRELESS 3
+#define BATADV_NUM_BCASTS_MAX 3
+
 /* msecs after which an ARP_REQUEST is sent in broadcast as fallback */
 #define ARP_REQ_DELAY 250
 /* numbers of originator to contact for any PUT/GET DHT operation */
diff --git a/send.c b/send.c
index 0a0bb45..e21138f 100644
--- a/send.c
+++ b/send.c
@@ -260,6 +260,9 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 		if (hard_iface->soft_iface != soft_iface)
 			continue;
 
+		if (forw_packet->num_packets >= hard_iface->num_bcasts)
+			continue;
+
 		/* send a copy of the saved skb */
 		skb1 = skb_clone(forw_packet->skb, GFP_ATOMIC);
 		if (skb1)
@@ -271,7 +274,7 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 	forw_packet->num_packets++;
 
 	/* if we still have some more bcasts to send */
-	if (forw_packet->num_packets < 3) {
+	if (forw_packet->num_packets < BATADV_NUM_BCASTS_MAX) {
 		_batadv_add_bcast_packet_to_list(bat_priv, forw_packet,
 						 msecs_to_jiffies(5));
 		return;
diff --git a/types.h b/types.h
index aba8364..0c5009f 100644
--- a/types.h
+++ b/types.h
@@ -76,6 +76,7 @@ struct batadv_hard_iface {
 	char if_status;
 	struct net_device *net_dev;
 	atomic_t frag_seqno;
+	uint8_t num_bcasts;
 	struct kobject *hardif_obj;
 	atomic_t refcount;
 	struct packet_type batman_adv_ptype;
-- 
1.8.1.5


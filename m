Return-Path: <mschiffer@universe-factory.net>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Date: Sat,  9 Mar 2013 22:18:22 +0100
Message-Id: <6ef8d3c1fe5fa21893c780a8c0777c4fd322cd07.1362863832.git.mschiffer@universe-factory.net>
In-Reply-To: <b6b8ee26c56ef0c28d1efe1c54218c4d7090bd98.1362863832.git.mschiffer@universe-factory.net>
References: <20130309201721.GQ1400@ritirata.org>
 <b6b8ee26c56ef0c28d1efe1c54218c4d7090bd98.1362863832.git.mschiffer@universe-factory.net>
In-Reply-To: <b6b8ee26c56ef0c28d1efe1c54218c4d7090bd98.1362863832.git.mschiffer@universe-factory.net>
References: <b6b8ee26c56ef0c28d1efe1c54218c4d7090bd98.1362863832.git.mschiffer@universe-factory.net>
Subject: [B.A.T.M.A.N.] [PATCHv4 2/2] batman-adv: send each broadcast only
	once on non-wireless interfaces
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
as broadcasts are often unreliable on these, there is no reason to do so on
other interface types.

The increased the overhead can be harmful on low-bandwidth links like VPN
connections over slow internet lines, therefore it is better to reduce the
number of broadcast packets sent on non-wireless links to one.

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
---
 hard-interface.c | 5 +++++
 main.h           | 5 +++++
 send.c           | 5 ++++-
 types.h          | 1 +
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/hard-interface.c b/hard-interface.c
index 333a504..0eaf02c 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -556,6 +556,11 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 	INIT_WORK(&hard_iface->cleanup_work,
 		  batadv_hardif_remove_interface_finish);
 
+	if (batadv_is_wifi_net_device(net_dev))
+		hard_iface->num_bcasts = BATADV_NUM_BCASTS_WIRELESS;
+	else
+		hard_iface->num_bcasts = BATADV_NUM_BCASTS_DEFAULT;
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


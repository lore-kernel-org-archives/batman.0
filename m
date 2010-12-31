Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Fri, 31 Dec 2010 16:46:18 +0100
Message-Id: <1293810385-31761-4-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1293810385-31761-1-git-send-email-linus.luessing@ascom.ch>
References: <1293810385-31761-1-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 03/10] batman-adv: Send neighbor discovery
	packets
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
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>

This patch makes use of the previously introduced periodic tasks per
interface and actually sends neighbor discovery packets on these now.
Note: The TQ values of each neighbor are not being added yet to these NDPs
and also no evaluation of these packets is being done.

Also most of the packet type numbers got changed due to their reordering.

Signed-off-by: Linus Lüssing <linus.luessing@ascom.ch>
---
 hard-interface.c |   12 +++++++++++-
 ndp.c            |   35 ++++++++++++++++++++++++++++++++++-
 packet.h         |   23 +++++++++++++++++------
 types.h          |    1 +
 4 files changed, 63 insertions(+), 8 deletions(-)

diff --git a/hard-interface.c b/hard-interface.c
index aba895f..3dc24f1 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -284,6 +284,7 @@ int hardif_enable_interface(struct batman_if *batman_if, char *iface_name)
 {
 	struct bat_priv *bat_priv;
 	struct ogm_packet *ogm_packet;
+	int ret;
 
 	if (batman_if->if_status != IF_NOT_IN_USE)
 		goto out;
@@ -331,7 +332,9 @@ int hardif_enable_interface(struct batman_if *batman_if, char *iface_name)
 
 	atomic_set(&batman_if->seqno, 1);
 	atomic_set(&batman_if->frag_seqno, 1);
-	ndp_init(batman_if);
+	ret = ndp_init(batman_if);
+	if (ret)
+		goto free;
 
 	bat_info(batman_if->soft_iface, "Adding interface: %s\n",
 		 batman_if->net_dev->name);
@@ -369,7 +372,14 @@ int hardif_enable_interface(struct batman_if *batman_if, char *iface_name)
 
 out:
 	return 0;
+free:
+	dev_remove_pack(&batman_if->batman_adv_ptype);
+	kref_put(&batman_if->refcount, hardif_free_ref);
 
+	bat_priv->num_ifaces--;
+	orig_hash_del_if(batman_if, bat_priv->num_ifaces);
+
+	kfree(batman_if->packet_buff);
 err:
 	return -ENOMEM;
 }
diff --git a/ndp.c b/ndp.c
index 60631b0..3269d67 100644
--- a/ndp.c
+++ b/ndp.c
@@ -49,10 +49,21 @@ static void ndp_send(struct work_struct *work)
 	struct batman_if *batman_if = container_of(work, struct batman_if,
 							ndp_wq.work);
 	struct bat_priv *bat_priv = netdev_priv(batman_if->soft_iface);
+	struct batman_packet_ndp *ndp_packet;
+	struct sk_buff *skb;
+
+	skb = skb_copy(batman_if->ndp_skb, GFP_ATOMIC);
+	ndp_packet = (struct batman_packet_ndp *)skb->data;
+	ndp_packet->seqno = htonl(atomic_read(&batman_if->ndp_seqno));
+	ndp_packet->num_neighbors = 0;
+	memcpy(ndp_packet->orig, bat_priv->primary_if->net_dev->dev_addr,
+	       ETH_ALEN);
 
 	bat_dbg(DBG_BATMAN, bat_priv,
 		"batman-adv:Sending ndp packet on interface %s, seqno %d\n",
-		batman_if->net_dev, atomic_read(&batman_if->ndp_seqno));
+		batman_if->net_dev, ntohl(ndp_packet->seqno));
+
+	send_skb_packet(skb, batman_if, broadcast_addr);
 
 	atomic_inc(&batman_if->ndp_seqno);
 	ndp_start_timer(batman_if);
@@ -60,12 +71,34 @@ static void ndp_send(struct work_struct *work)
 
 int ndp_init(struct batman_if *batman_if)
 {
+	struct batman_packet_ndp *ndp_packet;
+
+	batman_if->ndp_skb =
+		dev_alloc_skb(ETH_DATA_LEN + sizeof(struct ethhdr));
+	if (!batman_if->ndp_skb) {
+		printk(KERN_ERR "batman-adv: Can't add "
+			"local interface packet (%s): out of memory\n",
+			batman_if->net_dev->name);
+		goto err;
+	}
+	skb_reserve(batman_if->ndp_skb, sizeof(struct ethhdr) +
+					sizeof(struct batman_packet_ndp));
+	ndp_packet = (struct batman_packet_ndp *)
+		skb_push(batman_if->ndp_skb, sizeof(struct batman_packet_ndp));
+	memset(ndp_packet, 0, sizeof(struct batman_packet_ndp));
+
+	ndp_packet->packet_type = BAT_PACKET_NDP;
+	ndp_packet->version = COMPAT_VERSION;
+
 	INIT_DELAYED_WORK(&batman_if->ndp_wq, ndp_send);
 
 	return 0;
+err:
+	return 1;
 }
 
 void ndp_free(struct batman_if *batman_if)
 {
 	ndp_stop_timer(batman_if);
+	dev_kfree_skb(batman_if->ndp_skb);
 }
diff --git a/packet.h b/packet.h
index 681052d..0b0c453 100644
--- a/packet.h
+++ b/packet.h
@@ -24,12 +24,13 @@
 
 #define ETH_P_BATMAN  0x4305	/* unofficial/not registered Ethertype */
 
-#define BAT_PACKET_OGM   0x01
-#define BAT_ICMP         0x02
-#define BAT_UNICAST      0x03
-#define BAT_BCAST        0x04
-#define BAT_VIS          0x05
-#define BAT_UNICAST_FRAG 0x06
+#define BAT_PACKET_NDP   0x01
+#define BAT_PACKET_OGM   0x02
+#define BAT_ICMP         0x03
+#define BAT_UNICAST      0x04
+#define BAT_UNICAST_FRAG 0x05
+#define BAT_BCAST        0x06
+#define BAT_VIS          0x07
 
 /* this file is included by batctl which needs these defines */
 #define COMPAT_VERSION 12
@@ -51,6 +52,16 @@
 /* fragmentation defines */
 #define UNI_FRAG_HEAD 0x01
 
+/* Neighbor discovery packet */
+struct batman_packet_ndp {
+	uint8_t  packet_type;
+	uint8_t  version;  /* batman version field */
+	uint8_t  orig[6];
+	uint32_t seqno;
+	uint8_t  num_neighbors;
+	uint8_t  align[3];
+} __attribute__((packed));
+
 /* Originator message packet */
 struct ogm_packet {
 	uint8_t  packet_type;
diff --git a/types.h b/types.h
index 3ef48a6..f81d0ba 100644
--- a/types.h
+++ b/types.h
@@ -49,6 +49,7 @@ struct batman_if {
 	struct rcu_head rcu;
 	atomic_t ndp_interval;
 	atomic_t ndp_seqno;
+	struct sk_buff *ndp_skb;
 	struct delayed_work ndp_wq;
 };
 
-- 
1.7.1


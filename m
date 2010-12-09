Return-Path: <linus.luessing@ascom.ch>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Thu,  9 Dec 2010 10:23:52 +0100
Message-Id: <1291886638-19344-5-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1291732778-27441-1-git-send-email-linus.luessing@ascom.ch>
References: <1291732778-27441-1-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 04/10] batman-adv: Send neighbor discovery
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

Signed-off-by: Linus Lüssing <linus.luessing@ascom.ch>
---
 hard-interface.c |    5 ++++-
 ndp.c            |   36 +++++++++++++++++++++++++++++++++++-
 types.h          |    5 +++++
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/hard-interface.c b/hard-interface.c
index cb81c13..887f794 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -284,6 +284,7 @@ int hardif_enable_interface(struct batman_if *batman_if, char *iface_name)
 {
 	struct bat_priv *bat_priv;
 	struct batman_packet_ogm *batman_packet_ogm;
+	int ret;
 
 	if (batman_if->if_status != IF_NOT_IN_USE)
 		goto out;
@@ -331,7 +332,9 @@ int hardif_enable_interface(struct batman_if *batman_if, char *iface_name)
 
 	atomic_set(&batman_if->seqno, 1);
 	atomic_set(&batman_if->frag_seqno, 1);
-	ndp_init(batman_if);
+	ret = ndp_init(batman_if);
+	if (ret)
+		goto err;
 
 	bat_info(batman_if->soft_iface, "Adding interface: %s\n",
 		 batman_if->net_dev->name);
diff --git a/ndp.c b/ndp.c
index 2dfb06d..94d1971 100644
--- a/ndp.c
+++ b/ndp.c
@@ -20,10 +20,21 @@ static void ndp_send(struct work_struct *work)
 	struct batman_if *batman_if = container_of(work, struct batman_if,
 							ndp_wq.work);
 	struct bat_priv *bat_priv = netdev_priv(batman_if->soft_iface);
+	struct batman_packet_ndp *ndp_packet;
+	struct sk_buff *skb;
+
+	skb = skb_clone(batman_if->ndp_skb, GFP_ATOMIC);
+	ndp_packet = (struct batman_packet_ndp*)skb->data;
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
 	start_ndp_timer(batman_if);
@@ -31,14 +42,37 @@ static void ndp_send(struct work_struct *work)
 
 int ndp_init(struct batman_if *batman_if)
 {
+	struct batman_packet_ndp *ndp_packet;
+
 	atomic_set(&batman_if->ndp_interval, 500);
 	atomic_set(&batman_if->ndp_seqno, 0);
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
+	ndp_packet = (struct batman_packet_ndp*)
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
 	stop_ndp_timer(batman_if);
+	dev_kfree_skb(batman_if->ndp_skb);
 }
diff --git a/types.h b/types.h
index e8dfdf6..c5a26a7 100644
--- a/types.h
+++ b/types.h
@@ -49,6 +49,7 @@ struct batman_if {
 	struct rcu_head rcu;
 	atomic_t ndp_interval;
 	atomic_t ndp_seqno;
+	struct sk_buff *ndp_skb;
 	struct delayed_work ndp_wq;
 };
 
@@ -122,6 +123,10 @@ struct neigh_node {
 	struct batman_if *if_incoming;
 };
 
+struct neigh_entry {
+	uint8_t addr[ETH_ALEN];
+	uint8_t rq;
+};
 
 struct bat_priv {
 	atomic_t mesh_state;
-- 
1.7.1


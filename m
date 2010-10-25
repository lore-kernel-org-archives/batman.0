Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Tue, 26 Oct 2010 00:06:14 +0200
Message-Id: <1288044374-11771-2-git-send-email-linus.luessing@web.de>
In-Reply-To: <AANLkTi=MbTkJiD-=7LcWdzMdqcJeqaBkX2G6O3oeUDZ8@mail.gmail.com>
References: <AANLkTi=MbTkJiD-=7LcWdzMdqcJeqaBkX2G6O3oeUDZ8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Adding netfilter-bridge hooks
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

batman-adv is receiving and sending the packets of its own ether type
on a very early/low level. Therefore we need to add explicit hooks to
give netfilter/ebtables a chance to filter them.

//git revert 660d20261343e0b2ff57e51e50d7eb0e557d5e5b

//Signed-off-by: Linus Lüssing <linus.luessing@web.de>
//Reported-by: Antonio Quartulli <ordex@ritirata.org>
---
 hard-interface.c |   70 ++++++++++++++++++++++++++++++------------------------
 send.c           |    8 ++++-
 2 files changed, 45 insertions(+), 33 deletions(-)

diff --git a/hard-interface.c b/hard-interface.c
index ef95680..9153b19 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -30,6 +30,7 @@
 #include "hash.h"
 
 #include <linux/if_arp.h>
+#include <linux/netfilter_bridge.h>
 
 #include "compat.h"
 
@@ -539,46 +540,29 @@ out:
 	return NOTIFY_DONE;
 }
 
-/* receive a packet with the batman ethertype coming on a hard
- * interface */
-int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
-	struct packet_type *ptype, struct net_device *orig_dev)
+static int batman_skb_recv_finish(struct sk_buff *skb)
 {
-	struct bat_priv *bat_priv;
 	struct batman_packet *batman_packet;
 	struct batman_if *batman_if;
+	struct bat_priv *bat_priv;
 	int ret;
 
-	batman_if = container_of(ptype, struct batman_if, batman_adv_ptype);
-	skb = skb_share_check(skb, GFP_ATOMIC);
-
-	/* skb was released by skb_share_check() */
-	if (!skb)
-		goto err_out;
-
-	/* packet should hold at least type and version */
-	if (unlikely(!pskb_may_pull(skb, 2)))
+	batman_if = get_batman_if_by_netdev(skb->dev);
+	if (!batman_if)
 		goto err_free;
 
-	/* expect a valid ethernet header here. */
-	if (unlikely(skb->mac_len != sizeof(struct ethhdr)
-				|| !skb_mac_header(skb)))
+	if (!batman_if->soft_iface)
 		goto err_free;
 
-	if (!batman_if->soft_iface)
+	/* discard frames on not active interfaces */
+	if (batman_if->if_status != IF_ACTIVE)
 		goto err_free;
 
 	bat_priv = netdev_priv(batman_if->soft_iface);
-
 	if (atomic_read(&bat_priv->mesh_state) != MESH_ACTIVE)
 		goto err_free;
 
-	/* discard frames on not active interfaces */
-	if (batman_if->if_status != IF_ACTIVE)
-		goto err_free;
-
 	batman_packet = (struct batman_packet *)skb->data;
-
 	if (batman_packet->version != COMPAT_VERSION) {
 		bat_dbg(DBG_BATMAN, bat_priv,
 			"Drop packet: incompatible batman version (%i)\n",
@@ -624,18 +608,42 @@ int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	}
 
 	if (ret == NET_RX_DROP)
-		kfree_skb(skb);
+		goto err_free;
+
+	return 0;
 
-	/* return NET_RX_SUCCESS in any case as we
-	 * most probably dropped the packet for
-	 * routing-logical reasons. */
+err_free:
+	kfree_skb(skb);
+	return 0;
+}
 
-	return NET_RX_SUCCESS;
+/* receive a packet with the batman ethertype coming on a hard
+ * interface */
+int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
+	struct packet_type *ptype, struct net_device *orig_dev)
+{
+	skb = skb_share_check(skb, GFP_ATOMIC);
 
+	/* skb was released by skb_share_check() */
+	if (!skb)
+		return 0;
+
+	/* packet should hold at least type and version */
+	if (unlikely(!pskb_may_pull(skb, 2)))
+		goto err_free;
+
+	/* expect a valid ethernet header here. */
+	if (unlikely(skb->mac_len != sizeof(struct ethhdr) ||
+	    !skb_mac_header(skb)))
+		goto err_free;
+
+	/* if netfilter/ebtables wants to block incoming batman
+	 * packets then give them a chance to do so here */
+	return NF_HOOK(PF_BRIDGE, NF_BR_LOCAL_IN, skb, dev,
+		       NULL, batman_skb_recv_finish);
 err_free:
 	kfree_skb(skb);
-err_out:
-	return NET_RX_DROP;
+	return 0;
 }
 
 struct notifier_block hard_if_notifier = {
diff --git a/send.c b/send.c
index a96a786..11a009f 100644
--- a/send.c
+++ b/send.c
@@ -30,6 +30,7 @@
 #include "aggregation.h"
 #include "gateway_common.h"
 #include "originator.h"
+#include <linux/netfilter_bridge.h>
 
 #include "compat.h"
 
@@ -95,9 +96,12 @@ int send_skb_packet(struct sk_buff *skb,
 
 	/* dev_queue_xmit() returns a negative result on error.	 However on
 	 * congestion and traffic shaping, it drops and returns NET_XMIT_DROP
-	 * (which is > 0). This will not be treated as an error. */
+	 * (which is > 0). This will not be treated as an error.
+	 * Also, if netfilter/ebtables wants to block outgoing batman
+	 * packets then giving them a chance to do so here */
 
-	return dev_queue_xmit(skb);
+	return NF_HOOK(PF_BRIDGE, NF_BR_LOCAL_OUT, skb, NULL, skb->dev,
+		       dev_queue_xmit);
 send_skb_err:
 	kfree_skb(skb);
 	return NET_XMIT_DROP;
-- 
1.7.1


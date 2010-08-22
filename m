Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sun, 22 Aug 2010 22:53:20 +0200
Message-Id: <1282510400-10341-2-git-send-email-linus.luessing@web.de>
In-Reply-To: <1282510400-10341-1-git-send-email-linus.luessing@web.de>
References: <1282510400-10341-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Don't rely on NF_HOOKs return
	value
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
Cc: Vasiliy Kulikov <segooon@gmail.com>

If a hook returns NF_STOLEN, neither batman_skb_recv nor
batman_skb_recv_finish free the skb due to the asynchronous netfilter
handling in the kernel. Therefore not batman_skb_recv but the ok
function batman_skb_recv_finish should do the freeing when a recv
subfunction returns NET_RX_DROP instead.

Reported-by: Vasiliy Kulikov <segooon@gmail.com>
Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 hard-interface.c |   80 +++++++++++++++++++++++++----------------------------
 1 files changed, 38 insertions(+), 42 deletions(-)

diff --git a/hard-interface.c b/hard-interface.c
index a437ec3..3e81d17 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -494,56 +494,27 @@ out:
 
 static int batman_skb_recv_finish(struct sk_buff *skb)
 {
-	return NF_ACCEPT;
-}
-
-/* receive a packet with the batman ethertype coming on a hard
- * interface */
-int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
-	struct packet_type *ptype, struct net_device *orig_dev)
-{
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
-	/* if netfilter/ebtables wants to block incoming batman
-	 * packets then give them a chance to do so here */
-	ret = NF_HOOK(PF_BRIDGE, NF_BR_LOCAL_IN, skb, dev, NULL,
-		      batman_skb_recv_finish);
-	if (ret != 1)
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
@@ -551,6 +522,7 @@ int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 		goto err_free;
 	}
 
+
 	/* all receive handlers return whether they received or reused
 	 * the supplied skb. if not, we have to free the skb. */
 
@@ -589,18 +561,42 @@ int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	}
 
 	if (ret == NET_RX_DROP)
-		kfree_skb(skb);
+		goto err_free;
 
-	/* return NET_RX_SUCCESS in any case as we
-	 * most probably dropped the packet for
-	 * routing-logical reasons. */
+	return 0;
 
-	return NET_RX_SUCCESS;
+err_free:
+	kfree_skb(skb);
+	return 0;
+}
 
+/* receive a packet with the batman ethertype coming on a hard
+ * interface */
+int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
+	struct packet_type *ptype, struct net_device *orig_dev)
+{
+	skb = skb_share_check(skb, GFP_ATOMIC);
+
+	/* skb was released by skb_share_check() */
+	if (!skb)
+		return 0;
+
+	/* packet should hold at least type and version */
+	if (unlikely(!pskb_may_pull(skb, 2)))
+		goto err_free;
+
+	/* expect a valid ethernet header here. */
+	if (unlikely(skb->mac_len != sizeof(struct ethhdr)
+				|| !skb_mac_header(skb)))
+		goto err_free;
+
+	/* if netfilter/ebtables wants to block incoming batman
+	 * packets then give them a chance to do so here */
+	return NF_HOOK(PF_BRIDGE, NF_BR_LOCAL_IN, skb, dev, NULL,
+		      batman_skb_recv_finish);
 err_free:
 	kfree_skb(skb);
-err_out:
-	return NET_RX_DROP;
+	return 0;
 }
 
 struct notifier_block hard_if_notifier = {
-- 
1.7.1


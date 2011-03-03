Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu,  3 Mar 2011 22:08:39 +0100
Message-Id: <1299186519-27314-1-git-send-email-sven@narfation.org>
In-Reply-To: <1299184756-26069-1-git-send-email-sven@narfation.org>
References: <1299184756-26069-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: Disallow regular interface as
	mesh device
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

When trying to associate a net_device with another net_device which
already exists, batman-adv assumes that this interface is a fully
initialized batman mesh interface without checking it. The behaviour
when accessing data behind netdev_priv of a random net_device is
undefined and potentially dangerous.

Reported-by: Linus Lüssing <linus.luessing@ascom.ch>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 * Just smaller cleanups
 * No functionality changes

 batman-adv/hard-interface.c |   34 ++++++++++++++++++++++------------
 batman-adv/soft-interface.c |   13 +++++++++++++
 batman-adv/soft-interface.h |    1 +
 3 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/batman-adv/hard-interface.c b/batman-adv/hard-interface.c
index 95a35b6..a5d88e5 100644
--- a/batman-adv/hard-interface.c
+++ b/batman-adv/hard-interface.c
@@ -79,13 +79,8 @@ static int is_valid_iface(struct net_device *net_dev)
 		return 0;
 
 	/* no batman over batman */
-#ifdef HAVE_NET_DEVICE_OPS
-	if (net_dev->netdev_ops->ndo_start_xmit == interface_tx)
+	if (softif_is_valid(net_dev))
 		return 0;
-#else
-	if (net_dev->hard_start_xmit == interface_tx)
-		return 0;
-#endif
 
 	/* Device is being bridged */
 	/* if (net_dev->priv_flags & IFF_BRIDGE_PORT)
@@ -282,6 +277,8 @@ int hardif_enable_interface(struct hard_iface *hard_iface, char *iface_name)
 {
 	struct bat_priv *bat_priv;
 	struct batman_packet *batman_packet;
+	struct net_device *soft_iface;
+	int ret;
 
 	if (hard_iface->if_status != IF_NOT_IN_USE)
 		goto out;
@@ -289,18 +286,30 @@ int hardif_enable_interface(struct hard_iface *hard_iface, char *iface_name)
 	if (!atomic_inc_not_zero(&hard_iface->refcount))
 		goto out;
 
-	hard_iface->soft_iface = dev_get_by_name(&init_net, iface_name);
+	soft_iface = dev_get_by_name(&init_net, iface_name);
 
-	if (!hard_iface->soft_iface) {
-		hard_iface->soft_iface = softif_create(iface_name);
+	if (!soft_iface) {
+		soft_iface = softif_create(iface_name);
 
-		if (!hard_iface->soft_iface)
+		if (!soft_iface) {
+			ret = -ENOMEM;
 			goto err;
+		}
 
 		/* dev_get_by_name() increases the reference counter for us */
-		dev_hold(hard_iface->soft_iface);
+		dev_hold(soft_iface);
 	}
 
+	if (!softif_is_valid(soft_iface)) {
+		pr_err("Can't create batman mesh interface interface %s: "
+		       "already exists as regular interface\n",
+		       soft_iface->name);
+		dev_put(soft_iface);
+		ret = -EINVAL;
+		goto err;
+	}
+
+	hard_iface->soft_iface = soft_iface;
 	bat_priv = netdev_priv(hard_iface->soft_iface);
 	hard_iface->packet_len = BAT_PACKET_LEN;
 	hard_iface->packet_buff = kmalloc(hard_iface->packet_len, GFP_ATOMIC);
@@ -308,6 +317,7 @@ int hardif_enable_interface(struct hard_iface *hard_iface, char *iface_name)
 	if (!hard_iface->packet_buff) {
 		bat_err(hard_iface->soft_iface, "Can't add interface packet "
 			"(%s): out of memory\n", hard_iface->net_dev->name);
+		ret = -ENOMEM;
 		goto err;
 	}
 
@@ -370,7 +380,7 @@ out:
 
 err:
 	hardif_free_ref(hard_iface);
-	return -ENOMEM;
+	return ret;
 }
 
 void hardif_disable_interface(struct hard_iface *hard_iface)
diff --git a/batman-adv/soft-interface.c b/batman-adv/soft-interface.c
index 6b514ec..9ed2614 100644
--- a/batman-adv/soft-interface.c
+++ b/batman-adv/soft-interface.c
@@ -622,6 +622,19 @@ void softif_destroy(struct net_device *soft_iface)
 	unregister_netdevice(soft_iface);
 }
 
+int softif_is_valid(struct net_device *net_dev)
+{
+#ifdef HAVE_NET_DEVICE_OPS
+	if (net_dev->netdev_ops->ndo_start_xmit == interface_tx)
+		return 1;
+#else
+	if (net_dev->hard_start_xmit == interface_tx)
+		return 1;
+#endif
+
+	return 0;
+}
+
 /* ethtool */
 static int bat_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
 {
diff --git a/batman-adv/soft-interface.h b/batman-adv/soft-interface.h
index 80a3607..4789b6f 100644
--- a/batman-adv/soft-interface.h
+++ b/batman-adv/soft-interface.h
@@ -31,5 +31,6 @@ void interface_rx(struct net_device *soft_iface,
 		  int hdr_size);
 struct net_device *softif_create(char *name);
 void softif_destroy(struct net_device *soft_iface);
+int softif_is_valid(struct net_device *net_dev);
 
 #endif /* _NET_BATMAN_ADV_SOFT_INTERFACE_H_ */
-- 
1.7.4.1


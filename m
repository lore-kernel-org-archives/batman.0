Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon,  9 Aug 2010 23:56:38 +0200
Message-Id: <1281391002-21577-2-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1281391002-21577-1-git-send-email-sven.eckelmann@gmx.de>
References: <1281391002-21577-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/5] Staging: batman-adv: Fix merge of linus
	tree
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
To: greg@kroah.com
Cc: b.a.t.m.a.n@lists.open-mesh.net

Greg Kroah-Hartman merged Linus 2.6.36 tree in
e9563355ac1175dd3440dc2ea5c28b27ed51a283 with his staging tree.
Different parts of the merge conflicts were resolved incorrectly and may
result in an abnormal behavior.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/bat_sysfs.c      |    4 ++++
 drivers/staging/batman-adv/hard-interface.c |    8 --------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/batman-adv/bat_sysfs.c b/drivers/staging/batman-adv/bat_sysfs.c
index b4a8d5e..05ca15a 100644
--- a/drivers/staging/batman-adv/bat_sysfs.c
+++ b/drivers/staging/batman-adv/bat_sysfs.c
@@ -267,6 +267,10 @@ static ssize_t store_log_level(struct kobject *kobj, struct attribute *attr,
 	if (atomic_read(&bat_priv->log_level) == log_level_tmp)
 		return count;
 
+	bat_info(net_dev, "Changing log level from: %i to: %li\n",
+		 atomic_read(&bat_priv->log_level),
+		 log_level_tmp);
+
 	atomic_set(&bat_priv->log_level, (unsigned)log_level_tmp);
 	return count;
 }
diff --git a/drivers/staging/batman-adv/hard-interface.c b/drivers/staging/batman-adv/hard-interface.c
index 92c216a..f6345c4 100644
--- a/drivers/staging/batman-adv/hard-interface.c
+++ b/drivers/staging/batman-adv/hard-interface.c
@@ -442,8 +442,6 @@ int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	struct batman_packet *batman_packet;
 	struct batman_if *batman_if;
-	struct net_device_stats *stats;
-	struct rtnl_link_stats64 temp;
 	int ret;
 
 	skb = skb_share_check(skb, GFP_ATOMIC);
@@ -479,12 +477,6 @@ int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	if (batman_if->if_status != IF_ACTIVE)
 		goto err_free;
 
-	stats = (struct net_device_stats *)dev_get_stats(skb->dev, &temp);
-	if (stats) {
-		stats->rx_packets++;
-		stats->rx_bytes += skb->len;
-	}
-
 	batman_packet = (struct batman_packet *)skb->data;
 
 	if (batman_packet->version != COMPAT_VERSION) {
-- 
1.7.1


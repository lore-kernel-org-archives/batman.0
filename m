Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun,  5 Sep 2010 01:58:27 +0200
Message-Id: <1283644718-653-11-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1283644718-653-1-git-send-email-sven.eckelmann@gmx.de>
References: <1283644718-653-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 10/21] Staging: batman-adv: register the
	batman-adv packet type per interface
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
Cc: Marek Lindner <lindner_marek@yahoo.de>, b.a.t.m.a.n@lists.open-mesh.net

From: Marek Lindner <lindner_marek@yahoo.de>

Batman-adv globally registered the batman-adv packet type and installed
a hook to batman_skb_recv(). Each interface receiving a packet with that
type would end up in this function which then had to loop through all
batman-adv internal interface structures to find the its meta data. The
more interfaces a system had the longer the loops might take. Each and
every packet goes through this function making it a performance critical
loop.

This patch installs the hook for each activated interface. The called
batman_skb_recv() can distinguish these calls, therefore avoiding the
loop through the interface structures.

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
[sven.eckelmann@gmx.de: Rework on top of current version]
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/hard-interface.c |   12 ++++++++----
 drivers/staging/batman-adv/main.c           |   10 ----------
 drivers/staging/batman-adv/types.h          |    2 +-
 3 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/batman-adv/hard-interface.c b/drivers/staging/batman-adv/hard-interface.c
index 82d3d55..f33c73f 100644
--- a/drivers/staging/batman-adv/hard-interface.c
+++ b/drivers/staging/batman-adv/hard-interface.c
@@ -265,6 +265,11 @@ int hardif_enable_interface(struct batman_if *batman_if)
 	batman_if->if_status = IF_INACTIVE;
 	orig_hash_add_if(batman_if, bat_priv->num_ifaces);
 
+	batman_if->batman_adv_ptype.type = __constant_htons(ETH_P_BATMAN);
+	batman_if->batman_adv_ptype.func = batman_skb_recv;
+	batman_if->batman_adv_ptype.dev = batman_if->net_dev;
+	dev_add_pack(&batman_if->batman_adv_ptype);
+
 	atomic_set(&batman_if->seqno, 1);
 	atomic_set(&batman_if->frag_seqno, 1);
 	bat_info(soft_device, "Adding interface: %s\n", batman_if->dev);
@@ -319,6 +324,8 @@ void hardif_disable_interface(struct batman_if *batman_if)
 		return;
 
 	bat_info(soft_device, "Removing interface: %s\n", batman_if->dev);
+	dev_remove_pack(&batman_if->batman_adv_ptype);
+
 	bat_priv->num_ifaces--;
 	orig_hash_del_if(batman_if, bat_priv->num_ifaces);
 
@@ -468,6 +475,7 @@ int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	struct batman_if *batman_if;
 	int ret;
 
+	batman_if = container_of(ptype, struct batman_if, batman_adv_ptype);
 	skb = skb_share_check(skb, GFP_ATOMIC);
 
 	/* skb was released by skb_share_check() */
@@ -486,10 +494,6 @@ int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 				|| !skb_mac_header(skb)))
 		goto err_free;
 
-	batman_if = get_batman_if_by_netdev(skb->dev);
-	if (!batman_if)
-		goto err_free;
-
 	/* discard frames on not active interfaces */
 	if (batman_if->if_status != IF_ACTIVE)
 		goto err_free;
diff --git a/drivers/staging/batman-adv/main.c b/drivers/staging/batman-adv/main.c
index c0a3373..eb0bfbe 100644
--- a/drivers/staging/batman-adv/main.c
+++ b/drivers/staging/batman-adv/main.c
@@ -49,11 +49,6 @@ struct net_device *soft_device;
 unsigned char broadcast_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 atomic_t module_state;
 
-static struct packet_type batman_adv_packet_type __read_mostly = {
-	.type = __constant_htons(ETH_P_BATMAN),
-	.func = batman_skb_recv,
-};
-
 struct workqueue_struct *bat_event_workqueue;
 
 static int __init batman_init(void)
@@ -103,7 +98,6 @@ static int __init batman_init(void)
 		goto unreg_sysfs;
 
 	register_netdevice_notifier(&hard_if_notifier);
-	dev_add_pack(&batman_adv_packet_type);
 
 	pr_info("B.A.T.M.A.N. advanced %s%s (compatibility version %i) "
 		"loaded\n", SOURCE_VERSION, REVISION_VERSION_STR,
@@ -140,8 +134,6 @@ static void __exit batman_exit(void)
 		soft_device = NULL;
 	}
 
-	dev_remove_pack(&batman_adv_packet_type);
-
 	destroy_workqueue(bat_event_workqueue);
 	bat_event_workqueue = NULL;
 }
@@ -185,8 +177,6 @@ void deactivate_module(void)
 
 	vis_quit();
 
-	/* TODO: unregister BATMAN pack */
-
 	originator_free();
 
 	hna_local_free();
diff --git a/drivers/staging/batman-adv/types.h b/drivers/staging/batman-adv/types.h
index ac16575..2b06944 100644
--- a/drivers/staging/batman-adv/types.h
+++ b/drivers/staging/batman-adv/types.h
@@ -46,7 +46,7 @@ struct batman_if {
 	int packet_len;
 	struct kobject *hardif_obj;
 	struct rcu_head rcu;
-
+	struct packet_type batman_adv_ptype;
 };
 
 /**
-- 
1.7.1


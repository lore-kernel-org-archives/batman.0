Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue,  7 Feb 2012 17:20:48 +0800
Message-Id: <1328606451-3418-4-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1328606451-3418-1-git-send-email-lindner_marek@yahoo.de>
References: <201202071719.22804.lindner_marek@yahoo.de>
	<1328606451-3418-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 5/8] batman-adv: handle routing code
	initialization properly
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 bat_iv_ogm.c     |   11 ++++++++++-
 hard-interface.c |   14 ++++++--------
 types.h          |    2 +-
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 98c41f5..d944a0b 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -30,10 +30,11 @@
 #include "send.h"
 #include "bat_algo.h"
 
-static void bat_iv_ogm_iface_enable(struct hard_iface *hard_iface)
+static int bat_iv_ogm_iface_enable(struct hard_iface *hard_iface)
 {
 	struct batman_ogm_packet *batman_ogm_packet;
 	unsigned long random_seqno;
+	int res = -1;
 
 	/* randomize initial seqno to avoid collision */
 	get_random_bytes(&random_seqno, sizeof(unsigned long));
@@ -42,6 +43,9 @@ static void bat_iv_ogm_iface_enable(struct hard_iface *hard_iface)
 	hard_iface->packet_len = BATMAN_OGM_LEN;
 	hard_iface->packet_buff = kmalloc(hard_iface->packet_len, GFP_ATOMIC);
 
+	if (!hard_iface->packet_buff)
+		goto out;
+
 	batman_ogm_packet = (struct batman_ogm_packet *)hard_iface->packet_buff;
 	batman_ogm_packet->header.packet_type = BAT_OGM;
 	batman_ogm_packet->header.version = COMPAT_VERSION;
@@ -50,6 +54,11 @@ static void bat_iv_ogm_iface_enable(struct hard_iface *hard_iface)
 	batman_ogm_packet->tq = TQ_MAX_VALUE;
 	batman_ogm_packet->tt_num_changes = 0;
 	batman_ogm_packet->ttvn = 0;
+
+	res = 0;
+
+out:
+	return res;
 }
 
 static void bat_iv_ogm_iface_disable(struct hard_iface *hard_iface)
diff --git a/hard-interface.c b/hard-interface.c
index ec2f478..d6b25e0 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -310,21 +310,17 @@ int hardif_enable_interface(struct hard_iface *hard_iface,
 		pr_err("Can't create batman mesh interface %s: "
 		       "already exists as regular interface\n",
 		       soft_iface->name);
-		dev_put(soft_iface);
 		ret = -EINVAL;
-		goto err;
+		goto err_dev;
 	}
 
 	hard_iface->soft_iface = soft_iface;
 	bat_priv = netdev_priv(hard_iface->soft_iface);
 
-	bat_priv->bat_algo_ops->bat_iface_enable(hard_iface);
-
-	if (!hard_iface->packet_buff) {
-		bat_err(hard_iface->soft_iface, "Can't add interface packet "
-			"(%s): out of memory\n", hard_iface->net_dev->name);
+	ret = bat_priv->bat_algo_ops->bat_iface_enable(hard_iface);
+	if (ret < 0) {
 		ret = -ENOMEM;
-		goto err;
+		goto err_dev;
 	}
 
 	hard_iface->if_num = bat_priv->num_ifaces;
@@ -375,6 +371,8 @@ int hardif_enable_interface(struct hard_iface *hard_iface,
 out:
 	return 0;
 
+err_dev:
+	dev_put(soft_iface);
 err:
 	hardif_free_ref(hard_iface);
 	return ret;
diff --git a/types.h b/types.h
index 5e8de0e..3df38df 100644
--- a/types.h
+++ b/types.h
@@ -370,7 +370,7 @@ struct bat_algo_ops {
 	struct hlist_node list;
 	char *name;
 	/* init routing info when hard-interface is enabled */
-	void (*bat_iface_enable)(struct hard_iface *hard_iface);
+	int (*bat_iface_enable)(struct hard_iface *hard_iface);
 	/* de-init routing info when hard-interface is disabled */
 	void (*bat_iface_disable)(struct hard_iface *hard_iface);
 	/* init primary OGM when primary interface is selected */
-- 
1.7.5.4


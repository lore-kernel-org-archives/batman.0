Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 11 Mar 2012 06:17:50 +0800
Message-Id: <1331417873-19354-2-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1331417873-19354-1-git-send-email-lindner_marek@yahoo.de>
References: <1331417873-19354-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/5] batman-adv: refactoring API: find
	generalized name for bat_ogm_update_mac callback
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
 bat_iv_ogm.c     |   18 +++++++++---------
 hard-interface.c |    4 ++--
 main.c           |    2 +-
 types.h          |    5 +++--
 4 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 819ae49..1e92e38 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -93,24 +93,24 @@ static void bat_iv_ogm_iface_disable(struct hard_iface *hard_iface)
 	hard_iface->packet_buff = NULL;
 }
 
-static void bat_iv_ogm_primary_iface_set(struct hard_iface *hard_iface)
+static void bat_iv_ogm_iface_update_mac(struct hard_iface *hard_iface)
 {
 	struct batman_ogm_packet *batman_ogm_packet;
 
 	batman_ogm_packet = (struct batman_ogm_packet *)hard_iface->packet_buff;
-	batman_ogm_packet->flags = PRIMARIES_FIRST_HOP;
-	batman_ogm_packet->header.ttl = TTL;
+	memcpy(batman_ogm_packet->orig,
+	       hard_iface->net_dev->dev_addr, ETH_ALEN);
+	memcpy(batman_ogm_packet->prev_sender,
+	       hard_iface->net_dev->dev_addr, ETH_ALEN);
 }
 
-static void bat_iv_ogm_update_mac(struct hard_iface *hard_iface)
+static void bat_iv_ogm_primary_iface_set(struct hard_iface *hard_iface)
 {
 	struct batman_ogm_packet *batman_ogm_packet;
 
 	batman_ogm_packet = (struct batman_ogm_packet *)hard_iface->packet_buff;
-	memcpy(batman_ogm_packet->orig,
-	       hard_iface->net_dev->dev_addr, ETH_ALEN);
-	memcpy(batman_ogm_packet->prev_sender,
-	       hard_iface->net_dev->dev_addr, ETH_ALEN);
+	batman_ogm_packet->flags = PRIMARIES_FIRST_HOP;
+	batman_ogm_packet->header.ttl = TTL;
 }
 
 /* when do we schedule our own ogm to be sent */
@@ -1235,8 +1235,8 @@ static struct bat_algo_ops batman_iv __read_mostly = {
 	.name = "BATMAN IV",
 	.bat_iface_enable = bat_iv_ogm_iface_enable,
 	.bat_iface_disable = bat_iv_ogm_iface_disable,
+	.bat_iface_update_mac = bat_iv_ogm_iface_update_mac,
 	.bat_primary_iface_set = bat_iv_ogm_primary_iface_set,
-	.bat_ogm_update_mac = bat_iv_ogm_update_mac,
 	.bat_ogm_schedule = bat_iv_ogm_schedule,
 	.bat_ogm_emit = bat_iv_ogm_emit,
 };
diff --git a/hard-interface.c b/hard-interface.c
index b49bf0d..daa6adc 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -231,7 +231,7 @@ static void hardif_activate_interface(struct hard_iface *hard_iface)
 
 	bat_priv = netdev_priv(hard_iface->soft_iface);
 
-	bat_priv->bat_algo_ops->bat_ogm_update_mac(hard_iface);
+	bat_priv->bat_algo_ops->bat_iface_update_mac(hard_iface);
 	hard_iface->if_status = IF_TO_BE_ACTIVATED;
 
 	/**
@@ -527,7 +527,7 @@ static int hard_if_event(struct notifier_block *this,
 		check_known_mac_addr(hard_iface->net_dev);
 
 		bat_priv = netdev_priv(hard_iface->soft_iface);
-		bat_priv->bat_algo_ops->bat_ogm_update_mac(hard_iface);
+		bat_priv->bat_algo_ops->bat_iface_update_mac(hard_iface);
 
 		primary_if = primary_if_get_selected(bat_priv);
 		if (!primary_if)
diff --git a/main.c b/main.c
index 04658e0..75938fb 100644
--- a/main.c
+++ b/main.c
@@ -326,8 +326,8 @@ int bat_algo_register(struct bat_algo_ops *bat_algo_ops)
 	/* all algorithms must implement all ops (for now) */
 	if (!bat_algo_ops->bat_iface_enable ||
 	    !bat_algo_ops->bat_iface_disable ||
+	    !bat_algo_ops->bat_iface_update_mac ||
 	    !bat_algo_ops->bat_primary_iface_set ||
-	    !bat_algo_ops->bat_ogm_update_mac ||
 	    !bat_algo_ops->bat_ogm_schedule ||
 	    !bat_algo_ops->bat_ogm_emit) {
 		pr_info("Routing algo '%s' does not implement required ops\n",
diff --git a/types.h b/types.h
index 5ca9b58..04d6cf5 100644
--- a/types.h
+++ b/types.h
@@ -398,10 +398,11 @@ struct bat_algo_ops {
 	int (*bat_iface_enable)(struct hard_iface *hard_iface);
 	/* de-init routing info when hard-interface is disabled */
 	void (*bat_iface_disable)(struct hard_iface *hard_iface);
+	/* (re-)init mac addresses of the protocol information
+	 * belonging to this hard-interface */
+	void (*bat_iface_update_mac)(struct hard_iface *hard_iface);
 	/* called when primary interface is selected / changed */
 	void (*bat_primary_iface_set)(struct hard_iface *hard_iface);
-	/* init mac addresses of the OGM belonging to this hard-interface */
-	void (*bat_ogm_update_mac)(struct hard_iface *hard_iface);
 	/* prepare a new outgoing OGM for the send queue */
 	void (*bat_ogm_schedule)(struct hard_iface *hard_iface,
 				 int tt_num_changes);
-- 
1.7.9.1


Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue,  7 Feb 2012 17:20:45 +0800
Message-Id: <1328606451-3418-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <201202071719.22804.lindner_marek@yahoo.de>
References: <201202071719.22804.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/8] batman-adv: refactoring API: find
	generalized name for bat_ogm_init callback
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
 bat_iv_ogm.c     |    4 ++--
 hard-interface.c |    2 +-
 main.c           |    2 +-
 types.h          |    4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index bbab00b..3eff7f0 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -30,7 +30,7 @@
 #include "send.h"
 #include "bat_algo.h"
 
-static void bat_iv_ogm_init(struct hard_iface *hard_iface)
+static void bat_iv_ogm_iface_enable(struct hard_iface *hard_iface)
 {
 	struct batman_ogm_packet *batman_ogm_packet;
 
@@ -1180,7 +1180,7 @@ static void bat_iv_ogm_receive(struct hard_iface *if_incoming,
 
 static struct bat_algo_ops batman_iv __read_mostly = {
 	.name = "BATMAN IV",
-	.bat_ogm_init = bat_iv_ogm_init,
+	.bat_iface_enable = bat_iv_ogm_iface_enable,
 	.bat_ogm_init_primary = bat_iv_ogm_init_primary,
 	.bat_ogm_update_mac = bat_iv_ogm_update_mac,
 	.bat_ogm_schedule = bat_iv_ogm_schedule,
diff --git a/hard-interface.c b/hard-interface.c
index e16c996..4052444 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -318,7 +318,7 @@ int hardif_enable_interface(struct hard_iface *hard_iface,
 	hard_iface->soft_iface = soft_iface;
 	bat_priv = netdev_priv(hard_iface->soft_iface);
 
-	bat_priv->bat_algo_ops->bat_ogm_init(hard_iface);
+	bat_priv->bat_algo_ops->bat_iface_enable(hard_iface);
 
 	if (!hard_iface->packet_buff) {
 		bat_err(hard_iface->soft_iface, "Can't add interface packet "
diff --git a/main.c b/main.c
index 7750bca..8bc27e1 100644
--- a/main.c
+++ b/main.c
@@ -208,7 +208,7 @@ int bat_algo_register(struct bat_algo_ops *bat_algo_ops)
 	}
 
 	/* all algorithms must implement all ops (for now) */
-	if (!bat_algo_ops->bat_ogm_init ||
+	if (!bat_algo_ops->bat_iface_enable ||
 	    !bat_algo_ops->bat_ogm_init_primary ||
 	    !bat_algo_ops->bat_ogm_update_mac ||
 	    !bat_algo_ops->bat_ogm_schedule ||
diff --git a/types.h b/types.h
index 7f7f610..c78b925 100644
--- a/types.h
+++ b/types.h
@@ -369,8 +369,8 @@ struct recvlist_node {
 struct bat_algo_ops {
 	struct hlist_node list;
 	char *name;
-	/* init OGM when hard-interface is enabled */
-	void (*bat_ogm_init)(struct hard_iface *hard_iface);
+	/* init routing info when hard-interface is enabled */
+	void (*bat_iface_enable)(struct hard_iface *hard_iface);
 	/* init primary OGM when primary interface is selected */
 	void (*bat_ogm_init_primary)(struct hard_iface *hard_iface);
 	/* init mac addresses of the OGM belonging to this hard-interface */
-- 
1.7.5.4


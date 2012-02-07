Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue,  7 Feb 2012 17:20:47 +0800
Message-Id: <1328606451-3418-3-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1328606451-3418-1-git-send-email-lindner_marek@yahoo.de>
References: <201202071719.22804.lindner_marek@yahoo.de>
	<1328606451-3418-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 4/8] batman-adv: add iface_disable() callback
	to routing API
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
 bat_iv_ogm.c     |    7 +++++++
 hard-interface.c |    3 +--
 main.c           |    1 +
 types.h          |    2 ++
 4 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 4ac2d1d..98c41f5 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -52,6 +52,12 @@ static void bat_iv_ogm_iface_enable(struct hard_iface *hard_iface)
 	batman_ogm_packet->ttvn = 0;
 }
 
+static void bat_iv_ogm_iface_disable(struct hard_iface *hard_iface)
+{
+	kfree(hard_iface->packet_buff);
+	hard_iface->packet_buff = NULL;
+}
+
 static void bat_iv_ogm_init_primary(struct hard_iface *hard_iface)
 {
 	struct batman_ogm_packet *batman_ogm_packet;
@@ -1186,6 +1192,7 @@ static void bat_iv_ogm_receive(struct hard_iface *if_incoming,
 static struct bat_algo_ops batman_iv __read_mostly = {
 	.name = "BATMAN IV",
 	.bat_iface_enable = bat_iv_ogm_iface_enable,
+	.bat_iface_disable = bat_iv_ogm_iface_disable,
 	.bat_ogm_init_primary = bat_iv_ogm_init_primary,
 	.bat_ogm_update_mac = bat_iv_ogm_update_mac,
 	.bat_ogm_schedule = bat_iv_ogm_schedule,
diff --git a/hard-interface.c b/hard-interface.c
index 4052444..ec2f478 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -409,8 +409,7 @@ void hardif_disable_interface(struct hard_iface *hard_iface)
 			hardif_free_ref(new_if);
 	}
 
-	kfree(hard_iface->packet_buff);
-	hard_iface->packet_buff = NULL;
+	bat_priv->bat_algo_ops->bat_iface_disable(hard_iface);
 	hard_iface->if_status = IF_NOT_IN_USE;
 
 	/* delete all references to this hard_iface */
diff --git a/main.c b/main.c
index 8bc27e1..c4a9b2b 100644
--- a/main.c
+++ b/main.c
@@ -209,6 +209,7 @@ int bat_algo_register(struct bat_algo_ops *bat_algo_ops)
 
 	/* all algorithms must implement all ops (for now) */
 	if (!bat_algo_ops->bat_iface_enable ||
+	    !bat_algo_ops->bat_iface_disable ||
 	    !bat_algo_ops->bat_ogm_init_primary ||
 	    !bat_algo_ops->bat_ogm_update_mac ||
 	    !bat_algo_ops->bat_ogm_schedule ||
diff --git a/types.h b/types.h
index c78b925..5e8de0e 100644
--- a/types.h
+++ b/types.h
@@ -371,6 +371,8 @@ struct bat_algo_ops {
 	char *name;
 	/* init routing info when hard-interface is enabled */
 	void (*bat_iface_enable)(struct hard_iface *hard_iface);
+	/* de-init routing info when hard-interface is disabled */
+	void (*bat_iface_disable)(struct hard_iface *hard_iface);
 	/* init primary OGM when primary interface is selected */
 	void (*bat_ogm_init_primary)(struct hard_iface *hard_iface);
 	/* init mac addresses of the OGM belonging to this hard-interface */
-- 
1.7.5.4


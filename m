Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue,  7 Feb 2012 17:20:49 +0800
Message-Id: <1328606451-3418-5-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1328606451-3418-1-git-send-email-lindner_marek@yahoo.de>
References: <201202071719.22804.lindner_marek@yahoo.de>
	<1328606451-3418-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 6/8] batman-adv: refactoring API: find
	generalized name for bat_ogm_init_primary callback
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
index d944a0b..b82a772 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -67,7 +67,7 @@ static void bat_iv_ogm_iface_disable(struct hard_iface *hard_iface)
 	hard_iface->packet_buff = NULL;
 }
 
-static void bat_iv_ogm_init_primary(struct hard_iface *hard_iface)
+static void bat_iv_ogm_primary_iface_set(struct hard_iface *hard_iface)
 {
 	struct batman_ogm_packet *batman_ogm_packet;
 
@@ -1202,7 +1202,7 @@ static struct bat_algo_ops batman_iv __read_mostly = {
 	.name = "BATMAN IV",
 	.bat_iface_enable = bat_iv_ogm_iface_enable,
 	.bat_iface_disable = bat_iv_ogm_iface_disable,
-	.bat_ogm_init_primary = bat_iv_ogm_init_primary,
+	.bat_primary_iface_set = bat_iv_ogm_primary_iface_set,
 	.bat_ogm_update_mac = bat_iv_ogm_update_mac,
 	.bat_ogm_schedule = bat_iv_ogm_schedule,
 	.bat_ogm_emit = bat_iv_ogm_emit,
diff --git a/hard-interface.c b/hard-interface.c
index d6b25e0..2a435ec 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -146,7 +146,7 @@ static void primary_if_select(struct bat_priv *bat_priv,
 	if (!new_hard_iface)
 		goto out;
 
-	bat_priv->bat_algo_ops->bat_ogm_init_primary(new_hard_iface);
+	bat_priv->bat_algo_ops->bat_primary_iface_set(new_hard_iface);
 	primary_if_update_addr(bat_priv, curr_hard_iface);
 
 out:
diff --git a/main.c b/main.c
index c4a9b2b..87b75a9 100644
--- a/main.c
+++ b/main.c
@@ -210,7 +210,7 @@ int bat_algo_register(struct bat_algo_ops *bat_algo_ops)
 	/* all algorithms must implement all ops (for now) */
 	if (!bat_algo_ops->bat_iface_enable ||
 	    !bat_algo_ops->bat_iface_disable ||
-	    !bat_algo_ops->bat_ogm_init_primary ||
+	    !bat_algo_ops->bat_primary_iface_set ||
 	    !bat_algo_ops->bat_ogm_update_mac ||
 	    !bat_algo_ops->bat_ogm_schedule ||
 	    !bat_algo_ops->bat_ogm_emit ||
diff --git a/types.h b/types.h
index 3df38df..e3d2f1f 100644
--- a/types.h
+++ b/types.h
@@ -373,8 +373,8 @@ struct bat_algo_ops {
 	int (*bat_iface_enable)(struct hard_iface *hard_iface);
 	/* de-init routing info when hard-interface is disabled */
 	void (*bat_iface_disable)(struct hard_iface *hard_iface);
-	/* init primary OGM when primary interface is selected */
-	void (*bat_ogm_init_primary)(struct hard_iface *hard_iface);
+	/* called when primary interface is selected / changed */
+	void (*bat_primary_iface_set)(struct hard_iface *hard_iface);
 	/* init mac addresses of the OGM belonging to this hard-interface */
 	void (*bat_ogm_update_mac)(struct hard_iface *hard_iface);
 	/* prepare a new outgoing OGM for the send queue */
-- 
1.7.5.4


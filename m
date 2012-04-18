Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 18 Apr 2012 12:00:03 +0200
Message-Id: <1334743210-12338-7-git-send-email-ordex@autistici.org>
In-Reply-To: <1334743210-12338-1-git-send-email-ordex@autistici.org>
References: <1334743210-12338-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 06/13] batman-adv: add iface_disable()
	callback to routing API
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/bat_iv_ogm.c     |    7 +++++++
 net/batman-adv/hard-interface.c |    3 +--
 net/batman-adv/main.c           |    1 +
 net/batman-adv/types.h          |    2 ++
 4 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 95bfc59..4cc66db 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
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
@@ -1175,6 +1181,7 @@ static void bat_iv_ogm_receive(struct hard_iface *if_incoming,
 static struct bat_algo_ops batman_iv __read_mostly = {
 	.name = "BATMAN IV",
 	.bat_iface_enable = bat_iv_ogm_iface_enable,
+	.bat_iface_disable = bat_iv_ogm_iface_disable,
 	.bat_ogm_init_primary = bat_iv_ogm_init_primary,
 	.bat_ogm_update_mac = bat_iv_ogm_update_mac,
 	.bat_ogm_schedule = bat_iv_ogm_schedule,
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 4d9b85d..fd9715e 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -397,8 +397,7 @@ void hardif_disable_interface(struct hard_iface *hard_iface)
 			hardif_free_ref(new_if);
 	}
 
-	kfree(hard_iface->packet_buff);
-	hard_iface->packet_buff = NULL;
+	bat_priv->bat_algo_ops->bat_iface_disable(hard_iface);
 	hard_iface->if_status = IF_NOT_IN_USE;
 
 	/* delete all references to this hard_iface */
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index ca8f395..a47a6ce 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -209,6 +209,7 @@ int bat_algo_register(struct bat_algo_ops *bat_algo_ops)
 
 	/* all algorithms must implement all ops (for now) */
 	if (!bat_algo_ops->bat_iface_enable ||
+	    !bat_algo_ops->bat_iface_disable ||
 	    !bat_algo_ops->bat_ogm_init_primary ||
 	    !bat_algo_ops->bat_ogm_update_mac ||
 	    !bat_algo_ops->bat_ogm_schedule ||
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 4b92248..b034cf2 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -379,6 +379,8 @@ struct bat_algo_ops {
 	char *name;
 	/* init routing info when hard-interface is enabled */
 	void (*bat_iface_enable)(struct hard_iface *hard_iface);
+	/* de-init routing info when hard-interface is disabled */
+	void (*bat_iface_disable)(struct hard_iface *hard_iface);
 	/* init primary OGM when primary interface is selected */
 	void (*bat_ogm_init_primary)(struct hard_iface *hard_iface);
 	/* init mac addresses of the OGM belonging to this hard-interface */
-- 
1.7.9.4


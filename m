Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 18 Apr 2012 12:00:01 +0200
Message-Id: <1334743210-12338-5-git-send-email-ordex@autistici.org>
In-Reply-To: <1334743210-12338-1-git-send-email-ordex@autistici.org>
References: <1334743210-12338-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 04/13] batman-adv: refactoring API: find
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/bat_iv_ogm.c     |    4 ++--
 net/batman-adv/hard-interface.c |    2 +-
 net/batman-adv/main.c           |    2 +-
 net/batman-adv/types.h          |    4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index fab1071..117b831 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -30,7 +30,7 @@
 #include "send.h"
 #include "bat_algo.h"
 
-static void bat_iv_ogm_init(struct hard_iface *hard_iface)
+static void bat_iv_ogm_iface_enable(struct hard_iface *hard_iface)
 {
 	struct batman_ogm_packet *batman_ogm_packet;
 
@@ -1169,7 +1169,7 @@ static void bat_iv_ogm_receive(struct hard_iface *if_incoming,
 
 static struct bat_algo_ops batman_iv __read_mostly = {
 	.name = "BATMAN IV",
-	.bat_ogm_init = bat_iv_ogm_init,
+	.bat_iface_enable = bat_iv_ogm_iface_enable,
 	.bat_ogm_init_primary = bat_iv_ogm_init_primary,
 	.bat_ogm_update_mac = bat_iv_ogm_update_mac,
 	.bat_ogm_schedule = bat_iv_ogm_schedule,
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index f152007..4d9b85d 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -312,7 +312,7 @@ int hardif_enable_interface(struct hard_iface *hard_iface,
 	hard_iface->soft_iface = soft_iface;
 	bat_priv = netdev_priv(hard_iface->soft_iface);
 
-	bat_priv->bat_algo_ops->bat_ogm_init(hard_iface);
+	bat_priv->bat_algo_ops->bat_iface_enable(hard_iface);
 
 	if (!hard_iface->packet_buff) {
 		bat_err(hard_iface->soft_iface,
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index e67ca96..ca8f395 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -208,7 +208,7 @@ int bat_algo_register(struct bat_algo_ops *bat_algo_ops)
 	}
 
 	/* all algorithms must implement all ops (for now) */
-	if (!bat_algo_ops->bat_ogm_init ||
+	if (!bat_algo_ops->bat_iface_enable ||
 	    !bat_algo_ops->bat_ogm_init_primary ||
 	    !bat_algo_ops->bat_ogm_update_mac ||
 	    !bat_algo_ops->bat_ogm_schedule ||
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index a5b1a63..4b92248 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -377,8 +377,8 @@ struct recvlist_node {
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
1.7.9.4


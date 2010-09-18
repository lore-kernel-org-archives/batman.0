Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 18 Sep 2010 21:01:22 +0200
Message-Id: <1284836482-23431-13-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1284836482-23431-1-git-send-email-sven.eckelmann@gmx.de>
References: <1284836482-23431-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 12/12] Staging: batman-adv: Introduce
	update_primary_addr to update mac address
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
Cc: b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Marek Lindner <lindner_marek@yahoo.de>

set_primary_if is currently misused to update the mac address in vis
packets. This unneeded and introduces overhead due to other operations
which must be done when updating the primary interface.

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/hard-interface.c |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/batman-adv/hard-interface.c b/drivers/staging/batman-adv/hard-interface.c
index a9d6f1d..7b77cf2 100644
--- a/drivers/staging/batman-adv/hard-interface.c
+++ b/drivers/staging/batman-adv/hard-interface.c
@@ -106,11 +106,22 @@ out:
 	return batman_if;
 }
 
+static void update_primary_addr(struct bat_priv *bat_priv)
+{
+	struct vis_packet *vis_packet;
+
+	vis_packet = (struct vis_packet *)
+				bat_priv->my_vis_info->skb_packet->data;
+	memcpy(vis_packet->vis_orig,
+	       bat_priv->primary_if->net_dev->dev_addr, ETH_ALEN);
+	memcpy(vis_packet->sender_orig,
+	       bat_priv->primary_if->net_dev->dev_addr, ETH_ALEN);
+}
+
 static void set_primary_if(struct bat_priv *bat_priv,
 			   struct batman_if *batman_if)
 {
 	struct batman_packet *batman_packet;
-	struct vis_packet *vis_packet;
 	struct batman_if *old_if;
 
 	if (batman_if)
@@ -129,12 +140,7 @@ static void set_primary_if(struct bat_priv *bat_priv,
 	batman_packet->flags = PRIMARIES_FIRST_HOP;
 	batman_packet->ttl = TTL;
 
-	vis_packet = (struct vis_packet *)
-				bat_priv->my_vis_info->skb_packet->data;
-	memcpy(vis_packet->vis_orig,
-	       bat_priv->primary_if->net_dev->dev_addr, ETH_ALEN);
-	memcpy(vis_packet->sender_orig,
-	       bat_priv->primary_if->net_dev->dev_addr, ETH_ALEN);
+	update_primary_addr(bat_priv);
 
 	/***
 	 * hacky trick to make sure that we send the HNA information via
@@ -516,7 +522,7 @@ static int hard_if_event(struct notifier_block *this,
 
 		bat_priv = netdev_priv(batman_if->soft_iface);
 		if (batman_if == bat_priv->primary_if)
-			set_primary_if(bat_priv, batman_if);
+			update_primary_addr(bat_priv);
 		break;
 	default:
 		break;
-- 
1.7.2.3


Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 27 Jun 2012 22:28:18 +0200
Message-Id: <1340828898-12352-2-git-send-email-sven@narfation.org>
In-Reply-To: <1340828898-12352-1-git-send-email-sven@narfation.org>
References: <1340828898-12352-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Don't leak information
	through initialized packet fields
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

The reserved fields in batman-adv packets are not set to a constant value. The
content of these memory regions is leaked unintentionally to the network.

This regression was introduced in c7fb529996cbc47bc8243d6860dac716ae70af82

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 soft-interface.c    |    1 +
 translation-table.c |    1 +
 vis.c               |    2 ++
 3 files changed, 4 insertions(+)

diff --git a/soft-interface.c b/soft-interface.c
index 6e2530b..80e667a 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -206,6 +206,7 @@ static int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 
 		/* batman packet type: broadcast */
 		bcast_packet->header.packet_type = BAT_BCAST;
+		bcast_packet->reserved = 0;
 
 		/* hw address of first interface is the orig mac because only
 		 * this mac is known throughout the mesh */
diff --git a/translation-table.c b/translation-table.c
index 2ab83d7..6cb4f79 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1879,6 +1879,7 @@ static void send_roam_adv(struct bat_priv *bat_priv, uint8_t *client,
 	roam_adv_packet->header.packet_type = BAT_ROAM_ADV;
 	roam_adv_packet->header.version = COMPAT_VERSION;
 	roam_adv_packet->header.ttl = TTL;
+	roam_adv_packet->reserved = 0;
 	primary_if = primary_if_get_selected(bat_priv);
 	if (!primary_if)
 		goto out;
diff --git a/vis.c b/vis.c
index cec216f..70806af 100644
--- a/vis.c
+++ b/vis.c
@@ -620,6 +620,7 @@ static int generate_vis_packet(struct bat_priv *bat_priv)
 	packet->header.ttl = TTL;
 	packet->seqno = htonl(ntohl(packet->seqno) + 1);
 	packet->entries = 0;
+	packet->reserved = 0;
 	skb_trim(info->skb_packet, sizeof(*packet));
 
 	if (packet->vis_type == VIS_TYPE_CLIENT_UPDATE) {
@@ -913,6 +914,7 @@ int vis_init(struct bat_priv *bat_priv)
 	packet->header.packet_type = BAT_VIS;
 	packet->header.ttl = TTL;
 	packet->seqno = 0;
+	packet->reserved = 0;
 	packet->entries = 0;
 
 	INIT_LIST_HEAD(&bat_priv->vis_send_list);
-- 
1.7.10


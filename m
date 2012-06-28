Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 28 Jun 2012 11:56:52 +0200
Message-Id: <1340877413-18434-1-git-send-email-sven@narfation.org>
In-Reply-To: <1340828898-12352-1-git-send-email-sven@narfation.org>
References: <1340828898-12352-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 1/1] batman-adv: Don't leak information
	through uninitialized packet fields
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
Based on next and fixed commit title

 soft-interface.c    |    1 +
 translation-table.c |    1 +
 vis.c               |    2 ++
 3 files changed, 4 insertions(+)

diff --git a/soft-interface.c b/soft-interface.c
index b7c655c..9e4bb61 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -214,6 +214,7 @@ static int batadv_interface_tx(struct sk_buff *skb,
 
 		/* batman packet type: broadcast */
 		bcast_packet->header.packet_type = BATADV_BCAST;
+		bcast_packet->reserved = 0;
 
 		/* hw address of first interface is the orig mac because only
 		 * this mac is known throughout the mesh
diff --git a/translation-table.c b/translation-table.c
index 245cc9a..a438f4b 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -2052,6 +2052,7 @@ static void batadv_send_roam_adv(struct batadv_priv *bat_priv, uint8_t *client,
 	roam_adv_packet->header.packet_type = BATADV_ROAM_ADV;
 	roam_adv_packet->header.version = BATADV_COMPAT_VERSION;
 	roam_adv_packet->header.ttl = BATADV_TTL;
+	roam_adv_packet->reserved = 0;
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 	if (!primary_if)
 		goto out;
diff --git a/vis.c b/vis.c
index f09cc9a..2a2ea06 100644
--- a/vis.c
+++ b/vis.c
@@ -589,6 +589,7 @@ static int batadv_generate_vis_packet(struct batadv_priv *bat_priv)
 	packet->header.ttl = BATADV_TTL;
 	packet->seqno = htonl(ntohl(packet->seqno) + 1);
 	packet->entries = 0;
+	packet->reserved = 0;
 	skb_trim(info->skb_packet, sizeof(*packet));
 
 	if (packet->vis_type == BATADV_VIS_TYPE_CLIENT_UPDATE) {
@@ -890,6 +891,7 @@ int batadv_vis_init(struct batadv_priv *bat_priv)
 	packet->header.packet_type = BATADV_VIS;
 	packet->header.ttl = BATADV_TTL;
 	packet->seqno = 0;
+	packet->reserved = 0;
 	packet->entries = 0;
 
 	INIT_LIST_HEAD(&bat_priv->vis_send_list);
-- 
1.7.10


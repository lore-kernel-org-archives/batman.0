Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 22 Nov 2013 13:30:26 +0100
Message-Id: <1385123427-15460-3-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1385123427-15460-1-git-send-email-sw@simonwunderlich.de>
References: <1385123427-15460-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/4] batman-adv: fix sparse warning in
	batadv_iv_ogm_emit
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Simon Wunderlich <simon@open-mesh.com>

From: Simon Wunderlich <simon@open-mesh.com>

The directlink variable is not needed anymore, and sparse complains
about that. Remove it.

Removal was introduced in 29b9256e6631876d4f1719f4d5e13d7ee140c61b
("batman-adv: consider outgoing interface in OGM sending")

Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
---
 bat_iv_ogm.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index dbd55f0..2a36de8 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -467,12 +467,10 @@ static void batadv_iv_ogm_emit(struct batadv_forw_packet *forw_packet)
 	struct batadv_priv *bat_priv;
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_ogm_packet *batadv_ogm_packet;
-	unsigned char directlink;
 	uint8_t *packet_pos;
 
 	packet_pos = forw_packet->skb->data;
 	batadv_ogm_packet = (struct batadv_ogm_packet *)packet_pos;
-	directlink = (batadv_ogm_packet->flags & BATADV_DIRECTLINK ? 1 : 0);
 
 	if (!forw_packet->if_incoming) {
 		pr_err("Error - can't forward packet: incoming iface not specified\n");
-- 
1.7.10.4


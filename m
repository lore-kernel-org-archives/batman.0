Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Sun, 24 Nov 2013 14:05:43 +0100
Message-Id: <1385298345-13746-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: fix another sparse warning
	in batadv_iv_ogm_emit
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

Since the directlink variable was not needed anymore and was removed,
more variables are now obsolete too, so remove them.

The directlink flag commit (which was obviously incomplete) was
a0fc2f129f7193cbdd7e9c2e4da0d6e7ac15dd58 ("batman-adv: fix sparse warning
in batadv_iv_ogm_emit"), which itself was a fix for
29b9256e6631876d4f1719f4d5e13d7ee140c61b ("batman-adv: consider outgoing
interface in OGM sending").

Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
---
 bat_iv_ogm.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 92165cb..b9aec98 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -466,11 +466,6 @@ static void batadv_iv_ogm_emit(struct batadv_forw_packet *forw_packet)
 	struct net_device *soft_iface;
 	struct batadv_priv *bat_priv;
 	struct batadv_hard_iface *primary_if = NULL;
-	struct batadv_ogm_packet *batadv_ogm_packet;
-	uint8_t *packet_pos;
-
-	packet_pos = forw_packet->skb->data;
-	batadv_ogm_packet = (struct batadv_ogm_packet *)packet_pos;
 
 	if (!forw_packet->if_incoming) {
 		pr_err("Error - can't forward packet: incoming iface not specified\n");
-- 
1.7.10.4


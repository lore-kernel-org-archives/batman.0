Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 23 Jul 2012 14:59:13 +0200
Message-Id: <1343048353-23456-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: select an internet gateway if
	none was chosen
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

This is a regression introduced by: 6a17ecc4603be7f065c38b288d038a0082bbf21d

Reported-by: Nicolás Echániz <nicoechaniz@codigosur.org>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---

This patch is intended for next and needs to be backported for stable.

 gateway_client.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/gateway_client.c b/gateway_client.c
index b421cc4..fc866f2 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -200,11 +200,11 @@ void batadv_gw_election(struct batadv_priv *bat_priv)
 	if (atomic_read(&bat_priv->gw_mode) != BATADV_GW_MODE_CLIENT)
 		goto out;
 
-	if (!batadv_atomic_dec_not_zero(&bat_priv->gw_reselect))
-		goto out;
-
 	curr_gw = batadv_gw_get_selected_gw_node(bat_priv);
 
+	if (!batadv_atomic_dec_not_zero(&bat_priv->gw_reselect) && curr_gw)
+		goto out;
+
 	next_gw = batadv_gw_get_best_gw_node(bat_priv);
 
 	if (curr_gw == next_gw)
-- 
1.7.9.1


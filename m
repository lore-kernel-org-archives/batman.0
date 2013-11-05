Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue,  5 Nov 2013 10:02:31 +0100
Message-Id: <1383642151-2222-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix multi-line comment
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

Introduced by 99a6eb50ef5066e125cedb97bc0fcfcdff4f08cc
("batman-adv: deselect current GW on client mode switch off")

Reported-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 gateway_client.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/gateway_client.c b/gateway_client.c
index dca73bb..2d23c82 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -224,7 +224,8 @@ void batadv_gw_check_client_stop(struct batadv_priv *bat_priv)
 		return;
 
 	/* deselect the current gateway so that next time that client mode is
-	 * enabled a proper GW_ADD event can be sent */
+	 * enabled a proper GW_ADD event can be sent
+	 */
 	batadv_gw_select(bat_priv, NULL);
 
 	/* if batman-adv is switching the gw client mode off and a gateway was
-- 
1.8.4.2


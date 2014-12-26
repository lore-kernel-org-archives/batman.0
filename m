Return-Path: <mpa@pengutronix.de>
From: Markus Pargmann <mpa@pengutronix.de>
Date: Fri, 26 Dec 2014 12:41:26 +0100
Message-Id: <1419594103-10928-10-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
References: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
Subject: [B.A.T.M.A.N.] [PATCH v2 09/26] batman-adv: iv_ogm_iface_enable,
	direct return values
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
To: Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <antonio@meshcoding.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>

Directly return error values. No need to use a return variable.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 bat_iv_ogm.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 20295c5e5121..92eeed406663 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -310,7 +310,6 @@ static int batadv_iv_ogm_iface_enable(struct batadv_hard_iface *hard_iface)
 	struct batadv_ogm_packet *batadv_ogm_packet;
 	unsigned char *ogm_buff;
 	uint32_t random_seqno;
-	int res = -ENOMEM;
 
 	/* randomize initial seqno to avoid collision */
 	get_random_bytes(&random_seqno, sizeof(random_seqno));
@@ -319,7 +318,7 @@ static int batadv_iv_ogm_iface_enable(struct batadv_hard_iface *hard_iface)
 	hard_iface->bat_iv.ogm_buff_len = BATADV_OGM_HLEN;
 	ogm_buff = kmalloc(hard_iface->bat_iv.ogm_buff_len, GFP_ATOMIC);
 	if (!ogm_buff)
-		goto out;
+		return -ENOMEM;
 
 	hard_iface->bat_iv.ogm_buff = ogm_buff;
 
@@ -331,10 +330,7 @@ static int batadv_iv_ogm_iface_enable(struct batadv_hard_iface *hard_iface)
 	batadv_ogm_packet->reserved = 0;
 	batadv_ogm_packet->tq = BATADV_TQ_MAX_VALUE;
 
-	res = 0;
-
-out:
-	return res;
+	return 0;
 }
 
 static void batadv_iv_ogm_iface_disable(struct batadv_hard_iface *hard_iface)
-- 
2.1.3


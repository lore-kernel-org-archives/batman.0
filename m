Return-Path: <mpa@pengutronix.de>
From: Markus Pargmann <mpa@pengutronix.de>
Date: Fri, 26 Dec 2014 12:41:27 +0100
Message-Id: <1419594103-10928-11-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
References: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
Subject: [B.A.T.M.A.N.] [PATCH v2 10/26] batman-adv: iv_ogm_aggr_packet,
	bool return value
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

This function returns bool values, so it should be defined to return
them instead of the whole int range.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 bat_iv_ogm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 92eeed406663..b267afab65bb 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -394,8 +394,8 @@ static uint8_t batadv_hop_penalty(uint8_t tq,
 }
 
 /* is there another aggregated packet here? */
-static int batadv_iv_ogm_aggr_packet(int buff_pos, int packet_len,
-				     __be16 tvlv_len)
+static bool batadv_iv_ogm_aggr_packet(int buff_pos, int packet_len,
+				      __be16 tvlv_len)
 {
 	int next_buff_pos = 0;
 
-- 
2.1.3


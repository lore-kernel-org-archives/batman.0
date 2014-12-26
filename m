Return-Path: <mpa@pengutronix.de>
From: Markus Pargmann <mpa@pengutronix.de>
Date: Fri, 26 Dec 2014 12:41:35 +0100
Message-Id: <1419594103-10928-19-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
References: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
Subject: [B.A.T.M.A.N.] [PATCH v2 18/26] batman-adv: iv_ogm, fix coding style
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

The kernel coding style says, that there should not be multiple
assignments in one row.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 bat_iv_ogm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index ab48865130b0..39ec3eeec41f 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -66,7 +66,9 @@ static void batadv_ring_buffer_set(uint8_t lq_recv[], uint8_t *lq_index,
 static uint8_t batadv_ring_buffer_avg(const uint8_t lq_recv[])
 {
 	const uint8_t *ptr;
-	uint16_t count = 0, i = 0, sum = 0;
+	uint16_t count = 0;
+	uint16_t i = 0;
+	uint16_t sum = 0;
 
 	ptr = lq_recv;
 
-- 
2.1.3


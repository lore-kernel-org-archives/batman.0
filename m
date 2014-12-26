Return-Path: <mpa@pengutronix.de>
From: Markus Pargmann <mpa@pengutronix.de>
Date: Fri, 26 Dec 2014 12:41:36 +0100
Message-Id: <1419594103-10928-20-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
References: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
Subject: [B.A.T.M.A.N.] [PATCH v2 19/26] batman-adv: iv_ogm,
	fix comment function name
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

This is a small copy paste fix for batadv_ing_buffer_avg.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 bat_iv_ogm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 39ec3eeec41f..b613ef74b9e0 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -57,7 +57,7 @@ static void batadv_ring_buffer_set(uint8_t lq_recv[], uint8_t *lq_index,
 }
 
 /**
- * batadv_ring_buffer_set - compute the average of all non-zero values stored
+ * batadv_ring_buffer_avg - compute the average of all non-zero values stored
  * in the given ring buffer
  * @lq_recv: pointer to the ring buffer
  *
-- 
2.1.3


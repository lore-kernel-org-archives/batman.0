Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Fri, 29 May 2015 11:05:20 +0200
Message-Id: <1432890328-8247-9-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1432890328-8247-1-git-send-email-antonio@meshcoding.com>
References: <1432890328-8247-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 08/16] batman-adv: iv_ogm_iface_enable,
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@meshcoding.com>

From: Markus Pargmann <mpa@pengutronix.de>

Directly return error values. No need to use a return variable.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/bat_iv_ogm.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index fc299c0..123aabb 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -308,7 +308,6 @@ static int batadv_iv_ogm_iface_enable(struct batadv_hard_iface *hard_iface)
 	struct batadv_ogm_packet *batadv_ogm_packet;
 	unsigned char *ogm_buff;
 	uint32_t random_seqno;
-	int res = -ENOMEM;
 
 	/* randomize initial seqno to avoid collision */
 	get_random_bytes(&random_seqno, sizeof(random_seqno));
@@ -317,7 +316,7 @@ static int batadv_iv_ogm_iface_enable(struct batadv_hard_iface *hard_iface)
 	hard_iface->bat_iv.ogm_buff_len = BATADV_OGM_HLEN;
 	ogm_buff = kmalloc(hard_iface->bat_iv.ogm_buff_len, GFP_ATOMIC);
 	if (!ogm_buff)
-		goto out;
+		return -ENOMEM;
 
 	hard_iface->bat_iv.ogm_buff = ogm_buff;
 
@@ -329,10 +328,7 @@ static int batadv_iv_ogm_iface_enable(struct batadv_hard_iface *hard_iface)
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
2.4.2


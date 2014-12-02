Return-Path: <mpa@pengutronix.de>
From: Markus Pargmann <mpa@pengutronix.de>
Date: Tue,  2 Dec 2014 12:16:38 +0100
Message-Id: <1417519009-20699-21-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1417519009-20699-1-git-send-email-mpa@pengutronix.de>
References: <1417519009-20699-1-git-send-email-mpa@pengutronix.de>
Subject: [B.A.T.M.A.N.] [PATCH 20/31] batman-adv: iv_ogm_queue_add,
	Simplify expressions
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
Cc: b.a.t.m.a.n@lists.open-mesh.org

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 bat_iv_ogm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 1f3ed3173005..9482a0889201 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -750,13 +750,13 @@ static void batadv_iv_ogm_queue_add(struct batadv_priv *bat_priv,
 	unsigned long max_aggregation_jiffies;
 
 	batadv_ogm_packet = (struct batadv_ogm_packet *)packet_buff;
-	direct_link = batadv_ogm_packet->flags & BATADV_DIRECTLINK ? 1 : 0;
+	direct_link = !!(batadv_ogm_packet->flags & BATADV_DIRECTLINK);
 	max_aggregation_jiffies = msecs_to_jiffies(BATADV_MAX_AGGREGATION_MS);
 
 	/* find position for the packet in the forward queue */
 	spin_lock_bh(&bat_priv->forw_bat_list_lock);
 	/* own packets are not to be aggregated */
-	if ((atomic_read(&bat_priv->aggregated_ogms)) && (!own_packet)) {
+	if (atomic_read(&bat_priv->aggregated_ogms) && !own_packet) {
 		hlist_for_each_entry(forw_packet_pos,
 				     &bat_priv->forw_bat_list, list) {
 			if (batadv_iv_ogm_can_aggregate(batadv_ogm_packet,
-- 
2.1.3


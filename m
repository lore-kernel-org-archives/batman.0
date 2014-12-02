Return-Path: <mpa@pengutronix.de>
From: Markus Pargmann <mpa@pengutronix.de>
Date: Tue,  2 Dec 2014 12:16:35 +0100
Message-Id: <1417519009-20699-18-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1417519009-20699-1-git-send-email-mpa@pengutronix.de>
References: <1417519009-20699-1-git-send-email-mpa@pengutronix.de>
Subject: [B.A.T.M.A.N.] [PATCH 17/31] batman-adv: iv_ogm_can_aggregate,
	code readability
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

This patch tries to increase code readability by negating the first if
block and rearranging some of the other conditional blocks. This way we
save an indentation level, we also save some allocation that is not
necessary for one of the conditions.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 bat_iv_ogm.c | 98 +++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 50 insertions(+), 48 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 8ebbd2eb81ee..f8fd535dbdc9 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -546,58 +546,60 @@ batadv_iv_ogm_can_aggregate(const struct batadv_ogm_packet *new_bat_ogm_packet,
 	 * - the send time is within our MAX_AGGREGATION_MS time
 	 * - the resulting packet wont be bigger than
 	 *   MAX_AGGREGATION_BYTES
+	 * otherwise aggregation is not possible
 	 */
-	if (time_before(send_time, forw_packet->send_time) &&
-	    time_after_eq(aggregation_end_time, forw_packet->send_time) &&
-	    (aggregated_bytes <= BATADV_MAX_AGGREGATION_BYTES)) {
-		/* check aggregation compatibility
-		 * -> direct link packets are broadcasted on
-		 *    their interface only
-		 * -> aggregate packet if the current packet is
-		 *    a "global" packet as well as the base
-		 *    packet
-		 */
-		primary_if = batadv_primary_if_get_selected(bat_priv);
-		if (!primary_if)
-			goto out;
+	if (!time_before(send_time, forw_packet->send_time) ||
+	    !time_after_eq(aggregation_end_time, forw_packet->send_time) ||
+	    aggregated_bytes > BATADV_MAX_AGGREGATION_BYTES)
+		return false;
 
-		/* packet is not leaving on the same interface. */
-		if (forw_packet->if_outgoing != if_outgoing)
-			goto out;
+	/* packet is not leaving on the same interface. */
+	if (forw_packet->if_outgoing != if_outgoing)
+		return false;
 
-		/* packets without direct link flag and high TTL
-		 * are flooded through the net
-		 */
-		if ((!directlink) &&
-		    (!(batadv_ogm_packet->flags & BATADV_DIRECTLINK)) &&
-		    (batadv_ogm_packet->ttl != 1) &&
-
-		    /* own packets originating non-primary
-		     * interfaces leave only that interface
-		     */
-		    ((!forw_packet->own) ||
-		     (forw_packet->if_incoming == primary_if))) {
-			res = true;
-			goto out;
-		}
+	/* check aggregation compatibility
+	 * -> direct link packets are broadcasted on
+	 *    their interface only
+	 * -> aggregate packet if the current packet is
+	 *    a "global" packet as well as the base
+	 *    packet
+	 */
+	primary_if = batadv_primary_if_get_selected(bat_priv);
+	if (!primary_if)
+		return false;
 
-		/* if the incoming packet is sent via this one
-		 * interface only - we still can aggregate
-		 */
-		if ((directlink) &&
-		    (new_bat_ogm_packet->ttl == 1) &&
-		    (forw_packet->if_incoming == if_incoming) &&
-
-		    /* packets from direct neighbors or
-		     * own secondary interface packets
-		     * (= secondary interface packets in general)
-		     */
-		    (batadv_ogm_packet->flags & BATADV_DIRECTLINK ||
-		     (forw_packet->own &&
-		      forw_packet->if_incoming != primary_if))) {
-			res = true;
-			goto out;
-		}
+	/* packets without direct link flag and high TTL
+	 * are flooded through the net
+	 */
+	if (!directlink &&
+	    !(batadv_ogm_packet->flags & BATADV_DIRECTLINK) &&
+	    batadv_ogm_packet->ttl != 1 &&
+
+	    /* own packets originating non-primary
+	     * interfaces leave only that interface
+	     */
+	    (!forw_packet->own ||
+	     forw_packet->if_incoming == primary_if)) {
+		res = true;
+		goto out;
+	}
+
+	/* if the incoming packet is sent via this one
+	 * interface only - we still can aggregate
+	 */
+	if (directlink &&
+	    new_bat_ogm_packet->ttl == 1 &&
+	    forw_packet->if_incoming == if_incoming &&
+
+	    /* packets from direct neighbors or
+	     * own secondary interface packets
+	     * (= secondary interface packets in general)
+	     */
+	    (batadv_ogm_packet->flags & BATADV_DIRECTLINK ||
+	     (forw_packet->own &&
+	      forw_packet->if_incoming != primary_if))) {
+		res = true;
+		goto out;
 	}
 
 out:
-- 
2.1.3


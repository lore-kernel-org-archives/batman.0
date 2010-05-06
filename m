Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Thu,  6 May 2010 22:18:30 +0200
Message-Id: <1273177132-8792-5-git-send-email-andrew@lunn.ch>
In-Reply-To: <1273177132-8792-1-git-send-email-andrew@lunn.ch>
References: <1273177132-8792-1-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 04/26] staging:batman-adv: Fix aggregation
	direct-link bug
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: gregkh@suse.de
Cc: b.a.t.m.a.n@lists.open-mesh.net

From: Linus Lüssing <linus.luessing@web.de>

So far, neighbour's secondary interface OGMs can involuntarily
piggyback on primary interface OGMs that arrived on the same secondary
interface before. Secondary interface OGMs should NEVER leave their
direct neighbour broadcast domain! This patch ensures that secondary
interface OGMs can only be aggregated to other secondary interface OGMs.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/staging/batman-adv/aggregation.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/batman-adv/aggregation.c b/drivers/staging/batman-adv/aggregation.c
index d25e5a8..e1bd321 100644
--- a/drivers/staging/batman-adv/aggregation.c
+++ b/drivers/staging/batman-adv/aggregation.c
@@ -81,9 +81,15 @@ static bool can_aggregate_with(struct batman_packet *new_batman_packet,
 		 * interface only - we still can aggregate */
 		if ((directlink) &&
 		    (new_batman_packet->ttl == 1) &&
-		    (forw_packet->if_incoming == if_incoming))
+		    (forw_packet->if_incoming == if_incoming) &&
+
+		    /* packets from direct neighbors or
+		     * own secondary interface packets
+		     * (= secondary interface packets in general) */
+		    (batman_packet->flags & DIRECTLINK ||
+		     (forw_packet->own &&
+		      forw_packet->if_incoming->if_num != 0)))
 			return true;
-
 	}
 
 	return false;
@@ -204,7 +210,7 @@ void add_bat_packet_to_list(unsigned char *packet_buff, int packet_len,
 		 * later on
 		 */
 		if ((!own_packet) &&
-		    (atomic_read(&bat_priv->aggregation_enabled)))
+		    (atomic_read(&aggregation_enabled)))
 			send_time += msecs_to_jiffies(MAX_AGGREGATION_MS);
 
 		new_aggregated_packet(packet_buff, packet_len,
-- 
1.7.1


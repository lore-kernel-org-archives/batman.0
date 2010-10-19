Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 19 Oct 2010 11:59:14 +0200
Message-Id: <1287482355-16319-7-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1287482355-16319-1-git-send-email-sven.eckelmann@gmx.de>
References: <1287482355-16319-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 6/7] Staging: batman-adv: fix crash when new
	OGM is generated
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
To: greg@kroah.com
Cc: b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Marek Lindner <lindner_marek@yahoo.de>

If aggregation is not enabled the local translation table can grow
much bigger and expects to fill a full ethernet packet.

Reported-by: Sam Yeung <sam.cwyeung@gmail.com>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/aggregation.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/batman-adv/aggregation.c b/drivers/staging/batman-adv/aggregation.c
index 46b9c2b..16b268e 100644
--- a/drivers/staging/batman-adv/aggregation.c
+++ b/drivers/staging/batman-adv/aggregation.c
@@ -123,8 +123,14 @@ static void new_aggregated_packet(unsigned char *packet_buff, int packet_len,
 		return;
 	}
 
-	forw_packet_aggr->skb = dev_alloc_skb(MAX_AGGREGATION_BYTES +
-					      sizeof(struct ethhdr));
+	if ((atomic_read(&bat_priv->aggregation_enabled)) &&
+	    (packet_len < MAX_AGGREGATION_BYTES))
+		forw_packet_aggr->skb = dev_alloc_skb(MAX_AGGREGATION_BYTES +
+						      sizeof(struct ethhdr));
+	else
+		forw_packet_aggr->skb = dev_alloc_skb(packet_len +
+						      sizeof(struct ethhdr));
+
 	if (!forw_packet_aggr->skb) {
 		if (!own_packet)
 			atomic_inc(&bat_priv->batman_queue_left);
-- 
1.7.2.3


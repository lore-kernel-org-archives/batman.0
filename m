Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Fri,  7 May 2010 21:47:08 +0200
Message-Id: <1273261651-21378-4-git-send-email-andrew@lunn.ch>
In-Reply-To: <1273261651-21378-1-git-send-email-andrew@lunn.ch>
References: <1273261651-21378-1-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 03/26] Staging: batman-adv: fix aggregation
	timing bug
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
Cc: Marek Lindner <lindner_marek@yahoo.de>, b.a.t.m.a.n@lists.open-mesh.net

From: Marek Lindner <lindner_marek@yahoo.de>

batman-adv aggregates routing packets to reduce the number of packets in
the air. Every outgoing packet is compared with other packets in the
buffer to determine whether it can be aggregated or not. Packets sent
at a lower interval can be held back longer to maximize the aggregation.
Due to insufficient checking batman-adv held back all packets for a
certain time depending on its own lowest interval rate which slowed
down all other nodes.

Reported-by: Linus Lüssing <linus.luessing@web.de>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/staging/batman-adv/aggregation.c |   12 ++++++++++++
 drivers/staging/batman-adv/send.c        |   10 +---------
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/batman-adv/aggregation.c b/drivers/staging/batman-adv/aggregation.c
index 7917322..d25e5a8 100644
--- a/drivers/staging/batman-adv/aggregation.c
+++ b/drivers/staging/batman-adv/aggregation.c
@@ -52,6 +52,8 @@ static bool can_aggregate_with(struct batman_packet *new_batman_packet,
 	 */
 
 	if (time_before(send_time, forw_packet->send_time) &&
+	    time_after_eq(send_time + msecs_to_jiffies(MAX_AGGREGATION_MS),
+					forw_packet->send_time) &&
 	    (aggregated_bytes <= MAX_AGGREGATION_BYTES)) {
 
 		/**
@@ -195,6 +197,16 @@ void add_bat_packet_to_list(unsigned char *packet_buff, int packet_len,
 	if (forw_packet_aggr == NULL) {
 		/* the following section can run without the lock */
 		spin_unlock_irqrestore(&forw_bat_list_lock, flags);
+
+		/**
+		 * if we could not aggregate this packet with one of the others
+		 * we hold it back for a while, so that it might be aggregated
+		 * later on
+		 */
+		if ((!own_packet) &&
+		    (atomic_read(&bat_priv->aggregation_enabled)))
+			send_time += msecs_to_jiffies(MAX_AGGREGATION_MS);
+
 		new_aggregated_packet(packet_buff, packet_len,
 				      send_time, direct_link,
 				      if_incoming, own_packet);
diff --git a/drivers/staging/batman-adv/send.c b/drivers/staging/batman-adv/send.c
index ff7b1f1..d356ce7 100644
--- a/drivers/staging/batman-adv/send.c
+++ b/drivers/staging/batman-adv/send.c
@@ -46,15 +46,7 @@ static unsigned long own_send_time(void)
 /* when do we schedule a forwarded packet to be sent */
 static unsigned long forward_send_time(void)
 {
-	unsigned long send_time = jiffies; /* Starting now plus... */
-
-	if (atomic_read(&aggregation_enabled))
-		send_time += (((MAX_AGGREGATION_MS - (JITTER/2) +
-				(random32() % JITTER)) * HZ) / 1000);
-	else
-		send_time += (((random32() % (JITTER/2)) * HZ) / 1000);
-
-	return send_time;
+	return jiffies + (((random32() % (JITTER/2)) * HZ) / 1000);
 }
 
 /* send out an already prepared packet to the given address via the
-- 
1.7.1


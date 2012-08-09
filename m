Return-Path: <montik@autistici.org>
From: Edo Monticelli <montik@autistici.org>
Date: Thu,  9 Aug 2012 14:15:25 +0200
Message-Id: <1344514526-30256-3-git-send-email-montik@autistici.org>
In-Reply-To: <1344514526-30256-1-git-send-email-montik@autistici.org>
References: <1344514526-30256-1-git-send-email-montik@autistici.org>
Subject: [B.A.T.M.A.N.] [RFC 2/3] batman-adv: sender retransmission counter
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
To: b.a.t.m.a.n@lists.open-mesh.org

Added a sender-side counter of the number of retransmission of the *same window*,
defaults to BATADV_BW_MAX_SENDER_RETRANSMISSIONS. After them, test is aborted.

Signed-off-by: Edo Monticelli <montik@autistici.org>
---
 bw_meter.c |   18 +++++++++++++++---
 types.h    |    2 ++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/bw_meter.c b/bw_meter.c
index b5a67d3..b582ab0 100644
--- a/bw_meter.c
+++ b/bw_meter.c
@@ -389,20 +389,31 @@ static void batadv_bw_sender_worker(struct work_struct *work)
 
 	/* if timedout, resend whole window */
 	if (batadv_has_timed_out(bw_vars->last_sent_time, BATADV_BW_TIMEOUT)) {
+		/* increase resend counters */
+		if (bw_vars->window_first == bw_vars->last_resent_window) {
+			bw_vars->retry_number += 1;
+			if (bw_vars->retry_number > BATADV_BW_MAX_RETRY) {
+				bw_vars->window_first = BATADV_BW_TOTAL_TO_SEND;
+				bw_vars->status = ABORTING;
+			}
+		} else {
+			bw_vars->retry_number = 0;
+		}
+
 		pr_info("RESENDING WHOLE WINDOW %d\n", bw_vars->window_first);
+		bw_vars->last_resent_window = bw_vars->window_first;
 		bw_vars->next_to_send = bw_vars->window_first;
 		batadv_bw_multiple_send(bat_priv, bw_vars);
 	}
 
+	/* if not finished, re-enqueue worker */
 	if (bw_vars->window_first < bw_vars->total_to_send) {
-		/* if not finished, re-enqueue worker */
 		if (batadv_bw_queue_sender_worker(bw_vars) == 0) {
 			batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 				   "Meter: batadv_bw_start work already enqueued\n");
 		}
-
+	/* send the answer to batctl */
 	} else {
-		/* send the answer to batctl */
 		icmp_packet_rr = kmalloc(sizeof(*icmp_packet_rr), GFP_ATOMIC);
 		icmp_packet_rr->uid = bw_vars->socket_client->index;
 		result = (struct batadv_bw_result *)icmp_packet_rr;
@@ -492,6 +503,7 @@ void batadv_bw_start(struct batadv_socket_client *socket_client,
 	bw_vars->total_to_send = BATADV_BW_TOTAL_TO_SEND;
 	bw_vars->next_to_send = 0;
 	bw_vars->window_first = 0;
+	bw_vars->last_resent_window = 0;
 	bw_vars->bat_priv = bat_priv;
 	bw_vars->socket_client = socket_client;
 	bw_vars->last_sent_time = jiffies;
diff --git a/types.h b/types.h
index 813914c..e5ba150 100644
--- a/types.h
+++ b/types.h
@@ -253,6 +253,8 @@ struct batadv_bw_vars {
 	uint8_t status; /* see bm_meter_status */
 	unsigned long start_time;
 	unsigned long last_sent_time;
+	uint8_t retry_number;
+	uint16_t last_resent_window;
 };
 
 struct batadv_priv {
-- 
1.7.8.6


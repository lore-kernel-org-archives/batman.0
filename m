Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat,  4 Aug 2018 21:48:50 +0800
Message-Id: <20180804134854.4075-4-mareklindner@neomailbox.ch>
In-Reply-To: <20180804134854.4075-1-mareklindner@neomailbox.ch>
References: <20180804134854.4075-1-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [PATCH v3 3/7] batman-adv: tp_meter - allow up to 10
 queued sessions
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 net/batman-adv/main.h     | 6 ++++--
 net/batman-adv/tp_meter.c | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 8da3c933..89dfaf87 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -137,9 +137,11 @@
 #define BATADV_NC_NODE_TIMEOUT 10000 /* Milliseconds */
 
 /**
- * BATADV_TP_MAX_NUM - maximum number of simultaneously active tp sessions
+ * BATADV_TP_MAX_NUM_QUEUE - maximum number of queued (outgoing) tp sessions
+ * BATADV_TP_MAX_NUM_RECV - maximum number of simultaneous receiving streams
  */
-#define BATADV_TP_MAX_NUM 5
+#define BATADV_TP_MAX_NUM_QUEUE 10
+#define BATADV_TP_MAX_NUM_RECV 1
 
 /**
  * enum batadv_mesh_state - State of a soft interface
diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index a416c36d..e89d3942 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -939,7 +939,7 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 	session_cookie = batadv_tp_session_cookie(session_id, icmp_uid);
 	*cookie = session_cookie;
 
-	if (!atomic_add_unless(&bat_priv->tp_num, 1, BATADV_TP_MAX_NUM)) {
+	if (!atomic_add_unless(&bat_priv->tp_num, 1, BATADV_TP_MAX_NUM_QUEUE)) {
 		batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 			   "Meter: too many ongoing sessions, aborting (SEND)\n");
 		batadv_tp_batctl_error_notify(BATADV_TP_REASON_TOO_MANY, dst,
@@ -1313,7 +1313,7 @@ batadv_tp_init_recv(struct batadv_priv *bat_priv,
 	if (tp_vars)
 		goto out_unlock;
 
-	if (!atomic_add_unless(&bat_priv->tp_num, 1, BATADV_TP_MAX_NUM)) {
+	if (!atomic_add_unless(&bat_priv->tp_num, 1, BATADV_TP_MAX_NUM_RECV)) {
 		batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 			   "Meter: too many ongoing sessions, aborting (RECV)\n");
 		goto out_unlock;
-- 
2.18.0


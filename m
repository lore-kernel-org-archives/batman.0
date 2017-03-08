Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed,  8 Mar 2017 12:43:59 +0100
Message-Id: <20170308114359.26916-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Use __func__ to add function
	names to messages
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

The name of the function might change in which these messages are printed.
It is therefore better to let the compiler handle the insertion of the
correct function name.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index c94ebde..556f9a8 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -873,8 +873,8 @@ static int batadv_tp_send(void *arg)
 		/* something went wrong during the preparation/transmission */
 		if (unlikely(err && err != BATADV_TP_REASON_CANT_SEND)) {
 			batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
-				   "Meter: batadv_tp_send() cannot send packets (%d)\n",
-				   err);
+				   "Meter: %s() cannot send packets (%d)\n",
+				   __func__, err);
 			/* ensure nobody else tries to stop the thread now */
 			if (atomic_dec_and_test(&tp_vars->sending))
 				tp_vars->reason = err;
@@ -979,7 +979,8 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 	if (!tp_vars) {
 		spin_unlock_bh(&bat_priv->tp_list_lock);
 		batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
-			   "Meter: batadv_tp_start cannot allocate list elements\n");
+			   "Meter: %s cannot allocate list elements\n",
+			   __func__);
 		batadv_tp_batctl_error_notify(BATADV_TP_REASON_MEMORY_ERROR,
 					      dst, bat_priv, session_cookie);
 		return;
-- 
2.11.0


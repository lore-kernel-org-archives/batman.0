Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed,  9 May 2018 00:41:26 +0800
Message-Id: <20180508164130.8633-3-mareklindner@neomailbox.ch>
In-Reply-To: <20180508164130.8633-1-mareklindner@neomailbox.ch>
References: <20180508164130.8633-1-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [RFC 2/6] batman-adv: tp_meter - don't check for
 existing session
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
Cc: Antonio Quartulli <a@unstable.cc>

From: Antonio Quartulli <a@unstable.cc>

Since the conversion from kthread to queue worker it is not possible
to run more than one "sender" session at a time.
For this reason, checking if another session to the same destination
is already scheduled is not useful anymore.

Remove such check and allow the user to enqueue a new session to
a previously targeted node.

Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/tp_meter.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 55e93abc..d91d371d 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -939,21 +939,7 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 	session_cookie = batadv_tp_session_cookie(session_id, icmp_uid);
 	*cookie = session_cookie;
 
-	/* look for an already existing test towards this node */
-	spin_lock_bh(&bat_priv->tp_list_lock);
-	tp_vars = batadv_tp_list_find(bat_priv, dst);
-	if (tp_vars) {
-		spin_unlock_bh(&bat_priv->tp_list_lock);
-		batadv_tp_vars_put(tp_vars);
-		batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
-			   "Meter: test to or from the same node already ongoing, aborting\n");
-		batadv_tp_batctl_error_notify(BATADV_TP_REASON_ALREADY_ONGOING,
-					      dst, bat_priv, session_cookie);
-		return;
-	}
-
 	if (!atomic_add_unless(&bat_priv->tp_num, 1, BATADV_TP_MAX_NUM)) {
-		spin_unlock_bh(&bat_priv->tp_list_lock);
 		batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 			   "Meter: too many ongoing sessions, aborting (SEND)\n");
 		batadv_tp_batctl_error_notify(BATADV_TP_REASON_TOO_MANY, dst,
@@ -963,7 +949,6 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 
 	tp_vars = kmalloc(sizeof(*tp_vars), GFP_ATOMIC);
 	if (!tp_vars) {
-		spin_unlock_bh(&bat_priv->tp_list_lock);
 		batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 			   "Meter: %s cannot allocate list elements\n",
 			   __func__);
@@ -1021,6 +1006,7 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 	spin_lock_init(&tp_vars->prerandom_lock);
 
 	kref_get(&tp_vars->refcount);
+	spin_lock_bh(&bat_priv->tp_list_lock);
 	hlist_add_head_rcu(&tp_vars->list, &bat_priv->tp_list);
 	spin_unlock_bh(&bat_priv->tp_list_lock);
 
-- 
2.17.0


Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 16 Apr 2013 12:46:29 +0200
Message-Id: <1366109189-17384-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1366109189-17384-1-git-send-email-ordex@autistici.org>
References: <1366109189-17384-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv2 2/2] batman-adv: schedule global entry
	removal earlier
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
Cc: Marek Lindner <lindner_marek@yahoo.de>, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

Instead of scheduling the global entry removals in
batadv_orig_node_free_rcu() (which would result in
scheduling other RCU callbacks for the next RCU period),
do it in batadv_orig_node_free_ref() directly.

In this way all the callbacks get scheduled in one RCU
period.

CC: Linus Lüssing <linus.luessing@web.de>
CC: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
CC: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 originator.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/originator.c b/originator.c
index f50553a..2de5d4f 100644
--- a/originator.c
+++ b/originator.c
@@ -147,8 +147,6 @@ static void batadv_orig_node_free_rcu(struct rcu_head *rcu)
 	batadv_nc_purge_orig(orig_node->bat_priv, orig_node, NULL);
 
 	batadv_frag_list_free(&orig_node->frag_list);
-	batadv_tt_global_del_orig(orig_node->bat_priv, orig_node,
-				  "originator timed out");
 
 	kfree(orig_node->tt_buff);
 	kfree(orig_node->bcast_own);
@@ -160,11 +158,19 @@ static void batadv_orig_node_free_rcu(struct rcu_head *rcu)
  * batadv_orig_node_free_ref - decrement the orig node refcounter and possibly
  * schedule an rcu callback for freeing it
  * @orig_node: the orig node to free
+ *
+ * Decrement the refcounter and perform the following operations when it reaches
+ * zero:
+ * - remove the reference from any global entry served by this originator
+ * - schedule an RCU callback to free the orig_node
  */
 void batadv_orig_node_free_ref(struct batadv_orig_node *orig_node)
 {
-	if (atomic_dec_and_test(&orig_node->refcount))
+	if (atomic_dec_and_test(&orig_node->refcount)) {
+		batadv_tt_global_del_orig(orig_node->bat_priv, orig_node,
+					  "originator timed out");
 		call_rcu(&orig_node->rcu, batadv_orig_node_free_rcu);
+	}
 }
 
 /**
-- 
1.8.1.5


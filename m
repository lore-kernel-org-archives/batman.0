Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 25 Aug 2015 13:02:29 +0200
Message-Id: <1440500559-28368-6-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1440500559-28368-1-git-send-email-antonio@meshcoding.com>
References: <1440500559-28368-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 05/15] batman-adv: rename
	batadv_new_tt_req_node to batadv_tt_req_node_new
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@meshcoding.com>

From: Marek Lindner <mareklindner@neomailbox.ch>

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/translation-table.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 6b5f718..3932df2 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -2272,11 +2272,16 @@ static void batadv_tt_req_purge(struct batadv_priv *bat_priv)
 	spin_unlock_bh(&bat_priv->tt.req_list_lock);
 }
 
-/* returns the pointer to the new tt_req_node struct if no request
- * has already been issued for this orig_node, NULL otherwise
+/**
+ * batadv_tt_req_node_new - search and possibly create a tt_req_node object
+ * @bat_priv: the bat priv with all the soft interface information
+ * @orig_node: orig node this request is being issued for
+ *
+ * Returns the pointer to the new tt_req_node struct if no request
+ * has already been issued for this orig_node, NULL otherwise.
  */
 static struct batadv_tt_req_node *
-batadv_new_tt_req_node(struct batadv_priv *bat_priv,
+batadv_tt_req_node_new(struct batadv_priv *bat_priv,
 		       struct batadv_orig_node *orig_node)
 {
 	struct batadv_tt_req_node *tt_req_node_tmp, *tt_req_node = NULL;
@@ -2505,7 +2510,7 @@ static int batadv_send_tt_request(struct batadv_priv *bat_priv,
 	/* The new tt_req will be issued only if I'm not waiting for a
 	 * reply from the same orig_node yet
 	 */
-	tt_req_node = batadv_new_tt_req_node(bat_priv, dst_orig_node);
+	tt_req_node = batadv_tt_req_node_new(bat_priv, dst_orig_node);
 	if (!tt_req_node)
 		goto out;
 
-- 
2.5.0


Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 17 Apr 2011 21:30:12 +0200
Message-Id: <1303068618-27928-3-git-send-email-sven@narfation.org>
In-Reply-To: <1303068618-27928-1-git-send-email-sven@narfation.org>
References: <1303068618-27928-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 2/8] batman-adv: Make gateway_get_selected
	type safe
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Linus Lüssing <linus.luessing@web.de>

Make the return value explicit instead of (void *).

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/gateway_client.c |    2 +-
 net/batman-adv/gateway_client.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 3cc4355..27b87ad 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -42,7 +42,7 @@ static void gw_node_free_ref(struct gw_node *gw_node)
 		call_rcu(&gw_node->rcu, gw_node_free_rcu);
 }
 
-void *gw_get_selected(struct bat_priv *bat_priv)
+struct orig_node *gw_get_selected(struct bat_priv *bat_priv)
 {
 	struct gw_node *curr_gateway_tmp;
 	struct orig_node *orig_node = NULL;
diff --git a/net/batman-adv/gateway_client.h b/net/batman-adv/gateway_client.h
index 2aa4391..97c31d1 100644
--- a/net/batman-adv/gateway_client.h
+++ b/net/batman-adv/gateway_client.h
@@ -24,7 +24,7 @@
 
 void gw_deselect(struct bat_priv *bat_priv);
 void gw_election(struct bat_priv *bat_priv);
-void *gw_get_selected(struct bat_priv *bat_priv);
+struct orig_node *gw_get_selected(struct bat_priv *bat_priv);
 void gw_check_election(struct bat_priv *bat_priv, struct orig_node *orig_node);
 void gw_node_update(struct bat_priv *bat_priv,
 		    struct orig_node *orig_node, uint8_t new_gwflags);
-- 
1.7.4.4


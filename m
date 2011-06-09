Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu,  9 Jun 2011 23:09:10 +0200
Message-Id: <1307653754-5014-3-git-send-email-sven@narfation.org>
In-Reply-To: <1307653754-5014-1-git-send-email-sven@narfation.org>
References: <1307653754-5014-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/6] batman-adv: Don't return value in void
	function
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

gw_node_delete is defined with "void" as return type, but still tries to
return a value. The called function gw_node_delete is also return as
void and thus doesn't provide a value for us.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/gateway_client.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index ab597c4..cf7f95e 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -352,7 +352,7 @@ unlock:
 
 void gw_node_delete(struct bat_priv *bat_priv, struct orig_node *orig_node)
 {
-	return gw_node_update(bat_priv, orig_node, 0);
+	gw_node_update(bat_priv, orig_node, 0);
 }
 
 void gw_node_purge(struct bat_priv *bat_priv)
-- 
1.7.5.3


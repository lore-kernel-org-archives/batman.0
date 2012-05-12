Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 12 May 2012 14:38:01 +0200
Message-Id: <1336826281-9096-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix comment style and typo
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
To: b.a.t.m.a.n@lists.open-mesh.org

Fix to David's style

Introduced by b46c60b9e1ee7a1909c542413a85875a750955d6

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

This patch is for next


 routing.c           |    3 ++-
 translation-table.c |    3 ++-
 unicast.c           |    5 +++--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/routing.c b/routing.c
index 2181a91..4f2059f 100644
--- a/routing.c
+++ b/routing.c
@@ -922,7 +922,8 @@ static int check_unicast_ttvn(struct bat_priv *bat_priv,
 			sizeof(struct unicast_packet));
 
 		/* we don't have an updated route for this client, so we should
-		 * not try to reroute the packet!! */
+		 * not try to reroute the packet!!
+		 */
 		if (tt_global_client_is_roaming(bat_priv, ethhdr->h_dest))
 			return 1;
 
diff --git a/translation-table.c b/translation-table.c
index 88e4c8e..a66c2dc 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -2122,7 +2122,8 @@ request_table:
 
 /* returns true whether we know that the client has moved from its old
  * originator to another one. This entry is kept is still kept for consistency
- * purposes */
+ * purposes
+ */
 bool tt_global_client_is_roaming(struct bat_priv *bat_priv, uint8_t *addr)
 {
 	struct tt_global_entry *tt_global_entry;
diff --git a/unicast.c b/unicast.c
index 62ea9f1..e5c7999 100644
--- a/unicast.c
+++ b/unicast.c
@@ -395,10 +395,11 @@ find_router:
 
 	unicast_packet = (struct unicast_packet *)skb->data;
 
-	/* inform the destination ode that we are still missing a correct route
+	/* inform the destination node that we are still missing a correct route
 	 * for this client. The destination will receive this packet and will
 	 * try to reroute it because the ttvn contained in the header is less
-	 * than the current one */
+	 * than the current one
+	 */
 	if (tt_global_client_is_roaming(bat_priv, ethhdr->h_dest))
 		unicast_packet->ttvn = unicast_packet->ttvn - 1;
 
-- 
1.7.9.4


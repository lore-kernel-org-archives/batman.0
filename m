Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 10 Jul 2013 16:52:04 +0200
Message-Id: <1373467924-2316-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: remove bogus comment
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

this comment refers to the old batmand codebase and does
not make sense anymore. Remove it

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 gateway_client.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/gateway_client.c b/gateway_client.c
index 7116496..588d27e 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -194,11 +194,6 @@ void batadv_gw_election(struct batadv_priv *bat_priv)
 	struct batadv_neigh_node *router = NULL;
 	char gw_addr[18] = { '\0' };
 
-	/* The batman daemon checks here if we already passed a full originator
-	 * cycle in order to make sure we don't choose the first gateway we
-	 * hear about. This check is based on the daemon's uptime which we
-	 * don't have.
-	 */
 	if (atomic_read(&bat_priv->gw_mode) != BATADV_GW_MODE_CLIENT)
 		goto out;
 
-- 
1.8.1.5


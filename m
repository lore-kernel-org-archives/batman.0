Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 13 Aug 2014 14:26:56 +0200
Message-Id: <1407932816-19639-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix and simplify condition when
	bonding should be used
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

The current condition actually does NOT consider bonding when the
interface the packet came in from is the soft interface, which is the
opposite of what it should do (and the comment describes). Fix that and
slightly simplify the condition.

Reported-by: Ray Gibson <booray@gmail.com>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 routing.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/routing.c b/routing.c
index 35f76f2..6648f32 100644
--- a/routing.c
+++ b/routing.c
@@ -443,11 +443,13 @@ batadv_find_router(struct batadv_priv *bat_priv,
 
 	router = batadv_orig_router_get(orig_node, recv_if);
 
+	if (!router)
+		return router;
+
 	/* only consider bonding for recv_if == BATADV_IF_DEFAULT (first hop)
 	 * and if activated.
 	 */
-	if (recv_if == BATADV_IF_DEFAULT || !atomic_read(&bat_priv->bonding) ||
-	    !router)
+	if (!(recv_if == BATADV_IF_DEFAULT && atomic_read(&bat_priv->bonding)))
 		return router;
 
 	/* bonding: loop through the list of possible routers found
-- 
2.1.0.rc1


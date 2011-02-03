Return-Path: <linus.luessing@ascom.CH>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.CH>
Date: Thu,  3 Feb 2011 15:41:03 +0100
Message-Id: <1296744063-11440-1-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Disallow originator addressing
	within mesh layer
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
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.CH>

For a host in the mesh network, the batman layer should be transparent.
However, we had one exception, data packets within the mesh network
which have the same destination as a originator are being routed to
that node, although there is no host that node's bat0 interface and
therefore gets dropped anyway. This commit removes this exception.

Signed-off-by: Linus Lüssing <linus.luessing@ascom.ch>
---
 unicast.c |   22 +++-------------------
 1 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/batman-adv/unicast.c b/batman-adv/unicast.c
index 6a9ab61..9b13565 100644
--- a/batman-adv/unicast.c
+++ b/batman-adv/unicast.c
@@ -295,28 +295,12 @@ int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
 	/* get routing information */
 	if (is_multicast_ether_addr(ethhdr->h_dest)) {
 		orig_node = (struct orig_node *)gw_get_selected(bat_priv);
-		if (!orig_node)
-			goto trans_search;
-
-		kref_get(&orig_node->refcount);
-		goto find_router;
-	} else {
-		rcu_read_lock();
-		orig_node = ((struct orig_node *)hash_find(bat_priv->orig_hash,
-							   compare_orig,
-							   choose_orig,
-							   ethhdr->h_dest));
-		if (!orig_node) {
-			rcu_read_unlock();
-			goto trans_search;
+		if (orig_node) {
+			kref_get(&orig_node->refcount);
+			goto find_router;
 		}
-
-		kref_get(&orig_node->refcount);
-		rcu_read_unlock();
-		goto find_router;
 	}
 
-trans_search:
 	/* check for hna host - increases orig_node refcount */
 	orig_node = transtable_search(bat_priv, ethhdr->h_dest);
 
-- 
1.7.2.3


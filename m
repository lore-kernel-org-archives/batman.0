Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Fri, 11 Jul 2014 14:26:28 +0200
Message-Id: <1405081595-23371-6-git-send-email-martin@hundeboll.net>
In-Reply-To: <1405081595-23371-1-git-send-email-martin@hundeboll.net>
References: <1405081595-23371-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 06/13] batman-adv: kernel doc fixes for
	originator.c
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
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
---
 originator.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/originator.c b/originator.c
index 6a48451..3c2413e 100644
--- a/originator.c
+++ b/originator.c
@@ -166,7 +166,7 @@ static void batadv_neigh_ifinfo_free_rcu(struct rcu_head *rcu)
 }
 
 /**
- * batadv_neigh_ifinfo_free_now - decrement the refcounter and possibly free
+ * batadv_neigh_ifinfo_free_ref_now - decrement the refcounter and possibly free
  *  the neigh_ifinfo (without rcu callback)
  * @neigh_ifinfo: the neigh_ifinfo object to release
  */
@@ -233,7 +233,7 @@ void batadv_neigh_node_free_ref(struct batadv_neigh_node *neigh_node)
 }
 
 /**
- * batadv_orig_node_get_router - router to the originator depending on iface
+ * batadv_orig_router_get - router to the originator depending on iface
  * @orig_node: the orig node for the router
  * @if_outgoing: the interface where the payload packet has been received or
  *  the OGM should be sent to
@@ -347,7 +347,7 @@ out:
 
 /**
  * batadv_neigh_ifinfo_get - find the ifinfo from an neigh_node
- * @neigh_node: the neigh node to be queried
+ * @neigh: the neigh node to be queried
  * @if_outgoing: the interface for which the ifinfo should be acquired
  *
  * The object is returned with refcounter increased by 1.
@@ -380,7 +380,7 @@ batadv_neigh_ifinfo_get(struct batadv_neigh_node *neigh,
 
 /**
  * batadv_neigh_ifinfo_new - search and possibly create an neigh_ifinfo object
- * @neigh_node: the neigh node to be queried
+ * @neigh: the neigh node to be queried
  * @if_outgoing: the interface for which the ifinfo should be acquired
  *
  * Returns NULL in case of failure or the neigh_ifinfo object for the
@@ -516,7 +516,7 @@ static void batadv_orig_ifinfo_free_rcu(struct rcu_head *rcu)
 }
 
 /**
- * batadv_orig_ifinfo_free_ref - decrement the refcounter and possibly free
+ * batadv_orig_ifinfo_free_ref_now - decrement the refcounter and possibly free
  *  the orig_ifinfo (without rcu callback)
  * @orig_ifinfo: the orig_ifinfo object to release
  */
-- 
2.0.1


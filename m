Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Sat, 13 Dec 2014 23:32:15 +0100
Message-Id: <1418509935-11849-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH maint] batman-adv: fix potential TT client +
 orig-node memory leak
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

This patch fixes a potential memory leak which can occur once an
originator times out. On timeout the according global translation table
entry might not get purged correctly. Furthermore, the non purged TT
entry will cause its orig-node to leak, too. Which additionally can lead
to the new multicast optimization feature not kicking in because of a
therefore bogus counter.

In the wild with larger mesh networks we saw this leak quite regularly,
resulting in routers to reboot or killed processes. This was because
of a combination of two bugs: The bug fixed by commit
"batman-adv: fix delayed foreign originator recognition" (8a2ad5204674)
amplified this memory leak heavily. Since that commit I'd expect
it to happen rarely, probably only in paused and resumed VMs and
devices previously in stand-by.

The issue this patch fixes is caused by batadv_orig_node_free_rcu()
never being called because of not yet released references to the
orig-node. References which were supposed to be released through
batadv_orig_node_free_rcu()->batadv_tt_global_del_orig().

Fixing the issue by moving batadv_tt_global_del_orig() out of the rcu
callback.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 originator.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/originator.c b/originator.c
index 648bdba..bea8198 100644
--- a/originator.c
+++ b/originator.c
@@ -570,9 +570,6 @@ static void batadv_orig_node_free_rcu(struct rcu_head *rcu)
 
 	batadv_frag_purge_orig(orig_node, NULL);
 
-	batadv_tt_global_del_orig(orig_node->bat_priv, orig_node, -1,
-				  "originator timed out");
-
 	if (orig_node->bat_priv->bat_algo_ops->bat_orig_free)
 		orig_node->bat_priv->bat_algo_ops->bat_orig_free(orig_node);
 
@@ -978,6 +975,9 @@ static void _batadv_purge_orig(struct batadv_priv *bat_priv)
 			if (batadv_purge_orig_node(bat_priv, orig_node)) {
 				batadv_gw_node_delete(bat_priv, orig_node);
 				hlist_del_rcu(&orig_node->hash_entry);
+				batadv_tt_global_del_orig(orig_node->bat_priv,
+							  orig_node, -1,
+							  "originator timed out");
 				batadv_orig_node_free_ref(orig_node);
 				continue;
 			}
-- 
1.7.10.4


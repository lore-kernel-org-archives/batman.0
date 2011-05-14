Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 15 May 2011 00:50:21 +0200
Message-Id: <1305413421-8416-1-git-send-email-sven@narfation.org>
In-Reply-To: <1305407694-16789-1-git-send-email-sven@narfation.org>
References: <1305407694-16789-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 10/09] batman-adv: Use
	rcu_dereference_protected by update-side
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

Usually rcu_dereference isn't necessary in situations were the
RCU-protected data structure cannot change, but sparse and lockdep still
need a similar functionality for analysis. rcu_dereference_protected
implements the reduced version which should be used to support the
dynamic and static analysis.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat.h         |    2 ++
 gateway_client.c |    2 +-
 hard-interface.c |    2 +-
 soft-interface.c |    3 ++-
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/compat.h b/compat.h
index fb49f9d..c11f6cd 100644
--- a/compat.h
+++ b/compat.h
@@ -265,6 +265,8 @@ int bat_seq_printf(struct seq_file *m, const char *f, ...);
 	pos && ({ prefetch(pos->next); 1; }); \
 	pos = rcu_dereference(hlist_next_rcu(pos)))
 
+#define rcu_dereference_protected(p, c) (p)
+
 #endif /* < KERNEL_VERSION(2, 6, 34) */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 36)
diff --git a/gateway_client.c b/gateway_client.c
index 0df6e69..9fc475f 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -94,7 +94,7 @@ static void gw_select(struct bat_priv *bat_priv, struct gw_node *new_gw_node)
 	if (new_gw_node && !atomic_inc_not_zero(&new_gw_node->refcount))
 		new_gw_node = NULL;
 
-	curr_gw_node = bat_priv->curr_gw;
+	curr_gw_node = rcu_dereference_protected(bat_priv->curr_gw, 1);
 	rcu_assign_pointer(bat_priv->curr_gw, new_gw_node);
 
 	if (curr_gw_node)
diff --git a/hard-interface.c b/hard-interface.c
index e0052cf..a3fbfb5 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -138,7 +138,7 @@ static void primary_if_select(struct bat_priv *bat_priv,
 	if (new_hard_iface && !atomic_inc_not_zero(&new_hard_iface->refcount))
 		new_hard_iface = NULL;
 
-	curr_hard_iface = bat_priv->primary_if;
+	curr_hard_iface = rcu_dereference_protected(bat_priv->primary_if, 1);
 	rcu_assign_pointer(bat_priv->primary_if, new_hard_iface);
 
 	if (curr_hard_iface)
diff --git a/soft-interface.c b/soft-interface.c
index 515629e..56f1908 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -249,7 +249,8 @@ static void softif_neigh_vid_select(struct bat_priv *bat_priv,
 	if (new_neigh && !atomic_inc_not_zero(&new_neigh->refcount))
 		new_neigh = NULL;
 
-	curr_neigh = softif_neigh_vid->softif_neigh;
+	curr_neigh = rcu_dereference_protected(softif_neigh_vid->softif_neigh,
+					       1);
 	rcu_assign_pointer(softif_neigh_vid->softif_neigh, new_neigh);
 
 	if ((curr_neigh) && (!new_neigh))
-- 
1.7.5.1


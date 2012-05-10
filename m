Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 10 May 2012 14:01:32 +0800
Message-Id: <1336629692-32288-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman_adv: fix namespace for neigh_node_new
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <lindner_marek@yahoo.de>

Should be merged with 0c9a249ef4dcaf733f6c7f64d4ce5c97b4705968

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 bat_iv_ogm.c |    2 +-
 originator.c |    5 +++--
 originator.h |    5 +++--
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 837c8a6..24b510f 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -38,7 +38,7 @@ static struct neigh_node *bat_iv_ogm_neigh_new(struct hard_iface *hard_iface,
 {
 	struct neigh_node *neigh_node;
 
-	neigh_node = neigh_node_new(hard_iface, neigh_addr, seqno);
+	neigh_node = batman_adv_neigh_node_new(hard_iface, neigh_addr, seqno);
 	if (!neigh_node)
 		goto out;
 
diff --git a/originator.c b/originator.c
index 30889c9..504b4cd 100644
--- a/originator.c
+++ b/originator.c
@@ -86,8 +86,9 @@ struct neigh_node *orig_node_get_router(struct orig_node *orig_node)
 	return router;
 }
 
-struct neigh_node *neigh_node_new(struct hard_iface *hard_iface,
-				  const uint8_t *neigh_addr, uint32_t seqno)
+struct neigh_node *batman_adv_neigh_node_new(struct hard_iface *hard_iface,
+					     const uint8_t *neigh_addr,
+					     uint32_t seqno)
 {
 	struct bat_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 	struct neigh_node *neigh_node;
diff --git a/originator.h b/originator.h
index 64c5d94..fd37ba0 100644
--- a/originator.h
+++ b/originator.h
@@ -29,8 +29,9 @@ void originator_free(struct bat_priv *bat_priv);
 void purge_orig_ref(struct bat_priv *bat_priv);
 void orig_node_free_ref(struct orig_node *orig_node);
 struct orig_node *get_orig_node(struct bat_priv *bat_priv, const uint8_t *addr);
-struct neigh_node *neigh_node_new(struct hard_iface *hard_iface,
-				  const uint8_t *neigh_addr, uint32_t seqno);
+struct neigh_node *batman_adv_neigh_node_new(struct hard_iface *hard_iface,
+					     const uint8_t *neigh_addr,
+					     uint32_t seqno);
 void neigh_node_free_ref(struct neigh_node *neigh_node);
 struct neigh_node *orig_node_get_router(struct orig_node *orig_node);
 int orig_seq_print_text(struct seq_file *seq, void *offset);
-- 
1.7.9.1


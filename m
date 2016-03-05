Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  5 Mar 2016 15:56:01 +0100
Message-Id: <1457189761-9275-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix function names on new line
	starting with '*'
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

Some really long function names in batman-adv require a newline between
return type and the function name. This has lead to some lines starting
with *batadv_...

This * belongs to the return type and thus should be on the same line as
the return type.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bridge_loop_avoidance.c |  6 +++---
 net/batman-adv/main.c                  |  8 ++++----
 net/batman-adv/network-coding.c        | 18 +++++++++---------
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 642167f..943f9e2 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -200,9 +200,9 @@ static void batadv_claim_put(struct batadv_bla_claim *claim)
  *
  * Return: claim if found or NULL otherwise.
  */
-static struct batadv_bla_claim
-*batadv_claim_hash_find(struct batadv_priv *bat_priv,
-			struct batadv_bla_claim *data)
+static struct batadv_bla_claim *
+batadv_claim_hash_find(struct batadv_priv *bat_priv,
+		       struct batadv_bla_claim *data)
 {
 	struct batadv_hashtable *hash = bat_priv->bla.claim_hash;
 	struct hlist_head *head;
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 1245a58..50d5bd4 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -675,8 +675,8 @@ static void batadv_tvlv_handler_put(struct batadv_tvlv_handler *tvlv_handler)
  *
  * Return: tvlv handler if found or NULL otherwise.
  */
-static struct batadv_tvlv_handler
-*batadv_tvlv_handler_get(struct batadv_priv *bat_priv, u8 type, u8 version)
+static struct batadv_tvlv_handler *
+batadv_tvlv_handler_get(struct batadv_priv *bat_priv, u8 type, u8 version)
 {
 	struct batadv_tvlv_handler *tvlv_handler_tmp, *tvlv_handler = NULL;
 
@@ -734,8 +734,8 @@ static void batadv_tvlv_container_put(struct batadv_tvlv_container *tvlv)
  *
  * Return: tvlv container if found or NULL otherwise.
  */
-static struct batadv_tvlv_container
-*batadv_tvlv_container_get(struct batadv_priv *bat_priv, u8 type, u8 version)
+static struct batadv_tvlv_container *
+batadv_tvlv_container_get(struct batadv_priv *bat_priv, u8 type, u8 version)
 {
 	struct batadv_tvlv_container *tvlv_tmp, *tvlv = NULL;
 
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 4f7a558..fd5bcd0 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -793,10 +793,10 @@ static bool batadv_can_nc_with_orig(struct batadv_priv *bat_priv,
  *
  * Return: the nc_node if found, NULL otherwise.
  */
-static struct batadv_nc_node
-*batadv_nc_find_nc_node(struct batadv_orig_node *orig_node,
-			struct batadv_orig_node *orig_neigh_node,
-			bool in_coding)
+static struct batadv_nc_node *
+batadv_nc_find_nc_node(struct batadv_orig_node *orig_node,
+		       struct batadv_orig_node *orig_neigh_node,
+		       bool in_coding)
 {
 	struct batadv_nc_node *nc_node, *nc_node_out = NULL;
 	struct list_head *list;
@@ -835,11 +835,11 @@ static struct batadv_nc_node
  *
  * Return: the nc_node if found or created, NULL in case of an error.
  */
-static struct batadv_nc_node
-*batadv_nc_get_nc_node(struct batadv_priv *bat_priv,
-		       struct batadv_orig_node *orig_node,
-		       struct batadv_orig_node *orig_neigh_node,
-		       bool in_coding)
+static struct batadv_nc_node *
+batadv_nc_get_nc_node(struct batadv_priv *bat_priv,
+		      struct batadv_orig_node *orig_node,
+		      struct batadv_orig_node *orig_neigh_node,
+		      bool in_coding)
 {
 	struct batadv_nc_node *nc_node;
 	spinlock_t *lock; /* Used to lock list selected by "int in_coding" */
-- 
2.7.0


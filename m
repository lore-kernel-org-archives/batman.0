Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 25 Jul 2016 00:42:44 +0200
Message-Id: <1469400164-14302-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Remove needless init of
	variables on stack
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

Some variables are overwritten immediatelly in a functions. These don't
have to be initialized to a specific value on the stack because the value
will be overwritten before they will be used anywhere.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_v.c          | 2 +-
 net/batman-adv/bat_v_ogm.c      | 4 ++--
 net/batman-adv/gateway_client.c | 2 +-
 net/batman-adv/originator.c     | 8 ++++----
 net/batman-adv/send.c           | 2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index e79f6f0..57c795c 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -787,7 +787,7 @@ static bool batadv_v_gw_is_eligible(struct batadv_priv *bat_priv,
 				    struct batadv_orig_node *curr_gw_orig,
 				    struct batadv_orig_node *orig_node)
 {
-	struct batadv_gw_node *curr_gw = NULL, *orig_gw = NULL;
+	struct batadv_gw_node *curr_gw, *orig_gw = NULL;
 	u32 gw_throughput, orig_throughput, threshold;
 	bool ret = false;
 
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 1aeeadc..61ff5f8 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -401,7 +401,7 @@ static int batadv_v_ogm_metric_update(struct batadv_priv *bat_priv,
 				      struct batadv_hard_iface *if_incoming,
 				      struct batadv_hard_iface *if_outgoing)
 {
-	struct batadv_orig_ifinfo *orig_ifinfo = NULL;
+	struct batadv_orig_ifinfo *orig_ifinfo;
 	struct batadv_neigh_ifinfo *neigh_ifinfo = NULL;
 	bool protection_started = false;
 	int ret = -EINVAL;
@@ -486,7 +486,7 @@ static bool batadv_v_ogm_route_update(struct batadv_priv *bat_priv,
 				      struct batadv_hard_iface *if_outgoing)
 {
 	struct batadv_neigh_node *router = NULL;
-	struct batadv_orig_node *orig_neigh_node = NULL;
+	struct batadv_orig_node *orig_neigh_node;
 	struct batadv_neigh_node *orig_neigh_router = NULL;
 	struct batadv_neigh_ifinfo *router_ifinfo = NULL, *neigh_ifinfo = NULL;
 	u32 router_throughput, neigh_throughput;
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index de055d6..69bfe98 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -704,7 +704,7 @@ bool batadv_gw_out_of_range(struct batadv_priv *bat_priv,
 {
 	struct batadv_neigh_node *neigh_curr = NULL;
 	struct batadv_neigh_node *neigh_old = NULL;
-	struct batadv_orig_node *orig_dst_node = NULL;
+	struct batadv_orig_node *orig_dst_node;
 	struct batadv_gw_node *gw_node = NULL;
 	struct batadv_gw_node *curr_gw = NULL;
 	struct batadv_neigh_ifinfo *curr_ifinfo, *old_ifinfo;
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 5f3bfc4..6af87c9 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -364,7 +364,7 @@ struct batadv_orig_ifinfo *
 batadv_orig_ifinfo_new(struct batadv_orig_node *orig_node,
 		       struct batadv_hard_iface *if_outgoing)
 {
-	struct batadv_orig_ifinfo *orig_ifinfo = NULL;
+	struct batadv_orig_ifinfo *orig_ifinfo;
 	unsigned long reset_time;
 
 	spin_lock_bh(&orig_node->neigh_list_lock);
@@ -520,7 +520,7 @@ batadv_hardif_neigh_create(struct batadv_hard_iface *hard_iface,
 			   const u8 *neigh_addr)
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
-	struct batadv_hardif_neigh_node *hardif_neigh = NULL;
+	struct batadv_hardif_neigh_node *hardif_neigh;
 
 	spin_lock_bh(&hard_iface->neigh_list_lock);
 
@@ -563,7 +563,7 @@ static struct batadv_hardif_neigh_node *
 batadv_hardif_neigh_get_or_create(struct batadv_hard_iface *hard_iface,
 				  const u8 *neigh_addr)
 {
-	struct batadv_hardif_neigh_node *hardif_neigh = NULL;
+	struct batadv_hardif_neigh_node *hardif_neigh;
 
 	/* first check without locking to avoid the overhead */
 	hardif_neigh = batadv_hardif_neigh_get(hard_iface, neigh_addr);
@@ -683,7 +683,7 @@ batadv_neigh_node_get_or_create(struct batadv_orig_node *orig_node,
 				struct batadv_hard_iface *hard_iface,
 				const u8 *neigh_addr)
 {
-	struct batadv_neigh_node *neigh_node = NULL;
+	struct batadv_neigh_node *neigh_node;
 
 	/* first check without locking to avoid the overhead */
 	neigh_node = batadv_neigh_node_get(orig_node, hard_iface, neigh_addr);
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 8d4e1f5..e1e9136 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -562,7 +562,7 @@ int batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
 				    const struct sk_buff *skb,
 				    unsigned long delay)
 {
-	struct batadv_hard_iface *primary_if = NULL;
+	struct batadv_hard_iface *primary_if;
 	struct batadv_forw_packet *forw_packet;
 	struct batadv_bcast_packet *bcast_packet;
 	struct sk_buff *newskb;
-- 
2.8.1


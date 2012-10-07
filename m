Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  7 Oct 2012 12:02:22 +0200
Message-Id: <1349604142-9308-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Remove instant overwritten
	variable initialization
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 routing.c           |    2 +-
 sysfs.c             |    2 +-
 translation-table.c |   20 ++++++++++----------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/routing.c b/routing.c
index 12af7d3..e146370 100644
--- a/routing.c
+++ b/routing.c
@@ -911,7 +911,7 @@ batadv_reroute_unicast_packet(struct batadv_priv *bat_priv,
 			      struct batadv_unicast_packet *unicast_packet,
 			      uint8_t *dst_addr)
 {
-	struct batadv_orig_node *orig_node = NULL;
+	struct batadv_orig_node *orig_node;
 	bool ret = false;
 
 	orig_node = batadv_transtable_search(bat_priv, NULL, dst_addr);
diff --git a/sysfs.c b/sysfs.c
index 7fdc220..cc56ed0 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -739,7 +739,7 @@ int batadv_throw_uevent(struct batadv_priv *bat_priv, enum batadv_uev_type type,
 			enum batadv_uev_action action, const char *data)
 {
 	int ret = -ENOMEM;
-	struct batadv_hard_iface *primary_if = NULL;
+	struct batadv_hard_iface *primary_if;
 	struct kobject *bat_kobj;
 	char *uevent_env[4] = { NULL, NULL, NULL, NULL };
 
diff --git a/translation-table.c b/translation-table.c
index 1f5ad91..41613b7 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -256,8 +256,8 @@ void batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 			 int ifindex)
 {
 	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
-	struct batadv_tt_local_entry *tt_local = NULL;
-	struct batadv_tt_global_entry *tt_global = NULL;
+	struct batadv_tt_local_entry *tt_local;
+	struct batadv_tt_global_entry *tt_global;
 	struct hlist_head *head;
 	struct hlist_node *node;
 	struct batadv_tt_orig_list_entry *orig_entry;
@@ -543,7 +543,7 @@ uint16_t batadv_tt_local_remove(struct batadv_priv *bat_priv,
 				const uint8_t *addr, const char *message,
 				bool roaming)
 {
-	struct batadv_tt_local_entry *tt_local_entry = NULL;
+	struct batadv_tt_local_entry *tt_local_entry;
 	uint16_t flags, curr_flags = BATADV_NO_FLAGS;
 
 	tt_local_entry = batadv_tt_local_hash_find(bat_priv, addr);
@@ -783,8 +783,8 @@ int batadv_tt_global_add(struct batadv_priv *bat_priv,
 			 const unsigned char *tt_addr, uint8_t flags,
 			 uint8_t ttvn)
 {
-	struct batadv_tt_global_entry *tt_global_entry = NULL;
-	struct batadv_tt_local_entry *tt_local_entry = NULL;
+	struct batadv_tt_global_entry *tt_global_entry;
+	struct batadv_tt_local_entry *tt_local_entry;
 	int ret = 0;
 	int hash_added;
 	struct batadv_tt_common_entry *common;
@@ -1074,7 +1074,7 @@ static void batadv_tt_global_del(struct batadv_priv *bat_priv,
 				 const unsigned char *addr,
 				 const char *message, bool roaming)
 {
-	struct batadv_tt_global_entry *tt_global_entry = NULL;
+	struct batadv_tt_global_entry *tt_global_entry;
 	struct batadv_tt_local_entry *local_entry = NULL;
 
 	tt_global_entry = batadv_tt_global_hash_find(bat_priv, addr);
@@ -1677,7 +1677,7 @@ static bool
 batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 			      struct batadv_tt_query_packet *tt_request)
 {
-	struct batadv_orig_node *req_dst_orig_node = NULL;
+	struct batadv_orig_node *req_dst_orig_node;
 	struct batadv_orig_node *res_dst_orig_node = NULL;
 	struct batadv_neigh_node *neigh_node = NULL;
 	struct batadv_hard_iface *primary_if = NULL;
@@ -1812,7 +1812,7 @@ static bool
 batadv_send_my_tt_response(struct batadv_priv *bat_priv,
 			   struct batadv_tt_query_packet *tt_request)
 {
-	struct batadv_orig_node *orig_node = NULL;
+	struct batadv_orig_node *orig_node;
 	struct batadv_neigh_node *neigh_node = NULL;
 	struct batadv_hard_iface *primary_if = NULL;
 	uint8_t my_ttvn, req_ttvn, ttvn;
@@ -1978,7 +1978,7 @@ static void _batadv_tt_update_changes(struct batadv_priv *bat_priv,
 static void batadv_tt_fill_gtable(struct batadv_priv *bat_priv,
 				  struct batadv_tt_query_packet *tt_response)
 {
-	struct batadv_orig_node *orig_node = NULL;
+	struct batadv_orig_node *orig_node;
 
 	orig_node = batadv_orig_hash_find(bat_priv, tt_response->src);
 	if (!orig_node)
@@ -2020,7 +2020,7 @@ static void batadv_tt_update_changes(struct batadv_priv *bat_priv,
 
 bool batadv_is_my_client(struct batadv_priv *bat_priv, const uint8_t *addr)
 {
-	struct batadv_tt_local_entry *tt_local_entry = NULL;
+	struct batadv_tt_local_entry *tt_local_entry;
 	bool ret = false;
 
 	tt_local_entry = batadv_tt_local_hash_find(bat_priv, addr);
-- 
1.7.10.4


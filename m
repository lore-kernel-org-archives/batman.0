Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 14 Nov 2012 21:16:29 +0100
Message-Id: <1352924189-18843-12-git-send-email-ordex@autistici.org>
In-Reply-To: <1352924189-18843-1-git-send-email-ordex@autistici.org>
References: <1352924189-18843-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 11/11] batman-adv: Remove instant overwritten
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Sven Eckelmann <sven@narfation.org>

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/sysfs.c             |  2 +-
 net/batman-adv/translation-table.c | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index fa3cc1a..84a55cb 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -688,7 +688,7 @@ int batadv_throw_uevent(struct batadv_priv *bat_priv, enum batadv_uev_type type,
 			enum batadv_uev_action action, const char *data)
 {
 	int ret = -ENOMEM;
-	struct batadv_hard_iface *primary_if = NULL;
+	struct batadv_hard_iface *primary_if;
 	struct kobject *bat_kobj;
 	char *uevent_env[4] = { NULL, NULL, NULL, NULL };
 
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index dd2c254..9f5705f 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
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
@@ -544,7 +544,7 @@ uint16_t batadv_tt_local_remove(struct batadv_priv *bat_priv,
 				const uint8_t *addr, const char *message,
 				bool roaming)
 {
-	struct batadv_tt_local_entry *tt_local_entry = NULL;
+	struct batadv_tt_local_entry *tt_local_entry;
 	uint16_t flags, curr_flags = BATADV_NO_FLAGS;
 
 	tt_local_entry = batadv_tt_local_hash_find(bat_priv, addr);
@@ -784,8 +784,8 @@ int batadv_tt_global_add(struct batadv_priv *bat_priv,
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
@@ -1067,7 +1067,7 @@ static void batadv_tt_global_del(struct batadv_priv *bat_priv,
 				 const unsigned char *addr,
 				 const char *message, bool roaming)
 {
-	struct batadv_tt_global_entry *tt_global_entry = NULL;
+	struct batadv_tt_global_entry *tt_global_entry;
 	struct batadv_tt_local_entry *local_entry = NULL;
 
 	tt_global_entry = batadv_tt_global_hash_find(bat_priv, addr);
@@ -1670,7 +1670,7 @@ static bool
 batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 			      struct batadv_tt_query_packet *tt_request)
 {
-	struct batadv_orig_node *req_dst_orig_node = NULL;
+	struct batadv_orig_node *req_dst_orig_node;
 	struct batadv_orig_node *res_dst_orig_node = NULL;
 	struct batadv_neigh_node *neigh_node = NULL;
 	struct batadv_hard_iface *primary_if = NULL;
@@ -1805,7 +1805,7 @@ static bool
 batadv_send_my_tt_response(struct batadv_priv *bat_priv,
 			   struct batadv_tt_query_packet *tt_request)
 {
-	struct batadv_orig_node *orig_node = NULL;
+	struct batadv_orig_node *orig_node;
 	struct batadv_neigh_node *neigh_node = NULL;
 	struct batadv_hard_iface *primary_if = NULL;
 	uint8_t my_ttvn, req_ttvn, ttvn;
@@ -1971,7 +1971,7 @@ static void _batadv_tt_update_changes(struct batadv_priv *bat_priv,
 static void batadv_tt_fill_gtable(struct batadv_priv *bat_priv,
 				  struct batadv_tt_query_packet *tt_response)
 {
-	struct batadv_orig_node *orig_node = NULL;
+	struct batadv_orig_node *orig_node;
 
 	orig_node = batadv_orig_hash_find(bat_priv, tt_response->src);
 	if (!orig_node)
@@ -2013,7 +2013,7 @@ static void batadv_tt_update_changes(struct batadv_priv *bat_priv,
 
 bool batadv_is_my_client(struct batadv_priv *bat_priv, const uint8_t *addr)
 {
-	struct batadv_tt_local_entry *tt_local_entry = NULL;
+	struct batadv_tt_local_entry *tt_local_entry;
 	bool ret = false;
 
 	tt_local_entry = batadv_tt_local_hash_find(bat_priv, addr);
-- 
1.8.0


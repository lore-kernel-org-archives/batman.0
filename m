Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun, 12 Sep 2010 23:21:53 +0200
Message-Id: <1284326516-30540-3-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1284326516-30540-1-git-send-email-sven.eckelmann@gmx.de>
References: <1284326516-30540-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/5] Staging: batman-adv: Remove currently
	unused gw_* datastructures
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
To: greg@kroah.com
Cc: b.a.t.m.a.n@lists.open-mesh.net

gw_list_lock, gw_list and curr_gw are currently unused members of struct
bat_priv. They will be readded when gateway support is really
implemented.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/main.c  |    2 --
 drivers/staging/batman-adv/types.h |    3 ---
 2 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/batman-adv/main.c b/drivers/staging/batman-adv/main.c
index b3e23e1..78ceebf 100644
--- a/drivers/staging/batman-adv/main.c
+++ b/drivers/staging/batman-adv/main.c
@@ -84,13 +84,11 @@ int mesh_init(struct net_device *soft_iface)
 	spin_lock_init(&bat_priv->forw_bcast_list_lock);
 	spin_lock_init(&bat_priv->hna_lhash_lock);
 	spin_lock_init(&bat_priv->hna_ghash_lock);
-	spin_lock_init(&bat_priv->gw_list_lock);
 	spin_lock_init(&bat_priv->vis_hash_lock);
 	spin_lock_init(&bat_priv->vis_list_lock);
 
 	INIT_HLIST_HEAD(&bat_priv->forw_bat_list);
 	INIT_HLIST_HEAD(&bat_priv->forw_bcast_list);
-	INIT_HLIST_HEAD(&bat_priv->gw_list);
 
 	if (originator_init(bat_priv) < 1)
 		goto err;
diff --git a/drivers/staging/batman-adv/types.h b/drivers/staging/batman-adv/types.h
index e779c4a..9d744d8 100644
--- a/drivers/staging/batman-adv/types.h
+++ b/drivers/staging/batman-adv/types.h
@@ -128,7 +128,6 @@ struct bat_priv {
 	struct dentry *debug_dir;
 	struct hlist_head forw_bat_list;
 	struct hlist_head forw_bcast_list;
-	struct hlist_head gw_list;
 	struct list_head vis_send_list;
 	struct hashtable_t *orig_hash;
 	struct hashtable_t *hna_local_hash;
@@ -139,7 +138,6 @@ struct bat_priv {
 	spinlock_t forw_bcast_list_lock;
 	spinlock_t hna_lhash_lock;
 	spinlock_t hna_ghash_lock;
-	spinlock_t gw_list_lock;
 	spinlock_t vis_hash_lock;
 	spinlock_t vis_list_lock;
 	int16_t num_local_hna;
@@ -147,7 +145,6 @@ struct bat_priv {
 	struct delayed_work hna_work;
 	struct delayed_work orig_work;
 	struct delayed_work vis_work;
-	struct gw_node *curr_gw;
 	struct vis_info *my_vis_info;
 };
 
-- 
1.7.2.3


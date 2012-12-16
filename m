Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 16 Dec 2012 13:53:15 +0800
Message-Id: <1355637195-28768-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: unbloat batadv_priv if debug is
	not enabled
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 debugfs.c        |    1 -
 soft-interface.c |    2 ++
 types.h          |    4 ++++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/debugfs.c b/debugfs.c
index 5136d32..55a9007 100644
--- a/debugfs.c
+++ b/debugfs.c
@@ -229,7 +229,6 @@ static void batadv_debug_log_cleanup(struct batadv_priv *bat_priv)
 #else /* CONFIG_BATMAN_ADV_DEBUG */
 static int batadv_debug_log_setup(struct batadv_priv *bat_priv)
 {
-	bat_priv->debug_log = NULL;
 	return 0;
 }
 
diff --git a/soft-interface.c b/soft-interface.c
index adafa96..a8eb963 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -494,7 +494,9 @@ struct net_device *batadv_softif_create(const char *name)
 	atomic_set(&bat_priv->gw_bandwidth, 41);
 	atomic_set(&bat_priv->orig_interval, 1000);
 	atomic_set(&bat_priv->hop_penalty, 30);
+#ifdef CONFIG_BATMAN_ADV_DEBUG
 	atomic_set(&bat_priv->log_level, 0);
+#endif
 	atomic_set(&bat_priv->fragmentation, 1);
 	atomic_set(&bat_priv->bcast_queue_left, BATADV_BCAST_QUEUE_LEN);
 	atomic_set(&bat_priv->batman_queue_left, BATADV_BATMAN_QUEUE_LEN);
diff --git a/types.h b/types.h
index 441880a..d8061ac 100644
--- a/types.h
+++ b/types.h
@@ -284,12 +284,16 @@ struct batadv_priv {
 	atomic_t gw_bandwidth;		/* gw bandwidth */
 	atomic_t orig_interval;		/* uint */
 	atomic_t hop_penalty;		/* uint */
+#ifdef CONFIG_BATMAN_ADV_DEBUG
 	atomic_t log_level;		/* uint */
+#endif
 	atomic_t bcast_seqno;
 	atomic_t bcast_queue_left;
 	atomic_t batman_queue_left;
 	char num_ifaces;
+#ifdef CONFIG_BATMAN_ADV_DEBUG
 	struct batadv_debug_log *debug_log;
+#endif
 	struct kobject *mesh_obj;
 	struct dentry *debug_dir;
 	struct hlist_head forw_bat_list;
-- 
1.7.10.4


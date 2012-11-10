Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 10 Nov 2012 11:00:32 +0100
Message-Id: <1352541632-25336-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Initialize lockdep class keys
	for hashes
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

Different hashes have the same class key key because they get
initialised with the same one. For this reason lockdep can create
false warning when they are used recursively.

Re-initialise the key for each hash after the invocation to hash_new()
to avoid this problem.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 originator.c        |  6 ++++++
 translation-table.c | 10 ++++++++++
 vis.c               |  6 ++++++
 3 files changed, 22 insertions(+)

diff --git a/originator.c b/originator.c
index 8c32cf1..109081c 100644
--- a/originator.c
+++ b/originator.c
@@ -29,6 +29,9 @@
 #include "soft-interface.h"
 #include "bridge_loop_avoidance.h"
 
+/* hash class keys */
+static struct lock_class_key batadv_orig_hash_lock_class_key;
+
 static void batadv_purge_orig(struct work_struct *work);
 
 static void batadv_start_purge_timer(struct batadv_priv *bat_priv)
@@ -57,6 +60,9 @@ int batadv_originator_init(struct batadv_priv *bat_priv)
 	if (!bat_priv->orig_hash)
 		goto err;
 
+	batadv_hash_set_lock_class(bat_priv->orig_hash,
+				   &batadv_orig_hash_lock_class_key);
+
 	batadv_start_purge_timer(bat_priv);
 	return 0;
 
diff --git a/translation-table.c b/translation-table.c
index 4657d9e..1bcb705 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -29,6 +29,10 @@
 
 #include <linux/crc16.h>
 
+/* hash class keys */
+static struct lock_class_key batadv_tt_local_hash_lock_class_key;
+static struct lock_class_key batadv_tt_global_hash_lock_class_key;
+
 static void batadv_send_roam_adv(struct batadv_priv *bat_priv, uint8_t *client,
 				 struct batadv_orig_node *orig_node);
 static void batadv_tt_purge(struct work_struct *work);
@@ -235,6 +239,9 @@ static int batadv_tt_local_init(struct batadv_priv *bat_priv)
 	if (!bat_priv->tt.local_hash)
 		return -ENOMEM;
 
+	batadv_hash_set_lock_class(bat_priv->tt.local_hash,
+				   &batadv_tt_local_hash_lock_class_key);
+
 	return 0;
 }
 
@@ -691,6 +698,9 @@ static int batadv_tt_global_init(struct batadv_priv *bat_priv)
 	if (!bat_priv->tt.global_hash)
 		return -ENOMEM;
 
+	batadv_hash_set_lock_class(bat_priv->tt.global_hash,
+				   &batadv_tt_global_hash_lock_class_key);
+
 	return 0;
 }
 
diff --git a/vis.c b/vis.c
index 0f65a9d..60eb9b7 100644
--- a/vis.c
+++ b/vis.c
@@ -28,6 +28,9 @@
 
 #define BATADV_MAX_VIS_PACKET_SIZE 1000
 
+/* hash class keys */
+static struct lock_class_key batadv_vis_hash_lock_class_key;
+
 static void batadv_start_vis_timer(struct batadv_priv *bat_priv);
 
 /* free the info */
@@ -852,6 +855,9 @@ int batadv_vis_init(struct batadv_priv *bat_priv)
 		goto err;
 	}
 
+	batadv_hash_set_lock_class(bat_priv->vis.hash,
+				   &batadv_vis_hash_lock_class_key);
+
 	bat_priv->vis.my_info = kmalloc(BATADV_MAX_VIS_PACKET_SIZE, GFP_ATOMIC);
 	if (!bat_priv->vis.my_info)
 		goto err;
-- 
1.8.0


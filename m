Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 25 Nov 2012 19:23:28 +0100
Message-Id: <1353867811-8452-2-git-send-email-sven@narfation.org>
In-Reply-To: <1353867811-8452-1-git-send-email-sven@narfation.org>
References: <1353867811-8452-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/5] batman-adv: Define the size of
	hashtables by hash bits
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

The common hashtable implementation in the kernel uses bits of the hash to
compute the final size of the hastable. The current batman-adv hash
implementations should do the same to allow a migration to the common hashtable
implementation.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bridge_loop_avoidance.c |    6 ++++--
 distributed-arp-table.c |    2 +-
 main.h                  |    8 ++++++++
 originator.c            |    2 +-
 translation-table.c     |    8 ++++++--
 vis.c                   |    2 +-
 6 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 1400274..2fd5f09 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -1195,6 +1195,8 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
 	struct batadv_hard_iface *primary_if;
 	uint16_t crc;
 	unsigned long entrytime;
+	uint32_t hash_claim_size = 1 << BATADV_BLA_CLAIM_HASH_BITS;
+	uint32_t hash_backbone_size = 1 << BATADV_BLA_BACKBONE_HASH_BITS;
 
 	spin_lock_init(&bat_priv->bla.bcast_duplist_lock);
 
@@ -1221,8 +1223,8 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
 	if (bat_priv->bla.claim_hash)
 		return 0;
 
-	bat_priv->bla.claim_hash = batadv_hash_new(128);
-	bat_priv->bla.backbone_hash = batadv_hash_new(32);
+	bat_priv->bla.claim_hash = batadv_hash_new(hash_claim_size);
+	bat_priv->bla.backbone_hash = batadv_hash_new(hash_backbone_size);
 
 	if (!bat_priv->bla.claim_hash || !bat_priv->bla.backbone_hash)
 		return -ENOMEM;
diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 8e1d89d..7285496 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -653,7 +653,7 @@ int batadv_dat_init(struct batadv_priv *bat_priv)
 	if (bat_priv->dat.hash)
 		return 0;
 
-	bat_priv->dat.hash = batadv_hash_new(1024);
+	bat_priv->dat.hash = batadv_hash_new(1 << BATADV_DAT_HASH_BITS);
 
 	if (!bat_priv->dat.hash)
 		return -ENOMEM;
diff --git a/main.h b/main.h
index f58e373..78ea63f 100644
--- a/main.h
+++ b/main.h
@@ -127,6 +127,14 @@ enum batadv_uev_type {
 #define BATADV_DAT_CANDIDATE_NOT_FOUND	0
 #define BATADV_DAT_CANDIDATE_ORIG	1
 
+#define BATADV_BLA_CLAIM_HASH_BITS 7
+#define BATADV_BLA_BACKBONE_HASH_BITS 5
+#define BATADV_DAT_HASH_BITS 10
+#define BATADV_ORIG_HASH_BITS 10
+#define BATADV_TT_LOCAL_HASH_BITS 10
+#define BATADV_TT_GLOBAL_HASH_BITS 10
+#define BATADV_VIS_HASH_BITS 8
+
 /* Debug Messages */
 #ifdef pr_fmt
 #undef pr_fmt
diff --git a/originator.c b/originator.c
index 8c32cf1..bd3f5d2 100644
--- a/originator.c
+++ b/originator.c
@@ -52,7 +52,7 @@ int batadv_originator_init(struct batadv_priv *bat_priv)
 	if (bat_priv->orig_hash)
 		return 0;
 
-	bat_priv->orig_hash = batadv_hash_new(1024);
+	bat_priv->orig_hash = batadv_hash_new(1 << BATADV_ORIG_HASH_BITS);
 
 	if (!bat_priv->orig_hash)
 		goto err;
diff --git a/translation-table.c b/translation-table.c
index 86f8f82..7128576 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -251,10 +251,12 @@ int batadv_tt_len(int changes_num)
 
 static int batadv_tt_local_init(struct batadv_priv *bat_priv)
 {
+	uint32_t hash_size = 1 << BATADV_TT_LOCAL_HASH_BITS;
+
 	if (bat_priv->tt.local_hash)
 		return 0;
 
-	bat_priv->tt.local_hash = batadv_hash_new(1024);
+	bat_priv->tt.local_hash = batadv_hash_new(hash_size);
 
 	if (!bat_priv->tt.local_hash)
 		return -ENOMEM;
@@ -706,10 +708,12 @@ static void batadv_tt_local_table_free(struct batadv_priv *bat_priv)
 
 static int batadv_tt_global_init(struct batadv_priv *bat_priv)
 {
+	uint32_t hash_size = 1 << BATADV_TT_GLOBAL_HASH_BITS;
+
 	if (bat_priv->tt.global_hash)
 		return 0;
 
-	bat_priv->tt.global_hash = batadv_hash_new(1024);
+	bat_priv->tt.global_hash = batadv_hash_new(hash_size);
 
 	if (!bat_priv->tt.global_hash)
 		return -ENOMEM;
diff --git a/vis.c b/vis.c
index 2eb6878..30e1405 100644
--- a/vis.c
+++ b/vis.c
@@ -835,7 +835,7 @@ int batadv_vis_init(struct batadv_priv *bat_priv)
 
 	spin_lock_bh(&bat_priv->vis.hash_lock);
 
-	bat_priv->vis.hash = batadv_hash_new(256);
+	bat_priv->vis.hash = batadv_hash_new(1 << BATADV_VIS_HASH_BITS);
 	if (!bat_priv->vis.hash) {
 		pr_err("Can't initialize vis_hash\n");
 		goto err;
-- 
1.7.10.4


Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  1 Mar 2015 14:15:35 +0100
Message-Id: <1425215737-8387-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [RFCv3 1/3] batman-adv: Define the size of
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
Cc: Sven Eckelmann <sven@narfation.org>

The common hashtable implementation in the kernel uses bits of the hash to
compute the final size of the hastable. Similar can be done for the partially
locked, concurrent hashtables in batman-adv. The requirement of sizes with
power two will allow better compiler optimization in the future.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v3:
 - Rebased on master

 bridge_loop_avoidance.c | 6 ++++--
 distributed-arp-table.c | 2 +-
 main.h                  | 9 +++++++++
 network-coding.c        | 7 +++++--
 originator.c            | 2 +-
 translation-table.c     | 8 ++++++--
 6 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 6927589..c999d6b 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -1220,6 +1220,8 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
 	struct batadv_hard_iface *primary_if;
 	uint16_t crc;
 	unsigned long entrytime;
+	uint32_t hash_claim_size = 1u << BATADV_BLA_CLAIM_HASH_BITS;
+	uint32_t hash_backbone_size = 1u << BATADV_BLA_BACKBONE_HASH_BITS;
 
 	spin_lock_init(&bat_priv->bla.bcast_duplist_lock);
 
@@ -1246,8 +1248,8 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
 	if (bat_priv->bla.claim_hash)
 		return 0;
 
-	bat_priv->bla.claim_hash = batadv_hash_new(128);
-	bat_priv->bla.backbone_hash = batadv_hash_new(32);
+	bat_priv->bla.claim_hash = batadv_hash_new(hash_claim_size);
+	bat_priv->bla.backbone_hash = batadv_hash_new(hash_backbone_size);
 
 	if (!bat_priv->bla.claim_hash || !bat_priv->bla.backbone_hash)
 		return -ENOMEM;
diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 107ad62..87ab637 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -725,7 +725,7 @@ int batadv_dat_init(struct batadv_priv *bat_priv)
 	if (bat_priv->dat.hash)
 		return 0;
 
-	bat_priv->dat.hash = batadv_hash_new(1024);
+	bat_priv->dat.hash = batadv_hash_new(1u << BATADV_DAT_HASH_BITS);
 
 	if (!bat_priv->dat.hash)
 		return -ENOMEM;
diff --git a/main.h b/main.h
index 4deacfd..26a20ae 100644
--- a/main.h
+++ b/main.h
@@ -154,6 +154,15 @@ enum batadv_uev_type {
 #define BATADV_DAT_CANDIDATE_NOT_FOUND	0
 #define BATADV_DAT_CANDIDATE_ORIG	1
 
+#define BATADV_BLA_CLAIM_HASH_BITS 7
+#define BATADV_BLA_BACKBONE_HASH_BITS 5
+#define BATADV_NC_CODING_HASH_BITS 7
+#define BATADV_NC_DECODING_HASH_BITS 7
+#define BATADV_DAT_HASH_BITS 10
+#define BATADV_ORIG_HASH_BITS 10
+#define BATADV_TT_LOCAL_HASH_BITS 10
+#define BATADV_TT_GLOBAL_HASH_BITS 10
+
 /* Debug Messages */
 #ifdef pr_fmt
 #undef pr_fmt
diff --git a/network-coding.c b/network-coding.c
index d128c3b..b70c34e 100644
--- a/network-coding.c
+++ b/network-coding.c
@@ -116,20 +116,23 @@ static void batadv_nc_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
  */
 int batadv_nc_mesh_init(struct batadv_priv *bat_priv)
 {
+	uint32_t hash_coding_size = 1u << BATADV_NC_CODING_HASH_BITS;
+	uint32_t hash_decoding_size = 1u << BATADV_NC_DECODING_HASH_BITS;
+
 	bat_priv->nc.timestamp_fwd_flush = jiffies;
 	bat_priv->nc.timestamp_sniffed_purge = jiffies;
 
 	if (bat_priv->nc.coding_hash || bat_priv->nc.decoding_hash)
 		return 0;
 
-	bat_priv->nc.coding_hash = batadv_hash_new(128);
+	bat_priv->nc.coding_hash = batadv_hash_new(hash_coding_size);
 	if (!bat_priv->nc.coding_hash)
 		goto err;
 
 	batadv_hash_set_lock_class(bat_priv->nc.coding_hash,
 				   &batadv_nc_coding_hash_lock_class_key);
 
-	bat_priv->nc.decoding_hash = batadv_hash_new(128);
+	bat_priv->nc.decoding_hash = batadv_hash_new(hash_decoding_size);
 	if (!bat_priv->nc.decoding_hash)
 		goto err;
 
diff --git a/originator.c b/originator.c
index 90e805a..34ca176 100644
--- a/originator.c
+++ b/originator.c
@@ -130,7 +130,7 @@ int batadv_originator_init(struct batadv_priv *bat_priv)
 	if (bat_priv->orig_hash)
 		return 0;
 
-	bat_priv->orig_hash = batadv_hash_new(1024);
+	bat_priv->orig_hash = batadv_hash_new(1u << BATADV_ORIG_HASH_BITS);
 
 	if (!bat_priv->orig_hash)
 		goto err;
diff --git a/translation-table.c b/translation-table.c
index b20812b..1562e26 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -460,10 +460,12 @@ static int batadv_tt_local_table_transmit_size(struct batadv_priv *bat_priv)
 
 static int batadv_tt_local_init(struct batadv_priv *bat_priv)
 {
+	uint32_t hash_size = 1u << BATADV_TT_LOCAL_HASH_BITS;
+
 	if (bat_priv->tt.local_hash)
 		return 0;
 
-	bat_priv->tt.local_hash = batadv_hash_new(1024);
+	bat_priv->tt.local_hash = batadv_hash_new(hash_size);
 
 	if (!bat_priv->tt.local_hash)
 		return -ENOMEM;
@@ -1158,10 +1160,12 @@ static void batadv_tt_local_table_free(struct batadv_priv *bat_priv)
 
 static int batadv_tt_global_init(struct batadv_priv *bat_priv)
 {
+	uint32_t hash_size = 1u << BATADV_TT_GLOBAL_HASH_BITS;
+
 	if (bat_priv->tt.global_hash)
 		return 0;
 
-	bat_priv->tt.global_hash = batadv_hash_new(1024);
+	bat_priv->tt.global_hash = batadv_hash_new(hash_size);
 
 	if (!bat_priv->tt.global_hash)
 		return -ENOMEM;
-- 
2.1.4


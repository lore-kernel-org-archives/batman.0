Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 13 May 2012 08:45:17 +0200
Message-Id: <1336891517-20890-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Mark only locally used symbol
	batadv_tt_local_crc as static
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

29ccfec94d51f7725124786e29d023b212920661 changed the translation table code in
such a way that it doesn't use the symbol tt_local_crc outside of
translation-table.c

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 translation-table.c |    2 +-
 translation-table.h |    1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index f50e795..62dda2b 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1172,7 +1172,7 @@ static uint16_t batadv_tt_global_crc(struct bat_priv *bat_priv,
 }
 
 /* Calculates the checksum of the local table */
-uint16_t batadv_tt_local_crc(struct bat_priv *bat_priv)
+static uint16_t batadv_tt_local_crc(struct bat_priv *bat_priv)
 {
 	uint16_t total = 0, total_one;
 	struct hashtable_t *hash = bat_priv->tt_local_hash;
diff --git a/translation-table.h b/translation-table.h
index 56e8016..7edc9df 100644
--- a/translation-table.h
+++ b/translation-table.h
@@ -41,7 +41,6 @@ void batadv_tt_global_del_orig(struct bat_priv *bat_priv,
 struct orig_node *batadv_transtable_search(struct bat_priv *bat_priv,
 					   const uint8_t *src,
 					   const uint8_t *addr);
-uint16_t batadv_tt_local_crc(struct bat_priv *bat_priv);
 void batadv_tt_free(struct bat_priv *bat_priv);
 bool batadv_send_tt_response(struct bat_priv *bat_priv,
 			     struct tt_query_packet *tt_request);
-- 
1.7.10


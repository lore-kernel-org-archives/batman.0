Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri,  4 May 2012 09:32:31 +0200
Message-Id: <1336116752-585-2-git-send-email-sven@narfation.org>
In-Reply-To: <1336116752-585-1-git-send-email-sven@narfation.org>
References: <1336116752-585-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: Free bla hashes on error in
	bla_init
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bridge_loop_avoidance.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 8bb274b..9d1cb9b 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -1167,15 +1167,19 @@ int bla_init(struct bat_priv *bat_priv)
 		return 1;
 
 	bat_priv->claim_hash = hash_new(128);
+	if (!bat_priv->claim_hash)
+		return -1;
+
 	bat_priv->backbone_hash = hash_new(32);
+	if (!bat_priv->backbone_hash) {
+		hash_destroy(bat_priv->claim_hash);
+		return -1;
+	}
 
 	hash_set_lock_class(bat_priv->claim_hash, &claim_hash_lock_class_key);
 	hash_set_lock_class(bat_priv->backbone_hash,
 			    &backbone_hash_lock_class_key);
 
-	if (!bat_priv->claim_hash || !bat_priv->backbone_hash)
-		return -1;
-
 	bat_dbg(DBG_BLA, bat_priv, "bla hashes initialized\n");
 
 	bla_start_timer(bat_priv);
-- 
1.7.10


Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  5 May 2012 13:27:27 +0200
Message-Id: <1336217249-16071-1-git-send-email-sven@narfation.org>
In-Reply-To: <1336116752-585-1-git-send-email-sven@narfation.org>
References: <1336116752-585-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 1/2] batman-adv: Only set hash class after
	hash is initialized
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

We must be sure that there was no error during the creation of the hash before
we can set the hash lock class. The class set function was added to the wrong
place in 2c9aa3b4c37bd55148f5f25212c89e7bf5f28497

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bridge_loop_avoidance.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 8bb274b..48831c2 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -1169,13 +1169,13 @@ int bla_init(struct bat_priv *bat_priv)
 	bat_priv->claim_hash = hash_new(128);
 	bat_priv->backbone_hash = hash_new(32);
 
+	if (!bat_priv->claim_hash || !bat_priv->backbone_hash)
+		return -1;
+
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


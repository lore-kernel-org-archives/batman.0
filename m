Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 23 Oct 2010 15:46:02 +0200
Message-Id: <1287841562-19205-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Add missing space in originator.c
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

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv/originator.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/batman-adv/originator.c b/batman-adv/originator.c
index afac4eb..15bf037 100644
--- a/batman-adv/originator.c
+++ b/batman-adv/originator.c
@@ -177,7 +177,7 @@ struct orig_node *get_orig_node(struct bat_priv *bat_priv, uint8_t *addr)
 		goto free_bcast_own_sum;
 
 	if (bat_priv->orig_hash->elements * 4 > bat_priv->orig_hash->size) {
-		swaphash = hash_resize(bat_priv->orig_hash,choose_orig,
+		swaphash = hash_resize(bat_priv->orig_hash, choose_orig,
 				       bat_priv->orig_hash->size * 2);
 
 		if (!swaphash)
-- 
1.7.2.3


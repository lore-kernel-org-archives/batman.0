Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 20 Jun 2012 17:16:05 +0200
Message-Id: <1340205365-25052-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: only drop packets of known wifi
	clients
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

If the source or destination mac address of an ethernet packet
could not be found in the translation table the packet was
dropped if AP isolation was turned on. This behavior would
make it impossible to send broadcast packets over the mesh as
the broadcast address will never enter the translation table.

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---

This patch is for maint and possibly for stable.

 translation-table.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index a66c2dc..660c40f 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -2031,10 +2031,10 @@ bool is_ap_isolated(struct bat_priv *bat_priv, uint8_t *src, uint8_t *dst)
 {
 	struct tt_local_entry *tt_local_entry = NULL;
 	struct tt_global_entry *tt_global_entry = NULL;
-	bool ret = true;
+	bool ret = false;
 
 	if (!atomic_read(&bat_priv->ap_isolation))
-		return false;
+		goto out;
 
 	tt_local_entry = tt_local_hash_find(bat_priv, dst);
 	if (!tt_local_entry)
@@ -2044,10 +2044,10 @@ bool is_ap_isolated(struct bat_priv *bat_priv, uint8_t *src, uint8_t *dst)
 	if (!tt_global_entry)
 		goto out;
 
-	if (_is_ap_isolated(tt_local_entry, tt_global_entry))
+	if (!_is_ap_isolated(tt_local_entry, tt_global_entry))
 		goto out;
 
-	ret = false;
+	ret = true;
 
 out:
 	if (tt_global_entry)
-- 
1.7.9.1


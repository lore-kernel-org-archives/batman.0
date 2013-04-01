Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon,  1 Apr 2013 23:40:36 +0200
Message-Id: <1364852436-18056-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH trivial] batman-adv: make indexes variable
	type homogeneous
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

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 translation-table.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index 279f0fd..88a697d 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1391,8 +1391,7 @@ static uint16_t batadv_tt_global_crc(struct batadv_priv *bat_priv,
 	struct batadv_tt_common_entry *tt_common;
 	struct batadv_tt_global_entry *tt_global;
 	struct hlist_head *head;
-	uint32_t i;
-	int j;
+	int i, j;
 
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
-- 
1.8.1.5


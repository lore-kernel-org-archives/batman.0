Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun,  5 May 2013 14:37:56 +0200
Message-Id: <1367757476-1705-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1367757476-1705-1-git-send-email-ordex@autistici.org>
References: <1367757476-1705-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: remove
	batadv_tt_global_add_orig declaration
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
Cc: Antonio Quartulli <ordex@autistici.org>

batadv_tt_global_add_orig is neither used nor implemented
anymore, therefore it is possible to remove its declaration

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 translation-table.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/translation-table.h b/translation-table.h
index fb710c5..015d8b9 100644
--- a/translation-table.h
+++ b/translation-table.h
@@ -27,9 +27,6 @@ uint16_t batadv_tt_local_remove(struct batadv_priv *bat_priv,
 				const uint8_t *addr, const char *message,
 				bool roaming);
 int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset);
-void batadv_tt_global_add_orig(struct batadv_priv *bat_priv,
-			       struct batadv_orig_node *orig_node,
-			       const unsigned char *tt_buff, int tt_buff_len);
 int batadv_tt_global_seq_print_text(struct seq_file *seq, void *offset);
 void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
 			       struct batadv_orig_node *orig_node,
-- 
1.8.1.5


Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun,  5 May 2013 14:37:55 +0200
Message-Id: <1367757476-1705-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: make tt_global_add static
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

batadv_tt_global_add is not used anymore outside of the TT
code thanks to the TVLV implementation. It can therefore be
declared as static

Last user has been removed by 3de4e64df0f1326db7cc0ef25f5af8522850252d
("batman-adv: tvlv - convert roaming adv packet to use tvlv unicast packets")

Reported-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 translation-table.c | 8 ++++----
 translation-table.h | 4 ----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index 48e1ca9..9576d7a 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -806,10 +806,10 @@ out:
  *
  * The caller must hold orig_node refcount.
  */
-int batadv_tt_global_add(struct batadv_priv *bat_priv,
-			 struct batadv_orig_node *orig_node,
-			 const unsigned char *tt_addr, uint16_t flags,
-			 uint8_t ttvn)
+static int batadv_tt_global_add(struct batadv_priv *bat_priv,
+				struct batadv_orig_node *orig_node,
+				const unsigned char *tt_addr, uint16_t flags,
+				uint8_t ttvn)
 {
 	struct batadv_tt_global_entry *tt_global_entry;
 	struct batadv_tt_local_entry *tt_local_entry;
diff --git a/translation-table.h b/translation-table.h
index b4b6dea..fb710c5 100644
--- a/translation-table.h
+++ b/translation-table.h
@@ -30,10 +30,6 @@ int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset);
 void batadv_tt_global_add_orig(struct batadv_priv *bat_priv,
 			       struct batadv_orig_node *orig_node,
 			       const unsigned char *tt_buff, int tt_buff_len);
-int batadv_tt_global_add(struct batadv_priv *bat_priv,
-			 struct batadv_orig_node *orig_node,
-			 const unsigned char *addr, uint16_t flags,
-			 uint8_t ttvn);
 int batadv_tt_global_seq_print_text(struct seq_file *seq, void *offset);
 void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
 			       struct batadv_orig_node *orig_node,
-- 
1.8.1.5


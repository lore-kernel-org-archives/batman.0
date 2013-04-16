Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 16 Apr 2013 20:22:22 +0200
Message-Id: <1366136543-16916-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: pass a 16bit long flag
	argument to tt_global_add()
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

it may be the case that we want to store some local TT client flags in a global
entry, therefore the tt_global_add needs to get a proper argument for this

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

Based on top of the TVLV patches sent by Marek (but they may apply on maser as
well)

Cheers,

 translation-table.c | 2 +-
 translation-table.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index 5d99c64..c1a8a10 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -786,7 +786,7 @@ out:
 /* caller must hold orig_node refcount */
 int batadv_tt_global_add(struct batadv_priv *bat_priv,
 			 struct batadv_orig_node *orig_node,
-			 const unsigned char *tt_addr, uint8_t flags,
+			 const unsigned char *tt_addr, uint16_t flags,
 			 uint8_t ttvn)
 {
 	struct batadv_tt_global_entry *tt_global_entry;
diff --git a/translation-table.h b/translation-table.h
index 597a5d6..b4b6dea 100644
--- a/translation-table.h
+++ b/translation-table.h
@@ -32,7 +32,7 @@ void batadv_tt_global_add_orig(struct batadv_priv *bat_priv,
 			       const unsigned char *tt_buff, int tt_buff_len);
 int batadv_tt_global_add(struct batadv_priv *bat_priv,
 			 struct batadv_orig_node *orig_node,
-			 const unsigned char *addr, uint8_t flags,
+			 const unsigned char *addr, uint16_t flags,
 			 uint8_t ttvn);
 int batadv_tt_global_seq_print_text(struct seq_file *seq, void *offset);
 void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
-- 
1.8.1.5


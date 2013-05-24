Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Fri, 24 May 2013 17:25:28 +0200
Message-Id: <1369409129-1760-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: fix num_changes type to
	uint16_t
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

Since the introduction of the tvlv_tt_data struct variables
storing the number of TT changes are always declared as
uint16_t, however some of them were not changed.

Switch them al to uint16_t.

Introduced by 8405301b979466610a726b7d595b6bfee5306cf7
("batman-adv: tvlv - convert tt data sent within OGMs")

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 translation-table.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index 44e7789..f6b96cb 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1486,7 +1486,7 @@ static void batadv_tt_req_list_free(struct batadv_priv *bat_priv)
 static void batadv_tt_save_orig_buffer(struct batadv_priv *bat_priv,
 				       struct batadv_orig_node *orig_node,
 				       const unsigned char *tt_buff,
-				       uint8_t tt_num_changes)
+				       uint16_t tt_num_changes)
 {
 	uint16_t tt_buff_len = batadv_tt_len(tt_num_changes);
 
@@ -2407,8 +2407,8 @@ out:
 static void batadv_tt_update_orig(struct batadv_priv *bat_priv,
 				  struct batadv_orig_node *orig_node,
 				  const unsigned char *tt_buff,
-				  uint8_t tt_num_changes,
-				  uint8_t ttvn, uint32_t tt_crc)
+				  uint16_t tt_num_changes, uint8_t ttvn,
+				  uint32_t tt_crc)
 {
 	uint8_t orig_ttvn = (uint8_t)atomic_read(&orig_node->last_ttvn);
 	bool full_table = true;
-- 
1.8.1.5


Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Fri, 24 May 2013 17:25:29 +0200
Message-Id: <1369409129-1760-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1369409129-1760-1-git-send-email-ordex@autistici.org>
References: <1369409129-1760-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: fix typo in kernel doc
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

Now TT uses CRC32 instead of CRC16

Introduced by c5e7a06a29612056006e4dc01910c0b44e858583
("batman-adv: use CRC32C instead of CRC16 in TT code")

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 translation-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/translation-table.c b/translation-table.c
index f6b96cb..08da23a 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -2402,7 +2402,7 @@ out:
  * @tt_buff: buffer holding the tt information
  * @tt_num_changes: number of tt changes inside the tt buffer
  * @ttvn: translation table version number of this changeset
- * @tt_crc: crc16 checksum of orig node's translation table
+ * @tt_crc: crc32 checksum of orig node's translation table
  */
 static void batadv_tt_update_orig(struct batadv_priv *bat_priv,
 				  struct batadv_orig_node *orig_node,
-- 
1.8.1.5


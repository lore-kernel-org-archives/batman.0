Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 11 Feb 2014 17:05:06 +0100
Message-Id: <1392134707-2318-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH maint 1/2] batman-adv: fix TT CRC computation
	by ensuring byte order
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

When computing the CRC on a 2byte variable the order of
the bytes obviously alters the final result. This means
that computing the CRC over the same value on two archs
having different endianess leads to different numbers.

The global and local translation table CRC computation
routine makes this mistake while processing the clients
VIDs. The result is a continuous CRC mismatching between
nodes having different endianess.

Fix this by converting the VID to Network Order before
processing it. This guarantees that every node uses the same
byte order.

Introduced by 21a57f6e7a3b4455dfe68ee07a7b901d9e7f200b
("batman-adv: make the TT CRC logic VLAN specific")

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 translation-table.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index 05c2a9b..24e3267 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1961,6 +1961,7 @@ static uint32_t batadv_tt_global_crc(struct batadv_priv *bat_priv,
 	struct hlist_head *head;
 	uint32_t i, crc_tmp, crc = 0;
 	uint8_t flags;
+	__be16 tmp_vid;
 
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
@@ -1997,8 +1998,11 @@ static uint32_t batadv_tt_global_crc(struct batadv_priv *bat_priv,
 							     orig_node))
 				continue;
 
-			crc_tmp = crc32c(0, &tt_common->vid,
-					 sizeof(tt_common->vid));
+			/* use network order to read the VID: this ensures that
+			 * every node reads the bytes in the same order.
+			 */
+			tmp_vid = htons(tt_common->vid);
+			crc_tmp = crc32c(0, &tmp_vid, sizeof(tmp_vid));
 
 			/* compute the CRC on flags that have to be kept in sync
 			 * among nodes
@@ -2032,6 +2036,7 @@ static uint32_t batadv_tt_local_crc(struct batadv_priv *bat_priv,
 	struct hlist_head *head;
 	uint32_t i, crc_tmp, crc = 0;
 	uint8_t flags;
+	__be16 tmp_vid;
 
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
@@ -2050,8 +2055,11 @@ static uint32_t batadv_tt_local_crc(struct batadv_priv *bat_priv,
 			if (tt_common->flags & BATADV_TT_CLIENT_NEW)
 				continue;
 
-			crc_tmp = crc32c(0, &tt_common->vid,
-					 sizeof(tt_common->vid));
+			/* use network order to read the VID: this ensures that
+			 * every node reads the bytes in the same order.
+			 */
+			tmp_vid = htons(tt_common->vid);
+			crc_tmp = crc32c(0, &tmp_vid, sizeof(tmp_vid));
 
 			/* compute the CRC on flags that have to be kept in sync
 			 * among nodes
-- 
1.8.5.3


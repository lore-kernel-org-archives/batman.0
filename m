Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Mon, 17 Feb 2014 21:48:46 +0100
Message-Id: <1392670129-2498-8-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1392670129-2498-1-git-send-email-antonio@meshcoding.com>
References: <1392670129-2498-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 07/10] batman-adv: fix TT CRC computation by
	ensuring byte order
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@open-mesh.com>

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

Introduced by 7ea7b4a142758deaf46c1af0ca9ceca6dd55138b
("batman-adv: make the TT CRC logic VLAN specific")

Reported-by: Russel Senior <russell@personaltelco.net>
Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
Tested-by: Russell Senior <russell@personaltelco.net>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 net/batman-adv/translation-table.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index c21c557..959dde7 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1975,6 +1975,7 @@ static uint32_t batadv_tt_global_crc(struct batadv_priv *bat_priv,
 	struct hlist_head *head;
 	uint32_t i, crc_tmp, crc = 0;
 	uint8_t flags;
+	__be16 tmp_vid;
 
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
@@ -2011,8 +2012,11 @@ static uint32_t batadv_tt_global_crc(struct batadv_priv *bat_priv,
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
@@ -2046,6 +2050,7 @@ static uint32_t batadv_tt_local_crc(struct batadv_priv *bat_priv,
 	struct hlist_head *head;
 	uint32_t i, crc_tmp, crc = 0;
 	uint8_t flags;
+	__be16 tmp_vid;
 
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
@@ -2064,8 +2069,11 @@ static uint32_t batadv_tt_local_crc(struct batadv_priv *bat_priv,
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


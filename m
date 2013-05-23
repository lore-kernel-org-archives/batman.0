Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 23 May 2013 22:15:17 +0200
Message-Id: <1369340122-2660-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1369340122-2660-1-git-send-email-ordex@autistici.org>
References: <1369340122-2660-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 2/7] batman-adv: use vid when computing
	local and global TT CRC
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

now that each TT entry is characterised by a VLAN ID, the
latter has to be taken into consideration when computing the
local/global table CRC as it would be theoretically possible
to have the same client in two different VLANs

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 translation-table.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index bcf0f19..c13f5ed 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1495,6 +1495,24 @@ out:
  * batadv_tt_global_crc - calculates the checksum of the local table belonging
  *  to the given orig_node
  * @bat_priv: the bat priv with all the soft interface information
+ * @orig_node: originator for which the CRC should be computed
+ *
+ * This function computes the checksum for the global table corresponding to a
+ * particular originator. In particular the checksum is computed as follows: for
+ * each client connected to the originator the CRC32C of the MAC address and the
+ * VID is computed and then all the CRC32Cs of the various clients are xor'ed
+ * together.
+ *
+ * The idea behind is that CRC32C should be used as much as possible in order to
+ * produce a unique hash of the table, but since the order which is used to feed
+ * the CRC32C function affects the result and since every node in the network
+ * probably sorts the clients differently, the hash function cannot be directly
+ * computed over the entire table. Hence the CRC32C is used only on
+ * the single client entry, while all the results are then xor'ed together
+ * because the XOR operation can combine them all while trying to reduce the
+ * noise as much as possible.
+ *
+ * Returns the checksum of the global table of a given originator
  */
 static uint32_t batadv_tt_global_crc(struct batadv_priv *bat_priv,
 				     struct batadv_orig_node *orig_node)
@@ -1503,7 +1521,7 @@ static uint32_t batadv_tt_global_crc(struct batadv_priv *bat_priv,
 	struct batadv_tt_common_entry *tt_common;
 	struct batadv_tt_global_entry *tt_global;
 	struct hlist_head *head;
-	uint32_t i, crc = 0;
+	uint32_t i, crc_tmp, crc = 0;
 
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
@@ -1534,7 +1552,9 @@ static uint32_t batadv_tt_global_crc(struct batadv_priv *bat_priv,
 							     orig_node))
 				continue;
 
-			crc ^= crc32c(0, tt_common->addr, ETH_ALEN);
+			crc_tmp = crc32c(0, &tt_common->vid,
+					 sizeof(tt_common->vid));
+			crc ^= crc32c(crc_tmp, tt_common->addr, ETH_ALEN);
 		}
 		rcu_read_unlock();
 	}
@@ -1545,13 +1565,18 @@ static uint32_t batadv_tt_global_crc(struct batadv_priv *bat_priv,
 /**
  * batadv_tt_local_crc - calculates the checksum of the local table
  * @bat_priv: the bat priv with all the soft interface information
+ *
+ * For details about the computation, please refer to the documentation for
+ * batadv_tt_global_crc().
+ *
+ * Returns the checksum of the local table
  */
 static uint32_t batadv_tt_local_crc(struct batadv_priv *bat_priv)
 {
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
 	struct batadv_tt_common_entry *tt_common;
 	struct hlist_head *head;
-	uint32_t i, crc = 0;
+	uint32_t i, crc_tmp, crc = 0;
 
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
@@ -1564,7 +1589,9 @@ static uint32_t batadv_tt_local_crc(struct batadv_priv *bat_priv)
 			if (tt_common->flags & BATADV_TT_CLIENT_NEW)
 				continue;
 
-			crc ^= crc32c(0, tt_common->addr, ETH_ALEN);
+			crc_tmp = crc32c(0, &tt_common->vid,
+					 sizeof(tt_common->vid));
+			crc ^= crc32c(crc_tmp, tt_common->addr, ETH_ALEN);
 		}
 		rcu_read_unlock();
 	}
-- 
1.8.1.5


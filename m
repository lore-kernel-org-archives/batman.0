Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sun, 13 Oct 2013 02:50:20 +0200
Message-Id: <1381625420-4062-5-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1381625420-4062-1-git-send-email-antonio@meshcoding.com>
References: <1381625420-4062-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCHv2 4/4] batman-adv: include the synch-flags
	when compute the global/local table CRC
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

Flags covered by TT_SYNCH_MASK are kept in sync among the
nodes in the network and therefore they have to be
considered while computing the global/local table CRC.

In this way a generic originator is able to understand if
its table contains the correct flags or not.

Bits from 4 to 7 in the TT flags fields are now reserved for
"synchronized" flags only.

This allows future developers to add more flags of this type
without breaking compatibility.

It's important to note that not all the remote TT flags are
synchronised. This comes from the fact that some flags are
used to inject an information once only.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 packet.h            | 11 +++++++++--
 translation-table.c | 19 +++++++++++++++++++
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/packet.h b/packet.h
index bf4c91f..4683241 100644
--- a/packet.h
+++ b/packet.h
@@ -110,12 +110,13 @@ enum batadv_tt_data_flags {
 
 /* BATADV_TT_CLIENT flags.
  * Flags from BIT(0) to BIT(7) are sent on the wire, while flags from BIT(8) to
- * BIT(15) are used for local computation only
+ * BIT(15) are used for local computation only.
+ * Flags from BIT(4) to BIT(7) are kept in synch with the rest of the network.
  */
 enum batadv_tt_client_flags {
 	BATADV_TT_CLIENT_DEL     = BIT(0),
 	BATADV_TT_CLIENT_ROAM    = BIT(1),
-	BATADV_TT_CLIENT_WIFI    = BIT(2),
+	BATADV_TT_CLIENT_WIFI    = BIT(4),
 	BATADV_TT_CLIENT_NOPURGE = BIT(8),
 	BATADV_TT_CLIENT_NEW     = BIT(9),
 	BATADV_TT_CLIENT_PENDING = BIT(10),
@@ -129,6 +130,12 @@ enum batadv_tt_client_flags {
 #define BATADV_TT_REMOTE_MASK	0x00FF
 
 /**
+ * BATADV_TT_SYNCH_MASK - bitmask of the flags that need to be kept in sync
+ *  among the nodes. These flags are used to compute the global/local CRC
+ */
+#define BATADV_TT_SYNCH_MASK	0x00F0
+
+/**
  * batadv_vlan_flags - flags for the four MSB of any vlan ID field
  * @BATADV_VLAN_HAS_TAG: whether the field contains a valid vlan tag or not
  */
diff --git a/translation-table.c b/translation-table.c
index 4212e9a..538b86f 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1960,6 +1960,7 @@ static uint32_t batadv_tt_global_crc(struct batadv_priv *bat_priv,
 	struct batadv_tt_global_entry *tt_global;
 	struct hlist_head *head;
 	uint32_t i, crc_tmp, crc = 0;
+	uint8_t flags;
 
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
@@ -1998,6 +1999,13 @@ static uint32_t batadv_tt_global_crc(struct batadv_priv *bat_priv,
 
 			crc_tmp = crc32c(0, &tt_common->vid,
 					 sizeof(tt_common->vid));
+
+			/* compute the CRC on flags that have to be kept in sync
+			 * among nodes
+			 */
+			flags = tt_common->flags & BATADV_TT_SYNCH_MASK;
+			crc_tmp = crc32c(crc_tmp, &flags, sizeof(flags));
+
 			crc ^= crc32c(crc_tmp, tt_common->addr, ETH_ALEN);
 		}
 		rcu_read_unlock();
@@ -2023,6 +2031,7 @@ static uint32_t batadv_tt_local_crc(struct batadv_priv *bat_priv,
 	struct batadv_tt_common_entry *tt_common;
 	struct hlist_head *head;
 	uint32_t i, crc_tmp, crc = 0;
+	uint8_t flags;
 
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
@@ -2043,6 +2052,13 @@ static uint32_t batadv_tt_local_crc(struct batadv_priv *bat_priv,
 
 			crc_tmp = crc32c(0, &tt_common->vid,
 					 sizeof(tt_common->vid));
+
+			/* compute the CRC on flags that have to be kept in sync
+			 * among nodes
+			 */
+			flags = tt_common->flags & BATADV_TT_SYNCH_MASK;
+			crc_tmp = crc32c(crc_tmp, &flags, sizeof(flags));
+
 			crc ^= crc32c(crc_tmp, tt_common->addr, ETH_ALEN);
 		}
 		rcu_read_unlock();
@@ -3525,6 +3541,9 @@ int batadv_tt_init(struct batadv_priv *bat_priv)
 {
 	int ret;
 
+	/* synchronized flags must be remote */
+	BUILD_BUG_ON(!(BATADV_TT_SYNCH_MASK & BATADV_TT_REMOTE_MASK));
+
 	ret = batadv_tt_local_init(bat_priv);
 	if (ret < 0)
 		return ret;
-- 
1.8.3.2


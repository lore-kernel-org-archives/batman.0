Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 23 Apr 2013 23:45:27 +0200
Message-Id: <1366753527-17171-4-git-send-email-ordex@autistici.org>
In-Reply-To: <1366753527-17171-1-git-send-email-ordex@autistici.org>
References: <1366753527-17171-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: compute the global/local
	table CRC using the synch flags
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

Flags selected by TT_SYNCH_MASK are kept in sync among the
nodes in the network and therefore they have to be
considered while computing the global/local table CRC so
that a generic originator is able to realise if its table
contains all the correct flags too

Flags from bit 4 to bit 7 are now reserved for synchronized
flags only. This allows future developers to add more flags
of this type in the future without breaking compatibility
again.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 packet.h            |  8 +++++++-
 translation-table.c | 19 +++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/packet.h b/packet.h
index 02cba21..dd14c58 100644
--- a/packet.h
+++ b/packet.h
@@ -117,7 +117,7 @@ enum batadv_tt_data_flags {
 enum batadv_tt_client_flags {
 	BATADV_TT_CLIENT_DEL     = BIT(0),
 	BATADV_TT_CLIENT_ROAM    = BIT(1),
-	BATADV_TT_CLIENT_WIFI    = BIT(2),
+	BATADV_TT_CLIENT_WIFI    = BIT(4),
 	BATADV_TT_CLIENT_NOPURGE = BIT(8),
 	BATADV_TT_CLIENT_NEW     = BIT(9),
 	BATADV_TT_CLIENT_PENDING = BIT(10),
@@ -131,6 +131,12 @@ enum batadv_tt_client_flags {
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
index 9dc4207..b326983 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1565,6 +1565,7 @@ static uint32_t batadv_tt_global_crc(struct batadv_priv *bat_priv,
 	struct batadv_tt_global_entry *tt_global;
 	struct hlist_head *head;
 	uint32_t i, crc_tmp, crc = 0;
+	uint8_t flags;
 
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
@@ -1597,6 +1598,13 @@ static uint32_t batadv_tt_global_crc(struct batadv_priv *bat_priv,
 
 			crc_tmp = crc32c(0, &tt_common->vid,
 					 sizeof(tt_common->vid));
+
+			/* compute the CRC also over the flags that have to be
+			 * kept in sync among nodes
+			 */
+			flags = tt_common->flags & BATADV_TT_SYNCH_MASK;
+			crc_tmp = crc32c(crc_tmp, &flags, sizeof(flags));
+
 			crc ^= crc32c(crc_tmp, tt_common->addr, ETH_ALEN);
 		}
 		rcu_read_unlock();
@@ -1615,6 +1623,7 @@ static uint32_t batadv_tt_local_crc(struct batadv_priv *bat_priv)
 	struct batadv_tt_common_entry *tt_common;
 	struct hlist_head *head;
 	uint32_t i, crc_tmp, crc = 0;
+	uint8_t flags;
 
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
@@ -1629,6 +1638,13 @@ static uint32_t batadv_tt_local_crc(struct batadv_priv *bat_priv)
 
 			crc_tmp = crc32c(0, &tt_common->vid,
 					 sizeof(tt_common->vid));
+
+			/* compute the CRC also over the flags that have to be
+			 * kept in sync among nodes
+			 */
+			flags = tt_common->flags & BATADV_TT_SYNCH_MASK;
+			crc_tmp = crc32c(crc_tmp, &flags, sizeof(flags));
+
 			crc ^= crc32c(crc_tmp, tt_common->addr, ETH_ALEN);
 		}
 		rcu_read_unlock();
@@ -2917,6 +2933,9 @@ int batadv_tt_init(struct batadv_priv *bat_priv)
 {
 	int ret;
 
+	/* synchronized flags must be remote */
+	BUILD_BUG_ON(!(BATADV_TT_SYNCH_MASK & BATADV_TT_REMOTE_MASK));
+
 	ret = batadv_tt_local_init(bat_priv);
 	if (ret < 0)
 		return ret;
-- 
1.8.1.5


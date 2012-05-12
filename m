Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 12 May 2012 13:48:52 +0200
Message-Id: <1336823339-4095-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/8] batman-adv: Move hash_ipv4 to
	distributed-arp-table.c
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

hash_ipv4 is only used in distributed-arp-table.c and therefore can be placed
inside this file instead of the header.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 distributed-arp-table.c |   24 +++++++++++++++++++++++-
 distributed-arp-table.h |   22 ----------------------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index e678ec4..4894a85 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -32,6 +32,28 @@
 #include "translation-table.h"
 #include "unicast.h"
 
+/* hash function to choose an entry in a hash table of given size.
+ * hash algorithm from http://en.wikipedia.org/wiki/Hash_table
+ */
+static uint32_t batadv_hash_ipv4(const void *data, uint32_t size)
+{
+	const unsigned char *key = data;
+	uint32_t hash = 0;
+	size_t i;
+
+	for (i = 0; i < 4; i++) {
+		hash += key[i];
+		hash += (hash << 10);
+		hash ^= (hash >> 6);
+	}
+
+	hash += (hash << 3);
+	hash ^= (hash >> 11);
+	hash += (hash << 15);
+
+	return hash % size;
+}
+
 #ifdef CONFIG_BATMAN_ADV_DEBUG
 
 static void bat_dbg_arp(struct bat_priv *bat_priv, struct sk_buff *skb,
@@ -214,7 +236,7 @@ static struct dht_candidate *dht_select_candidates(struct bat_priv *bat_priv,
 	if (!res)
 		return NULL;
 
-	ip_key = (dat_addr_t)hash_ipv4(&ip_dst, DAT_ADDR_MAX);
+	ip_key = (dat_addr_t)batadv_hash_ipv4(&ip_dst, DAT_ADDR_MAX);
 
 	bat_dbg(DBG_DAT, bat_priv,
 		"dht_select_candidates(): IP=%pI4 hash(IP)=%u\n", &ip_dst,
diff --git a/distributed-arp-table.h b/distributed-arp-table.h
index 1ba7f01..ee5200a 100644
--- a/distributed-arp-table.h
+++ b/distributed-arp-table.h
@@ -49,28 +49,6 @@ bool batadv_dat_drop_broadcast_packet(struct bat_priv *bat_priv,
 				      struct forw_packet *forw_packet);
 void batadv_arp_change_timeout(struct net_device *soft_iface, const char *name);
 
-/* hash function to choose an entry in a hash table of given size.
- * hash algorithm from http://en.wikipedia.org/wiki/Hash_table
- */
-static inline uint32_t hash_ipv4(const void *data, uint32_t size)
-{
-	const unsigned char *key = data;
-	uint32_t hash = 0;
-	size_t i;
-
-	for (i = 0; i < 4; i++) {
-		hash += key[i];
-		hash += (hash << 10);
-		hash ^= (hash >> 6);
-	}
-
-	hash += (hash << 3);
-	hash ^= (hash >> 11);
-	hash += (hash << 15);
-
-	return hash % size;
-}
-
 static inline void
 batadv_dat_init_orig_node_dht_addr(struct orig_node *orig_node)
 {
-- 
1.7.10


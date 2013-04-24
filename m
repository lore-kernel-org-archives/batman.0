Return-Path: <mihail.costea2005@gmail.com>
From: Mihail <mihail.costea2005@gmail.com>
Date: Wed, 24 Apr 2013 08:17:46 +0300
Message-Id: <1366780666-5094-1-git-send-email-mihail.costea2005@gmail.com>
Subject: [B.A.T.M.A.N.] [PATCH 1/1] Added generic function for transforming
	DAT data to string
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

Signed-off-by: Mihail Costea <mihail.costea90@gmail.com>
Signed-off-by: Stefan Popa <Stefan.A.Popa@intel.com>
Reviewed-by: Stefan Popa <Stefan.A.Popa@intel.com>

---
The function added in this patch is used in order to avoid defining
different debug messages for different DAT data types. For example,
if we had IPv6 as a DAT data, then "%pI4" should be "%pI6c", but all
the other text of the debug message would be the same.

 distributed-arp-table.c |   43 +++++++++++++++++++++++++++++++++++++------
 distributed-arp-table.h |    1 +
 2 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 2cb5ebb..5073b01 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -31,9 +31,29 @@
 #include "translation-table.h"
 #include "unicast.h"
 
+static char *batadv_dat_types_str_fmt[] = {
+	"%pI4",
+};
+
 static void batadv_dat_purge(struct work_struct *work);
 
 /**
+ * batadv_dat_data_to_str: transforms DAT data to string
+ * @data: the DAT data
+ * @type: type of data
+ * @buf: the buf where the data string is stored
+ * @buf_len: buf length
+ *
+ * Returns buf.
+ */
+static char *batadv_dat_data_to_str(void *data, uint8_t type,
+				    char *buf, size_t buf_len)
+{
+	snprintf(buf, buf_len, batadv_dat_types_str_fmt[type], data);
+	return buf;
+}
+
+/**
  * batadv_dat_start_timer - initialise the DAT periodic worker
  * @bat_priv: the bat priv with all the soft interface information
  */
@@ -272,6 +292,7 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 {
 	struct batadv_dat_entry *dat_entry;
 	int hash_added;
+	char dbg_data[BATADV_DAT_DATA_MAX_LEN];
 
 	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip);
 	/* if this entry is already known, just update it */
@@ -279,8 +300,10 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 		if (!batadv_compare_eth(dat_entry->mac_addr, mac_addr))
 			memcpy(dat_entry->mac_addr, mac_addr, ETH_ALEN);
 		dat_entry->last_update = jiffies;
-		batadv_dbg(BATADV_DBG_DAT, bat_priv,
-			   "Entry updated: %pI4 %pM\n", &dat_entry->ip,
+		batadv_dbg(BATADV_DBG_DAT, bat_priv, "Entry updated: %s %pM\n",
+			   batadv_dat_data_to_str(&dat_entry->ip,
+						  BATADV_DAT_IPV4, dbg_data,
+						  sizeof(dbg_data)),
 			   dat_entry->mac_addr);
 		goto out;
 	}
@@ -305,8 +328,10 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 		goto out;
 	}
 
-	batadv_dbg(BATADV_DBG_DAT, bat_priv, "New entry added: %pI4 %pM\n",
-		   &dat_entry->ip, dat_entry->mac_addr);
+	batadv_dbg(BATADV_DBG_DAT, bat_priv, "New entry added: %s %pM\n",
+		   batadv_dat_data_to_str(&dat_entry->ip, BATADV_DAT_IPV4,
+					  dbg_data, sizeof(dbg_data)),
+		   dat_entry->mac_addr);
 
 out:
 	if (dat_entry)
@@ -528,6 +553,7 @@ batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst)
 	int select;
 	batadv_dat_addr_t last_max = BATADV_DAT_ADDR_MAX, ip_key;
 	struct batadv_dat_candidate *res;
+	char dbg_data[BATADV_DAT_DATA_MAX_LEN];
 
 	if (!bat_priv->orig_hash)
 		return NULL;
@@ -540,7 +566,9 @@ batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst)
 						    BATADV_DAT_ADDR_MAX);
 
 	batadv_dbg(BATADV_DBG_DAT, bat_priv,
-		   "dat_select_candidates(): IP=%pI4 hash(IP)=%u\n", &ip_dst,
+		   "dat_select_candidates(): IP=%s hash(IP)=%u\n",
+		   batadv_dat_data_to_str(&ip_dst, BATADV_DAT_IPV4,
+					  dbg_data, sizeof(dbg_data)),
 		   ip_key);
 
 	for (select = 0; select < BATADV_DAT_CANDIDATES_NUM; select++)
@@ -573,12 +601,15 @@ static bool batadv_dat_send_data(struct batadv_priv *bat_priv,
 	struct batadv_neigh_node *neigh_node = NULL;
 	struct sk_buff *tmp_skb;
 	struct batadv_dat_candidate *cand;
+	char dbg_data[BATADV_DAT_DATA_MAX_LEN];
 
 	cand = batadv_dat_select_candidates(bat_priv, ip);
 	if (!cand)
 		goto out;
 
-	batadv_dbg(BATADV_DBG_DAT, bat_priv, "DHT_SEND for %pI4\n", &ip);
+	batadv_dbg(BATADV_DBG_DAT, bat_priv, "DHT_SEND for %s\n",
+		   batadv_dat_data_to_str(&ip, BATADV_DAT_IPV4, dbg_data,
+					  sizeof(dbg_data)));
 
 	for (i = 0; i < BATADV_DAT_CANDIDATES_NUM; i++) {
 		if (cand[i].type == BATADV_DAT_CANDIDATE_NOT_FOUND)
diff --git a/distributed-arp-table.h b/distributed-arp-table.h
index 125c8c6..752c61d 100644
--- a/distributed-arp-table.h
+++ b/distributed-arp-table.h
@@ -28,6 +28,7 @@
 #include <linux/if_arp.h>
 
 #define BATADV_DAT_ADDR_MAX ((batadv_dat_addr_t)~(batadv_dat_addr_t)0)
+#define BATADV_DAT_DATA_MAX_LEN 16
 
 bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 					   struct sk_buff *skb);
-- 
1.7.10.4


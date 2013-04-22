Return-Path: <mihail.costea2005@gmail.com>
From: YourName <mihail.costea2005@gmail.com>
Date: Mon, 22 Apr 2013 14:12:18 +0300
Message-Id: <1366629138-28627-1-git-send-email-mihail.costea2005@gmail.com>
Subject: [B.A.T.M.A.N.] [PATCH] Added generic transformer to string function
	for DAT data
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

 distributed-arp-table.c |   71 +++++++++++++++++++++++++++++++++++++++++------
 types.h                 |    8 ++++++
 2 files changed, 70 insertions(+), 9 deletions(-)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 3a3e1d8..5df8f19 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -34,6 +34,36 @@
 static void batadv_dat_purge(struct work_struct *work);
 
 /**
+ * batadv_dat_data_to_str: transforms DAT data to string
+ * @data: the DAT data
+ * @type: type of data
+ *
+ * Returns the string representation of data. This should be freed with kfree.
+ */
+static char *batadv_dat_data_to_str(void *data, uint8_t type)
+{
+	size_t buf_size;
+	char *buf, *format_type, ipv4[] = "%pI4";
+
+	switch (type) {
+	case BATADV_DAT_IPV4:
+		/* maximum length for an IPv4 string representation + NULL */
+		buf_size = 16;
+		format_type = ipv4;
+		break;
+	default:
+		return NULL;
+	}
+
+	buf = kmalloc(buf_size, GFP_ATOMIC);
+	if (!buf)
+		return NULL;
+	snprintf(buf, buf_size, format_type, data);
+
+	return buf;
+}
+
+/**
  * batadv_dat_start_timer - initialise the DAT periodic worker
  * @bat_priv: the bat priv with all the soft interface information
  */
@@ -272,6 +302,7 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 {
 	struct batadv_dat_entry *dat_entry;
 	int hash_added;
+	char *dbg_data;
 
 	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip);
 	/* if this entry is already known, just update it */
@@ -279,9 +310,15 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 		if (!batadv_compare_eth(dat_entry->mac_addr, mac_addr))
 			memcpy(dat_entry->mac_addr, mac_addr, ETH_ALEN);
 		dat_entry->last_update = jiffies;
-		batadv_dbg(BATADV_DBG_DAT, bat_priv,
-			   "Entry updated: %pI4 %pM\n", &dat_entry->ip,
-			   dat_entry->mac_addr);
+
+		dbg_data = batadv_dat_data_to_str(&dat_entry->ip,
+						  BATADV_DAT_IPV4);
+		if (dbg_data) {
+			batadv_dbg(BATADV_DBG_DAT, bat_priv,
+				   "Entry updated: %s %pM\n", dbg_data,
+				   dat_entry->mac_addr);
+			kfree(dbg_data);
+		}
 		goto out;
 	}
 
@@ -304,8 +341,13 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 		goto out;
 	}
 
-	batadv_dbg(BATADV_DBG_DAT, bat_priv, "New entry added: %pI4 %pM\n",
-		   &dat_entry->ip, dat_entry->mac_addr);
+	dbg_data = batadv_dat_data_to_str(&dat_entry->ip, BATADV_DAT_IPV4);
+	if (dbg_data) {
+		batadv_dbg(BATADV_DBG_DAT, bat_priv,
+			   "New entry added: %s %pM\n", dbg_data,
+			   dat_entry->mac_addr);
+		kfree(dbg_data);
+	}
 
 out:
 	if (dat_entry)
@@ -527,6 +569,7 @@ batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst)
 	int select;
 	batadv_dat_addr_t last_max = BATADV_DAT_ADDR_MAX, ip_key;
 	struct batadv_dat_candidate *res;
+	char *dbg_data;
 
 	if (!bat_priv->orig_hash)
 		return NULL;
@@ -538,9 +581,13 @@ batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst)
 	ip_key = (batadv_dat_addr_t)batadv_hash_dat(&ip_dst,
 						    BATADV_DAT_ADDR_MAX);
 
-	batadv_dbg(BATADV_DBG_DAT, bat_priv,
-		   "dat_select_candidates(): IP=%pI4 hash(IP)=%u\n", &ip_dst,
-		   ip_key);
+	dbg_data = batadv_dat_data_to_str(&ip_dst, BATADV_DAT_IPV4);
+	if (dbg_data) {
+		batadv_dbg(BATADV_DBG_DAT, bat_priv,
+			   "dat_select_candidates(): IP=%s hash(IP)=%u\n",
+			   dbg_data, ip_key);
+		kfree(dbg_data);
+	}
 
 	for (select = 0; select < BATADV_DAT_CANDIDATES_NUM; select++)
 		batadv_choose_next_candidate(bat_priv, res, select, ip_key,
@@ -572,12 +619,18 @@ static bool batadv_dat_send_data(struct batadv_priv *bat_priv,
 	struct batadv_neigh_node *neigh_node = NULL;
 	struct sk_buff *tmp_skb;
 	struct batadv_dat_candidate *cand;
+	char *dbg_data;
 
 	cand = batadv_dat_select_candidates(bat_priv, ip);
 	if (!cand)
 		goto out;
 
-	batadv_dbg(BATADV_DBG_DAT, bat_priv, "DHT_SEND for %pI4\n", &ip);
+	dbg_data = batadv_dat_data_to_str(&ip, BATADV_DAT_IPV4);
+	if (dbg_data) {
+		batadv_dbg(BATADV_DBG_DAT, bat_priv,
+			   "DHT_SEND for %s\n", dbg_data);
+		kfree(dbg_data);
+	}
 
 	for (i = 0; i < BATADV_DAT_CANDIDATES_NUM; i++) {
 		if (cand[i].type == BATADV_DAT_CANDIDATE_NOT_FOUND)
diff --git a/types.h b/types.h
index b2c94e1..3488528 100644
--- a/types.h
+++ b/types.h
@@ -980,6 +980,14 @@ struct batadv_dat_entry {
 };
 
 /**
+ * batadv_dat_types - types used in batadv_dat_entry for IP
+ * @BATADV_DAT_IPv4: IPv4 address type
+ */
+enum batadv_dat_types {
+	BATADV_DAT_IPV4,
+};
+
+/**
  * struct batadv_dat_candidate - candidate destination for DAT operations
  * @type: the type of the selected candidate. It can one of the following:
  *	  - BATADV_DAT_CANDIDATE_NOT_FOUND
-- 
1.7.10.4


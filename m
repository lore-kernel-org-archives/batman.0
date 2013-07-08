Return-Path: <mihail.costea2005@gmail.com>
From: mihail.costea2005@gmail.com
Date: Mon,  8 Jul 2013 03:12:42 +0300
Message-Id: <1373242365-763-3-git-send-email-mihail.costea2005@gmail.com>
In-Reply-To: <1373242365-763-1-git-send-email-mihail.costea2005@gmail.com>
References: <1373242365-763-1-git-send-email-mihail.costea2005@gmail.com>
Subject: [B.A.T.M.A.N.] [RFC 3/6] batman-adv: Adds IPv6 to DAT and generic
	struct in distributed-arp-table.c
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

From: Mihail Costea <mihail.costea90@gmail.com>

Adds IPv6 functionality to the generic struct.

Signed-off-by: Mihail Costea <mihail.costea90@gmail.com>
Signed-off-by: Stefan Popa <Stefan.A.Popa@intel.com>
Reviewed-by: Stefan Popa <Stefan.A.Popa@intel.com>

---
 distributed-arp-table.c |   12 +++++++++---
 distributed-arp-table.h |    2 +-
 types.h                 |    6 +++++-
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index b2a4fe5..f941913 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -36,6 +36,12 @@ static struct batadv_dat_type_info batadv_dat_types_info[] = {
 		.size = sizeof(__be32),
 		.str_fmt = "%pI4",
 	},
+#if IS_ENABLED(CONFIG_IPV6)
+	{
+		.size = sizeof(struct in6_addr),
+		.str_fmt = "%pI6c",
+	},
+#endif
 };
 
 static void batadv_dat_purge(struct work_struct *work);
@@ -845,8 +851,8 @@ int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset)
 		goto out;
 
 	seq_printf(seq, "Distributed ARP Table (%s):\n", net_dev->name);
-	seq_printf(seq, "          %-7s          %-13s %5s\n", "IPv4", "MAC",
-		   "last-seen");
+	seq_printf(seq, "                       %-26s %-15s %5s\n",
+		   "IPv4/IPv6", "MAC", "last-seen");
 
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
@@ -859,7 +865,7 @@ int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset)
 			last_seen_msecs = last_seen_msecs % 60000;
 			last_seen_secs = last_seen_msecs / 1000;
 
-			seq_printf(seq, " * %15s %14pM %6i:%02i\n",
+			seq_printf(seq, " * %40s %15pM %6i:%02i\n",
 				   batadv_dat_data_to_str(dat_entry->data,
 							  dat_entry->type,
 							  dbg_data,
diff --git a/distributed-arp-table.h b/distributed-arp-table.h
index 21d7b24..d029b4b 100644
--- a/distributed-arp-table.h
+++ b/distributed-arp-table.h
@@ -28,7 +28,7 @@
 #include <linux/if_arp.h>
 
 #define BATADV_DAT_ADDR_MAX ((batadv_dat_addr_t)~(batadv_dat_addr_t)0)
-#define BATADV_DAT_DATA_MAX_LEN 16
+#define BATADV_DAT_DATA_MAX_LEN 40
 
 void batadv_dat_status_update(struct net_device *net_dev);
 bool batadv_dat_snoop_outgoing_pkt_request(struct batadv_priv *bat_priv,
diff --git a/types.h b/types.h
index 69c187e..60d2d64 100644
--- a/types.h
+++ b/types.h
@@ -953,10 +953,14 @@ struct batadv_dat_entry {
 
 /**
  * batadv_dat_types - types used in batadv_dat_entry for IP
- * @BATADV_DAT_IPv4: IPv4 address type
+ * @BATADV_DAT_IPV4: IPv4 address type
+ * @BATADV_DAT_IPV6: IPv6 address type
  */
 enum batadv_dat_types {
 	BATADV_DAT_IPV4 = 0,
+#if IS_ENABLED(CONFIG_IPV6)
+	BATADV_DAT_IPV6 = 1,
+#endif
 };
 
 /**
-- 
1.7.10.4


Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Thu,  7 Nov 2013 08:24:51 +0100
Message-Id: <1383809091-3887-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: use static string for table
	headers
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

Use a static string when showing table headers rather then
a nonsense parametric one with fixed arguments.

It is easier to grep and it does not need to be recomputed
at runtime each time.

Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 bat_iv_ogm.c            | 5 ++---
 bridge_loop_avoidance.c | 7 +++----
 distributed-arp-table.c | 4 ++--
 translation-table.c     | 9 ++++-----
 4 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 409cb16..553f8e4 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -1546,9 +1546,8 @@ static void batadv_iv_ogm_orig_print(struct batadv_priv *bat_priv,
 	int batman_count = 0;
 	uint32_t i;
 
-	seq_printf(seq, "  %-15s %s (%s/%i) %17s [%10s]: %20s ...\n",
-		   "Originator", "last-seen", "#", BATADV_TQ_MAX_VALUE,
-		   "Nexthop", "outgoingIF", "Potential nexthops");
+	seq_puts(seq,
+		 "  Originator      last-seen (#/" __stringify(BATADV_TQ_MAX_VALUE) ")           Nexthop [outgoingIF]:   Potential nexthops ...\n");
 
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 4382127..0c83809 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -1613,8 +1613,8 @@ int batadv_bla_claim_table_seq_print_text(struct seq_file *seq, void *offset)
 		   "Claims announced for the mesh %s (orig %pM, group id %#.4x)\n",
 		   net_dev->name, primary_addr,
 		   ntohs(bat_priv->bla.claim_dest.group));
-	seq_printf(seq, "   %-17s    %-5s    %-17s [o] (%-6s)\n",
-		   "Client", "VID", "Originator", "CRC");
+	seq_puts(seq,
+		 "   Client               VID      Originator        [o] (CRC   )\n");
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
 
@@ -1658,8 +1658,7 @@ int batadv_bla_backbone_table_seq_print_text(struct seq_file *seq, void *offset)
 		   "Backbones announced for the mesh %s (orig %pM, group id %#.4x)\n",
 		   net_dev->name, primary_addr,
 		   ntohs(bat_priv->bla.claim_dest.group));
-	seq_printf(seq, "   %-17s    %-5s %-9s (%-6s)\n",
-		   "Originator", "VID", "last seen", "CRC");
+	seq_puts(seq, "   Originator           VID   last seen (CRC   )\n");
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
 
diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index ed4b97a..4ba2d7d 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -756,8 +756,8 @@ int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset)
 		goto out;
 
 	seq_printf(seq, "Distributed ARP Table (%s):\n", net_dev->name);
-	seq_printf(seq, "          %-7s          %-9s %4s %11s\n", "IPv4",
-		   "MAC", "VID", "last-seen");
+	seq_puts(seq,
+		 "          IPv4             MAC        VID   last-seen\n");
 
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
diff --git a/translation-table.c b/translation-table.c
index 5957bad..6abb240 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -869,8 +869,8 @@ int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 	seq_printf(seq,
 		   "Locally retrieved addresses (from %s) announced via TT (TTVN: %u):\n",
 		   net_dev->name, (uint8_t)atomic_read(&bat_priv->tt.vn));
-	seq_printf(seq, "       %-13s  %s %-7s %-9s (%-10s)\n", "Client", "VID",
-		   "Flags", "Last seen", "CRC");
+	seq_puts(seq,
+		 "       Client         VID Flags    Last seen (CRC       )\n");
 
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
@@ -1503,9 +1503,8 @@ int batadv_tt_global_seq_print_text(struct seq_file *seq, void *offset)
 	seq_printf(seq,
 		   "Globally announced TT entries received via the mesh %s\n",
 		   net_dev->name);
-	seq_printf(seq, "       %-13s  %s  %s       %-15s %s (%-10s) %s\n",
-		   "Client", "VID", "(TTVN)", "Originator", "(Curr TTVN)",
-		   "CRC", "Flags");
+	seq_puts(seq,
+		 "       Client         VID  (TTVN)       Originator      (Curr TTVN) (CRC       ) Flags\n");
 
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
-- 
1.8.4.2


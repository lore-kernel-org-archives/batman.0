Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun,  6 Jun 2010 21:28:21 +0200
Message-Id: <1275852501-28523-10-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1275852501-28523-1-git-send-email-sven.eckelmann@gmx.de>
References: <1275852501-28523-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 9/9] Staging: batman-adv: Convert MAC_FMT to
	%pM
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
To: gregkh@suse.de, b.a.t.m.a.n@lists.open-mesh.net
Cc: Joe Perches <joe@perches.com>

From: Joe Perches <joe@perches.com>

Remove the last uses of MAC_FMT

Signed-off-by: Joe Perches <joe@perches.com>
[sven.eckelmann@gmx.de: Adapted for current batman-adv version]
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/main.c              |    3 +--
 drivers/staging/batman-adv/translation-table.c |   24 ++++--------------------
 2 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/batman-adv/main.c b/drivers/staging/batman-adv/main.c
index ed18b08..72fccb1 100644
--- a/drivers/staging/batman-adv/main.c
+++ b/drivers/staging/batman-adv/main.c
@@ -230,8 +230,7 @@ void dec_module_count(void)
 
 int addr_to_string(char *buff, uint8_t *addr)
 {
-	return sprintf(buff, MAC_FMT,
-		       addr[0], addr[1], addr[2], addr[3], addr[4], addr[5]);
+	return sprintf(buff, "%pM", addr);
 }
 
 /* returns 1 if they are the same originator */
diff --git a/drivers/staging/batman-adv/translation-table.c b/drivers/staging/batman-adv/translation-table.c
index 5a0264a..d9233b0 100644
--- a/drivers/staging/batman-adv/translation-table.c
+++ b/drivers/staging/batman-adv/translation-table.c
@@ -199,13 +199,8 @@ int hna_local_seq_print_text(struct seq_file *seq, void *offset)
 	while (hash_iterate(hna_local_hash, &hashit)) {
 		hna_local_entry = hashit.bucket->data;
 
-		pos += snprintf(buff + pos, 22, " * " MAC_FMT "\n",
-				hna_local_entry->addr[0],
-				hna_local_entry->addr[1],
-				hna_local_entry->addr[2],
-				hna_local_entry->addr[3],
-				hna_local_entry->addr[4],
-				hna_local_entry->addr[5]);
+		pos += snprintf(buff + pos, 22, " * %pM\n",
+				hna_local_entry->addr);
 	}
 
 	spin_unlock_irqrestore(&hna_local_hash_lock, flags);
@@ -417,19 +412,8 @@ int hna_global_seq_print_text(struct seq_file *seq, void *offset)
 		hna_global_entry = hashit.bucket->data;
 
 		pos += snprintf(buff + pos, 44,
-				" * " MAC_FMT " via " MAC_FMT "\n",
-				hna_global_entry->addr[0],
-				hna_global_entry->addr[1],
-				hna_global_entry->addr[2],
-				hna_global_entry->addr[3],
-				hna_global_entry->addr[4],
-				hna_global_entry->addr[5],
-				hna_global_entry->orig_node->orig[0],
-				hna_global_entry->orig_node->orig[1],
-				hna_global_entry->orig_node->orig[2],
-				hna_global_entry->orig_node->orig[3],
-				hna_global_entry->orig_node->orig[4],
-				hna_global_entry->orig_node->orig[5]);
+				" * %pM via %pM\n", hna_global_entry->addr,
+				hna_global_entry->orig_node->orig);
 	}
 
 	spin_unlock_irqrestore(&hna_global_hash_lock, flags);
-- 
1.7.1


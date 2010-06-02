Return-Path: <joe@perches.com>
From: Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 02 Jun 2010 13:10:18 -0700
Message-ID: <1275509418.23599.42.camel@Joe-Laptop.home>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] [PATCH] drivers/staging/batman-adv: Convert MAC_FMT
	to %pM
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
To: Marek Lindner <lindner_marek@yahoo.de>, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>, Andrew Lunn <andrew@lunn.ch>, Greg Kroah-Hartman <gregkh@suse.de>
Cc: devel <devel@driverdev.osuosl.org>, b.a.t.m.a.n@lists.open-mesh.net, linux-kernel@vger.kernel.org

Remove the last uses of MAC_FMT

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/staging/batman-adv/main.c              |    3 +-
 drivers/staging/batman-adv/translation-table.c |   25 ++++-------------------
 2 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/batman-adv/main.c b/drivers/staging/batman-adv/main.c
index 74c70d5..72851cd 100644
--- a/drivers/staging/batman-adv/main.c
+++ b/drivers/staging/batman-adv/main.c
@@ -226,8 +226,7 @@ void dec_module_count(void)
 
 int addr_to_string(char *buff, uint8_t *addr)
 {
-	return sprintf(buff, MAC_FMT,
-		       addr[0], addr[1], addr[2], addr[3], addr[4], addr[5]);
+	return sprintf(buff, "%pM", addr);
 }
 
 /* returns 1 if they are the same originator */
diff --git a/drivers/staging/batman-adv/translation-table.c b/drivers/staging/batman-adv/translation-table.c
index e01ff21..63d0967 100644
--- a/drivers/staging/batman-adv/translation-table.c
+++ b/drivers/staging/batman-adv/translation-table.c
@@ -202,13 +202,8 @@ int hna_local_fill_buffer_text(struct net_device *net_dev, char *buff,
 		hna_local_entry = hashit.bucket->data;
 
 		bytes_written += snprintf(buff + bytes_written, 22,
-					  " * " MAC_FMT "\n",
-					  hna_local_entry->addr[0],
-					  hna_local_entry->addr[1],
-					  hna_local_entry->addr[2],
-					  hna_local_entry->addr[3],
-					  hna_local_entry->addr[4],
-					  hna_local_entry->addr[5]);
+					  " * %pM\n",
+					  hna_local_entry->addr);
 	}
 
 	spin_unlock_irqrestore(&hna_local_hash_lock, flags);
@@ -420,19 +415,9 @@ int hna_global_fill_buffer_text(struct net_device *net_dev, char *buff,
 		hna_global_entry = hashit.bucket->data;
 
 		bytes_written += snprintf(buff + bytes_written, 44,
-					  " * " MAC_FMT " via " MAC_FMT "\n",
-					  hna_global_entry->addr[0],
-					  hna_global_entry->addr[1],
-					  hna_global_entry->addr[2],
-					  hna_global_entry->addr[3],
-					  hna_global_entry->addr[4],
-					  hna_global_entry->addr[5],
-					  hna_global_entry->orig_node->orig[0],
-					  hna_global_entry->orig_node->orig[1],
-					  hna_global_entry->orig_node->orig[2],
-					  hna_global_entry->orig_node->orig[3],
-					  hna_global_entry->orig_node->orig[4],
-					  hna_global_entry->orig_node->orig[5]);
+					  " * %pM via %pM\n",
+					  hna_global_entry->addr,
+					  hna_global_entry->orig_node->orig);
 	}
 
 	spin_unlock_irqrestore(&hna_global_hash_lock, flags);




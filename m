Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 19 Oct 2010 11:59:13 +0200
Message-Id: <1287482355-16319-6-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1287482355-16319-1-git-send-email-sven.eckelmann@gmx.de>
References: <1287482355-16319-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 5/7] Staging: batman-adv: protect against ogm
	packet overflow by checking table length
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
To: greg@kroah.com
Cc: b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Marek Lindner <lindner_marek@yahoo.de>

Reported-by: Sam Yeung <sam.cwyeung@gmail.com>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/translation-table.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/batman-adv/translation-table.c b/drivers/staging/batman-adv/translation-table.c
index 12b2325..681ccbd 100644
--- a/drivers/staging/batman-adv/translation-table.c
+++ b/drivers/staging/batman-adv/translation-table.c
@@ -59,6 +59,7 @@ void hna_local_add(struct net_device *soft_iface, uint8_t *addr)
 	struct hna_global_entry *hna_global_entry;
 	struct hashtable_t *swaphash;
 	unsigned long flags;
+	int required_bytes;
 
 	spin_lock_irqsave(&bat_priv->hna_lhash_lock, flags);
 	hna_local_entry =
@@ -74,8 +75,12 @@ void hna_local_add(struct net_device *soft_iface, uint8_t *addr)
 	/* only announce as many hosts as possible in the batman-packet and
 	   space in batman_packet->num_hna That also should give a limit to
 	   MAC-flooding. */
-	if ((bat_priv->num_local_hna + 1 > (ETH_DATA_LEN - BAT_PACKET_LEN)
-								/ ETH_ALEN) ||
+	required_bytes = (bat_priv->num_local_hna + 1) * ETH_ALEN;
+	required_bytes += BAT_PACKET_LEN;
+
+	if ((required_bytes > ETH_DATA_LEN) ||
+	    (atomic_read(&bat_priv->aggregation_enabled) &&
+	     required_bytes > MAX_AGGREGATION_BYTES) ||
 	    (bat_priv->num_local_hna + 1 > 255)) {
 		bat_dbg(DBG_ROUTES, bat_priv,
 			"Can't add new local hna entry (%pM): "
-- 
1.7.2.3


Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed,  7 Mar 2012 09:07:49 +0100
Message-Id: <1331107673-8986-5-git-send-email-sven@narfation.org>
In-Reply-To: <1331107673-8986-1-git-send-email-sven@narfation.org>
References: <7238641.4aX8WvziBv@sven-laptop.home.narfation.org>
	<1331107673-8986-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 5/8-master] batman-adv: Ignore 80-chars per
	line limits for strings
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bridge_loop_avoidance.c |   49 ++++++++++++++++++++--------------------------
 distributed-arp-table.c |   36 ++++++++++++++++++----------------
 translation-table.c     |    5 +--
 3 files changed, 42 insertions(+), 48 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index c191c18..274d93a 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -375,8 +375,8 @@ static struct backbone_gw *bla_get_backbone_gw(struct bat_priv *bat_priv,
 		return entry;
 
 	bat_dbg(DBG_BLA, bat_priv,
-		"bla_get_backbone_gw(): not found (%pM, %d),"
-		" creating new entry\n", orig, vid);
+		"bla_get_backbone_gw(): not found (%pM, %d), creating new entry\n",
+		orig, vid);
 
 	entry = kzalloc(sizeof(*entry), GFP_ATOMIC);
 	if (!entry)
@@ -449,8 +449,7 @@ static void bla_answer_request(struct bat_priv *bat_priv,
 	int i;
 
 	bat_dbg(DBG_BLA, bat_priv,
-		"bla_answer_request(): received a "
-		"claim request, send all of our own claims again\n");
+		"bla_answer_request(): received a claim request, send all of our own claims again\n");
 
 	backbone_gw = backbone_hash_find(bat_priv,
 					 primary_if->net_dev->dev_addr, vid);
@@ -643,16 +642,14 @@ static int handle_announce(struct bat_priv *bat_priv,
 	crc = ntohs(*((uint16_t *) (&an_addr[4])));
 
 	bat_dbg(DBG_BLA, bat_priv,
-		"handle_announce(): ANNOUNCE vid %d (sent "
-		"by %pM)... CRC = %04x\n",
+		"handle_announce(): ANNOUNCE vid %d (sent by %pM)... CRC = %04x\n",
 		vid, backbone_gw->orig, crc);
 
 	if (backbone_gw->crc != crc) {
 		bat_dbg(DBG_BLA, backbone_gw->bat_priv,
-			"handle_announce(): CRC FAILED for %pM/%d"
-			"(my = %04x, sent = %04x)\n",
-			backbone_gw->orig, backbone_gw->vid,
-			backbone_gw->crc, crc);
+			"handle_announce(): CRC FAILED for %pM/%d (my = %04x, sent = %04x)\n",
+			backbone_gw->orig, backbone_gw->vid, backbone_gw->crc,
+			crc);
 
 		bla_send_request(backbone_gw);
 	} else {
@@ -684,8 +681,7 @@ static int handle_request(struct bat_priv *bat_priv,
 		return 1;
 
 	bat_dbg(DBG_BLA, bat_priv,
-		"handle_request(): REQUEST vid %d (sent "
-		"by %pM)...\n",
+		"handle_request(): REQUEST vid %d (sent by %pM)...\n",
 		vid, ethhdr->h_source);
 
 	bla_answer_request(bat_priv, primary_if, vid);
@@ -711,8 +707,7 @@ static int handle_unclaim(struct bat_priv *bat_priv,
 		return 1;
 
 	/* this must be an UNCLAIM frame */
-	bat_dbg(DBG_BLA, bat_priv, "handle_unclaim():"
-		"UNCLAIM %pM on vid %d (sent by %pM)...\n",
+	bat_dbg(DBG_BLA, bat_priv, "handle_unclaim(): UNCLAIM %pM on vid %d (sent by %pM)...\n",
 		claim_addr, vid, backbone_gw->orig);
 
 	bla_del_claim(bat_priv, claim_addr, vid);
@@ -890,9 +885,8 @@ static int bla_process_claim(struct bat_priv *bat_priv,
 	/* check if it is a claim frame. */
 	ret = check_claim_group(bat_priv, primary_if, hw_src, hw_dst, ethhdr);
 	if (ret == 1)
-		bat_dbg(DBG_BLA, bat_priv, "bla_process_claim(): received "
-			"a claim frame from another group. From: "
-			"%pM on vid %d ...(hw_src %pM, hw_dst %pM)\n",
+		bat_dbg(DBG_BLA, bat_priv,
+			"bla_process_claim(): received a claim frame from another group. From: %pM on vid %d ...(hw_src %pM, hw_dst %pM)\n",
 			ethhdr->h_source, vid, hw_src, hw_dst);
 
 	if (ret < 2)
@@ -924,9 +918,8 @@ static int bla_process_claim(struct bat_priv *bat_priv,
 		break;
 	}
 
-	bat_dbg(DBG_BLA, bat_priv, "bla_process_claim(): ERROR - this looks"
-		"like a claim frame, but is useless. eth src"
-		"%pM on vid %d ...(hw_src %pM, hw_dst %pM)\n",
+	bat_dbg(DBG_BLA, bat_priv,
+		"bla_process_claim(): ERROR - this looks like a claim frame, but is useless. eth src %pM on vid %d ...(hw_src %pM, hw_dst %pM)\n",
 		ethhdr->h_source, vid, hw_src, hw_dst);
 	return 1;
 }
@@ -962,8 +955,8 @@ static void bla_purge_backbone_gw(struct bat_priv *bat_priv, int now)
 				continue;
 
 			bat_dbg(DBG_BLA, backbone_gw->bat_priv,
-				"bla_purge_backbone_gw(): backbone gw %pM"
-				" timed out\n",	backbone_gw->orig);
+				"bla_purge_backbone_gw(): backbone gw %pM timed out\n",
+				backbone_gw->orig);
 
 purge_now:
 			/* don't wait for the pending request anymore */
@@ -1551,21 +1544,21 @@ int bla_claim_table_seq_print_text(struct seq_file *seq, void *offset)
 
 	primary_if = primary_if_get_selected(bat_priv);
 	if (!primary_if) {
-		ret = seq_printf(seq, "BATMAN mesh %s disabled - please "
-				 "specify interfaces to enable it\n",
+		ret = seq_printf(seq,
+				 "BATMAN mesh %s disabled - please specify interfaces to enable it\n",
 				 net_dev->name);
 		goto out;
 	}
 
 	if (primary_if->if_status != IF_ACTIVE) {
-		ret = seq_printf(seq, "BATMAN mesh %s disabled - "
-				 "primary interface not active\n",
+		ret = seq_printf(seq,
+				 "BATMAN mesh %s disabled - primary interface not active\n",
 				 net_dev->name);
 		goto out;
 	}
 
-	seq_printf(seq, "Claims announced for the mesh %s "
-		   "(orig %pM, group id %04x)\n",
+	seq_printf(seq,
+		   "Claims announced for the mesh %s (orig %pM, group id %04x)\n",
 		   net_dev->name, primary_if->net_dev->dev_addr,
 		   ntohs(bat_priv->claim_dest.group));
 	seq_printf(seq, "   %-17s    %-5s    %-17s [o] (%-4s)\n",
diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 8a20961..114db0a 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -56,12 +56,12 @@ static void bat_dbg_arp(struct bat_priv *bat_priv, struct sk_buff *skb,
 
 	switch (unicast_4addr_packet->u.header.packet_type) {
 	case BAT_UNICAST:
-		bat_dbg(DBG_DAT, bat_priv, "* encapsulated within a UNICAST "
-			"packet\n");
+		bat_dbg(DBG_DAT, bat_priv,
+			"* encapsulated within a UNICAST packet\n");
 		break;
 	case BAT_UNICAST_4ADDR:
-		bat_dbg(DBG_DAT, bat_priv, "* encapsulated within a "
-			"UNICAST_4ADDR packet (src: %pM)\n",
+		bat_dbg(DBG_DAT, bat_priv,
+			"* encapsulated within a UNICAST_4ADDR packet (src: %pM)\n",
 			unicast_4addr_packet->src);
 		switch (unicast_4addr_packet->subtype) {
 		case BAT_P_DAT_DHT_PUT:
@@ -81,13 +81,13 @@ static void bat_dbg_arp(struct bat_priv *bat_priv, struct sk_buff *skb,
 		}
 		break;
 	case BAT_BCAST:
-		bat_dbg(DBG_DAT, bat_priv, "* encapsulated within a BCAST "
-			"packet (src: %pM)\n",
+		bat_dbg(DBG_DAT, bat_priv,
+			"* encapsulated within a BCAST packet (src: %pM)\n",
 			((struct bcast_packet *)unicast_4addr_packet)->orig);
 		break;
 	default:
-		bat_dbg(DBG_DAT, bat_priv, "* encapsulated within an unknown "
-			"packet type (0x%x)\n",
+		bat_dbg(DBG_DAT, bat_priv,
+			"* encapsulated within an unknown packet type (0x%x)\n",
 			unicast_4addr_packet->u.header.packet_type);
 	}
 }
@@ -177,9 +177,10 @@ static void choose_next_candidate(struct bat_priv *bat_priv,
 	if (max_orig_node) {
 		cands[select].type = DHT_CANDIDATE_ORIG;
 		cands[select].orig_node = max_orig_node;
-		bat_dbg(DBG_DAT, bat_priv, "dht_select_candidates() %d: "
-			"selected %pM addr=%u dist=%u\n", select,
-			max_orig_node->orig, max_orig_node->dht_addr, max);
+		bat_dbg(DBG_DAT, bat_priv,
+			"dht_select_candidates() %d: selected %pM addr=%u dist=%u\n",
+			select, max_orig_node->orig, max_orig_node->dht_addr,
+			max);
 	}
 	*last_max = max;
 }
@@ -206,8 +207,9 @@ static struct dht_candidate *dht_select_candidates(struct bat_priv *bat_priv,
 
 	ip_key = (dat_addr_t)hash_ipv4(&ip_dst, DAT_ADDR_MAX);
 
-	bat_dbg(DBG_DAT, bat_priv, "dht_select_candidates(): IP=%pI4 "
-		"hash(IP)=%u\n", &ip_dst, ip_key);
+	bat_dbg(DBG_DAT, bat_priv,
+		"dht_select_candidates(): IP=%pI4 hash(IP)=%u\n", &ip_dst,
+		ip_key);
 
 	for (select = 0; select < DHT_CANDIDATES_NUM; select++)
 		choose_next_candidate(bat_priv, res, select, ip_key, &last_max);
@@ -547,8 +549,8 @@ bool dat_drop_broadcast_packet(struct bat_priv *bat_priv,
 				 forw_packet->if_incoming->soft_iface);
 		/* check if we already know this neigh */
 		if (n && (n->nud_state & NUD_CONNECTED)) {
-			bat_dbg(DBG_DAT, bat_priv, "ARP Request for %pI4: "
-				"fallback prevented\n",
+			bat_dbg(DBG_DAT, bat_priv,
+				"ARP Request for %pI4: fallback prevented\n",
 				&ARP_IP_DST(forw_packet->skb,
 					    sizeof(struct bcast_packet)));
 			return true;
@@ -565,8 +567,8 @@ void arp_change_timeout(struct net_device *soft_iface, const char *name)
 {
 	struct in_device *in_dev = in_dev_get(soft_iface);
 	if (!in_dev) {
-		pr_err("Unable to set ARP parameters for the batman interface "
-		       "'%s'\n", name);
+		pr_err("Unable to set ARP parameters for the batman interface '%s'\n",
+		       name);
 		return;
 	}
 
diff --git a/translation-table.c b/translation-table.c
index 7dbf127..8e4964b 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -657,9 +657,8 @@ static void tt_global_print_entry(struct tt_global_entry *tt_global_entry,
 	hlist_for_each_entry_rcu(orig_entry, node, head, list) {
 		flags = tt_common_entry->flags;
 		last_ttvn = atomic_read(&orig_entry->orig_node->last_ttvn);
-		seq_printf(seq,	" * %pM  (%3u) via %pM     (%3u)   "
-			   "[%c%c]\n", tt_global_entry->common.addr,
-			   orig_entry->ttvn,
+		seq_printf(seq, " * %pM  (%3u) via %pM     (%3u)   [%c%c]\n",
+			   tt_global_entry->common.addr, orig_entry->ttvn,
 			   orig_entry->orig_node->orig, last_ttvn,
 			   (flags & TT_CLIENT_ROAM ? 'R' : '.'),
 			   (flags & TT_CLIENT_WIFI ? 'W' : '.'));
-- 
1.7.9.1


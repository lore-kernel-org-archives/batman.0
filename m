Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6330FCC6B1A
	for <batman@archiver.kernel.org>; Wed, 14 Oct 2026 07:49:33 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A4DD384205
	for <batman@archiver.kernel.org>; Wed, 14 Oct 2026 09:49:31 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791964171;
 b=faCuWMRXstvRBg6qsahnn57saxY68gtw9bm2qG3weaXggfY2hRWY2yKoe11B2JI6ToMMB
 joar1sJ7kvpYAF03bD6VBFA44edE+oLwwf1gxrkug5H7mgm8p7pgxuHV+Idh3mFQZwHTVAJ
 WZQSVKE4O5U687h/43AH3NajVC+P68o=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791964171; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=sp7rYi4V0Zf15z3VBcFmEaNVkFIOIbGIwVWWoYpwzVE=;
 b=IwsnWl9xQMFUV80e1dSvyszKyPKnhP0Dzyz4lZnx3vtGEok5T6TnSqY26mREKSs5ICz1c
 v5PmuglICoXL7hMrR3bOYeE2ucL7TkIARbWTnPhNVGsvGHibvWYtXPw09Mxt9Ouc+od1TwK
 moQPKXfF1CllRxYbiOoTr/eVit1MexA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id D530284205
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 14 Oct 2026 09:46:29 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791963999;
	b=kFnF6LvlIjHIhDXUCHmWy5tqTr1s6Yruvm/A+nf2nTUzSA9Hngsd6siYM660FXp9LDG3Eg
	Us+rc+PKdIU0pJYVxbPnqr9u9yWoxpfiHaQzhD1nHIbP3CqNP2wbNmA6Rm7VesDRJqBznM
	HOCKMHkcR4oz7huNjL7WfI9o0S+ekVA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791963999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=sp7rYi4V0Zf15z3VBcFmEaNVkFIOIbGIwVWWoYpwzVE=;
	b=2Kwu7vu2f1m2t93zjJGb9QBYfypBqcj6O2gU1spsj2Q+f19+5Oer6RO8iCuly3j9WqRIqe
	xCpipeaxStNBUqiYotUJxc2z5BrqJ/JFIsxo7WZa2yAUBcl0OwEBppKFHlRHfcf+Z3pzIg
	l0EKTmwXpqgpFxdBaOhdFjdKbABFJTU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=kUKtGh3L;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 78B0A20492;
	Wed, 14 Oct 2026 07:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791963989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sp7rYi4V0Zf15z3VBcFmEaNVkFIOIbGIwVWWoYpwzVE=;
	b=kUKtGh3LQx9s2mCPLuVtEjrRdti4QzfEQW8aZaeUPWWfT2QyFqcktqmWQksMiFZyzD+ZIg
	JMBWispm+lnsEahtxFgBGIgCSw0hwhnXxQnNWoOzrNRUaqreHkxe9c443s78JqMHZCfgTe
	AwHJ+s4JsyTtwhkyGC8/f16zFglKH9U=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 14 Oct 2026 09:46:01 +0200
Subject: [PATCH batadv v2 2/6] batman-adv: bla: use dedicated key type for
 backbone gateway hash
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-hash-key-v2-2-7cb91c7df2cb@narfation.org>
References: <20261014-hash-key-v2-0-7cb91c7df2cb@narfation.org>
In-Reply-To: <20261014-hash-key-v2-0-7cb91c7df2cb@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14408; i=sven@narfation.org;
 h=from:subject:message-id; bh=M/NQ/aueTR7lVQZULBUTFbidSDZYynf/p8SfCKbw5ec=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnnjT2Xyq1pjN6zNn7yxmJB7Stmz9scHRY9SOKQPOiok
 L+XSftPRykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAis94yMryUtVk8O9T/mvnn
 2QvMOa8n/Dqa8HxChfCLnH3tX1f+5nRh+F+aH2GfZmkVx7/4warMzVatz3p7bluWBH7PrX0U8Xu
 bKjcA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: O3HK5BE2BL4ER2F32BDWA7YKBV44SGGX
X-Message-ID-Hash: O3HK5BE2BL4ER2F32BDWA7YKBV44SGGX
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/O3HK5BE2BL4ER2F32BDWA7YKBV44SGGX/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_backbone_hash_find() creates a dummy struct batadv_bla_backbone_gw
on the stack and only fills orig and vid for the lookup. Which members
are part of the key is only visible in the hash and compare callbacks.

Move orig and vid into a new struct batadv_bla_backbone_gw_key, embedded as
batadv_bla_backbone_gw::key. The helpers are only using this key for
hashing/comparison.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bridge_loop_avoidance.c | 103 ++++++++++++++++-----------------
 net/batman-adv/types.h                 |  13 ++++-
 2 files changed, 62 insertions(+), 54 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index f9dd168870943..8a621005a7aaf 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -77,42 +77,41 @@ static inline u32 batadv_choose_claim(const void *data, u32 size)
 
 /**
  * batadv_choose_backbone_gw() - choose the right bucket for a backbone gateway.
- * @data: data to hash
+ * @data: &struct batadv_bla_backbone_gw_key to hash
  * @size: size of the hash table
  *
  * Return: the hash index of the backbone gateway
  */
 static inline u32 batadv_choose_backbone_gw(const void *data, u32 size)
 {
-	const struct batadv_bla_backbone_gw *gw;
+	const struct batadv_bla_backbone_gw_key *key = data;
 	u32 hash = 0;
 
-	gw = data;
-	hash = jhash(&gw->orig, sizeof(gw->orig), hash);
-	hash = jhash(&gw->vid, sizeof(gw->vid), hash);
+	hash = jhash(&key->orig, sizeof(key->orig), hash);
+	hash = jhash(&key->vid, sizeof(key->vid), hash);
 
 	return hash % size;
 }
 
 /**
- * batadv_compare_backbone_gw() - compare address and vid of two backbone gws
- * @node: list node of the first entry to compare
- * @data2: pointer to the second backbone gateway
+ * batadv_compare_backbone_gw() - compare key of a backbone gw with a search key
+ * @node: list node of the backbone gateway to compare
+ * @data2: &struct batadv_bla_backbone_gw_key to compare with
  *
- * Return: true if the backbones have the same data, false otherwise
+ * Return: true if the backbone gateway has the given key, false otherwise
  */
 static bool batadv_compare_backbone_gw(const struct hlist_node *node,
 				       const void *data2)
 {
-	const void *data1 = container_of(node, struct batadv_bla_backbone_gw,
-					 hash_entry);
-	const struct batadv_bla_backbone_gw *gw1 = data1;
-	const struct batadv_bla_backbone_gw *gw2 = data2;
+	const struct batadv_bla_backbone_gw_key *key = data2;
+	const struct batadv_bla_backbone_gw *gw;
 
-	if (!batadv_compare_eth(gw1->orig, gw2->orig))
+	gw = container_of(node, struct batadv_bla_backbone_gw, hash_entry);
+
+	if (!batadv_compare_eth(gw->key.orig, key->orig))
 		return false;
 
-	if (gw1->vid != gw2->vid)
+	if (gw->key.vid != key->vid)
 		return false;
 
 	return true;
@@ -261,24 +260,23 @@ batadv_backbone_hash_find(struct batadv_priv *bat_priv, const u8 *addr,
 {
 	struct batadv_hashtable *hash = bat_priv->bla.backbone_hash;
 	struct batadv_bla_backbone_gw *backbone_gw_tmp = NULL;
-	struct batadv_bla_backbone_gw search_entry;
 	struct batadv_bla_backbone_gw *backbone_gw;
+	struct batadv_bla_backbone_gw_key key;
 	struct hlist_head *head;
 	int index;
 
 	if (!hash)
 		return NULL;
 
-	ether_addr_copy(search_entry.orig, addr);
-	search_entry.vid = vid;
+	ether_addr_copy(key.orig, addr);
+	key.vid = vid;
 
-	index = batadv_choose_backbone_gw(&search_entry, hash->size);
+	index = batadv_choose_backbone_gw(&key, hash->size);
 	head = &hash->table[index];
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(backbone_gw, head, hash_entry) {
-		if (!batadv_compare_backbone_gw(&backbone_gw->hash_entry,
-						&search_entry))
+		if (!batadv_compare_backbone_gw(&backbone_gw->hash_entry, &key))
 			continue;
 
 		if (!kref_get_unless_zero(&backbone_gw->refcount))
@@ -462,9 +460,9 @@ static void batadv_bla_loopdetect_report(struct work_struct *work)
 
 	batadv_info(bat_priv->mesh_iface,
 		    "Possible loop on VLAN %d detected which can't be handled by BLA - please check your network setup!\n",
-		    batadv_print_vid(backbone_gw->vid));
+		    batadv_print_vid(backbone_gw->key.vid));
 	snprintf(vid_str, sizeof(vid_str), "%d",
-		 batadv_print_vid(backbone_gw->vid));
+		 batadv_print_vid(backbone_gw->key.vid));
 	vid_str[sizeof(vid_str) - 1] = 0;
 
 	batadv_throw_uevent(bat_priv, BATADV_UEV_BLA, BATADV_UEV_LOOPDETECT,
@@ -503,21 +501,21 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, const u8 *orig,
 	if (!entry)
 		return NULL;
 
-	entry->vid = vid;
+	entry->key.vid = vid;
 	WRITE_ONCE(entry->lasttime, jiffies);
 	entry->crc = BATADV_BLA_CRC_INIT;
 	entry->bat_priv = bat_priv;
 	spin_lock_init(&entry->crc_lock);
 	entry->state = BATADV_BLA_BACKBONE_GW_SYNCED;
 	entry->wait_periods = 0;
-	ether_addr_copy(entry->orig, orig);
+	ether_addr_copy(entry->key.orig, orig);
 	INIT_WORK(&entry->report_work, batadv_bla_loopdetect_report);
 	kref_init(&entry->refcount);
 
 	kref_get(&entry->refcount);
 	hash_added = batadv_hash_add(bat_priv->bla.backbone_hash,
 				     batadv_compare_backbone_gw,
-				     batadv_choose_backbone_gw, entry,
+				     batadv_choose_backbone_gw, &entry->key,
 				     &entry->hash_entry);
 
 	if (unlikely(hash_added != 0)) {
@@ -641,11 +639,11 @@ static void batadv_bla_send_request(struct batadv_bla_backbone_gw *backbone_gw)
 	batadv_bla_del_backbone_claims(backbone_gw);
 
 	batadv_dbg(BATADV_DBG_BLA, backbone_gw->bat_priv,
-		   "Sending REQUEST to %pM\n", backbone_gw->orig);
+		   "Sending REQUEST to %pM\n", backbone_gw->key.orig);
 
 	/* send request */
-	batadv_bla_send_claim(backbone_gw->bat_priv, backbone_gw->orig,
-			      backbone_gw->vid, BATADV_CLAIM_TYPE_REQUEST);
+	batadv_bla_send_claim(backbone_gw->bat_priv, backbone_gw->key.orig,
+			      backbone_gw->key.vid, BATADV_CLAIM_TYPE_REQUEST);
 
 	/* no local broadcasts should be sent or received, for now. */
 	spin_lock_bh(&backbone_gw->bat_priv->bla.num_requests_lock);
@@ -673,7 +671,7 @@ static void batadv_bla_send_announce(struct batadv_priv *bat_priv,
 	spin_unlock_bh(&backbone_gw->crc_lock);
 	memcpy(&mac[4], &crc, 2);
 
-	batadv_bla_send_claim(bat_priv, mac, backbone_gw->vid,
+	batadv_bla_send_claim(bat_priv, mac, backbone_gw->key.vid,
 			      BATADV_CLAIM_TYPE_ANNOUNCE);
 }
 
@@ -761,7 +759,7 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 		batadv_dbg(BATADV_DBG_BLA, bat_priv,
 			   "%s(): changing ownership for %pM, vid %d to gw %pM\n",
 			   __func__, mac, batadv_print_vid(vid),
-			   backbone_gw->orig);
+			   backbone_gw->key.orig);
 
 		/* add claim address to new backbone_gw */
 		spin_lock_bh(&backbone_gw->crc_lock);
@@ -874,7 +872,7 @@ static bool batadv_handle_announce(struct batadv_priv *bat_priv, u8 *an_addr,
 
 	batadv_dbg(BATADV_DBG_BLA, bat_priv,
 		   "%s(): ANNOUNCE vid %d (sent by %pM)... CRC = %#.4x\n",
-		   __func__, batadv_print_vid(vid), backbone_gw->orig, crc);
+		   __func__, batadv_print_vid(vid), backbone_gw->key.orig, crc);
 
 	spin_lock_bh(&backbone_gw->crc_lock);
 	backbone_crc = backbone_gw->crc;
@@ -883,8 +881,8 @@ static bool batadv_handle_announce(struct batadv_priv *bat_priv, u8 *an_addr,
 	if (backbone_crc != crc) {
 		batadv_dbg(BATADV_DBG_BLA, backbone_gw->bat_priv,
 			   "%s(): CRC FAILED for %pM/%d (my = %#.4x, sent = %#.4x)\n",
-			   __func__, backbone_gw->orig,
-			   batadv_print_vid(backbone_gw->vid),
+			   __func__, backbone_gw->key.orig,
+			   batadv_print_vid(backbone_gw->key.vid),
 			   backbone_crc, crc);
 
 		batadv_bla_send_request(backbone_gw);
@@ -1271,7 +1269,7 @@ static void batadv_bla_purge_backbone_gw(struct batadv_priv *bat_priv, int now)
 
 				batadv_dbg(BATADV_DBG_BLA, backbone_gw->bat_priv,
 					   "%s(): backbone gw %pM timed out\n",
-					   __func__, backbone_gw->orig);
+					   __func__, backbone_gw->key.orig);
 
 purge_now:
 				purged = true;
@@ -1342,7 +1340,7 @@ static void batadv_bla_purge_claims(struct batadv_priv *bat_priv,
 			if (now)
 				goto purge_now;
 
-			if (!batadv_compare_eth(backbone_gw->orig,
+			if (!batadv_compare_eth(backbone_gw->key.orig,
 						primary_if->net_dev->dev_addr))
 				goto skip;
 
@@ -1359,7 +1357,7 @@ static void batadv_bla_purge_claims(struct batadv_priv *bat_priv,
 				   claim->key.addr, claim->key.vid);
 
 			batadv_handle_unclaim(bat_priv, primary_if,
-					      backbone_gw->orig,
+					      backbone_gw->key.orig,
 					      claim->key.addr, claim->key.vid);
 skip:
 			batadv_backbone_gw_put(backbone_gw);
@@ -1410,11 +1408,11 @@ void batadv_bla_update_orig_address(struct batadv_priv *bat_priv,
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(backbone_gw, head, hash_entry) {
 			/* own orig still holds the old value. */
-			if (!batadv_compare_eth(backbone_gw->orig,
+			if (!batadv_compare_eth(backbone_gw->key.orig,
 						oldif->net_dev->dev_addr))
 				continue;
 
-			ether_addr_copy(backbone_gw->orig,
+			ether_addr_copy(backbone_gw->key.orig,
 					primary_if->net_dev->dev_addr);
 			/* send an announce frame so others will ask for our
 			 * claims and update their tables.
@@ -1440,9 +1438,10 @@ batadv_bla_send_loopdetect(struct batadv_priv *bat_priv,
 			   struct batadv_bla_backbone_gw *backbone_gw)
 {
 	batadv_dbg(BATADV_DBG_BLA, bat_priv, "Send loopdetect frame for vid %d\n",
-		   backbone_gw->vid);
+		   backbone_gw->key.vid);
 	batadv_bla_send_claim(bat_priv, bat_priv->bla.loopdetect_addr,
-			      backbone_gw->vid, BATADV_CLAIM_TYPE_LOOPDETECT);
+			      backbone_gw->key.vid,
+			      BATADV_CLAIM_TYPE_LOOPDETECT);
 }
 
 /**
@@ -1523,7 +1522,7 @@ static void batadv_bla_periodic_work(struct work_struct *work)
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(backbone_gw, head, hash_entry) {
-			if (!batadv_compare_eth(backbone_gw->orig,
+			if (!batadv_compare_eth(backbone_gw->key.orig,
 						primary_if->net_dev->dev_addr))
 				continue;
 
@@ -1809,8 +1808,8 @@ bool batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv, u8 *orig,
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(backbone_gw, head, hash_entry) {
-			if (batadv_compare_eth(backbone_gw->orig, orig) &&
-			    backbone_gw->vid == vid) {
+			if (batadv_compare_eth(backbone_gw->key.orig, orig) &&
+			    backbone_gw->key.vid == vid) {
 				rcu_read_unlock();
 				return true;
 			}
@@ -2030,7 +2029,7 @@ bool batadv_bla_rx(struct batadv_priv *bat_priv, struct sk_buff *skb,
 
 	/* if it is our own claim ... */
 	backbone_gw = batadv_bla_claim_get_backbone_gw(claim);
-	own_claim = batadv_compare_eth(backbone_gw->orig,
+	own_claim = batadv_compare_eth(backbone_gw->key.orig,
 				       primary_if->net_dev->dev_addr);
 	batadv_backbone_gw_put(backbone_gw);
 
@@ -2134,7 +2133,7 @@ bool batadv_bla_tx(struct batadv_priv *bat_priv, struct sk_buff *skb,
 
 	/* check if we are responsible. */
 	backbone_gw = batadv_bla_claim_get_backbone_gw(claim);
-	client_roamed = batadv_compare_eth(backbone_gw->orig,
+	client_roamed = batadv_compare_eth(backbone_gw->key.orig,
 					   primary_if->net_dev->dev_addr);
 	batadv_backbone_gw_put(backbone_gw);
 
@@ -2220,7 +2219,7 @@ batadv_bla_claim_dump_entry(struct sk_buff *msg, u32 portid,
 
 	backbone_gw = batadv_bla_claim_get_backbone_gw(claim);
 
-	is_own = batadv_compare_eth(backbone_gw->orig, primary_addr);
+	is_own = batadv_compare_eth(backbone_gw->key.orig, primary_addr);
 
 	spin_lock_bh(&backbone_gw->crc_lock);
 	backbone_crc = backbone_gw->crc;
@@ -2235,7 +2234,7 @@ batadv_bla_claim_dump_entry(struct sk_buff *msg, u32 portid,
 	if (nla_put(msg, BATADV_ATTR_BLA_ADDRESS, ETH_ALEN, claim->key.addr) ||
 	    nla_put_u16(msg, BATADV_ATTR_BLA_VID, claim->key.vid) ||
 	    nla_put(msg, BATADV_ATTR_BLA_BACKBONE, ETH_ALEN,
-		    backbone_gw->orig) ||
+		    backbone_gw->key.orig) ||
 	    nla_put_u16(msg, BATADV_ATTR_BLA_CRC,
 			backbone_crc)) {
 		genlmsg_cancel(msg, hdr);
@@ -2381,7 +2380,7 @@ batadv_bla_backbone_dump_entry(struct sk_buff *msg, u32 portid,
 
 	genl_dump_check_consistent(cb, hdr);
 
-	is_own = batadv_compare_eth(backbone_gw->orig, primary_addr);
+	is_own = batadv_compare_eth(backbone_gw->key.orig, primary_addr);
 
 	spin_lock_bh(&backbone_gw->crc_lock);
 	backbone_crc = backbone_gw->crc;
@@ -2396,8 +2395,8 @@ batadv_bla_backbone_dump_entry(struct sk_buff *msg, u32 portid,
 		}
 
 	if (nla_put(msg, BATADV_ATTR_BLA_BACKBONE, ETH_ALEN,
-		    backbone_gw->orig) ||
-	    nla_put_u16(msg, BATADV_ATTR_BLA_VID, backbone_gw->vid) ||
+		    backbone_gw->key.orig) ||
+	    nla_put_u16(msg, BATADV_ATTR_BLA_VID, backbone_gw->key.vid) ||
 	    nla_put_u16(msg, BATADV_ATTR_BLA_CRC,
 			backbone_crc) ||
 	    nla_put_u32(msg, BATADV_ATTR_LAST_SEEN_MSECS, msecs)) {
@@ -2549,7 +2548,7 @@ bool batadv_bla_check_claim(struct batadv_priv *bat_priv,
 	if (claim) {
 		backbone_gw = batadv_bla_claim_get_backbone_gw(claim);
 
-		if (!batadv_compare_eth(backbone_gw->orig,
+		if (!batadv_compare_eth(backbone_gw->key.orig,
 					primary_if->net_dev->dev_addr))
 			ret = false;
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index bfcbcf8c18c64..7285fe1bcc759 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1777,9 +1777,10 @@ enum batadv_bla_backbone_gw_state {
 };
 
 /**
- * struct batadv_bla_backbone_gw - batman-adv gateway bridged into the LAN
+ * struct batadv_bla_backbone_gw_key - key of a backbone gateway in
+ *  &batadv_priv_bla.backbone_hash
  */
-struct batadv_bla_backbone_gw {
+struct batadv_bla_backbone_gw_key {
 	/**
 	 * @orig: originator address of backbone node (mac address of primary
 	 *  iface)
@@ -1788,6 +1789,14 @@ struct batadv_bla_backbone_gw {
 
 	/** @vid: vlan id this gateway was detected on */
 	unsigned short vid;
+};
+
+/**
+ * struct batadv_bla_backbone_gw - batman-adv gateway bridged into the LAN
+ */
+struct batadv_bla_backbone_gw {
+	/** @key: hash key identifying the backbone gateway */
+	struct batadv_bla_backbone_gw_key key;
 
 	/** @hash_entry: hlist node for &batadv_priv_bla.backbone_hash */
 	struct hlist_node hash_entry;

-- 
2.47.3


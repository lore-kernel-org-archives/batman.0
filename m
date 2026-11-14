Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA461606A32E
	for <batman@archiver.kernel.org>; Sat, 14 Nov 2026 09:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=wnLit//r
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 75E28853F7
	for <batman@archiver.kernel.org>; Sat, 14 Nov 2026 10:18:08 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794647888;
 b=zLnx0tQ5LPsgdDXENDiDT88A01iz5HzPfuhRM2xoyk1L7uVTeFQv4KZ2pXkvidkp126u9
 M1N/+i5H3hzqGG86ptNHM1zWr6gDxi8xcDeG/QKjIRieANyKTfGy6RahSZU/6qc8FB8jdXK
 xcQB3HZsgdzJ19qY9pAU1ohZhumsz8U=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794647888; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ZEZvwrEMV8Z3UsaxCRRcOb105QQovu/snFrGfUZEhcg=;
 b=OJMR7iz+JvD1Per1zvDnjABIeupJt/Z/umnF2bcCO+uRpsKVBoA9+JDED6kGRDfn8Sg5w
 AFqBAu0QRb3zFm+VWPRdN6HzJXHSxnE80WMbnOgqJM+0ybZuYPk2TeaozYVpC/wUeK7DA20
 j0oUf3cUu9qWaozt1VNnIshlg5JYSxM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id BFF9683BE1
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 14 Nov 2026 10:16:01 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794647771;
	b=Pb4B5Y2RAimv7Etu/Ykp0lp3X1Hc/UtYvXBWSnKGe2MssBNwHkelVJo4Mb/AXSNPXfDR/+
	0JgYYgccVvIdZfS4NLiTHlgQdhF+YSxJBGq5ajpih3q+58oLyA3Om7/bBxI6zVCIGHhs/f
	9RdN/d0aJl7WqZq+lPiaGpMwkqHAfTc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794647771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ZEZvwrEMV8Z3UsaxCRRcOb105QQovu/snFrGfUZEhcg=;
	b=miUzJQJckTtyZPT+x5uzyIebAOWaZWpvHFcE3KGAQtSJTJPWggjFAoSIM15Z3oi/4pqZmL
	vhMXjJBB9i0vJ/Z5roZLZuAxX+i58k/U0vTS9BMNGMxduC18HP/IbyITydClWe6feXkkDZ
	4/ixTJkdMmEBtmAB8M6Ol4/C1ZBmYnc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b="wnLit//r";
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de (unknown
 [IPv6:2a02:3037:6ed:dd6c:838:344b:3152:2d5e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id F0C6DFA0B3;
	Sat, 14 Nov 2026 10:15:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1794647760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZEZvwrEMV8Z3UsaxCRRcOb105QQovu/snFrGfUZEhcg=;
	b=wnLit//rXcFUKu2IBRlRzJ1dViA47v4hfZr/xiK2BK8o2WKxgpkVAlqzNaKohMtZPV1mX/
	sML1lG1FlCIrzX2zQ+LNqwUaWOz3grcypgXRzfWK9l8N1Z/zbBFSpJi3vssIQaTqNkEMaS
	aqSP7hS+/cyr/SUuad9Oh6tX/hVZXxmY+wPnI3JRLtpYd9x9BWbMBdT64jXRGEc1Dn+mTi
	yGwmMiJoZKmi/wM86H0OAHCv6JHG3AQ8lKLu+FntzHb4lExOgVj6DwpF0WH8uJK+0rAP4b
	QLCmBFdKsP+YXFponV1nqrmMrKShBuAzGVUFrqqnouimyg86682XWEzYHweMaQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 02/15] batman-adv: bla: use dedicated key type for
 backbone gateway hash
Date: Sat, 14 Nov 2026 10:15:43 +0100
Message-ID: <20261114091556.3336038-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261114091556.3336038-1-sw@simonwunderlich.de>
References: <20261114091556.3336038-1-sw@simonwunderlich.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: LV36J2FBU43UROT5RPJLS5QLW5JNDMSC
X-Message-ID-Hash: LV36J2FBU43UROT5RPJLS5QLW5JNDMSC
X-MailFrom: sw@simonwunderlich.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/LV36J2FBU43UROT5RPJLS5QLW5JNDMSC/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sven Eckelmann <sven@narfation.org>

batadv_backbone_hash_find() creates a dummy struct batadv_bla_backbone_gw
on the stack and only fills orig and vid for the lookup. Which members
are part of the key is only visible in the hash and compare callbacks.

Move orig and vid into a new struct batadv_bla_backbone_gw_key, embedded as
batadv_bla_backbone_gw::key. The helpers are only using this key for
hashing/comparison.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bridge_loop_avoidance.c | 103 ++++++++++++-------------
 net/batman-adv/types.h                 |  13 +++-
 2 files changed, 62 insertions(+), 54 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index a5ac7ba24e834..cc7a98fbc3d2a 100644
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
+
+	gw = container_of(node, struct batadv_bla_backbone_gw, hash_entry);
 
-	if (!batadv_compare_eth(gw1->orig, gw2->orig))
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
@@ -875,7 +873,7 @@ static bool batadv_handle_announce(struct batadv_priv *bat_priv,
 
 	batadv_dbg(BATADV_DBG_BLA, bat_priv,
 		   "%s(): ANNOUNCE vid %d (sent by %pM)... CRC = %#.4x\n",
-		   __func__, batadv_print_vid(vid), backbone_gw->orig, crc);
+		   __func__, batadv_print_vid(vid), backbone_gw->key.orig, crc);
 
 	spin_lock_bh(&backbone_gw->crc_lock);
 	backbone_crc = backbone_gw->crc;
@@ -884,8 +882,8 @@ static bool batadv_handle_announce(struct batadv_priv *bat_priv,
 	if (backbone_crc != crc) {
 		batadv_dbg(BATADV_DBG_BLA, backbone_gw->bat_priv,
 			   "%s(): CRC FAILED for %pM/%d (my = %#.4x, sent = %#.4x)\n",
-			   __func__, backbone_gw->orig,
-			   batadv_print_vid(backbone_gw->vid),
+			   __func__, backbone_gw->key.orig,
+			   batadv_print_vid(backbone_gw->key.vid),
 			   backbone_crc, crc);
 
 		batadv_bla_send_request(backbone_gw);
@@ -1272,7 +1270,7 @@ static void batadv_bla_purge_backbone_gw(struct batadv_priv *bat_priv, int now)
 
 				batadv_dbg(BATADV_DBG_BLA, backbone_gw->bat_priv,
 					   "%s(): backbone gw %pM timed out\n",
-					   __func__, backbone_gw->orig);
+					   __func__, backbone_gw->key.orig);
 
 purge_now:
 				purged = true;
@@ -1343,7 +1341,7 @@ static void batadv_bla_purge_claims(struct batadv_priv *bat_priv,
 			if (now)
 				goto purge_now;
 
-			if (!batadv_compare_eth(backbone_gw->orig,
+			if (!batadv_compare_eth(backbone_gw->key.orig,
 						primary_if->net_dev->dev_addr))
 				goto skip;
 
@@ -1360,7 +1358,7 @@ static void batadv_bla_purge_claims(struct batadv_priv *bat_priv,
 				   claim->key.addr, claim->key.vid);
 
 			batadv_handle_unclaim(bat_priv, primary_if,
-					      backbone_gw->orig,
+					      backbone_gw->key.orig,
 					      claim->key.addr, claim->key.vid);
 skip:
 			batadv_backbone_gw_put(backbone_gw);
@@ -1411,11 +1409,11 @@ void batadv_bla_update_orig_address(struct batadv_priv *bat_priv,
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
@@ -1441,9 +1439,10 @@ batadv_bla_send_loopdetect(struct batadv_priv *bat_priv,
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
@@ -1524,7 +1523,7 @@ static void batadv_bla_periodic_work(struct work_struct *work)
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(backbone_gw, head, hash_entry) {
-			if (!batadv_compare_eth(backbone_gw->orig,
+			if (!batadv_compare_eth(backbone_gw->key.orig,
 						primary_if->net_dev->dev_addr))
 				continue;
 
@@ -1810,8 +1809,8 @@ bool batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv,
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(backbone_gw, head, hash_entry) {
-			if (batadv_compare_eth(backbone_gw->orig, orig) &&
-			    backbone_gw->vid == vid) {
+			if (batadv_compare_eth(backbone_gw->key.orig, orig) &&
+			    backbone_gw->key.vid == vid) {
 				rcu_read_unlock();
 				return true;
 			}
@@ -2031,7 +2030,7 @@ bool batadv_bla_rx(struct batadv_priv *bat_priv, struct sk_buff *skb,
 
 	/* if it is our own claim ... */
 	backbone_gw = batadv_bla_claim_get_backbone_gw(claim);
-	own_claim = batadv_compare_eth(backbone_gw->orig,
+	own_claim = batadv_compare_eth(backbone_gw->key.orig,
 				       primary_if->net_dev->dev_addr);
 	batadv_backbone_gw_put(backbone_gw);
 
@@ -2135,7 +2134,7 @@ bool batadv_bla_tx(struct batadv_priv *bat_priv, struct sk_buff *skb,
 
 	/* check if we are responsible. */
 	backbone_gw = batadv_bla_claim_get_backbone_gw(claim);
-	client_roamed = batadv_compare_eth(backbone_gw->orig,
+	client_roamed = batadv_compare_eth(backbone_gw->key.orig,
 					   primary_if->net_dev->dev_addr);
 	batadv_backbone_gw_put(backbone_gw);
 
@@ -2221,7 +2220,7 @@ batadv_bla_claim_dump_entry(struct sk_buff *msg, u32 portid,
 
 	backbone_gw = batadv_bla_claim_get_backbone_gw(claim);
 
-	is_own = batadv_compare_eth(backbone_gw->orig, primary_addr);
+	is_own = batadv_compare_eth(backbone_gw->key.orig, primary_addr);
 
 	spin_lock_bh(&backbone_gw->crc_lock);
 	backbone_crc = backbone_gw->crc;
@@ -2236,7 +2235,7 @@ batadv_bla_claim_dump_entry(struct sk_buff *msg, u32 portid,
 	if (nla_put(msg, BATADV_ATTR_BLA_ADDRESS, ETH_ALEN, claim->key.addr) ||
 	    nla_put_u16(msg, BATADV_ATTR_BLA_VID, claim->key.vid) ||
 	    nla_put(msg, BATADV_ATTR_BLA_BACKBONE, ETH_ALEN,
-		    backbone_gw->orig) ||
+		    backbone_gw->key.orig) ||
 	    nla_put_u16(msg, BATADV_ATTR_BLA_CRC,
 			backbone_crc)) {
 		genlmsg_cancel(msg, hdr);
@@ -2383,7 +2382,7 @@ batadv_bla_backbone_dump_entry(struct sk_buff *msg, u32 portid,
 
 	genl_dump_check_consistent(cb, hdr);
 
-	is_own = batadv_compare_eth(backbone_gw->orig, primary_addr);
+	is_own = batadv_compare_eth(backbone_gw->key.orig, primary_addr);
 
 	spin_lock_bh(&backbone_gw->crc_lock);
 	backbone_crc = backbone_gw->crc;
@@ -2399,8 +2398,8 @@ batadv_bla_backbone_dump_entry(struct sk_buff *msg, u32 portid,
 		}
 
 	if (nla_put(msg, BATADV_ATTR_BLA_BACKBONE, ETH_ALEN,
-		    backbone_gw->orig) ||
-	    nla_put_u16(msg, BATADV_ATTR_BLA_VID, backbone_gw->vid) ||
+		    backbone_gw->key.orig) ||
+	    nla_put_u16(msg, BATADV_ATTR_BLA_VID, backbone_gw->key.vid) ||
 	    nla_put_u16(msg, BATADV_ATTR_BLA_CRC,
 			backbone_crc) ||
 	    nla_put_u32(msg, BATADV_ATTR_LAST_SEEN_MSECS, msecs)) {
@@ -2552,7 +2551,7 @@ bool batadv_bla_check_claim(struct batadv_priv *bat_priv,
 	if (claim) {
 		backbone_gw = batadv_bla_claim_get_backbone_gw(claim);
 
-		if (!batadv_compare_eth(backbone_gw->orig,
+		if (!batadv_compare_eth(backbone_gw->key.orig,
 					primary_if->net_dev->dev_addr))
 			ret = false;
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 9d43e9cac0cc6..aae9c38a96b48 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1788,9 +1788,10 @@ enum batadv_bla_backbone_gw_state {
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
@@ -1799,6 +1800,14 @@ struct batadv_bla_backbone_gw {
 
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


Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA39C79F89
	for <batman-adv@archiver.kernel.org>; Mon,  7 Sep 2026 08:26:53 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 15A52858E0
	for <batman-adv@archiver.kernel.org>; Mon, 07 Sep 2026 10:26:50 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788769610;
 b=K3Fozuh5wZWX2BXkdlJCYbYR7P+WzC1Lv7LJX8sbfds5GP6nfOVn3m+USMGEQx4LWc/ht
 TjWxkweQj/lP6JxHGg/+avUSNoAdEJM6u+aWUUMhQw/Ic5xvNv7SU82JSjrMzltGHM+JaO3
 g9AEwagt+I/sYeXqKColwg5VosADyRU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788769610; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ZS6+oQjD9GI7kf3P/jASgDZaJ06znEuCzZF/IioT7eU=;
 b=UO220UWEAzqiW3j16qDpr92LVuckFFAnTQQVmn4DFgs6DzkPQ75JJr2ivMENcQfNZAK3T
 79xFhhPcKAaHmNKyRGG3Sj+DysvELFOzzMQsjNxknUu7bC2zyBVnRHkrFWQrcUOizLAf4su
 zuMI/A96Rte4ZhzLj+v/U+VgbTj0vkg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 2ED0D841FA
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 07 Sep 2026 10:18:43 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788769123;
	b=3JDE0eiV1GAFEh9QgmYIs/sqUk1D/bHMFic1tb5Ua63UoHYcPcfpAJ153adE9l9hXX3oF/
	nqC3aPjFfHJdaO99LGt5UyowBVgEbbrIogmIoSj7f9lTH69gtYnikwzeFyy9ZgtYMhNRhX
	SmJ7NsraC+2H3gJqGXSkd/BBFeGIDek=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788769123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ZS6+oQjD9GI7kf3P/jASgDZaJ06znEuCzZF/IioT7eU=;
	b=ec0uXk5Yd+aodfjM3aZmbf9kcVAbCANLHwD974Pi6RunzF18mU8MkzZ2sDwNObcKloEhpW
	CYXy5bZuSASGrkR6aGv1tLhfKihpZ7QOxN4i9H+kUlGoosLkra/Uob/DqJMc5ScPMaggex
	F+A7xuQVyzLgNQPDCbRwRqjKQYSnkr4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=VpFMlUAK;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c59748d0d8c3747188E6dfE6C0.dip0.t-ipconnect.de
 [IPv6:2003:c5:9748:d0d8:c374:7188:e6df:e6c0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 9E1ECFA2C0;
	Mon, 07 Sep 2026 10:18:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788769113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZS6+oQjD9GI7kf3P/jASgDZaJ06znEuCzZF/IioT7eU=;
	b=VpFMlUAKVDyDf1WYyzatgIgfLNje7G9/5N3n9iB0FBt7g05X+umcQ3Wlgg5Vh6R2L8kx4Q
	80KV+eEKZGlJR6MWleUCoKqwmMqwBrYNhiivkg3r5PSewyDff6mTuy/SkdfwfZElyhXCsu
	bZYUp++TKUX+XgJfWw4S+EnpSv9ZHUQRy8WwJ8ExXsI729I1wXe0TSvuQFKSg7Hi+dlANw
	sTBffd3QBf2zlggTYtNhu9DinarFi4KCCpt6ETikvH4vBOYJ4qPp5sQzZBvIerLYc4y5aL
	IxVz/AMelO2Yn02afgbaJxQlZSABS5eMZ7tyIC6sYXKRbB8xYalJiKilpR1qbg==
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
Subject: [PATCH net-next 11/15] batman-adv: tt: extract immediate purge of a
 local entry
Date: Mon,  7 Sep 2026 10:18:20 +0200
Message-ID: <20260907081824.2474040-12-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260907081824.2474040-1-sw@simonwunderlich.de>
References: <20260907081824.2474040-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: LAM3UNZIZ7LXQ2MFXSMMSF6C6QUEUVJP
X-Message-ID-Hash: LAM3UNZIZ7LXQ2MFXSMMSF6C6QUEUVJP
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/LAM3UNZIZ7LXQ2MFXSMMSF6C6QUEUVJP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

A client which was added after the last ttvn increment was never announced
and can be dropped from the local table right away. The code doing so is
the second half of batadv_tt_local_remove() and needed a goto to skip the
accounting when the entry was already gone from the hash.

Move it to batadv_tt_local_remove_now().

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 57 +++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 20 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index f5b753ed1ae1a..9f61797c64920 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1475,6 +1475,42 @@ batadv_tt_local_mark_removed(struct batadv_tt_local_entry *tt_local_entry,
 	return pending;
 }
 
+/**
+ * batadv_tt_local_remove_now() - purge a local entry which was never announced
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @tt_local_entry: local TT entry to purge
+ *
+ * A client which was added right after the last ttvn increment was never sent
+ * to the other nodes. It can therefore be dropped from the local table without
+ * waiting for the next ttvn increment.
+ */
+static void
+batadv_tt_local_remove_now(struct batadv_priv *bat_priv,
+			   struct batadv_tt_local_entry *tt_local_entry)
+{
+	struct batadv_tt_common_entry *common = &tt_local_entry->common;
+	struct hlist_node *tt_removed_node;
+
+	batadv_tt_local_event(bat_priv, tt_local_entry, BATADV_TT_CLIENT_DEL);
+
+	/* remove exactly this object when still present in hash */
+	tt_removed_node = batadv_hash_remove(bat_priv->tt.local_hash,
+					     batadv_compare_tt_entry,
+					     batadv_choose_tt, common);
+	if (!tt_removed_node)
+		return;
+
+	/* batadv_tt_local_transition_new() may have committed the entry and
+	 * thus counted it in the local table size since the
+	 * BATADV_TT_CLIENT_NEW check in batadv_tt_local_mark_removed().
+	 */
+	if (!(batadv_tt_flags_get(common) & BATADV_TT_CLIENT_NEW))
+		batadv_tt_local_size_dec(bat_priv, common->vid);
+
+	/* drop reference of remove hash entry */
+	batadv_tt_local_entry_put(tt_local_entry);
+}
+
 /**
  * batadv_tt_local_remove() - logically remove an entry from the local table
  * @bat_priv: the bat priv with all the mesh interface information
@@ -1490,7 +1526,6 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 			   bool roaming)
 {
 	struct batadv_tt_local_entry *tt_local_entry;
-	struct hlist_node *tt_removed_node;
 	u16 curr_flags = BATADV_NO_FLAGS;
 	bool pending = false;
 	u16 flags;
@@ -1518,25 +1553,7 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 	/* if this client has been added right now, it is possible to
 	 * immediately purge it
 	 */
-	batadv_tt_local_event(bat_priv, tt_local_entry, BATADV_TT_CLIENT_DEL);
-
-	/* remove exactly this object when still present in hash */
-	tt_removed_node = batadv_hash_remove(bat_priv->tt.local_hash,
-					     batadv_compare_tt_entry,
-					     batadv_choose_tt,
-					     &tt_local_entry->common);
-	if (!tt_removed_node)
-		goto out;
-
-	/* batadv_tt_local_transition_new() may have committed the entry and
-	 * thus counted it in the local table size since the BATADV_TT_CLIENT_NEW
-	 * check above.
-	 */
-	if (!(batadv_tt_flags_get(&tt_local_entry->common) & BATADV_TT_CLIENT_NEW))
-		batadv_tt_local_size_dec(bat_priv, tt_local_entry->common.vid);
-
-	/* drop reference of remove hash entry */
-	batadv_tt_local_entry_put(tt_local_entry);
+	batadv_tt_local_remove_now(bat_priv, tt_local_entry);
 
 out:
 	batadv_tt_local_entry_put(tt_local_entry);
-- 
2.47.3


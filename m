Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E89AC79F9E
	for <batman-adv@archiver.kernel.org>; Mon,  7 Sep 2026 08:26:20 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3D3BB859FC
	for <batman-adv@archiver.kernel.org>; Mon, 07 Sep 2026 10:26:19 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788769579;
 b=usEWGozZDkuS7qASyYVnt4mFjSoSv+7fuT9tjM432CI1mV/oubInM6uOXBhCzmLM4l+vs
 4ZFKc/Da9r4yEF52dYbcVQcw3fQN5yTqwAoHcl17mIEelYTKG+xjFQUiI+kOL/KMeLjbLIV
 lxr3qfIStRe8NUVjXOCXH12Cynskeic=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788769579; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=CRcYI0Qa4jD6HPqhMI0gjRr/Hmwnmtlo6Q7G3gFIZUs=;
 b=Q2ZF9eTkFZ87bkK2w58ZBSUhV+beCB3R5nWF96j/ZGuo6zivp7PdlxEEOW3Pms9PDvY4s
 KhOhHV4zfsXH3iXmoOBVttZuExQicgVF2dw29S9N/raJNnhlpfjlkS5JZZBH6k1wbKCDCmk
 XwLhZ4rLxNabc2r5KJJYWUQ/7J5Db/E=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id C18B080888
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 07 Sep 2026 10:18:30 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788769120;
	b=Y+9lZX1YJecQoVICLzYxqNqEQSgA+h3JifB6YklT83r7T8JF6/3FPj9EMumOeKjf1qk2wc
	aHfUPj1T6KuC3W2VBOky+s2M7w2qO3H20wuSLejC+EF5FCeopkZr091KqqkliZ8mSpb3NB
	ekJGd555M840eg9RJKbJCbqwkg1lFfU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788769120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=CRcYI0Qa4jD6HPqhMI0gjRr/Hmwnmtlo6Q7G3gFIZUs=;
	b=kT3GdAZ0hOU32QhLW4049QfEWfSZEJDhXolQIOrmJ8o1s+/PRLH3OFH7etkgU8AGtoSSiW
	UzQUk8upOcCewIWRe2HZdc5mVj1wA+3ezWhec1U21mGoGwws46wTDoA2Wy+YAbEDWG8xTn
	E5jysJEqkJPyp00v0u+oeM/sT7ATpSk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=T1iTFBDb;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C59748d0d8c3747188e6dfE6C0.dip0.t-ipconnect.de
 [IPv6:2003:c5:9748:d0d8:c374:7188:e6df:e6c0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id C7E98FA133;
	Mon, 07 Sep 2026 10:18:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788769107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CRcYI0Qa4jD6HPqhMI0gjRr/Hmwnmtlo6Q7G3gFIZUs=;
	b=T1iTFBDbqH6t47yS1gzOLar1dQrH69w6leb3W+Nozb9LdqhAJ+SNPQEUBqtjVjrIoEa6CG
	H+ewUq5HkXH1e54yzQoAmv6UyzT2TXlFIpceUd6B15zAwmnBaShP0h3rt0nDDcTHB4TmoT
	Mm5nj4ZfjzTr3E3VpubA4VbFKgprcTVyeHlLf2aCueSUHj12L+AmWX6jLaNFAsCfmHtL4g
	ehfcHqf6cJb9YskF3RzixOYmCDCHvI7L7OgjGL9RI+xZDUi7XsR/y79bxMgeESrVRWC5xs
	9MFPZ/AFtWFR68LS969NQ7foyu9Db7mnqvKdsz9WR4ux92qym4OEZZRQrBjMeA==
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
Subject: [PATCH net-next 03/15] batman-adv: tt: replace forward gotos in
 batadv_tt_local_add()
Date: Mon,  7 Sep 2026 10:18:12 +0200
Message-ID: <20260907081824.2474040-4-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260907081824.2474040-1-sw@simonwunderlich.de>
References: <20260907081824.2474040-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: Q7KBLIIE5K3EHWZLULIQCXZZOLRSQ5MG
X-Message-ID-Hash: Q7KBLIIE5K3EHWZLULIQCXZZOLRSQ5MG
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/Q7KBLIIE5K3EHWZLULIQCXZZOLRSQ5MG/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

batadv_tt_local_add() used two labels in the middle of the function to
express which parts of the common tail have to be executed: "add_event" to
announce a (re-)added client and "check_roaming" to skip that announcement.
Jumping forward into the middle of a function makes it hard to see which
path ends up sending an ADD event. Especially since the PENDING branch
reached "add_event" while the branch right below it reached "check_roaming"
instead.

Express the same in an "added" variable and turn the two client cases into
a plain if/else. The PENDING check returned early before the ROAM check
could run, so it becomes an "else if".

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 43 ++++++++++++++----------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 2bc243f0fa699..5d5f270b7eb4c 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -818,6 +818,7 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 	struct batadv_tt_global_entry *tt_global = NULL;
 	struct batadv_tt_local_entry *tt_local;
 	bool roamed_back = false;
+	bool added = false;
 	bool iif_is_wifi;
 	bool ret = false;
 	u8 remote_flags;
@@ -846,12 +847,8 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 			 * flag can be reset like it was never enqueued
 			 */
 			tt_local->common.flags &= ~BATADV_TT_CLIENT_PENDING;
-			spin_unlock_bh(&tt_local->common.flags_lock);
-
-			goto add_event;
-		}
-
-		if (tt_local->common.flags & BATADV_TT_CLIENT_ROAM) {
+			added = true;
+		} else if (tt_local->common.flags & BATADV_TT_CLIENT_ROAM) {
 			batadv_dbg(BATADV_DBG_TT, bat_priv,
 				   "Roaming client %pM (vid: %d) came back to its original location\n",
 				   addr, batadv_print_vid(vid));
@@ -864,29 +861,29 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 			roamed_back = true;
 		}
 		spin_unlock_bh(&tt_local->common.flags_lock);
+	} else {
+		tt_local = batadv_tt_local_create(mesh_iface, addr, vid, iif_is_wifi);
+		if (!tt_local)
+			goto out;
 
-		goto check_roaming;
-	}
-
-	tt_local = batadv_tt_local_create(mesh_iface, addr, vid, iif_is_wifi);
-	if (!tt_local)
-		goto out;
+		kref_get(&tt_local->common.refcount);
+		hash_added = batadv_hash_add(bat_priv->tt.local_hash, batadv_compare_tt,
+					     batadv_choose_tt, &tt_local->common,
+					     &tt_local->common.hash_entry);
 
-	kref_get(&tt_local->common.refcount);
-	hash_added = batadv_hash_add(bat_priv->tt.local_hash, batadv_compare_tt,
-				     batadv_choose_tt, &tt_local->common,
-				     &tt_local->common.hash_entry);
+		if (unlikely(hash_added != 0)) {
+			/* remove the reference for the hash */
+			batadv_tt_local_entry_put(tt_local);
+			goto out;
+		}
 
-	if (unlikely(hash_added != 0)) {
-		/* remove the reference for the hash */
-		batadv_tt_local_entry_put(tt_local);
-		goto out;
+		added = true;
 	}
 
-add_event:
-	batadv_tt_local_event(bat_priv, tt_local, BATADV_NO_FLAGS);
+	/* announce the (re-)added client to the mesh */
+	if (added)
+		batadv_tt_local_event(bat_priv, tt_local, BATADV_NO_FLAGS);
 
-check_roaming:
 	batadv_tt_local_add_roam(bat_priv, tt_global, roamed_back);
 
 	spin_lock_bh(&tt_local->common.flags_lock);
-- 
2.47.3


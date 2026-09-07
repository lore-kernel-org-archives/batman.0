Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4939DC79F9E
	for <batman-adv@archiver.kernel.org>; Mon,  7 Sep 2026 08:23:32 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B14FC8534B
	for <batman-adv@archiver.kernel.org>; Mon, 07 Sep 2026 10:23:30 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788769410;
 b=0KFhuk0Ni5zXOrKYQxN4nottldCRQcUA6MC+3qg0VoYNxebwG2cWos1UnX7TH1enTRU8Z
 qCLnC9gR4sn5dJ6Mp6GnZQ/NTxJHgiq2Vm6O2lBaEGB3BJS8BWnpFvT+k3aGYcEsoH+dyc3
 LkoLrqTjlIPnLG0IPEetm17Gn+3XxHk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788769410; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=E9UPNwNnh+47CLhgsd+wrZidNydWo2JD4C/E4XQ38ew=;
 b=awacA6owt0AT1704oJ9LYEseSoRtzlQhK9Cu9qv5B1lrXBtbf8jHisBs7n3ENqIrrf6ur
 bQlE+TFHHQGD23IueBKuOjBNGyGJcvCYaSl0NkTsWvnSHvqILaNHHEJAgutG2BXwDnVzz7g
 OX/bP1zVS0yU4PDXPFPdi+BwUSTQ8+s=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 7DCC98419D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 07 Sep 2026 10:18:38 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788769118;
	b=dOelmSifGGxCjVUcnX8RT2lsbPjLVzbmUE3RLCfYP2eXal+zs8MF+ChXYnvRLtXKQ+fz9e
	PJAqt7w8xLHseVHZKiYC7DLnD17UfvkmZNlZG6L5+nse+Tf0A97XwS9NUn5TJWo/IQdYuq
	As6IPD7au/X472jsIF1tlIcE+C+lOXE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788769118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=E9UPNwNnh+47CLhgsd+wrZidNydWo2JD4C/E4XQ38ew=;
	b=dylI6VYRs8OCj1PRxU1RyUUbDeR3sqh5LAEkWyEwvx/gBRkUMiUOCxksMO3mOPK14+N0zZ
	WWZ23eEuq63SoG8If7IP9uor7AwzIBEodjaFkahY03/OKNJZWwEJcDci9ThU6HWDphd0G7
	g+ti4Nx0s1yBRh+24F7Th+henJhtYrw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b="MlnD1D/i";
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c59748d0D8C3747188e6dFe6C0.dip0.t-ipconnect.de
 [IPv6:2003:c5:9748:d0d8:c374:7188:e6df:e6c0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 8DA13FA2C1;
	Mon, 07 Sep 2026 10:18:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788769114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E9UPNwNnh+47CLhgsd+wrZidNydWo2JD4C/E4XQ38ew=;
	b=MlnD1D/igJsTGf43rU9Tid9x+m4Auoct5nVrnnvNOxOxOhoacK73RH8MxYvWdybrcGYzI/
	WSIKbsiyyzBdQxkJyuAAErxM6U7unarg7oCRopQzdYE7wXgE8YIYf348vBbR54T30Uczmg
	8qX8//Ubvnt7O8x9iJGUis2BttaZCSDC7QyKAWP7zxT0/hQc/uKiyE1XQPIUUWUBT2CUrV
	/4FprlGgqbWP3xCG1wizz3+PpTsC/X3EYWhBj8+PQkHI5YgBnbQoVpkV6vz/pVdhLJRLp/
	wPKNRKImfHQqPa6xyd5HVVTr6l7teQR896brNAKjgxUeRc67TI2Bafr2vO8+mg==
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
Subject: [PATCH net-next 12/15] batman-adv: tt: drop the cleanup label from
 batadv_tt_local_remove()
Date: Mon,  7 Sep 2026 10:18:21 +0200
Message-ID: <20260907081824.2474040-13-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260907081824.2474040-1-sw@simonwunderlich.de>
References: <20260907081824.2474040-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: SBQA5ZZVQRQ5N5F522QP4WXU5TELTYJC
X-Message-ID-Hash: SBQA5ZZVQRQ5N5F522QP4WXU5TELTYJC
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/SBQA5ZZVQRQ5N5F522QP4WXU5TELTYJC/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

With both locked sections moved to their own helpers, the only thing left
in the cleanup section is the reference of the looked up entry. The "out"
label is therefore only reached with a valid entry, except for the lookup
failure at the very beginning.

Return BATADV_NO_FLAGS directly when there is no entry and let the two
remaining cases be an if/else.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 9f61797c64920..6c65d195f3756 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1526,13 +1526,12 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 			   bool roaming)
 {
 	struct batadv_tt_local_entry *tt_local_entry;
-	u16 curr_flags = BATADV_NO_FLAGS;
-	bool pending = false;
+	u16 curr_flags;
 	u16 flags;
 
 	tt_local_entry = batadv_tt_local_hash_find(bat_priv, addr, vid);
 	if (!tt_local_entry)
-		goto out;
+		return BATADV_NO_FLAGS;
 
 	flags = BATADV_TT_CLIENT_DEL;
 	/* if this global entry addition is due to a roaming, the node has to
@@ -1542,20 +1541,15 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 	if (roaming)
 		flags |= BATADV_TT_CLIENT_ROAM;
 
-	pending = batadv_tt_local_mark_removed(tt_local_entry, roaming,
-					       &curr_flags);
-	if (pending) {
-		batadv_tt_local_set_pending_event(bat_priv, tt_local_entry, flags,
-						  message);
-		goto out;
-	}
-
-	/* if this client has been added right now, it is possible to
-	 * immediately purge it
-	 */
-	batadv_tt_local_remove_now(bat_priv, tt_local_entry);
+	if (batadv_tt_local_mark_removed(tt_local_entry, roaming, &curr_flags))
+		batadv_tt_local_set_pending_event(bat_priv, tt_local_entry,
+						  flags, message);
+	else
+		/* if this client has been added right now, it is possible to
+		 * immediately purge it
+		 */
+		batadv_tt_local_remove_now(bat_priv, tt_local_entry);
 
-out:
 	batadv_tt_local_entry_put(tt_local_entry);
 
 	return curr_flags;
-- 
2.47.3


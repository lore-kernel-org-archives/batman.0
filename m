Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA0B2C624A4
	for <batman-adv@archiver.kernel.org>; Mon, 31 Aug 2026 13:54:53 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4E2A58197A
	for <batman-adv@archiver.kernel.org>; Mon, 31 Aug 2026 15:54:52 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788184492;
 b=kmGmcWlTg2GOCYc6+p7XXQ7Ku1zzGCUQ/NNlTeHnvhdNMxBekBFNlfh7qLcIpa5powZPL
 uwklyDmf95kwm90htXg8uu0hQnyPhCrji4iG8OxO0WZMA1hBh4kTQ+aZvSkLzgmLwK9u5hp
 ETmbRLILElyK/UUJRhbSg5lBHLJ1AGA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788184492; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=0arQLmCPaXP9OBvZH+SrzazgTcqbldryCUCPg9JgYhc=;
 b=pNUceHUmwaqNbY4e70HPWjJgXuQ2hmtkX89A0j4Mx/+fZShGJnnS0cXHaiS5u90VncTXk
 r9k6LQGQug1+Udpz1NEbBXaRPRxQbJDuxZN7Y57AmpzUbq49MGZedDQyvg+Uxq5KXzlmtQd
 LFw1s/g1XTGP6VArZMrkr0vF+BLpKM0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 0B8968195D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 31 Aug 2026 15:51:41 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788184301;
	b=WIG+dIC3uiR/iwdzWYttpwg6//BenLR6p9xpBwr5irpp4ORx/Yg5a1z3fT/anb38q20ySS
	TTRXru4zPDFYAz9kijLN+5buRloKMS8wR3EgmJFBLCQ9mFYlGqGl2u0x47Wxkf79G/G0Ei
	Us+9OFT5J+MxLxxrkV9HgSXbenvqR/o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788184301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=0arQLmCPaXP9OBvZH+SrzazgTcqbldryCUCPg9JgYhc=;
	b=Rf+VcXaBgJNrklxpV7L2vkpqzyTiDD11rTnSHYZoIxU7OlXLdyI1aJNNTo5kgMyH4TCy+N
	X6tzLDlUjg6u3fSNnY7tEYzaVEiJEc74SZJ77EbheCgQpSqhsFruMEY/fE16H2SydI9AE5
	WWnwlAiwPw3br85m9JpSWJOf8M3rJgo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=Cgl84q14;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C5970EeDd85F51f1FAa919d7a5.dip0.t-ipconnect.de
 [IPv6:2003:c5:970e:edd8:5f51:f1fa:a919:d7a5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 79A8DFA66D;
	Mon, 31 Aug 2026 15:51:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788184295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0arQLmCPaXP9OBvZH+SrzazgTcqbldryCUCPg9JgYhc=;
	b=Cgl84q14joCgYS6KdNqVcIVrPBwxhfi2dT30vEX8+Jc2Eimgxq127PBCkgN/Uv0B4C8m7v
	nf1wDL3sjEU8XFWAMwMrj3JMYAVv6CzIcmFmZy48V9w6Vw5qgQ1g2I0p3064CC35NWfySO
	11KbcOw8FitDXEIvFhfb02LEQ4aDNRLeUdBXvnnwuLPhRc3QxCCCgrrklsWzj9lycR2+5r
	Oe2kqDUzUsFiiEGoOsHfOFkfRWHqgQR6q0AnUXFjGfcyzpsd87jiaOI8GrQCdYPkD7VLur
	yrqUtcuuaBggfkk8reayjZgdHjiVlxJGbE4Olz8UJkXO3MaZp2ww6jq0N5liRQ==
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
Subject: [PATCH net-next 11/15] batman-adv: tt: drop unnecessary cleanup goto
 in helpers
Date: Mon, 31 Aug 2026 15:51:13 +0200
Message-ID: <20260831135117.574836-12-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831135117.574836-1-sw@simonwunderlich.de>
References: <20260831135117.574836-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: RR3JWVZ3NOYQNLJ4D5CBRCIF3R4POBLK
X-Message-ID-Hash: RR3JWVZ3NOYQNLJ4D5CBRCIF3R4POBLK
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RR3JWVZ3NOYQNLJ4D5CBRCIF3R4POBLK/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

To use scoped_guard(), it is not allowed to use goto in the same routine.
These goto's should only be used for cleanups but are not necessary of
minimal helpers like batadv_is_my_client(),
batadv_tt_global_client_is_roaming() and
batadv_tt_local_client_is_roaming(). Removing the goto's is actually making
these functions more readable.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 2f7951e4c3203..fbe75e184153f 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3544,19 +3544,18 @@ bool batadv_is_my_client(struct batadv_priv *bat_priv, const u8 *addr,
 			 unsigned short vid)
 {
 	struct batadv_tt_local_entry *tt_local_entry;
-	bool ret = false;
+	bool ret;
 
 	tt_local_entry = batadv_tt_local_hash_find(bat_priv, addr, vid);
 	if (!tt_local_entry)
-		goto out;
+		return false;
+
 	/* Check if the client has been logically deleted (but is kept for
 	 * consistency purpose)
 	 */
-	if ((tt_local_entry->common.flags & BATADV_TT_CLIENT_PENDING) ||
-	    (tt_local_entry->common.flags & BATADV_TT_CLIENT_ROAM))
-		goto out;
-	ret = true;
-out:
+	ret = !((tt_local_entry->common.flags & BATADV_TT_CLIENT_PENDING) ||
+		(tt_local_entry->common.flags & BATADV_TT_CLIENT_ROAM));
+
 	batadv_tt_local_entry_put(tt_local_entry);
 	return ret;
 }
@@ -4082,15 +4081,15 @@ bool batadv_tt_global_client_is_roaming(struct batadv_priv *bat_priv,
 					u8 *addr, unsigned short vid)
 {
 	struct batadv_tt_global_entry *tt_global_entry;
-	bool ret = false;
+	bool ret;
 
 	tt_global_entry = batadv_tt_global_hash_find(bat_priv, addr, vid);
 	if (!tt_global_entry)
-		goto out;
+		return false;
 
 	ret = tt_global_entry->common.flags & BATADV_TT_CLIENT_ROAM;
 	batadv_tt_global_entry_put(tt_global_entry);
-out:
+
 	return ret;
 }
 
@@ -4108,15 +4107,15 @@ bool batadv_tt_local_client_is_roaming(struct batadv_priv *bat_priv,
 				       u8 *addr, unsigned short vid)
 {
 	struct batadv_tt_local_entry *tt_local_entry;
-	bool ret = false;
+	bool ret;
 
 	tt_local_entry = batadv_tt_local_hash_find(bat_priv, addr, vid);
 	if (!tt_local_entry)
-		goto out;
+		return false;
 
 	ret = tt_local_entry->common.flags & BATADV_TT_CLIENT_ROAM;
 	batadv_tt_local_entry_put(tt_local_entry);
-out:
+
 	return ret;
 }
 
-- 
2.47.3


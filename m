Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C3AC624A4
	for <batman-adv@archiver.kernel.org>; Mon, 31 Aug 2026 13:56:30 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 09B2B842E6
	for <batman-adv@archiver.kernel.org>; Mon, 31 Aug 2026 15:56:29 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788184589;
 b=KicRYTRpdhpLK1lqmwol4pBfJqEPr9Ha5wkow/gaeqdy4Jx4B5FyVTXwj1Qla3LSIP8ey
 AISVicNmAkWqpqa5NDZ76LIfaZZotf55it7GJ8XCYx+1tqrkwDj1Ig+TMrUvKgHeUZ035vk
 BTUBzaJ75qgRLETG8t5oVmkJLiN1NcE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788184589; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=3YwemhihDz78tssD/CM0RujokvKpevMf6NjoVdOs20k=;
 b=DIqu/A+D7+/Y3kbk4rN/qKOn1eXHF1m1ejLH5W3tbeTiEen0D0Wbwpe+X19AnJCUJeHEs
 A4veK71Bsd9mb17vT10o7AFHI6NLsICJXlUfQIxqALfEWwJdUHokQsmuq/egTFp5J21htXF
 VhaLhWFQ6VvAhdfyMjITwaXIgzN77sg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id A536181958
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 31 Aug 2026 15:51:41 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788184301;
	b=R8GbokSbnf4nFlwOGJGgYjDcPvPkOw69y9oBIKxpqqylrwKeyzKiuuN111Zkbew0cPSgnO
	EOkHADkKvZlsze8P9QygVZsxnND4fwjSnaWkEGuHKom9nLcmywlndfggRAckAuobYYaEr1
	8N1qhEqLCsTEfnS10YBKObVh6BDpQCg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788184301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=3YwemhihDz78tssD/CM0RujokvKpevMf6NjoVdOs20k=;
	b=oYAlq5Lznd9JKQ9vD1/eItQnhXTsyFnd5E+gUunVNcyI8BOvj9Jr9xglQe/F/tquQ1saLU
	uex9OgYu6HkOj1vF90bHj30z8c6vB1zzRznP5qs0O9VocyUZEaG0uKQ8KRMXOgsObrI0wy
	28O0GnoYsEuFCItU1Q3K5ytXVeqOOc0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=boLFwmrE;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c5970EEDD85f51F1FAA919d7a5.dip0.t-ipconnect.de
 [IPv6:2003:c5:970e:edd8:5f51:f1fa:a919:d7a5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 0C532FA6B9;
	Mon, 31 Aug 2026 15:51:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788184297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3YwemhihDz78tssD/CM0RujokvKpevMf6NjoVdOs20k=;
	b=boLFwmrETPQPIfBECwlkvC1PNMriapkBGPLmxM2n3EPJAz89gZ6ic3M42vVdJ2OrIyOBlF
	f+mCRWayi9L/aDYuEdApMg1kTkmi/pLIMEQCEcdP/HvUpsBEeeGMJ+cxpm929fPG20Vlxs
	ydY0P+VQfau35NVlclIqagcrwcd+4LFxbjzEA/SL1jbv0Cv25OiUWX0Gx4BjBBe2viT74w
	AVCzww8B+POaH3G+3GVLub6/v6lFdysdExWEJuzagk+7835Xz+C5KauHQZj3MEMingRkIV
	9xdAjV7rivFxhVk1NCYjMsILEihy65RmuUdr13Isbh6cVk0vhA4NILTBgwYktw==
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
Subject: [PATCH net-next 14/15] batman-adv: tt: don't uncount never committed
 clients on pending purge
Date: Mon, 31 Aug 2026 15:51:16 +0200
Message-ID: <20260831135117.574836-15-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831135117.574836-1-sw@simonwunderlich.de>
References: <20260831135117.574836-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 5OK5XNTWDBIV4WBG7Z67NHKT5MRR5DTV
X-Message-ID-Hash: 5OK5XNTWDBIV4WBG7Z67NHKT5MRR5DTV
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/5OK5XNTWDBIV4WBG7Z67NHKT5MRR5DTV/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

batadv_tt_local_purge_pending_clients() decreases vlan->tt.num_entries for
every entry it unlinks, but an entry which still carries
BATADV_TT_CLIENT_NEW was never counted by batadv_tt_local_transition_new().

batadv_tt_local_resize_to_mtu() calls batadv_tt_local_purge() and
batadv_tt_local_purge_pending_clients() directly, without committing in
between, and it halves its timeout down towards zero. Once the timeout is
short enough, batadv_tt_local_purge_list() marks even freshly added clients
as pending. And each of them decreases a counter it never increased.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index a870d9a97e329..794692170b611 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -349,6 +349,10 @@ static void batadv_tt_local_size_inc(struct batadv_priv *bat_priv,
  *  given vid
  * @bat_priv: the bat priv with all the mesh interface information
  * @vid: the VLAN identifier
+ *
+ * It must only be called after a batadv_tt_local_entry without NEW flag
+ * was removed from bat_priv->tt.local_hash (under the specific
+ * list_locks[i]).
  */
 static void batadv_tt_local_size_dec(struct batadv_priv *bat_priv,
 				     unsigned short vid)
@@ -4019,8 +4023,13 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 					   tt_common->addr,
 					   batadv_print_vid(tt_common->vid));
 
-				batadv_tt_local_size_dec(bat_priv, tt_common->vid);
 				hlist_del_rcu(&tt_common->hash_entry);
+
+				/* An entry which still carries BATADV_TT_CLIENT_NEW was
+				 * never counted and must not be uncounted here.
+				 */
+				if (!(tt_common->flags & BATADV_TT_CLIENT_NEW))
+					batadv_tt_local_size_dec(bat_priv, tt_common->vid);
 			}
 
 			if (cont)
-- 
2.47.3


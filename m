Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E666CC79F82
	for <batman-adv@archiver.kernel.org>; Tue,  8 Sep 2026 17:25:34 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 59B9384033
	for <batman-adv@archiver.kernel.org>; Tue, 08 Sep 2026 19:25:33 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788888333;
 b=eeU9CC+lse1C1ZLDJZ9r4aIg+y34TqKv9yhg1i8j6LNkkCc6Au/MeFpfjS3qYaT6H4WV4
 mIA1H93Ic8843mtKYuN/01jsOvrCOt0ez68clU4hgFW4Quwvro9IragDHZECq74OpkXR3BA
 e8Bv9RoaC0o6lanTdkRQzhsyqtfAQzU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788888333; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=xhrMzE1SsavODGAnfmAnioDSqJMs3iemMDmTEXP9Oec=;
 b=nx1/FE/J6D/j/+ks+Cj9JLtqg+CO/2ZQmURlym21cl/wxXwVz7XBfpVg+Hp7A2aHrrQKl
 Z9or4AlsYFMyhp9WKIetFT5o41aFLNn1Yp+INN7AJ/E9qIpntotWpDcfYjc9Ph+csN/ZhiR
 VqFn21yM3BH8EaaaVef9kSHWNYg7Fpc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id CB67884043
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 08 Sep 2026 19:23:50 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788888235;
	b=KbyPaVaAfrFsvkPl/kV+0ku+KWzuw/0h+YlNXlRW5I5+6V8/gNJyarB2iYuKnouCVhZ4Rc
	7YcTuAOmL++m4fMKNpNRgKasBSul8Y3ENLEV1A/AojR1Q4jD67c3cHy8Zaid1rNJw55oxI
	xZbkM1bLV6qqWvWwTiOvPIeBsgAQWfI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788888235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=xhrMzE1SsavODGAnfmAnioDSqJMs3iemMDmTEXP9Oec=;
	b=Ai8BvWUe312RiYhYma4JiZTHq67Yz09Z+F4wLgNJDkanhof6ZBjMekVh6BGA59AdPYpaSO
	pKYlTIWLq2HMB07F1IG70bb526g1sdmF3kBNhe1FbCs77PzPMUbw39HwQpOmKU+vWoIzoz
	CBLY3igkmi2uJllAOAVO56XU9sPNJU4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=0NSHmCFH;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 51C5E204EB;
	Tue, 08 Sep 2026 17:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788888230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xhrMzE1SsavODGAnfmAnioDSqJMs3iemMDmTEXP9Oec=;
	b=0NSHmCFH1S/hVJzn1TjoPkDPjOUeh4JW1vwZ5vyAbyEwVkOvFtFjIapWeNoGKwuszXbqg8
	iTg3M66mOlGTc07/DMzcy4N3nxtD4VNCwOdQ3xFKRTWV2gtt9XbAOkgMKqgfh7BRNjnsv7
	N8cEl8EN13jBC1S18V0WOtwG+0ZRDsg=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 08 Sep 2026 19:23:37 +0200
Subject: [PATCH batadv 3/3] batman-adv: tt: soften kernel-doc for
 batadv_tt_local_remove_now()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-sashiko-kdoc-v1-3-535b498f2519@narfation.org>
References: <20260908-sashiko-kdoc-v1-0-535b498f2519@narfation.org>
In-Reply-To: <20260908-sashiko-kdoc-v1-0-535b498f2519@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1847; i=sven@narfation.org;
 h=from:subject:message-id; bh=u4uQkqYVIJKk3fis4ApkMwkZswQdB2lpAive1Obo8is=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkLXOZ2SuzKYAytWCE8+cvcmsmiEpc5rP5kFfsqZv9JX
 yWyQyGgo5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjCRGg1GhgNb7P98fRLBMuu0
 el7r/qn7N3iwqi75PI9/lxzbTIWIQlWGf0artn30KGv7XxJUOU1pgVph7TyRl0793E+ET7Uuktx
 0nRcA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 5KGND5LJMWBUVNCCDKN2N7QXKLVQ3BCK
X-Message-ID-Hash: 5KGND5LJMWBUVNCCDKN2N7QXKLVQ3BCK
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/5KGND5LJMWBUVNCCDKN2N7QXKLVQ3BCK/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The "never announced" statement is too harsh for an entry which could have
been actually be announced by a different context while the
batadv_tt_local_remove_now() is in the process of being called. "not yet"
might be more appropriate.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907081824.2474040-1-sw%40simonwunderlich.de?part=11
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index c0e84ee4..046ef01a 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1531,13 +1531,16 @@ batadv_tt_local_mark_removed(struct batadv_tt_local_entry *tt_local_entry,
 }
 
 /**
- * batadv_tt_local_remove_now() - purge a local entry which was never announced
+ * batadv_tt_local_remove_now() - purge a local entry which was not (yet) announced
  * @bat_priv: the bat priv with all the mesh interface information
  * @tt_local_entry: local TT entry to purge
  *
- * A client which was added right after the last ttvn increment was never sent
- * to the other nodes. It can therefore be dropped from the local table without
- * waiting for the next ttvn increment.
+ * A client which was added right after the last ttvn increment was not (yet)
+ * sent to the other nodes. It can therefore be dropped from the local table
+ * without waiting for the next ttvn increment.
+ *
+ * If it was still announced by a parallel context before it was removed from
+ * the hash, then the local TT size adjustment will be handled automatically.
  */
 static void
 batadv_tt_local_remove_now(struct batadv_priv *bat_priv,

-- 
2.47.3


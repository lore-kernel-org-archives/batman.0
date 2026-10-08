Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7274FCA6007
	for <batman@archiver.kernel.org>; Thu,  8 Oct 2026 15:12:48 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B984D8426E
	for <batman@archiver.kernel.org>; Thu, 08 Oct 2026 17:12:46 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791472366;
 b=jJUEyoj+O15LWVJRcU6SSzDZLtxtS2v2nkM7hp5lVWhrv5DRMpBBA/475zWt4r37FPNet
 UkRAvChSkrN3tecU1JxW3yBryI3t2zoNp0NLkpe8JznaJntLGOFDjcICteSewH6Lyij3ytO
 JNLn3prw6fEsriJo5SIhptNp1smFGu8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791472366; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=l/aQY/YEz9RZF41TSymqlDpHQwTGdPSp49K00WhOI00=;
 b=WPGQ9oUtSxSyiLOb/dcD8kj8d3CkqkTevdZI2GoqLMYR0LnKnLawIGjwHDTL8ks37TgQY
 7oXA6V0dKQH9W542vmeiK1goRht5OCWPU+itOq4x2uQZtGrQLNjo+JSC9b01Dv78t8rXqou
 De8gQM7YbE0CeIa6ix5FAqbMchgXIJA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id ED0CA807AD
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 08 Oct 2026 17:12:37 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791472358;
	b=kXLLczyNtgTUkrKpO1vfAPDtkU35n1ewiH2BVQP+bP4yVw+6+LwlHJ4q1NbDpr3KmEdBHa
	sVd5jpl2BgtU/oWkHjaBkP7rEWP2GPFM+sINYaNvUNB7fhtFWdo3pnBqxNJg20n88FM/ru
	EIMPM6tHPWDxpNTi6XBjMIw5nZ4AKms=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791472358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=l/aQY/YEz9RZF41TSymqlDpHQwTGdPSp49K00WhOI00=;
	b=LTgUfLFV7H92rOP4e50MxB9QIiiDMLynCGrwTZGy2NmPsC0ZEHyvX/lsTq9gKmr/Ai5BAc
	R/frE9tecI2CrGby3FT3KrM0HFaJBUdwxOqrtQj6BSJY8RYU4nB0jwvcQgx6TceRlFjKkg
	UTBN/3iacKvJ4qve1qFL2vWOiHzfPL0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="KnT/i+CB";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 0BE81202AD;
	Thu, 08 Oct 2026 15:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791472356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l/aQY/YEz9RZF41TSymqlDpHQwTGdPSp49K00WhOI00=;
	b=KnT/i+CBQV2Y3AbrF/MdTHvRT5qrOqYyKc0d0kiFyQSqooxCo5Ddsh4oBlQ8ZWMVqAxYFO
	/cPv+kMfx3upWXmwrJx/a/dRBpTUbmIG03zCKeSNojHKCRzDgmbpvbM3+bD2vPMyVUD5pq
	fw6p+ZtAnWxjQq7CCmkKgPwghG4+vkg=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 08 Oct 2026 17:12:14 +0200
Subject: [PATCH batadv] batman-adv: tt: increase hash generation when
 purging clients
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-tt-hash-generatopn-v1-1-5aa687343ce1@narfation.org>
X-B4-Tracking: v=1; b=H4sIAM2yx2oC/yWMQQqDMBAAvyJ77kLWUqn9SulhTVazPUTJRimIf
 29ajzMws4NJVjF4NDtk2dR0ThXo0oCPnCZBDZWhdW1Hzt2xFIxsESdJkrnMS8LOE/eO+htdA9R
 wyTLq5z99wsCFwwav09s6vMWX3xGO4wtHDHs3fgAAAA==
X-Change-ID: 20261008-tt-hash-generatopn-6c1a9019513d
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sashiko <sashiko-bot@kernel.org>, Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1486; i=sven@narfation.org;
 h=from:subject:message-id; bh=n5w4Cx+SXgFhonggTXUvQKzA8OaQxdkOBTEEY7NyqrA=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnHN10zn3VE6MI3ZZNX6u1qmdV2xoGW+SZG4sYi7WYCN
 ce0N7/uKGVhEONikBVTZNlzJf/8Zva38p+nfTwKM4eVCWQIAxenAEwkPI6RYfsvC8fV4vtrpeYe
 27GwTEPPSFQnuONQprX4lupPW5NFpjAyTLHeGimv09ogoFRclPJ7ae8zp5mHfZibd1QYrLdes8i
 fHwA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: XWLWPYY2UWVWAKL27PDQZ2U2DNOYMF7W
X-Message-ID-Hash: XWLWPYY2UWVWAKL27PDQZ2U2DNOYMF7W
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XWLWPYY2UWVWAKL27PDQZ2U2DNOYMF7W/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

If batadv_tt_local_dump() is preempted during a netlink dump and resumes in
the middle of a hash bucket while batadv_tt_local_purge_pending_clients()
concurrently removes an entry, the dump offset will be shifted.

Without incrementing the hash generation counter, netlink won't set
NLM_F_DUMP_INTR and the userspace will not be informed by the inconsistent
dump..

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20261008-tt-avoid-unhashed-event-v2-0-7c4eed81606d@narfation.org?part=6
Fixes: 45e3ad80fd80 ("batman-adv: Add inconsistent local TT netlink dump detection")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index e46040fd..4806bd89 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -4435,6 +4435,7 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 					   batadv_print_vid(tt_common->vid));
 
 				hlist_del_rcu(&tt_common->hash_entry);
+				atomic_inc(&hash->generation);
 
 				/* An entry which still carries BATADV_TT_CLIENT_NEW was
 				 * never counted and must not be uncounted here.

---
base-commit: 0eaac0f4187bc9b69b41d90998fd7b93ab07e53e
change-id: 20261008-tt-hash-generatopn-6c1a9019513d

Best regards,
--  
Sven Eckelmann <sven@narfation.org>


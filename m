Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF6BC55174
	for <batman-adv@archiver.kernel.org>; Wed,  5 Aug 2026 15:13:35 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B587584217
	for <batman-adv@archiver.kernel.org>; Wed, 05 Aug 2026 17:13:33 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785942813;
 b=C7stHQMdGMSvptELBiyXCIoeEJGhm2JfteYtQCPaarMRSO988fGw8IOH0xMxfCBYE1cjf
 wIRfkHPDk8Hc0gm59Abo1QlpUUZy1qRdwbMArS7xdoN2Q6yj1Ay969dZBfQFe2r55FxzX4t
 bbUDrHJU3VuN6L+GpGLFlpluWFQlj/g=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785942813; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=e+JwIEvp7i1jp/5LQYYOdXv61YbnP/CWhiVLan+Y1IQ=;
 b=T0JmYsr3jGjU+8oeJpO3/r4yQ7DKLFU731/08fN5hNBdUowZYNCfZyBKbp4hdypQy+oze
 NBEc+qWFeiNgRmHGgGDir7gUKDDS2ypWqQC4Cn7lFoZ7HylYL8KM9aEn18eOjvd9NlN17pT
 lVtL9ntCBtHiZ3wOHxm6Z1o0NVuv7bI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 7156484221
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 05 Aug 2026 17:10:44 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785942644;
	b=cfBaLq2Eaiy77ppUE031Or6Cvk2iMEIaKTIeK82mxqJeehk5rPfFi87tyZ4wcz1ZeRtUwP
	4xVyQtKYdnjW+lvVjVRpFZSQlYUkXpWJwUXS645TFd5gDTrXps5n8Uoge/8BZpDBp/R+gZ
	eewUSBtqgJXvulJk2l1eaTOZbq9k9zs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785942644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=e+JwIEvp7i1jp/5LQYYOdXv61YbnP/CWhiVLan+Y1IQ=;
	b=EquD8Poz2zqvqael9d90MtLPRxzsi1IMj19lM45tuupLsLWQ5NZz1AVi35dfXQ7i/qCMAr
	Mdv4pzez9O0LUB14MAzsL5URCtWF0esCRnVJKEo66+IVCpsM6hWqp9NVkptVAgL1hd4S3b
	+/RT5PHm9bUScl9xGq/I51PYc8f7g34=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=ZDroes6k;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 0FA7D204D0;
	Wed, 05 Aug 2026 15:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785942640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e+JwIEvp7i1jp/5LQYYOdXv61YbnP/CWhiVLan+Y1IQ=;
	b=ZDroes6kH4eF+TXhv8g2EjMEdIIK1LCrGQaCvhkI5q2UPxicTJUE+YGWizRn/tS//6RDq4
	yo/aKbzB1PR6hSinEuBEl+Ha3wQa1AHDc67Ckaygl49q67LSp51eYlNzk8hHxHobYHsDUu
	a3/pd8Ohw4MuI7zeWHKuFDitdmGrwJs=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 05 Aug 2026 17:09:40 +0200
Subject: [PATCH RFC batadv v3 6/6] batman-adv: tt: don't uncount never
 committed clients on pending purge
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-tt-fixes-v3-6-25b00b558470@narfation.org>
References: <20260805-tt-fixes-v3-0-25b00b558470@narfation.org>
In-Reply-To: <20260805-tt-fixes-v3-0-25b00b558470@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1713; i=sven@narfation.org;
 h=from:subject:message-id; bh=perN+br3E+5l/Zmu5fZkEKGpFgYhj7UjCHm+l53N5DM=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnFQaZvJjF0qv6LDa6d3+SzPe+jlWtxWovh/rxF8x5u3
 MTTtfBwRykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAiR48yMhy6rCnMP2GJ+dXp
 nsv4t25c5HK3MGb+B76IMs7WrbdYLcsZ/um06Kr9cU+1XmAoOvP5HBkL3wkHf655knuGfY7R28S
 4h9wA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: OHR37RFJ7BYDCSAVSLTPLVNYPVJM3564
X-Message-ID-Hash: OHR37RFJ7BYDCSAVSLTPLVNYPVJM3564
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/OHR37RFJ7BYDCSAVSLTPLVNYPVJM3564/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_tt_local_purge_pending_clients() decreases vlan->tt.num_entries for
every entry it unlinks, but an entry which still carries
BATADV_TT_CLIENT_NEW was never counted by batadv_tt_local_transition_new().

batadv_tt_local_resize_to_mtu() calls batadv_tt_local_purge() and
batadv_tt_local_purge_pending_clients() directly, without committing in
between, and it halves its timeout down towards zero. Once the timeout is
short enough, batadv_tt_local_purge_list() marks even freshly added clients
as pending. And each of them decreases a counter it never increased.

Consume the BATADV_TT_CLIENT_NEW accounting token here as well, so that the
counter is only decreased for entries which were actually counted.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index ce76d056..f6c18620 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -4087,8 +4087,15 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
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
+				else
+					tt_common->flags &= ~BATADV_TT_CLIENT_NEW;
 			}
 
 			if (cont)

-- 
2.47.3


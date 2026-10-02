Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6237CCA5FC4
	for <batman@archiver.kernel.org>; Fri,  2 Oct 2026 16:24:36 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7A0F784236
	for <batman@archiver.kernel.org>; Fri, 02 Oct 2026 18:24:34 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1790958274;
 b=Jf4eSLX/zMQXoAUGRtiffXbLaIpDt8K+Uni/YLUqJA/WSgrsRI6N2oz3MtW7IHuFYjV3Q
 /kUTANYZWhx/nXuhHXToLkhoZvMatALTwzbxOf3hQVpCcin6ur4or1GXuUn/rBASNwxn81Y
 GEJ/MgBvVLnUPulu0DxHh18R02ON6Rg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1790958274; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=APM/551+P5mypr8t09C2B5tk+wmPo/conR5u2OXvgQo=;
 b=PDzX8rQJoSpTqFx7sbc05/s/PD1mT1AWesFD3BsuaFid48dlG2HnE1uEMO6at2Es1WcG1
 xOulOUda7mI+8YPaFYX7t/Q31dajJp7aIKtOwZvYtzpPcUJzfq0GWuMEbTagydUQCLxP+sB
 GTz1tjZAWr3EprAlOs0sVjBlMd2si50=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 617DC8084E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 02 Oct 2026 18:24:15 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1790958265;
	b=kzQ4G5nJZts/3/dkf3RPDgQC6kuRrgO4LjL4zJ/LuDFu5HOsJy6cc+D420X1NhiJaKROOK
	z75MTkqaIeyYy55grnw2fbtx8j5Dk3+Iusj6TBetauRAV+L/2Zvs4BPWak758kC5xXw2VB
	RvyI+A9vgDVQuXYvCY8ezvbo43L4zZ8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1790958265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=APM/551+P5mypr8t09C2B5tk+wmPo/conR5u2OXvgQo=;
	b=Tu0jXrRDkc3GA09uzVZjS2QEzID+DQFRuhoJucdtm56zZ+raVr7dOxdpaRWrze9FKMqOTB
	BKHLJruLfbSYJbk0S5Yi7hK0FTV6oCVIdTQ7TvuSCA2UUS/LO3Ci9H5acFoJFZEOvYWIbB
	IyGiLjGws3Xmxa4Tf2fYnNrgB+hGgTE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=PZEnd7FE;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 7C6D71FDE9;
	Fri, 02 Oct 2026 16:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1790958254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=APM/551+P5mypr8t09C2B5tk+wmPo/conR5u2OXvgQo=;
	b=PZEnd7FEQ8Eoh1QSrZVH4s7bKJMZHcvKo4VhVAeOVxYkC3PrQ9k8wFl167fEEHiAo2rkEz
	CnU29AE81i8hh1PNAWojOu6YNjjuXKRJm3/oaS7IFE9caqqx6hJ3Wb11T398FFONbppi0f
	egH5Bwlc28OLFHmkjdWUQapEP4vhSXc=
From: Sven Eckelmann <sven@narfation.org>
To: sashiko-reviews@lists.linux.dev
Cc: antonio@mandelbit.com, sw@simonwunderlich.de, marek.lindner@mailbox.org,
 netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH net-next 5/9] batman-adv: tt: only queue local del event
 after
 successful unlink
Date: Fri, 02 Oct 2026 18:24:11 +0200
Message-ID: <23263645.EfDdHjke4D@sven-desktop>
In-Reply-To: <20261001095518.932241F000FF@smtp.kernel.org>
References: <20260930094558.3723766-1-sw@simonwunderlich.de>
 <20260930094558.3723766-6-sw@simonwunderlich.de>
 <20261001095518.932241F000FF@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7999796.EvYhyI6sBW";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: NM4SXFYY7VO33TLOAJGK7D3RO64YFKT5
X-Message-ID-Hash: NM4SXFYY7VO33TLOAJGK7D3RO64YFKT5
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/NM4SXFYY7VO33TLOAJGK7D3RO64YFKT5/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart7999796.EvYhyI6sBW
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: sashiko-reviews@lists.linux.dev
Date: Fri, 02 Oct 2026 18:24:11 +0200
Message-ID: <23263645.EfDdHjke4D@sven-desktop>
In-Reply-To: <20261001095518.932241F000FF@smtp.kernel.org>
MIME-Version: 1.0

On Thursday, 1 October 2026 11:55:18 CEST sashiko-bot@kernel.org wrote:
[...]
> > diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> > index 354d9416c1b75..c904d67791f8f 100644
> > --- a/net/batman-adv/translation-table.c
> > +++ b/net/batman-adv/translation-table.c
> [ ... ]
> > @@ -1496,8 +1496,6 @@ batadv_tt_local_remove_now(struct batadv_priv *bat_priv,
> >  	struct batadv_tt_common_entry *common = &tt_local_entry->common;
> >  	struct hlist_node *tt_removed_node;
> >  
> > -	batadv_tt_local_event(bat_priv, tt_local_entry, BATADV_TT_CLIENT_DEL);
> > -
> >  	/* remove exactly this object when still present in hash */
> >  	tt_removed_node = batadv_hash_remove(bat_priv->tt.local_hash,
> >  					     batadv_compare_tt_entry,
> > @@ -1505,6 +1503,8 @@ batadv_tt_local_remove_now(struct batadv_priv *bat_priv,
> >  	if (!tt_removed_node)
> >  		return;
> >  
> > +	batadv_tt_local_event(bat_priv, tt_local_entry, BATADV_TT_CLIENT_DEL);
> > +
> 
> [Severity: High]
> Does moving this event queueing after the hash removal create a lockless
> window where a concurrent ADD can be incorrectly cancelled by the delayed DEL
> event?

Previously, you're partner instance complained about the opposite order:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831135117.574836-1-sw%40simonwunderlich.de?part=8

Will postpone further changes (and not modify this PR) until a better way for 
consistency guarantee between announcements and hash states is implemented:
https://www.open-mesh.org/issues/475

Regards,
	Sven
--nextPart7999796.EvYhyI6sBW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCar/aqwAKCRBND3cr0xT1
y8XCAP9JVLQ8bmYR99VUuRhDTYj0Sr5vTirIQhqJPYELcMyFNgEAsH+kR6VwB/Ma
79/5wvr2hdkSi/JL4CBf2GHQOyY+CgY=
=ondY
-----END PGP SIGNATURE-----

--nextPart7999796.EvYhyI6sBW--




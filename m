Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1270BC624D0
	for <batman-adv@archiver.kernel.org>; Tue,  1 Sep 2026 19:36:24 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 812CA8222C
	for <batman-adv@archiver.kernel.org>; Tue, 01 Sep 2026 21:36:22 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788291382;
 b=oyAJlN8vqtuptp5cR66r/gSmDu99Z8JGkJmEtAHvL2o3SrYQgszQc8bvpmDz4Uyeaa2wf
 WHPH5jly/xNponSBpLgQ/CgJSUQ6/LE8SIzmjcL+vZDo4EE1RcM0uNk6kBGRVZqiH1R1P0/
 6Nz87tZJUDSDhM7OF7eyS0Nhli2+Wnw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788291382; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=IyloIUtGzLJBXQuyoH+mecbEdju+FMs6EneyHfBdrbc=;
 b=OYpQaUUgmkIwbAz1WrXBe+hm+zoDx/SzK8BBblrEe3BcZzrxigH9/WgHjh9k+Lma/l6Vi
 Y+ydFLbgNFzyQSHp+LJOBwCgJqv3hpIWrB2D4A303jhxk60NTYUgahKwhCFUmrWd9r+VOOr
 VGUHhKW4PRAFG4aki55y+Tl5DRr0Kek=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 296F780837
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 01 Sep 2026 21:36:14 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788291375;
	b=vup5P8u6LtnmdF76flgL/3qdHWVU2PBEWYRfkqHRTsZgIWP614JHhIxgIDw7Nbtg3g26S6
	mzu9Sj5XteW06jJ9LeKMeFiG5jJcu+fhtJhXhIOPhwh4TF21h4BxYYl+ikGoSwAQ61TsC2
	pxEqngWBgikRMisYOhXcRGvzsOONCdw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788291375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=IyloIUtGzLJBXQuyoH+mecbEdju+FMs6EneyHfBdrbc=;
	b=fR8OtvqyfvwwXSyIZxKyD3g/1fFVi3doMKcIgr45yg0yngt74QMc8dsxsSy7NGP16zqptk
	xXZzhXqogvonZN0lXfPEpjNme9VJj5uZCJo0vGYtob2gno9Bth7TPUegEnCC2LFeB/iddH
	UsfbrgG1piFE7lGflZgSBarFI0y37VA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=BnXgbLd6;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 0E7F320396;
	Tue, 01 Sep 2026 19:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788291370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IyloIUtGzLJBXQuyoH+mecbEdju+FMs6EneyHfBdrbc=;
	b=BnXgbLd6UIv+NF+nkq58UjyPcFQC6iB+IOaxKT9VAYjj+wxknxWDEO75gtnW3JlBJBl1OY
	0F3M9sIlbmlAydE68o+1oGgAED6xPIdI8UWHe1m/K78/vKmlOlg1/5uWc3W92d3bzdSbvK
	XvnlnhCL0dcrr+idoOBSbKKEbhVSlzo=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: [PATCH net-next 15/15] batman-adv: tt: decrement count for
 committed
 client on local_remove
Date: Tue, 01 Sep 2026 21:36:07 +0200
Message-ID: <2735744.Lt9SDvczpP@sven-desktop>
In-Reply-To: <20260831135117.574836-16-sw@simonwunderlich.de>
References: <20260831135117.574836-1-sw@simonwunderlich.de>
 <20260831135117.574836-16-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4549420.ejJDZkT8p0";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: Y52DMHDOGTUNWNKRPNE7HQKS3Y2NOEJD
X-Message-ID-Hash: Y52DMHDOGTUNWNKRPNE7HQKS3Y2NOEJD
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/Y52DMHDOGTUNWNKRPNE7HQKS3Y2NOEJD/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart4549420.ejJDZkT8p0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 01 Sep 2026 21:36:07 +0200
Message-ID: <2735744.Lt9SDvczpP@sven-desktop>
In-Reply-To: <20260831135117.574836-16-sw@simonwunderlich.de>
MIME-Version: 1.0

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831135117.574836-1=
=2Dsw%40simonwunderlich.de?part=3D15


> > diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/transl=
ation-table.c
> > index 794692170b61..44a8cf89382c 100644
> > --- a/net/batman-adv/translation-table.c
> > +++ b/net/batman-adv/translation-table.c
>=20
> [ ... ]
>=20
> > @@ -1423,6 +1424,13 @@ u16 batadv_tt_local_remove(struct batadv_priv *b=
at_priv, const u8 *addr,
> >  	if (!tt_removed_node)
> >  		goto out;
> > =20
> > +	/* batadv_tt_local_transition_new() may have committed the entry and
> > +	 * thus counted it in the local table size since the BATADV_TT_CLIENT=
_NEW
> > +	 * check above.
> > +	 */
> > +	if (!(batadv_tt_flags_get(&tt_local_entry->common) & BATADV_TT_CLIENT=
_NEW))
> > +		batadv_tt_local_size_dec(bat_priv, tt_local_entry->common.vid);
> > +
>=20
> Discovered by: gpt-5-6-sol, opus-5 =C2=B7 Missed by: sashiko-gemini
> Should this change carry a Fixes: tag?


I am not allowed to add Fixes: lines for patches targeting net-next. And th=
is=20
is not suitable for net or stable backports. See
https://lore.kernel.org/all/7d73cd74-b040-4a3d-9d78-4ad8fc0a01f4@redhat.com/


Regards,
Sven
--nextPart4549420.ejJDZkT8p0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCapcpJwAKCRBND3cr0xT1
y/4lAP9bzuKmRi7fUkP73L3i7HpGSy+CVGEaCYel6ASiYsnLfQD9EYu2l7koF89B
Om0nx+aTg0QGJZ0+Xd/ZyL8KFizLDAQ=
=gent
-----END PGP SIGNATURE-----

--nextPart4549420.ejJDZkT8p0--




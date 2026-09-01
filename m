Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691C2C624D0
	for <batman-adv@archiver.kernel.org>; Tue,  1 Sep 2026 19:31:34 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id BD02E82267
	for <batman-adv@archiver.kernel.org>; Tue, 01 Sep 2026 21:31:32 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788291092;
 b=iWdV3msbeH/M9MTPuTJI5X2kbzK6XPcTJ8cB5cPijTFMRbTODSp7umnshKvgNXzFoCl8U
 BWXH49KfRQmCAf+xx2qlmsKc0zyG2FGOJAzXPfYGL5ok8dgoUZWpSUf+vZ9Eq+ACpg6EQak
 JL2y84J/3s1m7K2vnVbVW9Nm/LNQhj0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788291092; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=S8/3xnSGNAuxKXecyvenpH9ckOoYM2DkfQ9xiFLBGm4=;
 b=caStfxZsNBykfZqcUc6d7I/m6/w5MPkj/n3WfeaXE9YNx3XFiahfJdw0R3lDW4O/YDN7+
 sv+F1B7wtrZPNGVpsY4AhEd9FZtA/JV09lIzuLMwJpzZFdMK6tFpdIUWe3/xj4e4IG8cYgE
 vnekCU5UB+18iDKQWjONw0BMXK3KbQM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id F1B1E8119A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 01 Sep 2026 21:31:24 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788291085;
	b=LGaxt76OtSq14ni9h2Ur7CzNN+Za1NSiClhk3KunHVihgUbu/zG2NK0qR3VSOHpxZE+BY7
	298v0RpecBKA9+S9gzbws38a89fmElpvlyIbHdZxbc7vRzzMulbieMVMZzKG9sBDcb143p
	5PBcURFIBB2OnajvfouE9W0JSiJ62qY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788291085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=S8/3xnSGNAuxKXecyvenpH9ckOoYM2DkfQ9xiFLBGm4=;
	b=rSHcZZZqNG6AzweUzdeOXeM5Zjl7jH653X1EePZuO7fzv+Tjbhq1MNKNMJzKFOqljYKgLw
	fjChUV8nqiWjZf2T/xQauCo95Mmk/sSt02iVsIqyzYaK+z7ekVE407lY+UCWsSqjb308Y4
	1t8bDHZWigh53cnhy3pUdcV9F20vJ8c=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=In7PdX1Q;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 0CCE620396;
	Tue, 01 Sep 2026 19:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788291079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S8/3xnSGNAuxKXecyvenpH9ckOoYM2DkfQ9xiFLBGm4=;
	b=In7PdX1QgpCvP6splh6EY5cd+AoJtviWIFGOm7hpUnzJ2fF+Lp5r+TSCetbliyIIS+hWJi
	ydBmA7ETjYnjKIBgSqR30e9UGA440bKLnaUqseT6ZyNy7uam2aDwtlv5iehcV9Wd6RjL7F
	gGWVGRdrr0Xpey4yCxMMpEmqDszgoRk=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: [PATCH net-next 13/15] batman-adv: tt: transition NEW local
 entries only
 under lock
Date: Tue, 01 Sep 2026 21:31:16 +0200
Message-ID: <6209959.MhkbZ0Pkbq@sven-desktop>
In-Reply-To: <20260831135117.574836-14-sw@simonwunderlich.de>
References: <20260831135117.574836-1-sw@simonwunderlich.de>
 <20260831135117.574836-14-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1886846.VLH7GnMWUR";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: CASDFO556O2Q2OSICJPWJATEM4HEMDSE
X-Message-ID-Hash: CASDFO556O2Q2OSICJPWJATEM4HEMDSE
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CASDFO556O2Q2OSICJPWJATEM4HEMDSE/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart1886846.VLH7GnMWUR
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 01 Sep 2026 21:31:16 +0200
Message-ID: <6209959.MhkbZ0Pkbq@sven-desktop>
In-Reply-To: <20260831135117.574836-14-sw@simonwunderlich.de>
MIME-Version: 1.0

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831135117.574836-1=
=2Dsw%40simonwunderlich.de?part=3D13


[...]
> Should a Fixes: tag naming that commit be added?
>=20
> Note that this patch depends on the tt_common_entry->flags_lock
> infrastructure added earlier in the same series, so a direct stable
> backport would need adaptation and the tag would mostly serve
> identification.

I am not allowed to add Fixes: lines for patches targeting net-next. And th=
is=20
is not suitable for net or stable backports. See
https://lore.kernel.org/all/7d73cd74-b040-4a3d-9d78-4ad8fc0a01f4@redhat.com/


>=20
> > diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/transl=
ation-table.c
> > index 163f90962306..a870d9a97e32 100644
> > --- a/net/batman-adv/translation-table.c
> > +++ b/net/batman-adv/translation-table.c
> > @@ -333,6 +333,10 @@ static void batadv_tt_local_size_mod(struct batadv=
_priv *bat_priv,
> >   *  given vid
> >   * @bat_priv: the bat priv with all the mesh interface information
> >   * @vid: the VLAN identifier
> > + *
> > + * It must only be called when removing the NEW flag of a
> > + * batadv_tt_local_entry while it is still part of the bat_priv->tt.lo=
cal_hash.
> > + * It must therefore be checked under the specific list_locks[i].
> >   */
> >  static void batadv_tt_local_size_inc(struct batadv_priv *bat_priv,
> >  				     unsigned short vid)
>=20
> Discovered by: gpt-5-6-sol, opus-5 =C2=B7 Missed by: sashiko-gemini
> This is a pre-existing issue and not introduced by this patch, but does
> the new invariant ("It must therefore be checked under the specific
> list_locks[i]") hold on the removal side as well?
>=20
> batadv_tt_local_remove() decides that no batadv_tt_local_size_dec() is
> owed while holding only flags_lock, then drops it before unlinking:
[...]
> Can vlan->tt.num_entries stay inflated by one in that case, the same
> "nothing will reduce the counter again" failure mode, reached through
> the check side instead of the walk side?


Out-of-scope for this specific patch. See patch
"batman-adv: tt: decrement count for committed client on local_remove"

Regards,
	Sven
--nextPart1886846.VLH7GnMWUR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCapcoBAAKCRBND3cr0xT1
yytgAP0abRyhK1qE8phNcYEUwb3RLsZYEza5P0U3/7+qEBaGRwD/fY1NCC6BfXGa
DzZdIS4cke3tZBQCD2gQQsteKb2piwQ=
=UNY8
-----END PGP SIGNATURE-----

--nextPart1886846.VLH7GnMWUR--




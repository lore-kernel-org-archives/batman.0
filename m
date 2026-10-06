Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53869CA5FF0
	for <batman@archiver.kernel.org>; Tue,  6 Oct 2026 13:06:00 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 747C381900
	for <batman@archiver.kernel.org>; Tue, 06 Oct 2026 15:05:58 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791291958;
 b=ljA3jRdSALMIIh4JpFZ3AimSwXFCyQZ+4aR0X0cl8Sbv2KBje+LqsMvW4mkzoEJpCQU72
 cRDsl+BhfoALH9qXOjrQZpebLtV8az466relXnz5Y3dDZ4FFCDEHFStfB33W6DQ07eIcv4H
 VsOQOrPNJHY1Ya8Nq7RFCDqmYFkmnMk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791291958; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=leMROTpkwTJLP4gquGwlXc+Y9Mr/ZVFaEnXalX39paE=;
 b=KlG3LiJQyz8jwSIbhT819k2HDjTX/+hau7ZYC3tbA/heVz8QzaVWH5g/Acd84sImpX5aS
 520CPXg1KxzrKVlEmoFyANQxBr5X96wxr11idrG+wecCn1kVVz3eEnpX3CFxNPoEmSvyvT+
 eHe31Tv0ZIStDDxqgD8lt2ielZ8TeYY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id D76AB80B92
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 06 Oct 2026 15:05:29 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791291940;
	b=NhawQPozPLDFhL7QBw+SfCgPH+9RTX3aCWasWU1T+XnhQBxF6fDjYdd4/Y8RUr4qDz+0N2
	6l2AHfcm7YKa06ZjGxT/PS1mGJRxtXtCZ0GOX7+HLGnULZML7JzEUyS+ACuvxfPwSC+jNk
	WYandxJWYCdSY0K1Te1v/AmthkKsbQk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791291939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=leMROTpkwTJLP4gquGwlXc+Y9Mr/ZVFaEnXalX39paE=;
	b=NzNcyupDGJMFln+zNq1gf47QbKXxQ3GpYo7EK+TNYaHtPfFIdz/0i5BKyM6th7k9gHM+ar
	u0DJ6gNgQbECDk9lgHyAnlRQaVaW6xQ5uCW5/Ey61/1KkAdB16ChX9IyJac3janewlKGdI
	LLKp9fP7+vMGfYh7TVUCU/V7f+5fVrU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=pOG53iOD;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 8A05020411;
	Tue, 06 Oct 2026 13:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791291925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=leMROTpkwTJLP4gquGwlXc+Y9Mr/ZVFaEnXalX39paE=;
	b=pOG53iODMpPMRnZQIsNIS7WPci8nCkm1zav21wIRMWyBhsxOuqFNzrEPjeVhD6Z+vd5aeO
	fyXuL+K/wwdsGwxJr6Z32B0u0hof9ySoXHUPR1tbsGxtEU0ENc1OdqKzD+uJuJV5Zh2ctF
	rJh2M4zV9PdZebl5+9gTBeKAmb0Teqg=
From: Sven Eckelmann <sven@narfation.org>
To: Linus =?UTF-8?B?TMO8c3Npbmc=?= <linus.luessing@c0d3.blue>
Cc: sashiko-reviews@lists.linux.dev, b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [batadv,v13 5/5] batman-adv: avoid superfluous DAT DHT_PUT
 additions to
 local DAT
Date: Tue, 06 Oct 2026 15:05:22 +0200
Message-ID: <3435112.aeNJFYEL58@sven-l14>
In-Reply-To: <20261006121937.398DD1F000FF@smtp.kernel.org>
References: <20261006120647.8646-1-linus.luessing@c0d3.blue>
 <20261006120647.8646-6-linus.luessing@c0d3.blue>
 <20261006121937.398DD1F000FF@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3441699.44csPzL39Z";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: QTXYHBV6YKG7PNYHQTSTPLC57F2BXXGE
X-Message-ID-Hash: QTXYHBV6YKG7PNYHQTSTPLC57F2BXXGE
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/QTXYHBV6YKG7PNYHQTSTPLC57F2BXXGE/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart3441699.44csPzL39Z
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Linus =?UTF-8?B?TMO8c3Npbmc=?= <linus.luessing@c0d3.blue>
Cc: sashiko-reviews@lists.linux.dev, b.a.t.m.a.n@lists.open-mesh.org
Date: Tue, 06 Oct 2026 15:05:22 +0200
Message-ID: <3435112.aeNJFYEL58@sven-l14>
In-Reply-To: <20261006121937.398DD1F000FF@smtp.kernel.org>
MIME-Version: 1.0

On Tuesday, 6 October 2026 14:19:36 CEST sashiko-bot@kernel.org wrote:> > d=
iff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
> > index 5cf26e8b3257a..8dd4094d134bd 100644
> > --- a/net/batman-adv/routing.c
> > +++ b/net/batman-adv/routing.c
> > @@ -1094,7 +1096,8 @@ int batadv_recv_unicast_packet(struct sk_buff *sk=
b,
> >  			unicast_4addr_packet =3D
> >  				(struct batadv_unicast_4addr_packet *)skb->data;
> >  			subtype =3D unicast_4addr_packet->subtype;
> > -			batadv_dat_inc_counter(bat_priv, subtype);
> > +			flags =3D unicast_4addr_packet->flags;
> > +			batadv_dat_inc_counter(bat_priv, subtype, flags);
>=20
> [Severity: Low]
> This passes three arguments to batadv_dat_inc_counter(). However, looking
> at net/batman-adv/distributed-arp-table.h, the dummy fallback implementat=
ion=20
> of this function used when CONFIG_BATMAN_ADV_DAT is disabled seems to onl=
y=20
> accept two arguments:
>=20
> static inline void batadv_dat_inc_counter(struct batadv_priv *bat_priv,
> 					  u8 subtype)
> {
> }
>=20
> Will this cause a build failure when compiling the kernel with
> CONFIG_BATMAN_ADV_DAT=3Dn?

Confirmed (+ some extra):

Name of failed tests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

pu
=2D-

 * checkpatch include/uapi/linux/batadv_packet.h
 * kerneldoc
 * sparse v5.18 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn MCAST=3Dy BATMAN=
_V=3Dn
 * sparse v5.19 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dn MCAST=3Dy BATMAN=
_V=3Dn
 * sparse v6.0 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn MCAST=3Dy BATMAN_=
V=3Dn
 * sparse v6.0 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy MCAST=3Dy BATMAN_=
V=3Dn
 * sparse v6.1.188 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dy MCAST=3Dn BAT=
MAN_V=3Dn
 * sparse v6.10 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dy MCAST=3Dn BATMAN=
_V=3Dn
 * sparse v6.11 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dy MCAST=3Dy BATMAN=
_V=3Dy
 * sparse v6.11 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dn MCAST=3Dn BATMAN=
_V=3Dy
 * sparse v6.12 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dy MCAST=3Dn BATMAN=
_V=3Dy
 * sparse v6.12.110 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dy MCAST=3Dn BA=
TMAN_V=3Dy
 * sparse v6.12.110 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy MCAST=3Dn BA=
TMAN_V=3Dn
 * sparse v6.12.110 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy MCAST=3Dn BA=
TMAN_V=3Dy
 * sparse v6.17 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dn MCAST=3Dn BATMAN=
_V=3Dn
 * sparse v6.17 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy MCAST=3Dy BATMAN=
_V=3Dy
 * sparse v6.18 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn MCAST=3Dn BATMAN=
_V=3Dn
 * sparse v6.18.51 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dy MCAST=3Dy BAT=
MAN_V=3Dn
 * sparse v6.18.51 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dn MCAST=3Dy BAT=
MAN_V=3Dy
 * sparse v6.2 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dy MCAST=3Dy BATMAN_=
V=3Dn
 * sparse v6.3 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy MCAST=3Dn BATMAN_=
V=3Dy
 * sparse v6.4 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn MCAST=3Dn BATMAN_=
V=3Dy
 * sparse v6.4 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn MCAST=3Dy BATMAN_=
V=3Dn
 * sparse v6.6 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn MCAST=3Dy BATMAN_=
V=3Dy
 * sparse v6.6 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dn MCAST=3Dn BATMAN_=
V=3Dy
 * sparse v6.6.157 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dn MCAST=3Dy BAT=
MAN_V=3Dy
 * sparse v6.8 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn MCAST=3Dn BATMAN_=
V=3Dn
 * sparse v6.9 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dy MCAST=3Dy BATMAN_=
V=3Dn
 * sparse v7.0 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dn MCAST=3Dy BATMAN_=
V=3Dy
 * sparse v7.0 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy MCAST=3Dn BATMAN_=
V=3Dn
 * sparse v7.1 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn MCAST=3Dn BATMAN_=
V=3Dn
 * sparse v7.2 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn MCAST=3Dy BATMAN_=
V=3Dy
 * sparse v7.2 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dy MCAST=3Dy BATMAN_=
V=3Dn
 * sparse v7.2.5 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dn MCAST=3Dn BATMA=
N_V=3Dy
 * sparse v7.3-rc3 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dy MCAST=3Dy BAT=
MAN_V=3Dn
 * sparse v7.3-rc3 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn MCAST=3Dn BAT=
MAN_V=3Dy
 * sparse v7.3-rc3 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dn MCAST=3Dn BAT=
MAN_V=3Dy
 * unused_symbols v5.18 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn MCAST=3D=
y BATMAN_V=3Dn
 * unused_symbols v5.19 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dn MCAST=3D=
y BATMAN_V=3Dn
 * unused_symbols v6.0 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn MCAST=3Dy=
 BATMAN_V=3Dn
 * unused_symbols v6.0 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy MCAST=3Dy=
 BATMAN_V=3Dn
 * unused_symbols v6.1.188 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dy MCAST=
=3Dn BATMAN_V=3Dn
 * unused_symbols v6.10 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dy MCAST=3D=
n BATMAN_V=3Dn
 * unused_symbols v6.11 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dy MCAST=3D=
y BATMAN_V=3Dy
 * unused_symbols v6.11 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dn MCAST=3D=
n BATMAN_V=3Dy
 * unused_symbols v6.12 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dy MCAST=3D=
n BATMAN_V=3Dy
 * unused_symbols v6.12.110 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dy MCAS=
T=3Dn BATMAN_V=3Dy
 * unused_symbols v6.12.110 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy MCAS=
T=3Dn BATMAN_V=3Dn
 * unused_symbols v6.12.110 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy MCAS=
T=3Dn BATMAN_V=3Dy
 * unused_symbols v6.17 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dn MCAST=3D=
n BATMAN_V=3Dn
 * unused_symbols v6.17 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy MCAST=3D=
y BATMAN_V=3Dy
 * unused_symbols v6.18 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn MCAST=3D=
n BATMAN_V=3Dn
 * unused_symbols v6.18.51 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dy MCAST=
=3Dy BATMAN_V=3Dn
 * unused_symbols v6.18.51 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dn MCAST=
=3Dy BATMAN_V=3Dy
 * unused_symbols v6.2 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dy MCAST=3Dy=
 BATMAN_V=3Dn
 * unused_symbols v6.3 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy MCAST=3Dn=
 BATMAN_V=3Dy
 * unused_symbols v6.4 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn MCAST=3Dn=
 BATMAN_V=3Dy
 * unused_symbols v6.4 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn MCAST=3Dy=
 BATMAN_V=3Dn
 * unused_symbols v6.6 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn MCAST=3Dy=
 BATMAN_V=3Dy
 * unused_symbols v6.6 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dn MCAST=3Dn=
 BATMAN_V=3Dy
 * unused_symbols v6.6.157 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dn MCAST=
=3Dy BATMAN_V=3Dy
 * unused_symbols v6.8 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn MCAST=3Dn=
 BATMAN_V=3Dn
 * unused_symbols v6.9 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dy MCAST=3Dy=
 BATMAN_V=3Dn
 * unused_symbols v7.0 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dn MCAST=3Dy=
 BATMAN_V=3Dy
 * unused_symbols v7.0 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy MCAST=3Dn=
 BATMAN_V=3Dn
 * unused_symbols v7.1 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn MCAST=3Dn=
 BATMAN_V=3Dn
 * unused_symbols v7.2 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn MCAST=3Dy=
 BATMAN_V=3Dy
 * unused_symbols v7.2 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dy MCAST=3Dy=
 BATMAN_V=3Dn
 * unused_symbols v7.2.5 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dn MCAST=
=3Dn BATMAN_V=3Dy
 * unused_symbols v7.3-rc3 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dy MCAST=
=3Dy BATMAN_V=3Dn
 * unused_symbols v7.3-rc3 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn MCAST=
=3Dn BATMAN_V=3Dy
 * unused_symbols v7.3-rc3 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dn MCAST=
=3Dn BATMAN_V=3Dy


Output of different failed tests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

pu: checkpatch include/uapi/linux/batadv_packet.h
=2D------------------------------------------------

    CHECK: Please don't use multiple blank lines
    #85: FILE: include/uapi/linux/batadv_packet.h:85:
    +
    +
   =20
    total: 0 errors, 0 warnings, 1 checks, 688 lines checked

pu: kerneldoc
=2D------------

    Warning: ./net/batman-adv/distributed-arp-table.c:1032 Excess function =
parameter 'hw_dst' description in 'batadv_dat_dht_get_self_reply' (did you =
mean one of: 'ip_dst', 'hw_src')
    Warning: ./net/batman-adv/distributed-arp-table.c:1286 Excess function =
parameter 'hw_dst' description in 'batadv_dat_forward_dht_get' (did you mea=
n one of: 'ip_dst', 'hw_src')
    Warning: ./net/batman-adv/distributed-arp-table.c:1032 Excess function =
parameter 'hw_dst' description in 'batadv_dat_dht_get_self_reply' (did you =
mean one of: 'ip_dst', 'hw_src')
    Warning: ./net/batman-adv/distributed-arp-table.c:1286 Excess function =
parameter 'hw_dst' description in 'batadv_dat_forward_dht_get' (did you mea=
n one of: 'ip_dst', 'hw_src')
    4 errors

pu: sparse v5.18 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn MCAST=3Dy BATMA=
N_V=3Dn
=2D---------------------------------------------------------------------

    /home/build_test/build_env/tmp.FzAjE3FV2V/net/batman-adv/routing.c: In =
function =E2=80=98batadv_recv_unicast_packet=E2=80=99:
    /home/build_test/build_env/tmp.FzAjE3FV2V/net/batman-adv/routing.c:1100=
:25: error: too many arguments to function =E2=80=98batadv_dat_inc_counter=
=E2=80=99
     1100 |                         batadv_dat_inc_counter(bat_priv, subtyp=
e, flags);
          |                         ^~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.FzAjE3FV2V/net/bat=
man-adv/routing.c:30:
    /home/build_test/build_env/tmp.FzAjE3FV2V/net/batman-adv/distributed-ar=
p-table.h:197:20: note: declared here
      197 | static inline void batadv_dat_inc_counter(struct batadv_priv *b=
at_priv,
          |                    ^~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:288: /home/build_test/build_env/tm=
p.FzAjE3FV2V/net/batman-adv/routing.o] Error 1
    make[2]: *** [scripts/Makefile.build:550: /home/build_test/build_env/tm=
p.FzAjE3FV2V/net/batman-adv] Error 2
    make[1]: *** [Makefile:1834: /home/build_test/build_env/tmp.FzAjE3FV2V]=
 Error 2
    make: *** [Makefile:65: all] Error 2

pu: sparse v5.19 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dn MCAST=3Dy BATMA=
N_V=3Dn
=2D---------------------------------------------------------------------

    /home/build_test/build_env/tmp.FzAjE3FV2V/net/batman-adv/routing.c: In =
function =E2=80=98batadv_recv_unicast_packet=E2=80=99:
    /home/build_test/build_env/tmp.FzAjE3FV2V/net/batman-adv/routing.c:1100=
:25: error: too many arguments to function =E2=80=98batadv_dat_inc_counter=
=E2=80=99
     1100 |                         batadv_dat_inc_counter(bat_priv, subtyp=
e, flags);
          |                         ^~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.FzAjE3FV2V/net/bat=
man-adv/routing.c:30:
    /home/build_test/build_env/tmp.FzAjE3FV2V/net/batman-adv/distributed-ar=
p-table.h:197:20: note: declared here
      197 | static inline void batadv_dat_inc_counter(struct batadv_priv *b=
at_priv,
          |                    ^~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:249: /home/build_test/build_env/tm=
p.FzAjE3FV2V/net/batman-adv/routing.o] Error 1
    make[2]: *** [scripts/Makefile.build:466: /home/build_test/build_env/tm=
p.FzAjE3FV2V/net/batman-adv] Error 2
    make[1]: *** [Makefile:1843: /home/build_test/build_env/tmp.FzAjE3FV2V]=
 Error 2
    make: *** [Makefile:65: all] Error 2

pu: sparse v6.0 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy MCAST=3Dy BATMAN=
_V=3Dn
=2D--------------------------------------------------------------------

    /home/build_test/build_env/tmp.FzAjE3FV2V/net/batman-adv/routing.c: In =
function =E2=80=98batadv_recv_unicast_packet=E2=80=99:
    /home/build_test/build_env/tmp.FzAjE3FV2V/net/batman-adv/routing.c:1100=
:25: error: too many arguments to function =E2=80=98batadv_dat_inc_counter=
=E2=80=99
     1100 |                         batadv_dat_inc_counter(bat_priv, subtyp=
e, flags);
          |                         ^~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.FzAjE3FV2V/net/bat=
man-adv/routing.c:30:
    /home/build_test/build_env/tmp.FzAjE3FV2V/net/batman-adv/distributed-ar=
p-table.h:197:20: note: declared here
      197 | static inline void batadv_dat_inc_counter(struct batadv_priv *b=
at_priv,
          |                    ^~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:249: /home/build_test/build_env/tm=
p.FzAjE3FV2V/net/batman-adv/routing.o] Error 1
    make[2]: *** [scripts/Makefile.build:465: /home/build_test/build_env/tm=
p.FzAjE3FV2V/net/batman-adv] Error 2
    make[1]: *** [Makefile:1852: /home/build_test/build_env/tmp.FzAjE3FV2V]=
 Error 2
    make: *** [Makefile:65: all] Error 2

pu: sparse v6.1.188 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dy MCAST=3Dn BA=
TMAN_V=3Dn
=2D------------------------------------------------------------------------

    /home/build_test/build_env/tmp.FzAjE3FV2V/net/batman-adv/routing.c: In =
function =E2=80=98batadv_recv_unicast_packet=E2=80=99:
    /home/build_test/build_env/tmp.FzAjE3FV2V/net/batman-adv/routing.c:1100=
:25: error: too many arguments to function =E2=80=98batadv_dat_inc_counter=
=E2=80=99
     1100 |                         batadv_dat_inc_counter(bat_priv, subtyp=
e, flags);
          |                         ^~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.FzAjE3FV2V/net/bat=
man-adv/routing.c:30:
    /home/build_test/build_env/tmp.FzAjE3FV2V/net/batman-adv/distributed-ar=
p-table.h:197:20: note: declared here
      197 | static inline void batadv_dat_inc_counter(struct batadv_priv *b=
at_priv,
          |                    ^~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:250: /home/build_test/build_env/tm=
p.FzAjE3FV2V/net/batman-adv/routing.o] Error 1
    make[2]: *** [scripts/Makefile.build:503: /home/build_test/build_env/tm=
p.FzAjE3FV2V/net/batman-adv] Error 2
    make[1]: *** [Makefile:2025: /home/build_test/build_env/tmp.FzAjE3FV2V]=
 Error 2
    make: *** [Makefile:65: all] Error 2

pu: sparse v6.10 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dy MCAST=3Dn BATMA=
N_V=3Dn
=2D---------------------------------------------------------------------

    /home/build_test/build_env/tmp.FzAjE3FV2V/net/batman-adv/routing.c: In =
function =E2=80=98batadv_recv_unicast_packet=E2=80=99:
    /home/build_test/build_env/tmp.FzAjE3FV2V/net/batman-adv/routing.c:1100=
:25: error: too many arguments to function =E2=80=98batadv_dat_inc_counter=
=E2=80=99
     1100 |                         batadv_dat_inc_counter(bat_priv, subtyp=
e, flags);
          |                         ^~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.FzAjE3FV2V/net/bat=
man-adv/routing.c:30:
    /home/build_test/build_env/tmp.FzAjE3FV2V/net/batman-adv/distributed-ar=
p-table.h:197:20: note: declared here
      197 | static inline void batadv_dat_inc_counter(struct batadv_priv *b=
at_priv,
          |                    ^~~~~~~~~~~~~~~~~~~~~~
    make[4]: *** [scripts/Makefile.build:244: /home/build_test/build_env/tm=
p.FzAjE3FV2V/net/batman-adv/routing.o] Error 1
    make[3]: *** [scripts/Makefile.build:485: /home/build_test/build_env/tm=
p.FzAjE3FV2V/net/batman-adv] Error 2
    make[2]: *** [/home/build_test/build_env/linux-build/linux/v6.10/Makefi=
le:1934: /home/build_test/build_env/tmp.FzAjE3FV2V] Error 2
    make[1]: *** [Makefile:240: __sub-make] Error 2
    make: *** [Makefile:65: all] Error 2

pu: sparse v6.11 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dy MCAST=3Dy BATMA=
N_V=3Dy
=2D---------------------------------------------------------------------

    /home/build_test/build_env/tmp.FzAjE3FV2V/net/batman-adv/routing.c: In =
function =E2=80=98batadv_recv_unicast_packet=E2=80=99:
    /home/build_test/build_env/tmp.FzAjE3FV2V/net/batman-adv/routing.c:1100=
:25: error: too many arguments to function =E2=80=98batadv_dat_inc_counter=
=E2=80=99
     1100 |                         batadv_dat_inc_counter(bat_priv, subtyp=
e, flags);
          |                         ^~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.FzAjE3FV2V/net/bat=
man-adv/routing.c:30:
    /home/build_test/build_env/tmp.FzAjE3FV2V/net/batman-adv/distributed-ar=
p-table.h:197:20: note: declared here
      197 | static inline void batadv_dat_inc_counter(struct batadv_priv *b=
at_priv,
          |                    ^~~~~~~~~~~~~~~~~~~~~~
    make[4]: *** [scripts/Makefile.build:244: /home/build_test/build_env/tm=
p.FzAjE3FV2V/net/batman-adv/routing.o] Error 1
    make[3]: *** [scripts/Makefile.build:485: /home/build_test/build_env/tm=
p.FzAjE3FV2V/net/batman-adv] Error 2
    make[2]: *** [/home/build_test/build_env/linux-build/linux/v6.11/Makefi=
le:1926: /home/build_test/build_env/tmp.FzAjE3FV2V] Error 2
    make[1]: *** [Makefile:224: __sub-make] Error 2
    make: *** [Makefile:65: all] Error 2

pu: sparse v6.12 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dy MCAST=3Dn BATMA=
N_V=3Dy
=2D---------------------------------------------------------------------

    /home/build_test/build_env/tmp.FzAjE3FV2V/net/batman-adv/routing.c: In =
function =E2=80=98batadv_recv_unicast_packet=E2=80=99:
    /home/build_test/build_env/tmp.FzAjE3FV2V/net/batman-adv/routing.c:1100=
:25: error: too many arguments to function =E2=80=98batadv_dat_inc_counter=
=E2=80=99
     1100 |                         batadv_dat_inc_counter(bat_priv, subtyp=
e, flags);
          |                         ^~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.FzAjE3FV2V/net/bat=
man-adv/routing.c:30:
    /home/build_test/build_env/tmp.FzAjE3FV2V/net/batman-adv/distributed-ar=
p-table.h:197:20: note: declared here
      197 | static inline void batadv_dat_inc_counter(struct batadv_priv *b=
at_priv,
          |                    ^~~~~~~~~~~~~~~~~~~~~~
    make[4]: *** [scripts/Makefile.build:229: /home/build_test/build_env/tm=
p.FzAjE3FV2V/net/batman-adv/routing.o] Error 1
    make[3]: *** [scripts/Makefile.build:478: /home/build_test/build_env/tm=
p.FzAjE3FV2V/net/batman-adv] Error 2
    make[2]: *** [/home/build_test/build_env/linux-build/linux/v6.12/Makefi=
le:1936: /home/build_test/build_env/tmp.FzAjE3FV2V] Error 2
    make[1]: *** [Makefile:224: __sub-make] Error 2
    make: *** [Makefile:65: all] Error 2

pu: sparse v6.12.110 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy MCAST=3Dn B=
ATMAN_V=3Dy
=2D-------------------------------------------------------------------------

    /home/build_test/build_env/tmp.FzAjE3FV2V/net/batman-adv/routing.c: In =
function =E2=80=98batadv_recv_unicast_packet=E2=80=99:
    /home/build_test/build_env/tmp.FzAjE3FV2V/net/batman-adv/routing.c:1100=
:25: error: too many arguments to function =E2=80=98batadv_dat_inc_counter=
=E2=80=99
     1100 |                         batadv_dat_inc_counter(bat_priv, subtyp=
e, flags);
          |                         ^~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.FzAjE3FV2V/net/bat=
man-adv/routing.c:30:
    /home/build_test/build_env/tmp.FzAjE3FV2V/net/batman-adv/distributed-ar=
p-table.h:197:20: note: declared here
      197 | static inline void batadv_dat_inc_counter(struct batadv_priv *b=
at_priv,
          |                    ^~~~~~~~~~~~~~~~~~~~~~
    make[4]: *** [scripts/Makefile.build:229: /home/build_test/build_env/tm=
p.FzAjE3FV2V/net/batman-adv/routing.o] Error 1
    make[3]: *** [scripts/Makefile.build:466: /home/build_test/build_env/tm=
p.FzAjE3FV2V/net/batman-adv] Error 2
    make[2]: *** [/home/build_test/build_env/linux-build/linux/v6.12.110/Ma=
kefile:1967: /home/build_test/build_env/tmp.FzAjE3FV2V] Error 2
    make[1]: *** [Makefile:224: __sub-make] Error 2
    make: *** [Makefile:65: all] Error 2

pu: sparse v6.17 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy MCAST=3Dy BATMA=
N_V=3Dy
=2D---------------------------------------------------------------------

    net/batman-adv/routing.c: In function =E2=80=98batadv_recv_unicast_pack=
et=E2=80=99:
    net/batman-adv/routing.c:1100:25: error: too many arguments to function=
 =E2=80=98batadv_dat_inc_counter=E2=80=99
     1100 |                         batadv_dat_inc_counter(bat_priv, subtyp=
e, flags);
          |                         ^~~~~~~~~~~~~~~~~~~~~~
    In file included from net/batman-adv/routing.c:30:
    net/batman-adv/distributed-arp-table.h:197:20: note: declared here
      197 | static inline void batadv_dat_inc_counter(struct batadv_priv *b=
at_priv,
          |                    ^~~~~~~~~~~~~~~~~~~~~~
    make[5]: *** [/home/build_test/build_env/linux-build/linux/v6.17/script=
s/Makefile.build:287: net/batman-adv/routing.o] Error 1
    make[4]: *** [/home/build_test/build_env/linux-build/linux/v6.17/script=
s/Makefile.build:556: net/batman-adv] Error 2
    make[3]: *** [/home/build_test/build_env/linux-build/linux/v6.17/Makefi=
le:2011: .] Error 2
    make[2]: *** [/home/build_test/build_env/linux-build/linux/v6.17/Makefi=
le:248: __sub-make] Error 2
    make[1]: *** [Makefile:248: __sub-make] Error 2
    make: *** [Makefile:65: all] Error 2

pu: sparse v6.18 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn MCAST=3Dn BATMA=
N_V=3Dn
=2D---------------------------------------------------------------------

    net/batman-adv/routing.c: In function =E2=80=98batadv_recv_unicast_pack=
et=E2=80=99:
    net/batman-adv/routing.c:1100:25: error: too many arguments to function=
 =E2=80=98batadv_dat_inc_counter=E2=80=99
     1100 |                         batadv_dat_inc_counter(bat_priv, subtyp=
e, flags);
          |                         ^~~~~~~~~~~~~~~~~~~~~~
    In file included from net/batman-adv/routing.c:30:
    net/batman-adv/distributed-arp-table.h:197:20: note: declared here
      197 | static inline void batadv_dat_inc_counter(struct batadv_priv *b=
at_priv,
          |                    ^~~~~~~~~~~~~~~~~~~~~~
    make[5]: *** [/home/build_test/build_env/linux-build/linux/v6.18/script=
s/Makefile.build:287: net/batman-adv/routing.o] Error 1
    make[4]: *** [/home/build_test/build_env/linux-build/linux/v6.18/script=
s/Makefile.build:556: net/batman-adv] Error 2
    make[3]: *** [/home/build_test/build_env/linux-build/linux/v6.18/Makefi=
le:2010: .] Error 2
    make[2]: *** [/home/build_test/build_env/linux-build/linux/v6.18/Makefi=
le:248: __sub-make] Error 2
    make[1]: *** [Makefile:248: __sub-make] Error 2
    make: *** [Makefile:65: all] Error 2

pu: sparse v6.18.51 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dy MCAST=3Dy BA=
TMAN_V=3Dn
=2D------------------------------------------------------------------------

    net/batman-adv/routing.c: In function =E2=80=98batadv_recv_unicast_pack=
et=E2=80=99:
    net/batman-adv/routing.c:1100:25: error: too many arguments to function=
 =E2=80=98batadv_dat_inc_counter=E2=80=99
     1100 |                         batadv_dat_inc_counter(bat_priv, subtyp=
e, flags);
          |                         ^~~~~~~~~~~~~~~~~~~~~~
    In file included from net/batman-adv/routing.c:30:
    net/batman-adv/distributed-arp-table.h:197:20: note: declared here
      197 | static inline void batadv_dat_inc_counter(struct batadv_priv *b=
at_priv,
          |                    ^~~~~~~~~~~~~~~~~~~~~~
    make[5]: *** [/home/build_test/build_env/linux-build/linux/v6.18.51/scr=
ipts/Makefile.build:287: net/batman-adv/routing.o] Error 1
    make[4]: *** [/home/build_test/build_env/linux-build/linux/v6.18.51/scr=
ipts/Makefile.build:544: net/batman-adv] Error 2
    make[3]: *** [/home/build_test/build_env/linux-build/linux/v6.18.51/Mak=
efile:2050: .] Error 2
    make[2]: *** [/home/build_test/build_env/linux-build/linux/v6.18.51/Mak=
efile:248: __sub-make] Error 2
    make[1]: *** [Makefile:248: __sub-make] Error 2
    make: *** [Makefile:65: all] Error 2

pu: sparse v6.2 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dy MCAST=3Dy BATMAN=
_V=3Dn
=2D--------------------------------------------------------------------

    /home/build_test/build_env/tmp.FzAjE3FV2V/net/batman-adv/routing.c: In =
function =E2=80=98batadv_recv_unicast_packet=E2=80=99:
    /home/build_test/build_env/tmp.FzAjE3FV2V/net/batman-adv/routing.c:1100=
:25: error: too many arguments to function =E2=80=98batadv_dat_inc_counter=
=E2=80=99
     1100 |                         batadv_dat_inc_counter(bat_priv, subtyp=
e, flags);
          |                         ^~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.FzAjE3FV2V/net/bat=
man-adv/routing.c:30:
    /home/build_test/build_env/tmp.FzAjE3FV2V/net/batman-adv/distributed-ar=
p-table.h:197:20: note: declared here
      197 | static inline void batadv_dat_inc_counter(struct batadv_priv *b=
at_priv,
          |                    ^~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:252: /home/build_test/build_env/tm=
p.FzAjE3FV2V/net/batman-adv/routing.o] Error 1
    make[2]: *** [scripts/Makefile.build:504: /home/build_test/build_env/tm=
p.FzAjE3FV2V/net/batman-adv] Error 2
    make[1]: *** [Makefile:2021: /home/build_test/build_env/tmp.FzAjE3FV2V]=
 Error 2
    make: *** [Makefile:65: all] Error 2

pu: sparse v6.3 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy MCAST=3Dn BATMAN=
_V=3Dy
=2D--------------------------------------------------------------------

    /home/build_test/build_env/tmp.FzAjE3FV2V/net/batman-adv/routing.c: In =
function =E2=80=98batadv_recv_unicast_packet=E2=80=99:
    /home/build_test/build_env/tmp.FzAjE3FV2V/net/batman-adv/routing.c:1100=
:25: error: too many arguments to function =E2=80=98batadv_dat_inc_counter=
=E2=80=99
     1100 |                         batadv_dat_inc_counter(bat_priv, subtyp=
e, flags);
          |                         ^~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.FzAjE3FV2V/net/bat=
man-adv/routing.c:30:
    /home/build_test/build_env/tmp.FzAjE3FV2V/net/batman-adv/distributed-ar=
p-table.h:197:20: note: declared here
      197 | static inline void batadv_dat_inc_counter(struct batadv_priv *b=
at_priv,
          |                    ^~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:252: /home/build_test/build_env/tm=
p.FzAjE3FV2V/net/batman-adv/routing.o] Error 1
    make[2]: *** [scripts/Makefile.build:494: /home/build_test/build_env/tm=
p.FzAjE3FV2V/net/batman-adv] Error 2
    make[1]: *** [Makefile:2025: /home/build_test/build_env/tmp.FzAjE3FV2V]=
 Error 2
    make: *** [Makefile:65: all] Error 2

pu: sparse v6.4 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn MCAST=3Dn BATMAN=
_V=3Dy
=2D--------------------------------------------------------------------

    /home/build_test/build_env/tmp.FzAjE3FV2V/net/batman-adv/routing.c: In =
function =E2=80=98batadv_recv_unicast_packet=E2=80=99:
    /home/build_test/build_env/tmp.FzAjE3FV2V/net/batman-adv/routing.c:1100=
:25: error: too many arguments to function =E2=80=98batadv_dat_inc_counter=
=E2=80=99
     1100 |                         batadv_dat_inc_counter(bat_priv, subtyp=
e, flags);
          |                         ^~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.FzAjE3FV2V/net/bat=
man-adv/routing.c:30:
    /home/build_test/build_env/tmp.FzAjE3FV2V/net/batman-adv/distributed-ar=
p-table.h:197:20: note: declared here
      197 | static inline void batadv_dat_inc_counter(struct batadv_priv *b=
at_priv,
          |                    ^~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:252: /home/build_test/build_env/tm=
p.FzAjE3FV2V/net/batman-adv/routing.o] Error 1
    make[2]: *** [scripts/Makefile.build:494: /home/build_test/build_env/tm=
p.FzAjE3FV2V/net/batman-adv] Error 2
    make[1]: *** [Makefile:2026: /home/build_test/build_env/tmp.FzAjE3FV2V]=
 Error 2
    make: *** [Makefile:65: all] Error 2

pu: sparse v6.6 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn MCAST=3Dy BATMAN=
_V=3Dy
=2D--------------------------------------------------------------------

    /home/build_test/build_env/tmp.FzAjE3FV2V/net/batman-adv/routing.c: In =
function =E2=80=98batadv_recv_unicast_packet=E2=80=99:
    /home/build_test/build_env/tmp.FzAjE3FV2V/net/batman-adv/routing.c:1100=
:25: error: too many arguments to function =E2=80=98batadv_dat_inc_counter=
=E2=80=99
     1100 |                         batadv_dat_inc_counter(bat_priv, subtyp=
e, flags);
          |                         ^~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.FzAjE3FV2V/net/bat=
man-adv/routing.c:30:
    /home/build_test/build_env/tmp.FzAjE3FV2V/net/batman-adv/distributed-ar=
p-table.h:197:20: note: declared here
      197 | static inline void batadv_dat_inc_counter(struct batadv_priv *b=
at_priv,
          |                    ^~~~~~~~~~~~~~~~~~~~~~
    make[4]: *** [scripts/Makefile.build:243: /home/build_test/build_env/tm=
p.FzAjE3FV2V/net/batman-adv/routing.o] Error 1
    make[3]: *** [scripts/Makefile.build:480: /home/build_test/build_env/tm=
p.FzAjE3FV2V/net/batman-adv] Error 2
    make[2]: *** [/home/build_test/build_env/linux-build/linux/v6.6/Makefil=
e:1913: /home/build_test/build_env/tmp.FzAjE3FV2V] Error 2
    make[1]: *** [Makefile:234: __sub-make] Error 2
    make: *** [Makefile:65: all] Error 2

pu: sparse v6.6.157 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dn MCAST=3Dy BA=
TMAN_V=3Dy
=2D------------------------------------------------------------------------

    /home/build_test/build_env/tmp.FzAjE3FV2V/net/batman-adv/routing.c: In =
function =E2=80=98batadv_recv_unicast_packet=E2=80=99:
    /home/build_test/build_env/tmp.FzAjE3FV2V/net/batman-adv/routing.c:1100=
:25: error: too many arguments to function =E2=80=98batadv_dat_inc_counter=
=E2=80=99
     1100 |                         batadv_dat_inc_counter(bat_priv, subtyp=
e, flags);
          |                         ^~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.FzAjE3FV2V/net/bat=
man-adv/routing.c:30:
    /home/build_test/build_env/tmp.FzAjE3FV2V/net/batman-adv/distributed-ar=
p-table.h:197:20: note: declared here
      197 | static inline void batadv_dat_inc_counter(struct batadv_priv *b=
at_priv,
          |                    ^~~~~~~~~~~~~~~~~~~~~~
    make[4]: *** [scripts/Makefile.build:243: /home/build_test/build_env/tm=
p.FzAjE3FV2V/net/batman-adv/routing.o] Error 1
    make[3]: *** [scripts/Makefile.build:480: /home/build_test/build_env/tm=
p.FzAjE3FV2V/net/batman-adv] Error 2
    make[2]: *** [/home/build_test/build_env/linux-build/linux/v6.6.157/Mak=
efile:1933: /home/build_test/build_env/tmp.FzAjE3FV2V] Error 2
    make[1]: *** [Makefile:234: __sub-make] Error 2
    make: *** [Makefile:65: all] Error 2

pu: sparse v6.8 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn MCAST=3Dn BATMAN=
_V=3Dn
=2D--------------------------------------------------------------------

    /home/build_test/build_env/tmp.FzAjE3FV2V/net/batman-adv/routing.c: In =
function =E2=80=98batadv_recv_unicast_packet=E2=80=99:
    /home/build_test/build_env/tmp.FzAjE3FV2V/net/batman-adv/routing.c:1100=
:25: error: too many arguments to function =E2=80=98batadv_dat_inc_counter=
=E2=80=99
     1100 |                         batadv_dat_inc_counter(bat_priv, subtyp=
e, flags);
          |                         ^~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.FzAjE3FV2V/net/bat=
man-adv/routing.c:30:
    /home/build_test/build_env/tmp.FzAjE3FV2V/net/batman-adv/distributed-ar=
p-table.h:197:20: note: declared here
      197 | static inline void batadv_dat_inc_counter(struct batadv_priv *b=
at_priv,
          |                    ^~~~~~~~~~~~~~~~~~~~~~
    make[4]: *** [scripts/Makefile.build:243: /home/build_test/build_env/tm=
p.FzAjE3FV2V/net/batman-adv/routing.o] Error 1
    make[3]: *** [scripts/Makefile.build:481: /home/build_test/build_env/tm=
p.FzAjE3FV2V/net/batman-adv] Error 2
    make[2]: *** [/home/build_test/build_env/linux-build/linux/v6.8/Makefil=
e:1921: /home/build_test/build_env/tmp.FzAjE3FV2V] Error 2
    make[1]: *** [Makefile:240: __sub-make] Error 2
    make: *** [Makefile:65: all] Error 2

pu: sparse v6.9 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dy MCAST=3Dy BATMAN=
_V=3Dn
=2D--------------------------------------------------------------------

    /home/build_test/build_env/tmp.FzAjE3FV2V/net/batman-adv/routing.c: In =
function =E2=80=98batadv_recv_unicast_packet=E2=80=99:
    /home/build_test/build_env/tmp.FzAjE3FV2V/net/batman-adv/routing.c:1100=
:25: error: too many arguments to function =E2=80=98batadv_dat_inc_counter=
=E2=80=99
     1100 |                         batadv_dat_inc_counter(bat_priv, subtyp=
e, flags);
          |                         ^~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.FzAjE3FV2V/net/bat=
man-adv/routing.c:30:
    /home/build_test/build_env/tmp.FzAjE3FV2V/net/batman-adv/distributed-ar=
p-table.h:197:20: note: declared here
      197 | static inline void batadv_dat_inc_counter(struct batadv_priv *b=
at_priv,
          |                    ^~~~~~~~~~~~~~~~~~~~~~
    make[4]: *** [scripts/Makefile.build:244: /home/build_test/build_env/tm=
p.FzAjE3FV2V/net/batman-adv/routing.o] Error 1
    make[3]: *** [scripts/Makefile.build:485: /home/build_test/build_env/tm=
p.FzAjE3FV2V/net/batman-adv] Error 2
    make[2]: *** [/home/build_test/build_env/linux-build/linux/v6.9/Makefil=
e:1919: /home/build_test/build_env/tmp.FzAjE3FV2V] Error 2
    make[1]: *** [Makefile:240: __sub-make] Error 2
    make: *** [Makefile:65: all] Error 2

pu: sparse v7.0 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy MCAST=3Dn BATMAN=
_V=3Dn
=2D--------------------------------------------------------------------

    net/batman-adv/routing.c: In function =E2=80=98batadv_recv_unicast_pack=
et=E2=80=99:
    net/batman-adv/routing.c:1100:25: error: too many arguments to function=
 =E2=80=98batadv_dat_inc_counter=E2=80=99
     1100 |                         batadv_dat_inc_counter(bat_priv, subtyp=
e, flags);
          |                         ^~~~~~~~~~~~~~~~~~~~~~
    In file included from net/batman-adv/routing.c:30:
    net/batman-adv/distributed-arp-table.h:197:20: note: declared here
      197 | static inline void batadv_dat_inc_counter(struct batadv_priv *b=
at_priv,
          |                    ^~~~~~~~~~~~~~~~~~~~~~
    make[5]: *** [/home/build_test/build_env/linux-build/linux/v7.0/scripts=
/Makefile.build:289: net/batman-adv/routing.o] Error 1
    make[4]: *** [/home/build_test/build_env/linux-build/linux/v7.0/scripts=
/Makefile.build:548: net/batman-adv] Error 2
    make[3]: *** [/home/build_test/build_env/linux-build/linux/v7.0/Makefil=
e:2105: .] Error 2
    make[2]: *** [/home/build_test/build_env/linux-build/linux/v7.0/Makefil=
e:248: __sub-make] Error 2
    make[1]: *** [Makefile:248: __sub-make] Error 2
    make: *** [Makefile:65: all] Error 2

pu: sparse v7.1 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn MCAST=3Dn BATMAN=
_V=3Dn
=2D--------------------------------------------------------------------

    net/batman-adv/routing.c: In function =E2=80=98batadv_recv_unicast_pack=
et=E2=80=99:
    net/batman-adv/routing.c:1100:25: error: too many arguments to function=
 =E2=80=98batadv_dat_inc_counter=E2=80=99
     1100 |                         batadv_dat_inc_counter(bat_priv, subtyp=
e, flags);
          |                         ^~~~~~~~~~~~~~~~~~~~~~
    In file included from net/batman-adv/routing.c:30:
    net/batman-adv/distributed-arp-table.h:197:20: note: declared here
      197 | static inline void batadv_dat_inc_counter(struct batadv_priv *b=
at_priv,
          |                    ^~~~~~~~~~~~~~~~~~~~~~
    make[5]: *** [/home/build_test/build_env/linux-build/linux/v7.1/scripts=
/Makefile.build:289: net/batman-adv/routing.o] Error 1
    make[4]: *** [/home/build_test/build_env/linux-build/linux/v7.1/scripts=
/Makefile.build:548: net/batman-adv] Error 2
    make[3]: *** [/home/build_test/build_env/linux-build/linux/v7.1/Makefil=
e:2144: .] Error 2
    make[2]: *** [/home/build_test/build_env/linux-build/linux/v7.1/Makefil=
e:248: __sub-make] Error 2
    make[1]: *** [Makefile:248: __sub-make] Error 2
    make: *** [Makefile:65: all] Error 2

pu: sparse v7.2 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn MCAST=3Dy BATMAN=
_V=3Dy
=2D--------------------------------------------------------------------

    net/batman-adv/routing.c: In function =E2=80=98batadv_recv_unicast_pack=
et=E2=80=99:
    net/batman-adv/routing.c:1100:25: error: too many arguments to function=
 =E2=80=98batadv_dat_inc_counter=E2=80=99
     1100 |                         batadv_dat_inc_counter(bat_priv, subtyp=
e, flags);
          |                         ^~~~~~~~~~~~~~~~~~~~~~
    In file included from net/batman-adv/routing.c:30:
    net/batman-adv/distributed-arp-table.h:197:20: note: declared here
      197 | static inline void batadv_dat_inc_counter(struct batadv_priv *b=
at_priv,
          |                    ^~~~~~~~~~~~~~~~~~~~~~
    make[5]: *** [/home/build_test/build_env/linux-build/linux/v7.2/scripts=
/Makefile.build:289: net/batman-adv/routing.o] Error 1
    make[4]: *** [/home/build_test/build_env/linux-build/linux/v7.2/scripts=
/Makefile.build:549: net/batman-adv] Error 2
    make[3]: *** [/home/build_test/build_env/linux-build/linux/v7.2/Makefil=
e:2187: .] Error 2
    make[2]: *** [/home/build_test/build_env/linux-build/linux/v7.2/Makefil=
e:248: __sub-make] Error 2
    make[1]: *** [Makefile:248: __sub-make] Error 2
    make: *** [Makefile:65: all] Error 2

pu: sparse v7.2.5 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dn MCAST=3Dn BATM=
AN_V=3Dy
=2D----------------------------------------------------------------------

    net/batman-adv/routing.c: In function =E2=80=98batadv_recv_unicast_pack=
et=E2=80=99:
    net/batman-adv/routing.c:1100:25: error: too many arguments to function=
 =E2=80=98batadv_dat_inc_counter=E2=80=99
     1100 |                         batadv_dat_inc_counter(bat_priv, subtyp=
e, flags);
          |                         ^~~~~~~~~~~~~~~~~~~~~~
    In file included from net/batman-adv/routing.c:30:
    net/batman-adv/distributed-arp-table.h:197:20: note: declared here
      197 | static inline void batadv_dat_inc_counter(struct batadv_priv *b=
at_priv,
          |                    ^~~~~~~~~~~~~~~~~~~~~~
    make[5]: *** [/home/build_test/build_env/linux-build/linux/v7.2.5/scrip=
ts/Makefile.build:289: net/batman-adv/routing.o] Error 1
    make[4]: *** [/home/build_test/build_env/linux-build/linux/v7.2.5/scrip=
ts/Makefile.build:550: net/batman-adv] Error 2
    make[3]: *** [/home/build_test/build_env/linux-build/linux/v7.2.5/Makef=
ile:2198: .] Error 2
    make[2]: *** [/home/build_test/build_env/linux-build/linux/v7.2.5/Makef=
ile:248: __sub-make] Error 2
    make[1]: *** [Makefile:248: __sub-make] Error 2
    make: *** [Makefile:65: all] Error 2

pu: sparse v7.3-rc3 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dy MCAST=3Dy BA=
TMAN_V=3Dn
=2D------------------------------------------------------------------------

    net/batman-adv/routing.c: In function =E2=80=98batadv_recv_unicast_pack=
et=E2=80=99:
    net/batman-adv/routing.c:1100:25: error: too many arguments to function=
 =E2=80=98batadv_dat_inc_counter=E2=80=99
     1100 |                         batadv_dat_inc_counter(bat_priv, subtyp=
e, flags);
          |                         ^~~~~~~~~~~~~~~~~~~~~~
    In file included from net/batman-adv/routing.c:30:
    net/batman-adv/distributed-arp-table.h:197:20: note: declared here
      197 | static inline void batadv_dat_inc_counter(struct batadv_priv *b=
at_priv,
          |                    ^~~~~~~~~~~~~~~~~~~~~~
    make[5]: *** [/home/build_test/build_env/linux-build/linux/v7.3-rc3/scr=
ipts/Makefile.build:290: net/batman-adv/routing.o] Error 1
    make[4]: *** [/home/build_test/build_env/linux-build/linux/v7.3-rc3/scr=
ipts/Makefile.build:551: net/batman-adv] Error 2
    make[3]: *** [/home/build_test/build_env/linux-build/linux/v7.3-rc3/Mak=
efile:2229: .] Error 2
    make[2]: *** [/home/build_test/build_env/linux-build/linux/v7.3-rc3/Mak=
efile:248: __sub-make] Error 2
    make[1]: *** [Makefile:248: __sub-make] Error 2
    make: *** [Makefile:65: all] Error 2

pu: unused_symbols v6.0 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy MCAST=3D=
y BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    batadv_bla_check_bcast_duplist
    batadv_bla_is_backbone_gw
    batadv_frag_send_packet
    batadv_frag_skb_buffer
    batadv_frag_skb_fwd
    batadv_gw_get_selected_orig
    batadv_hardif_no_broadcast
    batadv_interface_rx
    batadv_netdev_get_wifi_flags
    batadv_netlink_tpmeter_notify
    batadv_orig_node_vlan_get
    batadv_orig_node_vlan_new
    batadv_orig_node_vlan_release
    batadv_skb_head_push

pu: unused_symbols v6.10 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dy MCAST=
=3Dn BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    batadv_frag_send_packet
    batadv_frag_skb_buffer
    batadv_frag_skb_fwd
    batadv_gw_get_selected_orig
    batadv_hardif_no_broadcast
    batadv_interface_rx
    batadv_is_my_mac
    batadv_netdev_get_wifi_flags
    batadv_netlink_tpmeter_notify
    batadv_orig_node_vlan_get
    batadv_orig_node_vlan_new
    batadv_orig_node_vlan_release
    batadv_skb_head_push

pu: unused_symbols v6.11 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dy MCAST=
=3Dy BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    batadv_frag_send_packet
    batadv_frag_skb_buffer
    batadv_frag_skb_fwd
    batadv_gw_get_selected_orig
    batadv_interface_rx
    batadv_netdev_get_wifi_flags
    batadv_netlink_tpmeter_notify
    batadv_orig_node_vlan_get
    batadv_orig_node_vlan_new
    batadv_orig_node_vlan_release
    batadv_skb_head_push

pu: unused_symbols v6.17 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy MCAST=
=3Dy BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    batadv_bla_check_bcast_duplist
    batadv_bla_is_backbone_gw
    batadv_frag_send_packet
    batadv_frag_skb_buffer
    batadv_frag_skb_fwd
    batadv_gw_get_selected_orig
    batadv_interface_rx
    batadv_netdev_get_wifi_flags
    batadv_netlink_tpmeter_notify
    batadv_orig_node_vlan_get
    batadv_orig_node_vlan_new
    batadv_orig_node_vlan_release
    batadv_skb_head_push

pu: unused_symbols v6.8 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn MCAST=3D=
n BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    batadv_bla_check_bcast_duplist
    batadv_bla_is_backbone_gw
    batadv_bla_is_backbone_gw_orig
    batadv_frag_send_packet
    batadv_frag_skb_buffer
    batadv_frag_skb_fwd
    batadv_gw_get_selected_orig
    batadv_hardif_no_broadcast
    batadv_interface_rx
    batadv_is_my_mac
    batadv_netdev_get_wifi_flags
    batadv_netlink_tpmeter_notify
    batadv_orig_node_vlan_get
    batadv_orig_node_vlan_new
    batadv_orig_node_vlan_release
    batadv_skb_head_push

pu: unused_symbols v7.2.5 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dn MCAST=
=3Dn BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    batadv_bla_check_bcast_duplist
    batadv_bla_is_backbone_gw
    batadv_bla_is_backbone_gw_orig
    batadv_frag_send_packet
    batadv_frag_skb_buffer
    batadv_frag_skb_fwd
    batadv_gw_get_selected_orig
    batadv_interface_rx
    batadv_netdev_get_wifi_flags
    batadv_netlink_tpmeter_notify
    batadv_orig_node_vlan_get
    batadv_orig_node_vlan_new
    batadv_orig_node_vlan_release
    batadv_skb_head_push

pu: unused_symbols v7.3-rc3 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dy MCAS=
T=3Dy BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    batadv_frag_send_packet
    batadv_frag_skb_buffer
    batadv_frag_skb_fwd
    batadv_gw_get_selected_orig
    batadv_hardif_no_broadcast
    batadv_interface_rx
    batadv_netdev_get_wifi_flags
    batadv_netlink_tpmeter_notify
    batadv_orig_node_vlan_get
    batadv_orig_node_vlan_new
    batadv_orig_node_vlan_release
    batadv_skb_head_push

--nextPart3441699.44csPzL39Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCasTyEgAKCRBND3cr0xT1
y1GcAP9hBU7w6GeFcgUCtLKhk+fFvaBxrauWYZFINQs7qWDF+gD/eGtnKFTwfiTF
4o6iS6Nx6yDjpPX7EUUCpLtJY+8BKQ8=
=zO+Q
-----END PGP SIGNATURE-----

--nextPart3441699.44csPzL39Z--



